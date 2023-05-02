<template>
  <div class="inner-section">
    <card>
    </card>
    <body-card>
      <template v-slot:headerTitle v-if="appDetail.save_status === 2">
        <h4 class="card-title">{{ $t('dealer.application_form') }}</h4>
      </template>
      <template v-slot:body>
        <div v-if="loading">
          <Loading />
        </div>
        <div v-else>
          <div v-if="(!appDetail.id > 0) || enable_renew || enable_new || editStatus">
            <Form @submitForm="onSubmitForm()" :appDetail="appDetail" :isRenew="enable_renew" />
          </div>
          <div v-else>
            <div v-if="appDetail.save_status === 2">
              <Action @submitForm="onSubmitForm()" :appDetail="appDetail" @enableRenew="onEnableRenew()" />
              <AppStep @submitForm="onSubmitForm()" :appDetail.sync="appDetail" :applications="applications" @enableNew="onEnableNew()" />
            </div>
          </div>
        </div>
      </template>
    </body-card>
      <body-card v-if="(appDetail.save_status === 1 || appDetail.save_status === 2) && listStatus">
        <!-- table section start -->
        <template v-slot:headerTitle>
          <h4 class="card-title">{{ $t('license_management.application_list') }}</h4>
        </template>
        <template v-slot:headerAction>
        </template>
        <template v-slot:body>
          <b-overlay :show="loading">
            <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" />
              <b-row>
                <b-col md="12" class="table-responsive">
                  <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                    <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="applications" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                      <template v-slot:cell(serial)="data">
                        {{ $n(data.item.serial + pagination.slOffset) }}
                      </template>
                      <template v-slot:cell(date)="data">
                        {{ data.item.created_at | dateFormat }}
                      </template>
                      <template v-slot:cell(application_id)="data">
                        {{ $n(data.item.application_id, { useGrouping: false }) }}
                      </template>
                      <template v-slot:cell(applicant_name)="data">
                        {{ data.item.details.applicant_name }}
                      </template>
                      <template v-slot:cell(applicant_name_bn)="data">
                        {{ data.item.details.applicant_name_bn }}
                      </template>
                      <template v-slot:cell(mobile)="data">
                        {{ data.item.details.mobile | mobileNumber }}
                      </template>
                      <template v-slot:cell(district_id)="data">
                        {{ getDistrictName(data.item.details.company_district_id) }}
                      </template>
                      <template v-slot:cell(type)="data">
                        {{ getTypeName(data.item.type) }}
                      </template>
                      <template v-slot:cell(status)="data">
                        <span v-if="data.item.save_status === 1" class="badge badge-primary">{{$t('dealer.draft_status')}} </span>
                        <span v-else-if="data.item.pay_status === 0" class="badge badge-primary">{{$t('dealer.payment_list_status')}} </span>
                        <span v-else class="badge badge-primary">{{$t('dealer.application_processing')}}</span>
                      </template>
                      <template v-slot:cell(action)="data">
                        <b-button class="mr-2" :title="$t('globalTrans.details')" v-b-modal.modal-6 variant=" action-btn status mr-1" size="sm" @click="detailsView(data.item)"><i class="ri-eye-fill"></i></b-button>
                        <button v-if="data.item.save_status === 1" @click="editForm(data.item)" style="border-radius: 40px" size="sm" :title="$t('globalTrans.edit')" class="action-btn edit"><i class="ri-pencil-fill"></i></button>
                      </template>
                    </b-table>
                  </slot>
                </b-col>
              </b-row>
          </b-overlay>
        </template>
        <!-- table section end -->
      </body-card>
    <b-modal id="modal-6" size="lg" :title="$t('dealer.application_form')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Details :appDetail="appDetail" :applications="applications" :isModal="true" />
    </b-modal>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { applicationList, tcbPaymentStatusUpdate } from '../../api/routes'
import Form from './Form.vue'
import Loading from '../../../../../license-registration-service/license-management/components/loading/Details.vue'
import Action from './Action.vue'
import AppStep from './AppStep.vue'
import { EventBus } from '@/EventBusLayout'
import Details from './Details.vue'
import './step.css'

