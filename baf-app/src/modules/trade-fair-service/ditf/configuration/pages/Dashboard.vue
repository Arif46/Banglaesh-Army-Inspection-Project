<template>
  <div class="section-wrapper">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">Dhaka International Trade Fair</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group>
              <template v-slot:label>
                Fiscal Year
              </template>
              <b-form-select>
                <template v-slot:first>
                  <b-form-select-option>2021 - 2022</b-form-select-option>
                  <b-form-select-option>2022 - 2023</b-form-select-option>
                  <b-form-select-option>2023 - 2024</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group>
              <template v-slot:label>
                Fair Name
              </template>
              <b-form-select>
                <template v-slot:first>
                  <b-form-select-option>Dhaka International Trade Fair</b-form-select-option>
                  <b-form-select-option>Global Lift & Escalator Expo</b-form-select-option>
                  <b-form-select-option>International garment and textile exhibition</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group>
              <template v-slot:label>
                Stall Type
              </template>
              <b-form-select>
                <template v-slot:first>
                  <b-form-select-option>Pavilion</b-form-select-option>
                  <b-form-select-option>Restaurant</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <!-- *********upcoming fair & calender********* -->
    <b-row>
      <b-col>
        <b-card class="upcoming-fair">
          <div class="d-flex justifiy-center align-items-center flex-column">
            <div class="icon mb-2">
              <img class="img-fluid" src="../../../../../assets/images/local-shop.png" alt="">
            </div>
            <div class="content">
              <h5>Dhaka International Trade Fair- 2024</h5>
              <div class="d-flex align-items-center justify-content-center">
                <h6 class="py-3 mr-2"><strong>City and Country: </strong> Dhaka, Bangladesh</h6>
                <p class="fair-date"><strong>Duration: </strong>1 January, 2024 to 30 January, 2023</p>
              </div>
            </div>
          </div>
        </b-card>
      </b-col>
    </b-row>
    <div class="trade_fire_wrapper mb-4">
      <b-row>
        <b-col class="bdr" sm="4">
          <div class="info-card">
            <img src="../../../../../assets/images/shopping-mall.png" class="img-fluid" alt="">
            <div class="content">
              <p>Total Stall</p>
              <h3>129</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3 mt-sm-0" sm="4">
          <div class="info-card">
            <img src="../../../../../assets/images/food-store.png" class="img-fluid" alt="">
            <div class="content">
              <p>Local Stall</p>
              <h3>81</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr" sm="4">
          <div class="info-card">
            <img src="../../../../../assets/images/forign-shop.png" class="img-fluid" alt="">
            <div class="content">
              <p>Forign Stall</p>
              <h3>48</h3>
            </div>
          </div>
        </b-col>
      </b-row>
    </div>
    <div class="ditf_participant mb-4">
      <b-row>
        <b-col class="bdr" sm="3">
          <div class="info-card applicant">
            <div class="icon"><i class="ri-team-fill"></i></div>
            <div class="content">
              <p>Total Applicant</p>
              <h3>56</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3 mt-sm-0" sm="3">
          <div class="info-card approved">
            <div class="icon"><i class="ri-checkbox-fill"></i></div>
            <div class="content">
              <p>Approved Application</p>
              <h3>2560</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr" sm="3">
          <div class="info-card peinding">
            <div class="icon"><i class="ri-time-fill"></i></div>
            <div class="content">
              <p>Peinding Application</p>
              <h3>25</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3 mt-sm-0" sm="3">
          <div class="info-card reject">
            <div class="icon"><i class="ri-close-circle-fill"></i></div>
            <div class="content">
              <p>Reject Application</p>
              <h3>31</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3" sm="3">
          <div class="info-card paid">
            <div class="icon"><i class="ri-user-follow-fill"></i></div>
            <div class="content">
              <p>Paid Applicant</p>
              <h3>2560</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3" sm="3">
          <div class="info-card unpaid">
            <div class="icon"><i class="ri-user-unfollow-fill"></i></div>
            <div class="content">
              <p>Unpaid Applicant</p>
              <h3>25</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3" sm="3">
          <div class="info-card applicant">
            <div class="icon"><i class="ri-group-fill"></i></div>
            <div class="content">
              <p>Atended Applicant</p>
              <h3>31</h3>
            </div>
          </div>
        </b-col>
        <b-col class="bdr mt-3" sm="3">
          <div class="info-card foreign">
            <div class="icon"><i class="ri-global-fill"></i></div>
            <div class="content">
              <p>Foreign Applicant</p>
              <h3>31</h3>
            </div>
          </div>
        </b-col>
      </b-row>
    </div>
    <b-row>
      <b-col sm="8">
        <b-card>
          <img class="img-fluid" src="../../../../../assets/images/chart-3.png" alt="">
        </b-card>
      </b-col>
      <b-col sm="4">
        <b-card>
          <img class="img-fluid" src="../../../../../assets/images/Pie Chart.png" alt="">
        </b-card>
      </b-col>
    </b-row>
    <div class="ditf-info-table">
      <b-row>
        <b-col>
          <b-card header="(ক) প্যাভিলিয়ন/ স্টল/ রেস্টুরেন্টের শ্রেণী, প্রসেসিং ফি, রয়্যাল্টি/ ভাড়ার হার (স্থানীয়)">
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                  <tr>
                    <th scope="col">ক্রঃ</th>
                    <th scope="col">প্যাভিলিয়ন, স্টল, রেস্টুরেন্ট <small>(ক্যাটাগরি/ প্রকৃতি/ নাম)</small></th>
                    <th scope="col">সাইজ</th>
                    <th scope="col">আবেদন পত্র প্রসেসিং ফি</th>
                    <th scope="col">ফ্রোর মুল্য</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">১</th>
                    <td>সাউথ প্রিমিয়ার প্যাভিলিয়ন (SPP) ক্যাটাগরি- এ</td>
                    <td>(৬৫ x  ৩৬ ) ইন্সি</td>
                    <td>টাঃ ১৮,০০০/-</td>
                    <td>টাঃ ১৭,৫০,০০০/-</td>
                  </tr>
                  <tr>
                    <th scope="row">২</th>
                    <td>সাউথ প্রিমিয়ার প্যাভিলিয়ন (SPP) ক্যাটাগরি- এ</td>
                    <td>(৬৫ x  ৩৬ ) ইন্সি</td>
                    <td>টাঃ ১৮,০০০/-</td>
                    <td>টাঃ ১৭,৫০,০০০/-</td>
                  </tr>
                  <tr>
                    <th scope="row">৩</th>
                    <td>সাউথ প্রিমিয়ার প্যাভিলিয়ন (SPP) ক্যাটাগরি- এ</td>
                    <td>(৬৫ x  ৩৬ ) ইন্সি</td>
                    <td>টাঃ ১৮,০০০/-</td>
                    <td>টাঃ ১৭,৫০,০০০/-</td>
                  </tr>
                  <tr>
                    <th scope="row">৪</th>
                    <td>সাউথ প্রিমিয়ার প্যাভিলিয়ন (SPP) ক্যাটাগরি- এ</td>
                    <td>(৬৫ x  ৩৬ ) ইন্সি</td>
                    <td>টাঃ ১৮,০০০/-</td>
                    <td>টাঃ ১৭,৫০,০০০/-</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </b-card>
        </b-col>
      </b-row>
    </div>
  </div>
