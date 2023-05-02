<template>
  <div class="footer-wrapper">
    <div class="top-footer">
      <b-container>
        <b-row>
          <b-col sm="4">
            <div class="footer-links">
              <div class="list-group">
                <a href="/portal/home" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> Home</a>
                <a href="/portal/policy" class="list-group-item list-group-item-action"> <i
                    class="ri-arrow-right-s-line"></i> Policy</a>
                <a href="/portal/terms" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i>
                  Terms</a>
                <a href="/portal/home" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i>
                  Crop Pest Museum</a>
              </div>
            </div>
          </b-col>
          <b-col sm="4">
            <div class="footer-links">
              <div class="list-group">
                <a href="/portal/home" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> E-Service</a>
                <a href="/portal/policy" class="list-group-item list-group-item-action"> <i
                    class="ri-arrow-right-s-line"></i> Notice</a>
                <a href="/portal/terms" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i> Commerce News</a>
                <a href="/portal/home" class="list-group-item list-group-item-action"><i
                    class="ri-arrow-right-s-line"></i>
                  FAQ</a>
              </div>
            </div>
          </b-col>
          <b-col sm="4">
            <div class="help_center">
              <h5 class="title">Emergency</h5>
              <p class="sub_title">Portal Helpline</p>
              <div>
                <a href="tel: 01711378181">
                  <i class="ri-smartphone-line help_call" style="font-size: 2.2rem;"></i>
                  <span class="help_number" style="font-size: 1.6rem;">01711378181</span>
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
              <h5>Planning and Implementation</h5>
              <a target="_blank" href="#">
                <img style="width: 55px" src="../../../../assets/images/logo.png" alt="">
                <p class="mt-1 mb-0">Ministry of Commerce</p>
              </a>
            </div>
          </b-col>
          <b-col sm="12" md="4">
            <div class="footer-item">
              <h5>Technical Assistance</h5>
              <a target="_blank" href="#">
                <!-- <img style="width: 68px" src="../../../../assets/images/a2i-logo.png" alt="" class="mr-4"> -->
                <img style="width: 110px" src="../../../../assets/images/ict-division.png" alt="">
              </a>
            </div>
          </b-col>
          <b-col sm="12" md="4">
            <div class="footer-item">
              <h5>System Development</h5>
              <a target="_blank" href="#">
                <img class="syntech" src="../../../../assets/images/syntech2.png" alt="">
              </a>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
    <div class="bottom-footer">
      <b-container class="portal-container">
        <b-row>
          <b-col>
            <div class="d-flex justify-content-between text-light">
              <p>© All Rights Reserved</p>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Footer'
}
</script>
<style>

  .footer-wrapper .top-footer{
    width: 100%;
    padding: 30px 10px;
    border-top: 3px solid transparent;
    border-bottom: 3px solid transparent;
    border-image: url(../../../../assets/images/border.png) 30;
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
    margin-bottom: -9px;
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
    color: var(--link-color);
    background: var(--gray-eee);
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
</style>