export default {
  name: 'List',
  components: {
    Form,
    Loading,
    Action,
    AppStep,
    Details
  },
  data () {
    return {
      loading: false,
      enable_renew: false,
      enable_new: false,
      applications: [],
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      appDetail: {
        id: 0,
        org_id: 0,
        region_id: 0,
        applicant_name: '',
        applicant_name_bn: '',
        fasp_name: '',
        fasp_name_bn: '',
        mobile: '',
        other_family_license: false,
        other_dealer_name: '',
        other_dealer_name_bn: '',
        other_company_name: '',
        other_company_name_bn: '',
        other_company_division_id: 0,
        other_company_district_id: 0,
        other_company_upazilla_id: 0,
        company_name: '',
        company_name_bn: '',
        company_division_id: 0,
        company_district_id: 0,
        company_upazilla_id: 0,
        office_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: 0,
        union_id: 0,
        village: '',
        village_bn: '',
        dob: '',
        nid_no: '',
        marital_status: 1,
        father_nid_no: '',
        spouse_nid_no: '',
        email: '',
        tin_no: '',
        applicant_image: [],
        trade_license: [],
        bank_solvency: [],
        nid: [],
        tin: [],
        shop_document: [],
        vat_certificate: [],
        citizen_certificate: [],
        save_status: 2,
        type: 1
      },
      editStatus: false,
      listStatus: true,
      labelData: [
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '18%' } },
        { labels: 'globalTrans.date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '5%' } },
        { labels: 'dealer.applicant_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '18%' } },
        { labels: 'dealer.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '10%' } }
      ]
    }
  },
  created () {
    this.getAppDetail()
    this.paymentStatusUpdate()
    EventBus.$on('offlinePaymentSubmit', this.onSubmitForm)
  },
  watch: {
  },
  computed: {
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'application_id' },
          { key: 'date' },
          { key: 'applicant_name_bn' },
          { key: 'mobile' },
          { key: 'district_id' },
          { key: 'type' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'application_id' },
          { key: 'date' },
          { key: 'applicant_name' },
          { key: 'mobile' },
          { key: 'district_id' },
          { key: 'type' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    }
  },
  methods: {
    editForm (value) {
      if (value.save_status === 1) {
        this.editStatus = true
        this.listStatus = false
      }
      //  this.editStatus = false
    },
    detailsView (item) {
      this.appDetail = item
    },
    editMethodInParent (item, type) {
    },
    async getAppDetail () {
        this.loading = true
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, applicationList, {})
        if (result.success) {
          this.appDetail = result.data
          this.applications = result.applications
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        this.loading = false
    },
    onSubmitForm () {
      this.enable_renew = false
      this.editStatus = false
      this.listStatus = true
      this.getAppDetail()
    },
    onEnableRenew () {
      this.enable_renew = true
      this.listStatus = false
    },
    onEnableNew () {
      this.enable_new = true
      this.listStatus = false
      this.appDetail = {}
    },
    async paymentStatusUpdate () {
      if (this.$route.params.status && this.$route.query.transId) {
        const status = this.$route.params.status
        const tranId = this.$route.query.transId
        await RestApi.getData(licenseRegistrationServiceBaseUrl, tcbPaymentStatusUpdate + status, { transId: tranId }).then(response => {
          if (response.success) {
            this.$toast.success({
              title: 'Success',
              message: response.message,
              color: '#D6E09B'
            })
          } else {
            this.$toast.error({
              title: 'Error',
              message: response.message
            })
          }
        })
        this.getAppDetail()
        this.$router.push('/dealer-panel/applications')
      }
    },
    showMoneyReceipt (itemId, appType, paymentTypeTd) {
      this.currentAppId = itemId
      this.applicationType = appType
      this.paymentTypeTd = paymentTypeTd
      this.$bvModal.show('modal-money-receipt')
    },
    getDistrictName (id) {
      const data = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getTypeName (id) {
      const data = this.$store.state.LicenseRegistrationService.commonObj.applicationTypeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    }
  }
}
</script>
