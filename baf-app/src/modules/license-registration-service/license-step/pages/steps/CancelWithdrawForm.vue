<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <iq-card>
          <template v-slot:body>
            <b-overlay :show="loading">
              <b-row>
                <b-col lg="12" sm="12">
                  <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                    <b-form  @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                      <b-row>
                        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                          <ValidationProvider name="Application ID" vid="application_id" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="4"
                                label-for="application_id"
                                slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.application_id') }}  <span class="text-danger">*</span>
                            </template>
                              <b-form-input
                                id="application_id"
                                v-model="formData.application_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ nullMsz }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                          <b-button type="button" variant="primary" @click="searchApplication">{{ $t('globalTrans.search') }}</b-button>
                        </b-col>
                      </b-row>
                      <b-row v-if="listShow">
                        <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                          <template>
                            <div style="font-size:18px; background-color: #66CC99; text-align:center" class="mb-3">
                              <h5 class="text-white"> {{ $t('bsri_demandDIS.general_info') }}</h5>
                            </div>
                          </template>
                        </b-col>
                      </b-row>
                      <b-row  v-if="listShow">
                        <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                          <b-table-simple striped bordered small class="mt-2">
                            <b-thead>
                              <tr>
                                <b-th>{{ $t('globalTrans.application_id') }}</b-th>
                                <b-td> {{ applicationInfo.application_id }} </b-td>
                                <b-th>{{ $t('globalTrans.organization') }}</b-th>
                                <b-td> {{ getOrgName(applicationInfo.org_id) }} </b-td>
                              </tr>
                              <tr>
                                <b-th>{{ $t('service_name.service_name') }}</b-th>
                                <b-td> {{ getServiceName(applicationInfo.service_id) }} </b-td>
                                <b-th>{{ $t('step_name.step_name') }}</b-th>
                                <b-td> {{ getStepName(applicationInfo.current_step) }} </b-td>
                              </tr>
                              <!-- <tr>
                                <b-th>{{ $t('globalTrans.division') }}</b-th>
                                <b-td> {{ getStepName(applicationInfo.current_step) }} </b-td>
                                <b-th>{{ $t('globalTrans.district') }}</b-th>
                                <b-td> {{ 'Ministry' }} </b-td>
                              </tr> -->
                              <!-- <tr>
                                <b-th>{{ $t('globalTrans.city_corporation') }}</b-th>
                                <b-td> {{ 5465464 }} </b-td>
                                <b-th>{{ $t('globalTrans.upazila') }}</b-th>
                                <b-td> {{ 'Ministry' }} </b-td>
                              </tr> -->
                              <tr>
                                <b-th>{{ $t('org_pro.office_type') }}</b-th>
                                <b-td> {{ getOfficeTypeName(applicationInfo.office_type_id) }} </b-td>
                                <b-th>{{ $t('globalTrans.office') }}</b-th>
                                <b-td> {{ getOfficeName(applicationInfo.office_id) }} </b-td>
                              </tr>
                              <tr>
                                <b-th> {{ $t('globalTrans.status') }} </b-th>
                                <b-td> {{ getStatus(applicationInfo.status) }} </b-td>
                              </tr>
                            </b-thead>
                            <b-tbody>
                            </b-tbody>
                          </b-table-simple>
                        </b-col>
                      </b-row>
                      <b-row  v-if="listShow">
                        <b-col>
                          <div class="col text-right">
                            <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                              &nbsp;
                            <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-4')">{{ $t('globalTrans.cancel') }}</b-button>
                          </div>
                        </b-col>
                      </b-row>
                    </b-form>
                  </ValidationObserver>
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </iq-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { applicationInfocancel, applicationInfowithdraw, licenseCancel, licenseWithdraw } from '../../api/routes'

export default {
    props: ['id', 'formType'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
    data () {
        return {
            loading: false,
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            formData: {
              application_id: ''
            },
            applicationInfo: [],
            listShow: false,
            nullMsz: ''
        }
    },
    created () {
        if (this.id) {
            const tmp = this.getEditingData()
            this.formData = tmp
        }
    },
    computed: {
        locale: function () {
            return this.$i18n.locale
        }
    },
    methods: {
        getEditingData () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        searchApplication () {
          if (this.formData.application_id === '') {
            this.nullMsz = 'Please Enter Valid Application'
            return true
          }
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            this.loading = true
            let Api = ''
            if (this.formType === 1) {
              Api = applicationInfocancel
            } else {
              Api = applicationInfowithdraw
            }
            RestApi.getData(licenseRegistrationServiceBaseUrl, `${Api}/${this.formData.application_id}`).then(response => {
            if (response.success) {
              this.listShow = true
              this.applicationInfo = response.data
            } else {
              this.$toast.error({
                title: 'Error',
                message: response.message
              })
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false })
            this.loading = false
            })
        },
        async saveData () {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          this.loading = true

          let Api = ''
          if (this.formType === 1) {
            Api = licenseCancel
          } else {
            Api = licenseWithdraw
          }

          result = await RestApi.getData(licenseRegistrationServiceBaseUrl, Api, this.formData)

          if (result.success) {
              loadingState.listReload = true
              this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
              })

              this.$bvModal.hide('modal-4')
          } else {
            this.$refs.form.setErrors(result.errors)
          }
          this.$store.dispatch('mutateCommonProperties', loadingState)
        },
        getServiceName (sId) {
          const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === sId)
          return service !== undefined ? service.text : ''
        },
        getStepName (stId) {
          const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
          return step !== undefined ? step.text : ''
        },
        getOrgName (orgId) {
          const tmpOrg = this.$store.state.commonObj.organizationProfileList.find(org => org.value === orgId)
          return this.$i18n.locale === 'en' ? tmpOrg !== undefined ? tmpOrg.text_en : '' : tmpOrg !== undefined ? tmpOrg.text_bn : ''
        },
        getOfficeTypeName (offTypeId) {
          const offType = this.$store.state.commonObj.officeTypeList.find(item => item.value === offTypeId)
          return this.$i18n.locale === 'en' ? offType !== undefined ? offType.text_en : '' : offType !== undefined ? offType.text_bn : ''
        },
        getOfficeName (offId) {
          const offObj = this.$store.state.commonObj.officeList.find(item => item.value === offId)
          return this.$i18n.locale === 'en' ? offObj !== undefined ? offObj.text_en : '' : offObj !== undefined ? offObj.text_bn : ''
        },
        getStatus (status) {
          if (status === 0) {
            return this.$t('globalTrans.pending')
          } else if (status === 2) {
            return this.$t('globalTrans.approve')
          } else if (status === 2) {
            return this.$t('globalTrans.reject')
          } else if (status === 3) {
            return this.$t('globalTrans.processing')
          } else if (status === 4) {
            return this.$t('globalTrans.cancel')
          } else if (status === 5) {
            return this.$t('globalTrans.withdraw')
          } else if (status === 6) {
            return this.$t('globalTrans.transfer')
          }
        }
    }
}
</script>
