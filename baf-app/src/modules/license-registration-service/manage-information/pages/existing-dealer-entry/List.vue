<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('manage_information.existing_dealer_entry') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Regional Office"
            >
              <template v-slot:label>
                {{ $t('manage_information.regional_office') }}
              </template>
                 <b-form-select
                  plain
                  v-model="search.office_id"
                  :options="regionalOfficeList"
                  id="organization"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
            </b-form-group>
          </b-col>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Dealer Name" vid="dealer_name" rules="" v-slot="{ errors }">
                  <b-form-group
                  label-for="dealer_name"
                  >
                  <template v-slot:label>
                      {{ $t('manage_information.dealer_name') }}
                  </template>
                  <b-form-input
                      id="dealer_name"
                      v-model="search.name"
                      :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Company Name" vid="company_name" rules="" v-slot="{ errors }">
                  <b-form-group
                  label-for="company_name"
                  >
                  <template v-slot:label>
                      {{ $t('manage_information.company_name') }}
                  </template>
                  <b-form-input
                      id="company_name"
                      v-model="search.company_name"
                      :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="NID No" vid="nid_no" :rules="'max:'+(invalidNid ? 0 : (10|13|17))+'|min:10|numeric'" v-slot="{ errors }">
                    <b-form-group
                        label-for="nid"
                    >
                    <template v-slot:label>
                        {{ $t('globalTrans.nid') }}
                        </template>
                        <b-form-input
                            v-model="search.nid_no"
                           @input="nidRules($event)"
                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Mobile No" vid="mobile" v-slot="{ errors }" rules="min:11|max:11">
                  <b-form-group
                      label-for="mobile"
                  >
                  <template v-slot:label>
                      {{ $t('globalTrans.mobile') }}
                      </template>
                      <b-form-input
                          v-model="search.mobile"
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Dealer Agreement No." vid="agreement_no" rules="" v-slot="{ errors }">
                  <b-form-group
                      class="row"
                      label-for="agreement_no"
                  >
                  <template v-slot:label>
                      {{ $t('manage_information.agreement_no') }}
                      </template>
                      <b-form-input
                      id="agreement_no"
                      type="text"
                      v-model="search.agreement_no"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                      {{ errors[0] }}
                      </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col sm="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
          <b-col sm="9">
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('manage_information.existing_dealer_entry') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
      <router-link class="btn-add" to="existing-dealer-entry/create"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial +1) }}
                  </template>
                  <template v-slot:cell(office_id)="data">
                    {{ data.item.office_id }}
                  </template>
                  <template v-slot:cell(applicant_name)="data">
                    {{ $i18n.locale === 'bn' ? data.item.details.applicant_name_bn : data.item.details.applicant_name }}
                  </template>
                  <template v-slot:cell(company_name)="data">
                    {{ $i18n.locale === 'bn' ? data.item.details.company_name_bn : data.item.details.company_name }}
                  </template>
                  <template v-slot:cell(mobile)="data">
                    {{ $n(data.item.details.mobile, {useGrouping:false}) }}
                  </template>
                  <template v-slot:cell(agreement_no)="data">
                    {{ data.item.agreement_no }}
                  </template>
                  <template v-slot:cell(agreement_date)="data">
                    {{ data.item.agreement_date | dateFormat }}
                  </template>
                  <template v-slot:cell(expire_date)="data">
                    {{ data.item.expire_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 5">{{$t('globalTrans.archive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                  <router-link class="action-btn active view" variant=" iq-bg-success mr-1" :title="$t('globalTrans.view')" :to="`/license-registration-service/license-management/application-show/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
                    <router-link class="action-btn active view" variant=" iq-bg-warning mr-1" :title="$t('globalTrans.edit')" :to="`/license-registration-service/manage-information/existing-dealer-entry/edit/${data.item.id}`"><i class="ri-pencil-fill"></i></router-link>
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
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>

import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { existingDealerList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      applications: [],
      search: {
       application_id: '',
       name: '',
       company_name: '',
       mobile: '',
       agreement_no: '',
       nid_no: '',
       org_id: 0,
       office_id: 0,
       to_date: '',
       limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'manage_information.regional_office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'manage_information.dealer_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'manage_information.company_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'globalTrans.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
        { labels: 'manage_information.agreement_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '25%' } },
        { labels: 'license_management.agreement_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '25%' } },
        { labels: 'license_management.agreement_expire_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 10 }
      ],
      invalidNid: 1,
      actions: {
        edit: false,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.search.office_id = this.$store.state.Auth.authUser.office_detail.office_id
    }
    this.loadData()
  },
  mounted () {
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7)
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
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
          { key: 'office_name_bn' },
          { key: 'applicant_name' },
          { key: 'company_name' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'agreement_date' },
          { key: 'expire_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'office_name' },
          { key: 'applicant_name' },
          { key: 'company_name' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'agreement_date' },
          { key: 'expire_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
      nidRules (e) {
      if (e.length) {
        this.invalidNid = (parseInt(e.length) === 10 || parseInt(e.length) === 13 || parseInt(e.length) === 17) ? 0 : 1
      } else {
        this.invalidNid = 1
      }
    },
    clickForward () {
      const appIds = this.applications.map(item => {
        return item.id
      })
      this.$router.push({
        path: '/license-registration-service/license-management/forward',
        query: { applications: JSON.stringify(appIds) }
      })
    },
    checkApplication (value) {
      if (value.select) {
        this.applications.push({
          application_id: value.application_id,
          id: value.id
        })
      } else {
        this.applications = this.applications.filter(item => {
          return item.application_id !== value.application_id
        })
      }
    },
    checkAll (value) {
      if (value) {
        const applications = this.listData.map(item => {
          return { application_id: item.application_id, id: item.id }
        })
        this.applications = applications
      } else {
        this.applications = []
      }
    },
    editMethodInParent (item, type) {
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.search.limit })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, existingDealerList, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(law => law.value === parseInt(item.org_id))
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(law => law.value === parseInt(item.office_id))
          const orgData = {}
            if (typeof orgObj !== 'undefined') {
                orgData.org_name = orgObj.text_en
                orgData.org_name_bn = orgObj.text_bn
            } else {
              orgData.org_name = ''
              orgData.org_name_bn = ''
            }
          const officeData = {}
            if (typeof officeObj !== 'undefined') {
                officeData.office_name = officeObj.text_en
                officeData.office_name_bn = officeObj.text_bn
            } else {
              officeData.office_name = ''
              officeData.office_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, orgData, officeData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictName (id) {
      const data = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getTypeName (id) {
      const data = this.$store.state.LicenseRegistrationService.commonObj.applicationTypeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    }
  }
}
</script>
