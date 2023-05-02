<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(loadData)" @reset.prevent="reset" autocomplete="off">
            <b-row>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Document" vid="doc_type" rules="required|min_value:1">
                  <b-form-group
                    label-for="doc_type"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('bfti.doc_type')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="search.document_type_id"
                      :options="docTypeList"
                      id="doc_type"
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
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Title" vid="title">
                  <b-form-group
                    label-for="title"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('research_execution.title_or_topic')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.title_id"
                      :options="titleList"
                      id="title_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value=0> {{ load ? 'Loading ....' : $t('globalTrans.select') }} </b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Start date" vid="start_date" >
                  <b-form-group label-for="start_date">
                    <template v-slot:label>
                      {{ $t('globalTrans.start_date') }}
                    </template>
                    <date-picker
                      id="start_date"
                      v-model="search.start_date"
                      class="form-control"
                      :placeholder="$t('globalTrans.select_date')"
                    >
                    </date-picker>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="End date" vid="end_date" >
                  <b-form-group label-for="end_date">
                    <template v-slot:label>
                      {{ $t('globalTrans.end_date') }}
                    </template>
                    <date-picker
                      id="end_date"
                      v-model="search.end_date"
                      class="form-control"
                      :placeholder="$t('globalTrans.select_date')"
                    >
                    </date-picker>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Status" vid="status">
                  <b-form-group
                    label-for="status"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.status')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.status"
                      :options="statusList"
                      id="doc_type"
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
              <b-col xs="12" sm="12" md="4" v-if="search.document_type_id === 2 || search.document_type_id === 3">
                <ValidationProvider name="Contract Status" vid="contract_status">
                  <b-form-group
                    label-for="contract_status"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.contract_status')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.contract_status"
                      :options="yesNo"
                      id="contract_status"
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
              <b-col>
                <b-button type="submit" variant="primary" class="mt-20 mr-2 btn-sm">{{$t('globalTrans.search')}}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
    </card>
    <div v-if="showData">
      <b-overlay :show="loading">
        <slot v-if="eoiShow">
          <Eoi :statusList ="statusList" :yesNo="yesNo" :titleListData="titleListData" :search="search" :reportData="reportData" :headerExcelDefault ="headerExcelDefault"/>
        </slot>
        <slot v-if="rfpShow">
          <Rfp :statusList ="statusList" :yesNo="yesNo" :titleListData="titleListData" :search="search" :reportData="reportData" :headerExcelDefault ="headerExcelDefault"/>
        </slot>
        <slot v-if="researchShow">
          <Research :statusList ="statusList" :yesNo="yesNo" :titleListData="titleListData" :search="search" :reportData="reportData" :headerExcelDefault ="headerExcelDefault"/>
        </slot>
        <slot v-if="policyShow">
          <Policy ::statusList ="statusList" :yesNo="yesNo" :titleListData="titleListData" :search="search" :reportData="reportData" :headerExcelDefault ="headerExcelDefault"/>
        </slot>
     </b-overlay>
    </div>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { progressReportApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import excel from 'vue-excel-export'
import { dateFormat } from '@/utils/fliter'
import Eoi from './Eoi'
import Rfp from './Rfp'
import Research from './Research'
import Policy from './Policy'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Eoi,
    Rfp,
    Research,
    Policy
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        document_type_id: 0,
        title_id: 0,
        contract_status: 0,
        status: 0
      },
      editItemId: 0,
      item: {},
      showData: false,
      load: false,
      titleListData: [],
      headerExcelDefault: [],
      reportData: [],
      eoiShow: false,
      rfpShow: false,
      researchShow: false,
      policyShow: false
    }
  },
  created () {
    this.headerDataExcel()
    // this.loadData()
  },
  watch: {
    'search.document_type_id': function (newVal, oldVal) {
      if (newVal) {
        this.documentWiseTitle()
      }
    }
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (local === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report_management.progress_report')
        headerVal[4] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report_management.progress_report')
        headerVal[4] = ''
      }
      const doctype = this.$t('bfti.doc_type') + ' : ' + (this.search.document_type_id ? this.getColumnName(this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList, 'value', this.search.document_type_id) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const titleOrTopic = this.$t('research_execution.title_or_topic') + ' : ' + (this.search.title_id ? this.getColumnName(this.titleListData, 'value', this.search.title_id) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const startDate = this.$t('globalTrans.start_date') + ' : ' + (this.search.start_date ? dateFormat(this.search.start_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const endDate = this.$t('globalTrans.end_date') + ' : ' + (this.search.end_date ? dateFormat(this.search.end_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const status = this.$t('globalTrans.status') + ' : ' + (this.search.status ? this.getColumnName(this.statusList, 'value', this.search.status) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      headerVal[5] = doctype + titleOrTopic + startDate
      headerVal[6] = endDate + status
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          'ক্রমিক নং': 'serial',
          শিরোনাম: 'title',
          'মন্ত্রণালয়/সংস্থা/বিভাগ ': 'organization_ministry_division',
          'যোগাযোগ ব্যক্তিগত নাম': 'name',
          'যোগাযোগের নম্বর': 'contact_no',
          অবস্থা: 'status',
          'স্ট্যাটাসের তারিখ': 'status_date',
          'মন্তব্য ': 'comment'
        }
      } else {
        return {
          'SL No': 'serial',
          Title: 'title',
          'Organization/Ministry/Division': 'organization_ministry_division',
          'Contact Person No': 'name',
          'Contact No': 'contact_no',
          Status: 'status',
          'Date of Status': 'status_date',
          Remarks: 'comment'
        }
      }
    },
    excelData: function () {
        const excelData = []
        let zero = '0'
        if (this.$i18n.locale === 'bn') {
          zero = '০'
        }
        this.reportData.forEach((item, firstIndex) => {
          let status = ''
          if (item.document_approve_status === 5) {
            status = 'globalTrans.cancel'
          } else if (item.document_approve_status === 4) {
            status = 'research_execution.non_awarded'
          } else if (item.document_approve_status === 3) {
            status = 'research_execution.awarded'
          } else if (item.document_approve_status === 2) {
            status = 'globalTrans.submitted'
          } else {
            status = 'globalTrans.pending'
          }
          let statusDate = ''
          if (item.document_approve_status === 5) {
            statusDate = dateFormat(item.cancel_date)
          } else if (item.document_approve_status === 4) {
            statusDate = dateFormat(item.non_awarded_date)
          } else if (item.document_approve_status === 3) {
            statusDate = dateFormat(item.awarded_date)
          } else if (item.document_approve_status === 2) {
            statusDate = dateFormat(item.submit_date)
          }
          let statusComment = ''
          if (item.document_approve_status === 5) {
            statusComment = item.cancel_comment
          } else if (item.document_approve_status === 4) {
            statusComment = item.non_awarded_comment
          } else if (item.document_approve_status === 3) {
            statusComment = item.awarded_comment
          } else if (item.document_approve_status === 2) {
            statusComment = item.submit_comment
          }
          excelData.push({
            serial: this.$n(firstIndex + 1),
            title: (this.$i18n.locale === 'en') ? item.title : item.title_bn,
            organization_ministry_division: (this.$i18n.locale === 'en') ? item.organization_ministry_division : item.organization_ministry_division_bn,
            name: (this.$i18n.locale === 'en') ? item.name : item.name_bn,
            contact_no: zero + this.$n(item.contact_no, { useGrouping: false }),
            status: this.$t(status),
            status_date: statusDate,
            comment: statusComment
          })
        })
        return excelData
    },
    yesNo () {
      let yesNo = [
        {
          value: 2,
          text_en: 'Signed',
          text_bn: 'স্বাক্ষরিত'
        },
        {
          value: 1,
          text_en: 'Not Signed',
          text_bn: 'স্বাক্ষরিত হয় নাই'
        }
      ]
      yesNo = yesNo.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return yesNo
    },
    statusList () {
      let statusList = [
        {
          value: 1,
          text_en: 'Pending',
          text_bn: 'বিচারাধীন'
        },
        {
          value: 2,
          text_en: 'Submit',
          text_bn: 'দাখিলকৃত'
        },
        {
          value: 3,
          text_en: 'Approve/Awarded',
          text_bn: 'অনুমোদিত'
        },
        {
          value: 4,
          text_en: 'Non-Awarded',
          text_bn: 'অননুমোদিত'
        },
        {
          value: 5,
          text_en: 'Cancel',
          text_bn: 'বাতিল করুন'
        }
      ]
      statusList = statusList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return statusList
    },
    titleList: function () {
      const listObject = this.titleListData
      const tmpList = listObject.map((obj, index) => {
        if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
        } else {
            return { value: obj.value, text: obj.text_en }
        }
      })
      return tmpList
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    headerDataExcel () {
      RestApi.getData(bftiResReportServiceBaseUrl, '/configuration/report-head/detail/10').then(response => {
      if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === 10)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          const data = {
            orgName: orgName,
            orgNameBn: orgNameBn,
            address: response.data.address,
            address_bn: response.data.address_bn
          }
          this.headerExcelDefault = data
      }
      })
    },
    getColumnName (list, field, groupId) {
      const obj = list.find(item => parseInt(item[field]) === parseInt(groupId))
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return obj.text_bn
        } else {
          return obj.text_en
        }
      } else {
        return ''
      }
    },
    async documentWiseTitle () {
      this.load = true
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, 'master-list', this.search)
      if (result.success) {
        this.titleListData = result.data
        this.load = false
      } else {
        this.titleListData = []
        this.load = false
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.showData = true
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, progressReportApi, params)
      if (result.success) {
        this.reportData = result.data
      } else {
        this.reportData = []
      }
      if (this.search.document_type_id === 1) {
        this.eoiShow = true
        this.rfpShow = false
        this.researchShow = false
        this.policyShow = false
      } else if (this.search.document_type_id === 2) {
        this.rfpShow = true
        this.eoiShow = false
        this.researchShow = false
        this.policyShow = false
      } else if (this.search.document_type_id === 3) {
        this.researchShow = true
        this.rfpShow = false
        this.eoiShow = false
        this.policyShow = false
      } else if (this.search.document_type_id === 4) {
        this.policyShow = true
        this.researchShow = false
        this.rfpShow = false
        this.eoiShow = false
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
