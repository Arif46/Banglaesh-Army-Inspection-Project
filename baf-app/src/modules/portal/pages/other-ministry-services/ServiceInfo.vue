<template>
    <div class="other-ministy-service-info">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">সার্ভিস সম্পর্কে বিস্তারিত</h2>
            <img src="../../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container class="portal-container">
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home')
                            }}</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{
                            $t('portal.all_service') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.service_details') }}</span>
                    </li>
                </ol>
            </b-container>
        </div>
        <section>
            <b-container class="portal-container">
                <div class="box my-4">
                    <div class="d-flex justify-content-between align-items-center p-3">
                        <h4 class="font-weight-bold">জাতীয় পরিকল্পনা ও উন্নয়ন একাডেমি (এনএপিডি)</h4>
                        <button class="btn apply_btn"><b-icon icon="vector-pen" /> আবেদন করুন</button>
                    </div>
                </div>
                <div class="box my-4 p-3">
                    <h3 class="text-center mb-3">আবেদন ফরম পূরণের নিয়মাবলী</h3>
                    <p>
                        ১। আবেদন ফরমের লাল তারকা চিহ্নিত ঘরগুলো অবশ্যই পূরণ করুন। অন্যান্য ঘরগুলো পূরণ ঐচ্ছিক
                        ২। আবেদন প্রক্রিয়া সম্পন্ন হওয়ার পূর্বে প্রয়োজন হলে সংরক্ষণ করা যায় এবং পরবর্তীতে সেবা ব্যবস্থাপনা অপশন হতে
                        ড্রাফট
                        আবেদন পুনরায় শুরু করা যাবে।
                        ৩। আবেদন দাখিলের পর প্রতিটি আবেদনের জন্য একটা স্বতন্ত্র ট্রাকিং নম্বর প্রদান করা হবে যেটা ব্যবহার করে সেবা
                        ব্যবস্থাপনা
                        অপশন হতে আবেদনের অগ্রগতি জানা যাবে।
                    </p>
                </div>
                <div class="mb-4">
                    <b-row>
                        <b-col>
                            <div class="box p-2">
                                <b-alert variant="primary" show><b-icon icon="info-circle" /> সেবা প্রদানের পদ্ধতি</b-alert>
                                <p>আবেদন দাখিলের পর প্রতিটি আবেদনের জন্য একটা স্বতন্ত্র ট্রাকিং নম্বর প্রদান করা হবে যেটা ব্যবহার করে সেবা ব্যবস্থাপনা
                                অপশন হতে আবেদনের অগ্রগতি জানা যাবে।</p>
                            </div>
                        </b-col>
                        <b-col>
                            <div class="box p-2">
                                <b-alert variant="primary" show><b-icon icon="wallet2" /> সেবার মূল্য এবং পরিশোধ পদ্ধতি</b-alert>
                                <p>অনলাইন পরিশোধ করতে হবে।</p>
                            </div>
                        </b-col>
                        <b-col>
                            <div class="box p-2">
                                <b-alert variant="primary" show><b-icon icon="clock" /> সেবা প্রদানের সময়সীমা</b-alert>
                                <p>৪ দিন</p>
                            </div>
                        </b-col>
                    </b-row>
                </div>
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
.apply_btn{
    color: var(--white);
    padding: 4px 10px;
    background: var(--portal-brand);
    border-radius: 3px;
}
.apply_btn:hover{
    color: #fff;
    box-shadow: rgba(34, 34, 34, 0.5) 0px 2px 10px 0px;
    background: var(--portal-secondary);
}
</style>
