<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.proposal_no')}} </b> : {{ items.program?.proposal?.proposal_id }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.program_no')}} </b> : {{ $n(items.proposal_detail_id, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.program_name')}} </b> : {{ currentLocale === 'bn' ? items.program.programe_name_bn : items.program.programe_name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.start_date')}} </b> : {{ items.start_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.end_date')}} </b> : {{ items.end_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.status')}} </b> : {{ statusText(items.status) }}
            </b-col>
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
      <b-card>
        <b-row>
          <b-col xs="12" sm="12" md="12">
          <!-- Budget Details Start -->
          <div v-if="employeeList.length > 0" class="table-wrapper table-responsive">
               <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr class="bg-primary">
                                <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.organization') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.designation') }}</div></th>
                                <th scope="col" style="width: 15%;" class="text-center"><div>{{ $t('eBizProgram.employee') }}</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="items.investigators?.length > 0">
                                <tr v-for="(item, index) in items.investigators" :key="index">
                                    <td  class="text-center">{{ index+1 }}</td>
                                    <td  class="text-center">{{ getOrgnizationName(item.org_id) }}</td>
                                    <td  class="text-center">{{ getDesignation(item.org_id,item.designation_id) }}</td>
                                    <td  class="text-center">{{ getEmployee(item.employee_id) }}</td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                </tr>
                            </template>
                        </tbody>
                  </table>
          </div>
          <div v-else class="text-center">
          <span>Loading...</span>
            <!-- <b-spinner label="Spinning"></b-spinner> -->
          </div>
          <!-- Budget Details End -->
          </b-col>
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
    </b-overlay>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('investigator-view')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { designationWiseUser } from '../../api/routes'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      valid: null,
      investigators: [],
      employeeList: [],
      loading: false
    }
  },
  created () {
    if (this.items.id) {
      this.getEmployeeList(0, 8)
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    requestStatusList: function () {
      const list = [
            { value: 1, text: this.$i18n.locale === 'en' ? 'Draft' : 'খসড়া' },
            { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ' },
            { value: 3, text: this.$i18n.locale === 'en' ? 'Processing' : 'প্রক্রিয়াধীন' },
            { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত' },
            { value: 5, text: this.$i18n.locale === 'en' ? 'Agreement' : 'চুক্তি' }
            ]
           return list
    }
  },
  methods: {
        cipTradeRejectId () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
         getEmployee (empId) {
            const empObj = this.employeeList.find(item => item.value === empId)
            if (empObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return empObj.text_bn
              } else {
                  return empObj.text_en
              }
            }
          },
         getDesignation (orgId, desigId) {
            const desigObj = this.$store.state.CommonService.commonObj.designationList.find(item => item.status === 1 && item.org_id === orgId && item.value === desigId)
            if (desigObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return desigObj.text_bn
              } else {
                  return desigObj.text_en
              }
            }
          },
         getOrgnizationName (orgId) {
          const cateObj = this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).find(item => item.value === orgId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
        },
        statusText (sta) {
          const reqStatusObj = this.requestStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
        },
      async getEmployeeList (designationId, officeId) {
      this.officerLoading = true
        const params = {
          org_id: parseInt(officeId),
          designation_id: parseInt(designationId)
        }
        await RestApi.getData(eBizServiceBaseUrl, designationWiseUser, params)
        .then(response => {
          if (response.success) {
            const data = response.data
            this.employeeList = data.map(item => {
              return Object.assign({ value: item.user_id, text: this.$i18n.locale === 'bn' ? item.name_bn : item.name, text_bn: item.name_bn, text_en: item.name })
            })
          } else {
            this.employeeList = []
          }
          this.officerLoading = false
      })
    }
    }
}
</script>
