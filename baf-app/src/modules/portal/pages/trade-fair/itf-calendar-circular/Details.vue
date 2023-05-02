<template>
    <div>
      <b-card>
        <b-row>
          <b-overlay :show="loading">
            <list-report-head :base-url="baseUrl" uri="/itf-report-head/report-head/detail" :org-id="2">
              <template v-slot:projectNameSlot>
                {{ }}
              </template>
              {{ $t('tradeFairInfoManagement.fair_calender_circular') }}
            </list-report-head>
            <b-row>
              <b-col sm="6"> <div class="mt-2"> {{$t('externalTradeFair.circular_memo_no')}} : {{ form.circular_memo_number }} </div></b-col>
              <b-col sm="6">
                <div class="text-right mt-2">{{ $t('globalTrans.date') + ' : ' + dateData(form.updated_at) }}</div>
              </b-col>
            </b-row>
            <b-row class="mt-3 mb-3">
              <b-col sm="12">
                <div class="text-left mt-1">
                   <b class="small font-weight-bold">{{ $t('externalTradeFair.subject') + ' : ' + getFiscalYear(form.fiscal_year_id) + ' ' + $t('portal.calendar_sub') }}</b>
                </div>
              </b-col>
            </b-row>
            <b-row class="mt-3 mb-3">
              <b-col sm="12">
                <div class="text-left mt-1">
                  {{ $t('portal.calendar_text_1') + ' ' + getFiscalYear(form.fiscal_year_id) + ' ' + $t('portal.calendar_text_2') + '' + fYear + ' ' + $t('portal.calendar_text_21')+ '' + lYear + ' ' + $t('portal.calendar_text_22') }}
                </div>
              </b-col>
            </b-row>
            <b-row class="mt-3 mb-3">
              <b-col sm="12">
                <div class="text-left mt-1">
                  {{ $t('portal.calendar_text_3') + ' ' + getFiscalYear(form.fiscal_year_id) + ' ' + $t('portal.calendar_text_4') + ' ' + dateData(form.submission_deadline) + ' ' + $t('portal.calendar_text_5') }}
                </div>
              </b-col>
            </b-row>
            <b-row class="mt-3 mb-3">
              <b-col sm="12">
                <div class="text-left mt-1">
                   <b class="small font-weight-bold">{{ $t('portal.calendar_format_txr') + ' ( ' + getFiscalYear(form.fiscal_year_id) + ' ):' }}</b>
                </div>
              </b-col>
            </b-row>
            <b-table-simple bordered hover small>
              <b-tbody>
                <tr>
                  <b-td class="text-center">{{ $t('globalTrans.sl_no') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_2') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_3') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_4') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_5') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_6') }}</b-td>
                  <b-td class="text-center">{{ $t('portal.calendar_td_7') }}</b-td>
                  <b-td class="text-center">{{ $t('portal.calendar_td_8') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_9') }}</b-td>
                  <b-td class="vertical_Text">{{ $t('portal.calendar_td_10') }}</b-td>
                  <b-td class="text-center">{{ $t('portal.calendar_td_11') }}</b-td>
                  <b-td class="text-center">{{ $t('portal.calendar_td_12') }}</b-td>
                  <b-td class="text-center">{{ $t('portal.calendar_td_13') }}</b-td>
                </tr>
                <tr>
                  <b-th class="text-center">{{ $n('1') }}</b-th>
                  <b-th class="text-center">{{ $n('2') }}</b-th>
                  <b-th class="text-center">{{ $n('3') }}</b-th>
                  <b-th class="text-center">{{ $n('4') }}</b-th>
                  <b-th class="text-center">{{ $n('5') }}</b-th>
                  <b-th class="text-center">{{ $n('6') }}</b-th>
                  <b-th class="text-center">{{ $n('7') }}</b-th>
                  <b-th class="text-center">{{ $n('8') }}</b-th>
                  <b-th class="text-center">{{ $n('9') }}</b-th>
                  <b-th class="text-center">{{ $n('10') }}</b-th>
                  <b-th class="text-center">{{ $n('11') }}</b-th>
                  <b-th class="text-center">{{ $n('12') }}</b-th>
                  <b-th class="text-center">{{ $n('13') }}</b-th>
                </tr>
              </b-tbody>
            </b-table-simple>
            <b-row class="mt-3 mb-3">
              <b-col sm="12">
                <div class="text-left mt-1">
                  {{ $t('globalTrans.attachment') + ': ' + $t('portal.calendar_att') }}
                </div>
              </b-col>
            </b-row>
          </b-overlay>
        </b-row>
      </b-card>
        <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import moment from 'moment'
export default {
  name: 'Details',
  props: ['id'],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      loading: false,
      form: {},
      deadline: '',
      fYear: '',
      lYear: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircular()
      this.form = tmp
      this.form.updated_at = tmp.updated_at
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(this.form.fiscal_year_id))
      if (fiscalYearObj !== 'undefined') {
        const year = fiscalYearObj.text_en.split('-')
        this.fYear = this.$n(year[0], { useGrouping: false })
        this.lYear = this.$n(year[1], { useGrouping: false })
      }
      // this.dateData(date)
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    dateData (fdate) {
      const date = moment(fdate).format('Do MMMM, YYYY')
      return date
    },
    getCircular () {
      this.loading = true
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      this.loading = false
      return JSON.parse(JSON.stringify(tmpData))
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    async pdfExport () {
      this.loading = true
      const params = Object.assign({ local: this.$i18n.locale, org_id: 2, id: this.id })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, '/portal/itf-calendar-circular-details', params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.loading = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
<style>
    /*Creation of vertical text in cell*/
    .vertical_Text {
      writing-mode: vertical-rl;
    };
</style>
