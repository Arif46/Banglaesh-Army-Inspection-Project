<template>
  <div class="inner-section">
    <card></card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('cip.moc_committee_approval') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-overlay :show="loading">
          <div v-if="headerActionShow">
            <a href="javascript:" class="btn-add mr-2" @click="downloadCipApplicants"> {{ $t('cip.all_verification') }}</a>
            <a href="javascript:" class="btn-add" @click="showModal"> {{ !showSendBtn ? $t('cip.sorting_send') : $t('cip.forward') }}</a>
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
    <b-modal id="modal-remark" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Remark :circular_id="circularId" :current_status="10" :status="11" :menu_name_id="3" :key="circularId"/>
    </b-modal>
    <b-modal id="modal-forward" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Forward />
    </b-modal>
  </div>
</template>
<script>
import CipApplicants from './CipApplicants.vue'
import CipTrades from './CipTrades.vue'
import Forward from './Forward.vue'
import Remark from '../Remark.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { mocCommitteeApprovalListApi, mocCommVerifiedAppsApi } from '../../api/routes'
import ExportPdf from '../Allverified'

export default {
  components: {
    CipApplicants,
    CipTrades,
    Forward,
    Remark
  },
  data () {
    return {
      headerActionShow: false,
      showSendBtn: false,
      overallApplication: 0,
      loading: false,
      previousRemark: null,
      meetingResolutionShow: false,
      circularId: 0,
      comp: 'CipApplicants',
      applications: [],
      currentAppStatus: 0,
      year: '',
      fiscalYear_en: '',
      fiscalYear_bn: '',
      search: {
        app_type: 1
      },
      appTypes: [
        { item: 1, text_en: 'Cip Applications', text_bn: 'সিআইপি অ্যাপ্লিকেশন' },
        { item: 2, text_en: 'Cip Trades', text_bn: 'সিআইপি ট্রেডস' }
      ],
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
    }
  },
  created () {
    this.loadData()
  },
  computed: {
    formTitle: function () {
      return !this.showSendBtn ? this.$t('globalTrans.remark') : this.$t('cip.forward')
    },
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
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, mocCommitteeApprovalListApi)
      this.loading = false
      if (result.success) {
        this.headerActionShow = true
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        // send button show when meeting resolution added
        if (this.overallApplication === result.total_app) {
          this.showSendBtn = true
        } else {
          this.showSendBtn = false
        }
        this.circularId = result.data.data[0].circular_id
      } else {
        this.headerActionShow = false
        this.$store.dispatch('setList', [])
        this.showSendBtn = false
        this.circularId = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      let total = 0
      const dataList = data.map((item, index) => {
        total = total + item.total_application
      })
      this.overallApplication = total
      return dataList
    },
    showModal () {
      if (!this.showSendBtn) {
        this.$bvModal.show('modal-remark')
      } else {
        this.$bvModal.show('modal-forward')
      }
    },
    async downloadCipApplicants () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = { circular_id: this.circularId }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, mocCommVerifiedAppsApi, params)
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
