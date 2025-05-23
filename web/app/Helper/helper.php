<?php
use \Illuminate\Support\Facades\File;
function authSession($force=false){
    $session = new \App\Models\User;
    if($force){
        $user = \Auth::user()->getRoleNames();
        \Session::put('auth_user',$user);
        $session = \Session::get('auth_user');
        return $session;
    }
    if(\Session::has('auth_user')){
        $session = \Session::get('auth_user');
    }else{
        $user = \Auth::user();
        \Session::put('auth_user',$user);
        $session = \Session::get('auth_user');
    }
    return $session;
}

function comman_message_response( $message, $status_code = 200)
{
	return response()->json( [ 'message' => $message ], $status_code );
}

function comman_custom_response( $response, $status_code = 200 )
{
    return response()->json($response,$status_code);
}

function comman_list_response( $data )
{
    return response()->json(['data' => $data]);
}


function checkMenuRoleAndPermission($menu)
{
    if (\Auth::check()) {
        if ($menu->data('role') == null && auth()->user()->hasRole('admin')) {
            return true;
        }

        if($menu->data('permission') == null && $menu->data('role') == null) {
            return true;
        }

        if($menu->data('role') != null) {
            if(auth()->user()->hasAnyRole(explode(',', $menu->data('role')))) {
                return true;
            }
        }

        if($menu->data('permission') != null) {
            if(auth()->user()->can($menu->data('permission')) ) {
                return true;
            }
        }
    }

    return false;
}


function checkRolePermission($role,$permission){
    try{
        if($role->hasPermissionTo($permission)){
            return true;
        }
        return false;
    }catch (Exception $e){
        return false;
    }
}

function demoUserPermission(){
    if(\Auth::user()->hasAnyRole(['demo_admin'])){
        return true;
    }else{
        return false;
    }
}

function getSingleMedia($model, $collection = 'profile_image', $skip=true   )
{
    if (!\Auth::check() && $skip) {
        return asset('images/user/user.png');
    }
    $media = null;
    if ($model !== null) {
        $media = $model->getFirstMedia($collection);
    }

    if (getFileExistsCheck($media)) {
        return $media->getFullUrl();
    }else{

        switch ($collection) {
            case 'image_icon':
                $media = asset('images/user/user.png');
                break;
            case 'profile_image':
                $media = asset('images/user/user.png');
                break;
            case 'service_attachment':
                $media = asset('images/default.png');
                break;
            case 'site_logo':
                $media = asset('images/logo.png');
                break;
            case 'site_favicon':
                $media = asset('images/favicon.png');
                break;

            default:
                $media = asset('images/default.png');
                break;
        }
        return $media;
    }
}

function getFileExistsCheck($media)
{
    $mediaCondition = false;

    if($media) {
        if($media->disk == 'public') {
            $mediaCondition = file_exists($media->getPath());
        } else {
            $mediaCondition = \Storage::disk($media->disk)->exists($media->getPath());
        }
    }

    return $mediaCondition;
}

function storeMediaFile($model,$file,$name)
{
    if($file) {
        if( !in_array($name, ['service_attachment'])){
            $model->clearMediaCollection($name);
        }
        if (is_array($file)){
            foreach ($file as $key => $value){
                $model->addMedia($value)->toMediaCollection($name);
            }
        }else{
            $model->addMedia($file)->toMediaCollection($name);
        }
    }

    return true;
}

function getAttachments($attchments)
{
    $files = [];
    if (count($attchments) > 0) {
        foreach ($attchments as $attchment) {
            if (getFileExistsCheck($attchment)) {
                array_push($files, $attchment->getFullUrl());
            }
        }
    }

    return $files;
}
function getAttachmentArray($attchments)
{
    $files = [];
    if (count($attchments) > 0) {
        foreach ($attchments as $attchment) {
            if (getFileExistsCheck($attchment)) {
                $file = [
                    'id' => $attchment->id,
                    'url'=> $attchment->getFullUrl()
                ];
                array_push($files, $file);
            }
        }
    }

    return $files;
}
function getMediaFileExit($model, $collection = 'profile_image')
{
    if($model==null){
        return asset('images/user/user.png');;
    }

    $media = $model->getFirstMedia($collection);

    return getFileExistsCheck($media);
}

