<template>
  <div class="inner-section">
   <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('informationTraining.business_directory_search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row class="mt-4">
          <b-col lg="4" sm="4">
            <ValidationProvider name="Council" vid="council_info_id" rules="required|min_value:1">
                <b-form-group
                  label-for="council_info_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizReports.council')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="search.council_info_id"
                  :options="councilInfoList"
                  id="council_info_id"
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
          <b-col lg="4" sm="4">
            <ValidationProvider name="Association" vid="association_info_id" rules="">
                <b-form-group
                  label-for="association_info_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizReports.association')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.association_info_id"
                  :options="associationList"
                  id="association_info_id"
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
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{$t('globalTrans.search')}}</b-button>
          </b-col>
        </b-row>
        </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('informationTraining.business_directory_list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + 1) }}
                  </template>
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.application_date | dateFormat }}
                  </template>
                  <template v-slot:cell(council_name)="data">
                    {{ getCouncilName(data.item.council_info_id) }}
                  </template>
                  <template v-slot:cell(association_name)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                  <template v-slot:cell(company_mobile)="data">
                    {{ data.item.company_mobile | mobileNumber }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status <= 2 " >{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-danger" v-if="data.item.status === 3">{{$t('globalTrans.rejected')}}</span>
                    <span class="badge badge-success" v-if="data.item.status === 4">{{$t('globalTrans.approved')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button v-b-modal.modal-details variant=" iq-bg-success mr-1" size="sm" @click="details(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <template v-if="data.item.status < 4">
                      <b-button v-if="data.item.status == 2" variant="iq-bg-success mr-1" size="sm" @click="confirmForwardOrReject(data.item.id,1)" class="action-btn edit btn-success" :title="$t('globalTrans.approve')"><i class="ri-check-fill"></i>
                      </b-button>
                      <b-button v-if="data.item.status == 2" variant="iq-bg-danger mr-1" size="sm" @click="confirmForwardOrReject(data.item.id,2)" class="action-btn edit btn-danger" :title="$t('globalTrans.reject')"><i class="ri-close-line"></i>
                      </b-button>
                    </template>
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
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { businessDirectoryList, businessDirectoryApprove, businessDirectoryReject } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        fiscal_year_id: 0,
        council_info_id: 0,
        association_info_id: 0,
        from_date: '',
        to_date: '',
        limit: 10
      },
      items: [],
      associationList: [],
      associationInfoList: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'eBizProposal.council_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '5%' } },
        { labels: 'eBizProposal.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '5%' } },
        { labels: 'eBizProgram.type_of_business', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '5%' } },
        { labels: 'manage_information.company_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '5%' } },
        { labels: 'teaGardenConfig.company_address', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '5%' } },
        { labels: 'informationTraining.company_phone_or_mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '5%' } },
        { labels: 'informationTraining.company_email', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '5%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '5%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '5%' } }
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
    this.loadData()
  },
  watch: {
      'search.council_info_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
        this.associationList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === newVal)
        }
      },
     'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
       const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === newVal)
       this.search.from_date = fiscalYear.start_date
       this.search.to_date = fiscalYear.end_date
      }
    }
  },
  computed: {
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
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
          { key: 'council_name_bn' },
          { key: 'association_name_bn' },
          { key: 'type_of_business_bn' },
          { key: 'company_name_bn' },
          { key: 'company_address_bn' },
          { key: 'company_mobile' },
          { key: 'company_email' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'council_name_en' },
          { key: 'association_name_en' },
          { key: 'type_of_business_en' },
          { key: 'company_name' },
          { key: 'company_address' },
          { key: 'company_mobile' },
          { key: 'company_email' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('globalTrans.application') + ' ' + this.$t('globalTrans.entry') : this.$t('globalTrans.application') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return this.$t('InformationTraining.business_directory') + ' ' + this.$t('globalTrans.details')
    }
  },
  methods: {
    edit (item) {
        this.editItemId = item.id
      },
      editMethodInParent (item, type) {
          if (type === 1) {
            this.edit(item)
          }
      },
      details (item) {
        this.items = item
      },
      getCouncilName (councilNameId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, businessDirectoryList, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    confirmForwardOrReject (appId, hasForword) {
      this.$swal({
        title: this.$t('globalTrans.surePrompt'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          if (hasForword === 1) {
            this.forward(appId)
          } else {
            this.reject(appId)
          }
        }
      })
    },
    async forward (appId) {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      const result = await RestApi.postData(eBizServiceBaseUrl, `${businessDirectoryApprove}/${parseInt(appId)}`)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.update_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('globalTrans.sorry_error'),
          color: '#DC143C'
        })
      }
    },
  async reject (appId) {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      const result = await RestApi.postData(eBizServiceBaseUrl, `${businessDirectoryReject}/${parseInt(appId)}`)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.update_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('globalTrans.sorry_error'),
          color: '#DC143C'
        })
      }
  }
  }
}
</script>
