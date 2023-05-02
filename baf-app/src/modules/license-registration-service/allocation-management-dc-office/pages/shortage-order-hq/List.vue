<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.search') }}</h4>
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
                      id="fiscal_year"
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
                <ValidationProvider name="Allotment Installment" vid="allotment_count_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="allotment_count_id"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('allocation_management.allotment_count')}} <span class="text-danger">*</span>
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
                      {{ $t('allocation_dc_office.delivery_order_no') }}
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
                <ValidationProvider name="District" vid="district_id" rules="">
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
                <ValidationProvider name="Arrival Date From" vid="arrival_date_from" rules="" v-slot="{ errors }">
                  <b-form-group
                    label-for="arrival_date_from">
                    <template v-slot:label>
                      {{ $t('allocation_dc_office.delivery_date_from') }}
                    </template>
                    <date-picker
                      id="arrival_date_from"
                      v-model="search.arrival_date_from"
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
                <ValidationProvider name="Arrival Date To" vid="arrival_date_to" rules="" v-slot="{ errors }">
                  <b-form-group
                    label-for="arrival_date_to">
                    <template v-slot:label>
                      {{ $t('allocation_dc_office.delivery_date_to') }}
                    </template>
                    <date-picker
                      id="arrival_date_to"
                      v-model="search.arrival_date_to"
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
              <b-col sm="9">
              </b-col>
              <b-col sm="3" style="text-align: right;">
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
        <h4 class="card-title">{{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.list') }}</h4>
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
                   <template v-slot:cell(chalan)="data">
                    {{ $n(data.item.challan_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(arrival_date)="data">
                    {{ data.item.updated_at | dateFormat }}
                  </template>
                  <template v-slot:cell(fiscal_year)="data">
                    {{ getFiscalYear(data.item.fiscal_year_id) }}
                  </template>
                  <template v-slot:cell(allotment_count)="data">
                    {{ $n(data.item.allotment_count_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(dc_office_name)="data">
                    {{ getDistrictName(data.item.district_id) }}
                  </template>
                  <template v-slot:cell(delivery_order_no)="data">
                    {{ $n(data.item.delivery_order_no, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(is_shortage)="data">
                    <span  class="badge badge-warning" v-if="data.item.is_shortage === 1">
                       {{$t('globalTrans.pending')}}
                    </span >
                    <span  class="badge badge-primary" v-else-if="data.item.is_shortage === 2">
                         {{$t('allocation_dc_office.delivered')}}
                    </span>
                    <span  class="badge badge-success" v-else-if="data.item.is_shortage === 3">
                      {{$t('allocation_dc_office.received')}}
                    </span>
                  </template>
                  <template v-slot:cell(delivery_order_date)="data">
                    {{ data.item.created_at | dateFormat }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" class="action-btn edit" variant="iq-bg-success mr-1" v-b-modal.details @click="editMethodInParent(data.item,3)"> <i class="ri-eye-fill"></i></b-button>
                   <div v-if="isResionalOffice">
                     <b-button v-if="data.item.is_shortage === 1" :title="$t('allocation_dc_office.delivery')" class="action-btn btn-success" @click="deliveredList(data.item)"><i class="ri-stack-fill"></i></b-button>
                   </div>
                    <div v-else>
                      <b-button v-if="data.item.is_shortage === 2" :title="$t('allocation_dc_office.receive')" class="btn action-btn mx-2" v-b-modal.modal-5 @click="receive(data.item)" ><i class="ri-window-fill"></i></b-button>
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
    <b-modal id="modal-5" size="lg" :title="$t('allocation_dc_office.receive')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Receive :id="items" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="items" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
  import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
  import { shortageOrderWithDeliveryList } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import Receive from './Receive.vue'
  import Details from './Details.vue'

  export default {
    mixins: [ModalBaseMasterList],
    components: { Receive, Details },
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
          district_id: 0,
          arrival_date_from: '',
          arrival_date_to: '',
          limit: 10
        },
        items: [],
        viewitemId: 0,
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
          { labels: 'allocation_dc_office.challan', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.arrival_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
          { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
          { labels: 'allocation_management.allotment_count', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.dc_office_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.delivery_order_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
          { labels: 'allocation_dc_office.delivery_order_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } },
          { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9, thStyle: { width: '10%' } }
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
            { key: 'chalan' },
            { key: 'arrival_date' },
            { key: 'fiscal_year' },
            { key: 'allotment_count' },
            { key: 'dc_office_name' },
            { key: 'delivery_order_no' },
            { key: 'delivery_order_date' },
            { key: 'is_shortage' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'chalan' },
            { key: 'arrival_date' },
            { key: 'fiscal_year' },
            { key: 'allotment_count' },
            { key: 'dc_office_name' },
            { key: 'delivery_order_no' },
            { key: 'delivery_order_date' },
            { key: 'is_shortage' },
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
        return (this.editItemId === 0) ? this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.details') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
      },
      challanTitle () {
        return this.$t('allocation_dc_office.challan') + ' ' + this.$t('globalTrans.view')
      },
      deliveryTitle () {
        return this.$t('allocation_dc_office.delivery_order') + ' ' + this.$t('globalTrans.entry')
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
      officeList () {
        return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
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
       return this.$store.state.Auth.authUser.office_detail.office_type_id !== 23
      }
    },
    methods: {
      deliveredList (item) {
        this.id = item.id
        this.$router.push({ name: 'license_registration_service.shortage_order_delivered', params: { item: item } })
      },
      getFiscalYear (yearId) {
          const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
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
      // detailsData (viewitem) {
      //   this.items = viewitem
      // },
      receive (item) {
        this.items = item
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage, user_district_id: this.authDistrict })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, shortageOrderWithDeliveryList, params)
        if (result.success) {
          const listData = result.data.data.map((item, index) => {
            const productServiceData = {
              serial: index,
              delivery_order_no: item.delivery_order_no
            }
            return Object.assign({}, item, { serial: index }, productServiceData)
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
