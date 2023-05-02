<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('organogram.assign_designation') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="org_id"
            >
            <template v-slot:label>
              {{$t('organogram.org')}} <span class="text-danger">*</span>
            </template>
              <b-form-select
                plain
                v-model="search.org_id"
                :options="orgList"
                id="org_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="office_type_id"
            >
            <template v-slot:label>
              {{$t('organogram.office_type')}} <span class="text-danger">*</span>
            </template>
              <b-form-select
                plain
                v-model="search.office_type_id"
                :options="officeTypeList"
                id="office_type_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="office_id"
            >
            <template v-slot:label>
              {{$t('organogram.office_name')}} <span class="text-danger">*</span>
            </template>
              <b-form-select
                plain
                v-model="search.office_id"
                :options="offcelist"
                id="office_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="designation_id"
            >
            <template v-slot:label>
              {{$t('organogram.designation')}} <span class="text-danger">*</span>
            </template>
              <b-form-select
                plain
                v-model="search.designation_id"
                :options="designationList"
                id="designation_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
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
        <h4 class="card-title">{{ $t('organogram.assign_designation') }} {{ $t('globalTrans.list') }}</h4>
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
import { assignDesignationList, assignDesignationToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      sortBy: '',
      search: {
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        designation_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
        { labels: 'organogram.office_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
        { labels: 'organogram.office_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
        { labels: 'organogram.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '30%' } },
        { labels: 'organogram.approved_post', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '30%' } },
        { labels: 'globalTrans.sorting_order', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '30%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '30%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 9, thStyle: { width: '30%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      officeTypeList: [],
      offcelist: [],
      designationList: []
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
    'search.org_id': function (newVal, oldVal) {
      this.search.office_type_id = 0
      this.search.designation_id = 0
      if (newVal !== oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
        this.designationList = this.getDesignationList(newVal)
      } else {
         this.officeTypeList = []
         this.designationList = []
      }
    },
    'search.office_type_id': function (newVal, oldVal) {
       this.search.office_id = 0
      if (newVal !== oldVal) {
        this.offcelist = this.getOfficeList(newVal)
      } else {
         this.offcelist = []
      }
    }
  },
  computed: {
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
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
          { key: 'office_type_bn' },
          { key: 'office_name_bn' },
          { key: 'desingation_name_bn' },
          { key: 'approved_post' },
          { key: 'sorting_order' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'office_type' },
          { key: 'office_name' },
          { key: 'desingation_name' },
          { key: 'approved_post' },
          { key: 'sorting_order' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('organogram.designation') + ' ' + this.$t('globalTrans.entry') : this.$t('organogram.designation') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(commonServiceBaseUrl, assignDesignationToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, assignDesignationList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgProfileObj = this.$store.state.CommonService.commonObj.orgProfileList.find(orgProId => orgProId.value === item.org_id)
          const orgProfileData = {
            org_name_bn: orgProfileObj !== undefined ? orgProfileObj.text_bn : '',
            org_name: orgProfileObj !== undefined ? orgProfileObj.text_en : ''
          }
          const officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.find(officeType => officeType.value === item.office_type_id)
          const officeTypeData = {
            office_type_bn: officeTypeList !== undefined ? officeTypeList.text_bn : '',
            office_type: officeTypeList !== undefined ? officeTypeList.text_en : ''
          }
          const officeNameList = this.$store.state.CommonService.commonObj.officeList.find(office => office.value === item.office_id)
          const officeData = {
            office_name_bn: officeNameList !== undefined ? officeNameList.text_bn : '',
            office_name: officeNameList !== undefined ? officeNameList.text_en : ''
          }
          const DesignationList = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === item.designation_id)
          const desingationData = {
            desingation_name_bn: DesignationList !== undefined ? DesignationList.text_bn : '',
            desingation_name: DesignationList !== undefined ? DesignationList.text_en : ''
          }
          return Object.assign({}, item, { serial: index }, orgProfileData, officeTypeData, officeData, desingationData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getOfficeList (id) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === id)
    },
    getDesignationList (id) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === id)
    }
  }
}
</script>
