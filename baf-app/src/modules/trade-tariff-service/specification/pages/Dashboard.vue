<template>
  <div class="section-wrapper">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">Dashboard</h4>
      </template>
      <!-- search section end -->
    </card>
    <b-row>
      <b-col sm="6">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/five.jpg" style="width:1300px; height: 300px" alt="">
        </b-card>
      </b-col>
      <b-col sm="6">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/two.jpg" style="width:1300px; height: 300px" alt="">
        </b-card>
      </b-col>
    </b-row>
    <b-row>
      <b-col sm="6">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/ten.jpg" style="width:1300px; height: 300px" alt="">
        </b-card>
      </b-col>
      <b-col sm="6">
        <b-card>
          <img class="img-fluid" src="../../../../assets/images/seven.jpg" style="width:1300px; height: 300px" alt="">
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>
<style scoped>
.trade_fire_wrapper .info-card {
  border-radius: 1rem;
  color: #fff;
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
  background: linear-gradient(90deg, #fe646f 0%, #dc3545 100%);
}

.trade_fire_wrapper .info-card.total {
  color: rgb(24, 18, 1);
  background: linear-gradient(90deg, #fcf05a 0%, #fdbd40 100%);
}
.trade_fire_wrapper .info-card.atended {
  background: linear-gradient(90deg, #177be7 0%, rgb(39 76 213) 100%);
}

.trade_fire_wrapper .info-card.remaining {
  background: linear-gradient(90deg, rgb(63, 179, 98) 0%, rgb(134, 227, 162) 100%);
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
  display: flex;
  align-items: center;
  color: #fff;
  padding: 1rem;
  border-radius: 1rem;
}
.trade_fire_participant .info-card.applicant{
  background: #48B5E4;
}
.trade_fire_participant .info-card.approved{
  background: #21C228;
}
.trade_fire_participant .info-card.peinding{
  background: #C96BE5;
}
.trade_fire_participant .info-card.reject{
  background: #F8576A;
}
.trade_fire_participant .info-card.paid{
  background: #6349F8;
}
.trade_fire_participant .info-card.unpaid{
  background: #E79B55;
}
.trade_fire_participant .info-card .atended{
  background: #55A6F8;
}
.trade_fire_participant .info-card .icon{
  font-size: 1.5rem;
  margin-right: .6rem;
}
</style>
