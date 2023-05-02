<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_entry') }} {{ $t('globalTrans.search')}}</h4>
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
                      :options="cityCorporationList"
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
          <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 3">
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
          </b-col> -->
          <b-col sm="4" class="mt-4">
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
        <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_entry_list') }} {{ $t('globalTrans.list') }}</h4>
    </template>
    <template v-slot:headerAction>
        <router-link  class="btn-add" to="beneficiary-entry-form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
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
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                   <template v-slot:cell(areaItem)="data">
                      <div v-if="data.item.city_corporation_id"> {{ cityCorporationName(data.item.city_corporation_id) }} </div>
                      <div v-if="data.item.pauroshoba_id"> {{ pauroshobaName(data.item.pauroshoba_id) }} </div>
                      <div v-if="data.item.upazila_id"> {{ upazilaName(data.item.upazila_id) }} </div>
                    </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" :title="$t('globalTrans.edit')" :to="{ path: 'beneficiary-entry-form?id=' + data.item.id, query: { item: data.item }}"  size="sm">
                      <i class="ri-pencil-fill"></i>
                    </router-link>
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
    <b-modal id="modal-4" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :item="item" :key="detailsItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { beneficiartEntryList } from '../../../api/routes'
import routeBaseroute from '@/mixins/route-based-list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.area_type, label_bn: i18n.messages.bn.globalTrans.area_type, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.division, label_bn: i18n.messages.bn.globalTrans.division, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.district, label_bn: i18n.messages.bn.globalTrans.district, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tcbconfiguration.area, label_bn: i18n.messages.bn.tcbconfiguration.area, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 8, thStyle: { width: '10%' } }
]
export default {
  mixins: [routeBaseroute],
  components: {
    Details
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        limit: 10
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      cityCorporationList: [],
      pauroshobaList: [],
      detailsItemId: '',
      item: ''
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  mounted () {
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
        this.cityCorporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.cityCorporationList = []
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
    },
    'search.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
        } else {
          this.wardList = []
        }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getPauroshobaWardList(newVal)
        } else {
          this.wardList = []
        }
    },
    'search.union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getUnionWardList(newVal)
        } else {
          this.wardList = []
        }
    }
  },
  computed: {
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tcbconfiguration.beneficiary_entry') : this.$t('tcbconfiguration.beneficiary_entry') + ' ' + this.$t('globalTrans.modify')
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
          { key: 'area_type_name_bn' },
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'areaItem' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'area_type_name' },
          { key: 'division_name' },
          { key: 'district_name' },
          { key: 'areaItem' },
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
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, beneficiartEntryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(area => area.value === parseInt(item.area_type_id))
          const areaTypData = {}
            if (typeof areaTypeObj !== 'undefined') {
                areaTypData.area_type_name = areaTypeObj.text_en
                areaTypData.area_type_name_bn = areaTypeObj.text_bn
            } else {
                areaTypData.area_type_name = ''
                areaTypData.area_type_name_bn = ''
            }
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
            if (typeof divisionObj !== 'undefined') {
                divisionData.division_name = divisionObj.text_en
                divisionData.division_name_bn = divisionObj.text_bn
            } else {
                divisionData.division_name = ''
                divisionData.division_name_bn = ''
            }
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const districtData = {}
          if (typeof districtObj !== 'undefined') {
              districtData.district_name = districtObj.text_en
              districtData.district_name_bn = districtObj.text_bn
          } else {
              districtData.district_name = ''
              districtData.district_name_bn = ''
          }
        const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(corporation => corporation.value === parseInt(item.city_corporation_id))
        const cityCorporationData = {}
          if (typeof cityCorporationObj !== 'undefined') {
              cityCorporationData.city_corporation = cityCorporationObj.text_en
              cityCorporationData.city_corporation_bn = cityCorporationObj.text_bn
          } else {
              cityCorporationData.city_corporation = ' '
              cityCorporationData.city_corporation_bn = ' '
          }
          return Object.assign({}, item, { serial: index }, divisionData, districtData, cityCorporationData, areaTypData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getWardList (id) {
      return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getPauroshobaWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.municipality_id === id)
    },
    getUnionWardList (id) {
      return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.union_id === id)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    pauroshobaName (pauId) {
      const pauroObj = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === pauId)
      if (pauroObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return pauroObj.text_bn
        } else {
          return pauroObj.text_en
        }
      }
    },
    unionName (unionId) {
      const unionObj = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === unionId)
      if (unionObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return unionObj.text_bn
        } else {
          return unionObj.text_en
        }
      }
    },
    cityCorporationName (cityId) {
      const CityObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === cityId)
      if (CityObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return CityObj.text_bn
        } else {
          return CityObj.text_en
        }
      }
    },
    upazilaName (id) {
      const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
       if (upazilaObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return upazilaObj.text_bn
        } else {
          return upazilaObj.text_en
        }
      }
    }
  }
}
</script>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
