<template>
  <b-container fluid>
    <Search @LOAD_DATA="getSearchData" :key="componentKey" :menuId="$route.params.id" />
    <b-row>
      <b-col md="12">
        <iq-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ checkBn ? menuInfoList.grid_title_bn : menuInfoList.grid_title_en }}</h4>
          </template>
          <template v-slot:headerAction>
            <b-overlay :show="listLoading">
              <b-button class="mr-1" variant="primary" @click="pdfExport">
                <i class="fa fa-print"></i> {{  $t('globalTrans.print') }}
              </b-button>

              <b-button variant="primary">
                <export-excel
                  worksheet="Report Sheet"
                  :title=excelHeaderValue
                  :fields=excelFields
                  :data=excelData
                  :name="`${menuInfoList.grid_title_en}.xls`">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel>
              </b-button>
            </b-overlay>
          </template>
          <template v-slot:body>
            <b-overlay :show="listLoading">
              <b-row>
                  <b-col v-if="menuId">
                      <ListReportHead :baseUrl="licenseRegistrationServiceBaseUrl" url="/configuration/report-heading/detail" :menuId="menuId" @readyReportHead="inputReportHead">
                        {{ checkBn ? allData.title_bn : allData.title_en }} </ListReportHead>
                  </b-col>
              </b-row>
              <b-row>
                <b-col md="12" class="table-responsive">
                  <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + pagination.slOffset) }}
                    </template>
                    <template v-slot:cell(application_id)="data">
                      {{ $n(data.item.application_id, { useGrouping: false }) }}
                    </template>
                    <template v-slot:cell(org_id)="data">
                      {{ getMainStoreData('orgList', data.item.org_id) }}
                    </template>
                    <template v-slot:cell(service_id)="data">
                      {{ getStoreData('licenseRegistration', 'serviceNamesList', data.item.service_id) }}
                    </template>
                    <template v-slot:cell(issue_date)="data">
                      <span>{{ data.item.issue_date | dateFormat }}</span>
                    </template>
                    <template v-slot:cell(expire_date)="data">
                      <span>{{ data.item.expire_date | dateFormat }}</span>
                    </template>
                    <template v-slot:cell(generate_id)="data">
                      <span v-if="data.item.generate_id !== 0">
                        {{ $n(data.item.generate_id, {useGrouping: false}) }}
                      </span>
                      <span v-else-if="data.item.old_manual_id !== ''">
                        {{ data.item.old_manual_id }}
                      </span>
                      <span v-else>
                        {{ $t('boro_import.not_approved_yet') }}
                      </span>
                    </template>
                    <template v-slot:cell(status)="data">
                      {{ getStepName(data.item.current_step) }}
                    </template>
                    <template v-slot:cell(action)="data">
                        <!-- Details View -->
                        <router-link v-if="data.item.generate_id !== null" :to="{ name: getBtn(2).url, params: { stepChange }}" :title="getBtn(2).text" :class="`btn btn-sm`+ getBtn(2).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(2).icon"></i></span></router-link>
                        <!-- License View -->
                        <router-link v-if="data.item.generate_id !== null" :to="{ name: getBtn(5).url, params: { stepChange }}" :title="getBtn(5).text" :class="`btn btn-sm `+ getBtn(5).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(5).icon"></i></span></router-link>
                    </template>
                  </b-table>
                  <b-pagination
                    v-model="pagination.currentPage"
                    :per-page="pagination.perPage"
                    :total-rows="pagination.totalRows"
                    @input="searchData"
                    />
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </iq-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import Search from '../../components/searchReport'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { reportDataList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'
import ListReportHead from '@/components/custom/ListReportHeadLrcpn.vue'
import reportPdf from './export_pdf'
import { dateFormat } from '@/utils/fliter'
/** Excel */
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList, common],
  components: {
    Search,
    ListReportHead
  },
  data () {
    return {
      listLoading: false,
      componentKey: 0,
      stepChange: {
        application_id: [],
        step_id: 0,
        service_id: 0,
        org_id: 0,
        status: 1
      },
      search: {},
      columns: [],
      allData: {},
      menuInfo: [],
      isAddBtn: false,
      isAppPayment: false,
      gridLangData: '',
      resultData: '',
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      reportHeadData: {
        orgName: '',
        address: ''
      }
    }
  },
  created () {
    this.setCommonGrid()
    this.loadData()
  },
  computed: {
    excelHeaderValue: function () {
      const headerVal = []
      if (this.$i18n.locale === 'bn') {
        headerVal[0] = this.reportHeadData.orgName
        headerVal[1] = this.reportHeadData.address
        headerVal[2] = this.allData.title_bn
      } else {
        headerVal[0] = this.reportHeadData.orgName
        headerVal[1] = this.reportHeadData.address
        headerVal[2] = this.allData.title_en
      }
      return headerVal
    },
    excelFields () {
      if (this.columns.length <= 0) return {}
      const obj = Object.create(null)

      for (let index = 0; index < this.columns.length; index++) {
        const element = this.columns[index]
        if (element === null || element === undefined) continue
        if (element.key === 'action') continue
        obj[element.label] = element.key
      }

      return obj
    },
    excelData: function () {
      if (this.listData.length <= 0) return []
      const excelData = []

      for (let index = 0; index < this.listData.length; index++) {
        const dataItem = this.listData[index]
        const obj = Object.create(null)

        for (const key in this.excelFields) {
          const elementV = this.excelFields[key]
          if (elementV === 'index') {
            obj.index = this.$n(index + 1)
          } else if (elementV === 'generate_id' || elementV === 'application_id') {
            obj[elementV] = this.$n(dataItem[elementV], { useGrouping: false })
          } else if (elementV === 'expire_date' || elementV === 'issue_date') {
            obj[elementV] = dateFormat(dataItem[elementV])
          } else if (elementV === 'status') {
            obj.status = this.getStepName(dataItem.current_step)
          } else {
            obj[elementV] = dataItem[elementV]
          }
        }

        excelData.push(obj)
      }

      return excelData
    },
    auth () {
      return this.$store.state.Auth
    },
    formTitle () {
       return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
    },
    menuId () {
      return this.$route.params.id
    },
    menuInfoList () {
      const menuId = this.$route.params.id
      return this.$store.state.licenseRegistration.commonObj.reportMenuList.find(item => item.menu_id === parseInt(menuId))
    },
    laodList () {
      return this.$store.state.licenseRegistration.commonObj.laodList
    },
    local: function () {
      return this.$i18n.locale
    }
  },
  watch: {
    laodList: function (n, o) {
      if (n !== o) {
        this.loadData()
      }
    },
    menuId: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    local: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.getLanguateWisedata()
          this.componentKey = this.componentKey + 1
      }
    }
  },
  methods: {
    SetStep (item, status) {
      this.stepChange.application_id[0] = item.application_id
      this.stepChange.step_id = item.current_step
      this.stepChange.service_id = item.service_id
      this.stepChange.org_id = item.org_id
      this.stepChange.status = status
    },
    getBtn (value) {
      return this.$store.state.licenseRegistration.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
    },
    inputReportHead (data) {
      if (data.orgName) {
        this.reportHeadData = data
      } else {
        if (this.checkBn) {
          this.reportHeadData.orgName = 'কৃষি মন্ত্রণালয়'
          this.reportHeadData.address = 'বিল্ডিং নং ৪, সচিবালয়, আব্দুল গণি রোড, ঢাকা'
        } else {
          this.reportHeadData.orgName = 'Ministry of Agriculture'
          this.reportHeadData.address = 'Building no 4, Secretariat, Abdul Gani Rd, Dhaka'
        }
      }
    },
    getLanguateWisedata () {
      this.setGridData(this.gridLangData)
      this.setStatusColumn()
      this.setActionColumn()
    },
    getStepName (stId) {
      const step = this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === stId)
      return step.text
    },
    searchData () {
      this.loadData()
    },
    loadData () {
      const params = Object.assign({}, this.search, {
        page: this.pagination.currentPage,
        per_page: this.pagination.perPage,
        service_id: this.menuInfoList.service_id,
        report_process_id: this.menuInfoList.report_process_id,
        is_org_admin: this.$store.state.Auth.authUser.is_org_admin,
        office_id: this.$store.state.Auth.authUser.office_id
      })
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, reportDataList, params).then(response => {
        if (response.success) {
          let result = []
          if (response.data.data.length) {
            this.resultData = response.data.data
            result = this.getRelationData(response.data.data)
          } else {
            result = []
          }
          this.$store.dispatch('setList', result)
          this.paginationData(response.data)
        }
        this.listLoading = false
      })
    },
    getRelationData (data) {
        return data.map(item => {
          let tmpdd = {}
          Object.keys(item).map(key => {
            this.columns.map(element => {
              if ((typeof element !== 'undefined') && (typeof element.layData !== 'undefined')) {
                if (element.layData.field_name === key && element.layData.field_type === 'dropdown') {
                  if (element.layData.dropdownData.component_id === '1') {
                    tmpdd = Object.assign(item, item[key] = this.getCommonStoreData(element.layData.dropdownData.dropdown_name, item[key]))
                  } else {
                    tmpdd = item
                  }
                }
              } else {
                tmpdd = item
              }
            })
          })
          return tmpdd
        })
    },
    getSearchData (res) {
      if (res.type === 2) {
        this.allData = res.data.commonData
        this.search = res.searchData
        if (res.data.success) {
          const dynamicGrid = res.data.grid_field.map(item => {
            const tmpData = JSON.parse(item.data)
            return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, layData: tmpData, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '' }
          })
          this.gridLangData = dynamicGrid
          this.setGridData(dynamicGrid)
          this.setIssueExpireGrid(this.allData)
          if (this.allData.status) {
            this.setStatusColumn()
          }
          if (this.allData.detail) {
            this.setActionColumn()
          }
        } else {
          this.setCommonGrid()
        }
      } else {
        this.search = res.data
      }
      this.loadData()
    },
    setCommonGrid () {
      this.setSlAction(2)
    },
    setIssueExpireGrid (data) {
      const gridData = JSON.parse(data.grids)
      const itemArray = []
      gridData.forEach(item => {
        if (item === 10000) {
          itemArray.push({ label: this.checkBn ? 'প্রদানের তারিখ' : 'Issue Date', label_en: 'Issue Date', label_bn: 'প্রদানের তারিখ', class: 'text-left', key: 'issue_date' })
        } else if (item === 10001) {
          itemArray.push({ label: this.checkBn ? 'মেয়াদ উত্তীর্ণের তারিখ' : 'Expire Date', label_en: 'Expire Date', label_bn: 'মেয়াদ উত্তীর্ণের তারিখ', class: 'text-left', key: 'expire_date' })
        } else if (item === 10002) {
          itemArray.push({ label: this.checkBn ? 'লাইসেন্স নং' : 'License No', label_en: 'License No', label_bn: 'লাইসেন্স নং', class: 'text-left', key: 'generate_id' })
        }
      })
      this.columns = this.columns.concat(itemArray)
    },
    setGridData (data) {
      const newArray = data.map(item => {
        if ((this.local === 'en' && item.langType === 'en') || (this.local === 'en' && item.langType === '')) {
          return { label: item.text_en, label_en: item.text_en, class: 'text-left', key: item.value, layData: item.layData }
        } else if ((this.local === 'bn' && item.langType === 'bn') || (this.local === 'bn' && item.langType === '')) {
          return { label: item.text_bn, label_en: item.text_bn, class: 'text-left', key: item.value, layData: item.layData }
        }
      })
      this.columns = newArray
      this.setSlAction(1)
    },
    setSlAction (type) {
      this.columns = [
        // fsa
        { label: this.checkBn ? 'ক্রমিক নং' : 'SL No', label_en: 'SL No', label_bn: 'ক্রমিক নং', class: 'text-left', key: 'index' },
        { label: this.checkBn ? 'আবেদন আইডি' : 'Application Id', label_en: 'Application Id', label_bn: 'আবেদন আইডি', class: 'text-left', key: 'application_id' }
        ].concat(this.columns)
    },
    setStatusColumn () {
      this.columns = this.columns.concat([
        { label: this.checkBn ? 'অবস্থা' : 'Status', label_en: 'Status', label_bn: 'অবস্থা', class: 'text-left', key: 'status' }
      ])
    },
    setActionColumn () {
      this.columns = this.columns.concat([
        { label: this.checkBn ? 'অ্যাকশন' : 'Action', label_en: 'Action', label_bn: 'অ্যাকশন', class: 'text-left', key: 'action' }
      ])
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.step.value))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
    },
    pdfExport () {
      const reportTitle = this.checkBn ? this.allData.title_bn : this.allData.title_en
      reportPdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, this.resultData[0].org_id, reportTitle, this.columns, this.resultData, this)
    }
  }
}
</script>
<style scoped>
  .btn i {
      margin-right: 0px !important;
  }
  .btn {
    margin-left: 2px;
  }
</style>
