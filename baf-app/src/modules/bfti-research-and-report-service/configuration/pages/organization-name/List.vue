<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('globalTrans.org_name') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="organization_type_id"
            >
              <template v-slot:label>
                {{ $t('configuration.organization_type') }}
              </template>
              <b-form-select
                plain
                id="organization_type_id"
                :options="organizationTypeList"
                v-model="search.organization_type_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="organization_sub_type_id"
            >
              <template v-slot:label>
                {{ $t('configuration.organization_sub_type') }}
              </template>
              <b-form-select
                plain
                id="organization_sub_type_id"
                :options="organizationSubTypeList"
                v-model="search.organization_sub_type_id"
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
        <h4 class="card-title">{{ $t('globalTrans.org_name') }} {{ $t('globalTrans.list') }}</h4>
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
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { orgNameListApi, orgNameToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        organization_type_id: 0,
        organization_sub_type_id: 0,
        limit: 20
      },
      organizationSubTypeList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'configuration.organization_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'configuration.organization_sub_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'globalTrans.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6 }
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
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.organization_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.organizationSubTypeList = this.getOrganizationSubTypeList()
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
          { key: 'organization_type_bn' },
          { key: 'organization_sub_type_bn' },
          { key: 'organization_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'organization_type_en' },
          { key: 'organization_sub_type_en' },
          { key: 'organization_name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('globalTrans.org_name') + ' ' + this.$t('globalTrans.entry') : this.$t('globalTrans.org_name') + ' ' + this.$t('globalTrans.modify')
    },
    organizationTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(9, bftiResReportServiceBaseUrl, orgNameToggleApi, item)
      }
    },
    searchData () {
      this.loadData()
    },
     getOrganizationSubTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.filter(item => item.status === 1 && item.organization_type_id === this.search.organization_type_id).map(itemObj => {
        if (this.$i18n.locale === 'bn') {
          return { value: itemObj.value, text: itemObj.text_bn }
        } else {
          return { value: itemObj.value, text: itemObj.text_en }
        }
      })
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, orgNameListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList.find(law => law.value === parseInt(item.organization_type_id))
          const orgTypeObj = this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.find(law => law.value === parseInt(item.organization_sub_type_id))
          const orgData = {}
            if (typeof orgObj !== 'undefined') {
                orgData.organization_type_en = orgObj.text_en
                orgData.organization_type_bn = orgObj.text_bn
            } else {
              orgData.organization_type_en = ''
              orgData.organization_type_bn = ''
            }
            const orgTypeData = {}
            if (typeof orgTypeObj !== 'undefined') {
                orgTypeData.organization_sub_type_en = orgTypeObj.text_en
                orgTypeData.organization_sub_type_bn = orgTypeObj.text_bn
            } else {
              orgTypeData.organization_sub_type_en = ''
              orgTypeData.organization_sub_type_bn = ''
            }
          return Object.assign({}, item, { serial: index }, orgData, orgTypeData)
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