function activeRoute($route, $isClass = false): string
{
    $requestUrl = request()->is($route);

    if($isClass) {
        return $requestUrl ? $isClass : '';
    } else {
        return $requestUrl ? 'active' : '';
    }
}

function saveBookingActivity($data)
{
    $admin = \App\Models\AppSetting::first();
    date_default_timezone_set( $admin->time_zone ?? 'UTC');
    $data['datetime'] = date('Y-m-d H:i:s');
    $role = auth()->user()->user_type;
    switch ($data['activity_type'])
    {
        case "add_booking":
                $data['activity_message'] = __('messages.booking_added');
                $data['activity_type'] = __('messages.add_booking');
                $activity_data = [
                    'service_id' => $data['booking']->service_id,
                    'service_name' => isset($data['booking']->service) ? $data['booking']->service->name : '',
                    'customer_id' => $data['booking']->customer_id,
                    'customer_name' => isset($data['booking']->customer) ? $data['booking']->customer->display_name : '',
                    'provider_id' => $data['booking']->provider_id,
                    'provider_name' => isset($data['booking']->provider) ? $data['booking']->provider->display_name : '',
                ];
                $sendTo = ['admin' , 'provider'];
            break;
        case "assigned_booking":
                $assigned_handyman = handymanNames($data['booking']->handymanAdded);
                $data['activity_message'] = __('messages.booking_assigned',['name' => $assigned_handyman]);
                $data['activity_type'] = __('messages.assigned_booking');
                
                $activity_data = [
                    'handyman_id' => $data['booking']->handymanAdded->pluck('handyman_id'),
                    'handyman_name' => $data['booking']->handymanAdded,
                ];
                $sendTo = ['handyman'];
                break;

        case "transfer_booking":
                $assigned_handyman = handymanNames($data['booking']->handymanAdded);

                $data['activity_type'] = __('messages.transfer_booking');
                $data['activity_message'] = __('messages.booking_transfer',['name' => $assigned_handyman]);
                $activity_data = [
                    'handyman_id' => $data['booking']->handymanAdded->pluck('handyman_id'),
                    'handyman_name' => $data['booking']->handymanAdded,
                ];
                $sendTo = ['handyman'];
            break;

        case "update_booking_status":

                $status = \App\Models\BookingStatus::bookingStatus($data['booking']->status);
                $old_status = \App\Models\BookingStatus::bookingStatus($data['booking']->old_status);
                $data['activity_type'] = __('messages.update_booking_status');
                $data['activity_message'] = __('messages.booking_status_update',[ 'from' => $old_status , 'to' => $status ]);
                $activity_data = [
                    'reason' => $data['booking']->reason,
                    'status' => $data['booking']->status,
                    'status_label' => $status,
                    'old_status' => $data['booking']->old_status,
                    'old_status_label' => $old_status,
                ];

                $sendTo = removeArrayValue(['admin', 'provider' , 'handyman' , 'user'],$role);
            break;
        case "cancel_booking":
            $status = \App\Models\BookingStatus::bookingStatus($data['booking']->status);
            $old_status = \App\Models\BookingStatus::bookingStatus($data['booking']->old_status);
            $data['activity_type'] = __('messages.cancel_booking');

            $data['activity_message'] = __('messages.cancel_booking');
            $activity_data = [
                'reason' => $data['booking']->reason,
                'status' => $data['booking']->status,
                'status_label' => \App\Models\BookingStatus::bookingStatus($data['booking']->status),
            ];
            $sendTo = removeArrayValue(['admin', 'provider' , 'handyman' , 'user'],$role);
        break;
        case "payment_message_status" :
            $data['activity_type'] = __('messages.payment_message_status');

            $data['activity_message'] = __('messages.payment_message',['status' => $data['payment_status'] ]);

            $activity_data = [
                'activity_type' => $data['activity_type'],
                'payment_status'=> $data['payment_status'],
                'booking_id' => $data['booking_id'],
            ];
            $sendTo = ['user'];
        break;

        default :
            $activity_data = [];
            break;
    }
    $data['activity_data'] = json_encode($activity_data);
    \App\Models\BookingActivity::create($data);
    $notification_data = [
        'id'   => $data['booking']->id,
        'type' => $data['activity_type'],
        'subject' => $data['activity_type'],
        'message' => $data['activity_message'],
        "ios_badgeType"=>"Increase",
        "ios_badgeCount"=> 1
    ];
    foreach($sendTo as $to){
        switch ($to)
        {
            case 'admin':
                $user = \App\Models\User::getUserByKeyValue('user_type','admin');
                break;
            case 'provider':
                $user = \App\Models\User::getUserByKeyValue( 'id', $data['booking']->provider_id );
                break;
            case 'handyman':
                $handymans = $data['booking']->handymanAdded->pluck('handyman_id');
                foreach($handymans as $id)
                {
                    $user = \App\Models\User::getUserByKeyValue( 'id', $id );
                    sendNotification('provider',$user,$notification_data);
                }
                break;
            case 'user':
                    $user = \App\Models\User::getUserByKeyValue( 'id', $data['booking']->customer_id );
                break;
        }
        if($to != 'handyman' ) {
            sendNotification($to,$user,$notification_data);
        }
    }

}

