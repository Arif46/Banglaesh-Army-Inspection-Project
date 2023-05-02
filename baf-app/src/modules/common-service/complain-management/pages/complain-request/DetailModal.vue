<template>
  <b-container fluid>
      <b-row>
        <b-col lg="12" sm="12">
          <iq-card>
            <template>
              <b-row>
                <b-col lg="12" sm="12" class="text-center mb-4">
                  <h5 class='complain-title'>{{ $t('complain_management.complian_details') }}</h5>
                </b-col>
              </b-row>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-row>
                      <b-col lg="3" sm="12">
                        <p class="text-dark" >{{ $t('complain_management.com_title') }}</p>
                      </b-col>
                      <b-col lg="9" sm="12">
                         <p class="text-dark">{{ (this.$i18n.locale=='bn') ? complain_detail.com_title_bn : complain_detail.com_title }}</p>
                      </b-col>
                    </b-row>
                    <b-row>
                      <b-col lg="3" sm="12">
                        <p class="text-dark" >{{ $t('globalTrans.description') }}</p>
                      </b-col>
                      <b-col lg="9" sm="12">
                        <p class="text-dark"  v-html="(this.$i18n.locale=='bn') ? complain_detail.description_bn : complain_detail.description"></p>
                      </b-col>
                    </b-row>
                    <b-row>
                      <b-col lg="12" sm="12">
                        <div>
                          <b-table striped small bordered hover :items="columns"  thead-class="hidden_header"></b-table>
                        </div>
                      </b-col>
                    </b-row>
                  </b-col>
                </b-row>
                <b-row>
                <b-col lg="12" sm="12" class="text-center mb-4">
                  <h5 class='complain-title'>{{ $t('complain_management.committee_list') }}</h5>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" sm="12">
                  <div>
                    <b-table bordered hover small :items="committeesList" :fields="committees"  aria-hidden="loading | listReload ? 'true' : null">
                      <template v-slot:cell(index)="data">
                        {{ $n(data.index + slOffset) }}
                      </template>
                    </b-table>
                  </div>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" sm="12" class="text-center">
                  <h5 class='complain-title'>{{ $t('complain_management.committee_report') }}</h5>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" sm="12">
                  <b-row  v-for="(committeeReport,index) in getCommitteeReports" :key="index" class="mt-3">
                    <b-col lg="1" sm="1">
                      <div class="text-right">
                        <b-img width="40px" class="text-right mt-2" src="/images/user_icon.png" alt="Responsive image"></b-img>
                      </div>
                    </b-col>
                    <b-col lg="11" sm="11">
                      <div>
                        <b-card class="card-border card-report">
                          <h5 class="report-name">{{ $i18n.locale === 'en' ? committeeReport.name : committeeReport.name_bn }}</h5>
                          <span class="badge badge-success">{{ $i18n.locale === 'en' ? committeeReport.designation : committeeReport.designation_bn }}</span><span class="ml-2 text-dark"><i class="ri-calendar-line text-info"></i> {{ committeeReport.created_at | dateFormat}}</span>
                          <p class="text-dark" >{{ ($i18n.locale == 'bn') ? committeeReport.report_note_bn : committeeReport.report_note }}</p>
                          <a v-if="committeeReport.attachment" target="_blank" class="btn btn-primary btn-sm my-btn" :href=" base_url + 'download-attachment?file=uploads/complain/report/original/'+ committeeReport.attachment"><i class="ri-download-cloud-line"> File</i></a>
                        </b-card>
                      </div>
                    </b-col>
                  </b-row>

                </b-col>
              </b-row>
            </template>
          </iq-card>
        </b-col>
      </b-row>
    </b-container>
