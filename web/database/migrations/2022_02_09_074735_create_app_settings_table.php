<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_settings', function (Blueprint $table) {
            $table->id();
            $table->string('site_name')->nullable()->default(null);
            $table->string('site_email')->nullable()->default(null);
            $table->string('site_logo')->nullable()->default(null);
            $table->string('site_favicon')->nullable()->default(null);
            $table->longText('site_description')->nullable()->default(null);
            $table->string('site_copyright')->nullable()->default(null);
            $table->string('facebook_url')->nullable()->default(null);
            $table->string('instagram_url')->nullable()->default(null);
            $table->string('twitter_url')->nullable()->default(null);
            $table->string('youtube_url')->nullable();
            $table->string('linkedin_url')->nullable()->default(null);
            $table->string('remember_token')->nullable()->default(null);
            $table->string('inquriy_email')->nullable()->default(null);
            $table->string('helpline_number')->nullable()->default(null);
            $table->string('time_zone')->nullable()->default(null);
            $table->string('earning_type')->nullable()->default(null);
            $table->text('language_option')->nullable();
        });

        // Insert some stuff
        $rows = DB::table('app_settings')->get(['id','language_option']);
        foreach ($rows as $row) {
            DB::table('app_settings')
                ->where('id', $row->id)
                ->update(['language_option' => '["en","vi"]' ]);
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('app_settings');
    }
}
