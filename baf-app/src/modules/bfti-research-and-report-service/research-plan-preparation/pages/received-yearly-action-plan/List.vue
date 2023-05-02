<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('globalTrans.received') }} {{ $t('research_plan_management.yearly_action_plan') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Title" vid="title" rules="''" v-slot="{ errors }">
              <b-form-group label-for="title">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }}
                </template>
                <b-form-input
                  id="title"
                  v-model="search.title"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Start date" vid="from_date" rules="''" v-slot="{ errors }">
              <b-form-group label-for="from_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_from') }}
                </template>
                <date-picker
                  id="from_date"
                  v-model="search.from_date"
                  class="form-control"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="End date" vid="to_date" rules="''" v-slot="{ errors }">
              <b-form-group label-for="to_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_to') }}
                </template>
                <date-picker
                  id="to_date"
                  class="form-control"
                  v-model="search.to_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="4" >
            <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('globalTrans.received') }} {{ $t('research_plan_management.yearly_action_plan') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(budget)="data">
                    {{ $n(data.item.budget) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status == 2">{{$t('globalTrans.finalSave')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status == 3">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 4">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.rejected')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button  title="recommended" v-b-modal.modal-5 variant="iq-bg-info" class="action-btn btn-info" size="sm" @click="recommended(data.item)"><i class="ri-share-forward-line"></i></b-button>
                    <b-button title="Approve" v-b-modal.modal-6 variant="iq-bg-info" class="action-btn btn-success" size="sm" @click="approve(data.item)"><i class="ri-check-line"></i></b-button>
                    <b-button  title="Reject" v-b-modal.modal-4 variant=" iq-bg-success border-info" class="action-btn btn-danger" size="sm" @click="reject(data.item)"><i class="ri-indeterminate-circle-line"></i></b-button>
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
    <b-modal id="modal-details" size="lg" :title="$t('research_plan_management.yearly_action_plan') + ' ' + $t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="$t('globalTrans.reject')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Reject :id="rejectItemId" :item="item"/>
    </b-modal>
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :id="recommendedItemId" />
    </b-modal>
    <b-modal id="modal-6" size="lg" :title="$t('globalTrans.approve')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Approve :id="approveItemId"  :item="item"/>
    </b-modal>
  </div>
</template>
<script>
  import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
  import { yearlyActionPlanForwardedList, yearlyActionPlanChangeStatus } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import Details from '../yearly-action-plan/Details'
  import Forward from '../yearly-action-plan/Forward'
  import Approve from '../yearly-action-plan/Approve'
  import Reject from '../yearly-action-plan/Reject'

  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Details, Forward, Approve, Reject
    },
    data () {
      return {
        bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        search: {
          from_date: '',
          to_date: '',
          title: '',
          limit: 10
        },
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
          { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
          { labels: 'research_plan_management.client', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
          { labels: 'research_plan_management.budget_amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
          { labels: 'research_plan_management.duration', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
          { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '10%' } }
        ],
        actions: {
          edit: true,
          details: false,
          toogle: true,
          delete: false
        },
        item: {},
        rejectItemId: '',
        recommendedItemId: '',
        approveItemId: ''
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
            { key: 'title_bn' },
            { key: 'client_bn' },
            { key: 'budget' },
            { key: 'duration_bn' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'title_en' },
            { key: 'client_en' },
            { key: 'budget' },
            { key: 'duration_en' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      editMethodInParent (item, type) {
        if (type === 1) {
          this.edit(item)
        } else if (type === 2) {
          this.changeStatus(bftiResReportServiceBaseUrl, yearlyActionPlanChangeStatus, item)
        }
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(bftiResReportServiceBaseUrl, yearlyActionPlanForwardedList, params)
        if (result.success) {
          const listData = result.data.data.map((item, index) => {
            return Object.assign({}, item, { serial: index + 0 })
          })
          this.$store.dispatch('setList', listData)
          this.paginationData(result.data, this.search.limit)
        } else {
          this.$store.dispatch('setList', [])
          this.paginationData([])
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      },
      remove (item) {
        this.changeStatus(3, bftiResReportServiceBaseUrl, yearlyActionPlanChangeStatus, item)
      },
      recommended (item) {
        this.recommendedItemId = item.id
      },
      reject (item) {
        this.rejectItemId = item.id
        this.item = item
      },
      approve (item) {
        this.approveItemId = item.id
        this.item = item
      }
    }
  }
</script>

<style>
  .btn-success {
    background-color: var(--success) !important;
    border-color: var(--success);
  }
</style>
