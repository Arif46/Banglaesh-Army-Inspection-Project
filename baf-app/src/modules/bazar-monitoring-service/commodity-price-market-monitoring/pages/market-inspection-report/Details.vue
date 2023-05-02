<template>
  <b-row>
   <b-row>
        <b-col lg="12" sm="12">
          <iq-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-overlay :show="loading">
                      <b-row>
                        <b-col>
                          <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                            <template v-slot:projectNameSlot>
                              {{ }}
                            </template>
                            <u>{{ $t('priceMonitoring.inspection_report_title') }}</u>
                          </list-report-head>
                        </b-col>
                      </b-row>
                      <b-row>
                        <b-col lg="12" sm="12">
                          <div>
                            <b-table-simple  class="table table-borderless">
                                <b-tr v-if="detailsData.user_id">
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(1) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.inspector_name_des') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ ((this.$i18n.locale=='en')? officer.name : officer.name_bn) + ', ' + ((this.$i18n.locale=='en')? detailsData.designation_name : detailsData.designation_name_bn) + ', ' + ((this.$i18n.locale=='en')? detailsData.office_name : detailsData.office_name_bn) + ', ' + ((this.$i18n.locale=='en')? detailsData.org_name : detailsData.org_name_bn) }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(2) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.inspection_date') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ detailsData.inspection_date| dateFormat }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(3) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.inspection_market_name') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ getMarketDirectoryList(detailsData.market_directory_ids ) }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(4) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.case_no_if_any') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ $n(detailsData.no_of_cases, { useGrouping: false }) }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(5) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.inspection_des') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ detailsData.remarks }}</b-td>
                                </b-tr>
                                <b-tr v-if="detailsData.inspect_by === 1">
                                  <b-td style="width:8%"></b-td>
                                  <b-td colspan="3" style="width:51%">{{ $t('priceMonitoring.designation_ko') }}</b-td>
                                </b-tr>
                                <b-tr v-if="detailsData.inspect_by === 2">
                                  <b-td style="width:8%"></b-td>
                                  <b-td colspan="3" style="width:51%">{{ $t('priceMonitoring.designation_kho') }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(6) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('priceMonitoring.market_rate_att') }}</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-left" style="width:40%">{{ $t('priceMonitoring.scheme_attached') }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%">{{ currentLocale === 'bn' ? '০' : '0'}}{{ $n(7) + ' |' }}</b-td>
                                  <b-td style="width:51%">{{ $t('globalTrans.remarks') }} ({{ $t('priceMonitoring.attach_additional_paper_if_necessary') }})</b-td>
                                  <b-td class="text-center" style="width:2%">:</b-td>
                                  <b-td class="text-center" style="width:2%"></b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td style="width:8%"></b-td>
                                  <b-td colspan="3">{{ detailsData.extra_remarks }}</b-td>
                                </b-tr>
                            </b-table-simple>
                            <b-table-simple  class="table table-borderless" style="margin-top:100px">
                              <b-tr>
                                <b-td style="width:4%; padding-bottom:0px"></b-td>
                                <b-td style="width:6%; padding-bottom:0px">{{ $t('globalTrans.date') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:15%; padding-bottom:0px">{{today | dateFormat}}</b-td>
                                <b-td style="width:13%; padding-bottom:0px">{{ $t('globalTrans.signature') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:25%; padding-bottom:0px"></b-td>
                              </b-tr>
                              <b-tr>
                                <b-td style="width:4%"></b-td>
                                <b-td style="width:6%"></b-td>
                                <b-td class="text-center" style="width:2%"></b-td>
                                <b-td class="text-left" style="width:15%"></b-td>
                                <b-td style="width:13%; padding-top:0px; padding-bottom:0px">{{ $t('priceMonitoring.officer_name') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-top:0px; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:25%; padding-top:0px; padding-bottom:0px">{{ this.$i18n.locale=='en' ? officer.name : officer.name_bn }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-td style="width:4%"></b-td>
                                <b-td style="width:6%"></b-td>
                                <b-td class="text-center" style="width:2%"></b-td>
                                <b-td class="text-left" style="width:15%"></b-td>
                                <b-td style="width:13%; padding-top:0px; padding-bottom:0px">{{ $t('globalTrans.designation') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-top:0px; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:25%; padding-top:0px; padding-bottom:0px">{{ this.$i18n.locale=='en' ? detailsData.designation_name : detailsData.designation_name_bn }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-td style="width:4%"></b-td>
                                <b-td style="width:6%"></b-td>
                                <b-td class="text-center" style="width:2%"></b-td>
                                <b-td class="text-center" style="width:15%"></b-td>
                                <b-td style="width:13%; padding-top:0px; padding-bottom:0px">{{ $t('priceMonitoring.office_d') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-top:0px; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:25%; padding-top:0px; padding-bottom:0px">{{ this.$i18n.locale=='en' ? detailsData.org_name : detailsData.org_name_bn }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-td style="width:4%"></b-td>
                                <b-td style="width:6%"></b-td>
                                <b-td class="text-center" style="width:2%"></b-td>
                                <b-td class="text-center" style="width:15%"></b-td>
                                <b-td style="width:13%; padding-top:0px; padding-bottom:0px">{{ $t('globalTrans.mobile') }}</b-td>
                                <b-td class="text-center" style="width:2%; padding-top:0px; padding-bottom:0px">:</b-td>
                                <b-td class="text-left" style="width:25%; padding-top:0px; padding-bottom:0px">{{ officer.mobile | mobileNumber }}</b-td>
                              </b-tr>
                            </b-table-simple>
                          </div>
                        </b-col>
                      </b-row>
                    </b-overlay>
                  </b-col>
              </b-row>
            </template>
          </iq-card>
        </b-col>
      </b-row>
  </b-row>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { userListByDesignWise, marketInspectionPdf } from '../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
const today = new Date().toISOString().substr(0, 10)

export default {
  name: 'Details',
  mixins: [bazarMonitoringServiceMixin],
  props: ['id'],
  components: {
    ListReportHead
  },
  data () {
    return {
      valid: null,
      loading: false,
      today: today,
      errors: [],
      detailsData: [],
      officer: {},
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMarketInspectionReportDetails()
      if (tmp.user_id) {
        this.findUser(tmp.user_id)
      }
      this.detailsData = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getMarketInspectionReportDetails () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getMarketDirectoryList (marketIds) {
      const arr = []
      if (marketIds.constructor === Array) {
        marketIds.forEach(item => {
        const marketId = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(obj => obj.value === item)
        const marketName = this.$i18n.locale === 'en' ? ' ' + marketId.text_en : ' ' + marketId.text_bn
        arr.push(marketName)
        })
      }
      return arr.toString()
    },
    findUser (userId) {
      this.loading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          this.loading = false
          this.officer = response.data.find(user => user.id === userId)
        }
        this.loading = false
      })
    },
    async pdfExport () {
      this.loading = true
      const params = Object.assign({ local: this.$i18n.locale, org_id: 11, id: this.id, officer_name: this.officer.name, officer_name_bn: this.officer.name_bn, mobile: this.officer.mobile })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(bazarMonitoringServiceBaseUrl, marketInspectionPdf, params)
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
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
