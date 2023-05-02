<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">Report Process</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
          <b-form  @submit.prevent="handleSubmit(searchData)" >
            <b-row>
              <b-col lg="4" sm="4" md="4">
                <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                  <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="organization"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="search.org_id"
                      :options="organizationList"
                      id="org_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="4" sm="4" md="4">
                  <ValidationProvider name="Service Name" vid="service_id" rules="">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="service_id"
                      >
                      <template v-slot:label>
                      {{ $t('service_name.service_name') }}
                      </template>
                      <b-form-select
                        plain
                        v-model="search.service_id"
                        :options="serviceList"
                        id="org_id"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                    </b-form-group>
                  </ValidationProvider>
              </b-col>
              <b-col sm="4">
                <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                </b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
    </card>
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">Report Process List</h4>
      </template>
      <template v-slot:headerAction>
        <router-link :to="`report-process-form`">
          <b-button class="mr-2" title="Add New" variant="primary" size="sm">{{ $t('globalTrans.add_new') }}</b-button>
        </router-link>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="licenseRegistrationServiceBaseUrl" />
        </b-overlay>
      </template>
    </body-card>
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { reportProcessList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'

export default {
  mixins: [ModalBaseMasterList, common],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        org_id: 0,
        step_id: 0,
        service_id: 0
      },
      serviceList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '25%' } },
        { labels: 'service_name.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  computed: {
    organizationList: function () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    formTitle () {
       return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
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
          { key: 'service_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    }
  },
  watch: {
    loadingState: function (newVal) {
      if (newVal) {
        this.loadData()
      }
    },
    'search.org_id': function (newVal) {
      this.serviceList = this.getServiceList(newVal)
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    editMethodInParent (item, type) {
      const itemId = item.id
      if (type === 1) {
        this.$router.push({ path: '/license-registration-service/configuration/report-process-form', query: { id: itemId } })
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, reportProcessList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(law => law.value === parseInt(item.org_id))
          const orgData = { org_name: orgObj !== undefined ? orgObj.text_en : '', org_name_bn: orgObj !== undefined ? orgObj.text_bn : '' }
          const serObj = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(law => law.value === parseInt(item.service_id))
          const serData = { service_name: serObj !== undefined ? serObj.text_en : '', service_name_bn: serObj !== undefined ? serObj.text_bn : '' }
          return Object.assign({}, item, { serial: index }, orgData, serData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getOrgName (orgId) {
      const tmpOrg = this.organizationList.find(org => org.value === orgId)
      return this.$i18n.locale === 'en' ? tmpOrg !== undefined ? tmpOrg.text_en : '' : tmpOrg !== undefined ? tmpOrg.text_bn : ''
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    }
  }
}
</script>
