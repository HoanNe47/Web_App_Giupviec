<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class PlansTableDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        \DB::table('plans')->delete();
        \DB::table('plans')->insert(array (
            0 => 
            array (
                'id' => 1,
                'title' => 'Miễn phí',
                'identifier' => 'free',
                'type' => 'weekly',
                'amount' => 0,
                'trial_period' => 7,
                'status' => 1,
                'created_at' => '2022-10-20 11:26:15',
                'updated_at' => '2022-10-20 11:26:15',
            ),
            1 => 
            array (
                'id' => 2,
                'title' => 'Cơ bản',
                'identifier' => 'basic',
                'type' => 'monthly',
                'amount' => 10,
                'trial_period' => NULL,
                'status' => 1,
                'created_at' => '2022-10-20 11:26:15',
                'updated_at' => '2022-10-20 11:26:15',
            ),
            2 => 
            array (
                'id' => 3,
                'title' => 'Cao cấp',
                'identifier' => 'premium',
                'type' => 'yearly',
                'amount' => 100,
                'trial_period' => NULL,
                'status' => 1,
                'created_at' => '2022-10-20 11:26:15',
                'updated_at' => '2022-10-20 11:26:15',
            ),
        ));
    }
}
