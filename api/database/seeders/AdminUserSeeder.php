<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('users')->updateOrInsert(
            ['email' => 'sokhankheav@gmail.com'],
            [
                'first_name' => 'Admin',
                'last_name' => 'User',
                'phone' => '0123456789',
                'photo' => 'users/XGK1Mb6WZvxbbp0jd2GO2f1IQtcWrE3HToJMlEXC.jpg',
                'password' => Hash::make('password123'),
                'role' => 'admin',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );
    }
}
