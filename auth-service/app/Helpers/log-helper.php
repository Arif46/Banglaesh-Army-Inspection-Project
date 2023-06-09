<?php
if (!function_exists('save_log')) {
  function save_log($data)
  {
    try {
      $data['ip'] = isset($data['ip']) ? $data['ip'] : '';
      $data['execution_type'] = isset($data['execution_type']) ? $data['execution_type'] : 0;
      $data['user_id'] = user_id();
      $data['username'] = username();
      $data['menu_name'] = menu_name();
      $data['menu_name'] = isset($data['menu_name']) ? $data['menu_name'] : "&nbsp;";
  
      \App\Models\UserActivityLog::create($data);
    } catch (\Exception $ex) {
      Log::error("Failed to save log, Data:". implode(',', $data). " Error: {$ex->getMessage()}");
    }
  }
}

if (!function_exists('menu_name')) {
  function menu_name()
  {
    return app('request')->header('accessMenuName');
  }
}

if (!function_exists('exception_message')) {
  function exception_message($ex) {
    if (config('app.debug')) {
      return "Exception: {$ex->getMessage()}, Line: {$ex->getLine()}, File: {$ex->getFile()}";
    }

    return "";
  }
}