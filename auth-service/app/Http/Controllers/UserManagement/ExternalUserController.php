<?php

namespace App\Http\Controllers\UserManagement;

use App\Http\Controllers\Controller;
use App\Http\Validations\UserValidations;
use App\Library\CommonProfile;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class ExternalUserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validationResult = UserValidations::validate($request);

        if (!$validationResult['success']) {
            return response($validationResult);
        }

        try {

            $requestAll = $request->all();
            $requestAll['username'] = $request->mobile;
            $requestAll['password'] = Hash::make(($request->password));

           $user =  User::create($requestAll);

        } catch (\Exception $ex) {

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'user' => $user,
            'message' => 'Data saved successfully'
        ]);
    }

        /**
     * set last panel
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function setLastPanel (Request $request)
    {
        $user = User::find($request->user_id);

        if (!$user) {
            return response([
                'success' => false,
                'message' => 'User not found'
            ]);
        }

        $panels = array_filter(explode(',', $user->panels));
        array_push($panels, $request->last_panel);
        $panels = implode(',', array_unique($panels));

        $user->last_panel = $request->last_panel;
        $user->panels = $panels;

        $user->update();

        return response([
            'success' => true,
            'message' => 'Users Panel updated successfully.'
        ]);

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    /**
     * Create or update external user from other micro services
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function externalUserCreateOrUpdate(Request $request)
    {
        \Log::info('externalUserCreateOrUpdate');
        \Log::info("action: {$request->action} user_id: {$request->user_id} email: {$request->email}");
        // check validation
        if ($request->action == 'create') {
            $user = User::where('email', $request->email)
                ->orWhere('username', $request->mobile)
                ->orWhere('mobile', $request->mobile)
                ->first();

            if ($user) {
                return response([
                    'success' => true,
                    'message' => 'User already exists for this email or mobile',
                    'data' => $user
                ]);
            }
        } else {
            $user = User::find($request->user_id);

            if (!$user) {
                return response([
                    'success' => false,
                    'message' => 'User not found!',
                ]);
            }

            $anotherUser = User::where('email', $request->email)
                ->orWhere('username', $request->mobile)
                ->orWhere('mobile', $request->mobile)
                ->first();

            if ($anotherUser && ($user->isNot($anotherUser))) {
                return response([
                    'success' => false,
                    'message' => 'User already exists for this email or mobile.',
                    'data' => $anotherUser
                ]);
            }
        }

        DB::beginTransaction();

        try {
            $requestAll = $request->only('name', 'name_bn', 'email');
            $requestAll['username'] = $request->mobile;
            $requestAll['mobile'] = $request->mobile;
            $requestAll['user_type'] = 2;
            if ($request->action == 'create') {
                $requestAll['password'] = Hash::make('123456');
            }
            $requestAll['status'] = 1;

            $user = User::updateOrCreate(
                ['id' => $request->user_id],
                $requestAll
            );

            $execution_type = $request->action == 'create' ? 0 : 1;

            save_log([
                'data_id'    => $user->id,
                'table_name' => $user->getTable(),
                'execution_type'=> $execution_type
            ]);

            // create or update external user common profile info
            CommonProfile::setCommonProfileData($request, $user, $request->panel);

            DB::commit();

        } catch (\Exception $ex) {

            DB::rollback();

            return response([
                'success' => false,
                'message' => 'Failed to save data.',
                'errors'  => env('APP_ENV') !== 'production' ? $ex->getMessage() : []
            ]);
        }

        return response([
            'success' => true,
            'message' => 'Data saved successfully',
            'data' => $user
        ]);
    }

    /**
     * Destroy the specific user
     *
     * @param $id
     * @return \Illuminate\Http\Response
     */
    public function userDelete($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response([
                'success' => false,
                'message' => 'User not found'
            ]);
        }

        $user->delete();

        return response([
            'success' => true,
            'message' => 'User deleted successfully.'
        ]);
    }
}
