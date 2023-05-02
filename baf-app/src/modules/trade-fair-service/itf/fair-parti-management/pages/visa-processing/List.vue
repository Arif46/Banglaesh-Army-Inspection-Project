<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairConfig.visa_process_info') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('tradeFairConfig.visa_process_info') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(visa)="data">
                    <span v-if="data.item.is_visa_ready == 0">
                      <span class="badge badge-danger blink_me" v-if="!data.item.visa_docs.length && data.item.visa_info">Visa Submitted</span>
                      <span class="badge badge-warning" v-else>{{ $t('tradeFairConfig.visa_processing') }}</span>
                    </span>
                    <span class="badge badge-success" v-else>{{ $t('tradeFairConfig.visa_processed') }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant="iq-bg-primary" size="sm" @click="detailsData(data.item)" class="action-btn edit" :title="$t('globalTrans.view')"><i class="ri-eye-line"></i></b-button>
                    <b-button v-b-modal.modal-2 variant="iq-bg-success" size="sm" @click="returnItem(data.item)" class="approve action-btn" :title="$t('tradeFairConfig.visa_related_attach')"><i :class="data.item.visa_info ? 'ri-file-download-line' : 'ri-file-upload-line'"></i></b-button>
                    <b-button v-if="data.item.visa_info?.visa_start_date && !data.item.is_visa_ready" :title="$t('globalTrans.approve')" variant="iq-bg-info" class="action-btn btn-success" size="sm" @click="approveStatus(data.item)"><i class="ri-check-line"></i></b-button>
                    <b-button v-b-modal.modal-refund v-if="!data.item.visa_info?.visa_start_date && !data.item.is_visa_ready" :title="$t('globalTrans.refund')" variant="iq-bg-info" class="action-btn btn-danger" size="sm" @click="detailsData(data.item)"><i class="ri-arrow-go-back-line"></i></b-button>
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
    <b-modal id="modal-2" size="lg" :title="$t('tradeFairConfig.visa_related_attach')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FormV :id="detailsItemId"/>
    </b-modal>
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.fair_participation_payment') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" ref="details"/>
    </b-modal>
    <b-modal id="modal-refund" size="md" :title="$t('globalTrans.refund') + ' ' + $t('globalTrans.comments')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <VisaApproveModal :id="detailsItemId"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import VisaApproveModal from './VisaApproveModal'
import FormV from './Form'
import Details from '../approved-participation/Details'
import { approvedParticipantList, visaProcessingApproveApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    FormV,
    VisaApproveModal
  },
  data () {
    return {
      sortBy: '',
      detailsItemId: 0,
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        visa_menu: 1,
        limit: 20
      },
      fairNameList: [],
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
    currentLocale () {
      return this.$i18n.locale
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
          { key: 'visa' },
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
          { key: 'visa' },
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
    changeStatus (baseUrl, uri, item) {
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
            if (response.success) {
              this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: this.$t('globalTrans.update_msg'),
                  color: '#D6E09B'
              })
            } else {
                this.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
            })
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
        })
    },
    detailsData (item) {
      this.detailsItemId = item.id
    },
    approveStatus (item) {
      this.$swal({
        title: this.$t('globalTrans.approveMsg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.changeStatus(internationalTradeFairServiceBaseUrl, visaProcessingApproveApi, item)
        }
      })
    },
    getFairNameList () {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
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
    },
    returnItem (item) {
      this.detailsItemId = item.id
    },
    reject (item) {
      this.detailsItemId = item.id
    },
    getCompanyName (Id) {
        const Obj = this.$store.state.TradeFairService.commonObj.companyTypeList.find(el => el.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
          return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
        }
        return ''
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, approvedParticipantList, params)
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
          return Object.assign({}, item, { serial: index }, customItem)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style scoped>
  .modal-title {
    flex-grow: 1 !important;
  }
  .blink_me {
    animation: blinker 2.5s linear infinite;
    color: #fff;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      /* background-color: green; */
    }
  }
</style>
