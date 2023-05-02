<template>
  <div class="section-wrapper">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">International Trade Fair</h4>
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
                  <b-form-select-option value="1">2021 - 2022</b-form-select-option>
                  <b-form-select-option value="2">2022 - 2023</b-form-select-option>
                  <b-form-select-option value="3">2023 - 2024</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group>
              <template v-slot:label>
                Month
              </template>
              <b-form-select>
                <template v-slot:first>
                  <b-form-select-option value="1">January</b-form-select-option>
                  <b-form-select-option value="2">February</b-form-select-option>
                  <b-form-select-option value="3">March</b-form-select-option>
                  <b-form-select-option value="4">April</b-form-select-option>
                  <b-form-select-option value="5">May</b-form-select-option>
                  <b-form-select-option value="6">Jun</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group>
              <template v-slot:label>
                Sector
              </template>
              <b-form-select>
                <template v-slot:first>
                  <b-form-select-option value="1">Agricultural Products</b-form-select-option>
                  <b-form-select-option value="2">Agro Processed Food</b-form-select-option>
                  <b-form-select-option value="3">Book Fair</b-form-select-option>
                  <b-form-select-option value="4">Furniture</b-form-select-option>
                  <b-form-select-option value="5">General</b-form-select-option>
                  <b-form-select-option value="6">Handicrafts</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <b-card class="trade_fire_wrapper">
      <b-row>
        <b-col class="bdr" sm="3">
          <div class="info-card upcoming">
            <div class="content">
              <p>Upcoming Fair</p>
              <h3>56</h3>
            </div>
            <img src="../../../../assets/images/amico.png" class="img-fluid" alt="image">
          </div>
        </b-col>
        <b-col class="bdr mt-3 mt-sm-0" sm="3">
          <div class="info-card total">
            <div class="content">
              <p>Total Circular</p>
              <h3>12</h3>
            </div>
            <img src="../../../../assets/images/folder-bro.png" class="img-fluid" alt="image">
          </div>
        </b-col>
        <b-col class="bdr" sm="3">
          <div class="info-card atended">
            <div class="content">
              <p>Atended Fair</p>
              <h3>25</h3>
            </div>
            <img src="../../../../assets/images/stall.png" class="img-fluid" alt="image">
          </div>
        </b-col>
        <b-col class="bdr mt-3 mt-sm-0" sm="3">
          <div class="info-card remaining">
            <div class="content">
              <p>Remaining Fair</p>
              <h3>31</h3>
            </div>
            <img src="../../../../assets/images/rem-fair.png" class="img-fluid" alt="image">
          </div>
        </b-col>
      </b-row>
    </b-card>
    <!-- *********upcoming fair & calender********* -->
      <b-row>
        <b-col sm="8">
          <b-card class="upcoming-fair">
            <div class="d-flex justifiy-center align-items-center flex-column">
              <div class="icon mb-2">
                <img class="img-fluid" src="../../../../assets/images/local-shop.png" alt="image">
              </div>
              <div class="content">
                <h5>The 4th International Tread Show for Aquaculture</h5>
                <h6 class="py-3"><strong>City and Country: </strong> Riyadh, KSA</h6>
                <p class="fair-date"><strong>Duration: </strong>17 October, 2022 to 20 October, 2022</p>
              </div>
            </div>
          </b-card>
        </b-col>
        <b-col sm="4">
          <b-card>
            <img class="img-fluid" src="../../../../assets/images/calender.png" alt="image">
          </b-card>
        </b-col>
      </b-row>
    <div class="trade_fire_participant mb-4">
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
      </b-row>
    </div>
    <b-row>
      <b-col sm="8">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/Line Chart.png" alt="image">
        </b-card>
      </b-col>
      <b-col sm="4">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/Pie Chart.png" alt="image">
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>

export default {
  props: [],
  data () {
    return {
      dashboardData: {},
      loading: false
    }
  },
  computed: {
  },
  created () {
  },
  methods: {
  }
}
</script>

<style scoped>
.trade_fire_wrapper .info-card {
  border-radius: 1rem;
  color: #214162;
  padding: 1rem;
  min-height: 130px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.trade_fire_wrapper .info-card .content p {
  font-size: 20px;
}

.trade_fire_wrapper .info-card.upcoming {
  color: #237dd3;
  background: #D2E8FD;
}

.trade_fire_wrapper .info-card.total {
  color: #875c1c;
  background: #FEF5CC;
}
.trade_fire_wrapper .info-card.atended {
  color: #04637e;
  background: #D0F2FC;
}

.trade_fire_wrapper .info-card.remaining {
  color: #f14b1f;
  background: #FEE7D7;
}

.trade_fire_wrapper .info-card img {
  height: 70px;
}
.upcoming-fair{
  background: url(../../../../assets/images/fair-card-bg.jpg);
  background-position: 50%;
  background-repeat: no-repeat;
  background-size: cover !important;
  position: relative;
}
.upcoming-fair .icon img{
  width: 100px;
}
.upcoming-fair .content{
  padding: 2rem;
  width: 100%;
  color: #fff;
  text-align: center;
}
.trade_fire_participant .info-card {
  margin-top: 1.5rem;
  display: flex;
  align-items: center;
  padding: .5rem;
  border-radius: 1rem;
  background: #fff;
  box-shadow: rgb(0 0 0 / 10%) 0rem 0.25rem 0.375rem -0.0625rem,
    rgb(0 0 0 / 6%) 0rem 0.125rem 0.25rem -0.0625rem;
}
.trade_fire_participant .info-card.applicant .icon{
  background: #48B5E4;
}
.trade_fire_participant .info-card.approved .icon{
  background: #21C228;
}
.trade_fire_participant .info-card.peinding .icon{
  background: #C96BE5;
}
.trade_fire_participant .info-card.reject .icon{
  background: #F8576A;
}
.trade_fire_participant .info-card.paid .icon{
  background: #6349F8;
}
.trade_fire_participant .info-card.unpaid .icon{
  background: #E79B55;
}
.trade_fire_participant .info-card .atended .icon{
  background: #55A6F8;
}
.trade_fire_participant .info-card .icon{
  color: #fff;
  border-radius: 0.5rem;
  padding: 0.5rem;
  width: 3rem;
  height: 3rem;
  display: flex;
  font-size: 1.5rem;
  margin-right: 0.6rem;
  margin-top: -3rem;
  box-shadow: rgb(0 0 0 / 14%) 0rem 0.25rem 1.25rem 0rem, rgb(64 64 64 / 40%) 0rem 0.4375rem 0.625rem -0.3125rem;
  justify-content: center;
  align-items: center;
}
</style>
