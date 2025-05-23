<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class BookingStatusesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('booking_statuses')->delete();
        
        \DB::table('booking_statuses')->insert(array (
            0 => 
            array (
                'created_at' => '2022-10-20 16:47:08',
                'id' => 1,
                'label' => 'Chờ xử lý',
                'sequence' => 1,
                'status' => 1,
                'updated_at' => '2022-10-20 16:47:21',
                'value' => 'pending',
            ),
            1 => 
            array (
                'created_at' => '2022-10-20 16:50:40',
                'id' => 2,
                'label' => 'Đã chấp nhận',
                'sequence' => 2,
                'status' => 1,
                'updated_at' => '2022-10-20 16:50:44',
                'value' => 'accept',
            ),
            2 => 
            array (
                'created_at' => '2022-10-20 16:50:46',
                'id' => 3,
                'label' => 'Đang diễn ra',
                'sequence' => 3,
                'status' => 1,
                'updated_at' => '2022-10-20 16:50:48',
                'value' => 'on_going',
            ),
            3 => 
            array (
                'created_at' => '2022-10-20 16:50:50',
                'id' => 4,
                'label' => 'Đang thực hiện',
                'sequence' => 4,
                'status' => 1,
                'updated_at' => '2022-10-20 16:50:52',
                'value' => 'in_progress',
            ),
            4 => 
            array (
                'created_at' => '2022-10-20 16:50:54',
                'id' => 5,
                'label' => 'Giữ lại',
                'sequence' => 5,
                'status' => 1,
                'updated_at' => '2022-10-20 16:50:56',
                'value' => 'hold',
            ),
            5 => 
            array (
                'created_at' => '2022-10-20 16:55:03',
                'id' => 6,
                'label' => 'Đã hủy bỏ',
                'value' => 'cancelled',
                'sequence' => 6,
                'status' => 1,
                'updated_at' => '2022-10-20 16:55:05',
            ),
            6 => 
            array (
                'created_at' => '2022-10-20 16:55:09',
                'id' => 7,
                'label' => 'Bị từ chối',
                'sequence' => 7,
                'status' => 1,
                'updated_at' => '2022-10-20 16:55:10',
                'value' => 'rejected',
            ),
            7 => 
            array (
                'created_at' => '2022-10-20 16:55:11',
                'id' => 8,
                'label' => 'Lỗi',
                'sequence' => 8,
                'status' => 1,
                'updated_at' => '2022-10-20 16:55:12',
                'value' => 'failed',
            ),
            8 => 
            array (
                'id' => 9,
                'label' => 'Đã hoàn thành',
                'value' => 'completed',
                'sequence' => 9,
                'status' => 1,
                'updated_at' => '2022-10-20 16:55:12',
                'created_at' => '2022-10-20 16:55:11',
            ),
        ));
        
        
    }
}