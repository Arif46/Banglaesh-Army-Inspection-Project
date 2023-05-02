<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('approvedParticipation.fair_parti_payment') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{ $t('globalTrans.fiscal_year') }}
              </template>
              <b-form-select
                plain
                id="fiscal_year_id"
                :options="fiscalYearList"
                v-model="search.fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
                label-for="fair_name"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.fair_name') }}
                </template>
              <b-form-select
                plain
                id="fair_name"
                :options="fairNameList"
                v-model="search.fair_name_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0 disabled>{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title">{{ $t('approvedParticipation.fair_parti_payment') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(company_name)="data">
                    {{ data.item.company_type !== 4 ? getCompanyName(data.item.company_type) : ($i18n.locale == 'en' ? data.item.other_comp_type_en : data.item.other_comp_type_bn) }}
                  </template>
                  <template v-slot:cell(establishment_year)="data">
                    {{ $n(data.item.establishment_year, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 4">{{$t('globalTrans.return')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 5">{{$t('approvedParticipation.resubmit')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant="iq-bg-primary" size="sm" @click="detailsData(data.item)" class="action-btn edit" :title="$t('globalTrans.view')"><i class="ri-eye-line"></i></b-button>
                    <b-button v-b-modal.modal-return variant="iq-bg-success" size="sm" @click="returnItem(data.item)" class="action-btn approve" :title="$t('globalTrans.return')"><i class="ri-arrow-go-back-line"></i></b-button>
                    <b-button v-b-modal.modal-reject variant="iq-bg-danger" size="sm" @click="reject(data.item)" class="action-btn btn-danger" :title="$t('globalTrans.reject')"><i class="ri-close-line"></i></b-button>
                    <b-button v-if="data.item.evaluated.length === 0" v-b-modal.modal-checklist variant="iq-bg-info" size="sm" @click="checklist(data.item)" class="action-btn btn-edit" :title="$t('approvedParticipation.criteria_checklist')"><i class="ri-checkbox-multiple-line"></i></b-button>
                    <b-button v-if="data.item.evaluated.length > 0" variant="iq-bg-info" size="sm" @click="publishStatus(data.item)" class="action-btn status" :title="$t('globalTrans.approve')"><i class="ri-check-fill"></i></b-button>
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
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.fair_participation_payment') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" ref="details"/>
    </b-modal>
    <b-modal id="modal-return" size="lg" :title="$t('globalTrans.return')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Return :items="itemData"/>
    </b-modal>
    <b-modal id="modal-checklist" size="lg" :title="$t('approvedParticipation.criteria')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Checklist :items="itemData"/>
    </b-modal>
    <b-modal id="modal-reject" size="lg" :title="$t('globalTrans.reject')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Reject :items="itemData"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from '../approved-participation/Details'
import Reject from './Reject'
import Checklist from './Checklist'
import Return from './Return'
import { itfFairPariPaymentInfo, itfFairPariPaymentInfoApprove } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Reject, Checklist, Return
  },
  data () {
    return {
      sortBy: '',
      detailsItemId: '',
      itemData: [],
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        limit: 20
      },
      fairNameList: [],
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.fair_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.participation_id', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'externalTradeFair.comp_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.address', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.type_of_comp', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.establishment_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 10 }
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
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (this.search.fiscal_year_id) {
        this.fairNameList = this.getFairNameList()
      }
    }
  },
  computed: {
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
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
          { key: 'fiscal_year_bn' },
          { key: 'fair_name_bn' },
          { key: 'app_auto_id' },
          { key: 'name_bn' },
          { key: 'address_bn' },
          { key: 'company_name' },
          { key: 'establishment_year' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'fair_name_en' },
          { key: 'app_auto_id' },
          { key: 'name_en' },
          { key: 'address_en' },
          { key: 'company_name' },
          { key: 'establishment_year' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tradeFairPartiCircularManagement.fair_parti_circular') + ' ' + this.$t('globalTrans.entry') : this.$t('tradeFairPartiCircularManagement.fair_parti_circular') + ' ' + this.$t('globalTrans.modify')
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    }
  },
  methods: {
    getFairNameList () {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    detailsData (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    getCompanyName (Id) {
        const Obj = this.$store.state.TradeFairService.commonObj.companyTypeList.find(el => el.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
          return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
        }
        return ''
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    returnItem (item) {
      this.itemData = item
    },
    reject (item) {
      this.itemData = item
    },
    checklist (item) {
      this.itemData = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, itfFairPariPaymentInfo, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fair_circular.fiscal_year_id))
          const tmpFair = this.$store.state.TradeFairService.commonObj.fairNameList.find(obj => obj.value === parseInt(item.fair_circular.fair_name_id))
          const customItem = {
            fiscal_year_en: fiscalYearData.text_en,
            fiscal_year_bn: fiscalYearData.text_bn,
            fair_name_en: tmpFair !== undefined ? tmpFair.text_en : '',
            fair_name_bn: tmpFair !== undefined ? tmpFair.text_bn : ''
          }
          return Object.assign({}, item, { serial: index }, customItem, { fair_circular_en: item.fair_circular.subject_en, fair_circular_bn: item.fair_circular.subject_bn })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    publishStatus (item) {
      window.vm.$swal({
        title: window.vm.$t('approvedParticipation.approve_msg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          result = RestApi.postData(internationalTradeFairServiceBaseUrl, itfFairPariPaymentInfoApprove, item)
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)

          if (result.success) {
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.$t('globalTrans.update_msg'),
              color: '#D6E09B'
            })
          }
        }
      })
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