function settingSession($type='get'){
    if(\Session::get('setting_data') == ''){
        $type='set';
    }
    switch ($type){
        case "set" :
            $settings = \App\Models\AppSetting::first();
            \Session::put('setting_data',$settings);
            Cache::flush();
            break;
        default :
            break;
    }
    return \Session::get('setting_data');
}

function envChanges($type,$value){
    $path = base_path('.env');

    $checkType = $type.'="';
    if(strpos($value,' ') || strpos(file_get_contents($path),$checkType) || preg_match('/[\'^£$%&*()}{@#~?><>,|=_+¬-]/', $value)){
        $value = '"'.$value.'"';
    }

    $value = str_replace('\\', '\\\\', $value);

    if (file_exists($path)) {
        $typeValue = env($type);

        if(strpos(env($type),' ') || strpos(file_get_contents($path),$checkType)){
            $typeValue = '"'.env($type).'"';
        }

        file_put_contents($path, str_replace(
            $type.'='.$typeValue, $type.'='.$value, file_get_contents($path)
        ));

        $onesignal = collect(config('constant.ONESIGNAL'))->keys();

        $checkArray = \Arr::collapse([$onesignal,['DEFAULT_LANGUAGE']]);


        if( in_array( $type ,$checkArray) ){
            if(env($type) === null){
                file_put_contents($path,"\n".$type.'='.$value ,FILE_APPEND);
            }
        }
    }
}

function getPriceFormat($price){
    if (gettype($price) == 'string') {
        return $price;
    }
    if($price == null){
        return 0;
    }
    $currency_symbol = \App\Models\Setting::where('type','CURRENCY')->where('key','CURRENCY_COUNTRY_ID')->with('country')->first();
    $symbol = 'đ';
    if(!empty($currency_symbol))
    {
        $symbol = $currency_symbol->country->symbol;
    }
    $currency_position = \App\Models\Setting::where('type','CURRENCY')->where('key','CURRENCY_POSITION')->first();
    $position = 'right';
    if( !empty($currency_position) ){
        $position = $currency_position->value;
    }

    if ($position == 'left') {
        $price = $symbol."".number_format((float)$price,0, '', ',');
    } else {
        $price = number_format((float)$price,0, '', ',')."".$symbol;
    }

    return $price;
}
function payment_status(){

    return [
        'pending' => __('messages.pending'),
        'paid' => __('messages.paid'),
        'failed' => __('messages.failed'),
        'refunded' => __('messages.refunded')
    ];
}

function formatOffset($offset)
{
    $hours = $offset / 3600;
    $remainder = $offset % 3600;
    $sign = $hours > 0 ? '+' : '-';
    $hour = (int) abs($hours);
    $minutes = (int) abs($remainder / 60);

    if ($hour == 0 and $minutes == 0) {
        $sign = ' ';
    }
    return 'GMT' . $sign . str_pad($hour, 2, '0', STR_PAD_LEFT)
        . ':' . str_pad($minutes, 2, '0');
}

