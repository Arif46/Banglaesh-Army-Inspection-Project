<?php

namespace App\Library;

use Illuminate\Support\Facades\Mail;

class EmailSender
{
  public static function sendEmail($recipient, $data = [])
  {
    Mail::send('mail', $data, function ($message) use ($recipient) {
      $message->to($recipient, '')->subject('MoC Password Reset Code');
      $message->from('syntech@jssgservices.com', "MoC Mail service");
    });
  }
}