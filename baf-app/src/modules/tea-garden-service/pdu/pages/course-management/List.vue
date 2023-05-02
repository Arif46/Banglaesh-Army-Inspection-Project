<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('dealer.application') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Area Type" vid="area_type_id">
              <b-form-group
                label-for="area_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.area_type')}}
              </template>
              <b-form-select
                plain
                v-model="search.area_type_id"
                :options="areaTypeList"
                id="area_type_id"
                  :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="Division" vid="division_id">
              <b-form-group
                label-for="division_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.division')}}
              </template>
              <b-form-select
                plain
                v-model="search.division_id"
                :options="divisionList"
                id="division_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="District" vid="district_id">
              <b-form-group
                label-for="district_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.district')}}
              </template>
              <b-form-select
                plain
                v-model="search.district_id"
                :options="districtList"
                id="district_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1">
            <ValidationProvider name="City Corporation" vid="city_corporation_id">
              <b-form-group
                label-for="city_corporation_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.city_corporation')}}
              </template>
              <b-form-select
                plain
                v-model="search.city_corporation_id"
                :options="corporationList"
                id="city_corporation_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="Upazila" vid="upazila_id">
              <b-form-group
                label-for="upazila_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.upazila')}}
              </template>
              <b-form-select
                plain
                v-model="search.upazila_id"
                :options="upazilaList"
                id="upazila_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2">
            <ValidationProvider name="Pauroshoba" vid="pauroshoba_id">
              <b-form-group
                label-for="pauroshoba_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.pouroshova')}}
              </template>
              <b-form-select
                plain
                v-model="search.pauroshoba_id"
                :options="pauroshobaList"
                id="pauroshoba_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 3">
            <ValidationProvider name="Union" vid="union_id">
              <b-form-group
                label-for="union_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.union')}}
              </template>
              <b-form-select
                plain
                v-model="search.union_id"
                :options="unionList"
                id="union_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="3" class="mt-3">
            <b-button size="sm" variant="primary" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('dealer.application') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
