<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eventManage.event_date') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Year" vid="date" rules="required|min_value:1">
              <b-form-group
                  label-for="year"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('globalTrans.year')}}
                  </template>
                  <b-form-select
                  plain
                  v-model="search.date"
                  :options="yearList"
                  id="date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="3">
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
        <h4 class="card-title">{{ $t('eventManage.event_date') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                  <template v-slot:cell(date)="data">
                    {{ EngBangNum(data.item.date) }}
                  </template>
                  <template v-slot:cell(start_time)="data">
                    {{ EngBangNum(data.item.start_time) }}
                  </template>
                  <template v-slot:cell(end_time)="data">
                    {{ EngBangNum(data.item.end_time) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary">{{ getCurrentTimeWiseStatus(data.item) }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-1" size="sm" @click="detailsData(data.item)" class="action-btn status" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
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
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="detailsItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<script>
import Form from '../events-date/Form.vue'
import Details from '../events-date/Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { eventDateEntryList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import moment from 'moment'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.eventManage.event_title, label_bn: i18n.messages.bn.eventManage.event_title, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.eventManage.venue, label_bn: i18n.messages.bn.eventManage.venue, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.date, label_bn: i18n.messages.bn.globalTrans.date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.eventManage.start_time, label_bn: i18n.messages.bn.eventManage.start_time, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.eventManage.end_time, label_bn: i18n.messages.bn.eventManage.end_time, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      sortBy: '',
      search: {
        date: 0,
        limit: 20
      },
      details: [],
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      editItemId: '',
      detailsItemId: '',
      item: ''
    }
  },
  created () {
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
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
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
          { key: 'title_bn' },
          { key: 'venue_name_bn' },
          { key: 'date' },
          { key: 'start_time' },
          { key: 'end_time' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'title_en' },
          { key: 'venue_name' },
          { key: 'date' },
          { key: 'start_time' },
          { key: 'end_time' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('eventManage.event_date') + ' ' + this.$t('globalTrans.entry') : this.$t('eventManage.event_date') + ' ' + this.$t('globalTrans.modify')
    },
    detailsTitle () {
      return this.$t('eventManage.event_date') + ' ' + this.$t('globalTrans.details')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    }
  },
  methods: {
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
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, eventDateEntryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const venueObj = this.$store.state.ExportTrophyCipService.commonObj.venueList.find(obj => obj.value === parseInt(item.venue_id))
          const customItem = {
            venue_name: venueObj?.text_en,
            venue_name_bn: venueObj?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    getCurrentTimeWiseStatus (item) {
      const today = moment(new Date()).format('YYYY-MM-DD')
      if (item.date < today) {
        return this.$t('eventManage.accomplished')
      } else if (item.date > today) {
        return this.$t('eventManage.upcoming')
      } else {
        const currentTime = moment(new Date()).format('HH:mm:ss')
        if (currentTime > item.start_time && currentTime < item.end_time) {
          return this.$t('eventManage.running')
        } else if (currentTime < item.start_time) {
          return this.$t('eventManage.upcoming')
        } else {
          return this.$t('eventManage.accomplished')
        }
      }
    }
  }
}
</script>
