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
              <router-link class="btn-add" to="/bfti-research-and-report-service/task-activity-monitoring/assign-consultant"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
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
              <h4 class="card-title"> {{ $t('task_activity_monitoring.assign_consultant') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-table-simple bordered style="width: 100%">
                  <b-tr>
                    <b-th style="width:70px !important">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th style="width:60px !important">{{ $t('globalTrans.checkbox') }}</b-th>
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
                      <b-td>{{ $n(index + 1) }}</b-td>
                      <td style="text-align:center">
                        <b-form-checkbox
                          :id="'checkbox-' + index"
                          v-model="head.select"
                          :name="'checkbox-' + index"
                          value=1
                          unchecked-value=0
                        >
                        </b-form-checkbox>
                      </td>
                      <b-td>{{ ($i18n.locale === 'bn') ? head.name_bn : head.name_en }}, <br/> {{ head.contact_no | mobileNumber }}, <br/> {{ head.email }}, <br/>{{($i18n.locale === 'bn') ? head.designation_bn : head.designation }},<br/>{{($i18n.locale === 'bn') ? head.organization_bn : head.organization }}</b-td>
                      <b-td>
                        <ValidationProvider v-if="head.select === '1'" :vid="'date_from' + index" rules="required" name="Start Date">
                          <div slot-scope="{ valid, errors }">
                            <date-picker
                              :id="'date_from['+index+']'"
                              v-model="head.date_from"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :class="errors[0] ? 'is-invalid' : ''"
                              class="form-control"
                              :placeholder="$t('globalTrans.select_date')"
                            >
                            </date-picker>
                            <div class="invalid-feedback d-block">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider v-if="head.select === '1'" :vid="'date_to' + index" rules="required" name="End Date">
                          <div slot-scope="{ valid, errors }">
                            <date-picker
                              :id="'date_to['+index+']'"
                              v-model="head.date_to"
                              :class="errors[0] ? 'is-invalid' : ''"
                              :state="errors[0] ? false : (valid ? true : null)"
                                class="form-control"
                              :placeholder="$t('globalTrans.select_date')"
                            >
                            </date-picker>
                            <div class="invalid-feedback d-block">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                         <ValidationProvider v-if="head.select === '1'" :vid="'amount' + index" name="amount">
                          <div slot-scope="{ valid, errors }">
                            <b-form-input
                              :id="'amount['+index+']'"
                              type="number"
                              v-model="head.amount"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider v-if="head.select === '1'" name="Attachment" :vid="attachment+index" rules="" v-slot="{ errors }">
                            <b-form-group
                                label-for="attachment">
                                <b-form-file
                                    v-model="head.attachmentFile"
                                    @change="onChange($event, head)"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    placeholder="Choose a file or drop it here..."
                                    drop-placeholder="Drop file here..."
                                ></b-form-file>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-td>
                    </b-tr>
                  </template>
                </b-table-simple>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <router-link class="btn-sm btn btn-danger" to="/bfti-research-and-report-service/task-activity-monitoring/assign-consultant">{{ $t('globalTrans.cancel') }}</router-link>
            </b-col>
          </b-row>
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
import { assignConsultantUpdate, assignConsultantShow, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      research: {},
      assignConsultant: [],
      allreadyAssignConsultant: [],
      userList: [],
      attachmentFile: [],
      attachment: [
        {
          head: ''
        }
      ],
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
    getColumnName (list, field, groupId) {
      const obj = list.find(item => item[field] === groupId)
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
    onChange (event, head) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          head.file = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
         head.file = null
      }
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
            item.select = '1'
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
    getUserListLoop (designationId, lng) {
      const userList = this.allUserList.filter(item => item.designation_id === designationId)
      if (userList.length > 0) {
         const tmpList = userList.map((obj, index) => {
          return { value: obj.id, text: lng === 'en' ? obj.name : obj.name_bn }
        })
        return tmpList
      } else {
        return []
      }
    },
    getUserList (designationId, item) {
      const userList = this.allUserList.filter(item => item.designation_id === designationId)
      if (userList.length > 0) {
        const tmpList = userList.map((obj, index) => {
          return { value: obj.id, text: obj.name }
        })
        item.employeeList = tmpList
        const tmpListBn = userList.map((obj, index) => {
          return { value: obj.id, text: obj.name_bn }
        })
        item.employeeListBn = tmpListBn
      } else {
        item.employeeList = []
        item.employeeListBn = []
      }
    },
    //  diffYearMonthDay () {
    //   if (this.form.date_from && this.form.date_to) {
    //     const dt1 = new Date(this.form.date_from)
    //     const dt2 = new Date(this.form.date_to)
    //     const time = (dt2.getTime() - dt1.getTime()) / 1000
    //     const divisionNumberForYear = 60 * 60 * 24 * 365
    //     const divisionNumberForMonth = 60 * 60 * 24 * 30
    //     const divisionNumberForDay = 60 * 60 * 24
    //     const year = Math.abs(Math.floor(time / divisionNumberForYear))
    //     const month = Math.abs(Math.floor((time - (year * divisionNumberForYear)) / divisionNumberForMonth))
    //     const days = Math.abs(Math.floor((time - (year * divisionNumberForYear) - (month * divisionNumberForMonth)) / divisionNumberForDay))
    //     this.form.duration_en = year + ' ' + this.$t('research_plan_management.years', 'en') + ', ' + month + ' ' + this.$t('research_plan_management.months', 'en') + ', ' + days + ' ' + this.$t('research_plan_management.days', 'en')
    //     this.form.duration_bn = helpers.convertEnglishToBanglaNumber(year) + ' ' + this.$t('research_plan_management.years', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(month) + ' ' + this.$t('research_plan_management.months', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(days) + ' ' + this.$t('research_plan_management.days', 'bn')
    //   }
    // },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.putData(bftiResReportServiceBaseUrl, assignConsultantUpdate + '/' + this.$route.params.id, this.assignConsultant)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$router.push('/bfti-research-and-report-service/task-activity-monitoring/assign-consultant')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
