<template>
  <b-row>
   <b-row>
        <b-col lg="12" sm="12">
          <iq-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-overlay :show="loading">
                      <b-row>
                        <b-col lg="12" sm="12">
                          <div>
                            <b-table-simple hover small caption-top responsive striped bordered  v-if="showInternalOrg">
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('stakeholder.org_category') }}</b-th>
                                  <b-td style="width:25%">{{ getOrgCat(detailsData.organization_category) }}</b-td>
                                  <b-th style="width:25%">{{ $t('organogram.org') }}</b-th>
                                  <b-td style="width:25%">{{ getInternalOrg(detailsData.organization_id)}}</b-td>
                                </b-tr>
                            </b-table-simple>
                            <b-table-simple hover small caption-top responsive striped bordered  v-if="showExternalOrg">
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('stakeholder.org_category') }}</b-th>
                                  <b-td style="width:25%">{{  getOrgCat(detailsData.organization_category) }}</b-td>
                                  <b-th style="width:25%">{{ $t('stakeholder.org_type') }}</b-th>
                                  <b-td style="width:25%">{{ getOrgType(detailsData.organization_type_id) }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('stakeholder.org_sub_type') }}</b-th>
                                  <b-td style="width:25%">{{ getOrgSubHead(detailsData.organization_sub_type_id) }}</b-td>
                                  <b-th style="width:25%">{{ $t('organogram.org') }}</b-th>
                                  <b-td style="width:25%">{{  ($i18n.locale === 'bn') ? detailsData.org_name_bn : detailsData.org_name }}</b-td>
                                </b-tr>
                            </b-table-simple>
                            <template>
                              <div style="font-size:18px; background-color: #5f90c3">
                              <h5 class="text-white text-center">
                                  {{ $t('stakeholder.stakeholder_info') }}
                              </h5>
                              </div>
                          </template>
                             <b-table-simple hover small caption-top responsive striped bordered>
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('globalTrans.name_en') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.stakeholder_name_en }}</b-td>
                                  <b-th style="width:25%">{{ $t('globalTrans.name_bn') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.stakeholder_name_bn }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('globalTrans.designation') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.stakeholder_designation }}</b-td>
                                  <b-th style="width:25%">{{ $t('globalTrans.designation_bn') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.stakeholder_designation_bn }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('globalTrans.email') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.email }}</b-td>
                                  <b-th style="width:25%">{{ $t('stakeholder.contact_no') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.contact_no }}</b-td>
                                </b-tr>
                                <b-tr>
                                  <b-th style="width:25%">{{ $t('globalTrans.address') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.address }}</b-td>
                                  <b-th style="width:25%">{{ $t('globalTrans.address_bn') }}</b-th>
                                  <b-td style="width:25%">{{ detailsData.address_bn }}</b-td>
                                </b-tr>
                            </b-table-simple>
                            <template>
                              <div style="font-size:18px; background-color: #5f90c3">
                              <h5 class="text-white text-center">
                                  {{ $t('stakeholder.follow_up') }}
                              </h5>
                              </div>
                          </template>
                            <b-table-simple hover small caption-top responsive striped bordered>
                              <b-tr>
                                <b-th style="width:25%">{{ $t('globalTrans.designation') }}</b-th>
                                <b-td style="width:25%">{{ getDesignationList(detailsData.designation) }}</b-td>
                                <b-th style="width:25%">{{ $t('stakeholder.employee_name') }}</b-th>
                                <b-td style="width:25%">{{ getEmployeeName(detailsData.employee_name) }}</b-td>
                              </b-tr>
                            </b-table-simple>
                          </div>
                        </b-col>
                      </b-row>
                    </b-overlay>
                  </b-col>
              </b-row>
            </template>
          </iq-card>
        </b-col>
      </b-row>
  </b-row>
</template>
<script>
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { userListByDesignWise } from '../../api/routes'

export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      showExternalOrg: false,
      showInternalOrg: false,
      valid: null,
      loading: false,
      errors: [],
      detailsData: [],
      officer: {},
      orgTypeList: [
        { value: 1, text: 'MOC' },
        { value: 2, text: 'other' }
      ],
      allUserList: []
    }
  },
  created () {
    this.getAllUserList()
  },
  methods: {
    getAllUserList () {
      this.loading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allUserList = response.data
          if (this.id) {
            const tmp = this.getDetailsData()
            this.detailsData = tmp
            this.orgShow()
            this.loading = false
          }
        }
      })
    },
    getDetailsData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    orgShow () {
      if (this.detailsData.organization_category === 1) {
        this.showExternalOrg = false
        this.showInternalOrg = true
      }
      if (this.detailsData.organization_category === 2) {
        this.showInternalOrg = false
        this.showExternalOrg = true
      }
    },
    getOrgCat (id) {
      const data = this.orgTypeList.find(orgCat => orgCat.value === id)
      return data !== undefined ? data.text : ''
    },
    getInternalOrg (id) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.organizationNameList.find(orgCat => orgCat.value === id)
      return data !== undefined ? data.text : ''
    },
    getOrgType (id) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList.find(orgCat => orgCat.value === id)
      return data !== undefined ? data.text : ''
    },
    getOrgSubHead (id) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.find(orgCat => orgCat.value === id)
      return data !== undefined ? data.text : ''
    },
    getOrg (id) {
      const data = this.$store.state.CommonService.commonObj.componentOrgList.find(orgCat => orgCat.value === id)
      return data !== undefined ? data.text : ''
    },
    getDesignationList (id) {
      const data = this.$store.state.CommonService.commonObj.designationList.find(desig => desig.value === parseInt(id))
      return data !== undefined ? data.text : ''
    },
    getEmployeeName (empID) {
      const empData = this.allUserList.find(user => user.id === parseInt(empID))
      if (empData) {
        return empData.name
      }
    }
  }
}
</script>