</template>
<script>
import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '../../../../../config/api_config'
import { getCommitteeList, getCommitteeReport } from '../../api/routes'
export default {
  name: 'FormLayout',
  props: ['id'],
  created () {
    this.getUserList()
    // this.getCommitteesReport()
    if (this.id) {
      const tmp = this.getComplainInfo()
      Object.freeze(tmp)
      this.complain_detail = tmp
    }
  },
  data () {
    return {
      complain_detail: '',
      slOffset: 1,
      committeesList: [],
      userList: [],
      getCommitteeReports: [],
      base_url: commonServiceBaseUrl
    }
  },
  computed: {
    columns () {
      if (this.$i18n.locale === 'bn') {
        return [
          { key: this.$t('globalTrans.organization'), val: this.complain_detail.org_name_bn, key1: this.$t('moc_portal.service'), val1: this.complain_detail.service_name_bn },
          { key: this.$t('globalTrans.division'), val: this.complain_detail.division_name_bn, key1: this.$t('globalTrans.district'), val1: this.complain_detail.district_name_bn },
          { key: this.$t('globalTrans.upazila'), val: this.complain_detail.upazilla_name_bn, key1: this.$t('globalTrans.union'), val1: this.complain_detail.union_name_bn },
          { key: this.$t('globalTrans.mobile'), val: this.$n(this.complain_detail.mobile_no), key1: this.$t('globalTrans.email'), val1: this.complain_detail.email }
        ]
      } else {
          return [
            { key: this.$t('globalTrans.organization'), val: this.complain_detail.org_name, key1: this.$t('moc_portal.service'), val1: this.complain_detail.service_name },
            { key: this.$t('globalTrans.division'), val: this.complain_detail.division_name, key1: this.$t('globalTrans.district'), val1: this.complain_detail.district_name },
            { key: this.$t('globalTrans.upazila'), val: this.complain_detail.upazilla_name, key1: this.$t('globalTrans.union'), val1: this.complain_detail.union_name },
            { key: this.$t('globalTrans.mobile'), val: this.complain_detail.mobile_no, key1: this.$t('globalTrans.email'), val1: this.complain_detail.email }
          ]
      }
    },
    committees () {
       const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('globalTrans.name'), class: 'text-center' },
          { label: this.$t('globalTrans.designation'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'name_bn' },
          { key: 'designation_bn' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'name' },
          { key: 'designation' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    }
  },
  methods: {
    getComplainInfo () {
      return this.$store.state.Complain.complainRequestList.find(item => item.id === this.id)
    },
    async getCommitteesReport () {
      const result = await RestApi.getData(commonServiceBaseUrl, `${getCommitteeReport}/${this.id}`)
      if (result.success) {
        this.getCommitteeReports = this.getRelationalUser(result.data)
      }
    },
    getRelationalUser (data) {
      const designationList = this.$store.state.commonObj.designationList
      const listData = data.map(item => {
        const userObj = this.userList.find(user => user.user_id === item.created_by)
        const userData = { name: userObj.name, name_bn: userObj.name_bn }
        const designationObj = designationList.find(designation => designation.value === userObj.designation_id)
        const designatioinData = { designation: designationObj.text_en, designation_bn: designationObj.text_bn }
        return Object.assign({}, item, userData, designatioinData)
      })
      return listData
    },
    async getCommiteeList () {
      const result = await RestApi.getData(commonServiceBaseUrl, `${getCommitteeList}/${this.id}`)
      if (result.success) {
        this.committeesList = this.formatList(result.data)
      }
    },
    formatList (data) {
      const designationList = this.$store.state.commonObj.designationList
      const listData = data.map(item => {
        const userObj = this.userList.find(user => user.user_id === item.user_id)
        const userData = { name: userObj.name, name_bn: userObj.name_bn }
        const designationObj = designationList.find(designation => designation.value === item.designation_id)
        const designatioinData = { designation: designationObj.text_en, designation_bn: designationObj.text_bn }
        return Object.assign({}, item, userData, designatioinData)
      })
      return listData
    },
    getUserList () {
        RestApi.getData(authServiceBaseUrl, 'user/userListRoleOnly')
        .then(response => {
          if (response.length > 0) {
            this.getCommiteeList()
            this.getCommitteesReport()
          }
            this.userList = response
        })
    },
    getUserByUserId (userId) {
        const designationList = this.$store.state.commonObj.designationList
        RestApi.getData(authServiceBaseUrl, 'user/getUserByUserId/' + userId)
        .then(response => {
            const designationObject = designationList.filter(designation => designation.value === response.designation_id)
            this.designationList = designationObject.map((obj, index) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.value, text: obj.text_bn }
                } else {
                    return { value: obj.value, text: obj.text }
                }
            })
        })
    }
  }
}
</script>
<style>
  .hidden_header {
    display: none
  }
  .card-border {
    border: 1px solid #b9bdc1;
    box-shadow: 1px 1px 6px -1px grey;
    background-color: #dee2e6;
  }
  [dir=ltr][mode=light] .card-body {
    flex: 1 1 auto;
    min-height: 1px;
    padding: 10px;
  }
  .report-name{
    font-weight: bold !important;
    text-transform: uppercase;
  }
  .my-btn{
    padding: 2px !important;
  }
</style>
