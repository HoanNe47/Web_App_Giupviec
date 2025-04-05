<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class CategoriesTableSeeder extends Seeder
{

    /**
     * Auto generated seed file
     *
     * @return void
     */
    public function run()
    {
        

        \DB::table('categories')->delete();
        
        \DB::table('categories')->insert(array (
            0 => 
            array (
                'id' => 1,
                'name' => 'Chăm sóc da mặt',
                'description' => 'Vì môi trường sống ngày càng ô nhiễm, cho nên da của chị em ngày càng bị hư tổn và lão hóa.
                Để khôi phục lại làn da khỏe đẹp của mình, không ít người đã “nhờ cậy” đến các Spa chăm sóc da mặt.
                Chăm sóc da mặt là một trong các gói dịch vụ Spa cơ bản và đông khách nhất hiện nay, bạn đừng bỏ sót dịch vụ này nhé.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 05:22:59',
                'updated_at' => '2022-03-03 05:19:52',
            ),
            1 => 
            array (
                'id' => 2,
                'name' => 'Điều trị mụn, sẹo',
            'description' => 'Mụn là một trong những mối lo vì chúng tạo nên khuyết điểm trên khuôn mặt.
            Điều trị mụn là phương pháp hiệu quả nhất nhằm làm sạch mụn, se khít lỗ chân lông và giảm vết sẹo thâm do mụn để lại.
            Thực sự đây là dịch vụ mà mỗi Spa cần có trong bảng menu vì nhu cầu của khách hàng là rất lớn, kể cả khách hàng là nam giới',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:27:43',
                'updated_at' => '2022-03-03 05:20:38',
            ),
            2 => 
            array (
                'id' => 3,
                'name' => 'Trị thâm, nám, tàn nhang',
                'description' => 'Dịch vụ trị thâm, nám, tàng nhang giúp lấy lại sự tươi trẻ cho làn da, đây là một trong những dịch vụ spa thu hút khách hàng nhất hiện nay bởi nhu cầu là rất lớn.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:29:36',
                'updated_at' => '2022-03-03 05:20:55',
            ),
            3 => 
            array (
                'id' => 4,
                'name' => 'Trẻ hóa da',
                'description' => 'Thông thường một liệu trình dịch vụ trẻ hóa da sẽ bao gồm cả trị sẹo, vết thâm, nám, tàng nhang. Hiệu quả dịch vụ sẽ nhanh chóng và kéo dài tới vài năm. Đây chính là dịch vụ spa mà khách hàng thường hay tìm kiếm, đặc biệt là với nhóm khách hàng trên 30 tuổi.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:39:07',
                'updated_at' => '2022-03-03 05:21:27',
            ),
            4 => 
            array (
                'id' => 5,
                'name' => 'Massage',
                'description' => 'Massage foot và massage body có tác dụng giúp khách hàng giảm đau, thư giãn, xua tan mệt mỏi và căng thẳng, tăng cường hệ miễn dịch.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:39:54',
                'updated_at' => '2022-03-03 05:22:33',
            ),
            5 => 
            array (
                'id' => 6,
                'name' => 'Giảm béo',
                'description' => 'Tăng cân, béo phì là vấn đề mà rất nhiều chị em lo lắng, việc chăm lo cho vóc dáng dường như đã trở thành nhu cầu thiết yếu của con người trong cuộc sống hiện đại.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:40:23',
                'updated_at' => '2022-10-20 06:40:26',
            ),
            6 => 
            array (
                'id' => 7,
                'name' => 'Triệt lông vĩnh viễn',
                'description' => 'Cũng như giảm béo, tẩy lông vĩnh viễn cũng là điều mà chị em phụ nữ rất quan tâm.
                Phái đẹp luôn muốn mình có một thân hình cân đối, một làn da mịn màng để dễ dàng diện những bộ cánh body, cắt xẻ quyến rũ.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:40:59',
                'updated_at' => '2022-10-20 06:41:02',
            ),
            7 => 
            array (
                'id' => 8,
                'name' => 'Tắm trắng',
                'description' => 'Tắm trắng thực sự là mảnh đất “màu mỡ” mà các Spa nên cho vào danh sách menu dịch vụ làm đẹp. Tuy nhiên, đây cũng là dịch vụ Spa đặc biệt cần nhiều đến các thiết bị Spa đắt tiền như: máy tắm trắng phi thuyền, lồng hấp trắng… Cho nên các chủ đầu tư cũng phải bỏ ra vốn đầu tư không hề nhỏ.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:41:17',
                'updated_at' => '2022-10-20 06:41:21',
            ),
            8 => 
            array (
                'id' => 9,
                'name' => 'Tẩy da chết toàn thân',
                'description' => 'Mỗi ngày, cơ thể của bạn thường xuyên phải tiếp xúc với ánh nắng mặt trời, khói bụi, làm cho làn da dần trở nên lão hóa. Trong thời tiết lạnh thì da còn bị khô, tróc vảy khiến việc sử dụng mỹ phẩm kém hiệu quả.',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:41:17',
                'updated_at' => '2022-10-20 06:41:21',
            ),
            9 => 
            array (
                'id' => 10,
                'name' => 'Phun xăm thẩm mỹ',
                'description' => 'Sở hữu đôi lông mày cân đối, sắc nét, đôi môi căng mọng là mơ ước của rất nhiều chị em. Bạn đừng bỏ qua phun xăm thẩm mỹ trong bảng menu dịch vụ spa của mình nhé',
                'color' => '#cc0099',
                'status' => 1,
                'is_featured' => 1,
                'deleted_at' => NULL,
                'created_at' => '2022-10-20 06:41:17',
                'updated_at' => '2022-10-20 06:41:21',
            )
        ));
        
        
    }
}