<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('policyAdvocacy.workshop_list') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="fiscal_year"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }}
                </template>
                <b-form-select
                  plain
                  id="fiscal_year"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
            <b-button size="sm" type="submit" variant="primary" class="mt-20">
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
        <h4 class="card-title">{{ $t('policyAdvocacy.workshop_list') }}</h4>
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
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.application?.application_date | dateFormat }}
                  </template>
                  <template v-slot:cell(application_id)="data">
                    {{ data.item.application?.application_id }}
                  </template>
                  <template v-slot:cell(association_name)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.feedback == null" >{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-success" v-if="data.item.feedback != null">{{$t('policyAdvocacy.end')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button v-b-modal.modal-feedback-view variant=" iq-bg-success mr-1" size="sm" @click="feedback(data.item)" class="action-btn edit" :title="$t('globalTrans.feedback')"><i class="ri-eye-fill"></i>
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
    <b-modal id="modal-feedback-view" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <FeedbackDetails :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import FeedbackDetails from './FeedbackDetails.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { policyAdvocacyFeedbackList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    FeedbackDetails
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        fiscal_year_id: 0,
        from_date: '',
        to_date: '',
        association_info_id: 0,
        council_info_id: 0,
        limit: 10
      },
      application_id: 0,
      workshop_id: 0,
      items: [],
      profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile,
      associationInfoList: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'eBizConfig.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'policyAdvocacy.workshop_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 6, thStyle: { width: '5%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '5%' } }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
     'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
       const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === newVal)
       this.search.from_date = fiscalYear.start_date
       this.search.to_date = fiscalYear.end_date
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
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
          { key: 'application_date' },
          { key: 'application_id' },
          { key: 'association_name' },
          { key: 'workshop_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'application_date' },
          { key: 'application_id' },
          { key: 'association_name' },
          { key: 'workshop_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return this.$t('policyAdvocacy.feedback_and_recommendation') + ' ' + this.$t('globalTrans.entry')
    },
    viewTitle () {
      return this.$t('policyAdvocacy.workshop') + ' ' + this.$t('globalTrans.details')
    }
  },
  methods: {
    feedback (item) {
      this.items = item
    },
      editMethodInParent (item, type) {
          if (type === 1) {
            this.edit(item)
          }
      },
      details (item) {
        this.items = item
      },
      getCouncilName (councilNameId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.search.council_info_id = this.profile.council_info_id
      this.search.association_info_id = this.profile.association_info_id
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, policyAdvocacyFeedbackList, params)
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
    }
  }
}
</script>
