<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('bazarMonitoring.market_assign') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                    <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{$t('globalTrans.org_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="search.org_id"
                        :options="orgList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        @input="userPrivilegeData()"
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
                <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                    <b-form-group
                        label-for="office_type_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('userManagement.office_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="search.office_type_id"
                        :options="officeTypeList"
                        id="office_type_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        @input="userPrivilegeData()"
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
                <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                    <b-form-group
                        label-for="office_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('userManagement.office')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="search.office_id"
                        :options="officeList"
                        id="office_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        @input="userPrivilegeData()"
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
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Market Diretory" vid="market_id">
                    <b-form-group
                        label-for="market_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.market_name')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.market_id"
                        :options="marketList"
                        id="market_id"
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
            <b-col sm="12" class="mt-12 text-right">
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
        <h4 class="card-title">{{ $t('bazarMonitoring.market_assign') }} {{ $t('globalTrans.list') }}</h4>
      </template>
       <template v-slot:headerAction>
        <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
        <router-link  class="btn-add" to="market-assign-form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-danger" v-if="data.item.status == 2">{{$t('priceMonitoring.unpublish')}}</span>
                    <span class="badge badge-success" v-if="data.item.status == 3">{{$t('priceMonitoring.published')}}</span>
                  </template>
                   <template v-slot:cell(price_collection_date)="data">
                      {{ data.item.price_collection_date | dateFormat }}
                    </template>
                   <template v-slot:cell(mobile)="data">
                      <span v-if="data.item.mobile">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(data.item.mobile, { useGrouping: false }) }}</span>
                    </template>
                  <template v-slot:cell(action)="data">
                    <!-- <router-link class="action-btn edit" :title="$t('globalTrans.edit')" :to="{ name: 'bazar_monitoring_service.configuration.price_form', params: { id: data.item.id, latitude: data.item.latitude, longitude: data.item.longitude }}" size="sm">
                      <i class="ri-pencil-fill"></i>
                    </router-link> -->
                    <b-button variant=" iq-bg-info" v-if="data.item.status == 2" size="sm" @click="publishStatus(data.item)" class="action-btn approve" :title="$t('globalTrans.delete')"><i class="ri-check-fill"></i></b-button>
                    <b-button class="mr-2" :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status mr-1" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-form" size="xl" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
     <b-modal id="modal-4" size="lg" :title="$t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
        <Details :id="detailsItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketAssignList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '6%' } },
  { label_en: i18n.messages.en.globalTrans.org_name, label_bn: i18n.messages.bn.globalTrans.org_name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '18%' } },
  { label_en: i18n.messages.en.userManagement.office_type, label_bn: i18n.messages.bn.userManagement.office_type, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.userManagement.office, label_bn: i18n.messages.bn.userManagement.office, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.name, label_bn: i18n.messages.bn.globalTrans.name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.mobile, label_bn: i18n.messages.bn.globalTrans.mobile, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.bazarMonitoring.market_name, label_bn: i18n.messages.bn.bazarMonitoring.market_name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 7, thStyle: { width: '6%' } }
]
export default {
    mixins: [ModalBaseMasterList],
    components: {
        Form, Details
    },
    data () {
        return {
        transProps: {
            name: 'flip-list'
        },
        sortBy: '',
        search: {
            org_id: 0,
            office_type_id: 0,
            office_id: 0,
            market_id: 0,
            division_id: 0,
            district_id: 0,
            limit: 20
        },
        sortDesc: true,
        sortDirection: 'desc',
        labelData: [],
        officeTypeList: [],
        officeList: [],
        districtList: [],
        marketList: [],
        item: '',
        detailsItemId: ''
        }
    },
    mounted () {
      if (this.$store.state.Auth.activeRoleId !== 1) {
        this.search = Object.assign({}, this.search, {
          org_id: this.loggedUserPrivilege.org_id,
          office_type_id: this.loggedUserPrivilege.office_type_id,
          office_id: this.loggedUserPrivilege.office_id,
          market_id: this.addressCustomUser.market_id,
          marketList: JSON.stringify(this.loggedUserPrivilege.market_id)
        })
      }
      if (this.$store.state.Auth.activeRoleId === 1 || this.loggedUserPrivilege.area_type_id) {
        this.loadData()
      } else {
        this.$store.dispatch('setList', [])
      }
    },
    created () {
        this.labelData = this.labelList
    },
    watch: {
      'search.limit': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.loadData()
        }
      },
      'search.org_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.officeTypeList = this.getOfficeTypeList(newVal)
        } else {
            this.officeTypeList = []
        }
      },
      'search.office_type_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.officeList = this.getOfficeList(newVal)
        } else {
            this.officeList = []
        }
      },
      'search.division_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.search.district_id = 0
            this.districtList = this.getDistrictList(newVal)
        } else {
            this.districtList = []
        }
      },
      'search.district_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.search.market_id = 0
            this.marketList = this.getMarketDirectoryList(newVal)
        } else {
            this.marketList = []
        }
      }
    },
    computed: {
      addressCustomUser: function () {
        return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
      },
      loggedUserPrivilege: function () {
        return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
      },
      orgList: function () {
        return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
      },
      divisionList: function () {
        return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
            { key: 'org_name_bn' },
            { key: 'office_type_name_bn' },
            { key: 'office_name_bn' },
            { key: 'name_bn' },
            { key: 'mobile' },
            { key: 'market_name_bn' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'org_name' },
            { key: 'office_type_name' },
            { key: 'office_name' },
            { key: 'name' },
            { key: 'mobile' },
            { key: 'market_name_en' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
      },
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketAssignList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObjList = this.$store.state.CommonService.commonObj.componentOrgList.find(org => org.value === parseInt(item.org_id))
        const orgData = {}
        if (typeof orgObjList !== 'undefined') {
            orgData.org_name = orgObjList.text_en
            orgData.org_name_bn = orgObjList.text_bn
        } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
        }
        const officeTypeObj = this.$store.state.CommonService.commonObj.officeTypeList.find(officeType => officeType.value === parseInt(item.office_type_id))
        const officeTypeData = {}
        if (typeof officeTypeObj !== 'undefined') {
            officeTypeData.office_type_name = officeTypeObj.text_en
            officeTypeData.office_type_name_bn = officeTypeObj.text_bn
        } else {
            officeTypeData.office_type_name = ''
            officeTypeData.office_type_name_bn = ''
        }
        const officeNameObj = this.$store.state.CommonService.commonObj.officeList.find(officeName => officeName.value === parseInt(item.office_id))
        const officeNameData = {}
        if (typeof officeNameObj !== 'undefined') {
            officeNameData.office_name = officeNameObj.text_en
            officeNameData.office_name_bn = officeNameObj.text_bn
        } else {
            officeNameData.office_name = ''
            officeNameData.office_name_bn = ''
        }
        const areaTypeText = item.area_type_id
        const areaTypeArray = areaTypeText ? areaTypeText.split(',') : null
        let areaData
        let areaDataBn
        if (areaTypeArray && areaTypeArray.length) {
          areaData = areaTypeArray.map(areaItem => {
            const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(area => area.value === parseInt(areaItem))
            return areaTypeObj !== undefined ? areaTypeObj.text_en : ''
          })
          areaDataBn = areaTypeArray.map(areaItem => {
            const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(area => area.value === parseInt(areaItem))
            return areaTypeObj !== undefined ? areaTypeObj.text_bn : ''
          })
          areaData = areaData.join(', ')
          areaDataBn = areaDataBn.join(', ')
        } else {
          areaData = null
          areaDataBn = null
        }
        const cityCorText = item.area_type_id
        const cityCorArray = cityCorText ? cityCorText.split(',') : null
        let cityCorData
        let cityCorDataBn
        if (cityCorArray && cityCorArray.length) {
          cityCorData = cityCorArray.map(cityItem => {
            const cityCorObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(cityCor => cityCor.value === parseInt(cityItem))
            return cityCorObj !== undefined ? cityCorObj.text_en : ''
          })
          cityCorDataBn = cityCorArray.map(cityItem => {
            const cityCorObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(cityCor => cityCor.value === parseInt(cityItem))
            return cityCorObj !== undefined ? cityCorObj.text_bn : ''
          })
          cityCorData = cityCorData.join(', ')
          cityCorDataBn = cityCorDataBn.join(', ')
        } else {
          cityCorData = null
          cityCorDataBn = null
        }
        const text = item.division_id
        const divisionNameArray = text ? text.split(',') : null
        let divisionData
        let divisionDataBn
        if (divisionNameArray && divisionNameArray.length) {
          divisionData = divisionNameArray.map(divisionItem => {
            const divisionObject = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(divisionItem))
            return divisionObject !== undefined ? divisionObject.text_en : ''
          })
          divisionDataBn = divisionNameArray.map(divisionItem => {
            const divisionObject = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(divisionItem))
            return divisionObject !== undefined ? divisionObject.text_bn : ''
          })
          divisionData = divisionData.join(', ')
          divisionDataBn = divisionDataBn.join(', ')
        } else {
          divisionData = null
          divisionDataBn = null
        }
        const districtStrr = item.district_id
        const districtArray = districtStrr ? districtStrr.split(',') : null
        let distrctData
        let districtDataBn
        if (districtArray && districtArray.length) {
            distrctData = districtArray.map(districtItem => {
              const distrctObject = this.$store.state.CommonService.commonObj.districtList.find(distrct => distrct.value === parseInt(districtItem))
              return distrctObject !== undefined ? distrctObject.text_en : ''
          })
            districtDataBn = districtArray.map(districtItem => {
              const distrctObject = this.$store.state.CommonService.commonObj.districtList.find(distrct => distrct.value === parseInt(districtItem))
              return distrctObject !== undefined ? distrctObject.text_bn : ''
          })
          distrctData = distrctData.join(', ')
          districtDataBn = districtDataBn.join(', ')
        }
        const upazillaStr = item.upazila_id
        const upazilaNameArray = upazillaStr ? upazillaStr.split(',') : null
        let upazillaData
        let upazillaDataBn
        if (upazilaNameArray && upazilaNameArray.length) {
          upazillaData = upazilaNameArray.map(upazilaItem => {
            const upazillaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === parseInt(upazilaItem))
            return upazillaObj !== undefined ? upazillaObj.text_en : ''
          })
          upazillaDataBn = upazilaNameArray.map(upazilaItem => {
            const upazillaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === parseInt(upazilaItem))
            return upazillaObj !== undefined ? upazillaObj.text_bn : ''
          })
          upazillaData = upazillaData.join(',')
          upazillaDataBn = upazillaDataBn.join(',')
        }
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === parseInt(item.upazila_id))
        const upazilaData = {}
        if (typeof upazilaObj !== 'undefined') {
            upazilaData.upazila_name = upazilaObj.text_en
            upazilaData.upazila_name_bn = upazilaObj.text_bn
        } else {
            upazilaData.upazila_name = ''
            upazilaData.upazila_name_bn = ''
        }
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === parseInt(item.market_id))
        const marketData = {}
          if (typeof marketDirectoryObj !== 'undefined') {
            marketData.market_name_en = marketDirectoryObj.text_en
            marketData.market_name_bn = marketDirectoryObj.text_bn
          } else {
            marketData.market_name_en = ' '
            marketData.market_name_bn = ' '
          }
          return Object.assign({}, item, { serial: index }, officeTypeData, orgData, marketData, officeNameData, upazilaData,
          { division_name: divisionData, division_name_bn: divisionDataBn, distrct_name: distrctData, district_name_bn: districtDataBn, upazila_name: upazillaData, upazila_name_bn: upazillaDataBn, area_type: areaData, area_type_bn: areaDataBn, city_corporation: cityCorData, city_corporation_bn: cityCorDataBn })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getMarketDirectoryList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.district_id === id)
    },
    getOfficeTypeList (orgId) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === OfficeTypeID)
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    }
  }
}
</script>
