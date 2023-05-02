<?php

namespace App\Http\Controllers;

use App\Http\Validations\ExternalUserValidations;
use App\Http\Validations\OtpVerifyValidation;
use App\Library\CommonInfo;
use App\Models\{ User, UserDetail, UserProfile };
use App\Models\UserOtp;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\{ Auth, Crypt, Hash, Log, Validator};
use App\Models\UserManagement\MenuWiseRole;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Library\SmsLibrary;
use DB;
class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validationResult = ExternalUserValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        DB::beginTransaction();
        try {
            $requestAll = $request->all();
            $requestAll['username'] = $request->mobile;
            $requestAll['status'] = 2;
            $requestAll['email'] = $request->email ? $request->email : null;
            $requestAll['password'] = Hash::make(($request->password));


            $user = User::create($requestAll);


            $now_date    = new \DateTime();
            $expiry_date = $now_date->add(new \DateInterval('PT5M'))->format('Y-m-d H:i:s');
            $userOtp             = new UserOtp();
            $userOtp->user_id    = $user->id;
            $userOtp->mobile_no  = $request->mobile;
            // $userOtp->email  = $request->email ? $request->email : null;
            $userOtp->otp        = rand(100000, 999999);
            $userOtp->expiry_date = $expiry_date;
            $userOtp->save();


            // if ($user) {
            //     $userStat = User::find($user->id);
            //     $userStat->status = 2;
            //     $userStat->mobile = $user->id;
            //     $userStat->username = $user->id;
            //     $userStat->email = $user->id;
            //     $userStat->save();
            // }



            DB::commit();

            $smsData['mobile'] = $userOtp->mobile_no;
            $smsData['message'] = "MoC Registration verification code ". $userOtp->otp . '.';
            $sms = new SmsLibrary();
            $sms->sendSingleSms($smsData);

            return response(['data' => [], 'message' => 'An OTP sent in your mobile number whose validity is 5 minutes!', 'success' =>  true, 'user_id' => $user->id]);

        } catch (\Exception $ex) {

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data saved successfully'
        ]);
    }


    public function roleUpdate($roleId)
    {
        $userDetail = unserialize(Crypt::decryptString(app('request')->header('user-detail')));
        $userDetail['role_id']= $roleId;
        $userDetail = Crypt::encryptString(serialize($userDetail));

        return [
            'success'       => true,
            'user_detail'  => $userDetail
        ];
    }

    public function otpVerify(Request $request)
    {
        $validationResult = OtpVerifyValidation::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        $current_user = User::find($request->id);

        if($current_user->status == 1) {
            return response(['data' => [], 'message' => 'You are already Registered User!!', 'success' => false]);
        }

        DB::beginTransaction();

        try {

            $userOtp = UserOtp::whereUserId($request->id)->latest()->first();

            if ($userOtp) {
                $now_date = new \DateTime(date('Y-m-d H:i:s'));
                $expiry_date = new \DateTime($userOtp->expiry_date);
                $otp_code = $request->otp_code;

                if ($otp_code == $userOtp->otp) {

                    if ($expiry_date < $now_date){
                        return response(['data' => [], 'message' => 'Your otp time limit expired.', 'success' => false]);
                    } else {
                        $userOtp->is_active = '1';
                        $userOtp->save();

                        $user = User::find($request->id);
                        $user->username = $userOtp->mobile_no;
                        $user->mobile = $userOtp->mobile_no;
                        $user->email = $userOtp->email;
                        $user->status = 1;
                        $user->save();

                        DB::commit();

                        return response([
                            'data' => [],
                            'message' => 'Account OTP verify successfully!',
                            'success' => true
                        ]);
                    }
                } else {
                    return response(['data' => [], 'message' => 'OTP is invalid!', 'success' => false]);
                }
            } else {
                return response(['data' => [], 'message' => 'Your account is invalid !!!', 'success' => false]);
            }

        } catch (\Exception $ex) {
            DB::rollback();

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : ""
            ]);
        }
    }

    public function otpResend(Request $request)
    {
        try {
            $userOtp = UserOtp::whereUserId($request->id)->latest()->first();

            if ($userOtp) {
                $now_date    = new \DateTime();
                $expiry_date = $now_date->add(new \DateInterval('PT3M'))->format('Y-m-d H:i:s');

                $userOtp->otp        = rand(100000, 999999);
                $userOtp->expiry_date = $expiry_date;
                $userOtp->update();

                $smsData['mobile'] = $userOtp->mobile_no;
                $smsData['message'] = "MoC Registration verification code ". $userOtp->otp . '.';
                $sms = new SmsLibrary();
                $sms->sendSingleSms($smsData);

                return response(['data' => [], 'message' => 'OTP resend successfully!', 'success' => true]);
            } else {
                return response(['data' => [], 'message' => 'Your account is invalid!', 'success' => false]);
            }

        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : ""
            ]);
        }
    }

    /** Customizing Login */
    public function login(Request $request)
    {

        $isNothiLogin = (int)$request->nothi_login;

        Log::info("Login start: isNothiLogin = {$isNothiLogin}");

        $response = [
            'success' => false,
            'message' => ''
        ];

        if ($isNothiLogin) {
            $response = $this->loginWithNothi($request);
        } else {
            $response = $this->loginWithCredential($request);
        }

        return response($response);
    }

    /**
     * Login with credential
    */
    public function loginWithCredential($request)
    {
        $this->validate($request, [
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $fieldType = filter_var($request->username, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';
        $credentials = array($fieldType => $request->username, 'password' => $request->password);

        if (! $token = Auth::attempt($credentials)) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Login with nothi
    */
    private function loginWithNothi($request)
    {
        /** Decoding the obtained payload from nothi login */
        Log::info("Nothi login started:");

        $data = json_decode(gzuncompress(base64_decode($request->data)), true);
        $user = User::where('nothi_user_id', $data['user_info']['user']['username'])->first();

        Log::info("Nothi User ID: {$data['user_info']['user']['username']}");

        if (!$user) {
            return [
                'success' => false,
                'message' => "This User ID does not exist in the system."
            ];
        }

        $userDetail = $this->updateSsoInfo($user, $data);

        if (!$userDetail) {
            return [
                'success' => false,
                'message' => "User Detail Not Found"
            ];
        }

        $current_user = User::find($user->id);
        // $token = JWTAuth::fromUser($current_user);

        if (! $token = JWTAuth::fromUser($current_user)) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        JWTAuth::setToken($token)->toUser();

        return $this->respondWithToken($token);
    }

    protected function updateSsoInfo($user, $data) {

        $key = array_search(true, array_column($data['user_info']['office_info'], 'status'));;
        $ssoInfo = [
            'office_id' => $data['user_info']['office_info'][$key]['office_id'],
            'user_id' => $data['user_info']['user']['id'],
            'fdesk' => $data['user_info']['office_info'][$key]['office_unit_organogram_id'],
        ];

        $userDetail = UserDetail::where('user_id', $user->id)->first();

        if (!$userDetail) {
            return false;
        }

        $userDetail->sso = $ssoInfo;
        $userDetail->save();

        return true;
    }

     /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    public function tokenVerification()
    {
        if (auth()->user()) {

            return response()->json([
                'success' => true,
                'data' => auth()->user()
            ]);
        }

        return response()->json([
            'success' => false,
            'data' => 'User Not Found'
        ]);
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Successfully logged out']);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
       $user = auth()->user();

       if ($user->status == 2) {
        return [
            'success' => false,
            'message' => "User Not Found"
        ];
    }

        $externalUserDetail = [];

        if ($user->user_type == 1) {

            $user_office_detail = UserDetail::select('designation_id','org_id','office_type_id','office_id','photo')->where('user_id', $user->id)->first();

            $user_detail = [
                'user_id'       => $user->id,
                'user_name'     => $user->username,
                'email'         => $user->email,
                'mobile'        => $user->mobile,
                'last_panel'    => $user->last_panel,
                'panels'        => $user->panels,
                'org_admin'     => $user->org_admin,
                'org_id'     => $user_office_detail['org_id'],
                'office_id'     => $user_office_detail['office_id'],
                'office_type_id'  => $user_office_detail['office_type_id'],
                'user_type'     => $user->user_type,
                'name'          => $user->name,
                'name_bn'       => $user->name_bn,
                'photo'         => $user_office_detail['photo']
            ];
            $allDetail = Crypt::encryptString(serialize($user_detail));

        } else {

            $user_office_detail = [];
            $user_profile = UserProfile::where('user_id', $user->id)->first();
            $user_detail = $user_profile;
            $user_detail['user_id'] = $user->id;
            $user_detail['name']    = $user->name;
            $user_detail['name_bn'] = $user->name_bn;
            $user_detail['mobile']  = $user->mobile;
            $user_detail['email']   = $user->email;
            $externalUserDetail = $user_detail;
            $userInfo = [
                'user_id' =>$user->id,
                'name' =>$user->name,
                'name_bn' =>$user->name_bn,
                'mobile' =>$user->mobile,
                'email' =>$user->email,
                'user_type'  => $user->user_type
            ];
            $allDetail = Crypt::encryptString(serialize($userInfo));
        }

        $office_detail = $user_office_detail;

        return [
            'success'       => true,
            'access_token'  => $token,
            'token_type'    => 'Bearer',
            'user_detail'   => $allDetail,
            'external_user_detail'   => $externalUserDetail,
            'office_detail' => $office_detail,
            'user_id'       => $user->id,
            'email'         => $user->email,
            'mobile'        => $user->mobile,
            'last_panel'    => $user->last_panel,
            'panels'        => $user->panels,
            'org_admin'     => $user->org_admin,
            'user_type'     => $user->user_type,
            'name'          => $user->name,
            'name_bn'       => $user->name_bn
        ];
    }

    /**
     * Get all roles of a user
     */
    public function userRoles(Request $request, $userId)
    {
        $userRoles = User::find($userId)->roles()->get();

        return response([
            'success' => true,
            'message' => 'User roles',
            'data' => $userRoles
        ]);
    }

    /**
     * Retrieves all component ids of all menus which are assigned to a role.
     */
    public function componentsByRole($roleId)
    {
        try {
            $query = MenuWiseRole::select('component_id');

            if ($roleId != 1) {
                $query = $query->where('role_id', $roleId);
            }

            $componentIds = $query->groupBy('component_id')->pluck('component_id')->all();

            if (count($componentIds) === 0) {
                return response([
                    'success' => false,
                    'message' => 'This role has not been assigned any menu',
                    'message_i18n_code' => 'authentication.noPrivilege'
                ]);
            }

            $components = CommonInfo::getAllComponents();
            $components = json_decode($components, true);

            if (!isset($components['success'])) {
                return response([
                    'success' => false,
                    'message' => 'Failed get components.',
                    'message_i18n_code' => 'authentication.noComponent'
                ]);
            }

            $selectedComponents = [];

            foreach ($components['data'] as $component) {
                if (in_array($component['id'], $componentIds)) {
                    $selectedComponents[] = $component;
                }
            }
        } catch (\Exception $ex) {
            return response([
                'success' => false,
                'message' => 'Faield to get components',
                'message_i18n_code' => 'authentication.serverError'
            ]);
        }

        return response([
            'success' => true,
            'data' => $selectedComponents
        ]);
    }

    /**
     * Change Password
    */
    public function changePassword (Request $request)
    {
        $user = User::find($request->user_id);

        if (!(Hash::check($request->get('old_password'), $user->password))) {
            return response([
                'success' => false,
                'message' => 'Old Password does not match'
            ]);
        }

        if(strcmp($request->get('new_password'), $user->password) == 0){
            // Current password and new password same
            return response([
                'success' => false,
                'message' => 'New Password cannot be same as your current password'
            ]);
        }

        $validator = Validator::make($request->all(), [
            'old_password' => 'required',
            'new_password' => 'required|string|min:6|required_with:repeat_new_password|same:repeat_new_password',
            'repeat_new_password' => 'required|min:6',
        ],
        [
           'new_password.min' => 'New Password Should be Minimum of 6 Character',
           'new_password.same' => 'Password & Repeat New Password not match',
           'repeat_new_password.min' => 'Repeat New Password Should be Minimum of 6 Character',
        ]);

        if ($validator->fails()) {
            return [
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ];
        }

        //Change Password
        $user->password = Hash::make(($request->new_password));
        $user->update();

        return [
            'success' => true,
            'message' => 'Password successfully changed!'
        ];
    }
}
