<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.service_assign') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                  <b-form-group
                      label-for="org_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{$t('globalTrans.org_name')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                      plain
                      v-model="search.org_id"
                      :options="orgList"
                      id="org_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                  <b-form-group
                      label-for="office_type_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('userManagement.office_type')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                      plain
                      v-model="search.office_type_id"
                      :options="officeTypeList"
                      id="office_type_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                  <b-form-group
                      label-for="office_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('userManagement.office')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.office_id"
                      :options="officeList"
                      id="office_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                      <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col sm="12" class="mt-12 text-right">
              <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('teaGardenConfig.service_assign') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
      <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
      <router-link class="btn-add" to="/tea-garden-service/configuration/service-assign/form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
      </template>
      <template v-slot:body>
      <b-overlay :show="loadingState">
        <select-column-check :labelData="labelData" :search="search" :columns="columns" />
        <b-row>
          <b-col md="12" class="table-responsive">
            <slot v-if ="columns.filter(item => item.show === '1').length > 0">
              <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                <template v-slot:cell(serial)="data">
                  {{ $n(data.item.serial + pagination.slOffset) }}
                </template>
                <template v-slot:cell(status)="data">
                  <span class="badge badge-danger" v-if="data.item.status == 2">{{$t('priceMonitoring.unpublish')}}</span>
                  <span class="badge badge-success" v-if="data.item.status == 3">{{$t('priceMonitoring.published')}}</span>
                </template>
                <template v-slot:cell(name)="data">
                  <b>{{ ($i18n.locale === 'bn' ? data.item.name_bn : data.item.name_en) }}</b>,  <span v-if="data.item.mobile">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(data.item.mobile, { useGrouping: false }) }}</span>
                </template>
                <template v-slot:cell(action)="data">
                  <!-- <router-link class="action-btn edit" :title="$t('globalTrans.edit')" :to="{ name: 'bazar_monitoring_service.configuration.price_form', params: { id: data.item.id, latitude: data.item.latitude, longitude: data.item.longitude }}" size="sm">
                    <i class="ri-pencil-fill"></i>
                  </router-link> -->
                  <b-button variant=" iq-bg-info" v-if="data.item.status == 2" size="sm" @click="publishStatus(data.item)" class="action-btn approve" :title="$t('globalTrans.delete')"><i class="ri-check-fill"></i></b-button>
                  <b-button class="mr-2" :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status mr-1" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-form" size="xl" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
     <b-modal id="modal-4" size="lg" :title="$t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
        <Details :id="detailsItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { masterServiceAssignList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      detailsItemId: '',
      item: '',
      search: {
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'userManagement.office_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'userManagement.office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '13%' } },
        { labels: 'globalTrans.name_and_mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '13%' } },
        { labels: 'globalTrans.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '14%' } },
        { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } }
      ],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      },
      officeTypeList: [],
      officeList: []
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.officeTypeList = this.getOfficeTypeList(newVal)
      } else {
          this.officeTypeList = []
      }
    },
    'search.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.officeList = this.getOfficeList(newVal)
      } else {
          this.officeList = []
      }
    },
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
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
          { key: 'office_type_name_bn' },
          { key: 'name' },
          { key: 'designation_name_bn' },
          { key: 'service_bn' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'office_type_name' },
          { key: 'office_name' },
          { key: 'name' },
          { key: 'designation_name' },
          { key: 'service' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.service_name') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.service_name') + ' ' + this.$t('globalTrans.modify')
    },
    masterServiceList () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
    }
  },
  methods: {
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, masterServiceAssignList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObjList = this.$store.state.CommonService.commonObj.componentOrgList.find(org => org.value === parseInt(item.org_id))
          const orgData = {}
          if (typeof orgObjList !== 'undefined') {
            orgData.org_name = orgObjList.text_en
            orgData.org_name_bn = orgObjList.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }
          const officeTypeObj = this.$store.state.CommonService.commonObj.officeTypeList.find(officeType => officeType.value === parseInt(item.office_type_id))
          const officeTypeData = {}
          if (typeof officeTypeObj !== 'undefined') {
            officeTypeData.office_type_name = officeTypeObj.text_en
            officeTypeData.office_type_name_bn = officeTypeObj.text_bn
          } else {
            officeTypeData.office_type_name = ''
            officeTypeData.office_type_name_bn = ''
          }
          const officeNameObj = this.$store.state.CommonService.commonObj.officeList.find(officeName => officeName.value === parseInt(item.office_id))
          const officeNameData = {}
          if (typeof officeNameObj !== 'undefined') {
            officeNameData.office_name = officeNameObj.text_en
            officeNameData.office_name_bn = officeNameObj.text_bn
          } else {
            officeNameData.office_name = ''
            officeNameData.office_name_bn = ''
          }
          const desigObj = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === parseInt(item.designation_id))
          const desigData = {}
          if (typeof desigObj !== 'undefined') {
            desigData.designation_name = desigObj.text_en
            desigData.designation_name_bn = desigObj.text_bn
          } else {
            desigData.designation_name = ''
            desigData.designation_name_bn = ''
          }
          const serviceText = item.service_id
          const serviceArray = serviceText ? serviceText.split(',') : null
          let serviceData
          let serviceDataBn
          if (serviceArray && serviceArray.length) {
              serviceData = serviceArray.map(areaItem => {
                  const serviceObj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(area => area.value === parseInt(areaItem))
                  return serviceObj !== undefined ? serviceObj.text_en : ''
              })
              serviceDataBn = serviceArray.map(areaItem => {
                  const serviceObj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(area => area.value === parseInt(areaItem))
                  return serviceObj !== undefined ? serviceObj.text_bn : ''
              })
              serviceData = serviceData.join(', ')
              serviceDataBn = serviceDataBn.join(', ')
          } else {
              serviceData = null
              serviceDataBn = null
          }
          return Object.assign({}, item, { serial: index }, officeTypeData, orgData, officeNameData, desigData,
            { service: serviceData, service_bn: serviceDataBn })
          })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getOfficeTypeList (orgId) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === OfficeTypeID)
    }
  }
}
</script>
