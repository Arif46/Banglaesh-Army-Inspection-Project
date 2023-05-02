<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col lg="6" sm="6" md="6">
            <ValidationProvider name="Servey Name" vid="survey_id" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="survey_id"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('survey_management.survey_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="search.survey_id"
                  :options="surveyList"
                  id="survey_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
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

    <div v-if="showData">
      <b-overlay :show="loading">
        <body-card>
          <!-- table section start -->
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('survey_management.survey_report') }}</h4>
          </template>
          <template v-slot:headerAction>
            <!-- <b-button class="btn-add" variant=" iq-bg-primary" @click="pdfExport">
                {{ $t('globalTrans.print') }}
            </b-button> -->
            <button @click="printDiv()" class="btn btn-success btn-sm"><i class="ri-printer-line mr-0"></i>
              {{ $t('globalTrans.print') }}
            </button>
            <button @click="exportToExcel()" class="btn btn-info btn-sm"><i class="ri-printer-line mr-0"></i>
              {{ $t('globalTrans.export_excel') }}
            </button>
          </template>
          <template v-slot:body>
            <div id="printArea" v-if="labels.length > 0">
              <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                <b-thead>
                  <b-tr>
                    <b-td :colspan="labels.length + 3" style="text-align:center">
                      <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10" :colspan="labels.length + 4">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('survey_management.survey_report') }}
                      </list-report-head>
                    </b-td>
                  </b-tr>
                  <b-tr>
                    <b-th style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th style="width:10%" class="text-center">{{ $t('globalTrans.name') }}</b-th>
                    <b-th style="width:10%" class="text-center">{{ $t('globalTrans.application_id') }}</b-th>
                    <slot v-for="(label, index) in labels">
                      <b-th style="width:13%" class="text-center" :key="index">
                        {{ ($i18n.locale === 'en') ? label.label : label.label_bn }}
                      </b-th>
                    </slot>
                  </b-tr>
                </b-thead>
                <b-tbody>
                  <template v-if="allApplicants.length">
                      <b-tr v-for="(data, index) in allApplicants" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td class="text-center"><b>{{ ($i18n.locale === 'en') ? data.name : data.name_bn }}</b></b-td>
                        <b-td class="text-center">
                          {{ data.application_id }}
                        </b-td>
                        <slot v-for="(item, dindex) in data.data">
                          <b-td style="width:13%" class="text-center" :key="dindex">
                            <Input :reportView="true" :tmpData="data.data" :index="dindex" v-if="item.dataType === 'InputField'" />
                            <Attachment :reportView="true" :data="item" v-if="item.dataType === 'Attachment'"/>
                            <Dropdown :reportView="true" :data="item" :drpChangeData="allApplicants[dindex + 1]" :nextIndex="dindex + 1" v-if="item.dataType === 'Dropdown'"/>
                            <Checkbox :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Checkbox'"/>
                            <Radio :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Radio'"/>
                            <Textarea :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Textarea'"/>
                            <Paragraph :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Paragraph'"/>
                            <Date :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Date'"/>
                            <Header :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Header'"/>
                            <Payment :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'Payment'"/>
                            <PaymentCheckbox :reportView="true" :data="data.data[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                            <AddMoreDetails :reportView="true" v-if="item.dataType === 'Add More'" :tmpData="item.layout_value" :colData="item.layout" :key="addDetail" class="mt-3"/>
                          </b-td>
                        </slot>
                      </b-tr>
                  </template>
                  <template v-else>
                      <b-tr>
                          <b-td class="text-center" colspan="10">{{ $t('globalTrans.noDataFound') }}</b-td>
                      </b-tr>
                  </template>
                </b-tbody>
              </b-table-simple>
            </div>
            <div v-else>
              <div class="text-center text-danger" style="font-size">{{ $t('globalTrans.noDataFound') }}</div>
            </div>
          </template>
        </body-card>
     </b-overlay>
     <!-- <pre>{{allApplicants}}</pre> -->
    </div>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHeadExcel.vue'
