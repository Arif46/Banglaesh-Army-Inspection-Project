<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizProposal.proposal_list') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
           <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
              <b-row>
            <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year" rules="required|min_value:1">
                <b-form-group
                  label-for="fiscal_year"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      id="fiscal_year"
                      :options="fiscalYearList"
                      v-model="search.fiscal_year_id"
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
            <b-col xs="12" sm="12" md="3" lg="3" xl="3">
              <ValidationProvider name="Source Of Fund" vid="source_of_fund" rules="required|min_value:1">
                <b-form-group
                  label-for="source_of_fund"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.source_of_fund')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="search.source_of_fund"
                  :options="sourceOfFund"
                  id="source_of_fund"
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
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                <ValidationProvider name="Circular No" vid="circular_notice_id" rules="required|min_value:1">
                      <b-form-group
                          label-for="circular_notice_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{$t('eBizProposal.circular_no')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="search.circular_notice_id"
                          :options="circularList"
                          id="circular_notice_id"
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
             <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                <ValidationProvider name="Council Name" vid="council_info_id" rules="required|min_value:1">
                      <b-form-group
                          label-for="council_info_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
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
          <b-col md="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
            <b-button type="submit" size="sm" variant="primary" class="mt-20">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
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
        <h4 class="card-title">{{ $t('eBizProposal.proposal_list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-button @click="pdfExport" class="btn btn-success btn-sm">
           <i class="ri-file-pdf-line"></i>&nbsp; {{  $t('globalTrans.pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                 <template v-slot:cell(association)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                 <template v-slot:cell(proposal_id)="data">
                    {{ data.item.proposal_id }}
                  </template>
                 <template v-slot:cell(circular_no)="data">
                    {{ data.item.circular.circular_memo_no }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 2">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 3">{{$t('globalTrans.processing')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 4">{{$t('globalTrans.approved')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { proposalTopSheetList, circularList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Pdf from './pdf'

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
        circularList: [],
        bpc_budget: {},
      search: {
        fiscal_year_id: 0,
        council_info_id: 0,
        circular_notice_id: 0,
        source_of_fund: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'associationPanel.association', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'associationPnl.proposal_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'associationPanel.circular_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7, thStyle: { width: '12%' } }
      ],
      items: [],
      viewitemId: 0,
      itemList: [],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    // this.loadData()
    this.getCircularNotice()
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
          { key: 'fiscal_year_bn' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'circular_no' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'circular_no' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    sourceOfFund () {
      let fundList = [
        {
          value: '1',
          text_en: 'Gov',
          text_bn: 'সরকারি'
        },
        {
            value: '2',
            text_en: 'Project',
            text_bn: 'প্রজেক্ট'
        },
        {
            value: '3',
            text_en: 'Other',
            text_bn: 'অন্যান্য'
        }
      ]
       fundList = fundList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return fundList
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('eBizProposal.proposal_list') + ' ' + this.$t('globalTrans.view') : this.$t('eBizProposal.proposal_list') + ' ' + this.$t('globalTrans.modify')
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
        this.items = item
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    calculateAmount (item) {
        return item.details.reduce((total, item) => total + parseFloat(item.amount), 0)
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
    getFiscalYear (id) {
      const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, proposalTopSheetList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
          const fiscalYearService = fiscalYearList.find(tmp => tmp.value === item.circular.fiscal_year_id)
          const fisalYearObj = {
          serial: index,
          fiscal_year: fiscalYearService !== 'undefined' ? fiscalYearService.text_en : '',
          fiscal_year_bn: fiscalYearService !== 'undefined' ? fiscalYearService.text_bn : ''
        }
          return Object.assign({}, item, fisalYearObj, { serial: index, select: 0 })
        })
        this.itemList = listData
        this.bpc_budget = result.bpc_total_budget
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async getCircularNotice () {
      const result = await RestApi.getData(eBizServiceBaseUrl, circularList, '')
      if (result.success) {
        this.circularList = result.data
      } else {
        this.circularList = []
      }
    },
    pdfExport () {
      Pdf.exportPdfDetails(eBizServiceBaseUrl, '/configuration/report-heading/detail', 2, this.itemList, this.bpc_budget, this.search, this)
    }
  }
}
</script>
