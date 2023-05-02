<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <iq-card>
          <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('li_step.expiration_passed_report') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  :label="$t('warehouse_config.organization')"
                  label-for="org_id"
                  >
                  <b-form-select
                      plain
                      v-model="search.org_id"
                      :options="orgList"
                      id="org_id"
                      >
                      <template v-slot:first>
                      <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  :label="$t('service_name.service_name')"
                  label-for="service_id"
                  >
                  <b-form-select
                      plain
                      v-model="search.service_id"
                      :options="serviceList"
                      id="service_id"
                      >
                      <template v-slot:first>
                      <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  :label="$t('li_step.type')"
                  label-for="report_type"
                  >
                  <b-form-select
                      plain
                      v-model="search.report_type"
                      :options="reportTypeList"
                      id="report_type"
                      >
                      <template v-slot:first>
                      <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <b-button type="button" variant="primary" @click="searchData">{{ $t('globalTrans.search')}}</b-button>
              </b-col>
            </b-row>
          </template>
        </iq-card>
        <b-row>
          <b-col md="12" v-if="showData">
            <b-overlay>
              <iq-card>
                <template v-slot:body>
                  <b-row>
                    <b-col md="12">
                      <iq-card>
                        <template v-slot:headerTitle>
                          <h4 class="card-title">{{ $t('li_step.expiration_passed_report_list') }}</h4>
                        </template>
                        <template v-slot:headerAction>
                          <b-button variant="primary" @click="pdfExport" class="mr-2">
                            {{  $t('globalTrans.print') }}
                          </b-button>

                          <b-button variant="warning">
                            <export-excel
                                worksheet="Report Sheet"
                                :title=excelHeaderValue
                                :fields=excelFields
                                :data=excelData
                                name="expiration-passed-report.xls">
                                {{ $t('globalTrans.export_excel') }}
                            </export-excel>
                          </b-button>
                        </template>
                        <template v-slot:body>
                          <b-overlay :show="loading">
                            <b-row mt-5>
                              <b-col md="12" class="table-responsive">
                                <br style="border: 2px solid;margin:10px;padding:10px">
                                  <b-row>
                                    <b-col>
                                       <ListReportHead :baseUrl="licenseRegistrationServiceBaseUrl" url="/configuration/report-heading/detail" :menuId="0" @readyReportHead="inputReportHead">
                                            {{ $t('li_step.expiration_passed_report') }}
                                        </ListReportHead>
                                    </b-col>
                                  </b-row>
                                  <b-col>
                                    <div class="text-center">
                                        <table style="width:100%;color:black;">
                                            <tr v-if="search.org_name">
                                                <td align="right" style="width:35%">{{ $t('warehouse_config.organization') }}</td>
                                                <td align="center" style="width:5%">:</td>
                                                <td align="left" style="width:60%">{{ ($i18n.locale==='bn') ? search.org_name_bn : search.org_name }}</td>
                                            </tr>
                                            <tr v-if="search.service_name">
                                                <td align="right" style="width:35%">{{ $t('service_name.service_name') }}</td>
                                                <td align="center" style="width:5%">:</td>
                                                <td align="left" style="width:60%">{{ ($i18n.locale==='bn') ? search.service_name_bn : search.service_name }}</td>
                                            </tr>
                                            <tr v-if="search.type_en">
                                                <td align="right" style="width:35%">{{ $t('li_step.type') }}</td>
                                                <td align="center" style="width:5%">:</td>
                                                <td align="left" style="width:60%">{{ ($i18n.locale==='bn') ? search.type_bn : search.type_en }}</td>
                                            </tr>
                                        </table>
                                    </div>
                                  </b-col>
                                <template v-if="datas.length">
                                    <b-row>
                                        <b-col>
                                            <b-table-simple class="tg mt-3" bordered hover row-hovered small caption-top responsive show-empty>
                                                <b-thead>
                                                <b-tr>
                                                    <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                                    <b-th class="text-center">{{ $t('warehouse_config.organization') }}</b-th>
                                                    <b-th class="text-center">{{ $t('li_step.application_id') }}</b-th>
                                                    <b-th class="text-center">{{ $t('li_step.issue_date') }}</b-th>
                                                    <b-th class="text-center">{{ $t('li_step.expire_date') }}</b-th>
                                                </b-tr>
                                                </b-thead>
                                                <b-tbody  v-for="(info, index) in datas" :key="index">
                                                <b-td class="text-center">{{  $n(index + 1) }}</b-td>
                                                <b-td class="text-center">{{ ($i18n.locale==='bn') ? info.org_name_bn : info.org_name }}</b-td>
                                                <b-td class="text-center">{{ $n(info.application_id, { useGrouping: false }) }}</b-td>
                                                <b-td class="text-center">{{ info.issue_date | dateFormat }}</b-td>
                                                <b-td class="text-center">{{ info.expire_date | dateFormat }}</b-td>
                                                </b-tbody>
                                            </b-table-simple>
                                        </b-col>
                                    </b-row>
                                </template>
                                <template v-else>
                                    <div class="text-center">
                                      {{ $t('globalTrans.noDataFound') }}
                                    </div>
                                </template>
                              </b-col>
                            </b-row>
                          </b-overlay>
                        </template>
                      </iq-card>
                    </b-col>
                  </b-row>
                </template>
              </iq-card>
            </b-overlay>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { expirationPassedReportList } from '../../../api/routes'
