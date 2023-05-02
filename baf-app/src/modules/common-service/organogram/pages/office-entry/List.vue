<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('organogram.office') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="org_name"
            >
              <template v-slot:label>
                {{ $t('orgProfile.org_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.org_id"
                :options="orgProfileList"
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
              label-for="office_type"
            >
              <template v-slot:label>
                {{ $t('organogram.office_type') }}
              </template>
            <b-form-select
                plain
                v-model="search.office_type_id"
                :options="officeTypeList"
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
              label-for="area_type"
            >
              <template v-slot:label>
                {{ $t('orgProfile.area_type') }}
              </template>
            <b-form-select
                plain
                v-model="search.area_type_id"
                :options="getAreaTypeList"
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
              label-for="division"
            >
              <template v-slot:label>
                {{ $t('orgProfile.division') }}
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
                {{ $t('orgProfile.district') }}
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
              label-for="upazila"
            >
              <template v-slot:label>
                {{ $t('orgProfile.upazila') }}
              </template>
            <b-form-select
                plain
                v-model="search.upazila_id"
                :options="upazilaList"
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
              label-for="union"
            >
              <template v-slot:label>
                {{ $t('orgProfile.union') }}
              </template>
            <b-form-select
                plain
                v-model="search.union_id"
                :options="unionList"
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
              label-for="office_name"
            >
              <template v-slot:label>
                {{ $t('organogram.office_name') }}
              </template>
              <b-form-input
                  id="office_name"
                  type="text"
                  v-model="search.office_name"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="office_code"
            >
              <template v-slot:label>
                {{ $t('organogram.office_code') }}
              </template>
              <b-form-input
                  id="office_code"
                  type="text"
                  v-model="search.office_code"
              ></b-form-input>
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
        <h4 class="card-title">{{ $t('organogram.office') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { officeList, officeToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import i18n from '@/i18n'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      search: {
        office_name: '',
        org_id: 0,
        office_type_id: 0,
        area_type_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        office_code: '',
        limit: 20
      },
      officeTypeList: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'organogram.office_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '12%' } },
        { labels: 'orgProfile.division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'orgProfile.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'organogram.office_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '12%' } },
        { labels: 'orgProfile.area_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '12%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 9 }
      ],
      actions: {
        edit: true,
        details: true,
        toogle: true,
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
    },
    'search.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'search.district_id': function (newVal, oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'search.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
    },
    'search.org_id': function (newVal, oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
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
          { key: 'org_name_bn' },
          { key: 'office_type_name_bn' },
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'office_name_bn' },
          { key: 'area_type_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'office_type_name' },
          { key: 'division_name' },
          { key: 'district_name' },
          { key: 'office_name' },
          { key: 'area_type_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('organogram.office') + ' ' + this.$t('globalTrans.entry') : this.$t('organogram.office') + ' ' + this.$t('globalTrans.modify')
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    getAreaTypeList: function () {
        const objectData = this.$store.state.commonObj.typeList
        return objectData.map((obj, key) => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.id, text: obj.name_bn }
            } else {
                return { value: obj.id, text: obj.name }
            }
        })
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(commonServiceBaseUrl, officeToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, officeList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
        const officeTypeObj = this.$store.state.CommonService.commonObj.officeTypeList.find(oType => oType.value === parseInt(item.office_type_id))
        const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const areaTypeObj = this.$store.state.commonObj.typeList.find(areaType => areaType.id === parseInt(item.area_type_id))
        const orgData = {}
        const officeTypeData = {}
        const divisionData = {}
        const districtData = {}
        const areaTypeData = {}
            if (typeof orgObj !== 'undefined') {
                orgData.org_name = orgObj.text_en
                orgData.org_name_bn = orgObj.text_bn
            } else {
                orgData.org_name = ''
                orgData.org_name_bn = ''
            }
            if (typeof officeTypeObj !== 'undefined') {
                officeTypeData.office_type_name = officeTypeObj.text_en
                officeTypeData.office_type_name_bn = officeTypeObj.text_bn
            } else {
                officeTypeData.office_type_name = ''
                officeTypeData.office_type_name_bn = ''
            }
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
            if (typeof areaTypeObj !== 'undefined') {
                areaTypeData.area_type_name = areaTypeObj.name
                areaTypeData.area_type_name_bn = areaTypeObj.name_bn
            } else {
                areaTypeData.area_type_name = ''
                areaTypeData.area_type_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, orgData, officeTypeData, divisionData, districtData, areaTypeData)
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
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    }
  }
}
</script>
