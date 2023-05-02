<template>
      <div class="row" style="width: 75%;margin: auto; margin-top:25px">
          <div class="col-2" style="text-align: center;">
            <img src="@/assets/images/logo.png" class="img-fluid" alt="" style="width: 70px;">
          </div>
          <div class="col-8" style="text-align:center; margin-top: 10px;">
            <p style="font-weight: 600;font-size: 18px;margin-top: 5px;">{{$t('tcb_report.government_text')}}</p>
            <p style="font-weight: 500;font-size: 16px;margin-top: 3px;">{{$t('tcb_report.trading_corporation_of_bangladesh')}}</p>
            <p style="font-weight: ;font-size: 14px;margin-top: 3px;">{{$t('tcb_report.tcb_address')}}</p>
          </div>
          <div class="col-2" style="text-align:center">
            <img src="@/assets/images/tcb_logo.png" class="img-fluid" alt="" style="width: 70px;">
          </div>
      </div>
</template>
<script>
  export default {
  name: 'ReportHeading',
  props: ['id'],
  data () {
    return {}
  }
}
</script>
