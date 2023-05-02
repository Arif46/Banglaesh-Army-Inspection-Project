<template>
  <div class="inner-section">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <card>
            <template v-slot:searchHeaderTitle>
              <h4 class="card-title"> {{ $t('globalTrans.document') }} {{ $t('globalTrans.information') }}</h4>
            </template>
            <template v-slot:searchHeaderAction>
              <b-button class="btn-add" variant=" iq-bg-primary" @click="pdfExport">
                {{ $t('globalTrans.print') }}
            </b-button>
              <router-link class="btn btn-add btn-success ml-2" to="/bfti-research-and-report-service/task-activity-monitoring/assign-consultant"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
            </template>
            <template v-slot:searchBody>
                 <b-table-simple bordered>
                <b-tr v-if="Object.values(research).length > 0">
                  <b-th>{{ $t('configuration.document_type') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ getDocumentTypeName(research.document_type_id) }}</b-td>
                  <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? research.organization_bn : research.organization }}</b-td>
                  </b-tr>
                  <b-tr v-if="Object.values(research).length > 0">
                  <b-th>{{ $t('bfti.topic') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? research.topic_bn : research.topic }}</b-td>
                  <b-th class="font-weight-bold">{{ $t('research_execution.project_duration') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ getDuration(research.duration_start_date, research.duration_end_date) }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('task_activity_monitoring.consultant_info') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col>
                  <b-table-simple bordered style="width: 100%">
                   <b-tr>
                    <b-th style="width:70px !important">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th style="width:150px !important">{{ $t('task_activity_monitoring.consultant_info') }}</b-th>
                    <b-th style="width:150px !important">{{ $t('task_activity_monitoring.contract') +' '+$t('globalTrans.from_date') }}</b-th>
                    <b-th style="width:150px !important">{{ $t('task_activity_monitoring.contract') +' '+$t('globalTrans.to_date') }}</b-th>
                    <b-th style="width:150px !important">{{ $t('task_activity_monitoring.contract_amount') }}</b-th>
                    <b-th style="width:150px !important">{{ $t('globalTrans.attachment') }}</b-th>
                  </b-tr>
                    <template v-if="assignConsultant.length === 0">
                      <tr>
                        <th colspan="8" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                      </tr>
                    </template>
                    <template v-else>
                      <b-tr v-for="(head, index) in assignConsultant" :key="index">
                        <b-td v-if="head.date_to">{{ $n(index + 1) }}</b-td>
                        <b-td v-if="head.date_to">{{ ($i18n.locale === 'bn') ? head.name_bn : head.name_en }}, <br/>{{($i18n.locale === 'bn') ? head.designation_bn : head.designation }},<br/>{{($i18n.locale === 'bn') ? head.organization_bn : head.organization }} , <br/> {{ head.contact_no | mobileNumber }}, <br/> {{ head.email }}</b-td>
                        <b-td v-if="head.date_to">
                            {{head.date_from | dateFormat }}
                        </b-td>
                        <b-td v-if="head.date_to">
                            {{head.date_to | dateFormat }}
                        </b-td>
                        <b-td v-if="head.date_to">
                            {{$n(head.amount)}}
                        </b-td>
                         <b-td v-if="head.date_to">
                            <a v-if="head.pre_attachment" class="btn btn-success btn-sm rounded-pill mr-1" target="_blank" :href="baseUrl + 'download-attachment?file=' + head.pre_attachment" title="attachment"><i class="ri-download-cloud-fill"></i></a><br/>
                            <a target="_blank" v-if="head.pre_attachment" :href="baseUrl + head.pre_attachment">{{ $t('bfti.attachment_down')}}</a>
                        </b-td>
                      </b-tr>
                    </template>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<style>
  .datepicker-form {
    font-size: 8px !important;
  }
</style>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { assignConsultantShow, userListByDesignWise } from '../../api/routes'
import ExportPdf from './export_pdf_details'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
    //   bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      baseUrl: bftiResReportServiceBaseUrl,
      condinatorInfo: [],
            research: {},
      taskHeading: [],
      assignConsultant: [],
      userList: [],
      allUserList: [],
      districtList: []
    }
  },
  created () {
    if (this.$route.params.id) {
      this.getAllUserList()
    }
  },
  watch: {
    'form.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    designationList: function () {
      const listObject = this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
      const tmpList = listObject.map((obj, index) => {
        return { value: obj.value, text: obj.text_en }
      })
      return tmpList
    },
    designationListBn: function () {
      const listObject = this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
      const tmpList = listObject.map((obj, index) => {
        return { value: obj.value, text: obj.text_bn }
      })
      return tmpList
    }
  },
  methods: {
    getColumnName (list, field, groupId, type = null) {
      const obj = list.find(item => item[field] === groupId)
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          if (type) {
            return obj.name_bn
          } else {
            return obj.text_bn
          }
        } else {
          if (type) {
            return obj.name
          } else {
            return obj.text_en
          }
        }
      } else {
        return ''
      }
    },
     getDuration (startingDate, endingDate) {
            var startDate = new Date(new Date(startingDate).toISOString().substr(0, 10))
            if (!endingDate) {
                endingDate = new Date().toISOString().substr(0, 10)
            }
            var endDate = new Date(endingDate)
            if (startDate > endDate) {
                var swap = startDate
                startDate = endDate
                endDate = swap
            }
            var startYear = startDate.getFullYear()
            var february = (startYear % 4 === 0 && startYear % 100 !== 0) || startYear % 400 === 0 ? 29 : 28
            var daysInMonth = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            var yearDiff = endDate.getFullYear() - startYear
            var monthDiff = endDate.getMonth() - startDate.getMonth()
            if (monthDiff < 0) {
                yearDiff--
                monthDiff += 12
            }
            var dayDiff = endDate.getDate() - startDate.getDate()
            if (dayDiff < 0) {
                if (monthDiff > 0) {
                    monthDiff--
                } else {
                    yearDiff--
                    monthDiff = 11
                }
                dayDiff += daysInMonth[startDate.getMonth()]
            }

            if (this.$i18n.locale === 'bn') {
                const year = this.$n(yearDiff, { useGrouping: false })
                const month = this.$n(monthDiff, { useGrouping: false })
                const day = this.$n(dayDiff, { useGrouping: false })
                const result = year + ' বছর, ' + month + ' মাস, ' + day + ' দিন'
                return result
            } else {
                const result = yearDiff + ' Year, ' + monthDiff + ' Month, ' + dayDiff + ' Days'
                return result
            }
    },
    getDocumentTypeName (documentTypeId) {
    const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
    return data !== undefined ? data.text : ''
    },
    getAllUserList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allUserList = response.data
          this.loadData()
        } else {
          this.$store.dispatch('mutateCommonProperties', { loading: false })
        }
      })
    },
     async loadData () {
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, assignConsultantShow + '/' + this.$route.params.id)
      if (result.success) {
        this.allreadyAssignConsultant = result.assignConsultant
                this.research = result.research
        this.assignConsultant = result.data.map((item, index) => {
          const isBefore = this.allreadyAssignConsultant.find(allreadyAssignConsultant => allreadyAssignConsultant.resource_pool_id === item.resource_pool_id)
          if (typeof isBefore !== 'undefined') {
            item.select = 1
            item.id = isBefore.id
            item.date_from = isBefore.date_from
            item.date_to = isBefore.date_to
            item.amount = isBefore.amount
            item.pre_attachment = isBefore.attachment
          } else {
            item.select = 0
            item.id = 0
            item.date_from = ''
            item.date_to = ''
            item.amount = ''
            item.pre_attachment = ''
          }
          return Object.assign({}, item)
        })
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      } else {
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    pdfExport () {
      const reportTitle = this.$t('task_activity_monitoring.assign_consultant') + ' ' + this.$t('globalTrans.details')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.assignConsultant)
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    }
  }
}
</script>
