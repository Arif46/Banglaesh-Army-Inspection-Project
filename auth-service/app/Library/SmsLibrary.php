<?php
namespace App\Library;

use DB, Log;
use GuzzleHttp\Client;

class SmsLibrary
{
  private $api_token = "";
  private $sid = "";
  private $domain = "";
  private $singleSmsEndPoint = "/api/v3/send-sms";

  public function __construct()
  {
    $this->domain = config('custom.sms.domain');
    $this->sid = config('custom.sms.sid');
    $this->api_token = config('custom.sms.api_token');
  }

  public function sendSingleSms($sms_info = [])
  {
      $mobile = $sms_info['mobile'];
      $message = $sms_info['message'];
      $csmsId = 'fdklfdfl';

      return $this->singleSms($mobile, $message, $csmsId);
  }

  public function singleSms($msisdn, $messageBody, $csmsId)
  {
      $params = [
          "api_token" => $this->api_token,
          "sid" => $this->sid,
          "msisdn" => $msisdn,
          "sms" => $messageBody,
          "csms_id" => $csmsId
      ];
      $url = trim($this->domain, '/') . $this->singleSmsEndPoint;
      $params = json_encode($params);
      return $this->callApi($url, $params);
  }

  public function callApi($url, $params)
  {

    try {

      $ch = curl_init(); // Initialize cURL
      curl_setopt($ch, CURLOPT_URL, $url);
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
      curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
      curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
      curl_setopt($ch, CURLOPT_HTTPHEADER, array(
          'Content-Type: application/json',
          'Content-Length: ' . strlen($params),
          'accept:application/json'
      ));

      $response = curl_exec($ch);
      
      curl_close($ch);

      Log::info($response);

      return [
        'success' => true,
        'message' => $response,
        'errors' => []
      ];

    } catch (\Exception $ex) {

      Log::info('SMS:' ."Error occurred during communicating with other dependent service." . $ex->getMessage());

      return [
        'success' => false,
        'message' => "Error occurred during communicating with other dependent service." . $ex->getMessage(),
        'errors' => []
      ];
    }
  }
}