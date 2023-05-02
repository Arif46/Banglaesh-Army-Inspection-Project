<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairProposalManagement.fair_proposal_sorting') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="type_of_fair"
            >
              <template v-slot:label>
                {{ $t('externalTradeFair.type_of_fair') }}
              </template>
              <b-form-select
                plain
                id="type_of_fair"
                :options="typeOfFair"
                v-model="search.type_of_fair"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col><b-col sm="4">
            <b-form-group
              label-for="country_id"
            >
              <template v-slot:label>
                {{ $t('externalTradeFair.country') }}
              </template>
              <b-form-select
                plain
                id="country_id"
                :options="countryList"
                v-model="search.country_id"
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
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('tradeFairProposalManagement.fair_proposal_sorting') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <!-- <template v-slot:headerAction>
        <router-link href="javascript:" to="/trade-fair-service/itf/fair-proposal-management/fair-calendar-info-form" class="btn-add"><i class="ri-add-fill"></i> {{  $t('globalTrans.add_new') }}</router-link>
      </template> -->
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:head(check)>
                    <b-form-checkbox
                      style="display: table-cell"
                      class="col-form-label-sm font-weight-bold mb-0"
                      name="checked"
                      v-model="selectAll"
                      @change="checkAll"
                      :value=true
                      :unchecked-value=false
                    >
                    </b-form-checkbox>
                </template>
                <template v-slot:cell(check)="data">
                  <b-form-group class="mb-0" v-slot="{ ariaDescribedby }">
                    <b-form-checkbox-group v-model="selectedItem" style="margin-top: 5px" :aria-describedby="ariaDescribedby">
                      <b-form-checkbox :value="data.item.id" style="margin-right: 0"></b-form-checkbox>
                    </b-form-checkbox-group>
                  </b-form-group>
                </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-detail variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn active view" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <router-link :title="$t('globalTrans.edit')" :to="`/trade-fair-service/itf/fair-proposal-management/fair-calendar-info-form?id=${data.item.id}`" class="action-btn edit"><i class="ri-ball-pen-fill m-0"></i></router-link>
                  </template>
                  <template #custom-foot="">
                    <b-tr>
                      <b-th colspan="10" class="text-right">
                        <button v-b-modal.modal-form-reject @click="sortListStore(selectedItem)" class="btn btn-primary btn-sm" :title="$t('tradeFairProposalManagement.sorting')" :disabled="selectedItem.length > 0 ? false : true">
                          <i class="fas fa-list"></i> {{ $t('tradeFairProposalManagement.reject') }}
                        </button>
                      </b-th>
                    </b-tr>
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
    <b-modal id="modal-detail" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-form-reject" size="md" :title="$t('tradeFairProposalManagement.reject')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Reject :items="selectedItem"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import Reject from './Reject'
import { itfFairCalenderListFiscalCircularWise } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Reject
  },
  data () {
    return {
      sortBy: '',
      selectAll: false,
      selectedItem: [],
      search: {
        type_of_fair: 0,
        country_id: 0,
        limit: 20
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '7%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'externalTradeFair.fair_sector', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'externalTradeFair.type_of_fair', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'externalTradeFair.fair_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '30%' } },
        { labels: 'externalTradeFair.city_country', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8 }
      ],
      actions: {
        edit: true,
        details: false,
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
    },
    selectedItem: function () {
      if (this.selectedItem.length === this.listData.length) {
        this.selectAll = true
      }
      if (this.selectedItem.length < this.listData.length) {
        this.selectAll = false
      }
    }
  },
  computed: {
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
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
          { key: 'fiscal_year_bn' },
          { key: 'fair_sector_bn' },
          { key: 'type_of_fair_bn' },
          { key: 'fair_name_bn' },
          { key: 'country_bn' },
          { key: 'action' },
          { key: 'check' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'fair_sector' },
          { key: 'type_of_fair_en' },
          { key: 'fair_name' },
          { key: 'country_en' },
          { key: 'action' },
          { key: 'check' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    },
    typeOfFair () {
      return this.$store.state.TradeFairService.commonObj.typeOfFair.map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    countryList () {
      return this.$store.state.CommonService.commonObj.countryList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    checkAll () {
      if (this.selectAll) {
        this.selectedItem.splice(0, this.selectedItem.length)
        this.listData.forEach(element => this.selectedItem.push(element.id))
      } else {
        this.selectedItem.splice(0, this.selectedItem.length)
      }
    },
    check () {
      const itemObj = this.listData.find(item => item.is_checked === false)
      if (itemObj === undefined) {
        this.selectAll = true
      } else {
        this.selectAll = false
      }
    },
    sortListStore (item) {
      this.selectedItem = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { circular_id: this.$route.query.circular, fiscal_year_id: this.$route.query.fiscal_year })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, itfFairCalenderListFiscalCircularWise, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const typeOfFair = this.$store.state.TradeFairService.commonObj.typeOfFair.find(obj => obj.value === parseInt(item.type_of_fair))
          const country = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(item.country_id))
          const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(item.fair_sector_id))
          const customItem = {
            fiscal_year_en: fiscalYearData?.text_en,
            fiscal_year_bn: fiscalYearData?.text_bn,
            type_of_fair_bn: typeOfFair.text_bn,
            type_of_fair_en: typeOfFair.text_en,
            country_en: country.text_en,
            country_bn: country.text_bn,
            fair_sector_bn: sectorObj.text_bn,
            fair_sector: sectorObj.text_en
          }
          return Object.assign({}, item, { serial: index }, { circular_memo_number: item.circular.circular_memo_number, subject_en: item.circular.subject_en, subject_bn: item.circular.subject_bn, is_checked: false }, customItem)
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
