<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\{ PasswordReset, User };
use App\Library\{ SmsLibrary, EmailSender };

use Validator;

class PasswordResetController extends Controller
{
    public function sendOtp(Request $request)
    {
        $model = User::where('username', $request->mobile_or_email)->first();
         
        if (!$model) {
            $model = User::where('email', $request->mobile_or_email)->first();
        }

        if (!$model) {
            return response([
                'success' => false,
                'message' => 'User does not exist. Mobile or email not found.'
            ]);
        }

        $email = $model->email;
        $mobile_no = $model->mobile;

        try {

            $otp = rand(100000, 999999);
            $message = 'MoC password reset code:' . $otp;
    
            if (PasswordReset::where('user_id', $model->id)->exists()) {
                PasswordReset::where('user_id', $model->id)->update([
                    'status' => 0
                ]);
            }
    
            $passwordResetModel = new PasswordReset();
    
            $passwordResetModel->user_id = $model->id;
            $passwordResetModel->otp = $otp;
            $passwordResetModel->expired_at = (new \DateTime())->add(new \DateInterval('PT1H'))->format('Y-m-d H:i:s');
            $passwordResetModel->status = 1;
    
            $passwordResetModel->save();
    
            /** Sending SMS */
            if ($mobile_no) {
                $smsHelperObj = new SmsLibrary();
    
                $smsHelperObj->sendSingleSms([
                    'mobile'  => $mobile_no,
                    'message' => $message
                ]);
            }

            /** Sending email */
            // if ($email) {
            //     EmailSender::sendEmail($email, [
            //         'code' => $otp,
            //         'expired_at' => $passwordResetModel->expired_at
            //     ]);
            // }

        } catch (\Exception $ex) {

            $message = env('APP_ENV') !== 'production' ? $ex->getMessage() : "";

            return response([
                'success' => false,
                'message' => 'Failed to send OTP. Please, try again. ' . $message
            ]);
        }

        return response([
            'success' => true,
            'message' => 'OTP send successfully.',
            'data' => 'OTP will expired at: ' . $passwordResetModel->expired_at
        ]);        
    }

    public function verifyOtp(Request $request)
    {
        $otpModel = PasswordReset::where('otp', $request->password_reset_code)->first();

        if (!$otpModel) {
            return response([
                'success' => false,
                'message' => 'Wrong password reset code.',
                'errors' => ['otp' => ['Wrong password reset code.']]
            ]);
        }

        if (!$otpModel->status) {
            return response([
                'success' => false,
                'message' => 'This password reset code already expired.',
                'errors' => ['otp' => ['This password reset code already expired.']]
            ]);
        }

        $currentTime = (new \DateTime())->format('Y-m-d H:i:s');
        if ($otpModel->expired_at < $currentTime) {
            return response([
                'success' => false,
                'message' => 'This password reset code already expired.',
                'errors' => ['otp' => ['This password reset code already expired.']]
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Password reset code matched.'
        ]);
    }

    public function changePassword(Request $request)
    {
        $passwordResetModel = PasswordReset::where('otp', $request->password_reset_code)->first();

        if (!$passwordResetModel) {
            return response([
                'success' => false,
                'message' => 'Password reset code not found. Please, resend it.'
            ]);
        }

        if (!$passwordResetModel->status) {
            return response([
                'success' => false,
                'message' => 'Wrong otp'
            ]);
        }

        $validator = Validator::make($request->all(), [
            'new_password'  => 'required|min:6',
            'password_confirmation'  => 'required|min:6|same:new_password',
        ]);

        if ($validator->fails()) {
            return response([
                'success' => false,
                'errors'  => $validator->errors()
            ]);
        }

        $model = User::find($passwordResetModel->user_id);

        $model->password = Hash::make($request->new_password);        
        $model->save();

        $passwordResetModel->status = 0;
        $passwordResetModel->save();

        return response([
            'success' => true,
            'message' => 'Password reset successfull.'
        ]);
        
    }
}
