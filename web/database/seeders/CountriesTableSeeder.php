<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CountriesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('countries')->delete();
        
        \DB::table('countries')->insert(array (
            0 => 
            array (
                'id' => 1,
                'code' => 'VN',
                'name' => 'Viet Nam',
                'dial_code' => 84,
                'currency_name' => 'Việt Nam đồng',
                'symbol' => '₫',
                'currency_code' => 'VND',
            ),
        ));
        
    }
}