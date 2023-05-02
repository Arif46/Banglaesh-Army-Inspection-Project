<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('moc_portal.service') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xl="12" lg="12" sm="12">
              <b-form-group
                  class="row"
                  label-for="service_type"
                  >
                  <b-form-radio-group
                      v-model="search.service_type_id"
                      :options="serviceTypeList"
                      value-field="value"
                      text-field="text"
                  ></b-form-radio-group>
              </b-form-group>
          </b-col>
        </b-row>
        <b-row>
          <b-col v-if="search.service_type_id == 1" xl="4" lg="4" sm="4">
              <b-form-group
                label-for="component_id"
              >
              <template v-slot:label>
                {{$t('menu.component')}}
              </template>
              <b-form-select
                plain
                v-model="search.component_id"
                :options="componentList"
                id="component_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col v-if="search.service_type_id && search.service_type_id !== 1" sm="4">
              <b-form-group
                label-for="ministry_id"
              >
              <template v-slot:label>
                {{$t('moc_portal.ministry_name')}}
              </template>
              <b-form-select
                plain
                v-model="search.ministry_id"
                :options="ministryNameList"
                id="ministry_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col v-if="search.service_type_id" sm="4">
              <b-form-group
                label-for="org_name"
              >
              <template v-slot:label>
                {{$t('globalTrans.org_name')}}
              </template>
              <b-form-select
                plain
                v-model="search.org_id"
                :options="orgList"
                id="org_name"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="service_name"
            >
              <template v-slot:label>
                {{ $t('moc_portal.service_name') }}
              </template>
              <b-form-input
                  id="service_name"
                  type="text"
                  v-model="search.service_name"
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
        <h4 class="card-title">{{ $t('moc_portal.service') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <my-base-table v-on:editMethodInParent="editMethodInParent"
          :labelData="search.service_type_id === 1 ? labelData2 : labelData"
          :columns="search.service_type_id === 1 ? columns2 : columns"
          :search="search" :searchData="searchData"
          :paginations="pagination" :actions="actions"
          :orderChange="orderChange" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import MyBaseTable from './MyBaseTable.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { serviceListApi, serviceToggleStatusApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, MyBaseTable
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl,
      sortBy: '',
      search: {
        service_type_id: 1,
        component_id: 0,
        org_id: 0,
        ministry_id: 0,
        service_name: '',
        limit: 20
      },
      orgList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'moc_portal.service_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'moc_portal.ministry_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.org_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'moc_portal.service_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'globalTrans.featured', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 8, thStyle: { width: '9%' } }
      ],
      labelData2: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'moc_portal.service_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'menu.component', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'moc_portal.service_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'globalTrans.featured', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 7, thStyle: { width: '9%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      orderChange: {
        type: 'Comp',
        colspan: 5,
        urlSave: '/portal/services/update-feature'
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.pagination.currentPage = 1
        // this.pagination.perPage = 2
        this.loadData()
      }
    },
    'search.service_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.orgList = []
        this.search.org_id = 0
        this.search.ministry_id = 0
        this.search.component_id = 0
        if (newVal === 1) {
          this.orderChange.colspan = 5
        } else {
          this.orderChange.colspan = 6
        }
        this.loadData()
      }
    },
    'search.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.orgList = this.getOrgList(newVal)
      }
    },
    'search.ministry_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.orgList = this.getExOrgList(newVal)
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
          { key: 'service_type_bn' },
          { key: 'ministry_name_bn' },
          { key: 'ex_org_name_bn' },
          { key: 'name_bn' },
          { key: 'status' },
          { key: 'is_feature' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'service_type' },
          { key: 'ministry_name' },
          { key: 'ex_org_name' },
          { key: 'name' },
          { key: 'status' },
          { key: 'is_feature' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    columns2 () {
      const labelData2 = this.labelData2
      const labels = labelData2.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'service_type_bn' },
          { key: 'component_name_bn' },
          { key: 'name_bn' },
          { key: 'status' },
          { key: 'is_feature' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'service_type' },
          { key: 'component_name' },
          { key: 'name' },
          { key: 'status' },
          { key: 'is_feature' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    serviceTypeList () {
      return this.$store.state.CommonService.commonObj.portalServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.filter(item => item.status === 1)
    },
    ministryNameList () {
      return this.$store.state.CommonService.commonObj.ministryNameList.filter(el => el.status === 1)
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('moc_portal.service') + ' ' + this.$t('globalTrans.entry') : this.$t('moc_portal.service') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, serviceToggleStatusApi, item)
      }
    },
    edit (item) {
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    getExOrgList (Id) {
      return this.$store.state.CommonService.commonObj.exOrgList.filter(item => item.ministry_id === parseInt(Id) && item.status === 1)
    },
    getOrgList (compId) {
      const orgComponentList = this.$store.state.CommonService.commonObj.orgComponentList.filter(comp => comp.component_id === compId)
      return orgComponentList.map(item => {
        if (typeof item !== 'undefined') {
          const org = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === item.org_id)
          return (this.$i18n.locale === 'bn') ? Object.assign({}, org, { text: org.abbreviation_bn }) : Object.assign({}, org, { text: org.abbreviation })
        }
      })
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, serviceListApi, params)
      if (result.success) {
        const listData = this.getRelationalData(result.data.data)
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      const listData = data.map((item, index) => {
          const tmpServiceType = this.serviceTypeList.find(el => el.value === item.service_type_id)
          const returnData = {
              service_type: tmpServiceType !== undefined ? tmpServiceType.text_en : '',
              service_type_bn: tmpServiceType !== undefined ? tmpServiceType.text_bn : '',
              serial: index
          }
          if (item.service_type_id === 1) {
            const tmpComponent = this.$store.state.CommonService.commonObj.componentList.find(el => el.value === item.component_id)
            returnData.component_name = tmpComponent !== undefined ? tmpComponent.text_en : ''
            returnData.component_name_bn = tmpComponent !== undefined ? tmpComponent.text_bn : ''
          } else {
            const tmpMinistry = this.$store.state.CommonService.commonObj.ministryNameList.find(el => el.value === item.ministry_id)
            const tmpExOrg = this.$store.state.CommonService.commonObj.exOrgList.find(el => el.value === item.ex_org_id)
            returnData.ex_org_name = tmpExOrg !== undefined ? tmpExOrg.text_en : ''
            returnData.ex_org_name_bn = tmpExOrg !== undefined ? tmpExOrg.text_bn : ''
            returnData.ministry_name = tmpMinistry !== undefined ? tmpMinistry.text_en : ''
            returnData.ministry_name_bn = tmpMinistry !== undefined ? tmpMinistry.text_bn : ''
          }
          return Object.assign({}, item, returnData)
      })
      return listData
    }
  }
}
</script>
