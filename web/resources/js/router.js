import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

import LandingPage from "./views/LandingPage/LandingPage";
import Category from "./views/Category/Category";
import Service from "./views/Service/Service";
import Booking from "./views/Booking/Booking";
import ServiceDetail from "./views/Service/ServiceDetail";
import BookingDetail from "./views/Booking/BookingDetail";
import CategoryDetail from "./views/Category/CategoryDetail";
import Gallery from './views/Service/Gallery'
import BookingWizard from './views/Booking/BookingWizard'
import About from './views/About/About'
import ContactUs from './views/ContactUs/ContactUs'
import PrivacyPolicy from './views/PrivacyPolicy/PrivacyPolicy'
import UserFavourite from './views/Service/Userfavourite'
import TermsConditions from './views/TermsConditions/TermsConditions'
import Provider from './views/provider/Provider.vue'
import ProviderService from './views/provider/ProviderService.vue'
import HelpSupport from './views/HelpSupport/HelpSupport'
import RefundPolicy from './views/RefundPolicy/RefundPolicy'

const routes = [
    { path: '/', name: 'frontend-home', component: LandingPage, meta: { label: 'Trang chủ' } },
    { path: '/category', name: 'category', component: Category, meta: { label: 'Danh sách', homeName:'Danh mục' } },
    { path: '/service', name: 'service', component: Service, meta: { label: 'Danh sách',homeName:'Dịch vụ' } },
    { path: '/booking', name: 'booking', component: Booking, meta: { label: 'Danh sách',homeName:'Đặt chỗ' } },
    { path: '/userfavourite', name: 'user-favourite', component: UserFavourite, meta: { label: 'Người dùng yêu thích',homeName:'Người dùng yêu thích' } },
    { path: '/service-detail/:service_id', name: 'service-detail', component: ServiceDetail, meta: { label: 'Chi tiết dịch vụ',homeName:'Dịch vụ' } },
    { path: '/booking-detail/:booking_id', name: 'booking-detail', component: BookingDetail, meta: { label: 'Chi tiết đặt chỗ',homeName:'Booking' } },
    { path: '/category-detail/:category_id', name: 'category-detail', component: CategoryDetail, meta: { label: 'Chi tiết danh mục',homeName:'Danh mục' } },
    { path: '/gallery', name: 'gallery', component: Gallery, meta: { label: 'Thu viện',homeName:'Thư viện' } },
    { path: '/bookingwizard/:service_id', name: 'book-service', component: BookingWizard, meta: { label: 'Đặt dịch vụ',homeName:'Dịch vụ' } },
    { path: '/about-us', name: 'about-us', component: About, meta: { label: 'Giới thiệu',homeName:'Giới thiệu' } },
    { path: '/contact-us', name: 'contact-us', component: ContactUs, meta: { label: 'Liên hệ',homeName:'Liên hệ' } },
    { path: '/privacy-policy', name: 'privacy-policy', component: PrivacyPolicy, meta: { label: 'Chính sách bảo mật',homeName:'Chính sách bảo mật'} },
    { path: '/term-conditions', name: 'term-conditions', component: TermsConditions, meta: { label: 'Điều kiện',homeName:'Điều kiện' } },
    { path: '/provider', name: 'provider', component: Provider, meta: { label: 'Danh sách nhà cung cấp' } },
    { path: '/provider-service/:provider_id', name: 'provider-service', component: ProviderService, meta: { label: 'Nhà cung cấp dịch vụ' } },
    { path: '/help-support', name: 'help-support', component: HelpSupport, meta: { label: 'Trợ giúp & Hỗ trợ',homeName:'Trợ giúp & Hỗ trợ' } },
    { path: '/refund-cancellation-policy', name: 'refund-cancellation-policy', component: RefundPolicy, meta: { label: 'Chính sách hoàn tiền',homeName:'Chính sách hoàn tiền' } },

    

];
const router = new VueRouter({
    base: process.env.BASE_URL,
    routes: routes
})
router.beforeEach((to, from, next) => {
    const loggedIn = localStorage.getItem('user')
    window.scrollTo(0, 0);
    if (to.matched.some(record => record.meta.auth) && !loggedIn) {
        next('/login')
        return
    }
    next()
})
export default router
