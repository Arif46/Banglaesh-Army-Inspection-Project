<template>
  <b-container fluid>
    <b-overlay>
      <b-col v-if="loading" md="12" lg="12" sm="12">
        <b-overlay :show="true" class="p-5">
          <div class="text-center">
            <h5> {{ $t('externalLrcpn.approveAmountChecking') }} </h5>
          </div>
        </b-overlay>
      </b-col>
      <b-col v-else md="12" lg="12" sm="12">
        <b-card no-body>
          <b-tabs>
            <b-tab :title="$t('boro_import.import_seed_amount')">
              <div class="row">
                <b-col lg="12" sm="12">
                  <div style="background-color: #005B5B;margin-bottom: 5px">
                    <h5 class="text-white ml-2"> {{  $t('boro_import.import_seed_amount') }} </h5>
                  </div>
                  <b-table-simple striped bordered small class="mt-2">
                      <b-tr>
                          <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th>{{ $t('boro_import.variety_name') }}</b-th>
                          <b-th>{{ $t('boro_import.meeting_date') }}</b-th>
                          <b-th>{{ $t('boro_import.meeting_number') }}</b-th>
                          <b-th> {{ $t('boro_import.af_1') }}</b-th>
                          <b-th> {{ $t('boro_import.a_line') }}</b-th>
                          <b-th> {{ $t('boro_import.r_line') }}</b-th>
                          <b-th> {{ $t('boro_import.seed_produce') }}</b-th>
                          <b-th> {{ $t('boro_import.abadi_jomi') }}</b-th>
                          <b-th> {{ $t('boro_import.prev_year_prod') }}</b-th>
                      </b-tr>
                      <b-tr v-for="(item, index) in addmore_updateData" :key="index">
                        <b-td>
                          {{ $n(index + 1) }}
                        </b-td>
                        <b-td v-for="(ditem, dindex) in item" :key="dindex">
                          {{ ditem }}
                        </b-td>
                      </b-tr>
                  </b-table-simple>
                </b-col>
              </div>
            </b-tab>
            <b-tab :title="$t('boro_import.future_seed')">
              <div class="row">
                <b-col lg="12" sm="12">
                  <div style="background-color: #005B5B;margin-bottom: 5px">
                    <h5 class="text-white ml-2"> {{  $t('boro_import.future_seed') }} </h5>
                  </div>
                  <b-table-simple striped bordered small class="mt-2">
                      <b-tr>
                          <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th>{{ $t('boro_import.variety_name') }}</b-th>
                          <b-th>{{ $t('boro_import.variety_indetails') }}</b-th>
                          <b-th> {{ $t('boro_import.af_1') }}</b-th>
                          <b-th> {{ $t('boro_import.a_line') }}</b-th>
                          <b-th> {{ $t('boro_import.r_line') }}</b-th>
                          <b-th> {{ $t('boro_import.abadi_jomi') }}</b-th>
                          <b-th> {{ $t('boro_import.prev_year_prod') }}</b-th>
                          <b-th> {{ $t('boro_import.comment') }}</b-th>
                      </b-tr>
                      <b-tr v-for="(item, index) in addmore_updateData2" :key="index">
                        <b-td>
                          {{ $n(index + 1) }}
                        </b-td>
                        <b-td v-for="(ditem, dindex) in item" :key="dindex">
                          {{ ditem }}
                        </b-td>
                      </b-tr>
                  </b-table-simple>
                </b-col>
              </div>
            </b-tab>
          </b-tabs>
        </b-card>
        <div class="row mt-3">
          <div class="col-md-12 text-right">
            <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('approve-amount-show')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
        </div>
      </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { applicationFormData } from '../../api/routes'
import ExportPdf from './ApproveAmountPdf'

export default {
  props: ['approveAmount'],
  data () {
    return {
        loading: false,
        addmore_updateData: '',
        addmore_updateData2: ''
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    async loadData () {
      const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => item.service_id === this.approveAmount.service_id && item.form_type === 2)
        if (typeof formData !== 'undefined') {
          const formId = formData.form_id
          this.loading = true
          const params = {
            id: formId,
            service_id: this.approveAmount.service_id,
            step_id: this.getGridStep(this.approveAmount.service_id).step_id,
            applicationID: parseInt(this.approveAmount.application_id)
          }
          this.loading = true
          const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, applicationFormData, params)
          this.loading = false
          if (result.success) {
            if (result.data.applicationData[0]) {
              const tableA = result.data.applicationData[0].add_more_update ? JSON.parse(result.data.applicationData[0].add_more_update) : JSON.parse(result.data.applicationData[0].add_more_1575)
              const tableB = result.data.applicationData[0].add_more_update_1 ? JSON.parse(result.data.applicationData[0].add_more_update_1) : JSON.parse(result.data.applicationData[0].add_more_2087)
              this.addmore_updateData = tableA
              this.addmore_updateData2 = tableB
            }
          } else {
            this.addmore_updateData = ''
            this.addmore_updateData2 = ''
          }
        }
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    pdfExport () {
      const reportTitle = this.$i18n.locale === 'en' ? 'Port Wise Allocation Management' : 'বন্দর অনুযায়ী বরাদ্দের ব্যবস্থাপনা'
      ExportPdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, reportTitle, this.addmore_updateData, this.addmore_updateData2, this)
    }
  }
}
</script>
