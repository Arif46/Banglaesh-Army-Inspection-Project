<?php

namespace App\Http\Middleware;

use DB, Log, Auth;
use Closure;

class TransformData
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // Pre-Middleware Action
        // return $request->data;
        if (is_array($request->data) && $request->data) {
            return $request->all();
            $request->merge($request->data);
            unset($request['data']);
        }

        $response = $next($request);

        // Post-Middleware Action

        return $response;
    }
}
