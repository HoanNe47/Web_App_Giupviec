<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class ServicesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('services')->delete();
        
        \DB::table('services')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Chăm sóc da mặt thư giãn',
                'category_id' => 1,
                'provider_id' => 4,
                'price' => 150000,
                'type' => 'hourly',
                'duration' => '01:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Vì môi trường sống ngày càng ô nhiễm, cho nên da của chị em ngày càng bị hư tổn và lão hóa.',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 06:36:09',
                'updated_at' => '2022-02-23 10:08:03',
                'subcategory_id' => NULL,
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Hút chì thải độc tố, thanh tẩy làn da',
                'category_id' => 1,
                'provider_id' => 4,
                'price' => 150000,
                'type' => 'hourly',
                'duration' => '01:00',
                'discount' => NULL,
                'status' => 1,
                'description' => 'Để khôi phục lại làn da khỏe đẹp của mình, không ít người đã “nhờ cậy” đến các Spa chăm sóc da mặt.',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 06:51:09',
                'updated_at' => '2022-02-23 10:08:18',
                'subcategory_id' => NULL,
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Chăm sóc da với bộ mỹ phẩm Pháp Leclub',
                'category_id' => 1,
                'provider_id' => 4,
                'price' => 250000,
                'type' => 'hourly',
                'duration' => '01:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Chăm sóc da mặt là một trong các gói dịch vụ Spa cơ bản và đông khách nhất hiện nay, bạn đừng bỏ sót dịch vụ này nhé.',
                'is_featured' => 1,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 06:53:58',
                'updated_at' => '2022-02-23 11:55:47',
                'subcategory_id' => NULL,
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Trị mụn cơ bản',
                'category_id' => 2,
                'provider_id' => 4,
                'price' => 150000,
                'type' => 'fixed',
                'duration' => '01:00',
                'discount' => NULL,
                'status' => 1,
                'description' => 'Mụn là một trong những mối lo vì chúng tạo nên khuyết điểm trên khuôn mặt.',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 06:56:19',
                'updated_at' => '2022-02-23 10:08:36',
                'subcategory_id' => NULL,
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Trị mụn chuyên sâu cùng Oxyjet',
                'category_id' => 2,
                'provider_id' => 4,
                'price' => 350000,
                'type' => 'fixed',
                'duration' => '01:30',
                'discount' => 20.0,
                'status' => 1,
                'description' => 'Điều trị mụn là phương pháp hiệu quả nhất nhằm làm sạch mụn, se khít lỗ chân lông và giảm vết sẹo thâm do mụn để lại.',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 07:04:40',
                'updated_at' => '2022-02-23 11:54:45',
                'subcategory_id' => NULL,
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'Trị mụn công nghệ cao cùng CO2 DJ Carbon',
                'category_id' => 2,
                'provider_id' => 4,
                'price' => 600000,
                'type' => 'fixed',
                'duration' => '02:00',
                'discount' => 0.0,
                'status' => 1,
                'description' => 'Thực sự đây là dịch vụ mà mỗi Spa cần có trong bảng menu vì nhu cầu của khách hàng là rất lớn, kể cả khách hàng là nam giới.',
                'is_featured' => 1,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-02-23 07:08:26',
                'updated_at' => '2022-03-04 04:52:22',
                'subcategory_id' => NULL,
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'Trị nám cùng công nghệ Laser',
                'category_id' => 3,
                'provider_id' => 4,
                'price' => 1500000,
                'type' => 'fixed',
                'duration' => '2:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => NULL,
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-03-02 09:02:29',
                'updated_at' => '2022-03-02 09:02:29',
                'subcategory_id' => NULL,
            ),
            7 => 
            array (
                'id' => 8,
                'name' => 'Tiêm Mesotox + Nano với mỹ phầm Hàn Quốc',
                'category_id' => 3,
                'provider_id' => 4,
                'price' => 3000000,
                'type' => 'fixed',
                'duration' => '02:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Trắng sản da, tăng sinh Collagen, trẻ hóa da, chống lão hóa',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-03-02 09:15:59',
                'updated_at' => '2022-03-02 09:15:59',
                'subcategory_id' => NULL,
            ),
            8 => 
            array (
                'id' => 9,
                'name' => 'Phi kim nhừa thâm, trị sẹo, se khít lỗ chân lông',
                'category_id' => 4,
                'provider_id' => 4,
                'price' => 1500000,
                'type' => 'fixed',
                'duration' => '01:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Phi kim nhừa thâm, trị sẹo, se khít lỗ chân lông',
                'is_featured' => 1,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-03-02 09:49:22',
                'updated_at' => '2022-03-02 09:49:22',
                'subcategory_id' => NULL,
            ),
            9 => 
            array (
                'id' => 10,
                'name' => 'Massage body thư giãn',
                'category_id' => 4,
                'provider_id' => 4,
                'price' => 250000,
                'type' => 'hourly',
                'duration' => '01:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Massage foot và massage body có tác dụng giúp khách hàng giảm đau, thư giãn, xua tan mệt mỏi và căng thẳng, tăng cường hệ miễn dịch',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-03-02 10:04:25',
                'updated_at' => '2022-03-02 10:04:25',
                'subcategory_id' => NULL,
            ),
            10 => 
            array (
                'id' => 11,
                'name' => 'Giảm béo cùng công nghệ Cavitation-RF',
                'category_id' => 5,
                'provider_id' => 4,
                'price' => 600000,
                'type' => 'fixed',
                'duration' => '02:00',
                'discount' => 10.0,
                'status' => 1,
                'description' => 'Tăng cân, béo phì là vấn đề mà rất nhiều chị em lo lắng, việc chăm lo cho vóc dáng dường như đã trở thành nhu cầu thiết yếu của con người trong cuộc sống hiện đại.',
                'is_featured' => 0,
                'added_by' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-03-02 10:04:25',
                'updated_at' => '2022-03-02 10:04:25',
                'subcategory_id' => NULL,
            ),
        ));
        
        
    }
}