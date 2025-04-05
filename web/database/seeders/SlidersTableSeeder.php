<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class SlidersTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('sliders')->delete();
        
        \DB::table('sliders')->insert(array (
            0 => 
            array (
                'created_at' => '2022-02-23 09:05:27',
                'deleted_at' => NULL,
                'description' => NULL,
                'id' => 1,
                'status' => 1,
                'title' => 'Cùng Spa đẹp rạng ngời như những đóa hoa',
                'type' => 'service',
                'type_id' => '1',
                'updated_at' => '2022-02-23 09:16:33',
            ),
            1 => 
            array (
                'created_at' => '2022-02-23 09:21:08',
                'deleted_at' => NULL,
                'description' => NULL,
                'id' => 2,
                'status' => 1,
                'title' => 'Diện mạo như ý, không lo chi phí',
                'type' => 'service',
                'type_id' => '2',
                'updated_at' => '2022-02-23 09:21:08',
            ),
            2 => 
            array (
                'created_at' => '2022-02-23 09:23:23',
                'deleted_at' => NULL,
                'description' => NULL,
                'id' => 3,
                'status' => 1,
                'title' => 'Thẩm mỹ uy tín - Hàng đầu Việt Nam',
                'type' => 'service',
                'type_id' => '3',
                'updated_at' => '2022-02-23 09:23:23',
            ),
            3 => 
            array (
                'created_at' => '2022-02-23 09:25:11',
                'deleted_at' => NULL,
                'description' => NULL,
                'id' => 4,
                'status' => 1,
                'title' => 'Độc quyền với công nghệ Plasma lạnh',
                'type' => 'service',
                'type_id' => '4',
                'updated_at' => '2022-02-23 09:25:11',
            ),
        ));
        
        
    }
}