<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class StatesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('states')->delete();
        
        \DB::table('states')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Hà Nội',
                'country_id' => 1,
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Hà Giang',
                'country_id' => 1,
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Cao Bằng',
                'country_id' => 1,
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Bắc Kạn',
                'country_id' => 1,
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Tuyên Quang',
                'country_id' => 1,
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'Lào Cai',
                'country_id' => 1,
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'Điện Biên',
                'country_id' => 1,
            ),
            7 => 
            array (
                'id' => 8,
                'name' => 'Lai Châu',
                'country_id' => 1,
            ),
            8 => 
            array (
                'id' => 9,
                'name' => 'Sơn La',
                'country_id' => 1,
            ),
            9 => 
            array (
                'id' => 10,
                'name' => 'Yên Bái',
                'country_id' => 1,
            ),
            10 => 
            array (
                'id' => 11,
                'name' => 'Hòa Bình',
                'country_id' => 1,
            ),
            11 => 
            array (
                'id' => 12,
                'name' => 'Thái Nguyên',
                'country_id' => 1,
            ),
            12 => 
            array (
                'id' => 13,
                'name' => 'Lạng Sơn',
                'country_id' => 1,
            ),
            13 => 
            array (
                'id' => 14,
                'name' => 'Quảng Ninh Pradesh',
                'country_id' => 1,
            ),
            14 => 
            array (
                'id' => 15,
                'name' => 'Bắc Giang',
                'country_id' => 1,
            ),
            15 => 
            array (
                'id' => 16,
                'name' => 'Phú Thọ',
                'country_id' => 1,
            ),
            16 => 
            array (
                'id' => 17,
                'name' => 'Vĩnh Phúc',
                'country_id' => 1,
            ),
            17 => 
            array (
                'id' => 18,
                'name' => 'Bắc Ninh',
                'country_id' => 1,
            ),
            18 => 
            array (
                'id' => 19,
                'name' => 'Hải Dương',
                'country_id' => 1,
            ),
            19 => 
            array (
                'id' => 20,
                'name' => 'Hải Phòng',
                'country_id' => 1,
            ),
            20 => 
            array (
                'id' => 21,
                'name' => 'Hưng Yên',
                'country_id' => 1,
            ),
            21 => 
            array (
                'id' => 22,
                'name' => 'Thái Bình',
                'country_id' => 1,
            ),
            22 => 
            array (
                'id' => 23,
                'name' => 'Hà Nam',
                'country_id' => 1,
            ),
            23 => 
            array (
                'id' => 24,
                'name' => 'Nam Định',
                'country_id' => 1,
            ),
            24 => 
            array (
                'id' => 25,
                'name' => 'Ninh Bình',
                'country_id' => 1,
            ),
            25 => 
            array (
                'id' => 26,
                'name' => 'Thanh Hóa',
                'country_id' => 1,
            ),
            26 => 
            array (
                'id' => 27,
                'name' => 'Nghệ An',
                'country_id' => 1,
            ),
            27 => 
            array (
                'id' => 28,
                'name' => 'Hà Tĩnh',
                'country_id' => 1,
            ),
            28 => 
            array (
                'id' => 29,
                'name' => 'Quảng Bình',
                'country_id' => 1,
            ),
            29 => 
            array (
                'id' => 30,
                'name' => 'Quảng Trị',
                'country_id' => 1,
            ),
            30 => 
            array (
                'id' => 31,
                'name' => 'Thừa Thiên Huế',
                'country_id' => 1,
            ),
            31 => 
            array (
                'id' => 32,
                'name' => 'Đà Nẵng',
                'country_id' => 1,
            ),
            32 => 
            array (
                'id' => 33,
                'name' => 'Quảng Nam',
                'country_id' => 1,
            ),
            33 => 
            array (
                'id' => 34,
                'name' => 'Quảng Ngãi',
                'country_id' => 1,
            ),
            34 => 
            array (
                'id' => 35,
                'name' => 'Bình Định',
                'country_id' => 1,
            ),
            35 => 
            array (
                'id' => 36,
                'name' => 'Phú Yên',
                'country_id' => 1,
            ),
            36 => 
            array (
                'id' => 37,
                'name' => 'Khánh Hòa',
                'country_id' => 1,
            ),
            37 => 
            array (
                'id' => 38,
                'name' => 'Ninh Thuận',
                'country_id' => 1,
            ),
            38 => 
            array (
                'id' => 39,
                'name' => 'Bình Thuận',
                'country_id' => 1,
            ),
            39 => 
            array (
                'id' => 40,
                'name' => 'Kon Tum',
                'country_id' => 1,
            ),
            40 => 
            array (
                'id' => 41,
                'name' => 'Gia Lai',
                'country_id' => 1,
            ),
            41 => 
            array (
                'id' => 42,
                'name' => 'Đắk Lắk',
                'country_id' => 1,
            ),
            42 => 
            array (
                'id' => 43,
                'name' => 'Đắk Nông',
                'country_id' => 1,
            ),
            43 => 
            array (
                'id' => 44,
                'name' => 'Lâm Đồng',
                'country_id' => 1,
            ),
            44 => 
            array (
                'id' => 45,
                'name' => 'Bình Phước',
                'country_id' => 1,
            ),
            45 => 
            array (
                'id' => 46,
                'name' => 'Tây Ninh',
                'country_id' => 1,
            ),
            46 => 
            array (
                'id' => 47,
                'name' => 'Bình Dương',
                'country_id' => 1,
            ),
            47 => 
            array (
                'id' => 48,
                'name' => 'Đồng Nai',
                'country_id' => 1,
            ),
            48 => 
            array (
                'id' => 49,
                'name' => 'Bà Rịa - Vũng Tàu',
                'country_id' => 1,
            ),
            49 => 
            array (
                'id' => 50,
                'name' => 'Hồ Chí Minh',
                'country_id' => 1,
            ),
            50 => 
            array (
                'id' => 51,
                'name' => 'Long An',
                'country_id' => 1,
            ),
            51 => 
            array (
                'id' => 52,
                'name' => 'Tiền Giang',
                'country_id' => 1,
            ),
            52 => 
            array (
                'id' => 53,
                'name' => 'Bến Tre',
                'country_id' => 1,
            ),
            53 => 
            array (
                'id' => 54,
                'name' => 'Trà Vinh',
                'country_id' => 1,
            ),
            54 => 
            array (
                'id' => 55,
                'name' => 'Vĩnh Long',
                'country_id' => 1,
            ),
            55 => 
            array (
                'id' => 56,
                'name' => 'Đồng Tháp',
                'country_id' => 1,
            ),
            56 => 
            array (
                'id' => 57,
                'name' => 'An Giang',
                'country_id' => 1,
            ),
            57 => 
            array (
                'id' => 58,
                'name' => 'Kiên Giang',
                'country_id' => 1,
            ),
            58 => 
            array (
                'id' => 59,
                'name' => 'Cần Thơ',
                'country_id' => 1,
            ),
            59 => 
            array (
                'id' => 60,
                'name' => 'Hậu Giang',
                'country_id' => 1,
            ),
            60 => 
            array (
                'id' => 61,
                'name' => 'Sóc Trăng',
                'country_id' => 1,
            ),
            61 => 
            array (
                'id' => 62,
                'name' => 'Bạc Liêu',
                'country_id' => 1,
            ),
            62 => 
            array (
                'id' => 63,
                'name' => 'Cà Mau',
                'country_id' => 1,
            ),
        ));
        
        
    }
}