<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.market_inspection_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="inspection_date_from"
            >
              <template v-slot:label>
                {{ $t('priceMonitoring.inspection_date_from') }}
              </template>
                <date-picker
                  id="inspection_date_from"
                  v-model="search.inspection_date_from"
                  class="form-control"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                >
                </date-picker>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="inspection_date_to"
            >
              <template v-slot:label>
                {{ $t('priceMonitoring.inspection_date_to') }}
              </template>
                <date-picker
                  id="inspection_date_to"
                  v-model="search.inspection_date_to"
                  class="form-control"
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
        <h4 class="card-title">{{ $t('priceMonitoring.market_inspection_report') }}</h4>
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
                  <template v-slot:cell(market_directory_ids)="data">
                    {{ getMarketDirectoryList(data.item.market_directory_ids) }}
                  </template>
                  <template v-slot:cell(no_of_cases)="data">
                    {{ $n(data.item.no_of_cases, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(inspection_date)="data">
                    {{ data.item.inspection_date| dateFormat }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button class="btn action-btn status mr-1 btn-sm" :title="$t('globalTrans.details')" v-b-modal.details variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)"><i class="ri-eye-line m-0 "></i></b-button>
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
    <b-modal id="details" size="lg" :title="$t('priceMonitoring.market_inspection_report') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('priceMonitoring.market_inspection_report') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="editItemId" :key="editItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketInspectionReportList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.priceMonitoring.inspection_date, label_bn: i18n.messages.bn.priceMonitoring.inspection_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '25%' } },
  { label_en: i18n.messages.en.priceMonitoring.inspection_market, label_bn: i18n.messages.bn.priceMonitoring.inspection_market, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '35%' } },
  { label_en: i18n.messages.en.priceMonitoring.no_of_cases, label_bn: i18n.messages.bn.priceMonitoring.no_of_cases, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 4, thStyle: { width: '10%' } }
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
        market_directory_id: 0,
        inspection_date_from: '',
        inspection_date_to: '',
        limit: 20
      },
      editItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      labelData: []
    }
  },
  created () {
    this.labelData = this.labelList
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        market_directory_id: this.addressCustomUser.market_id,
        marketList: JSON.stringify(this.loggedUserPrivilege.market_id)
      })
    }
    this.loadData()
  },
  mounted () {
    //
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
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
          { key: 'inspection_date' },
          { key: 'market_directory_ids' },
          { key: 'no_of_cases' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'inspection_date' },
          { key: 'market_directory_ids' },
          { key: 'no_of_cases' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.entry') : this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    },
    marketDirectoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    edit (item) {
      this.editItemId = item.id
      this.item = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketInspectionReportList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const inspectByObj = this.$store.state.BazarMonitoringService.commonObj.inspectByList.find(itemData => itemData.value === parseInt(item.inspect_by))
          const orgObj = this.$store.state.CommonService.commonObj.componentOrgList.find(itemData => itemData.value === parseInt(item.org_id))
          const officeTypeObj = this.$store.state.CommonService.commonObj.officeTypeList.find(itemData => itemData.value === parseInt(item.office_type_id))
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(itemData => itemData.value === parseInt(item.office_id))
          const designationObj = this.$store.state.CommonService.commonObj.designationList.find(itemData => itemData.value === parseInt(item.designation_id))
          // const userObj = RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
          //   if (response.success) {
          //     return response.data.find(user => user.id === item.user_id)
          //   }
          // })
          const inspectByData = {}
          const orgData = {}
          const officeTypeData = {}
          const officeData = {}
          const designationData = {}
          // const userData = {}
            // if (typeof userObj !== 'undefined') {
            //     userData.name = userObj.name
            //     userData.name_bn = userObj.name_bn
            // } else {
            //   userData.name = ''
            //   userData.name_bn = ''
            // }
            if (typeof inspectByObj !== 'undefined') {
                inspectByData.inspect_name = inspectByObj.text_en
                inspectByData.inspect_name_bn = inspectByObj.text_bn
            } else {
              inspectByData.inspect_name = ''
              inspectByData.inspect_name_bn = ''
            }
            if (typeof orgObj !== 'undefined') {
                orgData.org_name = orgObj.text_en
                orgData.org_name_bn = orgObj.text_bn
            } else {
              orgData.org_name = ''
              orgData.org_name_bn = ''
            }
            if (typeof officeTypeObj !== 'undefined') {
                officeTypeData.officeType_name = officeTypeObj.text_en
                officeTypeData.officeType_name_bn = officeTypeObj.text_bn
            } else {
              officeTypeData.officeType_name = ''
              officeTypeData.officeType_name_bn = ''
            }
            if (typeof officeObj !== 'undefined') {
                officeData.office_name = officeObj.text_en
                officeData.office_name_bn = officeObj.text_bn
            } else {
              officeData.office_name = ''
              officeData.office_name_bn = ''
            }
            if (typeof designationObj !== 'undefined') {
              designationData.designation_name = designationObj.text_en
              designationData.designation_name_bn = designationObj.text_bn
            } else {
              designationData.designation_name = ''
              designationData.designation_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, inspectByData, orgData, officeTypeData, officeData, designationData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getMarketDirectoryList (marketIds) {
        const arr = []
        if (marketIds.constructor === Array) {
            marketIds.forEach(item => {
            const marketId = this.marketDirectoryList.find(obj => obj.value === item)
              if (marketId !== undefined) {
                const marketName = this.currentLocale === 'en' ? ' ' + marketId.text_en : ' ' + marketId.text_bn
                arr.push(marketName)
              }
            })
        }
        return arr.toString()
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
