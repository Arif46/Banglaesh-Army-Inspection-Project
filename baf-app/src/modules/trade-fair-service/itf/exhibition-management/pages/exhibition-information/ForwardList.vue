<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exhibitCircularManagement.fair_exhibition_forward_info') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('exhibitCircularManagement.fair_exhibition_forward_info') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:head(check)>
                    <b-form-checkbox
                      style="display: table-cell"
                      class="col-form-label-sm font-weight-bold mb-0"
                      name="checked"
                      v-model="selectAll"
                      @change="checkAll"
                      :value=true
                      :unchecked-value=false
                    >
                    {{ $t('globalTrans.forward') }}
                    </b-form-checkbox>
                  </template>
                  <template v-slot:cell(check)="data">
                    <b-form-group class="mb-0" v-slot="{ ariaDescribedby }">
                      <b-form-checkbox-group v-model="selectedItem" style="margin-top: 5px" :aria-describedby="ariaDescribedby">
                        <b-form-checkbox :value="data.item.id" style="margin-right: 0"></b-form-checkbox>
                      </b-form-checkbox-group>
                    </b-form-group>
                  </template>
                  <template v-slot:cell(company_type)="data">
                    {{ getCompanyTypeName(data.item.company_type) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-secondary" v-else-if="data.item.status == 2">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 4">{{$t('globalTrans.return')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 5">{{$t('exhibitCircularManagement.resubmit')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-details variant=" action-btn status" size="sm" @click="details(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status > 1" v-b-modal.modal-form-forward-details variant="iq-bg-info mr-1" size="sm" @click="forwardDetails(data.item)" class="action-btn active" :title="$t('exportTrophyGazette.forward_comment')"><i class="ri-message-2-line"></i></b-button>
                  </template>
                  <template #custom-foot="">
                    <b-tr>
                      <b-th colspan="10" class="text-right">
                        <button v-b-modal.modal-forward class="btn btn-primary btn-sm mr-1" :title="$t('globalTrans.forward')" @click="forward(selectedItem)" :disabled="selectedItem.length > 0 ? false : true">
                          <i class="ri-share-forward-line"></i> {{ $t('globalTrans.forward') }}
                        </button>
                        <button v-b-modal.modal-approve-return class="btn btn-success btn-sm mr-1" :title="$t('globalTrans.approve')" @click="approveReturn(selectedItem, 3)" :disabled="selectedItem.length > 0 ? false : true">
                          <i class="ri-check-line"></i> {{ $t('globalTrans.approve') }}
                        </button>
                        <button v-b-modal.modal-approve-return class="btn btn-danger btn-sm mr-1" :title="$t('globalTrans.return')" @click="approveReturn(selectedItem, 4)" :disabled="selectedItem.length > 0 ? false : true">
                          <i class="ri-arrow-go-back-fill"></i> {{ $t('globalTrans.return') }}
                        </button>
                      </b-th>
                    </b-tr>
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
      <ForwardComments :item="itemData"/>
    </b-modal>
    <b-modal id="modal-forward" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :item="itemData" :selectedItem="selectedItem"/>
    </b-modal>
    <b-modal id="modal-details" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('exhibitCircularManagement.fair_exhibition_info') + ' ' + $t('globalTrans.details') }}
        <b-button variant="success" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" :item="itemData" :key="detailsItemId"  ref="details"/>
    </b-modal>
    <b-modal id="modal-approve-return" size="md" :title="status === 3 ? $t('globalTrans.approve') : $t('globalTrans.return')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApproveReturn :selectedItem="selectedItem" :status="status"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import Forward from './Forward'
import ForwardComments from './ForwardComments'
import ApproveReturn from './ApproveReturn.vue'
import { exhibitionForwardListApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Forward, ForwardComments, ApproveReturn
  },
  data () {
    return {
      sortBy: '',
      detailsItemId: '',
      selectAll: false,
      selectedItem: [],
      itemData: [],
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
        { labels: 'externalTradeFair.exhibition_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'tradeFairInfoManagement.subject', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 9 },
        { labels: 'exhibitCircularManagement.check', class: 'text-center', show: '1', order: 10 }
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
    selectedItem: function () {
      if (this.selectedItem.length === this.listData.length) {
        this.selectAll = true
      }
      if (this.selectedItem.length < this.listData.length) {
        this.selectAll = false
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
          { key: 'circular_memo' },
          { key: 'exhibit_auto_id' },
          { key: 'subject_bn' },
          { key: 'company_name_bn' },
          { key: 'company_type' },
          { key: 'status' },
          { key: 'action' },
          { key: 'check' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo' },
          { key: 'exhibit_auto_id' },
          { key: 'subject_en' },
          { key: 'company_name_en' },
          { key: 'company_type' },
          { key: 'status' },
          { key: 'action' },
          { key: 'check' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
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
    checkAll () {
      if (this.selectAll) {
        this.selectedItem.splice(0, this.selectedItem.length)
        this.listData.forEach(element => this.selectedItem.push(element.id))
      } else {
        this.selectedItem.splice(0, this.selectedItem.length)
      }
    },
    check () {
      const itemObj = this.listData.find(item => item.is_checked === false)
      if (itemObj === undefined) {
        this.selectAll = true
      } else {
        this.selectAll = false
      }
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    searchData () {
      this.loadData()
    },
    forward (item) {
      this.itemData = item
    },
    forwardDetails (item) {
      this.itemData = item
    },
    approveReturn (selectedItem, status) {
      this.selectedItem = selectedItem
      this.status = status
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, exhibitionForwardListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const customItem = {
            fiscal_year_en: fiscalYearData.text_en,
            fiscal_year_bn: fiscalYearData.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem, { circular_memo: item.exhibit_circular.circular_memo_no, subject_en: item.exhibit_circular.subject_en, subject_bn: item.exhibit_circular.subject_bn }, { company_name_en: item.fair_parti.name_en, company_name_bn: item.fair_parti.name_bn, company_type: item.fair_parti.company_type })
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
    },
    getCompanyTypeName (id) {
      const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
      if (typeof companyType !== 'undefined') {
        return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
      } else {
        return ''
      }
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
