<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{

    //https://gist.github.com/Cerwyn/7fb92e7ddb3a6c49c5846f82cab0e9ac

    public function register(Request $request)
    {
        $attr = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed'
        ]);

        $user = User::create([
            'name' => $attr['name'],
            'password' => bcrypt($attr['password']),
            'email' => $attr['email']
        ]);

        // return $this->success([
        //     'token' => $user->createToken('API Token')->plainTextToken
        // ]);

        //return $user->createToken('API Token')->plainTextToken;
         return $user->createToken($request['device_name'])->plainTextToken;
    }
    // public function register(Request $request)
    // {
    //     $attr = $request->validate([
    //         'name' => 'required|string|max:255',
    //         'email' => 'required|string|email|unique:users,email',
    //        // 'password' => 'required|string|min:6|confirmed'
    //        'password' => 'required|string|min:6'
    //     ]);

    //     $user = User::create([
    //         'name' => $attr['name'],
    //         'password' => bcrypt($attr['password']),
    //         'email' => $attr['email']
    //     ]);

    //     // if (! $user || ! Hash::check($request->password, $user->password)) {
    //     //     throw ValidationException::withMessages([
    //     //         'email' => ['The provided credentials are incorrect.'],
    //     //     ]);
    //     // }

    //     return $user->createToken($request->device_name)->plainTextToken;

    //     // return $this->success([
    //     //     'token' => $user->createToken('API Token')->plainTextToken
    //     // ]);

    // }
// http://localhost:8000/api/auth/login
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'device_name' => 'required',
        ]);

        // $attr = $request->validate([
        //     'name' => 'required|string|max:255',
        //     'email' => 'required|string|email|unique:users,email',
        //     'password' => 'required|string|min:6|confirmed'
        // ]);


        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        return $user->createToken($request->device_name)->plainTextToken;
    }

    //http://localhost:8000/api/auth/logout
    public function logout(Request $request)
    {
       // auth()->user()->tokens()->delete();

        // return [
        //     'message' => 'Tokens Revoked'
        // ];
        $user = User::where('email',$request->email)->first();

        if($user){
            $user->tokens()->delete();
        }
        return response()->noContent();
    }
}