<!--        <router-link to="tea-garden-application-form" class="btn-add"  v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>-->
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col sm="12">
              <div class="quick-filter-wrapper">
                <div class="quick-filter-left">
                  <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
                    <b-dropdown-form>
                      <div
                        class="form-group"
                        v-for="(field, index) in labelData"
                        :key="index"
                        >
                          <b-form-checkbox
                            :id="'checkbox-' + field.label_en"
                            v-model="field.show"
                            :name="'checkbox-' + field.label_en"
                            value=1
                            unchecked-value=0
                          >
                            {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
                          </b-form-checkbox>
                      </div>
                    </b-dropdown-form>
                  </b-dropdown>
                </div>
                <div class="quick-filter-right">
                  <b-form-group
                    :label="$t('menu.perpage')"
                    label-for="per-page-select"
                  >
                    <b-form-select
                      id="per-page-select"
                      v-model="search.limit"
                      :options="pageOptions"
                      size="sm"
                    ></b-form-select>
                  </b-form-group>
                </div>
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ getFiscalYearName(data.item.fiscal_year_id) }}
                  </template>
                  <template v-slot:cell(app_id)="data">
                    {{ data.item.app_id }}
                  </template>
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.application_date | dateFormat }}
                  </template>
                  <template v-slot:cell(circular_id)="data">
                    {{ getCircularName(data.item.circular_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    {{ getStatus(data.item.status) }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <!-- payment routes -->
                   <router-link class="moc-action-btn moc-payment-btn" :to="`payment/${data.item.id}?from=tea_garden_service.pdu.course_application`" v-if="data.item.status === 3 && data.item.payment_status == 0" :title="$t('teaGardenBtriService.payment_for')">
                      <i class="ri-secure-payment-line"></i>
                    </router-link>
                    <!-- payment receipt  -->
                    <b-button v-b-modal.modal-6 class="moc-action-btn moc-payment-receipt-btn" :title="$t('externalLrcpn.payment_receipt')" @click="paymentInfoShow(data.item)" v-if="data.item.status === 4">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <router-link class="moc-action-btn moc-view-btn" :to="'course-application/'+data.item.id" :title="$t('globalTrans.view')">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <b-button class="moc-action-btn moc-edit-btn" v-if="data.item.status === 1" @click="editData(data.item)" :title="$t('globalTrans.edit')">
                      <i class="ri-pencil-fill"></i>
                    </b-button>
                    <b-button class="moc-action-btn moc-assign-btn" :title="$t('globalTrans.verify')" @click="verify(data.item)" v-if="!isGardenAdminCheckGardenId() && data.item.status === 2">
                      <i class="ri-newspaper-line"></i>
                    </b-button>
                    <router-link class="moc-action-btn moc-forward-btn" v-if="data.item.status === 5" :to="'course-application-certificate/'+data.item.id" :title="$t('globalTrans.certificate')">
                      <i class="ri-file-paper-2-line"></i>
                    </router-link>
                  </template>
                </b-table>
              </slot>
              <div class="pagination-wrapper mt-3" v-if="columns.filter(item => item.show === '1').length > 0">
                <b-pagination
                  v-model="pagination.currentPage"
                  :perPage="search.limit"
                  :total-rows="pagination.totalRows"
                  @input="searchData"
                />
               </div>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <!-- payment receipt modal  -->
    <b-modal id="modal-6" size="lg" :title="$t('externalLrcpn.payment_receipt')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
     <template #modal-title class="flex-grow-1">
       {{ $t('externalLrcpn.payment_receipt') }}
       <b-button variant="primary" @click="pdfExportPayment" class="mr-2 float-right">
         {{  $t('globalTrans.export_pdf') }}
       </b-button>
     </template>
        <PaymentInfo :id="item.id" :item="item" ref="paymentInfo"/>
    </b-modal>
  </div>
</template>
<script>

import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { applicantInfoListApi, applicantInfoVerifyApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/route-based-list'
import i18n from '@/i18n'
import PaymentInfo from './Payment/PaymentInfo.vue'
import teaGardenService from '@/mixins/tea-garden-service'
const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.fiscal_year, label_bn: i18n.messages.bn.globalTrans.fiscal_year, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
  { label_en: i18n.messages.en.globalTrans.applicant_name, label_bn: i18n.messages.bn.globalTrans.applicant_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
  { label_en: i18n.messages.en.approvalProcess.app_id, label_bn: i18n.messages.bn.approvalProcess.app_id, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
  { label_en: i18n.messages.en.teaGardenPanel.application_date, label_bn: i18n.messages.bn.teaGardenPanel.application_date, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.teaGardenPduService.circular_name, label_bn: i18n.messages.bn.teaGardenPduService.circular_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8 }
]
export default {
  mixins: [ModalBaseMasterList, teaGardenService],
  components: {
    PaymentInfo
  },
  data () {
    return {
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      search: {
        tea_garden_gen_info_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        tea_company_id: 0,
        user_id: this.$store.state.Auth.authUser.user_id,
        limit: 20
      },
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      pauroshobaList: [],
      labelData: [],
      editItemId: 0,
      item: {
        id: 0
      }
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
      } else {
        this.unionList = []
        this.pauroshobaList = []
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_id' },
          { key: 'applicant_name_bn' },
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'circular_id' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_id' },
          { key: 'applicant_name_en' },
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'circular_id' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    detailsTitle () {
      return this.$t('externalUser.export_data_application_form') + ' ' + this.$t('globalTrans.details')
    },
    certificateTitle () {
      return this.$t('dealer.application') + ' ' + this.$t('globalTrans.certificate')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    authUser () {
      return this.$store.state.Auth.authUser
    }
  },
  methods: {
    editData (item) {
      if (this.authUser.user_type === 1) {
        this.$router.push(`course-application-form?id=${item.id}`)
      } else {
        // if (.application_type === 2) {
        //   this.$router.push(`/tea-garden-panel/tea-garden-renew-application-form/${.parent.taggable.id}?id=${item.id}`)
        // } else {
        //   this.$router.push(`/tea-garden-panel/tea-garden-application-form?id=${item.id}`)
        // }
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, applicantInfoListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
            return Object.assign({ serial: index }, item)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    details (item) {
      this.editItemId = item.id
    },
    getFiscalYearName (id) {
      const obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
    },
    getCircularName (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.pduCircularList.find(item => item.value === id)
      return this.currentLocate === 'en' ? obj?.text_en : obj?.text_bn
    },
    getStatus (status) {
      let statusText
      if (status === 1) {
        statusText = this.$t('globalTrans.draft')
      } else if (status === 2) {
        statusText = this.$t('globalTrans.pending')
      } else if (status === 3) {
        statusText = this.$t('globalTrans.verified')
      } else if (status === 4) {
        statusText = this.$t('teaGardenPduService.confirmed')
      } else {
        statusText = this.$t('teaGardenPduService.certified')
      }
      return statusText
    },
    pdfExport () {
      this.$refs.certificate.pdfExport()
    },
    pdfExportPayment () {
      this.$refs.paymentInfo.pdfExport()
    },
    paymentInfoShow (item) {
      this.item = item
    },
    verify (item) {
      window.vm.$swal({
        title: window.vm.$t('teaGardenBtriService.verify_confirm_msg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
          RestApi.deleteData(teaGardenServiceBaseUrl, `${applicantInfoVerifyApi}/${item.id}`).then(response => {
            if (response.success) {
              window.vm.$toast.success({
                title: window.vm.$t('globalTrans.success'),
                message: window.vm.$t('globalTrans.update_msg'),
                color: '#D6E09B'
              })
            } else {
              window.vm.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
              })
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
          })
        }
      })
    }
  }
}
</script>

<style>
  table#table-transition-example .flip-list-move {
    transition: transform 1s;
  }
  .modal-title {
    flex-grow: 1 !important;
  }
  .blinking {
    animation: 1s blink ease infinite;
  }

  @keyframes blink {

    from,
    to {
      opacity: 0;
    }

    50% {
      opacity: 1;
    }
  }
</style>
