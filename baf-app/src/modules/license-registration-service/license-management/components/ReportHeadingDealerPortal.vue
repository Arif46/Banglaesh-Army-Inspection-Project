<template>
    <b-row>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
         <!-- <div style="text-align: center;">
            <img src="@/assets/images/logo.png" class="img-fluid" alt="" style="width: 70px;">
          </div> -->
        </b-col>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
         <div style="text-align:center">
            <img src="@/assets/images/tcb_logo.png" class="img-fluid" alt="" style="width: 70px;">
          </div>
        </b-col>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
         <!-- <div style="text-align:center">
            <img src="@/assets/images/mujib.png" class="img-fluid" alt="" style="width: 70px;">
          </div> -->
        </b-col>
        <b-col xs="12" sm="12" md="7" lg="7" xl="7" offset="3" class="mt-4">
            <template v-if="this.$i18n.locale === 'bn'">
              <p style="font-weight: bold;font-size: 23px;margin-top: 3px; margin-left: 37px">ট্রেডিং কর্পোরেশন অব বাংলাদেশ</p>
            </template>
            <template v-else>
              <p style="font-weight: bold;font-size: 23px;margin-top: 3px; margin-left: 4px">Trading Corporation Of Bangladesh</p>
            </template>
            <p style="font-weight: ;font-size: 14px;margin-top: 5px; margin-left: 100px">{{$t('tcb_report.tcb_address')}}</p>
        </b-col>
    </b-row>
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
