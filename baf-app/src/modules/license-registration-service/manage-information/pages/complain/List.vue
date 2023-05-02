<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('manage_information.complain') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Region" vid="office_id" rules="required">
              <b-form-group
                label-for="office_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('manage_information.regional_office')}}
              </template>
              <b-form-select
                plain
                v-model="search.office_id"
                :options="regionalOfficeList"
                id="office_id"
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
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="complain_id"
                >
                <template v-slot:label>
                    {{ $t('manage_information.complain_id') }}
                </template>
                <b-form-input
                    id="complain_id"
                    v-model="search.complain_id"
                    >
                </b-form-input>
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
        <h4 class="card-title">{{ $t('manage_information.complain') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(complain_id)="data">
                    {{ $n(data.item.complain_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(office_id)="data">
                    {{ data.item.office_id }}
                  </template>
                  <template v-slot:cell(userExternal)="data">
                    {{ getExterUserName(data.item.user_id) }}
                  </template>
                  <template v-slot:cell(subject)="data">
                    {{ data.item.subject }}
                  </template>
                  <template v-slot:cell(details)="data">
                    {{ data.item.details }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 0">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('manage_information.done')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button v-b-modal.modal-form @click="editMethodInParent(data.item,1)" class="btn btn-sm btn-success">{{$t('manage_information.feedback')}}
                     </b-button>
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
import Form from './Form.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { fdComplainList } from '../../api/routes'
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
        office_id: 0,
        complain_id: '',
        limit: 10
      },
      userDetails: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'manage_information.complain_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'manage_information.regional_office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '' } },
        { labels: 'manage_information.complainer_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '' } },
        { labels: 'manage_information.subject', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '' } },
        { labels: 'manage_information.details', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8 }
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
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.search.office_id = this.$store.state.Auth.authUser.office_detail.office_id
    }
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
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
          { key: 'complain_id' },
          { key: 'office_name_bn' },
          { key: 'userExternal' },
          { key: 'subject' },
          { key: 'details' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'complain_id' },
          { key: 'office_name' },
          { key: 'userExternal' },
          { key: 'subject' },
          { key: 'details' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('manage_information.feedback') + ' ' + this.$t('globalTrans.entry') : this.$t('manage_information.feedback') + ' ' + this.$t('globalTrans.modify')
    },
   regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7)
    },
    serviceList () {
        return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1)
    }
  },
  methods: {
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
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, fdComplainList, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(law => law.value === parseInt(item.office_id))
           const officeData = {}
            if (typeof officeObj !== 'undefined') {
                officeData.office_name = officeObj.text_en
                officeData.office_name_bn = officeObj.text_bn
            } else {
              officeData.office_name = ''
              officeData.office_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, officeData)
        })
        this.userDetails = result.userIds
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getExterUserName (id) {
      const userName = this.userDetails.find(user => user.value === parseInt(id))
        if (userName !== undefined) {
          if (this.$i18n.locale === 'bn') {
            return userName.text_bn
          } else {
            return userName.text_en
          }
        }
    }
  }
}
</script>