</template>
<style scoped>
.trade_fire_wrapper {
  border-radius: .2rem;
  background: #55A6F8 url(../../../../../assets/images/card-bg2.png);
  background-size: cover;
  background-position: left;
}
.trade_fire_wrapper .info-card {
  border-radius: 4px;
  color: #fff;
  padding: 1rem;
  min-height: 130px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.trade_fire_wrapper .info-card .content{
  text-align: center;
}
.trade_fire_wrapper .info-card .content p {
  font-size: 20px;
}
.trade_fire_wrapper .info-card img {
  height: 50px;
}
.trade_fire_wrapper .info-card.upcoming {
  background: linear-gradient(90deg, #dc3545 0%, rgb(252 80 42) 100%);
}

.trade_fire_wrapper .info-card.total {
  background: linear-gradient(90deg, #7d1dff 0%, #9448fa 100%);
}

.trade_fire_wrapper .info-card.atended {
  background: linear-gradient(90deg, #e39630 0%, #eecc61 100%);;
}

.upcoming-fair {
  background-image: url(../../../../../assets/images/bg-3.png), linear-gradient(90deg, #7716fe 0%, #9d56fa 100%);
  background-repeat: no-repeat;
  background-size: cover !important;
  position: relative;
}

.upcoming-fair .icon img {
  width: 100px;
}

.upcoming-fair .content {
  padding: 1rem;
  width: 100%;
  color: #fff;
  text-align: center;
}

.ditf_participant .info-card {
  display: flex;
  align-items: center;
  padding: 1rem;
  border-radius: 4px;
  box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}

.ditf_participant .info-card .icon {
  padding-right: 1rem;
  color: #fff;
  font-size: 1.5rem;
  margin-right: .6rem;
}

.ditf_participant .info-card.applicant {
  background: linear-gradient(90deg, #520979 20%, #f9efff 23%);
}

.ditf_participant .info-card.approved {
  background: rgb(33, 194, 40);
  background: linear-gradient(90deg, #21c228 20%, #effff0 23%);
}

.ditf_participant .info-card.peinding {
  background: #C96BE5;
  background: linear-gradient(90deg, #C96BE5 20%, #faebff 23%);
}

.ditf_participant .info-card.reject {
  background: #F8576A;
  background: linear-gradient(90deg, #F8576A 20%, #ffeef0 23%);
}

.ditf_participant .info-card.paid {
  background: #6349F8;
  background: linear-gradient(90deg, #6349F8 20%, #efecff 23%);
}

.ditf_participant .info-card.unpaid {
  background: #E79B55;
  background: linear-gradient(90deg, #E79B55 20%, #fff7ef 23%);
}

.ditf_participant .info-card.atended {
  background: #55A6F8;
  background: linear-gradient(90deg, #55A6F8 20%, #eaf5ff 23%);
}

.ditf_participant .info-card.foreign {
  background: #2943d6;
  background: linear-gradient(90deg, #2943d6 20%, #e9ecff 23%);
}
</style>
