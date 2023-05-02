<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.fine_receipt') }}</h4>
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
                {{$t('bazarMonitoring.area_type')}}
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="0" vid="market_directory_id">
              <b-form-group
                  label-for="market_directory_id"
                  slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{$t('bazarMonitoring.market_name')}}
              </template>
              <b-form-select
                  plain
                  v-model="search.market_directory_id"
                  :options="marketDirectoryList"
                  id="market_directory_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="0" vid="mobile_no">
              <b-form-group
                label-for="mobile_no"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('priceMonitoring.mobile_no')}}
                </template>
                <b-form-input
                  v-model="search.mobile_no"
                  id="mobile_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
        <h4 class="card-title">{{ $t('priceMonitoring.fine_receipt') }}</h4>
      </template>
      <template v-slot:headerAction>
<!--        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>-->
        <router-link to="fine-receipt-form" class="btn-add"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(market_directory_ids)="data">
                    {{ getMarketDirectoryList(data.item.market_directory_ids) }}
                  </template>
                  <template v-slot:cell(no_of_cases)="data">
                    {{ $n(data.item.no_of_cases, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(date_of_conviction)="data">
                    {{ data.item.date_of_conviction| dateFormat }}
                  </template>
                  <template v-slot:cell(mobile_no)="data">
                    <slot v-if="data.item.mobile_no">
                      {{ data.item.mobile_no | numberConvert }}
                    </slot>
<!--                   {{ data.item.mobile_no ? (($i18n.locale === 'bn') ? '০' : '0' + $n(parseInt(data.item.mobile_no), { useGrouping: false })) : '' }}-->
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link v-if="!data.item.fine_details || (data.item.fine_details && data.item.fine_details.status === 1)" class="btn action-btn edit mr-1 btn-sm" :title="$t('globalTrans.edit')" size="sm" :to="{ name: 'bazar_monitoring_service.commodity_price_market_monitoring.fine_receipt_form', params: { item: data.item } }" ><i class="ri-pencil-fill m-0 "></i></router-link>
                    <b-button class="btn action-btn status mr-1 btn-sm" :title="$t('globalTrans.view')" v-b-modal.details variant=" iq-bg-primary mr-1" size="sm" @click="edit(data.item)"><i class="ri-eye-line m-0 "></i></b-button>
                    <template class="pb-3" v-if="data.item.fine_details && isFile(data.item.fine_details.attachment)">
                      <a :href="bazarMonitoringServiceBaseUrl + (isImage(data.item.fine_details.attachment) ? 'storage/' : '') + data.item.fine_details.attachment" target="_blank" :title="$t('globalTrans.download')" class="btn btn-sm btn-success action-btn" download><i class="ri-download-cloud-line"></i></a>
<!--                      <a :href="bazarMonitoringServiceBaseUrl + 'download-attachment?file=app/public/' +  (isImage(data.item.fine_details.attachment) ? data.item.fine_details.attachment : data.item.fine_details.attachment.replace('storage/', ''))" target="_blank" :title="$t('globalTrans.download')" class="btn btn-sm btn-success action-btn" download><i class="ri-download-cloud-line"></i></a>-->
                    </template>
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
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="$t('priceMonitoring.fine_receipt') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('priceMonitoring.fine_receipt') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="editItemId" :key="editItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { accusedPersonInfoList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
  { label_en: i18n.messages.en.globalTrans.division, label_bn: i18n.messages.bn.globalTrans.division, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.district, label_bn: i18n.messages.bn.globalTrans.district, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.upazila, label_bn: i18n.messages.bn.globalTrans.upazila, class: 'text-center', sortable: true, stickyColumn: true, show: '0', order: 4, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.bazarMonitoring.market_name, label_bn: i18n.messages.bn.bazarMonitoring.market_name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.priceMonitoring.complain_no, label_bn: i18n.messages.bn.priceMonitoring.complain_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.priceMonitoring.accused_person_org, label_bn: i18n.messages.bn.priceMonitoring.accused_person_org, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.mobile, label_bn: i18n.messages.bn.globalTrans.mobile, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.priceMonitoring.date_of_conviction, label_bn: i18n.messages.bn.priceMonitoring.date_of_conviction, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 10, thStyle: { width: '10%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      sortBy: '',
      search: {
        market_directory_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        mobile_no: '',
        limit: 20
      },
      editItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      pauroshobaList: [],
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_directory_id: this.addressCustomUser.market_id,
        divisionList: JSON.stringify(this.loggedUserPrivilege.division_id),
        districtList: JSON.stringify(this.loggedUserPrivilege.district_id),
        upazilaList: JSON.stringify(this.loggedUserPrivilege.upazila_id),
        marketList: JSON.stringify(this.loggedUserPrivilege.market_id)
      })
    }
    if (this.$store.state.Auth.activeRoleId === 1 || this.loggedUserPrivilege.area_type_id) {
      this.loadData()
    } else {
      this.$store.dispatch('setList', [])
    }
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.area_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getAreaMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.marketDirectoryList = this.getDivMarketList(newVal)
      } else {
        this.districtList = []
        this.marketDirectoryList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
        this.marketDirectoryList = this.getDisMarketList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
        this.marketDirectoryList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
        this.marketDirectoryList = this.getUpaMarketList(newVal)
      } else {
        this.unionList = []
        this.pauroshobaList = []
        this.marketDirectoryList = []
      }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getCityMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getPauroMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'search.union_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getUniMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
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
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'upazila_name_bn' },
          { key: 'market_name_bn' },
          { key: 'case_number' },
          { key: 'accused_person_name_bn' },
          { key: 'mobile_no' },
          { key: 'date_of_conviction' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'division_name_en' },
          { key: 'district_name_en' },
          { key: 'upazila_name_en' },
          { key: 'market_name_en' },
          { key: 'case_number' },
          { key: 'accused_person_name_en' },
          { key: 'mobile_no' },
          { key: 'date_of_conviction' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('priceMonitoring.fine_receipt') + ' ' + this.$t('globalTrans.entry') : this.$t('priceMonitoring.fine_receipt') + ' ' + this.$t('globalTrans.modify')
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
    currentLocale () {
      return this.$i18n.locale
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    edit (item) {
      this.editItemId = item.id
      this.item = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, accusedPersonInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const division = this.divisionList.find(obj => obj.value === parseInt(item.division_id))
          const district = this.$store.state.CommonService.commonObj.districtList.find(obj => obj.value === parseInt(item.district_id))
          const upazila = this.$store.state.CommonService.commonObj.upazilaList.find(obj => obj.value === parseInt(item.upazila_id))
          const market = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(obj => obj.value === parseInt(item.market_directory_id))
          const customItem = {
            division_name_en: division?.text_en,
            division_name_bn: division?.text_bn,
            district_name_en: district?.text_en,
            district_name_bn: district?.text_bn,
            upazila_name_en: upazila?.text_en,
            upazila_name_bn: upazila?.text_bn,
            market_name_en: market?.text_en,
            market_name_bn: market?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getMarketDirectoryList (marketIds) {
        const arr = []
        if (marketIds.constructor === Array) {
            marketIds.forEach(item => {
            const marketId = this.marketDirectoryList.find(obj => obj.value === item)
            const marketName = this.currentLocale === 'en' ? ' ' + marketId.text_en : ' ' + marketId.text_bn
            arr.push(marketName)
            })
        }
        return arr.toString()
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getAreaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === id)
    },
    getDivMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.division_id === id)
    },
    getDisMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUpaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getUniMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.union_id === id)
    },
    getPauroMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.pauroshoba_id === id)
    },
    getCityMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    },
    isFile (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg|docs|doc|pdf|csv|xsl|xslx|ppt|pptx)$/.test(path)
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
