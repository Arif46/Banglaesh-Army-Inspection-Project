<template>
  <div class="inner-section">
    <card></card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('cip.pmo_approval') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-overlay :show="loading">
          <div v-if="headerActionShow">
            <a href="javascript:" class="btn-add mr-2" @click="downloadCipApplicants"> {{ $t('cip.all_verification') }}</a>
            <a href="javascript:" class="btn-add mr-1" v-b-modal.modal-remark>{{ $t('cip.sorting_send') }}</a>
          </div>
        </b-overlay>
      </template>
      <template v-slot:body>
        <b-row>
            <b-col xl="6" lg="6" md="6" sm="6">
                <ValidationProvider>
                    <b-form-group
                        class="row"
                        label-for="app_type"
                        slot-scope="{ valid, errors }"
                        >
                        <b-form-radio-group
                            v-model="search.app_type"
                            :options="appTypeList"
                            value-field="item"
                            text-field="name"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-radio-group>
                        <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <component :is='comp' />
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-remark" size="md" :title="$t('globalTrans.remark')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Remark :circular_id="circularId" :current_status="16" :status="17" :menu_name_id="4" :key="circularId"/>
    </b-modal>
  </div>
</template>
<script>
import CipApplicants from './CipApplicants.vue'
import CipTrades from './CipTrades.vue'
import Remark from '../Remark.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { pmoApprovalListApi, pmoApprovalVerifiedAppsApi } from '../../api/routes'
import ExportPdf from '../Allverified'

export default {
  components: {
    CipApplicants,
    CipTrades,
    Remark
  },
  data () {
    return {
      loading: false,
      headerActionShow: false,
      comp: 'CipApplicants',
      circularId: 0,
      year: '',
      fiscalYear_en: '',
      fiscalYear_bn: '',
      search: {
        app_type: 1,
        receiver_id: this.$store.state.Auth.authUser.user_id
      },
      appTypes: [
        { item: 1, text_en: 'Cip Applications', text_bn: 'সিআইপি অ্যাপ্লিকেশন' },
        { item: 2, text_en: 'Cip Trades', text_bn: 'সিআইপি ট্রেডস' }
      ]
    }
  },
  created () {
    this.loadData()
  },
  computed: {
    listReload () {
      return this.$store.state.commonObj.listReload
    },
    appTypeList: function () {
      return this.appTypes.map(item => {
        return Object.assign({}, item, { name: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    }
  },
  watch: {
    listReload: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.app_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (parseInt(newVal) === 1) {
          this.comp = 'CipApplicants'
        } else {
          this.comp = 'CipTrades'
        }
      }
    }
  },
  methods: {
    async loadData () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, pmoApprovalListApi, this.search)
      this.loading = false
      if (result.success) {
        this.headerActionShow = true
        this.circularId = result.data.data[0].circular_id
      } else {
        this.headerActionShow = false
        this.circularId = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async downloadCipApplicants () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = { circular_id: this.circularId }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, pmoApprovalVerifiedAppsApi, params)
      this.loading = false
      if (result.success) {
          this.applications = this.getRelationalVerifiedData(result.data)
          this.pdfExport()
      } else {
          this.applications = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalVerifiedData (data) {
      const income = data[0].details[0].product_success_description[1]
      const circular = data[0].details[0].circular
      this.setYearFiscalYear(income, circular)
      const sectorList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const list = data.map((tmp, indx) => {
          const sector = sectorList.find(el => el.value === tmp.sector_id)

          const sectorObj = {
              sector_sl: indx,
              sector_name_en: typeof sector !== 'undefined' ? sector.text_en : '',
              sector_name_bn: typeof sector !== 'undefined' ? sector.text_bn : ''
          }

          const details = tmp.details.map((item, index) => {
              const orgData = {
                  detail_serial: index,
                  org_name_en: item.org_info !== null ? item.org_info.org_name_en : '',
                  org_name_bn: item.org_info !== null ? item.org_info.org_name_bn : ''
              }
              Object.assign({}, item, orgData)
          })
          return Object.assign({}, tmp, sectorObj, details)
      })

      return list
    },
    setYearFiscalYear (income, circular) {
      const tmpFis = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === income.fiscal_year_id)
      this.year = circular.year
      this.fiscalYear_bn = tmpFis.text_bn
      this.fiscalYear_en = tmpFis.text_en
    },
    pdfExport () {
      const reportTitle = this.$t('cip.cip_application_report_head')
      ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
    }
  }
}
</script>