function timeZoneList()
{
    $list = \DateTimeZone::listAbbreviations();
    $idents = \DateTimeZone::listIdentifiers();

    $data = $offset = $added = array();
    foreach ($list as $abbr => $info) {
        foreach ($info as $zone) {
            if (!empty($zone['timezone_id']) and !in_array($zone['timezone_id'], $added) and in_array($zone['timezone_id'], $idents)) {

                $z = new \DateTimeZone($zone['timezone_id']);
                $c = new \DateTime(null, $z);
                $zone['time'] = $c->format('H:i a');
                $offset[] = $zone['offset'] = $z->getOffset($c);
                $data[] = $zone;
                $added[] = $zone['timezone_id'];
            }
        }
    }

    array_multisort($offset, SORT_ASC, $data);
    $options = array();
    foreach ($data as $key => $row) {

        $options[$row['timezone_id']] = $row['time'] . ' - ' . formatOffset($row['offset'])  . ' ' . $row['timezone_id'];
    }
    $options['Asia/Ho_Chi_Minh'] = '7:00 pm -  GMT+07:00 Asia/Ho_Chi_Minh';
    return $options;
}

function stringLong($str = '', $type = 'title', $length = 0) //Add … if string is too long
{
    if ($length != 0) {
        return strlen($str) > $length ? substr($str, 0, $length) . "..." : $str;
    }
    if ($type == 'desc') {
        return strlen($str) > 150 ? substr($str, 0, 150) . "..." : $str;
    } elseif ($type == 'title') {
        return strlen($str) > 15 ? substr($str, 0, 25) . "..." : $str;
    } else {
        return $str;
    }

}
function dateAgoFormate($date,$type2='')
{
    if($date==null || $date=='0000-00-00 00:00:00'){
        return '-';
    }

    $diff_time1= \Carbon\Carbon::createFromTimeStamp(strtotime($date))->diffForHumans();
    $datetime = new \DateTime($date);
    $la_time = new \DateTimeZone(\Auth::check() ? \Auth::user()->time_zone ?? 'Asia/Ho_Chi_Minh' : 'Asia/Ho_Chi_Minh');
    $datetime->setTimezone($la_time);
    $diff_date= $datetime->format('Y-m-d H:i:s');

    $diff_time= \Carbon\Carbon::parse($diff_date)->isoFormat('LLL');

    if($type2 != ''){
        return $diff_time;
    }

    return $diff_time1 .' on '.$diff_time;
}

function timeAgoFormate($date)
{
    if($date==null){
        return '-';
    }

    // date_default_timezone_set('UTC');

    $diff_time= \Carbon\Carbon::createFromTimeStamp(strtotime($date))->diffForHumans();

    return $diff_time;
}

function duration($start ='' , $end='' ,$type = '')
{
    $start = \Carbon\Carbon::parse($start);
    $end = \Carbon\Carbon::parse($end);

    if($type){
        $diff_in_minutes = $start->diffInMinutes($end);
        return $diff_in_minutes;
    }else{
        $diff = $start->diff($end);
        return $diff->format('%H:%I');
    }
}

function removeArrayValue($array = [],$find)
{
    foreach (array_keys($array, $find) as $key) {
        unset($array[$key]);
    }

    return array_values($array);
}

function handymanNames($collection)
{
    return $collection->mapWithKeys(function ($item) {
        return [$item->handyman_id => optional($item->handyman)->display_name];
    })->values()->implode(',');
}

function languagesArray($ids = [])
{
    $language = [
        [ 'title' => 'Vietnamese' , 'id' => 'vi'],
        [ 'title' => 'English' , 'id' => 'en']
    ];
    if(!empty($ids))
    {
        $language = collect($language)->whereIn('id',$ids)->values();
    }
    return $language;
}
function replaceJsonString($replace_from,$replace_to,$input)
{
    $result="";

    for($i=0;$i<strlen($input);$i++)
    {
        $result.= ($input[$i]==$replace_from)?$replace_to:$input[$i];
    }

    return $result;
}
function flattenToMultiDimensional(array $array, $delimiter = '.')
{
    $result = [];
    foreach ($array as $notations => $value) {
        // extract keys
        $keys = explode($delimiter, $notations);
        // reverse keys for assignments
        $keys = array_reverse($keys);

        // set initial value
        $lastVal = $value;
        foreach ($keys as $key) {
            // wrap value with key over each iteration
            $lastVal = [
                $key => $lastVal
            ];
        }

        // merge result
        $result = array_merge_recursive($result, $lastVal);
    }

    return $result;
}
function createLangFile($lang=''){
    $langDir = resource_path().'/lang/';
    $viDir = $langDir.'vi';
    $currentLang = $langDir . $lang;
    if(!File::exists($currentLang)){
       File::makeDirectory($currentLang);
       File::copyDirectory($viDir,$currentLang);
    }
}
function convertToHoursMins($time, $format = '%02d:%02d') {
    if ($time < 1) {
        return sprintf($format, 0, 0);
    }
    $hours = floor($time / 60);
    $minutes = ($time % 60);
    return sprintf($format, $hours, $minutes);
}

