<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('component_settings.dashboard_card') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <b-form-group label-for="org_id">
              <template v-slot:label>
                {{ $t('globalTrans.organization') }}
              </template>
              <b-form-select
                plain
                id="org_id"
                :options="orgList"
                v-model="search.org_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <b-form-group label-for="service_id">
              <template v-slot:label>
                {{ $t('service_name.service_name') }}
              </template>
              <b-form-select
                plain
                id="service_id"
                :options="serviceList"
                v-model="search.service_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <b-form-group label-for="step_id">
              <template v-slot:label>
                {{ $t('step_name.step_name') }}
              </template>
              <b-form-select
                plain
                id="step_id"
                :options="stepList"
                v-model="search.step_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <b-form-group
              label-for="Title"
            >
              <template v-slot:label>
                {{ $t('globalTrans.title') }}
              </template>
              <b-form-input
                  id="title"
                  type="text"
                  v-model="search.title"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col sm="12" class="text-right">
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
        <h4 class="card-title">{{ $t('component_settings.dashboard_card') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="licenseRegistrationServiceBaseUrl" />
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { cardList, cardToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      serviceList: [],
      stepList: [],
      search: {
        title: '',
        step_id: 0,
        service_id: 0,
        org_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'service_name.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'step_name.step_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7 }
      ],
      actions: {
        edit: true,
        details: false,
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
    'search.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === newVal)
      }
    },
    'search.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.stepList = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.filter(item => item.status === 1 && item.service_id === newVal)
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
          { key: 'title' },
          { key: 'org_name_bn' },
          { key: 'service_name_bn' },
          { key: 'step_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'title' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'step_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('component_settings.dashboard_card') + ' ' + this.$t('globalTrans.entry') : this.$t('component_settings.dashboard_card') + ' ' + this.$t('globalTrans.modify')
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(7, licenseRegistrationServiceBaseUrl, cardToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, cardList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(law => law.value === parseInt(item.org_id))
          const orgData = { org_name: orgObj !== undefined ? orgObj.text_en : '', org_name_bn: orgObj !== undefined ? orgObj.text_bn : '' }
          const serObj = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(law => law.value === parseInt(item.service_id))
          const serData = { service_name: serObj !== undefined ? serObj.text_en : '', service_name_bn: serObj !== undefined ? serObj.text_bn : '' }
          const stepObj = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(step => step.value === parseInt(item.step_id))
          const stepData = { step_name: stepObj !== undefined ? stepObj.text_en : '', step_name_bn: stepObj !== undefined ? stepObj.text_bn : '' }
          return Object.assign({}, item, { serial: index }, orgData, serData, stepData)
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
