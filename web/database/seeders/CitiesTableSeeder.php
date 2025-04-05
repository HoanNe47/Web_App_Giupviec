<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CitiesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('cities')->delete();
        
        \DB::table('cities')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Quận 1',
                'state_id' => 50,
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Quận 2',
                'state_id' => 50,
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Quận 3',
                'state_id' => 50,
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Quận 4',
                'state_id' => 50,
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Quận 5',
                'state_id' => 50,
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'Quận 6',
                'state_id' => 50,
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'Quận 7',
                'state_id' => 50,
            ),
            7 => 
            array (
                'id' => 8,
                'name' => 'Quận 8',
                'state_id' => 50,
            ),
            8 => 
            array (
                'id' => 9,
                'name' => 'Quận 11',
                'state_id' => 50,
            ),
            9 => 
            array (
                'id' => 10,
                'name' => 'Quận 12',
                'state_id' => 50,
            ),
            10 => 
            array (
                'id' => 11,
                'name' => 'Quận Bình Tân',
                'state_id' => 50,
            ),
            11 => 
            array (
                'id' => 12,
                'name' => 'Quận Bình Thạnh',
                'state_id' => 50,
            ),
            12 => 
            array (
                'id' => 13,
                'name' => 'Quận Tân Bình',
                'state_id' => 50,
            ),
            13 => 
            array (
                'id' => 14,
                'name' => 'Quận Tân Phú',
                'state_id' => 50,
            ),
            14 => 
            array (
                'id' => 15,
                'name' => 'Quận Phú Nhuận',
                'state_id' => 50,
            ),
            15 => 
            array (
                'id' => 16,
                'name' => 'Thành phố Thủ Đức',
                'state_id' => 50,
            ),
            16 => 
            array (
                'id' => 17,
                'name' => 'Huyện Củ Chi',
                'state_id' => 50,
            ),
            17 => 
            array (
                'id' => 18,
                'name' => 'Huyện Hóc Môn',
                'state_id' => 50,
            ),
            18 => 
            array (
                'id' => 19,
                'name' => 'Huyện Bình Chánh',
                'state_id' => 50,
            ),
            19 => 
            array (
                'id' => 20,
                'name' => 'Huyện Nhà Bè',
                'state_id' => 50,
            ),
            20 => 
            array (
                'id' => 21,
                'name' => 'Huyện Cần Giờ',
                'state_id' => 50,
            ),          
            
        ));        
        
    }
}