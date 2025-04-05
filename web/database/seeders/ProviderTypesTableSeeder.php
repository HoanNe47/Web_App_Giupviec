<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class ProviderTypesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('provider_types')->delete();
        
        \DB::table('provider_types')->insert(array (
            0 => 
            array (
                'commission' => 20,
                'created_at' => '2021-06-10 11:43:51',
                'id' => 1,
                'name' => 'Công ty',
                'status' => 1,
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
            1 => 
            array (
                'commission' => 5,
                'created_at' => '2021-06-10 11:58:53',
                'id' => 2,
                'name' => 'Lao động tự do',
                'status' => 1,
                'updated_at' => NULL,
                'deleted_at' => NULL,
            ),
        ));
        
        
    }
}