<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="fiscal_year"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }}
                </template>
                <b-form-select
                  plain
                  id="fiscal_year"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="allotment_count"
              >
                <template v-slot:label>
                  {{ $t('allocation_management.allotment_count') }}
                </template>
                <b-form-select
                  plain
                  id="allotment_count"
                  :options="allotmentCount"
                  v-model="search.allotment_count"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Delivery Order No" vid="delivery_order_no" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="delivery_order_no">
                <template v-slot:label>
                  {{ $t('allocation_dc_office.delivery_order_no') }}
                </template>
                <b-form-input
                  id="dispatch_no"
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
              <ValidationProvider name="Delivery Order From Date" vid="start_date" rules="" v-slot="{ errors }">
                <b-form-group
                  label-for="start_date">
                  <template v-slot:label>
                    {{ $t('allocation_dc_office.start_date') }}
                  </template>
                  <date-picker
                    id="start_date"
                    v-model="search.start_date"
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
              <ValidationProvider name="Delivery Order To Date " vid="end_date" rules="" v-slot="{ errors }">
                <b-form-group
                  label-for="end_date">
                  <template v-slot:label>
                    {{ $t('allocation_dc_office.end_date') }}
                  </template>
                  <date-picker
                    id="end_date"
                    v-model="search.end_date"
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
          <b-col offset-md="9" md="3" style="text-align: right;">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
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
        <h4 class="card-title">{{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link class="btn-add" to="delivery-order-hq/add"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(delivery_order_no)="data">
                    {{ $n(data.item.delivery_order_no, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(fiscal_year)="data">
                    {{ getFiscalYear(data.item.fiscal_year_id) }}
                  </template>
                  <template v-slot:cell(allotment_count)="data">
                    {{ $n(data.item.allotment_count_id, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(delivery_date)="data">
                    {{ data.item.created_at | dateFormat}}
                  </template>
                  <template v-slot:cell(regional_office)="data">
                   {{regionName(data.item.regional_office_id)}}
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button :title="$t('globalTrans.details')" class="action-btn btn-warning view" v-b-modal.details @click="detailsData(data.item)"> <i class="ri-eye-fill"></i></b-button>
                     <b-button v-if="data.item.is_draft" :title="$t('globalTrans.edit')" class="action-btn btn-info edit" @click="editMethodInParent(data.item)"> <i class="ri-pencil-fill"></i></b-button>
                     <b-button v-if="data.item.is_draft" :title="$t('globalTrans.save')" class="action-btn btn-success view" @click="makePublished(data.item)"> <i class="ri-calendar-check-fill"></i></b-button>
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
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :items="items"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { deliveryOrderList, deliveryOrderFinalSave } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        fiscal_year_id: 0,
        allotment_count: 0,
        delivery_order_no: '',
        star_date: '',
        end_date: '',
        limit: 10
      },
      id: 0,
      items: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'allocation_dc_office.delivery_order_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'allocation_management.allotment_count', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'allocation_dc_office.delivery_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'allocation_dc_office.regional_office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '15%' } }
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
          { key: 'delivery_order_no' },
          { key: 'fiscal_year' },
          { key: 'allotment_count' },
          { key: 'delivery_date' },
          { key: 'regional_office' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'delivery_order_no' },
          { key: 'fiscal_year' },
          { key: 'allotment_count' },
          { key: 'delivery_date' },
          { key: 'regional_office' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_dc_office.delivery_order') + ' ' + this.$t('globalTrans.entry') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_dc_office.delivery_order') + ' ' + this.$t('globalTrans.details') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
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
    warehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
    }
  },
  methods: {
    makePublished (item) {
      this.$swal({
        title: this.$t('globalTrans.final_save_msg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.confirmData(item)
        }
      })
    },
   async confirmData (item) {
      let result = null
      this.loadingState = true
     this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, deliveryOrderFinalSave + '/' + item.id)
      if (result.success) {
        this.loadingState = false
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: 'Data saved successfully',
          color: '#D6E09B'
        })
        this.loadData()
      }
    },
    editMethodInParent (item) {
      this.items = item
      this.id = item.id
      this.$router.push({ name: 'license_registration_service.delivery_order_hq_edit', params: { item: item } })
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
    detailsData (viewitem) {
      this.items = viewitem
    },
    searchData () {
      this.loadData()
    },
    regionName (region, lang = this.$i18n.locale) {
      const data = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1).find(item => item.value === region)
      if (data !== undefined) {
        if (lang === 'bn') {
          return data.text_bn
        } else {
          return data.text_en
        }
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, deliveryOrderList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', { loading: false, listReload: false })
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
