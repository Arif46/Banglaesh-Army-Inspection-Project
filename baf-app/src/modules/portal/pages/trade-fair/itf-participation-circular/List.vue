<template>
    <div class="service-details-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title" style="font-size: 25px">{{ Object.keys($route.params).length > 0 ? checkServiceName() : $t('portal.circular') + ' ' + $t('globalTrans.list') }}</h2>
            <img src="@/assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{ $t('portal.all_service') }}</router-link></li>
                    <li @click="$router.go(-1)" class="breadcrumb-item"><router-link to="" target="_self">{{ $t('portal.service_details') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.circular') }}</span></li>
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
                  <b-col sm="4">
                    <b-form-group
                      label-for="fiscal_year_id"
                    >
                    <template v-slot:label>
                      {{$t('globalTrans.fiscal_year')}}
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
                  <b-col sm="4">
                    <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
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
                      <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                        <template v-slot:cell(serial)="data">
                          {{ $n(data.item.serial + pagination.slOffset) }}
                        </template>
                        <template v-slot:cell(fiscal_year_id)="data">
                          <span>{{ getFiscalYear(data.item.fiscal_year_id) }}</span>
                        </template>
                        <template v-slot:cell(deadline)="data">
                          <span>{{ data.item.deadline | dateFormat }}</span>
                        </template>
                        <template v-slot:cell(action)="data">
                          <b-button class="mb-1" :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                          <b-button class="mb-1 btn btn-success ml-1" v-b-modal.modal-final size="sm" @click="final(data.item)" :title="$t('portal.calendar')">{{ $t('portal.calendar') }}</b-button>
                          <b-button class="mb-1 btn btn-info btn-sm ml-1" v-if="data.item.deadline >= current_date" type="button" @click="setServiceUrl(data.item)" :title="$t('globalTrans.apply')">{{ $t('globalTrans.apply') }}</b-button>
                        </template>
                      </b-table>
                      <div class="pagination-wrapper mt-3">
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
        <b-modal id="modal-4" size="lg" :title="$t('externalTradeFair.circular_fair_participation') + ' ' + $t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
          <template #modal-title class="flex-grow-1">
            {{ $t('externalTradeFair.circular_fair_participation') + ' ' + $t('globalTrans.details') }}
            <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
              {{  $t('globalTrans.export_pdf') }}
            </b-button>
          </template>
          <Details :id="detailsItemId" :item="item" :dropdown="dropdown" :key="detailsItemId" ref="details"/>
        </b-modal>
        <b-modal id="modal-final" size="lg" :title="$t('portal.calendar')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
          <Final :items="itemData" :dropdown="dropdown"/>
        </b-modal>
    </div>
</template>
<script>
import Details from './Details.vue'
import Final from './Final'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const today = new Date().toISOString().substr(0, 10)
const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.fiscal_year, label_bn: i18n.messages.bn.globalTrans.fiscal_year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.circular_memo_no, label_bn: i18n.messages.bn.tradeFairInfoManagement.circular_memo_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.subject, label_bn: i18n.messages.bn.tradeFairInfoManagement.subject, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.submission_deadline, label_bn: i18n.messages.bn.tradeFairInfoManagement.submission_deadline, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 6, thStyle: { width: '20%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      current_date: today,
      sortBy: '',
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      dropdown: [],
      item: '',
      detailsItemId: '',
      itemData: '',
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      editItemId: '',
      service_name: ''
    }
  },
  components: {
    Details, Final
  },
  created () {
    window.scrollTo(0, 0)
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
          { key: 'circular_memo_no' },
          { key: 'subject_bn' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_id' },
          { key: 'circular_memo_no' },
          { key: 'subject_en' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    detailsTitle () {
      return this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.details')
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
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, '/portal/itf-participation-circular-list', params)
      if (result.success) {
        this.dropdown = result.dropdown
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
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    final (item) {
      this.itemData = item
    },
    setServiceUrl (item) {
      this.$store.dispatch('Portal/setServiceUrl', {
        externalPanelServiceUrl: '/trade-fair-panel/fair-participation-form?circular_id=' + item.id,
        externalPanelCurrentServiceUrl: '/trade-fair-panel/fair-participation-form?circular_id=' + item.id
      })
      this.$router.push('/auth/login').catch(() => {})
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style>
  .apply_btn{
    font-size: 13px;
    padding: 3px 5px;
  }
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
