<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\UserDetail;
use GuzzleHttp\Client;
use DB, Log, Auth;

class NothiUserController extends Controller
{
    private $nothiUrl = null;

    public function __construct() {
        $this->nothiUrl = 'http://training.nothi.gov.bd/';    
    }

    public function ssoUser(Request $request)
    {
        $data = json_decode(gzuncompress(base64_decode($request->data)), true);
        return $data;
    }

    
    //Return Nothi User
    public function apiAccess()
    {
        // $formData = [
        //     'username' => 'O7F3HC',
        //     'password' => 'kjIn0Tv'
        // ];
        $formData = [
            'username' => 'idsdpMoSW',
            'password' => 'idsdp@m$&o0swI'
        ];
        $formDatas = json_encode($formData);
        Log::info("user id and password=== {$formDatas}");

        $ip_server = $_SERVER['SERVER_ADDR'];
        Log::info("SERVER_ADDR=== {$ip_server}");

        //$data = \App\Library\RestService::postData($this->nothiUrl, 'apiAccess', $formData); 
        return $this->sendNothiApiRearange('apiAccess', $formData);
    }

    public function sendNothiApiRearange($uri, $formData)
    {
        $client = new Client(['base_uri' => $this->nothiUrl]);

        try {
            $res = $client->request('POST', $uri, ['form_params' => $formData]);
            if ($res->getStatusCode() != 200) {
                return response([
                    'success' => false,
                    'message' => "Failed to get content from other service",
                    'errors' => []
                ]);
            }
        } catch (\Exception $ex) {

            return response([
                'success' => false,
                'message' => "Error occurred during communicating with other dependent service." . $ex->getMessage(),
                'errors' => []
            ]);
        }
        return $res->getBody()->getContents();
    }


    public function nothiReturn(Request $request)
    {
        $data = json_encode($request->all());
        // return $data;
        Log::info("Nothi Retrun: {$data}");
    }


    public function apiOnlineApplication(Request $request)
    {
        $requestAll = $request->all();
        $nothiUser = json_decode($this->apiAccess(), true);

        $requestAlls = json_encode($requestAll);
        Log::info("requestAll=== {$requestAlls}");

        $nothiUsers = json_encode($nothiUser);
        Log::info("nothiUser=== {$nothiUsers}");
        
        Log::info("Feedback api key=== {$request->feedback_api_key}");
        
        if ($nothiUser['status'] == 'success') {
            $userDetail = UserDetail::where('user_id', $request->user_id)->first();
            
            $formData = [
                // 'token' => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjU5MTg0MjgsImp0aSI6Ik1UWTJOVGt4T0RReU9BPT0iLCJpc3MiOiJodHRwOlwvXC90cmFpbmluZy5ub3RoaS5nb3YuYmRcLyIsIm5iZiI6MTY2NTkxODQyOCwiZXhwIjoxNjY2MDA0ODI4LCJkYXRhIjp7ImFwaV91aWQiOiJjektBNUI2NjVxSndsYnhDQ0ExRHpDUUZQUys3UlZEOXRNanZQNTA5YWVyUlV3aUhrcHYyRmVwWklCVU56NGc3XC9UU0FWUmk2eDM1OG9MV0lxU3FRTnc9PSIsInJfaXAiOiJPeXhFRG81blBtQVBFc25nS3lqbEFlcXJ0ZUpyZG55bnFtRWFURk93Y2VNTTZpYXVaT0FJZTJGb1pTS0RjSFp6UWRyeTRkZm1JYXBTbVRHNHBDZTU5QT09In19.7UI0NYgFvMg5hXvXNK6p4lsNp6s04Fb_xn77_F2Iu-8',
                'token' => $nothiUser['token'],
                'office_id' => $userDetail->sso['office_id'], // Dak receiving office id
                'user_id' => $userDetail->sso['user_id'], // Unique id of the user
                'data' =>  $request->html, // Can be HTML or text. Works as the main body of the application
                'api_client' => 'O7F3HC', // username of apiAccess API
                'applicant_name' => 'Syntech Solutions LTD',
                'application_subject' => $request->application_subject, // Unique
                'feedback_url' => $request->feedback_url,
                // 'feedback_url' => 'http://209.126.78.97:8080/nothi/nothi-return',
                'decision' => $request->decision,
                'fdesk' => $userDetail->sso['fdesk'],
                'feedback_api_key' => $request->feedback_api_key
                // 'receivers' => 4398,
            ];
            $data = $this->sendNothiApiRearange('apiOnlineApplication', $formData);
            return $data;
        }
       
       return $nothiUser['status'];
    }
    

    public function apiReOnlineApplication(Request $request)
    {
        $requestAll = $request->all();

        $nothiUser = json_decode($this->apiAccess(), true);
        $nothiTest = json_encode($nothiUser);
        Log::info("Feedback api key=== {$request->feedback_api_key}");
        Log::info("Nothi User=== {$nothiTest}");
        
        if ($nothiUser['status'] == 'success') {
            $userDetail = UserDetail::where('user_id', $request->user_id)->first();
            
            $formData = [
                // 'token' => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NDEzNzQwMTIsImp0aSI6Ik1UWTBNVE0zTkRBeE1nPT0iLCJpc3MiOiJodHRwOlwvXC90cmFpbmluZy5ub3RoaS5nb3YuYmRcLyIsIm5iZiI6MTY0MTM3NDAxMiwiZXhwIjoxNjQxNDYwNDEyLCJkYXRhIjp7ImFwaV91aWQiOiJQdlV4bjdCNkx4dkFZa3RMUElycWtvYXJZN2F1TWwzOVdvOWtHS1QrZnJYQm5RZ08zamJ4azRyYVRKUHlNZHlNWWxqOGIwXC9FcUlHekZYczhkTnkyZHc9PSIsInJfaXAiOiJaK1wvMGxtYkl1aWd2QWM3dGFUVmQwTEhWREpkRDQ1NXJDQmM0a2s0RENzZ3dPT2x4RW8wVkNScWs5dDNMd1dTTzN4Smh3XC93YTZ4YklsK2d4am8rSGdRPT0ifX0.qerrUalu-lpNmB6VarHTDOhWzqSAe0LcxnVi23U2o7A',
                'token' => $nothiUser['token'],
                'office_id' => $userDetail->sso['office_id'], // Dak receiving office id
                'user_id' => $userDetail->sso['user_id'], // Unique id of the user
                'data' =>  $request->html, // Can be HTML or text. Works as the main body of the application
                'api_client' => 'O7F3HC', // username of apiAccess API
                'applicant_name' => 'Syntech Solutions LTD',
                'application_subject' => $request->application_subject, // Unique
                'feedback_url' => $request->feedback_url,
                // 'feedback_url' => 'http://209.126.78.97:8080/nothi/nothi-return',
                'decision' => $request->decision,
                'nothi_id' => $request->nothi_id,
                'note_id' => $request->note_id,
                'potro_id' => $request->potro_id,
                'decision_note' => $request->decision_note,
                'decision_id' => $request->decision_id,
                'fdesk' => $userDetail->sso['fdesk'],
                'feedback_api_key' => $request->feedback_api_key
                // 'receivers' => 4398,
            ];
            $data = $this->sendNothiApiRearange('apiResubmitApplication', $formData);
            // return $formData;
            return $data;
        }
       
       return $nothiUser['status'];
    }
}
