<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairConfig.committee_info') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="committee_type"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.committee_type') }}
              </template>
              <b-form-select
                plain
                id="committee_type"
                :options="committeeTypeList"
                v-model="search.committee_type"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="committee_name_id"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.committee_name') }}
              </template>
              <b-form-select
                plain
                id="committee_name_id"
                :options="committeeNameList"
                v-model="search.committee_name_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('tradeFairConfig.committee_formation_date') }}
                </template>
                <date-picker
                  id="committee_formation_date"
                  class="form-control"
                  v-model="search.committee_formation_date"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                >
                </date-picker>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('tradeFairConfig.committee_tenure_date') }}
                </template>
                <date-picker
                  id="committee_tenure_date"
                  class="form-control"
                  v-model="search.committee_tenure_date"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                >
                </date-picker>
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
        <h4 class="card-title">{{ $t('tradeFairConfig.committee_info_list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
        <router-link href="javascript:" to="committee-info-form" class="btn-add"><i class="ri-add-fill"></i> {{  $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(committee_formation_date)="data">
                    {{ data.item.committee_formation_date | dateFormat }}
                  </template>
                  <template v-slot:cell(committee_tenure_date)="data">
                    {{ data.item.committee_tenure_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <router-link :title="$t('globalTrans.edit')" :to="`/trade-fair-service/itf/configuration/committee-info-form?id=${data.item.id}`" class="action-btn edit"><i class="ri-ball-pen-fill m-0"></i></router-link>
                    <b-button :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="remove(data.item)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
    <b-modal id="modal-4" size="xl" :title="$t('tradeFairConfig.committee_info_details')" hide-footer ok-only ok-variant="danger">
      <Details :id="detailsItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import Details from './Details.vue'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { committeeInfoList, committeeInfoToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.tradeFairConfig.committee_type, label_bn: i18n.messages.bn.tradeFairConfig.committee_type, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tradeFairConfig.committee_name, label_bn: i18n.messages.bn.tradeFairConfig.committee_name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tradeFairConfig.committee_formation_date, label_bn: i18n.messages.bn.tradeFairConfig.committee_formation_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tradeFairConfig.committee_tenure_date, label_bn: i18n.messages.bn.tradeFairConfig.committee_tenure_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 7, thStyle: { width: '15%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        committee_type: 0,
        committee_name_id: 0,
        committee_formation_date: '',
        committee_tenure_date: '',
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      committeeNameList: [],
      labelData: [],
      item: '',
      detailsItemId: ''
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
    },
    'search.committee_type': function (newVal, oldVal) {
      if (newVal) {
        this.committeeNameList = this.getCommitteeName(newVal)
      } else {
        this.committeeNameList = []
      }
    }
  },
  computed: {
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
          { key: 'Committee_type_bn' },
          { key: 'committee_name_bn' },
          { key: 'committee_formation_date' },
          { key: 'committee_tenure_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'Committee_type_en' },
          { key: 'committee_name_en' },
          { key: 'committee_formation_date' },
          { key: 'committee_tenure_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tradeFairConfig.committee_info') + ' ' + this.$t('globalTrans.entry') : this.$t('tradeFairConfig.committee_info') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    },
    committeeTypeList () {
      return this.$store.state.TradeFairService.commonObj.committeeTypeList
    }
  },
  methods: {
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, committeeInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const committeeType = this.$store.state.TradeFairService.commonObj.committeeTypeList.find(obj => obj.value === parseInt(item.committee_type_id))
          const committeeName = this.$store.state.TradeFairService.commonObj.committeeNameList.find(obj => obj.status === 1 && obj.value === parseInt(item.committee_name_id))
          const customItem = {
            Committee_type_en: committeeType?.text_en,
            Committee_type_bn: committeeType?.text_bn,
            committee_name_en: committeeName?.text_en,
            committee_name_bn: committeeName?.text_bn
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
    remove (item) {
      this.changeStatus(9, internationalTradeFairServiceBaseUrl, committeeInfoToggle, item)
    },
    getCommitteeName (id) {
      return this.$store.state.TradeFairService.commonObj.committeeNameList.filter(item => item.status === 1 && item.committee_type_id === id)
    }
  }
}
</script>
