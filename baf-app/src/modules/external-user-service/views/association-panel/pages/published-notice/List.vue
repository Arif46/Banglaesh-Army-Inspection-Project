<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('associationPanel.published_notice') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <b-form-group
              label-for="from_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.from_date') }}
              </template>
                <date-picker id="from_date" v-model="search.from_date" class="form-control"
                  :placeholder="$t('globalTrans.select_date')">
                </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <b-form-group
              label-for="to_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.to_date') }}
              </template>
              <date-picker id="to_date" v-model="search.to_date" class="form-control"
                :placeholder="$t('globalTrans.select_date')">
              </date-picker>
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
        <h4 class="card-title">{{ $t('associationPanel.published_notice') }} {{ $t('globalTrans.list') }}</h4>
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
                 <template v-slot:cell(circular_no)="data">
                    {{ data.item.circular_memo_no }}
                  </template>
                  <template v-slot:cell(title)="data">
                    {{ currentLocale === 'bn' ? data.item.title_bn : data.item.title_en }}
                  </template>
                  <template v-slot:cell(deadline)="data">
                    {{  data.item.deadline | dateFormat }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="!data.item.proposal" v-b-modal.apply variant="status mr-1" @click="editMethodInParent(data.item,1)" class="btn btn-success btn-sm" :title="$t('globalTrans.apply')">{{$t('globalTrans.apply')}}</b-button>
                    <b-button v-if="data.item.proposal?.status < 2" v-b-modal.apply variant="iq-bg-success mr-1" size="sm" @click="editProposal(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="data.item.proposal?.status == 2" class="btn btn-success btn-sm">{{ $t('associationPnl.applied') }}</b-button>
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
    <b-modal id="apply" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :items="items" :associationInfo="associationInfo" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { publishedNoticeList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        from_date: '',
        to_date: '',
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'associationPanel.circular_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'associationPanel.deadline', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5, thStyle: { width: '12%' } }
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
          { key: 'circular_no' },
          { key: 'title' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'circular_no' },
          { key: 'title' },
          { key: 'deadline' },
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
    formTitle () {
      return (!this.id) ? this.$t('associationPnl.initital_proposal') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.initital_proposal') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPanel.published_notice') + ' ' + this.$t('globalTrans.view') : this.$t('associationPanel.published_notice') + ' ' + this.$t('globalTrans.modify')
    },
    sourceOfFundList: function () {
        const list = [
        { value: 1, text_en: 'Gov', text_bn: 'সরকারি' },
        { value: 2, text_en: 'Project', text_bn: 'প্রজেক্ট' },
        { value: 3, text_en: 'Other', text_bn: 'অন্যান্য' }
        ]
        return list
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
        this.items = item
      } else if (type === 2) {
        // this.changeStatus(3, eBizServiceBaseUrl, budgetEntryToggle, item)
      }
    },
    editProposal (item) {
       this.items = item
    },
    details (item) {
        this.items = item
    },
    searchData () {
      this.loadData()
    },
    getSource (id) {
        this.sourceOfFund.find(item => item.value === id)
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, publishedNoticeList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.associationInfo = result.association
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