function getSettingKeyValue($type="",$key=""){
    $setting_data = \App\Models\Setting::where('type',$type)->where('key',$key)->first();
    if($setting_data != null)
    {
        return $setting_data->value;
    } else {


        switch ($key) {
            case 'DISTANCE_TYPE':
                return 'km';
                break;
            case 'DISTANCE_RADIOUS':
                return 50;
                break;
            default:
                break;
        }

    }
}

function countUnitvalue($unit){
   switch ($unit) {
       case 'mile':
           return 3956;
           break;
       default:
           return 6371;
           break;
   }
}

function imageExtention($media)
{
    $extention = null;
    if($media != null){
        $path_info = pathinfo($media);
        $extention = $path_info['extension'];
    }
    return $extention;
}

function verify_provider_document($provider_id)
{
    $documents = \App\Models\Documents::where('is_required',1)->where('status', 1)->withCount([
        'providerDocument',
        'providerDocument as is_verified_document' => function ($query) use($provider_id) {
            $query->where('is_verified', 1)->where('provider_id', $provider_id);
        }])
    ->get();

    $is_verified = $documents->where('is_verified_document', 1);

    if(count($documents) == count($is_verified))
    {
        return true;
    } else {
        return false;
    }
}
function format_number_field($value){

    if($value !== 0){
        return getPriceFormat($value);
    }

    return 0;
}
function format_commission($value){
    // if($value == 0){
    //     return '';
    // }
    if($value != null){
        $commission_value = optional($value->providertype)->commission;
        $commission_type = optional($value->providertype)->type;

        $commission = getPriceFormat($commission_value);
        if($commission_type === 'percent'){
            $commission = $commission_value . '%';
        }

        return $commission;

    }
}

function calculate_commission($total_amount = 0,$provider_commission = 0, $commission_type = 'percent',$type = '', $totalEarning = 0,$count=0){
    if($total_amount === 0){
        return [
            'value' => '-',
            'number_format' => 0
          ];
    }
    switch ($type) {
      case 'provider':
          $earning =   ($total_amount) - ($provider_commission * $count);
          if($commission_type === 'percent'){
              $earning =  ($total_amount) * $provider_commission / 100;
          }
          $final_amount = $earning - $totalEarning;
          break;
      default:
          $earning =  $provider_commission * $count ;
          if($commission_type === 'percent'){
              $earning = ($total_amount) * (100 - $provider_commission) / 100;
          }
          $final_amount = $earning;
          break;
    }
    return [
        'value' => getPriceFormat($final_amount),
        'number_format' => $final_amount
      ];
}

