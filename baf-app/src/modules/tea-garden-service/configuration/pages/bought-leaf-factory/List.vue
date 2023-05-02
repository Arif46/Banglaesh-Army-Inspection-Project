<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.bought_leaf_factory') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="division"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.division') }}
              </template>
            <b-form-select
                plain
                v-model="search.division_id"
                :options="divisionList"
                id="org_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="district"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.district') }}
              </template>
            <b-form-select
                plain
                v-model="search.district_id"
                :options="districtList"
                id="org_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="made_tea_type_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.select_made_tea_type') }}
              </template>
            <b-form-select
                plain
                v-model="search.made_tea_type_id"
                :options="madeTeaType"
                id="made_tea_type_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="factory_type_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.factory_type') }}
              </template>
            <b-form-select
                plain
                v-model="search.factory_type_id"
                :options="factoryType"
                id="factory_type_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="factory_name_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.factory_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.factory_name_id"
                :options="factoryNameList"
                id="factory_name_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
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
        <h4 class="card-title"> {{ $t('teaGardenConfig.bought_leaf_factory') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                  <template v-slot:cell(made_tea_type_id)="data">
                    {{ getMadeTypeNames(JSON.parse(data.item.made_tea_type_id)) }}
                  </template>
                  <template v-slot:cell(status)="data">
                      <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                      <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="editMethodInParent(data.item, 1)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button class="btn action-btn status btn- btn-success btn-sm" :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" size="sm" @click="editMethodInParent(data.item, 2)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { boughtLeafFactoryList, boughtLeafFactoryToggle, getFactoryNameList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      search: {
        division_id: 0,
        district_id: 0,
        factory_type_id: 0,
        made_tea_type_id: 0,
        factory_name_id: 0,
        limit: 20
      },
      districtList: [],
      factoryNameList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'teaGardenConfig.registration_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.factory_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.factory_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.select_made_tea_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '12%' } },
        { labels: 'teaGardenConfig.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '12%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 9, thStyle: { width: '15%' } }
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
    this.getFactoryNameSearchList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
      this.getFactoryNameSearchList()
    },
    'search.district_id': function (newVal, oldVal) {
      this.getFactoryNameSearchList()
    },
    'search.made_tea_type_id': function (newVal, oldVal) {
      this.getFactoryNameSearchList()
    },
    'search.factory_type_id': function (newVal, oldVal) {
      this.getFactoryNameSearchList()
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
          { key: 'registration_no' },
          { key: 'factory_name_bn' },
          { key: 'factory_type_bn' },
          { key: 'made_tea_type_id' },
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'registration_no' },
          { key: 'factory_name_en' },
          { key: 'factory_type_en' },
          { key: 'made_tea_type_id' },
          { key: 'division_name' },
          { key: 'district_name' },
          { key: 'status' },
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
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.bought_leaf_factory') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.bought_leaf_factory') + ' ' + this.$t('globalTrans.modify')
    },
    boughtLeafFactoryList () {
      return this.$store.state.TeaGardenService.commonObj.masterBoughtLeafFactoryList.filter(item => item.status === 1)
    },
    getAreaTypeList: function () {
        const objectData = this.$store.state.commonObj.areaTypeList
        return objectData.map((obj, key) => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.value, text: obj.text_bn }
            } else {
                return { value: obj.value, text: obj.text_en }
            }
        })
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    madeTeaType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList.filter(item => item.status === 1)
    },
    factoryType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterFactoryTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, teaGardenServiceBaseUrl, boughtLeafFactoryToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, boughtLeafFactoryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const divisionData = {}
        const districtData = {}
            if (typeof divisionObj !== 'undefined') {
                divisionData.division_name = divisionObj.text_en
                divisionData.division_name_bn = divisionObj.text_bn
            } else {
                divisionData.division_name = ''
                divisionData.division_name_bn = ''
            }
            if (typeof districtObj !== 'undefined') {
                districtData.district_name = districtObj.text_en
                districtData.district_name_bn = districtObj.text_bn
            } else {
                districtData.district_name = ''
                districtData.district_name_bn = ''
            }
            return Object.assign({}, item, { serial: index }, divisionData, districtData)
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
    async getFactoryNameSearchList () {
    let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, getFactoryNameList, this.search)
      if (result) {
        this.factoryNameList = result
      }
    },
    getMadeTypeNames (data) {
      var madeTeaTypes = []
        if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            madeTeaTypes.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            madeTeaTypes.push(item.text_en)
          }
          })
      }
      return madeTeaTypes.toString()
    }
  }
}
</script>
