<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_management.paid_allocation') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="regional_office"
            >
              <template v-slot:label>
                {{ $t('allocation_management.regional_office') }}
              </template>
                 <b-form-select
                  plain
                  v-model="search.office_id"
                  :options="regionalOfficeList"
                  id="organization"
                  :disabled="lock_office"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Mobile" vid="mobile_no" rules="min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="mobile_no">
                <template v-slot:label>
                  {{ $t('globalTrans.mobile') }}
                </template>
                <b-form-input
                  id="mobile_no"
                  v-model="search.mobile_no"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Letter No" vid="letter_no" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="letter_no">
                <template v-slot:label>
                  {{ $t('allocation_management.letter_no') }}
                </template>
                <b-form-input
                  id="letter_no"
                  v-model="search.letter_no"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
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
        <h4 class="card-title">{{ $t('allocation_management.paid_allocation') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
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
                  <template v-slot:cell(district_id)="data">
                    {{ data.item.district_id }}
                  </template>
                  <template v-slot:cell(dealer_name)="data">
                    {{ $i18n.locale === 'bn' ? data.item.applicant_name_bn : data.item.applicant_name }}
                  </template>
                  <template v-slot:cell(company_name)="data">
                    {{ $i18n.locale === 'bn' ? data.item.company_name_bn : data.item.company_name }}
                  </template>
                  <!-- <template v-slot:cell(address)="data">
                    {{ data.item.details.address }}
                  </template> -->
                  <template v-slot:cell(mobile)="data">
                    {{ data.item.mobile | mobileNumber }}
                  </template>
                  <template v-slot:cell(agreement_no)="data">
                    {{ data.item.agreement_no }}
                  </template>
                  <template v-slot:cell(letter_no)="data">
                    {{ data.item.allocation_letter_id }}
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button :title="$t('globalTrans.details')" class="action-btn active view mx-2" v-b-modal.details @click="editMethodInParent(data.item,3)"> <i class="ri-eye-fill"></i>
                     </b-button>
                     <b-button v-if="data.item.verify_status == 1" v-b-modal.modal-form @click="editMethodInParent(data.item,1)" class="btn btn-sm btn-success"><i class="ri-send-plane-fill"></i>&nbsp;{{$t('globalTrans.send')}}
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
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paidAllocationList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      lock_office: false,
      search: {
        office_id: 0,
        mobile_no: '',
        letter_no: '',
        limit: 10
      },
      items: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'allocation_management.dealer_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'allocation_management.dealer_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'allocation_management.company_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        // { labels: 'allocation_management.address', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'allocation_management.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '20%' } },
        { labels: 'allocation_management.agreement_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '20%' } },
        { labels: 'allocation_management.letter_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 10, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 11 }
      ],
      actions: {
        edit: false,
        details: true,
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
          { key: 'dealer_type_bn' },
          { key: 'district_name_bn' },
          { key: 'dealer_name' },
          { key: 'company_name' },
          // { key: 'address' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'letter_no' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'dealer_type_en' },
          { key: 'district_name' },
          { key: 'dealer_name' },
          { key: 'company_name' },
          // { key: 'address' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'letter_no' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_management.paid_allocation') + ' ' + this.$t('globalTrans.entry') : this.$t('allocation_management.paid_allocation') + ' ' + this.$t('globalTrans.send')
    },
    viewTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_management.paid_allocation') + ' ' + this.$t('globalTrans.details') : this.$t('allocation_management.paid_allocation') + ' ' + this.$t('globalTrans.modify')
    },
    regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.org_id === 7 && item.is_regional_office === 1))
    },
    sellerTypeList () {
      return this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList
    },
    auth () {
      return this.$store.state.Auth
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 3) {
        this.details(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, paidAllocationList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.company_district_id))
        const sellerType = this.sellerTypeList.find(law => law.value === parseInt(item.dealer_type))
        const sellerData = { dealer_type_en: sellerType !== undefined ? sellerType.text_en : '', dealer_type_bn: sellerType !== undefined ? sellerType.text_bn : '' }
          const districtData = {}
          if (typeof districtObj !== 'undefined') {
            districtData.district_name = districtObj.text_en
            districtData.district_name_bn = districtObj.text_bn
          } else {
            districtData.district_name = ''
            districtData.district_name_bn = ''
          }
          return Object.assign({}, item, { serial: index }, sellerData, districtData)
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
