<div class="iq-top-navbar">
    <div class="iq-navbar-custom">
        <nav class="navbar navbar-expand-lg navbar-light p-0">
{{--            <div class="iq-navbar-logo d-flex align-items-center justify-content-between">--}}
{{--                <i class="ri-menu-line wrapper-menu"></i>--}}
{{--                <a href="{{ asset('/') }}" class="header-logo">--}}
{{--                    <img src="{{ asset('images/logo.png') }}" class="img-fluid rounded-normal" alt="logo">--}}
{{--                    <!-- <h4 class="ml-1"><b>{{ env('APP_NAME') }}</b></h4> -->--}}
{{--                </a>--}}
{{--            </div>--}}
            <div class="side-menu-bt-sidebar">
                <svg xmlns="http://www.w3.org/2000/svg" class="text-secondary wrapper-menu" width="30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                </svg>
            </div>
            <div class="d-flex align-items-center">
                <div class="change-mode">
                    <div class="custom-control custom-switch custom-switch-icon custom-control-inline">
                        <div class="custom-switch-inner">
                            <p class="mb-0"> </p>
                            <input type="checkbox" class="custom-control-input" id="dark-mode" data-active="true">
                            <label class="custom-control-label" for="dark-mode" data-mode="toggle">
                                <span class="switch-icon-left">
                                    <svg class="svg-icon" id="h-moon" height="20" width="20" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
                                    </svg>
                                </span>
                                <span class="switch-icon-right">
                                    <svg class="svg-icon" id="h-sun" height="20" width="20" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
                                    </svg>
                                </span>
                            </label>
                        </div>
                    </div>
                </div>
                @if( auth()->user()->hasRole('admin') && URL::current() == route('home') || auth()->user()->hasRole('demo_admin') && URL::current() == route('home'))
                <button class="btn p-0" data-toggle="modal" data-target="#adminModal"><svg width="24" height="24" viewBox="0 0 24 24" fill="#ffffff" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 6.40039H5.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M11 6.40039H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5858 6.34625C10.5858 5.0506 9.52762 4 8.22264 4C6.91766 4 5.8595 5.0506 5.8595 6.34625C5.8595 7.64191 6.91766 8.69251 8.22264 8.69251C9.52762 8.69251 10.5858 7.64191 10.5858 6.34625Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 18.4004H6.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12 18.4004H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M11.5858 18.3463C11.5858 17.0506 10.5276 16 9.22264 16C7.91766 16 6.8595 17.0506 6.8595 18.3463C6.8595 19.6419 7.91766 20.6925 9.22264 20.6925C10.5276 20.6925 11.5858 19.6419 11.5858 18.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 12.4004H11" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M17 12.4004H19.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M16.5858 12.3463C16.5858 11.0506 15.5276 10 14.2226 10C12.9177 10 11.8595 11.0506 11.8595 12.3463C11.8595 13.6419 12.9177 14.6925 14.2226 14.6925C15.5276 14.6925 16.5858 13.6419 16.5858 12.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg></button>
                @endif
                @if( auth()->user()->hasRole('provider') && URL::current() == route('home'))
                <button class="btn p-0" data-toggle="modal" data-target="#providerModal"><svg width="24" height="24" viewBox="0 0 24 24" fill="#ffffff" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 6.40039H5.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M11 6.40039H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5858 6.34625C10.5858 5.0506 9.52762 4 8.22264 4C6.91766 4 5.8595 5.0506 5.8595 6.34625C5.8595 7.64191 6.91766 8.69251 8.22264 8.69251C9.52762 8.69251 10.5858 7.64191 10.5858 6.34625Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 18.4004H6.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12 18.4004H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M11.5858 18.3463C11.5858 17.0506 10.5276 16 9.22264 16C7.91766 16 6.8595 17.0506 6.8595 18.3463C6.8595 19.6419 7.91766 20.6925 9.22264 20.6925C10.5276 20.6925 11.5858 19.6419 11.5858 18.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 12.4004H11" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M17 12.4004H19.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M16.5858 12.3463C16.5858 11.0506 15.5276 10 14.2226 10C12.9177 10 11.8595 11.0506 11.8595 12.3463C11.8595 13.6419 12.9177 14.6925 14.2226 14.6925C15.5276 14.6925 16.5858 13.6419 16.5858 12.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg></button>
                @endif
                @if( auth()->user()->hasRole('handyman') && URL::current() == route('home'))
                <button class="btn p-0" data-toggle="modal" data-target="#handymanModal"><svg width="24" height="24" viewBox="0 0 24 24" fill="#ffffff" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 6.40039H5.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M11 6.40039H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5858 6.34625C10.5858 5.0506 9.52762 4 8.22264 4C6.91766 4 5.8595 5.0506 5.8595 6.34625C5.8595 7.64191 6.91766 8.69251 8.22264 8.69251C9.52762 8.69251 10.5858 7.64191 10.5858 6.34625Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 18.4004H6.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12 18.4004H19" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M11.5858 18.3463C11.5858 17.0506 10.5276 16 9.22264 16C7.91766 16 6.8595 17.0506 6.8595 18.3463C6.8595 19.6419 7.91766 20.6925 9.22264 20.6925C10.5276 20.6925 11.5858 19.6419 11.5858 18.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 12.4004H11" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M17 12.4004H19.5" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path fill-rule="evenodd" clip-rule="evenodd" d="M16.5858 12.3463C16.5858 11.0506 15.5276 10 14.2226 10C12.9177 10 11.8595 11.0506 11.8595 12.3463C11.8595 13.6419 12.9177 14.6925 14.2226 14.6925C15.5276 14.6925 16.5858 13.6419 16.5858 12.3463Z" stroke="#232D42" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                </svg></button>
                @endif
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"  aria-label="Toggle navigation">
                    <svg xmlns="http://www.w3.org/2000/svg" class="text-secondary" width="30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7" />
                    </svg>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto navbar-list align-items-center">
                        <li class="nav-item nav-icon dropdown"> 
                            <a href="#" class="search-toggle dropdown-toggle notification_list" id="notification-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" class="h-6 w-6 text-secondary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                                </svg>
                                <span class="bg-primary"></span>
                                <span class="badge badge-pill badge-danger badge-up notify_count count-mail d-none"></span>
                                <span class="bg-danger dots d-none"></span>
                            </a>
                            <div class="iq-sub-dropdown dropdown-menu notification-menu" aria-labelledby="notification-dropdown">
                                <div class="card shadow-none m-0 border-0 notification_data"></div>
                            </div>
                        </li>
                        <li class="nav-item nav-icon dropdown">
                            <a href="#" class="search-toggle dropdown-toggle" id="languageDropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <?php
                                    $selected_lang_flag = file_exists(public_path('/images/flags/' .app()->getLocale() . '.png')) ? asset('/images/flags/' . app()->getLocale() . '.png') : asset('/images/language.png');
                                ?>
                                <img src="{{ $selected_lang_flag }}" class="img-fluid rounded-circle" alt="lang" style="height: 30px; min-width: 30px; width: 30px;">
                                <span class="bg-primary"></span>
                            </a>
                            <div class="iq-sub-dropdown dropdown-menu language-dropdown-menu" aria-labelledby="languageDropdownMenu">
                                <div class="card shadow-none m-0 border-0">
                                    <div class=" p-0 ">
                                        <ul class="dropdown-menu-1 list-group list-group-flush">
                                            <?php
                                                $language_option = settingSession('get')->language_option;
                                                if(!empty($language_option)){
                                                    $language_array = languagesArray($language_option);
                                                }
                                            ?>
                                            @if(count($language_array) > 0 )
                                                @foreach( $language_array  as $lang )
                                                    <li class="dropdown-item-1 list-group-item px-2">
                                                        <a class="p-0" data-lang="{{ $lang['id'] }}" href="{{ route('switch-language',['locale'=> $lang['id'] ]) }}">
                                                        <?php
                                                            $flag_path = file_exists(public_path('/images/flags/' . $lang['id'] . '.png')) ? asset('/images/flags/' . $lang['id'] . '.png') : asset('/images/language.png');
                                                        ?>
                                                        <img src="{{ $flag_path }}" alt="img-flag-{{ $lang['id'] }}" class="img-fluid mr-2" style="width: 20px;height: auto;min-width: 15px;"/>
                                                            {{ $lang['title'] }}
                                                        </a>
                                                    </li>
                                                @endforeach
                                            @endif
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item nav-icon dropdown">
                            <a href="#" class="nav-item nav-icon dropdown-toggle pr-0 search-toggle" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                                <img src="{{ getSingleMedia(auth()->user(),'profile_image') }}" class="img-fluid avatar-rounded" alt="user">
                                <span class="mb-0 ml-2 user-name">{{ auth()->user()->first_name." ".auth()->user()->last_name }}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
                                <li class="dropdown-item d-flex svg-icon">
                                    <svg class="svg-icon mr-0 text-secondary" id="h-01-p" width="20" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    <a href="{{ route('setting.index',['page' => 'profile_form']) }}">{{ __('messages.my_profile') }}</a>
                                </li>
                                <li class="dropdown-item d-flex svg-icon">
                                    <svg class="svg-icon mr-0 text-secondary" id="h-03-p" width="20" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    </svg>
                                    <a href="{{  route('setting.index') }}">{{ __('messages.setting') }}</a>
                                </li>
                                <li class="dropdown-item  d-flex svg-icon border-top">
                                    <form method="POST" action="{{ route('logout') }}">
                                        @csrf
                                        <svg class="svg-icon mr-0 text-secondary" id="h-05-p" width="20" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                    </svg>
                                        <a class="pl-1" href="javascript:void(0)"
                                           onclick="event.preventDefault();
                                        this.closest('form').submit();">
                                            {{ __('messages.logout') }}
                                        </a>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</div>
