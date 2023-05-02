<template>
  <div class="inner-section">
      <b-overlay :show="loading">
        <card>
          <template v-slot:searchHeaderTitle>
            <h4 class="card-title">{{ $t('research_plan_management.general_information') }}</h4>
          </template>
          <template v-slot:searchHeaderAction>
            <router-link class="btn-add" to="/bfti-research-and-report-service/research-plan-preparation/prepare-eoi"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
          </template>
          <template v-slot:searchBody>
            <b-row>
              <b-table-simple>
                <b-tr>
                  <b-th>{{ $t('globalTrans.title') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.title_bn : form.title }}</b-td>
                  <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.organization_ministry_division_bn : form.organization_ministry_division }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.agency') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.agency_bn : form.agency }}</b-td>
                  <b-th>{{ $t('research_plan_management.name_of_procuring_entity') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.name_of_procuring_entity_bn : form.name_of_procuring_entity }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{$t('research_plan_management.procuring_entity')}} {{$t('globalTrans.division')}}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ getDivision(form.division_id) }}</b-td>
                  <b-th>{{$t('research_plan_management.procuring_entity')}}  {{$t('globalTrans.district')}}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ getDistrict(form.district_id) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.expression_of_interest_for') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.expression_of_interest_for_bn : form.expression_of_interest_for }}</b-td>
                  <b-th>{{$t('research_plan_management.eoi_reference_no')}}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.eoi_reference_no }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('globalTrans.date') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.eio_date| dateFormat }}</b-td>
                  <b-th></b-th>
                  <b-th class="text-center"></b-th>
                  <b-td></b-td>
                </b-tr>
              </b-table-simple>
            </b-row>
          </template>
        </card>
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('research_plan_management.key_information') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-table-simple style="width:50%">
                <b-tr>
                  <b-th>{{ $t('research_plan_management.procurement_method') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.procurement_method_bn : form.procurement_method }}</b-td>
                  <b-th></b-th>
                  <b-th class="text-center"></b-th>
                  <b-td></b-td>
                </b-tr>
              </b-table-simple>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('research_plan_management.funding_information') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-table-simple>
                <b-tr>
                  <b-th style="width:20%">{{ $t('research_plan_management.budget_and_source_of_fund') }}</b-th>
                  <b-th class="text-center" style="width:3%">:</b-th>
                  <b-td style="width:25%">{{ ($i18n.locale === 'bn') ? form.budget_and_source_of_fund_bn : form.budget_and_source_of_fund }}</b-td>
                  <b-th style="width:25%">{{ $t('research_plan_management.development_partners_if_applicable') }}</b-th>
                  <b-th class="text-center" style="width:3%">:</b-th>
                  <b-td style="width:35%">{{ ($i18n.locale === 'bn') ? form.development_partners_if_applicable_bn : form.development_partners_if_applicable }}</b-td>
                </b-tr>
              </b-table-simple>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('research_plan_management.particular_information') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-table-simple>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.program_code') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.program_code }}</b-td>
                  <b-th>{{ $t('research_plan_management.program_name') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.program_name_bn : form.program_name }}</b-td>
                </b-tr>
              </b-table-simple>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('research_plan_management.procuring_entity_details_official_inviting_eio') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-table-simple>
                <b-tr>
                  <b-th>{{ $t('globalTrans.name') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.eoi_details.name_bn : form.eoi_details.name }}</b-td>
                  <b-th>{{ $t('globalTrans.designation') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.eoi_details.designation_bn : form.eoi_details.designation }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('globalTrans.address') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.eoi_details.address_bn : form.eoi_details.address }}</b-td>
                  <b-th>{{ $t('globalTrans.contact_no') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.eoi_details.contact_no | mobileNumber }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('globalTrans.email') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.eoi_details.email }}</b-td>
                  <b-th>{{ $t('bfti.attachment') }}</b-th>
                  <b-th class="text-center">:</b-th>
                   <b-td>
                    <a v-if="form.eoi_details.attachment" class="btn btn-success btn-sm rounded-pill mr-1" target="_blank" :href="baseUrl + 'download-attachment?file=' + form.eoi_details.attachment" title="attachment"><i class="ri-download-cloud-fill"></i></a>
                    <a target="_blank" v-if="form.eoi_details.attachment" :href="baseUrl + form.eoi_details.attachment">{{ $t('bfti.attachment_down')}}</a>
                  </b-td>
                </b-tr>
              </b-table-simple>
            </b-row>
          </template>
        </body-card>
      </b-overlay>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { prepareEioShow } from '../../api/routes'
export default {
  name: 'Form',
  data () {
    return {
      valid: null,
      errors: [],
      baseUrl: bftiResReportServiceBaseUrl,
      form: {
        title: '',
        title_bn: '',
        organization_ministry_division: '',
        organization_ministry_division_bn: '',
        agency_bn: '',
        agency: '',
        division_id: 0,
        district_id: 0,
        attachment: [],
        eoi_details: {
          name: '',
          name_bn: '',
          designation: '',
          address: '',
          contact_no: '',
          email: ''
        }
      },
      districtList: []
    }
  },
  created () {
    if (this.$route.params.id) {
      this.loadData()
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    async loadData () {
      const loadingState = { loading: true, listReload: false }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, prepareEioShow + '/' + this.$route.params.id)
      if (result.success) {
        this.form = result.data
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getDistrict (districtId) {
      const data = this.$store.state.CommonService.commonObj.districtList.find(doc => doc.value === districtId)
      return data !== undefined ? data.text : ''
    },
    getDivision (divisionId) {
      const data = this.$store.state.CommonService.commonObj.divisionList.find(doc => doc.value === divisionId)
      return data !== undefined ? data.text : ''
    },
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
