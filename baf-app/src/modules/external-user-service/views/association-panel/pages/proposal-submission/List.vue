<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('associationPnl.proposal_list') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
        <b-col lg="4" sm="4">
              <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="">
            <b-form-group
              label-for="fiscal_year_id"
              slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }}
                </template>
                <b-form-select
                  plain
                  id="fiscal_year_id"
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
         <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Council Name" vid="council_info_id" rules="">
                  <b-form-group
                      label-for="council_info_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eBizProposal.council_name')}}
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
        <h4 class="card-title">{{ $t('associationPnl.proposal_list') }}</h4>
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
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                 <template v-slot:cell(proposal_id)="data">
                    {{ data.item.proposal_id }}
                  </template>
                 <template v-slot:cell(circular_no)="data">
                    {{ data.item.circular.circular_memo_no }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.draft')}}</span>
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
import { proposalList } from '../../api/routes'
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
        user_id: this.$store.state.Auth.authUser.user_id,
        fiscal_year_id: 0,
        council_info_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'associationPanel.proposal_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'associationPanel.circular_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '12%' } }
      ],
      items: [],
      associationInfo: {},
      viewitemId: 0,
      actions: {
        edit: true,
        toogle: true,
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
          { key: 'proposal_id' },
          { key: 'circular_no' },
          { key: 'fiscal_year_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'proposal_id' },
          { key: 'circular_no' },
          { key: 'fiscal_year' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.proposal_list') + ' ' + this.$t('globalTrans.view') : this.$t('associationPnl.proposal_list') + ' ' + this.$t('globalTrans.modify')
    },
    councilInfoList () {
      return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
        this.items = item
    },
     editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
        this.items = item
      } else if (type === 2) {
        // this.changeStatus(3, eBizServiceBaseUrl, budgetEntryToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, proposalList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
          const fiscalYearService = fiscalYearList.find(tmp => tmp.value === item.circular.fiscal_year_id)
          const fisalYearObj = {
          serial: index,
          fiscal_year: fiscalYearService !== 'undefined' ? fiscalYearService.text_en : '',
          fiscal_year_bn: fiscalYearService !== 'undefined' ? fiscalYearService.text_bn : ''
        }
          return Object.assign({}, item, fisalYearObj, { serial: index })
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
