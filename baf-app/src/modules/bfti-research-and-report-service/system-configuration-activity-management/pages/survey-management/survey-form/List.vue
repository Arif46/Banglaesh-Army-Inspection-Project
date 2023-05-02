<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('survey_management.survey_form') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="5" lg="5" xl="5">
            <b-form-group label-for="org_id">
              <template v-slot:label>
                {{ $t('survey_management.survey_name') }}
              </template>
              <b-form-select
                plain
                id="survey_id"
                :options="surveyList"
                v-model="search.survey_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="5" lg="5" xl="5">
            <b-form-group
            label-for="title"
            >
            <template v-slot:label>
              {{ $t('dynamic_form.form_title') }}
            </template>
            <b-form-input
            id="title"
            type="text"
            v-model="search.title"
            ></b-form-input>
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
        <h4 class="card-title">{{ $t('survey_management.survey_form') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link :to="`survey-form-create`">
          <b-button class="btn-add mr-2" title="Add" variant="primary" size="sm"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</b-button>
        </router-link>
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
                  <template v-slot:cell(eio_date)="data">
                    {{ data.item.eio_date| dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status === 0">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 1">{{$t('globalTrans.save')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" v-if="data.item.status === 0" variant=" iq-bg-success mr-1" title="Edit" :to="`/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form-create?id=${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>
                    <b-button class="action-btn btn-success" v-if="data.item.status == 0" @click="remove(data.item)" title="Submit" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" title="View" :to="`/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form-view?id=${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" title="View" :to="`/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form/receive/${data.item.survey_id}`"><i class="ri-folder-received-fill"></i></router-link>
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
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyFormListApi, surveyFormToggleApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        ttle: '',
        survey_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'survey_management.survey_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '25%' } },
        { labels: 'dynamic_form.form_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
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
          { key: 'survey_name_bn' },
          { key: 'form_title_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'survey_name' },
          { key: 'form_title' },
          { key: 'status' },
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
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, surveyFormListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const surveyObj = this.surveyList.find(law => law.value === parseInt(item.survey_id))
          const surveyData = {}
            if (typeof surveyObj !== 'undefined') {
              surveyData.survey_name = surveyObj.text_en
              surveyData.survey_name_bn = surveyObj.text_bn
            } else {
              surveyData.survey_name = ''
              surveyData.survey_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, surveyData)
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
      this.changeStatus(6, bftiResReportServiceBaseUrl, surveyFormToggleApi, item)
    }
  }
}
</script>
