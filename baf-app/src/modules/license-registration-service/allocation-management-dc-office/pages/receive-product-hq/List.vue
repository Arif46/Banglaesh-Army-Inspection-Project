<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.receive_product') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <b-row>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year" rules="required|min_value:1">
                  <b-form-group
                    label-for="fiscal_year"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="search.fiscal_year_id"
                      :options="fiscalYearList"
                      id="fiscal_year_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Allotment Count" vid="allotment_count_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="allotment_count_id"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('allocation_dc_office.allonment_count')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="search.allotment_count_id"
                      :options="allotmentCount"
                      id="allotment_count_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Delivery Order No" vid="delivery_order_no" v-slot="{ errors }" rules="">
                  <b-form-group
                    label-for="delivery_order_no"
                  >
                    <template v-slot:label>
                      {{ $t('allocation_dc_office.delivery_no') }}
                    </template>
                    <b-form-input
                      v-model="search.delivery_order_no"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Delivery Date From" vid="delivery_date_from" rules="" v-slot="{ errors }">
                  <b-form-group
                    label-for="delivery_date_from">
                    <template v-slot:label>
                      {{ $t('allocation_dc_office.delivery_date_from') }}
                    </template>
                    <date-picker
                      id="delivery_date_from"
                      v-model="search.delivery_date_from"
                      class="form-control"
                      :placeholder="$t('globalTrans.select_date')"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :class="errors[0] ? 'is-invalid' : ''"
                    >
                    </date-picker>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Delivery Date To" vid="delivery_date_to" rules="" v-slot="{ errors }">
                  <b-form-group
                    label-for="delivery_date_to">
                    <template v-slot:label>
                      {{ $t('allocation_dc_office.delivery_date_to') }}
                    </template>
                    <date-picker
                      id="delivery_date_to"
                      v-model="search.delivery_date_to"
                      class="form-control"
                      :placeholder="$t('globalTrans.select_date')"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :class="errors[0] ? 'is-invalid' : ''"
                    >
                    </date-picker>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col sm="3">
                <b-button size="sm" type="submit" variant="primary" class="mt-20">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                </b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.receive_product') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial +1) }}
                  </template>
                  <template v-slot:cell(chalan_no)="data">
                    {{ $n(data.item.challan_id, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(allotment_count)="data">
                      {{ $n(data.item.allotment_count_id, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(dc_office_name)="data">
                    {{ getDistrictName(data.item.district_id) }} {{ $t('allocation_dc_office.dc_office') }}
                  </template>
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ getFiscalYear(data.item.fiscal_year_id) }}
                  </template>
                  <template v-slot:cell(delivery_order_no)="data">
                    {{ $n(data.item.delivery_order_no, { useGrouping: false }) }}
                  </template>
                  <!-- <template v-slot:cell(chalan_no)="data">
                    {{ $n(data.item.chalan_no) }}
                  </template> -->
                  <template v-slot:cell(distribution_date)="data">
                    {{ data.item.distribution_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-danger" v-if="data.item.status == 0">{{$t('license_management.pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.received')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <div style="width: 120px;">
                      <b-button v-b-modal.details variant="iq-bg-success mr-1" size="sm" @click="details(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                      <b-button :title="$t('globalTrans.payment')"  v-if="data.item.status != 0 && isResionalOffice" class="btn action-btn mx-2" v-b-modal.pay-view @click="challanPay(data.item)" ><i class="ri-bank-card-fill"></i></b-button>
                      <b-button v-b-modal.challan-view class="btn action-btn mx-2" @click="challanView(data.item)" :title="$t('allocation_dc_office.challan')"><i class="ri-window-2-line"></i></b-button>
                      <b-button v-b-modal.modal-5  v-if="data.item.status === 0  && isResionalOffice" variant="iq-bg-primary mr-1" size="sm" @click="receive(data.item)" class="action-btn active" :title="$t('allocation_dc_office.receive')"><i class="ri-file-chart-line m-0"></i></b-button>
                    </div>
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
     <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :item="items" :key="viewitemId"/>
    </b-modal>
     <b-modal id="challan-view" size="lg" :title="challanTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Challan :item="items" :key="ChallanItemId"/>
    </b-modal>
     <b-modal id="pay-view" size="lg" :title="paymentTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Payment :item="items" :key="ChallanItemId"/>
    </b-modal>
    <b-modal id="modal-5" size="lg" :title="$t('allocation_dc_office.receive')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Receive :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
  import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
  import { receiveProductList } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import Challan from './Challan.vue'
  import Details from './Details.vue'
  import Receive from './Receive.vue'
  import Payment from './Payment'
  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Payment,
      Challan,
      Details,
      Receive
    },
    data () {
      return {
        licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        search: {
          fiscal_year_id: 0,
          allotment_count_id: 0,
          delivery_order_no: '',
          delivery_date_from: '',
          delivery_date_to: '',
          limit: 10
        },
        valid: '',
        items: [],
        receiveData: [],
        viewitemId: 0,
        ChallanItemId: 0,
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
          { labels: 'allocation_dc_office.challan', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
          { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.allonment_count', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.dc_office_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '14%' } },
          { labels: 'allocation_dc_office.delivery_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '14%' } },
          { labels: 'allocation_dc_office.delivery_date', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '14%' } },
          { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '13%' } },
          { labels: 'globalTrans.action', class: 'text-center', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '20%' } }
        ],
        actions: {
          edit: false,
          details: true,
          toogle: false,
          delete: false
        }
      }
    },
    created () {
      this.loadData()
    },
    watch: {
      'search.limit': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.loadData()
        }
      }
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
            { key: 'serial' },
            { key: 'chalan_no' },
            { key: 'fiscal_year_id' },
            { key: 'allotment_count' },
            { key: 'dc_office_name' },
            { key: 'delivery_order_no' },
            { key: 'distribution_date' },
            { key: 'status' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'chalan_no' },
            { key: 'fiscal_year_id' },
            { key: 'allotment_count' },
            { key: 'dc_office_name' },
            { key: 'delivery_order_no' },
            { key: 'distribution_date' },
            { key: 'status' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      formTitle () {
        return (this.editItemId === 0) ? this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.entry') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
      },
      viewTitle () {
        return this.$t('allocation_dc_office.receive_product') + ' ' + this.$t('globalTrans.details')
      },
      challanTitle () {
        return this.$t('globalTrans.view')
      },
      paymentTitle () {
        return this.$t('allocation_dc_office.challan') + ' ' + this.$t('globalTrans.payment')
      },
      allotmentCount () {
        return this.$store.state.commonObj.gradeList.map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text }
          }
        })
      },
      fiscalYearList () {
        return this.$store.state.CommonService.commonObj.fiscalYearList
      },
      districtList () {
        const objectData = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1)
        return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn, text_bn: obj.text_bn, text_en: obj.text_en, no_of_beneficiary: 0 }
          } else {
            return { value: obj.value, text: obj.text_en, text_bn: obj.text_bn, text_en: obj.text_en, no_of_beneficiary: 0 }
          }
        })
      },
      warehouseList () {
        return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      },
      authDistrict () {
        const officeId = this.$store.state.Auth.authUser.office_detail.office_id
        return this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeId).district_id
      },
      isResionalOffice () {
        return this.$store.state.Auth.authUser.office_detail.office_type_id === 23
      }
    },
    methods: {
      receive (item) {
        this.editItemId = item.id
      },
      getFiscalYear (yearId) {
        const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fisCal => fisCal.value === yearId)
          if (cateObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
              return cateObj.text_bn
            } else {
              return cateObj.text_en
            }
          }
        },
      editMethodInParent (item, type) {
        if (type === 1) {
          this.edit(item)
        } else if (type === 2) {
          this.changeStatus(8, licenseRegistrationServiceBaseUrl, item)
        } else if (type === 3) {
          this.details(item)
        }
      },
      getDistrictName (id) {
        if (id) {
          const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
          if (this.$i18n.locale === 'bn') {
            return obj.text_bn
          } else {
            return obj.text_en
          }
        }
      },
      details (viewitem) {
        this.items = viewitem
      },
      challanView (item) {
        this.ChallanItemId = item.id
        this.items = item
      },
      challanPay (item) {
        this.ChallanItemId = item.id
        this.items = item
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage, district_id: this.authDistrict })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, receiveProductList, params)
        if (result.success) {
          const listData = result.data.data.map((item, index) => {
            return Object.assign({}, item, { serial: index })
          })
          this.$store.dispatch('setList', listData)
          this.paginationData(result.data, this.search.limit)
        } else {
          this.$store.dispatch('setList', [])
          this.paginationData([])
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      }
    }
  }
</script>
