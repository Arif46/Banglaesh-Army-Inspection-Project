<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('fair_report.application_report') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="fiscal_year"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.fiscal_year') }}
              </template>
              <b-form-select
                plain
                id="fiscal_year"
                :options="fiscalYearList"
                v-model="search.fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="fair_sector"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.fair_sector') }}
              </template>
              <b-form-select
                plain
                id="fair_sector"
                :options="fairSectorList"
                v-model="search.fair_sector_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="fair_name"
            >
              <template v-slot:label>
                {{ $t('globalTrans.fair_name') }}
              </template>
              <b-form-select
                plain
                id="fair_name"
                :options="fairNameList"
                v-model="search.fair_name_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
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
        <h4 class="card-title">{{ $t('fair_report.application_report') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-button variant="primary" @click="pdfExport" class="mb-2 float-right">
            {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('fair_report.application_report') }}
          </list-report-head>
          <b-row>
            <b-col md="4">
              <span>{{ $t('tradeFairConfig.fiscal_year') }}</span>:
              <strong>{{ parseInt(search_param.fiscal_year_id) ? getSearchParamName(search_param.fiscal_year_id, 'fiscal') : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-center">
              <span>{{ $t('tradeFairConfig.fair_sector') }}</span>:
              <strong>{{ parseInt(search_param.fair_sector_id) ? getSearchParamName(search_param.fair_sector_id, 'sector') : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-right">
              <span>{{ $t('tradeFairConfig.fair_name') }}</span>:
              <strong>{{ parseInt(search_param.fair_name_id) ? getSearchParamName(search_param.fair_name_id, 'fair') : $t('globalTrans.all') }}</strong>
            </b-col>
          </b-row>
          <!-- <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" /> -->
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
                    {{ $t('globalTrans.forward') }}
                    </b-form-checkbox>
                  </template>
                  <template v-slot:cell(check)="data">
                    <b-form-group class="mb-0" v-slot="{ ariaDescribedby }" v-if="data.item.status != 3">
                      <b-form-checkbox-group v-model="selectedItem" style="margin-top: 5px" :aria-describedby="ariaDescribedby">
                        <b-form-checkbox :value="data.item.id" style="margin-right: 0"></b-form-checkbox>
                      </b-form-checkbox-group>
                    </b-form-group>
                  </template>
                  <template v-slot:cell(company_type)="data">
                    {{ getCompanyTypeName(data.item.company_type) }}
                  </template>
                  <template v-slot:cell(repres_name)="data">
                    <span v-for="(itm, indx) in data.item.representatives" :key="indx">
                        <span>{{ $i18n.locale === 'en' ? itm.repres_name_en : itm.repres_name_bn }}</span><span v-if="indx+1 < data.item.representatives.length">{{ ', ' }}</span>
                    </span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-details variant=" action-btn status" size="sm" @click="details(data.item)"><i class="ri-eye-fill"></i></b-button>
                  </template>
                </b-table>
              </slot>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { applicationReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      sortBy: '',
      detailsItemId: '',
      itemData: [],
      listData: [],
      search: {
        fiscal_year_id: 0,
        fair_sector_id: 0,
        fair_name_id: 0,
        limit: 20
      },
      search_param: {
        fiscal_year_id: 0,
        fair_sector_id: 0,
        fair_name_id: 0
      },
      fairNameList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'globalTrans.fair_sector', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'globalTrans.fair_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'fair_report.representatives', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 8 }
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
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.fair_sector_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    }
  },
  computed: {
    // listData: function () {
    //   const tmpData = this.$store.state.list
    //   return JSON.parse(JSON.stringify(tmpData))
    // },
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
          { key: 'fair_name_bn' },
          { key: 'name_bn' },
          { key: 'company_type' },
          { key: 'repres_name' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'fair_sector_en' },
          { key: 'fair_name_en' },
          { key: 'name_en' },
          { key: 'company_type' },
          { key: 'repres_name' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    },
    fairSectorList () {
      return this.$store.state.TradeFairService.commonObj.fairSectorList.filter(el => el.status === 1).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getSearchParamName (Id, paramName) {
      let arrayData
      if (paramName === 'fair') {
        arrayData = this.$store.state.TradeFairService.commonObj.fairNameList
      } else if (paramName === 'sector') {
        arrayData = this.$store.state.TradeFairService.commonObj.fairSectorList
      } else if (paramName === 'fiscal') {
        arrayData = this.$store.state.CommonService.commonObj.fiscalYearList
      } else {
        return ''
      }
      const Obj = arrayData.find(el => el.value === parseInt(Id))
      if (typeof Obj !== 'undefined') {
        return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
      } else {
        return ''
      }
    },
    getFairNameList () {
        if (this.search.fiscal_year_id && this.search.fair_sector_id) {
            return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id && item.fair_sector_id === this.search.fair_sector_id).map(el => {
              return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
           })
        } else if (this.search.fiscal_year_id) {
            return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
              return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
           })
        } else {
            return []
        }
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, applicationReportList, this.search)
      if (result.success) {
        this.search_param = result.search_data
        this.listData = this.getRelationalData(result.data)
        // this.$store.dispatch('setList', listData)
      } else {
        this.listData = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
        const mapData = data.map((item, index) => {
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fair_circular.fiscal_year_id))
          const fairSector = this.$store.state.TradeFairService.commonObj.fairSectorList.find(obj => obj.value === parseInt(item.fair_circular.calendar_info.fair_sector_id))
          const customItem = {
            fair_name_en: item.fair_circular.calendar_info.fair_name,
            fair_name_bn: item.fair_circular.calendar_info.fair_name_bn,
            fiscal_year_en: fiscalYear?.text_en,
            fiscal_year_bn: fiscalYear?.text_bn,
            fair_sector_en: fairSector?.text_en,
            fair_sector_bn: fairSector?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
      })
      return mapData
    },
    getCompanyTypeName (id) {
      const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
      if (typeof companyType !== 'undefined') {
        return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
      } else {
        return ''
      }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, fiscal_year_id: this.search.fiscal_year_id, fair_sector_id: this.search.fair_sector_id, fair_name_id: this.search.fair_name_id })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, applicationReportList, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.customloading = false
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
