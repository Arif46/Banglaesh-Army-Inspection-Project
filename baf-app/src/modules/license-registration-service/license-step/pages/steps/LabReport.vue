<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
        <ValidationObserver ref="Form" v-slot="{ handleSubmit, reset }">
          <b-form  @submit.prevent="handleSubmit(saveLabReport)"  @reset.prevent="reset" >
            <b-overlay :show="saveloading">
              <b-row>
                <b-col lg="12" md="12" sm="12" class="mb-2">
                  <h4>{{ $t('li_step.sample_number') }} : {{ labAssign.sample_number }}</h4>
                </b-col>
                  <b-table-simple  bordered>
                      <thead>
                          <tr class="bg-primary">
                              <th width="100px">{{ $t('globalTrans.sl_no') }}</th>
                              <th>{{ $t('li_step.ingredient_name') }}</th>
                              <th>{{ $t('li_step.upload_report') }}</th>
                          </tr>
                      </thead>
                      <b-tbody>
                          <b-tr v-for="(item, index) in labReport" :key="index">
                              <b-td>
                                  {{ $n(index + 1) }}
                              </b-td>
                              <b-td>
                                  <ValidationProvider vid="ingrident_id">
                                      <b-form-group
                                          slot-scope="{ valid, errors }"
                                      >
                                          <b-form-select
                                              disabled
                                              plain
                                              id="ingrident_id"
                                              v-model="item.ingrident_id"
                                              :options="ingridentList"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-select>
                                          <div class="invalid-feedback">
                                              {{ errors[0] }}
                                          </div>
                                      </b-form-group>
                                  </ValidationProvider>
                              </b-td>
                              <b-td>
                                <span v-if="item.attachment[0] !== ''" class="text-success">
                                  {{ $t('li_step.lab_report_uploaded') }}
                                </span>
                                <span v-else>
                                  <ValidationProvider name="Attachment" vid="attachment">
                                    <b-form-file
                                      placeholder="Choose a file"
                                      :id="item.id"
                                      @input="onFileChange($event, index)"
                                      v-model="item.attachment[0]"
                                    ></b-form-file>
                                  </ValidationProvider>
                                </span>
                              </b-td>
                          </b-tr>
                      </b-tbody>
                  </b-table-simple>
                </b-row>
              <b-row>
              </b-row>
            </b-overlay>
              <div class="row">
                  <div class="col-sm-3"></div>
                    <div class="col text-right">
                        <b-button type="submit" @click="labAssign.save_status = 1" variant="warning" class="mr-2">{{ $t('globalTrans.draft') }}</b-button>
                        &nbsp;
                        <b-button type="submit" @click="labAssign.save_status = 2" variant="primary" class="mr-2">{{ $t('globalTrans.save') }}</b-button>
                        &nbsp;
                      <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-8')">{{ $t('globalTrans.cancel') }}</b-button>
                    </div>
                </div>
          </b-form>
        </ValidationObserver>
      </template>
    </iq-card>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { daeLabReportStore, assignDataApi } from '../../api/routes'
export default {
  props: ['pDatas', 'stepID'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      labAssign: {
        sample_number: '',
        details: [],
        application_id: 0,
        save_status: 1,
        labAssignId: '',
        step_id: this.stepID,
        service_id: '',
        nextStep_id: '',
        designation_id: '',
        sender_id: ''
      },
      labReport: [
        {
          ingrident_id: '',
          attachment: ''
        }
      ],
      saveloading: false
    }
  },
  created () {
    if (this.pDatas) {
      this.labAssignData(this.pDatas.application_id)
      this.labAssign.designation_id = this.$store.state.Auth.authUser.designation_id
      this.labAssign.sender_id = this.pDatas.sender_id
    }
  },
  mounted () {
  },
  watch: {
  },
  computed: {
    local: function () {
        return this.$i18n.locale
    },
    ingridentList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.activeIngredientList.filter(item => item.status === 1)
    }
  },
  methods: {
    labAssignData (applicationID) {
      this.saveloading = true
      const userId = this.$store.state.Auth.authUser.user_id
      const search = {
        officer_id: userId
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, `${assignDataApi}/${applicationID}`, search).then(response => {
        if (response.success) {
          this.getRelationData(response.data)
        }
        this.saveloading = false
      })
    },
    getRelationData (data) {
      data.map((item, index) => {
        this.labReport = []
        this.labAssign.application_id = item.application_id
        this.labAssign.labAssignId = item.id
        this.labAssign.sample_number = item.sample_number
        this.labAssign.service_id = item.service_id
        this.labAssign.nextStep_id = this.getServiceWiseStep(item.service_id, this.stepID)
        item.lab_details.map(item2 => {
          const items = {
            report_id: item2.id,
            ingrident_id: item2.ingrident_id,
            attachment: [item2.attachment]
         }
         this.labReport.push(items)
        })
      })
    },
    async saveLabReport () {
      let result = null
      this.saveloading = true
      const config = {
        headers: { 'content-type': 'multipart/form-data' }
      }
      var formData = new FormData()
      Object.keys(this.labAssign).map(key => {
        formData.append(key, this.labAssign[key])
      })
      this.labReport.forEach(item => {
        Object.keys(item).map(key => {
          if (key === 'report_id') {
            formData.append('report_id[]', item.report_id)
          } else if (key === 'ingrident_id') {
            formData.append('ingrident_id[]', item.ingrident_id)
          } else if (key === 'attachment') {
            formData.append('file[]', item.attachment[0])
          }
        })
      })
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, daeLabReportStore, formData, config)
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-8')
        this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
      } else {
        this.$refs.form.setErrors(result.errors)
      }
     this.saveloading = false
    },
    onFileChange (e, index) {
      this.labReport[index].attachment[0] = e
    },
    getServiceWiseStep (serviceId, stepId) {
        const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(stepId))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
    }
  }
}
</script>
<style scoped>
hr {
    border: none;
    border-top: 3px double #333;
    color: #333;
    overflow: visible;
    text-align: center;
    height: 5px;
}
hr:after {
    background: #fff;
    content: '';
    padding: 0 4px;
    position: relative;
    top: -13px;
}
</style>