function get_provider_commission($bookings) {
      $all_booking_total = $bookings->map(function ($booking) {
          return $booking->total_amount;
      })->toArray();

      $all_booking_tax = $bookings->map(function ($booking) {
          return $booking->getTaxesValue();
      })->toArray();

      $total = array_reduce($all_booking_total, function ($value1, $value2) {
          return $value1 + $value2;
      }, 0);

      $tax = array_reduce($all_booking_tax, function ($tax1, $tax2) {
          return $tax1 + $tax2;
      }, 0);

      $total_amount = $total;

      return [
          'total_amount' => $total_amount,
          'tax' => $tax,
          'total' => $total,
          'all_booking_tax' => $all_booking_tax,
          'all_booking_total' => $all_booking_total,
      ];
}
function get_handyman_provider_commission($handyman_id){
    $hadnymantype_id = !empty($handyman_id) ?$handyman_id : 1;
    $get_commission = \App\Models\HandymanType::withTrashed()->where('id',$hadnymantype_id)->first();
    if($get_commission){
        $commission_value = $get_commission->commission;
        $commission_type = $get_commission->type;

        $commission = getPriceFormat($commission_value);
        if($commission_type === 'percent'){
            $commission = $commission_value . '%';
        }

        return $commission;
    }
    return '-';
}
function adminEarning(){
    $revenuedata= \App\Models\Payment::selectRaw('sum(total_amount) as total , booking_id, DATE_FORMAT(datetime , "%m") as month' )
    ->whereYear('datetime',date('Y'))
    ->where('payment_status','paid')
    ->groupBy('month');
    $revenuedata = $revenuedata->get()->toArray();
    foreach ($revenuedata as $key => $value) {
       $total_amount = $value['total'];
       $booking  =  \App\Models\Booking::where('id',$value['booking_id'])->first();
       if(!empty($booking)){
        $provider = App\Models\User::where('id',$booking->provider_id)->first();
        $provider_commission = optional($provider->providertype)->commission;
        $provider_type = optional($provider->providertype)->type;
        $earning =   ($total_amount) - ($provider_commission );
        if($provider_type === 'percent'){
            $earning =  ($total_amount) * $provider_commission / 100;
        }
        $revenuedata[$key]['providerEarning'] = $earning;
        $revenuedata[$key]['afterAmount'] = $total_amount - $earning;

        }else{
            $revenuedata[$key]['providerEarning'] = 0;
            $revenuedata[$key]['afterAmount'] = 0;
        }
    }

    $data['revenueData']    =    [];
    for($i = 1; $i <= 12; $i++ ){
        $revenueData = 0;
        foreach($revenuedata as $revenue){
            if((int)$revenue['month'] == $i){
                $data['revenueData'][] = (int)$revenue['afterAmount'];
                $revenueData++;
            }
        }
        if($revenueData == 0){
            $data['revenueData'][] = 0 ;
        }
    }
    return $data['revenueData'];
}
function savePayoutActivity($data)
{
    switch ($data['type'])
    {
        case "provider_payout":
                $data['activity_message'] = __('messages.payout_paid',['type' =>'Admin','amount' => $data['amount']]);
                $activity_data = [
                    'user_id' =>$data['user_id'],
                    'amount' => $data['amount'],
                ];
                $sendTo = ['provider'];
            break;
        case "handyman_payout":
                $data['activity_message'] = __('messages.payout_paid',['type' =>'Provider','amount' => $data['amount']]);
                $activity_data = [
                    'user_id' =>$data['user_id'],
                    'amount' => $data['amount'],
                ];
                $sendTo = ['handyman'];
            break;

        default :
            $activity_data = [];
            break;
    }

    $notification_data = [
        'id'   => $data['user_id'],
        'type' => $data['activity_type'],
        'subject' => $data['activity_type'],
        'message' => $data['activity_message'],
    ];
    foreach($sendTo as $to){
        switch ($to)
        {
            case 'provider':
                $user = \App\Models\User::getUserByKeyValue( 'id', $data['user_id'] );
                break;
            case 'handyman':
                $user = \App\Models\User::getUserByKeyValue( 'id', $data['user_id'] );
                break;
        }
        $user->notify(new App\Notifications\CommonNotification($data['activity_type'],$notification_data ));
        $user->notify(new \App\Notifications\PayoutNotification($notification_data));
    }

}
function getTimeZone(){
    $timezone = \App\Models\AppSetting::first();
    return $timezone->time_zone ?? 'UTC';
}
function get_plan_expiration_date($plan_start_date = '',$plan_type = '',$left_days = 0, $plan_duration = 1){
    $start_at = new \Carbon\Carbon( $plan_start_date);
    $end_date = '';

    if($plan_type === 'weekly'){
       $getdays = App\Models\Plans::where('identifier','free')->first();
       $getdays = $getdays->trial_period;
       $days = $left_days + $getdays;
       $end_date =  $start_at->addDays($days);
    }
    if($plan_type === 'monthly'){
        $end_date =  $start_at->addMonths($plan_duration)->addDays($left_days);
    }
    if($plan_type === 'yearly'){
        $end_date =  $start_at->addYears($plan_duration)->addDays($left_days);
    }
    return $end_date->format('Y-m-d H:i:s');
}
function get_user_active_plan($user_id){
    $get_provider_plan  =  \App\Models\ProviderSubscription::where('user_id',$user_id)->where('status',config('constant.SUBSCRIPTION_STATUS.ACTIVE'))->first();
    $activeplan = null; 
    if(!empty($get_provider_plan)){
        $activeplan = new App\Http\Resources\API\ProviderSubscribeResource($get_provider_plan);
    }
    return $activeplan;
}
function is_subscribed_user($user_id){
    $user_subscribed = \App\Models\ProviderSubscription::where('user_id',$user_id)->where('status',config('constant.SUBSCRIPTION_STATUS.ACTIVE'))->first();
    $value = 0;
    if($user_subscribed){
        $value = 1;
    }
    return $value;
}
function check_days_left_plan($old_plan,$new_plan){
    $previous_plan_start = $old_plan->start_at;
    $previous_plan_end = new \Carbon\Carbon($old_plan->end_at);
    $new_plan_start = new \Carbon\Carbon(date('Y-m-d H:i:s'));
    $left_days = $previous_plan_end->diffInDays($new_plan_start);
    return $left_days;
}
function user_last_plan($user_id){
    $user_subscribed = \App\Models\ProviderSubscription::where('user_id',$user_id)
                    ->where('status',config('constant.SUBSCRIPTION_STATUS.INACTIVE'))->orderBy('id','desc')->first();
    $inactivePlan = null; 
    if(!empty($user_subscribed)){
        $inactivePlan = new App\Http\Resources\API\ProviderSubscribeResource($user_subscribed);
    }
    return $inactivePlan;
}
function is_any_plan_active($user_id){
    $user_subscribed = \App\Models\ProviderSubscription::where('user_id',$user_id)->where('status',config('constant.SUBSCRIPTION_STATUS.ACTIVE'))->first();
    $value = 0;
    if($user_subscribed){
        $value = 1;
    }
    return $value;
}
function default_earning_type(){
    $gettype = \App\Models\AppSetting::first();
    $earningtype = $gettype->earning_type ? $gettype->earning_type : 'commission';
    return $earningtype;
}
function saveWalletHistory($data){
    $admin = \App\Models\AppSetting::first();
    date_default_timezone_set( $admin->time_zone ?? 'UTC');
    $data['datetime'] = date('Y-m-d H:i:s');
    $data['user_id'] =  $data['wallet']->user_id;
    $role = auth()->user()->user_type;
    switch ($data['activity_type'])
    {
        case "add_wallet":
                $data['activity_message'] = __('messages.wallet_added');
                $activity_data = [
                    'title' => $data['wallet']->title,
                    'user_id' => $data['wallet']->user_id,
                    'provider_name' => isset($data['wallet']->provider) ? $data['wallet']->provider->display_name : '',
                    'amount' => $data['wallet']->amount,
                ];
            break;

        case "update_wallet":
                $data['activity_message'] = __('messages.update_wallet');
                $activity_data = [
                    'title' => $data['wallet']->title,
                    'user_id' => $data['wallet']->user_id,
                    'provider_name' => isset($data['wallet']->provider) ? $data['wallet']->provider->display_name : '',
                    'amount' => $data['wallet']->amount,
                ];
            break;

        case "wallet_payout_transfer":
            $data['activity_message'] = __('messages.wallet_amount',['value' => getPriceFormat($data['wallet']->amount)]);
            $activity_data = [
                'title' => $data['wallet']->title,
                'user_id' => $data['wallet']->user_id,
                'provider_name' => isset($data['wallet']->provider) ? $data['wallet']->provider->display_name : '',
                'amount' => $data['wallet']->amount,
            ];
        break;
        default :
            $activity_data = [];
            break;
    }
    $data['activity_data'] = json_encode($activity_data);

    \App\Models\WalletHistory::create($data);

    $notification_data = [
        'id'   => $data['wallet']->id,
        'type' => $data['activity_type'],
        'subject' => $data['activity_type'],
        'message' => $data['activity_message'],
        'notification_type' => 'wallet',
    ];
    $user = \App\Models\User::getUserByKeyValue( 'id', $data['wallet']->user_id );
    $user->notify(new App\Notifications\CommonNotification($data['activity_type'],$notification_data ));
    $user->notify(new \App\Notifications\WalletNotification($notification_data));
}
function get_provider_plan_limit($provider_id,$type){
    $limit_array = array();

    if(is_any_plan_active($provider_id) == 1){
        $exceed = '';
        $get_current_plan = get_user_active_plan($provider_id);
        if($get_current_plan->plan_type === 'limited'){
            $get_plan_limit = json_decode($get_current_plan->plan_limitation,true);
            $plan_start_date =  date('Y-m-d',strtotime( $get_current_plan->start_at));

            if($type === 'service'){
                $limit_array = $get_plan_limit['service'];
                $provider_service_count = \App\Models\Service::where('provider_id',$provider_id)->whereDate('created_at', '>=', $plan_start_date)->count();
                if($limit_array['is_checked'] == 'on' && $limit_array['limit'] != null){
                    if( $provider_service_count >= $limit_array['limit']){
                      $exceed = 1; // 1 for exceed limit;
                    }
                }elseif ($limit_array['is_checked'] === 'on' && $limit_array['limit'] == null) {
                     $exceed = 0;
                }
            }
            if($type === 'featured_service'){
                $limit_array = $get_plan_limit['featured_service'];
                $provider_featured_service_count = \App\Models\Service::where('provider_id',$provider_id)->where('is_featured',1)->whereDate('created_at', '>=', $plan_start_date)->count();
                if($limit_array['is_checked'] == 'on' && $limit_array['limit'] != null){
                    if($provider_featured_service_count >= $limit_array['limit']){
                      $exceed = 1; // 1 for exceed limit;
                    }
                }elseif ($limit_array['is_checked'] === 'on' && $limit_array['limit'] == null) {
                     $exceed = 0;
                }
            }
            if($type === 'handyman'){
                $limit_array = $get_plan_limit['handyman'];
                $handyman_count = \App\Models\User::where('provider_id',$provider_id)->whereDate('created_at', '>=', $plan_start_date)->count();
                if($limit_array['is_checked'] == 'on' && $limit_array['limit'] != null){
                    if($handyman_count >= $limit_array['limit']){
                      $exceed = 1; // 1 for exceed limit;
                    }
                }elseif ($limit_array['is_checked'] === 'on' && $limit_array['limit'] == null) {
                     $exceed = 0;
                }
            }

        }else{
            return;
        }
    }else{
        return;
    }
    return $exceed;
}
function sendNotification($type,$user,$data){
    $app_id = ENV('ONESIGNAL_API_KEY');
    $rest_api_key = ENV('ONESIGNAL_REST_API_KEY');
    if($type === 'user'){
        $app_id = ENV('ONESIGNAL_API_KEY');
        $rest_api_key = ENV('ONESIGNAL_REST_API_KEY');
    }
    if($type === 'provider'){
        $app_id = ENV('ONESIGNAL_APP_ID_PROVIDER');
        $rest_api_key = ENV('ONESIGNAL_REST_API_KEY_PROVIDER');
    }
    $heading      = array(
        "vi" => str_replace("_"," ",ucfirst($data['subject']))
    );
    $content      = array(
        "vi" => $data['message']
    );
    $fields = array(
        'app_id' => $app_id,
        'include_player_ids' => array($user->player_id),
        'data' =>  array(
            'type' => $data['type'],
            'id' => $data['id']
        ),
        'headings' => $heading,
        'contents' => $content,
    );
    $fields = json_encode($fields);
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, "https://onesignal.com/api/v1/notifications");
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        'Content-Type: application/json; charset=utf-8',
        "Authorization:Basic $rest_api_key"
    ));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_POST, TRUE);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    
    $response = curl_exec($ch);
    curl_close($ch);
    $childData = array(
        "id"=> $data['id'],
        "type"=>$data['type'],
        "subject"=>$data['subject'],
        "message"=>$data['message']
    );
    $notification = \App\Models\Notification::create(
        array(
            'id' => Illuminate\Support\Str::random(32),
            'type' => $data['type'],
            'notifiable_type'=> 'App\Models\User',
            'notifiable_id'=>$user->id,
            'data'=>json_encode($childData)
        )
    );

   
  }

  
