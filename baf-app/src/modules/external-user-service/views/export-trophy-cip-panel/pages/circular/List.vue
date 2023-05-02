<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="3">
            <b-form-group
              label-for="fiscal_year_id"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.fiscal_year')}}
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
          <b-col sm="3">
            <b-form-group
              label-for="year"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.year')}}
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
          <b-col sm="3">
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
              label-for="title"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.title')}}
            </template>
              <b-form-input
                plain
                v-model="search.title"
                id="title_en"
              >
              </b-form-input>
            </b-form-group>
          </b-col>
          <b-col sm="3">
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
                  <template v-slot:cell(year)="data">
                    <span>{{ EngBangNum(data.item.year.toString()) }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="parseInt(data.item.app_start_date) <= parseInt(currentDate) && parseInt(data.item.deadline) >= parseInt(currentDate)" v-b-modal.modal-form @click="apply(data.item)" size="sm" class="action-btn status" :title="$t('globalTrans.apply')"><i class="ri-add-fill"></i></b-button>
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
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApplicationType :id="editItemId" :item="item" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import ApplicationType from './ApplicationType.vue'
import Details from './Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { circularListApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.fiscal_year, label_bn: i18n.messages.bn.exportTrophyCircular.fiscal_year, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.year, label_bn: i18n.messages.bn.exportTrophyCircular.year, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.memo_no, label_bn: i18n.messages.bn.exportTrophyCircular.memo_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.exportTrophyCircular.title, label_bn: i18n.messages.bn.exportTrophyCircular.title, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 6 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, ApplicationType
  },
  data () {
    return {
      sortBy: '',
      currentDate: '',
      search: {
        fiscal_year_id: 0,
        year: 0,
        memo_no: '',
        title: '',
        limit: 20
      },
      item: '',
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      editItemId: 0
    }
  },
  created () {
    // Milliseconds since 1970/01/01 to current date
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
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
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
          { key: 'fiscal_year_bn' },
          { key: 'year' },
          { key: 'memo_no' },
          { key: 'title_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
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
    detailsTitle () {
      return this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.details')
    },
    formTitle () {
      return this.$t('externalUser.choose_application')
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
    apply (item) {
      this.item = item
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
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, circularListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
            const tmpFiscal = this.$store.state.CommonService.commonObj.fiscalYearList.find(el => el.value === item.fiscal_year_id)
            const tmpObj = {
                serial: index,
                fiscal_year_en: tmpFiscal !== 'undefined' ? tmpFiscal.text_en : '',
                fiscal_year_bn: tmpFiscal !== 'undefined' ? tmpFiscal.text_bn : ''
            }
            return Object.assign({}, item, tmpObj)
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
      this.editItemId = item.id
    }
  }
}
</script>
