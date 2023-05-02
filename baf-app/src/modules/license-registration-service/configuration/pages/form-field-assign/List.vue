<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('component_settings.form_field_assign') }}</h4>
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
        <h4 class="card-title">{{ $t('component_settings.form_field_assign') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link :to="`form-field-assign-form`">
          <b-button class="mr-2 btn-add" title="Add New" variant="primary" size="sm"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</b-button>
        </router-link>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                <template slot="thead-top">
                  <tr>
                    <th class="text-center" width="50%" colspan="4">{{ $t('globalTrans.from') }} ({{ $t('dynamic_form.form') }})</th>
                    <th class="text-center" width="50%" colspan="4">{{ $t('globalTrans.to') }} ({{ $t('dynamic_form.form') }}) </th>
                  </tr>
                </template>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(org_id_from)="data">
                  {{ getOrgName(data.item.org_id_from) }}
                </template>
                <template v-slot:cell(org_id_to)="data">
                  {{ getOrgName(data.item.org_id_to) }}
                </template>
                <template v-slot:cell(service_id_from)="data">
                  {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', data.item.service_id_from) }}
                </template>
                <template v-slot:cell(service_id_to)="data">
                  {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', data.item.service_id_to) }}
                </template>
                <template v-slot:cell(form_id_from)="data">
                  {{ getStoreData('LicenseRegistrationService', 'dynamicFormList', data.item.form_id_from) }}
                </template>
                <template v-slot:cell(form_id_to)="data">
                  {{ getStoreData('LicenseRegistrationService', 'dynamicFormList', data.item.form_id_to) }}
                </template>
                <template v-slot:cell(action)="data">
                  <router-link :to="`form-field-assign-form?id=` + data.item.id">
                    <b-button title="Edit" variant=" iq-bg-success mr-1 mb-1" size="sm"><i class="ri-ball-pen-fill m-0"></i></b-button>
                  </router-link>
                  <b-button @click="changeStatus(data.item)" title="Permanent Delete" class="btn btn-danger btn-sm"> <i class="ri-close-line m-0"></i></b-button>
                </template>
              </b-table>
              <b-pagination
                v-model="pagination.currentPage"
                :per-page="pagination.perPage"
                :total-rows="pagination.totalRows"
                @input="searchData"
                />
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { fieldAssignList, fieldAssignRemove } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'

export default {
  mixins: [ModalBaseMasterList, common],
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      serviceList: [],
      search: {
        service_id: 0,
        org_id: 0,
        limit: 10
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
    }
  },
  computed: {
    columns () {
      const labels = [
        { label: this.$t('globalTrans.sl_no'), class: 'text-left' },
        { label: this.$t('globalTrans.organization'), class: 'text-left' },
        { label: this.$t('service_name.service_name'), class: 'text-left' },
        { label: this.$t('dynamic_form.form'), class: 'text-left' },
        { label: this.$t('globalTrans.organization'), class: 'text-left' },
        { label: this.$t('service_name.service_name'), class: 'text-left' },
        { label: this.$t('dynamic_form.form'), class: 'text-left' },
        { label: this.$t('globalTrans.action'), class: 'text-center' }
      ]
      const keys = [
        { key: 'index' },
        { key: 'org_id_from' },
        { key: 'service_id_from' },
        { key: 'form_id_from' },
        { key: 'org_id_to' },
        { key: 'service_id_to' },
        { key: 'form_id_to' },
        { key: 'action' }
      ]
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, fieldAssignList, params)
      if (result.success) {
        const listData = this.formateData(result.data.data)
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    formateData (data) {
      return data.map(item => {
        return Object.assign(item,
        // 1 form_service, 2 to service
        this.getServiceOrg(item.service_id_from, 1),
        this.getServiceOrg(item.service_id_to, 2)
        )
      })
    },
    getServiceOrg (serviceId, type = 0) {
      const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === parseInt(serviceId))
      if (type === 1) {
        return {
          org_id_from: service.org_id
        }
      } else {
        return {
          org_id_to: service.org_id
        }
      }
    },
    getOrgName (orgId) {
      const tmpOrg = this.orgList.find(org => org.value === orgId)
      return this.$i18n.locale === 'en' ? tmpOrg !== undefined ? tmpOrg.text_en : '' : tmpOrg !== undefined ? tmpOrg.text_bn : ''
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    changeStatus (item) {
      window.vm.$swal({
        title: window.vm.$t('globalTrans.deleteConfirmMsg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.removeItem(item)
        }
      })
    },
    removeItem (item) {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      RestApi.deleteData(licenseRegistrationServiceBaseUrl, `${fieldAssignRemove}/${item.id}`).then(response => {
        if (response.success) {
          window.vm.$toast.success({
            title: this.$t('globalTrans.success'),
            message: 'Data Updated Successfully',
            color: '#D6E09B'
          })
        } else {
            window.vm.$toast.error({
              title: 'Error',
              message: 'Operation failed! Please, try again.'
          })
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
      })
    }
  }
}
</script>
