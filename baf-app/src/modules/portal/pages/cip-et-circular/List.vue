<template>
    <div class="service-details-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ Object.keys($route.params).length > 0 ? checkServiceName() : $t('portal.circular') + ' ' + $t('globalTrans.list') }}</h2>
            <img src="../../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{ $t('portal.all_service') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.service_details') }}</span></li>
                </ol>
            </b-container>
        </div>
        <div class="service-description">
          <b-container>
            <body-card>
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.search') }}</h4>
              </template>
              <template v-slot:body>
                <b-row>
                  <b-col sm="3">
                    <b-form-group
                      label-for="fiscal_year_id"
                    >
                    <template v-slot:label>
                      {{$t('externalUser.et')}} {{$t('globalTrans.fiscal_year')}}
                    </template>
                      <b-form-select
                        plain
                        v-model="search.fiscal_year_id"
                        :options="fiscalYear"
                        id="fiscal_year_id"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                      </b-form-select>
                    </b-form-group>
                  </b-col>
                  <b-col sm="2">
                    <b-form-group
                      label-for="year"
                    >
                    <template v-slot:label>
                      {{$t('externalUser.cip')}} {{$t('globalTrans.year')}}
                    </template>
                      <b-form-select
                        plain
                        v-model="search.year"
                        :options="YearList"
                        id="year"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                      </b-form-select>
                    </b-form-group>
                  </b-col>
                  <b-col sm="2">
                    <b-form-group
                      label-for="memo_no"
                    >
                    <template v-slot:label>
                      {{$t('exportTrophyCircular.memo_no')}}
                    </template>
                      <b-form-input
                        plain
                        v-model="search.memo_no"
                        id="memo_no"
                      >
                      </b-form-input>
                    </b-form-group>
                  </b-col>
                  <b-col sm="3">
                    <b-form-group
                      label-for="title_en"
                    >
                    <template v-slot:label>
                      {{$t('exportTrophyCircular.title')}}
                    </template>
                      <b-form-input
                        plain
                        v-model="search.title_en"
                        id="title_en"
                      >
                      </b-form-input>
                    </b-form-group>
                  </b-col>
                  <b-col sm="2" style="margin-top:18px;">
                    <b-button size="sm" variant="primary" @click="searchData">
                      <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                    </b-button>
                  </b-col>
                </b-row>
              </template>
              <!-- search section end -->
            </body-card>

            <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.list') }}</h4>
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
                            {{ $n(data.item.serial + pagination.slOffset) }}
                          </template>
                          <template v-slot:cell(fiscal_year_id)="data">
                            <span>{{ EngBangNum(getFiscalYear(data.item.fiscal_year_id)) }}</span>
                          </template>
                          <template v-slot:cell(year)="data">
                            <span>{{ EngBangNum(data.item.year.toString()) }}</span>
                          </template>
                          <template v-slot:cell(action)="data">
                            <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-1" size="sm" class="btn btn-primary apply_btn" @click="details(data.item)" :title="$t('globalTrans.view')">{{ $t('globalTrans.view') }}</b-button><br/>
                            <slot v-if="parseInt(data.item.app_start_date) <= parseInt(currentDate) && parseInt(data.item.deadline) >= parseInt(currentDate)">
                              <b-button class="btn btn-success apply_btn" variant="iq-bg-success mr-1 my-1" size="sm" @click="setServiceUrl(data.item.id, 1)" :title="$t('portal.cip_application')">{{ $t('portal.cip_application') }}</b-button><br/>
                              <b-button class="btn btn-success apply_btn" variant="iq-bg-success " size="sm" @click="setServiceUrl(data.item.id, 2)" :title="$t('portal.et_application')">{{ $t('portal.et_application') }}</b-button>
                            </slot>
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
          </b-container>
        </div>
      <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Details :id="editItemId" :key="editItemId" :userDetails="userDetails"/>
      </b-modal>
    </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.fiscal_year, label_bn: i18n.messages.bn.exportTrophyCircular.fiscal_year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '14%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.year, label_bn: i18n.messages.bn.exportTrophyCircular.year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.memo_no, label_bn: i18n.messages.bn.exportTrophyCircular.memo_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.title, label_bn: i18n.messages.bn.exportTrophyCircular.title, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 7, thStyle: { width: '15%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      currentDate: '',
      sortBy: '',
      search: {
        fiscal_year_id: 0,
        year: 0,
        memo_no: '',
        title_en: '',
        limit: 20
      },
      userDetails: [],
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      editItemId: '',
      service_name: ''
    }
  },
  components: {
    Details
  },
  created () {
    window.scrollTo(0, 0)
    this.currentDate = Math.round(new Date().getTime() / (1000 * 60 * 60 * 24)) * (1000 * 60 * 60 * 24)
    this.labelData = this.labelList
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
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYear () {
      return this.$store.state.Portal.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_id' },
          { key: 'year' },
          { key: 'memo_no' },
          { key: 'title_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_id' },
          { key: 'year' },
          { key: 'memo_no' },
          { key: 'title_en' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.entry') : this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.modify')
    },
    detailsTitle () {
      return this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.details')
    },
    forwardTitle () {
      return this.$t('globalTrans.forward')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    YearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    }
  },
  methods: {
    checkServiceName () {
      return this.currentLocale === 'bn' ? this.$route.params.name_bn : this.$route.params.name
    },
    forward (item) {
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, '/portal/et-cip/circular-list', params)
      if (result.success) {
        this.userList = result.userDetails
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index }, { app_start: item.app_start }, { deadline_date: item.deadline_date })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    details (item) {
      this.editItemId = item.id
      this.userDetails = this.userList
    },
    getNameReceiver (id) {
      if (this.userList) {
        const userName = this.userList.find(user => user.value === id)
        if (this.$i18n.locale === 'bn') {
          return userName.text_bn
        } else {
          return userName.text_en
        }
      }
    },
    setServiceUrl (circularId, type) {
      if (type === 1) {
        this.$store.dispatch('Portal/setServiceUrl', {
          externalPanelServiceUrl: '/export-trophy-cip-panel/cip-application-form?circular_id=' + circularId,
          externalPanelCurrentServiceUrl: '/export-trophy-cip-panel/cip-application-form?circular_id=' + circularId
        })
      } else if (type === 2) {
        this.$store.dispatch('Portal/setServiceUrl', {
          externalPanelServiceUrl: '/export-trophy-cip-panel/export-trophy-application-form?circular_id=' + circularId,
          externalPanelCurrentServiceUrl: '/export-trophy-cip-panel/export-trophy-application-form?circular_id=' + circularId
        })
      }
      this.$router.push('/auth/login').catch(() => {})
    }
  }
}
</script>
<style scoped>
  .apply_btn{
    font-size: 13px;
    padding: 3px 5px;
  }
</style>
