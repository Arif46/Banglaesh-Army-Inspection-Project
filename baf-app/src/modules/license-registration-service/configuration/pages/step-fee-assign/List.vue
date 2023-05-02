<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('step_assign.step_fee_assign') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
        <h4 class="card-title">{{ $t('step_assign.step_fee_assign') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + 1) }}
                </template>
                <template v-slot:cell(org_name)="data">
                  {{ getOrgName(data.item) }}
                </template>
                <template v-slot:cell(service_name)="data">
                  {{ getServiceName(data.item) }}
                </template>
                <template v-slot:cell(step_name)="data">
                  {{ getStepName(data.item) }}
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="editData(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                </template>
              </b-table>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :item="editItem" :id="editItemId" :orgId="editOrgId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepFeeAssignList } from '../../api/routes'
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
      search: {
        org_id: 0,
        service_id: 0,
        limit: 10
      },
      editItem: '',
      editItemId: '',
      editOrgId: '',
      serviceLists: []
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
    }
  },
  computed: {
    columns () {
      const labels = [
        { label: this.$t('globalTrans.sl_no'), class: 'text-left' },
        { label: this.$t('orgProfile.org_name'), class: 'text-left' },
        { label: this.$t('service_name.service_name'), class: 'text-left' },
        { label: this.$t('step_name.steps'), class: 'text-left' },
        { label: this.$t('globalTrans.action'), class: 'text-center' }
      ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'step_name' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'step_name' },
          { key: 'action' }
        ]
      }

      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('step_assign.step_fee_assign') + ' ' + this.$t('globalTrans.entry') : this.$t('step_assign.step_fee_assign') + ' ' + this.$t('globalTrans.modify')
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    serviceNameList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1)
    },
    stepNameList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.filter(item => item.status === 1)
    }
  },
  methods: {
    editData (item) {
      this.editItem = item
      const service = Object.entries(item)
      const serviceId = parseInt(service[0])
      let orgIdd
      Object.entries(item).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          orgIdd = value.org_id
        })
      })
      this.editItemId = serviceId
      this.editOrgId = orgIdd
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, stepFeeAssignList, params)
      if (result.success) {
        const listData = result.data
        this.$store.dispatch('setList', listData)
      } else {
        this.$store.dispatch('setList', [])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getOrgName (data) {
      let orgIdd
      Object.entries(data).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          orgIdd = value.org_id
        })
      })
      const orgName = this.orgList.find(item => item.value === orgIdd)
      return this.$i18n.locale === 'en' ? orgName !== undefined ? orgName.text_en : '' : orgName !== undefined ? orgName.text_bn : ''
    },
    getServiceName (data) {
      const service = Object.keys(data)
      const serviceId = parseInt(service[0])
      const ServiceName = this.serviceNameList.find(item => item.value === serviceId)
      return this.$i18n.locale === 'en' ? ServiceName !== undefined ? ServiceName.text_en : '' : ServiceName !== undefined ? ServiceName.text_bn : ''
    },
    getStepName (data) {
      const stepList = this.stepNameList
      const step = []
      Object.entries(data).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          const stepFind = stepList.find(item => item.value === value.step_id)
          step.push(this.$i18n.locale === 'en' ? stepFind !== undefined ? stepFind.text_en : '' : stepFind !== undefined ? stepFind.text_bn : '')
        })
      })
      return step.join(', ')
    }
  }
}
</script>
