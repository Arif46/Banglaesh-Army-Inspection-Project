<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.tea_garden_profile') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="tea_company_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.tea_company') }}
              </template>
            <b-form-select
                plain
                v-model="search.tea_company_id"
                :options="getTeaCompanyList"
                id="tea_company_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="0" vid="tea_garden_gen_info_id">
              <b-form-group
                  label-for="tea_garden_gen_info_id"
                  slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{$t('teaGardenConfig.tea_garden_name')}}
              </template>
              <b-form-select
                  plain
                  v-model="search.tea_garden_gen_info_id"
                  :options="teaGardenNameList"
                  id="tea_garden_gen_info_id"
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
          <b-col sm="4">
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
        <h4 class="card-title"> {{ $t('teaGardenConfig.tea_garden_list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link to="tea-garden-profile-form" class="btn-add"  v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                              :id="'checkbox-' + field.labels"
                              v-model="field.show"
                              :name="'checkbox-' + field.labels"
                              value=1
                              unchecked-value=0
                            >
                              {{ $t(field.labels)  }}
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
                  <template v-slot:cell(tea_company_id)="data">
                    {{ getTeaCompanyName(data.item.tea_company_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                      <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                      <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.view')" :to="{ name: 'tea_garden_service.configuration.tea_garde_profile_view', params: { item: data.item }, query: { id: data.item.id } }">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-edit-btn" :title="$t('globalTrans.edit')" :to="{ name: 'tea_garden_service.configuration.tea_garden_profile_create', params: { item: data.item }, query: { id: data.item.id } }">
                      <i class="ri-pencil-fill"></i>
                    </router-link>
                    <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="toggleStatus(data.item)">
                      <i :class="data.item.status === 2 ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
                    </b-button>
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
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { teaGardenGenInfoList, teaGardenProfileToggle, getTeaGardenNameList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/route-based-list'
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
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
        limit: 20
      },
      teaGardenNameList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      pauroshobaList: [],
      editItemId: '',
      labelData: [
      { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
      { labels: 'teaGardenConfig.company_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
      { labels: 'teaGardenConfig.tea_garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
      { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
      { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
    this.getTeaGardenProfileList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.tea_company_id': function (newVal, oldVal) {
      this.getTeaGardenProfileList()
    },
    'search.area_type_id': function (newVal, oldVal) {
      this.getTeaGardenProfileList()
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.getTeaGardenProfileList()
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
        this.getTeaGardenProfileList()
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
        this.getTeaGardenProfileList()
      } else {
        this.unionList = []
        this.pauroshobaList = []
      }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getTeaGardenProfileList()
      }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getTeaGardenProfileList()
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
          { key: 'tea_company_id' },
          { key: 'tea_garden_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'tea_company_id' },
          { key: 'tea_garden_name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    teaGardenGenInfoList () {
      return this.$store.state.TeaGardenService.commonObj.masterBoughtLeafFactoryList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    getTeaCompanyList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.filter(item => item.status === 1)
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
    }
  },
  methods: {
    toggleStatus (item) {
        this.changeStatus(3, teaGardenServiceBaseUrl, teaGardenProfileToggle, item)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, teaGardenGenInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const division = this.divisionList.find(obj => obj.value === parseInt(item.division_id))
          const district = this.$store.state.CommonService.commonObj.districtList.find(obj => obj.value === parseInt(item.district_id))
          const upazila = this.$store.state.CommonService.commonObj.upazilaList.find(obj => obj.value === parseInt(item.upazila_id))
          const customItem = {
            division_name_en: division?.text_en,
            division_name_bn: division?.text_bn,
            district_name_en: district?.text_en,
            district_name_bn: district?.text_bn,
            upazila_name_en: upazila?.text_en,
            upazila_name_bn: upazila?.text_bn
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
    getTeaCompanyName (id) {
      const companyInfo = this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.find(item => item.value === id)
         if (companyInfo && this.$i18n.locale === 'bn') {
            return companyInfo.text_bn
         } else if (companyInfo && this.$i18n.locale === 'en') {
            return companyInfo.text_en
         }
    },
    async getTeaGardenProfileList () {
    let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, getTeaGardenNameList, this.search)
      if (result) {
        this.teaGardenNameList = result
      }
    }
  }
}
</script>
