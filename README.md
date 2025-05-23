# Web App Giúp Việc

## Mô tả dự án

Đây là một dự án phát triển **Web App Giúp Việc** giúp người dùng tìm kiếm và đặt dịch vụ giúp việc qua nền tảng web. Dự án được xây dựng với mục tiêu cung cấp một giải pháp đơn giản và hiệu quả cho nhu cầu tìm kiếm dịch vụ giúp việc.

### Mục tiêu
- Cung cấp giao diện dễ sử dụng cho người dùng.
- Quản lý dịch vụ giúp việc.
- Tích hợp chức năng tìm kiếm và đặt lịch cho các dịch vụ giúp việc.
- Đảm bảo tính bảo mật cho người dùng thông qua đăng nhập và đăng ký tài khoản.

---

## Các công nghệ sử dụng

- **Frontend:**
  - HTML
  - CSS
  - JavaScript (JS)
  - **Flutter** (Dùng cho mobile app nếu có)

- **Backend:**
  - **PHP** (Laravel Framework)

- **Cơ sở dữ liệu:**
  - MySQL

- **Công cụ phát triển:**
  - Visual Studio Code
  - Git

---

## Các chức năng chính

1. **Đăng ký và đăng nhập người dùng**
   - Người dùng có thể đăng ký và đăng nhập vào hệ thống để đặt dịch vụ giúp việc.

2. **Quản lý dịch vụ giúp việc**
   - Người quản trị có thể thêm, sửa, và xóa các dịch vụ giúp việc.

3. **Tìm kiếm dịch vụ giúp việc**
   - Người dùng có thể tìm kiếm các dịch vụ theo loại hình, giá cả, khu vực.

4. **Đặt lịch dịch vụ**
   - Người dùng có thể đặt lịch cho dịch vụ giúp việc.

---

## Cài đặt và sử dụng

### Cài đặt cho Laravel (Backend)

1. **Clone repo về máy:**

   ```bash
   git clone https://github.com/HoanNe47/Web_App_Giupviec.git

2. Cài đặt cho Flutter
   flutter clean
   flutter pub cache clean
   flutter pub get
   flutter run
   flutter vesion 3.22.3
3. Cài đặt cho Laravel
   #### Install Dependencies

```zsh
composer install
```

#### Configure the Environment
Create `.env` file:
```zsh
cat .env.example > .env
php artisan key:generate
```
#### Migrate and Seed the Database
```zsh
php artisan migrate
php artisan db:seed

php artisan migrate:fresh --seed
```
#### Command
```zsh
php artisan storage:link
php artisan cache:clear
php artisan route:clear
php artisan config:clear
php artisan view:clear
php artisan key:generate

chmod -R 775 bootstrap/cache/
chmod -R 775 storage/framework/
chmod -R 775 storage/logs/
