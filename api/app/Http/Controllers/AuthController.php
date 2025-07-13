<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Mail\PasswordResetCodeMail;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

class AuthController extends Controller
{
    // get all users
    public function index()
    {
        try {
            // get all users
            $users = User::orderBy('id', 'desc')->get();

            // format data users
            $formattedUsers = $users->map(function ($user) {
                return [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'photo' => $user->photo ? 'storage/' . $user->photo : null,
                    'role' => $user->role,
                ];
            });

            // response data users
            return response()->json([
                'success' => true,
                'message' => 'Users retrieved successfully',
                'users' => $formattedUsers,
            ], 200);

            // catch error
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to get users, please try again',
            ], 500);
        }
    }

    public function getOwnUser(Request $request)
    {
        try {
            $user = $request->user();

            $photoUrl = $user->photo ?? null;

            return response()->json([
                'success' => true,
                'message' => 'User profile retrieved successfully',
                'user' => [
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'first_name' => $user->first_name,
                    'last_name' => $user->last_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'photo_url' => $photoUrl,
                ],
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to retrieve profile, please try again',
            ], 500);
        }
    }

    // register user
    public function register(Request $request)
    {
        // validate data
        $request->validate(
            [
                'first_name' => ['required', 'string'],
                'last_name' => ['required', 'string'],
                'email' => ['required', 'email', 'unique:users,email'],
                'phone' => ['required', 'string', 'unique:users,phone'],
                'password' => ['required', 'string', 'min:6', 'confirmed'],
            ],
            [
                'first_name.required' => 'Please enter your first name',
                'last_name.required' => 'Please enter your last name',
                'email.required' => 'Please enter your email',
                'email.unique' => 'This email is already taken',
                'phone.required' => 'Please enter your phone number',
                'phone.unique' => 'This phone is already taken',
                'password.min' => 'Password must be at least 6 characters long',
                'password.confirmed' => 'Password confirmation does not match',
            ]
        );

        try {
            DB::beginTransaction();

            // create new user
            $user = new User();
            $user->first_name = $request->first_name;
            $user->last_name = $request->last_name;
            $user->email = $request->email;
            $user->phone = $request->phone;
            $user->role = 'user';
            $user->password = Hash::make($request->password);

            // save data user
            $user->save();
            // create token
            $token = $user->createToken('auth_token')->plainTextToken;
            DB::commit();

            // response data user and token
            return response()->json([
                'success' => true,
                'message' => 'User registered successfully',
                'token' => $token,
                'token_type' => 'Bearer',
                'user_info' => [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                ],
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            // Handle other exceptions error
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to register, please try again',
            ], 500);
        }
    }

    // login to plate form
    public function login(Request $request)
    {
        // validate data
        $request->validate(
            [
                'email' => ['required', 'email', 'exists:users,email'],
                'password' => ['required', 'string', 'min:6'],
            ],
            [
                'email.required' => 'Please enter your email',
                'password.min' => 'Password must be at least 6 characters',
            ]
        );

        try {
            // find user by email
            $user = User::where('email', $request->email)->first();

            // Check password
            if (!$user || !Hash::check($request->password, $user->password)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Incorrect password. Please try again.',
                ], 401);
            }

            // Create token
            $token = $user->createToken('auth_token')->plainTextToken;

            // response data user and token
            return response()->json([
                'success' => true,
                'message' => 'User logged in successfully',
                'token' => $token,
                'token_type' => 'Bearer',
                'user_info' => [
                    'id' => $user->id,
                    'name' => $user->first_name . ' ' . $user->last_name,
                    'email' => $user->email,
                    'role' => $user->role,
                    'phone' => $user->phone,
                ],
            ], 200);
        } catch (\Exception $e) {
            // Handle other exceptions
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to login, please try again',
            ], 500);
        }
    }

    // logut from plate form
    public function logout(Request $request)
    {
        try {
            // Delete all tokens of the user (logs out from all devices)
            $request->user()->tokens()->delete();

            return response()->json([
                'success' => true,
                'message' => 'Successfully logged out from all sessions.',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Logout failed',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // refresh token
    public function refresh(Request $request)
    {
        try {
            $user = $request->user();
            $oldToken = $request->bearerToken();

            // Delete the current token (based on the raw token from header)
            if ($oldToken) {
                $user->tokens()->where('token', hash('sha256', $oldToken))->delete();
            }

            // Create a new token
            $newToken = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'success' => true,
                'message' => 'Token refreshed successfully.',
                'token' => $newToken,
                'token_type' => 'Bearer',
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to refresh token',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    // send email to get code
    public function sendPasswordResetCode(Request $request)
    {
        // Validate the email input
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        try {
            // Find the user by the provided email
            $user = User::where('email', $request->email)->first();

            // Check if user exists
            if (!$user) {
                return response()->json([
                    'message' => 'User not found.',
                ], 404);
            }

            // Generate a random code for password reset
            $code = rand(100000, 999999);

            // Store the code temporarily (e.g., in cache)
            Cache::put('password_reset_code_' . $code, $user->id, now()->addMinutes(10));

            // Send code to email...
            Mail::to($user->email)->send(new PasswordResetCodeMail($code));

            // Return success message
            return response()->json([
                'message' => 'Verification code sent to your email',
            ]);
        } catch (\Exception $e) {
            // Return error message if something goes wrong
            return response()->json([
                'success' => false,
                'error_message' => $e->getMessage(),
                'message' => 'Failed to send code',
            ], 500);
        }
    }


    // verify code
    public function verifyPasswordCode(Request $request)
    {
        $request->validate([
            'code' => 'required|string',
        ]);

        $cacheKey = 'password_reset_code_' . $request->code;
        $userId = Cache::get($cacheKey);

        if (!$userId) {
            return response()->json(['message' => 'Invalid or expired code'], 400);
        }

        // Save verified state
        $verifiedKey = 'verified_user_for_password_reset_' . $request->ip();
        Cache::put($verifiedKey, $userId, now()->addMinutes(10));

        return response()->json(['message' => 'Code verified successfully']);
    }

    // reset password
    public function resetPassword(Request $request)
    {
        $request->validate([
            'new_password' => ['required', 'string', 'min:6'],
            'confirm_password' => ['required', 'same:new_password'],
        ]);

        // Identify user from verification cache
        $cacheKey = 'verified_user_for_password_reset_' . $request->ip();
        $userId = Cache::get($cacheKey);

        if (!$userId) {
            return response()->json(['message' => 'No verified reset request found'], 400);
        }

        $user = User::find($userId);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        // Clean up
        Cache::forget($cacheKey);

        return response()->json(['message' => 'Password reset successful']);
    }
}