import Input from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/input-field'
import Dropdown from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/dropdown-field'
import Checkbox from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/checkbox-field'
import Attachment from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/attachment-field-report'
import Radio from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/radio-field'
import Textarea from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/textarea-field'
import Paragraph from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/paragraph-field'
import Date from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/date-field'
import Header from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/header-field'
import Payment from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/payment'
import PaymentCheckbox from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/payment-checkbox'
// import RelationalCheckbox from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableField/relational-checkbox'
// import RelationalDetails from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableField/relational-details'
import AddMoreDetails from '@/modules/external-user-service/views/bfti-panel/pages/components/dissableFieldReport/addMoreDetails'
import Vue from 'vue'
import VueHtmlToPaper from 'vue-html-to-paper'
const options = {
  name: '_blank',
  specs: [
    'fullscreen=yes',
    'titlebar=yes',
    'scrollbars=no'
  ],
  styles: [
    'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
    'https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css',
    // 'http://service.moa.gov.bd/step.css'
    './step.css'
  ],
  autoClose: true
}
Vue.use(VueHtmlToPaper, options)
export default {
  components: {
    ListReportHead,
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    Payment,
    PaymentCheckbox,
    AddMoreDetails
    // RelationalCheckbox,
    // RelationalDetails
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        survey_id: 0
      },
      item: {},
      labels: [],
      totalLabel: 0,
      allApplicants: [],
      layoutData: [],
      showData: false,
      reportData: [],
      detailsData: [],
      addDetail: 1
    }
  },
  created () {
  },
  watch: {
  },
  computed: {
    surveyList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.surveyList.filter(item => item.status === 1)
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    checkColpsan () {
      const total = parseInt(this.totalLabel + 3) * 25
      return Math.round(total / 100)
    },
    exportToExcel () {
      var location = 'data:application/vnd.ms-excel;base64,'
      var excelTemplate = '<html> ' +
        '<head> ' +
        '<meta http-equiv="content-type" content="text/plain; charset=UTF-8"/> ' +
        '</head> ' +
        '<body> ' +
        document.getElementById('printArea').innerHTML +
        '</body> ' +
        '</html>'
      // window.location.href = location + window.btoa(excelTemplate)
      window.location.href = location + window.btoa(unescape(encodeURIComponent(excelTemplate)))
    },
    printDiv () {
      this.$htmlToPaper('printArea')
    },
    getAddMoreData (addMoreLayoutItem) {
      const datas = []
      const addData = []
      this.detailsData.forEach(item => {
        item.forEach(itm => {
          if (itm.id === addMoreLayoutItem.i) {
            addData.push(itm)
          }
        })
      })
      addData.forEach(item => {
        const newFindData = Object.keys(item).reduce((obj, key) => {
          if (key !== 'id') {
            obj[key] = item[key]
          }
          return obj
        }, {})
        datas.push(newFindData)
      })
      return datas
    },
    details (item) {
      this.item = item
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.showData = true
      this.labels = []
      this.allApplicants = []
      if (this.search.survey_id) {
        const surveyName = this.$store.state.BftiResearchAndReportService.commonObj.surveyList.find(obj => obj.value === this.search.survey_id)
        const customItem = {
          survey_en: surveyName?.text_en,
          survey_bn: surveyName?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, surveyReportList, params)
      if (result.success) {
        // const labelDataThere = []
        const addMoreAllData = result.label.filter(dataJson => dataJson.field_type === 'addMore_button')
        const addMoreFiledId = []
        if (typeof addMoreAllData !== 'undefined') {
          addMoreAllData.map((item) => {
            item.fields.forEach(i => {
              addMoreFiledId.push(i)
            })
          })
        }
        const newLabel = []
        result.label.map((item) => {
          let isThere = true
          addMoreFiledId.forEach(i => {
            if (i === item.id) {
              isThere = false
            }
          })
          if (isThere) {
            newLabel.push(item)
          }
        })
        this.labels = newLabel
        this.totalLabel = this.labels.length
        // const layoutData = []
        // let data = []
        const listData = result.allApplicants.map((item) => {
          const otherData = []
          if (item !== null) {
            Object.keys(item).forEach(key => {
              const dataJson = this.labels.find(dataJson => dataJson.field_name === key)
              if (typeof dataJson !== 'undefined') {
                const newData = {}
                Object.keys(dataJson).forEach(function (key1) {
                  newData[key1] = dataJson[key1]
                })
                if (dataJson.field_type === 'options') {
                  newData.value = item[key]
                } else if (dataJson.field_type === 'addMore_button') {
                  const cols = []
                  dataJson.fields.forEach(i => {
                    const field = result.label.find(item => item.id === i)
                    cols.push({ text_en: field.label, text_bn: field.label_bn, id: i })
                  })
                  newData.layout = cols
                  newData.layout_value = JSON.parse(item[dataJson.field_name])
                } else if (dataJson.field_type === 'RelationalField') {
                    newData.value = item[key]
                } else if (dataJson.field_type === 'number') {
                    newData.value = this.$n(item[key], { useGrouping: false })
                } else if (dataJson.field_type === 'text') {
                  if (isNaN(item[key])) {
                    newData.value = item[key]
                  } else {
                    newData.value = this.$n(item[key], { useGrouping: false })
                  }
                } else {
                  newData.value = item[key]
                }
                otherData.push(newData)
              }
            })
          }
          return Object.assign({}, item, { data: otherData })
        })
        this.allApplicants = listData
      } else {
        this.labels = []
        this.allApplicants = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    }
  }
}
</script>

<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
