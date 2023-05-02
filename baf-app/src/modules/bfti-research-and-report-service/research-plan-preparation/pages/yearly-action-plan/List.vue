<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('research_plan_management.yearly_action_plan') }} {{ $t('globalTrans.search') }}</h4>
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
                  v-model="search.to_date"
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
        <h4 class="card-title">{{ $t('research_plan_management.yearly_action_plan') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                    <!--                    <router-link class="action-btn edit" variant=" iq-bg-success mr-1" title="Edit" :to="`/bfti-research-and-report-service/research-plan-preparation/prepare-eio-from/${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>-->
                    <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" v-if="data.item.status == 1" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-ball-pen-fill"></i></b-button>
                    <b-button class="action-btn btn-success" v-if="data.item.status == 1" @click="remove(data.item)" title="Submit" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
                    <b-button v-b-modal.modal-details variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button  title="recommended" v-if="data.item.status === 2" v-b-modal.modal-5 variant="iq-bg-info" class="action-btn btn-info" size="sm" @click="recommended(data.item)"><i class="ri-share-forward-line"></i></b-button>
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
    <b-modal id="modal-details" size="lg" :title="$t('research_plan_management.yearly_action_plan') + ' ' + $t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" :ok-disabled="true">
      <Details :id="editItemId" :key="editItemId" hide-footer/>
    </b-modal>
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :id="recommendedItemId" hide-footer/>
    </b-modal>
  </div>
</template>
<script>
  import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
  import { yearlyActionPlanList, yearlyActionPlanChangeStatus } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import Form from './Form'
  import Details from './Details'
  import Forward from './Forward'

  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Form, Details, Forward
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
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
          { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '10%' } }
        ],
        actions: {
          edit: true,
          details: false,
          toogle: true,
          delete: false
        },
        recommendedItemId: ''
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
            { key: 'status' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'title_en' },
            { key: 'client_en' },
            { key: 'budget' },
            { key: 'duration_en' },
            { key: 'status' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      formTitle () {
        return (this.editItemId === 0) ? this.$t('research_plan_management.yearly_action_plan') + ' ' + this.$t('globalTrans.entry') : this.$t('research_plan_management.yearly_action_plan') + ' ' + this.$t('globalTrans.modify')
      },
      rfpTypeList () {
        return [
          {
            value: 1,
            text_en: 'EOI',
            text_bn: 'ইওআই',
            text: this.currentLocale === 'bn' ? 'ইওআই' : 'EOI'
          },
          {
            value: 2,
            text_en: 'Without EOI',
            text_bn: 'ইওআই ছাড়া',
            text: this.currentLocale === 'bn' ? 'ইওআই ছাড়া' : 'Without EOI'
          }
        ]
      },
      currentLocale () {
        return this.$i18n.locale
      },
      eoiList () {
        return this.$store.state.BftiResearchAndReportService.commonObj.eoiList
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
        const result = await RestApi.getData(bftiResReportServiceBaseUrl, yearlyActionPlanList, params)
        if (result.success) {
          const listData = result.data.data.map((item, index) => {
            const rfpType = this.rfpTypeList.find(obj => obj.value === item.rfp_type)
            const eoi = this.eoiList.find(obj => obj.value === parseInt(item.prepare_eoi_id))
            const customItem = {
              rfp_type_en: rfpType?.text_en,
              rfp_type_bn: rfpType?.text_bn,
              eoi_title_en: eoi?.text_en,
              eoi_title_bn: eoi?.text_bn
            }
            return Object.assign({}, item, { serial: index + 0 }, customItem)
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
