<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col sm="4">
            <b-form-group
              label-for="org_id"
            >
              <template v-slot:label>
                 {{ $t('configuration.search') }} {{ $t('survey_management.research_topic') }}
              </template>
              <b-form-select
                plain
                id="org_id"
                :options="researchRequestList"
                v-model="search.research_req_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
            label-for="title"
            >
            <template v-slot:label>
              {{ $t('survey_management.title') }}
            </template>
            <b-form-input
            id="title"
            type="text"
            v-model="search.title"
            ></b-form-input>
            </b-form-group>
          </b-col>
           <b-col xs="12" sm="12" md="3">
            <ValidationProvider name="Start date" vid="start_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                {{ $t('globalTrans.start_date') }}
                </template>
                <date-picker
                 id="start_date"
                  class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                 v-model="search.start_date"
                 :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3">
            <ValidationProvider name="End date" vid="end_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}
                </template>
                <date-picker
                 id="end_date"
                  class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                  v-model="search.end_date"
                 :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
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
        <h4 class="card-title">{{ $t('survey_management.survey_information') + ' ' + $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="$t('survey_management.survey_information') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :id="detailItemId" :key="detailItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyInfoListApi, surveyInfoToggleApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        research_req_id: '',
        title: '',
        start_date: '',
        end_date: '',
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'survey_management.research_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'survey_management.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'survey_management.start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'survey_management.end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8 }
      ],
      actions: {
        edit: true,
        details: true,
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
          { key: 'topic_bn' },
          { key: 'title_bn' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'topic' },
          { key: 'title' },
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
    formTitle () {
      return (this.editItemId === 0) ? this.$t('survey_management.survey_information') + ' ' + this.$t('globalTrans.entry') : this.$t('survey_management.survey_information') + ' ' + this.$t('globalTrans.modify')
    },
    researchRequestList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.researchRequestList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(6, bftiResReportServiceBaseUrl, surveyInfoToggleApi, item)
      } else if (type === 3) {
        this.details(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, surveyInfoListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const topicObj = this.$store.state.BftiResearchAndReportService.commonObj.researchRequestList.find(law => law.value === parseInt(item.research_req_id))
          const topicData = {}
          if (typeof topicObj !== 'undefined') {
                topicData.topic = topicObj.text_en
                topicData.topic_bn = topicObj.text_bn
            } else {
              topicData.topic = ''
              topicData.topic_bn = ''
            }
          return Object.assign({}, item, { serial: index }, topicData)
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
