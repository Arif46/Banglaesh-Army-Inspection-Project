<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('survey_management.survey_receive') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.index + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(created_at)="data">
                    {{ data.item.created_at| dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status === 0">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 1">{{$t('globalTrans.save')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link v-if="data.item.application_id" :to="`/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form/view?application_id=${data.item.application_id}&survey_id=${data.item.survey_id}&form_id=${form_id}`" :title="$t('globalTrans.details')" class="action-btn view"><i class="ri-eye-line"></i></router-link>
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
      <!-- search section end -->
    </card>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyFormReceiveListApi, surveyFormToggleApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      form_id: 0,
      search: {
        ttle: '',
        survey_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'globalTrans.name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
      ],
      actions: {
        edit: true,
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
          { key: 'application_id' },
          { key: 'name_bn' },
          { key: 'created_at' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'application_id' },
          { key: 'name' },
          { key: 'created_at' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    surveyList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.surveyList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      const itemId = item.id
      if (type === 1) {
        this.$router.push({ path: '/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form-create', query: { id: itemId } })
      } else if (type === 3) {
        this.$router.push({ path: '/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form-view', query: { id: itemId } })
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.search.survey_id = this.$route.params.id
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, surveyFormReceiveListApi, params)
      if (result.success) {
        this.form_id = result.form_id
        this.$store.dispatch('setList', result.data.data)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    remove (item) {
      this.changeStatus(6, bftiResReportServiceBaseUrl, surveyFormToggleApi, item)
    }
  }
}
</script>
