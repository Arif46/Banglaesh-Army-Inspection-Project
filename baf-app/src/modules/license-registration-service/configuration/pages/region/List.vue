<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('component_settings.region') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required">
              <b-form-group
              label-for="org_id"
              slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="org_id"
                  :options="orgList"
                  v-model="search.org_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Service Name" vid="service_id" rules="required">
                <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                    v-model="search.service_id"
                    :options="serviceNamesList"
                    id="service_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                    <template v-slot:first>
                        <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                </b-form-select>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Region" vid="region_office_id">
                  <b-form-group
                  label-for="region_office_id"
                  >
                  <template v-slot:label>
                      {{$t('component_settings.region')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="search.region_office_id"
                      :options="regionNameList"
                      id="region_office_id"
                  >
                      <template v-slot:first>
                      <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
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
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('fee_name.fee_name') }} {{ $t('globalTrans.list') }}</h4>
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
import { regionList } from '../../api/routes'
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
      serviceNamesList: [],
      regionNameList: [],
      search: {
        region_office_id: 0,
        service_id: 0,
        org_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'service_name.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'component_settings.region', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 6 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: false,
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
        this.serviceNamesList = this.getSevicename(newVal)
        this.regionNameList = this.getRegionNameList(newVal)
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
          { key: 'org_name_bn' },
          { key: 'service_name_bn' },
          { key: 'region_office_bn' },
          { key: 'district_name_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'region_office' },
          { key: 'district_name' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('fee_name.fee_name') + ' ' + this.$t('globalTrans.entry') : this.$t('fee_name.fee_name') + ' ' + this.$t('globalTrans.modify')
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    getSevicename (orgId) {
        const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
        return service
    },
    getRegionNameList (orgId) {
      const tmpList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === orgId && item.is_regional_office === 1)
      return tmpList.map(item => ({ text: item.text, value: item.value }))
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, regionList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(law => law.value === parseInt(item.org_id))
          const serObj = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(law => law.value === parseInt(item.service_id))
          const regionObj = this.$store.state.CommonService.commonObj.officeList.find(law => law.value === parseInt(item.master_region_districts[0].region_id))
          const orgData = {}
          const serData = {}
          const regionData = {}
          if (typeof orgObj !== 'undefined') {
              orgData.org_name = orgObj.text_en
              orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }
          if (typeof serObj !== 'undefined') {
              serData.service_name = orgObj.text_en
              serData.service_name_bn = orgObj.text_bn
          } else {
            serData.service_name = ''
            serData.service_name_bn = ''
          }
          if (typeof regionObj !== 'undefined') {
              regionData.region_office = regionObj.text_en
              regionData.region_office_bn = regionObj.text_bn
          } else {
            regionData.region_office = ''
            regionData.region_office_bn = ''
          }
          const disData = item.master_region_districts
          let disNameEn = ''
          let disNameBn = ''
          const districtData = {}
          disData.forEach((district, index) => {
            const disInfo = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === district.district_id)
            if (disNameEn !== '' && disNameBn !== '') {
              disNameEn = disNameEn + ', ' + disInfo.text_en
              disNameBn = disNameBn + ', ' + disInfo.text_bn
            } else {
              disNameEn = disInfo.text_en
              disNameBn = disInfo.text_bn
            }
          })
          districtData.district_name = disNameEn
          districtData.district_name_bn = disNameBn
          return Object.assign({}, item, { serial: index }, orgData, serData, regionData, districtData)
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
