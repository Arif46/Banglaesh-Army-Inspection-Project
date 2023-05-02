<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('survey_management.survey') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="5">
            <b-form-group
              label-for="research_id"
            >
              <template v-slot:label>
                {{$t('bfti.research')}}
              </template>
              <b-form-select
                plain
                v-model="search.research_id"
                :options="researchRequestList"
                id="research_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="5">
            <b-form-group
              label-for="survey_id"
            >
              <template v-slot:label>
                {{$t('survey_management.survey')}}
              </template>
              <b-form-select
                plain
                v-model="search.survey_id"
                :options="surveyList"
                id="survey_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4">
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
        <h4 class="card-title">{{ $t('survey_management.survey') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <!-- <router-link :to="`survey-entry`" :title="$t('bfti.submit_survey')" size="sm">
          <b-button variant="primary">
            {{  $t('bfti.submit_survey') }}
          </b-button>
        </router-link> -->
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
                          :id="'checkbox-' + field.label_en"
                          v-model="field.show"
                          :name="'checkbox-' + field.label_en"
                          value=1
                          unchecked-value=0
                        >
                          {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
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
                    {{ $n(data.index + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(eio_date)="data">
                    {{ data.item.eio_date| dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.draftStatus === 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.draftStatus === 2">{{$t('globalTrans.save')}}</span>
                    <span class="badge badge-info" v-else>{{$t('globalTrans.pending')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <!-- Application View (Details) -->
                    <router-link v-if="data.item.application_id" :to="`/bfti-panel/survey-entry/view?application_id=${data.item.application_id}&survey_id=${data.item.survey_id}&form_id=${data.item.id}`" :title="$t('globalTrans.details')" class="action-btn view"><i class="ri-eye-line"></i></router-link>
                    <router-link v-if="data.item.draftStatus === ''" class="action-btn edit" variant=" iq-bg-success mr-1" title="Edit" :to="`/bfti-panel/survey-entry/add/${data.item.survey_id}`"><i class="ri-survey-line"></i> </router-link>
                    <router-link v-if="data.item.draftStatus === 1" class="action-btn edit" variant=" iq-bg-success mr-1" title="View" :to="`/bfti-panel/survey-entry/edit?application_id=${data.item.application_id}&survey_id=${data.item.survey_id}&form_id=${data.item.id}`"><i class="ri-survey-line"></i></router-link>
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
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details  :item="item" ref="details"/>
    </b-modal>
  </div>
</template>
<style scoped>
  table#table-transition-example .flip-list-move {
    transition: transform 1s;
  }
</style>
<script>
  import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
  import { surveyListApi } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import Details from './Details'

  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Details
    },
    data () {
      return {
        sortBy: '',
        search: {
          survey_id: 0,
          research_id: 0,
          limit: 10,
          type: this.$store.state.Auth.authUser.user_type,
          user_id: this.$store.state.Auth.authUser.user_id
        },
        surveyList: [],
        item: '',
        sortDesc: true,
        sortDirection: 'desc',
        editItem: [],
        editItemId: 0,
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
          { labels: 'survey_management.survey_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '40%' } },
          { labels: 'dynamic_form.form_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '40%' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '40%' } },
          { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
        ]
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
      },
      'search.research_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.surveyList = this.$store.state.ExternalUserService.bftiPanel.commonObj.surveyList.filter(item => item.research_id === newVal)
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
      currentLocale () {
        return this.$i18n.locale
      },
      detailsTitle () {
        return this.$t('policy_advocacy.policy_request') + ' ' + this.$t('globalTrans.details')
      },
      formTitle () {
        return this.$t('policy_advocacy.policy_request')
      },
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
      },
      researchRequestList () {
        return this.$store.state.ExternalUserService.bftiPanel.commonObj.researchRequestList.filter(item => item.status === 2)
      }
    },
    methods: {
      edit (item) {
        this.item = item
      },
      searchData () {
        this.loadData()
      },
      resetId () {
        this.item = ''
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(bftiResReportServiceBaseUrl, surveyListApi, params)
        if (result.success) {
          const allApplication = result.allApplication
          const listData = result.data.data.map((item, index) => {
            const surveyObj = this.$store.state.ExternalUserService.bftiPanel.commonObj.surveyList.find(law => law.value === parseInt(item.survey_id))
            const surveyData = {}
            if (typeof surveyObj !== 'undefined') {
              surveyData.survey_name = surveyObj.text_en
              surveyData.survey_name_bn = surveyObj.text_bn
            } else {
              surveyData.survey_name = ''
              surveyData.survey_name_bn = ''
            }
            const allApplicationObj = allApplication.find(allApplication => allApplication.survey_id === parseInt(item.survey_id))
            const allApplicationFound = {
              application_id: typeof allApplicationObj !== 'undefined' ? allApplicationObj.application_id : 0,
              draftStatus: typeof allApplicationObj !== 'undefined' ? allApplicationObj.save_status : ''
            }
            return Object.assign({}, item, { serial: index }, surveyData, allApplicationFound)
          })
          this.$store.dispatch('setList', listData)
          this.paginationData(result.data, this.search.limit)
        } else {
          this.$store.dispatch('setList', [])
          this.paginationData([])
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      },
      details (item) {
        this.item = item
      }
    }
  }
</script>
