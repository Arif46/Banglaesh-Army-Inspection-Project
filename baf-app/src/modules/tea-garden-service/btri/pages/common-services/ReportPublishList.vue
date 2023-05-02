<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenBtriService.report_publish_application') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title"> {{ $t('teaGardenBtriService.report_publish_application') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(status)="data">
                      <span :class="'badge badge-'+ getStatusInfo(data.item, 2)">{{ getStatusInfo(data.item) }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.view')" :to="{ name: 'tea_garden_service.btri.test_services_view', params: { id: data.item.id }}">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <b-button class="moc-action-btn moc-payment-receipt-btn" v-b-modal.modal-6 :title="$t('externalLrcpn.payment_receipt')" @click="returnApplication(data.item)" v-if="(data.item.status >= 2) && (data.item.payment)">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <b-button class="moc-action-btn moc-publish-btn" v-b-modal.modal-8 title="Publish" @click="publishReport(data.item)" v-if="data.item.status == 7">
                      <i class="ri-compass-discover-line"></i>
                    </b-button>
                    <a class="moc-action-btn moc-download-btn" :title="$t('globalTrans.download')" :href="teaGardenServiceBaseUrl + 'download-storage-attachment?file=app/public' + data.item.report.attachment.replace('storage', '')" v-if="data.item.report" download>
                      <i class="ri-download-cloud-line"></i>
                    </a>
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
      <b-modal id="modal-8" size="lg" :title="$t('globalTrans.publish')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
        <Approve :id="item.id"  :item="item"/>
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
    </body-card>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { reportPublishList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import teaGardenService from '@/mixins/tea-garden-service'
import Approve from './Approve'
import PaymentInfo from './PaymentInfo'

export default {
  mixins: [ModalBaseMasterList, teaGardenService],
  components: { Approve, PaymentInfo },
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
        { labels: 'teaGardenBtriService.registration_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'teaGardenService.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'teaGardenConfig.garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'teaGardenBtriService.no_of_sample', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8 },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      },
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
          { key: 'registration_no' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'app_id' },
          { key: 'registration_no' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'status' },
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
    publishReport (item) {
      // window.vm.$swal({
      //   title: window.vm.$t('teaGardenBtriService.publish_confirm_msg'),
      //   showCancelButton: true,
      //   confirmButtonText: window.vm.$t('globalTrans.yes'),
      //   cancelButtonText: window.vm.$t('globalTrans.no'),
      //   focusConfirm: false
      // }).then((result) => {
      //   if (result.isConfirmed) {
      //     this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      //     RestApi.deleteData(teaGardenServiceBaseUrl, `${reportPublish}/${item.id}`).then(response => {
      //       if (response.success) {
      //         window.vm.$toast.success({
      //           title: window.vm.$t('globalTrans.success'),
      //           message: window.vm.$t('globalTrans.update_msg'),
      //           color: '#D6E09B'
      //         })
      //       } else {
      //         window.vm.$toast.error({
      //           title: 'Error',
      //           message: 'Operation failed! Please, try again.'
      //         })
      //       }
      //       this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
      //     })
      //   }
      // })
      this.item = item
    },
    returnApplication (item) {
      this.item = item
    },
    getStatusInfo (item, type = 1) {
      let statusText = this.$t('globalTrans.draft')
      let statusClass = 'warning'
      if (item.status === 2) {
        statusText = this.$t('globalTrans.pending')
        statusClass = 'light'
      } else if (item.status === 3) {
        statusText = this.$t('teaGardenBtriService.assigned')
        statusClass = 'secondary'
      } else if (item.status === 4) {
        statusText = this.$t('globalTrans.forward')
        statusClass = 'dark'
      } else if (item.status === 5) {
        statusText = this.$t('globalTrans.returned')
        statusClass = 'danger'
      } else if (item.status === 6) {
        statusText = this.$t('teaGardenBtriService.sample_verified')
        statusClass = 'primary'
      } else if (item.status === 7) {
        statusText = this.$t('teaGardenBtriService.report_prepared')
        statusClass = 'info'
      } else if (item.status === 8) {
        statusText = this.$t('globalTrans.published')
        statusClass = 'success'
      }
      return type === 2 ? statusClass : statusText
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
      const result = await RestApi.getData(teaGardenServiceBaseUrl, reportPublishList, params)
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
 .blinking {
    animation: 1s blink ease infinite;
  }
  @keyframes blink {
    from,
    to {
      opacity: 0;
    }
    50% {
      opacity: 1;
    }
  }
</style>
