<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class StaticDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \DB::table('static_data')->delete();
        \DB::table('static_data')->insert(array (
            0 => 
            array (
                'id' => 1,
                'type' => 'plan_type',
                'label' => 'Không giới hạn',
                'value' => 'unlimited',
                'created_at' => '2022-04-21 12:23:03',
                'updated_at' => '2022-04-21 12:23:03',
            ),
            1 => 
            array (
                'id' => 2,
                'type' => 'plan_type',
                'label' => 'Giới hạn',
                'value' => 'limited',
                'created_at' => '2022-04-21 12:23:03',
                'updated_at' => '2022-04-21 12:23:03',
            ),
            2 => 
            array (
                'id' => 3,
                'type' => 'plan_limit_type',
                'label' => 'Dịch vụ',
                'value' => 'service',
                'created_at' => '2022-04-21 12:23:03',
                'updated_at' => '2022-04-21 12:23:03',
            ),
            3 => 
            array (
                'id' => 4,
                'type' => 'plan_limit_type',
                'label' => 'Kỹ thuật viên',
                'value' => 'handyman',
                'created_at' => '2022-04-21 12:23:03',
                'updated_at' => '2022-04-21 12:23:03',
            ),
            4 => 
            array (
                'id' => 5,
                'type' => 'plan_limit_type',
                'label' => 'Dịch vụ nổi bật',
                'value' => 'featured_service',
                'created_at' => '2022-04-21 12:23:03',
                'updated_at' => '2022-04-21 12:23:03',
            )
        ));
    }
}
