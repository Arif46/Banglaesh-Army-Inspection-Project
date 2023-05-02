<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exhibitCircularManagement.for_cir_of_exit') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('exhibitCircularManagement.for_cir_of_exit') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(deadline)="data">
                    {{ data.item.deadline | dateFormat }}
                  </template>
                  <template v-slot:cell(country_city)="data">
                    {{ currentLocale === 'bn' ? data.item.parti_circular.calendar_info.city_bn + ', ' + data.item.country_bn : data.item.parti_circular.calendar_info.city +', '+ data.item.country_en }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-secondary" v-else-if="data.item.status == 2">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 4">{{$t('globalTrans.return')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 5">{{$t('globalTrans.publish')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form-forward-details variant="iq-bg-info mr-1" size="sm" @click="forwardDetails(data.item)" class="action-btn active" :title="$t('exportTrophyGazette.forward_comment')"><i class="ri-message-2-line"></i></b-button>
                    <b-button v-if="data.item.status === 1 || data.item.status === 2" :title="$t('globalTrans.forward')" v-b-modal.modal-5 variant="iq-bg-info" class="action-btn btn-info" size="sm" @click="forward(data.item)"><i class="ri-share-forward-line"></i></b-button>
                    <b-button :title="$t('globalTrans.approve')" v-b-modal.modal-approve-return variant="iq-bg-info" class="action-btn btn-success" size="sm" @click="approveReturn(data.item.id, 3)"><i class="ri-check-line"></i></b-button>
                    <b-button :title="$t('globalTrans.return')" v-b-modal.modal-approve-return variant=" iq-bg-success border-info" class="action-btn btn-warning" size="sm" @click="approveReturn(data.item.id, 4)"><i class="ri-arrow-go-back-fill"></i></b-button>
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
    <b-modal id="modal-form-forward-details" size="lg" :title="$t('exportTrophyGazette.forward_comment')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ForwardDetails :item="itemData"/>
    </b-modal>
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :item="itemData"/>
    </b-modal>
    <b-modal id="modal-approve-return" size="md" :title="status === 3 ? $t('globalTrans.approve') : $t('globalTrans.return')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApproveReturn :id="itemId" :status="status"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Forward from './Forward'
import ApproveReturn from './ApproveReturn.vue'
import ForwardDetails from './ForwardComments.vue'
import { itfFairExhibitCircularForwardList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Forward, ApproveReturn, ForwardDetails
  },
  data () {
    return {
      sortBy: '',
      itemData: [],
      itemId: '',
      status: '',
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tradeFairInfoManagement.circular_memo_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'tradeFairInfoManagement.subject', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.city_country', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'tradeFairInfoManagement.submission_deadline', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 8 }
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
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
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
          { key: 'circular_memo_no' },
          { key: 'subject_bn' },
          { key: 'country_city' },
          { key: 'deadline' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_no' },
          { key: 'subject_en' },
          { key: 'country_city' },
          { key: 'deadline' },
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
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    forward (item) {
      this.itemData = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, itfFairExhibitCircularForwardList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const country = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(item.parti_circular.calendar_info.country_id))
          const customItem = {
            fiscal_year_en: fiscalYearData.text_en,
            fiscal_year_bn: fiscalYearData.text_bn,
            country_en: country.text_en,
            country_bn: country.text_bn
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
    forwardDetails (item) {
      this.itemData = item
    },
    approve (item) {
      this.itemData = item
    },
    returnData (item) {
      this.itemData = item
    },
    approveReturn (id, status) {
      this.itemId = id
      this.status = status
    }
  }
}
</script>
