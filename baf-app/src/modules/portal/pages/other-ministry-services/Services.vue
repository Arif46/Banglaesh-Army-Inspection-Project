<template>
    <div class="other-ministy-services">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">প্রয়োজনীয় সেবা গ্রহণ করুন</h2>
            <img src="../../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container class="portal-container">
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item">
                        <router-link to="/portal/home" target="_self" class="">
                        {{ $t('portal.home') }}
                        </router-link>
                    </li>
                    <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{
                        $t('portal.all_service')
                    }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.service_details') }}</span>
                    </li>
                </ol>
            </b-container>
        </div>
        <section>
            <b-container class="portal-container">
                <div class="box service-filter my-4">
                    <div class="d-block d-sm-flex justify-content-between align-items-center p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <b-form-checkbox id="sectorBased" name="serviceBased">
                                সেবা খাত ভিত্তিক
                            </b-form-checkbox>
                            <b-form-checkbox id="ministryBased" name="serviceBased">
                                মন্ত্রণালয় ভিত্তিক
                            </b-form-checkbox>
                        </div>
                        <div class="searchBox">
                            <b-input-group>
                                <b-input-group-prepend>
                                    <b-input-group-text>
                                        <b-icon icon="search" />
                                    </b-input-group-text>
                                </b-input-group-prepend>
                                <b-form-input type="text" placeholder="আপনার সেবাটি খুজুন.."></b-form-input>
                                <b-input-group-append>
                                    <b-button variant="info">খুজুন</b-button>
                                </b-input-group-append>
                            </b-input-group>
                        </div>
                    </div>
                </div>
            </b-container>
        </section>
        <section>
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="3">
                        <div class="sidebar-list">
                            <div class="box-title"><p>দপ্তর অনুসারে সেবা</p></div>
                            <div class="box-content">
                                <b-list-group>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        মন্ত্রিপরিষদ বিভাগ
                                        <b-badge variant="info" pill>১৪</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        বস্ত্র ও পাট মন্ত্রণালয়
                                        <b-badge variant="info" pill>১১</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        অর্থ মন্ত্রণালয়
                                        <b-badge variant="info" pill>২</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        জনপ্রশাসন মন্ত্রণালয়
                                        <b-badge variant="info" pill>৩১</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        কৃষি মন্ত্রণালয়
                                        <b-badge variant="info" pill>১৭</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        খাদ্য মন্ত্রণালয়
                                        <b-badge variant="info" pill>৩</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        ডাক, টেলিযোগাযোগ মন্ত্রণালয়
                                        <b-badge variant="info" pill>৯</b-badge>
                                    </b-list-group-item>
                                </b-list-group>
                            </div>
                        </div>
                        <div class="sidebar-list mt-4">
                            <div class="box-title"><p>সেবা খাত সমূহ</p></div>
                            <div class="box-content">
                                <b-list-group>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        নিবন্ধন ও লাইসেন্স
                                        <b-badge variant="info" pill>১৪</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        কৃষি
                                        <b-badge variant="info" pill>১১</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        অর্থ ও ব্যাংক
                                        <b-badge variant="info" pill>২</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        সনদ, প্রত্যয়ন, অনাপত্তি ও অনুমতি
                                        <b-badge variant="info" pill>৩১</b-badge>
                                    </b-list-group-item>
                                    <b-list-group-item href="#" class="d-flex justify-content-between align-items-center">
                                        অনুদান, ভাতা ও ঋণ
                                        <b-badge variant="info" pill>১৭</b-badge>
                                    </b-list-group-item>
                                </b-list-group>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="9">
                        <div class="services-list mt-4 mt-sm-0">
                            <b-list-group>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">মন্ত্রিপরিষদ বিভাগ</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">বস্ত্র ও পাট মন্ত্রণালয়</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">জাতীয় পরিকল্পনা ও উন্নয়ন একাডেমি (এনএপিডি)</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">বাংলাদেশ কর্মচারী কল্যাণ বোর্ড (বিকেকেবি)</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">জনপ্রশাসন মন্ত্রণালয়</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">কৃষি মন্ত্রণালয়</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">বাংলাদেশ সিভিল সার্ভিস প্রশাসন একাডেমি</span></b-list-group-item>
                                <b-list-group-item href="#"><b-icon class="text-success" icon="file-earmark-text-fill"/><span class="pl-2">ডাক, টেলিযোগাযোগ মন্ত্রণালয়</span></b-list-group-item>
                            </b-list-group>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </section>
    </div>
</template>
<script>
    export default {
        data () {
            return {

            }
        }
    }
</script>
<style>
.other-ministy-services{
    margin-bottom: 2rem;
}
.other-ministy-services .service-filter{
    color: #fff;
    background: var(--portal-brand);
    border-radius: 1rem!important;
}
.other-ministy-services .searchBox .form-control, .font-bn .other-ministy-services .searchBox .form-control{
    height: 38px;
    border-left: none;
}
.other-ministy-services .searchBox .form-control:focus, .font-bn .other-ministy-services .searchBox .form-control:focus{
    border: inherit;
}
.other-ministy-services .searchBox .input-group-text{
    border-right: none;
    background: #f2f2f2;
}
.other-ministy-services .box {
    border-radius: .3rem .3rem 0 0;
}
.other-ministy-services .box-title {
    text-align: center;
    padding: .4rem 1rem;
    border-radius: .3rem .3rem 0 0;
    color: #fff;
    background: var(--portal-brand);
}
.other-ministy-services .services-list .list-group-item{
    padding: .4rem 1rem;
    margin-bottom: .5rem;
}
.other-ministy-services .services-list .list-group-item:hover span{
    color: var(--portal-brand);
}
.other-ministy-services .sidebar-list .list-group-item {
    margin: .3rem 0;
    border-left: 3px solid var(--portal-brand);
    box-shadow: rgba(60, 64, 67, 0.3) 0px 1px 1px 0px, rgba(60, 64, 67, 0.15) 0px 1px 1px 1px;
}
</style>
