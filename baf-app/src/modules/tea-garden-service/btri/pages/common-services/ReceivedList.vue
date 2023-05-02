<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenBtriService.received_application') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="year"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.service_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.service_id"
                :options="serviceList"
                id="year"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title"> {{ $t('teaGardenBtriService.received_application') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
              <b-col sm="12">
                <div class="quick-filter-wrapper">
                  <div class="quick-filter-left">
                    <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
                      <b-dropdown-form>
                        <div
                          class="form-group"
                          v-for="(field, index) in labelData"
                          :key="index"
                          >
                            <b-form-checkbox
                              :id="'checkbox-' + field.labels"
                              v-model="field.show"
                              :name="'checkbox-' + field.labels"
                              value=1
                              unchecked-value=0
                            >
                              {{ $t(field.labels)  }}
                            </b-form-checkbox>
                        </div>
                      </b-dropdown-form>
                    </b-dropdown>
                  </div>
                  <div class="quick-filter-right">
                    <b-form-group
                      :label="$t('menu.perpage')"
                      label-for="per-page-select"
                    >
                      <b-form-select
                        id="per-page-select"
                        v-model="search.limit"
                        :options="pageOptions"
                        size="sm"
                      ></b-form-select>
                    </b-form-group>
                  </div>
                </div>
              </b-col>
          </b-row>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.application_date | dateFormat }}
                  </template>
                  <template v-slot:cell(total_samples)="data">
                    {{ $n(data.item.total_samples) }}
                  </template>
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ getName(data.item.fiscal_year_id, 'fiscal_year') }}
                  </template>
                  <template v-slot:cell(garden_id)="data">
                    {{ getName(data.item.garden_id, 'garden') }}
                  </template>
                  <template v-slot:cell(service_id)="data">
                    {{ $i18n.locale === 'bn' ? data.item.service.service_name_bn : data.item.service.service_name_en }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.view')" :to="{ name: 'tea_garden_service.btri.test_services_view', params: { id: data.item.id }}">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <b-button v-b-modal.modal-6 class="moc-action-btn moc-payment-receipt-btn" :title="$t('externalLrcpn.payment_receipt')" @click="returnApplication(data.item)" v-if="(data.item.status >= 2) && (data.item.payment)">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <b-button :title="$t('globalTrans.forward')" v-b-modal.modal-5 class="moc-action-btn moc-forward-btn" @click="forwarded(data.item)">
                      <i class="ri-arrow-go-forward-fill"></i>
                    </b-button>
                    <b-button v-b-modal.modal-4 class="moc-action-btn moc-return-btn" :title="$t('globalTrans.return')" @click="returnApplication(data.item)" v-if="!isGardenAdminCheckGardenId() && (data.item.status > 1 && data.item.status < 5)">
                      <i class="ri-reply-all-fill"></i>
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
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :id="forwardedItemId" :service_id="service_id"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="$t('globalTrans.return')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Return :id="item.id" :item="item"/>
    </b-modal>
    <b-modal id="modal-6" size="lg" :title="$t('externalLrcpn.payment_receipt')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <template #modal-title class="flex-grow-1">
        {{ $t('externalLrcpn.payment_receipt') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <PaymentInfo :id="item.id" :item="item" ref="paymentInfo"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { assignedList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import teaGardenService from '@/mixins/tea-garden-service'
import Forward from './Forward'
import Return from './Return'
import PaymentInfo from './PaymentInfo'

export default {
  mixins: [ModalBaseMasterList, teaGardenService],
  components: {
    Forward, Return, PaymentInfo
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      search: {
        year: 0,
        service_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'teaGardenService.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'teaGardenConfig.garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'teaGardenBtriService.no_of_sample', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      },
      forwardedItemId: '',
      service_id: '',
      item: {
        id: 0
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
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    serviceList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => JSON.parse(item.service_type).includes(2))
    }
  },
  methods: {
    forwarded (item) {
      this.forwardedItemId = item.id
      this.service_id = item.service_id
    },
    returnApplication (item) {
      this.item = item
    },
    getName (id, type) {
      let obj = {}
      if (type === 'fiscal_year') {
        obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      } else if (type === 'garden') {
        obj = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === parseInt(id))
      }
      return this.$i18n.locale === 'bn' ? obj?.text_bn : obj?.text_en
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, assignedList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
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
    pdfExport () {
      this.$refs.paymentInfo.pdfExport()
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
