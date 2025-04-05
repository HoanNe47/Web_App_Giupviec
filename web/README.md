#actcms-spa
# Requirement
```zsh
PHP 7.3 or greater
OpenSSL PHP Extension
PDO PHP Extension
Mbstring PHP Extension
Tokenizer PHP Extension
XML PHP Extension
Ctype PHP Extension
JSON PHP Extension
GD PHP Extension (or Imagick PHP Extension)
PHP Fileinfo extension
PHP Zip Archive
Rewrite Module (Apache or Nginx)
```
# php.ini Requirements
```zsh
open_basedir must be disabled
````
# File and folder permissions
```zsh
/bootstrap 775
/bootstrap 775
````
# Basic Server Setup

# Start prepare the environment:
```zsh
cp .env.example .env // cấu hình database của bạn
php artisan key:generate
php artisan migrate
php artisan db:seed
php artisan migrate:fresh --seed
php artisan storage:link

php artisan config:cache
php artisan cache:clear
php artisan route:clear
php artisan config:clear
php artisan view:clear
php artisan optimize
```