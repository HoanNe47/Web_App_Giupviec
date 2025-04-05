<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class UserTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('users')->delete();
        
        \DB::table('users')->insert(array (
            0 => 
            array (
                'id' => 1,
                'username' => 'actcms',
                'first_name' => 'Admin',
                'last_name' => 'ACTCMS',
                'contact_number' => '973909143',
                'address' => NULL,
                'email' => 'actcms.work@gmail.com',
                'password' => bcrypt('12345678'),
                'country_id' => 1,
                'state_id' => NULL,
                'city_id' => 50,
                'ward_id' => 1,
                'email_verified_at' => NULL,
                'user_type' => 'admin',
                'player_id' => NULL,
                'provider_id' => NULL,
                'is_featured' => 0,
                'display_name' => 'Admin Admin',
                'providertype_id' => NULL,
                'remember_token' => NULL,
                'last_notification_seen' => NULL,
                'status' => 1,
                'time_zone' => 'Asia/Ho_Chi_Minh',
                'created_at' => '2021-05-28 15:59:15',
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            1 => 
            array (
                'id' => 2,
                'username' => 'admin',
                'first_name' => 'Admin',
                'last_name' => 'Admin',
                'contact_number' => '123456789',
                'address' => NULL,
                'email' => 'admin@actcms.work',
                'password' => bcrypt('12345678'),
                'country_id' => 1,
                'state_id' => NULL,
                'city_id' => 50,
                'ward_id' => 2,
                'email_verified_at' => NULL,
                'user_type' => 'demo_admin',
                'player_id' => NULL,
                'provider_id' => NULL,
                'is_featured' => 0,
                'display_name' => 'Demo Admin',
                'providertype_id' => NULL,
                'remember_token' => NULL,
                'last_notification_seen' => NULL,
                'status' => 1,
                'time_zone' => 'Asia/Ho_Chi_Minh',
                'created_at' => '2021-05-29 05:40:38',
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            2 => 
            array (
                'id' => 3,
                'username' => 'user',
                'first_name' => 'User',
                'last_name' => 'Demo',
                'contact_number' => '123456789',
                'address' => NULL,
                'email' => 'demo@actcms.work',
                'password' => bcrypt('12345678'),
                'country_id' => 1,
                'state_id' => NULL,
                'city_id' => 50,
                'ward_id' => 3,
                'email_verified_at' => NULL,
                'user_type' => 'user',
                'player_id' => NULL,
                'provider_id' => NULL,
                'is_featured' => 0,
                'display_name' => 'Demo User',
                'providertype_id' => NULL,
                'remember_token' => NULL,
                'last_notification_seen' => NULL,
                'status' => 1,
                'time_zone' => 'Asia/Ho_Chi_Minh',
                'created_at' => '2021-05-28 12:36:58',
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            3 => 
            array (
                'id' => 4,
                'username' => 'vendor',
                'first_name' => 'Vendor',
                'last_name' => 'Demo',
                'contact_number' => '0123456789',
                'address' => NULL,
                'email' => 'vendor@actcms.work',
                'password' => bcrypt('12345678'),
                'country_id' => 1,
                'state_id' => NULL,
                'city_id' => 50,
                'ward_id' => 4,
                'email_verified_at' => NULL,
                'user_type' => 'provider',
                'player_id' => NULL,
                'provider_id' => NULL,
                'is_featured' => 1,
                'display_name' => 'Spa Demo',
                'providertype_id' => 1,
                'remember_token' => NULL,
                'last_notification_seen' => NULL,
                'status' => 1,
                'time_zone' => 'Asia/Ho_Chi_Minh',
                'created_at' => '2021-05-29 05:43:47',
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            4 => 
            array (
                'id' => 5,
                'username' => 'reparer',
                'first_name' => 'Kỹ thuật viên',
                'last_name' => 'Demo',
                'contact_number' => '123456789',
                'address' => NULL,
                'email' => 'repairer@actcms.work',
                'password' => bcrypt('12345678'),
                'country_id' => 1,
                'state_id' => NULL,
                'city_id' => 50,
                'ward_id' => 15,
                'email_verified_at' => NULL,
                'user_type' => 'handyman',
                'player_id' => NULL,
                'provider_id' => 4,
                'is_featured' => 0,
                'display_name' => 'KTV Demo',
                'providertype_id' => NULL,
                'remember_token' => NULL,
                'last_notification_seen' => NULL,
                'status' => 1,
                'time_zone' => 'Asia/Ho_Chi_Minh',
                'created_at' => '2021-05-29 05:43:24',
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
        ));
        
        
    }
}