<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class HandymanTypesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('handyman_types')->delete();
        
        \DB::table('handyman_types')->insert(array (
            0 => 
            array (
                'commission' => 20.0,
                'type' => 'percent',
                'created_at' => '2022-10-20 11:43:51',
                'id' => 1,
                'name' => 'Công ty',
                'status' => 1,
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            1 => 
            array (
                'commission' => 5.0,
                'type' => 'fixed',
                'created_at' => '2022-10-20 11:58:53',
                'id' => 2,
                'name' => 'Lao động tự do',
                'status' => 1,
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
        ));
        
        
    }
}