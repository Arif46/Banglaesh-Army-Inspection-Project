<template>
  <div class="inner-section">
    <card>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('associationPnl.program_request') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                 <template v-slot:cell(program_no)="data">
                    {{ $n(data.item.program_no, {useGrouping: false}) }}
                  </template>
                 <template v-slot:cell(circular_no)="data">
                    {{ data.item.circular.circular_memo_no }}
                  </template>
                  <template v-slot:cell(start_date)="data">
                    {{ data.item.start_date | dateFormat }}
                  </template>
                  <template v-slot:cell(end_date)="data">
                    {{ data.item.end_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 2">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 3">{{$t('globalTrans.processing')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 4">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-primary" v-if="data.item.status == 5">{{$t('associationPnl.agreement')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="data.item.adv_payment_status == 1" v-b-modal.modal-form-add-item variant=" iq-bg-success mr-1" size="sm" @click="addHeadItem(data.item)" class="action-btn edit" :title="$t('globalTrans.add')"><i class="ri-file-add-fill"></i></b-button>
                    <b-button  v-b-modal.modal-details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.adv_payment_status == 1"  v-b-modal.modal-edit variant="action-btn status mr-1" size="sm" @click="edit(data.item)" class="action-btn status" :title="$t('globalTrans.edit')"><i class="ri-edit-circle-fill"></i></b-button>
                    <!-- <b-button v-if="data.item.adv_payment_status != 3" v-b-modal.modal-form-advanced-payment variant="action-btn status mr-1" size="sm" @click="advPayment(data.item)" class="action-btn status" :title="$t('associationPnl.advanced_payment')"><i class="ri-currency-fill"></i></b-button> -->
                    <b-button v-if="data.item.adv_payment_status < 3 && data.item.status < 2" v-b-modal.modal-form-advanced-payment variant="action-btn status mr-1" size="sm" @click="advPayment(data.item)" class="action-btn status" :title="$t('associationPnl.advanced_payment')"><i class="ri-currency-fill"></i></b-button>
                    <b-button v-if="data.item.adv_payment_status >= 1 && data.item.status == 1"  v-b-modal.modal-final-save variant="action-btn status mr-1" size="sm" @click="finalSave(data.item)" class="action-btn status" :title="$t('associationPnl.final_save')"><i class="ri-save-3-fill"></i></b-button>
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
    <b-modal id="modal-form-add-item" size="lg" :title="formTitleAddItemAdd" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FormAddItem :id="proRequestId" :key="proRequestId"/>
    </b-modal>
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="modal-edit" size="lg" :title="formTitleAddItemEdit" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <FormEdit :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="modal-form-advanced-payment" size="lg" :title="formTitleAdvancedPayment" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FormAdvancedPayment :id="proRequestId" :key="proRequestId"/>
    </b-modal>
    <b-modal id="modal-final-save" size="lg" :title="finalSaveTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <FinalSave :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import Form from './Form.vue'
import FormEdit from './Form-edit.vue'
import FormAddItem from './Form-add-item.vue'
import FormAdvancedPayment from './Form-advanced-payment.vue'
import FinalSave from './Final-save.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details, FormAddItem, FormEdit, FormAdvancedPayment, FinalSave
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
      search: {
        user_id: this.$store.state.Auth.authUser.user_id,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'associationPnl.proposal_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'associationPnl.program_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'associationPnl.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'associationPnl.start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'associationPnl.end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '25%' } }
      ],
      items: [],
      proRequestId: 0,
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
          { key: 'program_no' },
          { key: 'programe_name_bn' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'proposal_id' },
          { key: 'program_no' },
          { key: 'programe_name_en' },
          { key: 'start_date' },
          { key: 'end_date' },
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
      return (this.viewitemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('globalTrans.view') : this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.modify')
    },
    finalSaveTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save') : this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save')
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.program_request') + ' ' + this.$t('globalTrans.modify')
    },
    formTitleAddItemAdd () {
      return (this.proRequestId === 0) ? this.$t('associationPnl.expenditure_item') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.expenditure_item') + ' ' + this.$t('globalTrans.entry')
    },
    formTitleAddItemEdit () {
      return (this.proRequestId === 0) ? this.$t('associationPnl.expenditure_item') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.expenditure_item') + ' ' + this.$t('globalTrans.modify')
    },
    formTitleAdvancedPayment () {
      return (this.proRequestId === 0) ? this.$t('associationPnl.advanced_payment') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.advanced_payment') + ' ' + this.$t('globalTrans.entry')
    },
    councilInfoList () {
      return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    addHeadItem (item) {
      this.proRequestId = item.id
    },
    details (item) {
        this.items = item
    },
    edit (item) {
      this.items = item
    },
    advPayment (item) {
      this.proRequestId = item.id
    },
    finalSave (item) {
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
      const result = await RestApi.getData(eBizServiceBaseUrl, programList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fisalYearObj = {
          serial: index
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