import { dateFormat } from '@/utils/fliter'
import ListReportHead from '@/components/custom/ListReportHeadLrcpn.vue'
import Pdf from './pdf'
/** Excel */
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
    props: ['id'],
    components: {
      ListReportHead
    },
    created () {
    },
    data () {
      return {
        search: {
          org_id: 0,
          service_id: 0,
          report_type: 0
        },
        licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
        datas: [],
        loading: false,
        showData: false,
        serviceList: [],
        reportHeadData: {
          orgName: '',
          address: ''
        }
      }
    },
    computed: {
        excelHeaderValue: function () {
          if (this.datas.length <= 0) return []
          const headerVal = []
          headerVal[0] = this.reportHeadData.orgName
          headerVal[1] = this.reportHeadData.address
          headerVal[2] = this.$t('li_step.expiration_passed_report_list')
          headerVal[3] = this.getHeadParam()
          return headerVal
        },
        excelFields: function () {
          return {
            [`${this.$t('globalTrans.sl_no')}`]: 'serial',
            [`${this.$t('warehouse_config.organization')}`]: 'organization',
            [`${this.$t('li_step.application_id')}`]: 'application_id',
            [`${this.$t('li_step.issue_date')}`]: 'issue_date',
            [`${this.$t('li_step.expire_date')}`]: 'expire_date'
          }
        },
        excelData: function () {
          if (this.datas.length <= 0) return []
          const excelData = []

          for (let index = 0; index < this.datas.length; index++) {
            const element = this.datas[index]

            if (this.$i18n.locale === 'bn') {
              excelData.push({
                serial: this.$n(index + 1),
                organization: element.org_name_bn,
                application_id: this.$n(element.application_id, { useGrouping: false }),
                issue_date: this.dateFormatForExcel(element.issue_date),
                expire_date: this.dateFormatForExcel(element.expire_date)
              })
            } else {
              excelData.push({
                serial: this.$n(index + 1),
                organization: element.org_name,
                application_id: this.$n(element.application_id, { useGrouping: false }),
                issue_date: this.dateFormatForExcel(element.issue_date),
                expire_date: this.dateFormatForExcel(element.expire_date)
              })
            }
          }

          return excelData
        },
        orgList: function () {
            return this.$store.state.commonObj.organizationProfileList.filter(item => item.status === 0)
        },
        reportTypeList: function () {
          const list = [
            { value: 1, text: this.$i18n.locale === 'bn' ? 'মেয়াদোত্তীর্ণ' : 'Expired' },
            { value: 2, text: this.$i18n.locale === 'bn' ? 'সক্রিয়' : 'Active' }
          ]
          return list
        }
    },
    watch: {
       'search.org_id': function (newValue, oldVal) {
            if (newValue !== oldVal) {
                this.serviceList = this.getServiceList(newValue)
            }
        }
    },
    methods: {
      dateFormatForExcel (data) {
        return dateFormat(data)
      },
      inputReportHead (data) {
        if (data.orgName) {
          this.reportHeadData = data
        } else {
          if (this.$i18n.locale === 'bn') {
            this.reportHeadData.orgName = 'কৃষি মন্ত্রণালয়'
            this.reportHeadData.address = 'বিল্ডিং নং ৪, সচিবালয়, আব্দুল গণি রোড, ঢাকা'
          } else {
            this.reportHeadData.orgName = 'Ministry of Agriculture'
            this.reportHeadData.address = 'Building no 4, Secretariat, Abdul Gani Rd, Dhaka'
          }
        }
      },
      getHeadParam () {
        let tmpText = ''
        if (this.$i18n.locale === 'bn') {
          tmpText += `${this.$t('globalTrans.organization')} : ${this.search.org_name_bn ? this.search.org_name_bn : this.$t('globalTrans.all')}`
          tmpText += `, ${this.$t('service_name.service_name')} : ${this.search.service_name_bn ? this.search.service_name_bn : this.$t('globalTrans.all')}`
          tmpText += `, ${this.$t('li_step.type')} : ${this.search.type_bn ? this.search.type_bn : this.$t('globalTrans.all')}`
        } else {
          tmpText += `${this.$t('globalTrans.organization')} : ${this.search.org_name ? this.search.org_name : this.$t('globalTrans.all')}`
          tmpText += `, ${this.$t('service_name.service_name')} : ${this.search.service_name ? this.search.service_name : this.$t('globalTrans.all')}`
          tmpText += `, ${this.$t('li_step.type')} : ${this.search.type_en ? this.search.type_en : this.$t('globalTrans.all')}`
        }
        return tmpText
      },
      pdfExport () {
        const reportTitle = this.$t('li_step.expiration_passed_report')
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.datas, this, this.search)
      },
      async searchData () {
        this.getCustomDataSearch()
        this.loading = true
        this.showData = true
        const params = Object.assign({}, this.search)
        await RestApi.getData(licenseRegistrationServiceBaseUrl, expirationPassedReportList, params).then(response => {
            if (response.success) {
                this.datas = this.getRelationalData(response.data)
            } else {
                this.datas = []
            }
        })
        this.loading = false
      },
      getRelationalData (data) {
            const orgList = this.$store.state.commonObj.organizationProfileList
            return data.map(item => {
                const orgDataObj = orgList.find(org => org.value === item.org_id)
                const orgData = {
                        org_name: orgDataObj ? orgDataObj.text_en : '',
                        org_name_bn: orgDataObj ? orgDataObj.text_bn : ''
                    }

                return Object.assign({}, item, orgData)
            })
      },
      getServiceList (orgId = null) {
        return this.$store.state.licenseRegistration.commonObj.serviceNamesList.filter(service => service.org_id === orgId)
      },
      getCustomDataSearch () {
          const orgObj = this.$store.state.commonObj.organizationProfileList.find(orgData => orgData.value === parseInt(this.search.org_id))
          if (typeof orgObj !== 'undefined') {
          this.search.org_name = orgObj.text_en
          this.search.org_name_bn = orgObj.text_bn
          } else {
          this.search.org_name = ''
          this.search.org_name_bn = ''
          }
          const serviceObj = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(serviceData => serviceData.value === parseInt(this.search.service_id))
          if (typeof serviceObj !== 'undefined') {
          this.search.service_name = serviceObj.text_en
          this.search.service_name_bn = serviceObj.text_bn
          } else {
          this.search.service_name = ''
          this.search.service_name_bn = ''
          }
          const typeObj = this.reportTypeList.find(item => item.value === this.search.report_type)
          this.search.type_en = typeof typeObj !== 'undefined' ? typeObj.text : ''
          this.search.type_bn = typeof typeObj !== 'undefined' ? typeObj.text : ''
      }
  }
}
</script>
