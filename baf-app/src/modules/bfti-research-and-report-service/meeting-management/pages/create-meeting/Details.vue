<template>
  <div class="section-wrapper">
    <b-overlay :show="loading">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template v-slot:body>
              <b-row class="m-4">
                <b-col md="6" lg="6"> {{ detailsData.memo_no }} </b-col>
                <b-col md="6" lg="6" class="text-right"> Date- {{ todayDate() }}. </b-col>
              </b-row>
              <b-row>
                <b-col md="12 text-center">
                  <h5>
                    {{ ($i18n.locale === 'en') ? detailsData.meeting_title_en : detailsData.meeting_title_bn }} <br />
                    {{ $t('globalTrans.date')}}: {{ formatted(detailsData.meeting_date) }}
                  </h5>
                </b-col>
                <b-col lg="12" sm="12" class="m-4">
                  <div>
                    <p class="text-weight-bold"> {{ $t('meetingManagement.agenda') }}: <br /> </p>
                    <p v-if="$i18n.locale === 'en'" class="text-dark pl-4" v-html="detailsData.agenda_text_en"></p>
                    <p v-else class="text-dark pl-4" v-html="detailsData.agenda_text_bn"></p>
                    <b-table-simple hover small caption-top responsive striped bordered>
                      <b-tr>
                        <b-th>{{ $t('meetingManagement.item') }}</b-th>
                        <b-th>{{ $t('meetingManagement.decision') }}</b-th>
                        <b-th>{{ $t('meetingManagement.update') }}</b-th>
                        <b-th>{{ $t('globalTrans.designation') }}</b-th>
                        <b-th>{{ $t('stakeholder.employee_name') }}</b-th>
                      </b-tr>
                      <template v-for="(head, index) in detailsData.heads">
                        <slot v-for="(detail, index1) in head.details">
                          <b-tr v-if="index1 === 0" :key="index">
                            <b-td colspan="5"><h5>{{ head.head_title_en }}</h5></b-td>
                          </b-tr>
                          <b-tr>
                            <b-td> {{ detail.item }} </b-td>
                            <b-td> {{ detail.decision }} </b-td>
                            <b-td> {{ detail.update }} </b-td>
                            <b-td> {{ getDesignationList(detail.designation_id) }}  </b-td>
                            <b-td> {{ getEmployeeName(detail.employee_user_id) }} </b-td>
                          </b-tr>
                        </slot>
                      </template>
                    </b-table-simple>
                  </div>
                </b-col>
              </b-row>
            </template>
          </body-card>
        </b-col>
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { authServiceBaseUrl, bftiResReportServiceBaseUrl } from '@/config/api_config'
import { userListByDesignWise, detailsDataApi } from '../../api/routes'
import ExportPdf from './export_pdf_details'

export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      errors: [],
      detailsData: [],
      officer: {},
      allUserList: []
    }
  },
  created () {
    this.getAllUserList()
    if (this.id) {
      const tmp = this.DetailsData()
      this.detailsData = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    getAllUserList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allUserList = response.data
        }
      })
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
    },
    DetailsData () {
      const loadingState = { loading: true, listReload: true }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { id: this.id })
      RestApi.getData(bftiResReportServiceBaseUrl, detailsDataApi, params).then(response => {
        if (response.success) {
          this.detailsData = response.data
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    getDesignationList (id) {
      const data = this.$store.state.CommonService.commonObj.designationList.find(desig => desig.value === parseInt(id))
      return data !== undefined ? data.text : ''
    },
    pdfExport () {
      const reportTitle = this.$t('meetingManagement.meeting_information') + ' ' + this.$t('globalTrans.details')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.detailsData, this.todayDate(), this.formatted(this.detailsData.meeting_date))
    },
    formatted (value) {
      return new Date(value).toLocaleString(this.$i18n.locale + '-GB', {
        day: 'numeric', // numeric, 2-digit
        year: 'numeric', // numeric, 2-digit
        month: 'long' // numeric, 2-digit, long, short, narrow
      })
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.toString().replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.toString().replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    todayDate () {
      const today = new Date().toISOString().slice(0, 10)
      return this.formatted(today)
    },
    getEmployeeName (empID) {
      const empData = this.allUserList.find(user => user.id === empID)
      if (empData) {
        if (this.$i18n.locale === 'en') {
          return empData.name
        } else {
          return empData.name_bn
        }
      }
    }
  }
}
</script>
