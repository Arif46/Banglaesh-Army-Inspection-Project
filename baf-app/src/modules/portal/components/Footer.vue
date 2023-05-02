<template>
  <div class="footer-wrapper">
    <div class="top-footer">
      <b-container>
        <b-row>
          <b-col sm="4">
            <div class="footer-links">
              <div class="list-group">
                <router-link to="/portal/home" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> {{ $t('portal.home') }}</router-link>
                <router-link to="/portal/policy" class="list-group-item list-group-item-action"> <i
                    class="ri-arrow-right-s-line"></i> {{ $t('portal.policy') }}</router-link>
                <router-link to="/portal/terms" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i>
                  {{ $t('portal.terms') }}</router-link>
                <!-- <router-link to="/portal/all-services" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> {{ $t('portal.e_services') }}</router-link> -->
              </div>
            </div>
          </b-col>
          <b-col sm="4">
            <div class="footer-links mob-footer-links">
              <div class="list-group">
                <router-link to="/portal/notice" class="list-group-item list-group-item-action"> <i
                    class="ri-arrow-right-s-line"></i> {{ $t('portal.notice') }}</router-link>
                <router-link to="/portal/news" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> {{ $t('portal.commerce_news') }}</router-link>
                <router-link to="/portal/faq" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i>
                  {{ $t('portal.Q_A') }}</router-link>
              </div>
            </div>
          </b-col>
          <b-col sm="4">
            <div class="help_center">
              <h5 class="title">{{ $t('portal.emergency') }}</h5>
              <p class="sub_title">{{ $t('portal.portal_office') }}</p>
              <div>
                <a href="tel: 01711378181">
                  <i class="ri-smartphone-line help_call" style="color: #3e69f1;vertical-align: middle;"></i>
                  <span class="help_number" style="font-size: 1.6rem;">{{ $i18n.locale === 'en' ? '01711378181' : BangNum('01711378181') }}</span>
                </a>
              </div>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
    <div class="middle-footer">
      <b-container class="portal-container">
        <b-row>
          <b-col sm="12" md="4">
            <div class="footer-item">
              <h5>{{ $t('portal.paning_implementation') }}</h5>
              <a target="_blank" href="http://www.mincom.gov.bd/">
                <img style="width: 55px" src="../../../assets/images/logo.png" alt="">
                <p class="mt-1 mb-0">{{ $t('portal.moc') }}</p>
              </a>
            </div>
          </b-col>
          <b-col sm="12" md="4">
            <div class="footer-item mob-footer-item">
              <h5>{{ $t('portal.with_technical_assistance') }}</h5>
              <a target="_blank" href="https://ictd.gov.bd">
                <!-- <img style="width: 68px" src="../../../assets/images/a2i-logo.png" alt="" class="mr-4"> -->
                <img style="width: 110px" src="../../../assets/images/ict-division.png" alt="">
              </a>
            </div>
          </b-col>
          <b-col sm="12" md="4">
            <div class="footer-item">
              <h5>{{ $t('portal.system_development') }}</h5>
              <a target="_blank" href="https://www.syntechbd.com/">
                <img class="syntech" src="../../../assets/images/syntech2.png" alt="">
              </a>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
    <div class="bottom-footer">
      <b-container class="portal-container">
        <b-row>
          <b-col sm="6">
            <div class="copyright d-flex justify-content-between text-light align-items-center h-100">
              <p style="font-size: 1rem;">&copy; {{ $t('portal.footer_text') }}</p>
            </div>
          </b-col>
          <b-col sm="6">
            <div class="social_wrapper">
              <a href="www.facebook.com" class="social facebook"><i class="ri-facebook-fill"></i></a>
              <a href="www.youtube.com"  class="social pinterest"><i class="ri-youtube-fill"></i></a>
              <a href="`mailto:`+`info@syntech.com`" class="social envelope"><i class="ri-mail-fill"></i></a>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
  </div>
</template>
<script>

export default {
  data () {
    return {
        loading: false,
        data: {},
        infos: ''
    }
  },
  computed: {
  },
  created () {
  },
  methods: {
    BangNum (n) {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
    }
  }
}
</script>
<style scoped>
.footer-wrapper .top-footer{
    width: 100%;
    padding: 30px 10px;
    border-top: 3px solid transparent;
    border-bottom: 3px solid transparent;
    border-image: url(../../../assets/images/border.png) 30;
    background-color: var(--white);
  }
  .footer-wrapper .top-footer .help_center{
    text-align: center;
  }
  .footer-wrapper .top-footer .help_center .title {
    margin-bottom: 8px;
    font-weight: 600;
  }
  .footer-wrapper .top-footer .help_center .sub_title {
    margin-bottom: -7px;
    color: var(--portal-brand);
  }
  .footer-wrapper .top-footer .help_center a {
    color: var(--portal-secondary);
    font-weight: 700;
    font-size: 40px;
  }
  .footer-wrapper .top-footer .footer-links .list-group-item {
    display: block;
    padding: 0.5em;
    font-weight: 500;
    border: 0;
  }
  .footer-wrapper .top-footer .footer-links .list-group-item:hover {
    margin-left: 4px;
    color: var(--portal-brand);
    background: transparent;
  }
  .footer-wrapper .top-footer .footer-links .list-group-item.active {
    color: var(--portal-brand);
    background: transparent;
  }
  .footer-wrapper .top-footer .footer-links .list-group-item i {
    vertical-align: middle;
  }
  .footer-wrapper .middle-footer{
    width: 100%;
    padding: 30px 20px;
    background-color: var(--white);
  }
  .footer-wrapper .middle-footer .footer-item{
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
  }
  .footer-wrapper .middle-footer .footer-item h5{
    margin-bottom: 1em;
    font-size: medium;
  }
  .footer-wrapper .middle-footer .footer-item a{
    color: var(--dark-gray);
  }
  .footer-wrapper .middle-footer .footer-item a .syntech{
    width: 130px;
  }
  .footer-wrapper .bottom-footer{
    width: 100%;
    padding: 5px;
    background-color: var(--portal-brand);
  }
  .footer-wrapper .bottom-footer .social_wrapper {
    padding: 5px 0;
    text-align: right;
  }
  .footer-wrapper .bottom-footer .social_wrapper .social {
    padding: 4px 9px 7px;
    color: var(--white);
    font-size: 1.1rem;
  }
  .footer-wrapper .bottom-footer .social_wrapper .facebook {
    background: #4268b3;
  }
  .footer-wrapper .bottom-footer .social_wrapper .twitter {
    background: #54abee;
  }
  .footer-wrapper .bottom-footer .social_wrapper .pinterest {
    background: #cb2027;
  }
  .footer-wrapper .bottom-footer .social_wrapper .envelope {
    background: #7d7d7d;
  }
  .footer-wrapper .bottom-footer .social_wrapper .share {
    background: #95d03a;
  }
</style>
