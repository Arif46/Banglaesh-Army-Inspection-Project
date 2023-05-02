<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('license_management.forward') }}</h4>
            </template>
            <template v-slot:body>
              <b-overlay :show="loading">
                <b-row>
                  <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="Step Name" vid="step_id" rules="required">
                      <b-form-group
                        class="row"
                        label-cols-sm="3"
                        label-for="step_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('step_name.step_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.step_id"
                          :options="stepList"
                          id="step_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="12" sm="12">
                    <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                      <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                        <b-row>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="office_type_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('userManagement.office_type')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.office_type_id"
                                    :options="officeTypeList"
                                    id="office_type_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Office Id" vid="office_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="office_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('globalTrans.office')}}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.office_id"
                                    :options="officeList"
                                    id="office_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Designation Id" vid="designation_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="designation_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('organogram.designation')}}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.designation_id"
                                    :options="designationList"
                                    id="designation_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value="0">{{ designationLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Officer" vid="receiver_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="3"
                                    label-for="receiver_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('priceMonitoring.officer_name')}}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.receiver_id"
                                    :options="officerList"
                                    id="receiver_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value="0">{{ officerLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Note (EN)" vid="note_en"  rules="required">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="note_en"
                                  slot-scope="{ valid, errors }"
                              >
                                  <template v-slot:label>
                                      {{ $t('license_management.note_en') }}  <span class="text-danger">*</span>
                                  </template>
                                  <b-form-textarea
                                      v-model="form.note_en"
                                      id="note_en"
                                      rows=3
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                  </b-form-textarea>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="Note (BN)" vid="note_bn">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="note_bn"
                                  slot-scope="{ valid, errors }"
                              >
                                  <template v-slot:label>
                                      {{ $t('license_management.note_bn') }}
                                  </template>
                                  <b-form-textarea
                                      plain
                                      rows="3"
                                      v-model="form.note_bn"
                                      id="note_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                  </b-form-textarea>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col lg="6" sm="12">
                            <ValidationProvider name="attachment" vid="attachment">
                              <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="attachment"
                                slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                {{ $t('globalTrans.attachment') }}
                                </template>
                                <b-form-file
                                  id="attachment"
                                  name="attachment"
                                  v-model="form.attachment"
                                  v-on:change="onChange"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                        <div class="row">
                          <div class="col-8 offset-4" sm="12">
                              <div class="text-right">
                                  <b-button type="submit" variant="primary" class="mr-2 btn-sm">{{ $t('globalTrans.save') }}</b-button>
                                  &nbsp;
                                  <b-button variant="danger" class="mr-1 btn-sm" @click="back()">{{ $t('globalTrans.cancel') }}</b-button>
                              </div>
                          </div>
                        </div>
                      </b-form>
                    </ValidationObserver>
                  </b-col>
                </b-row>
              </b-overlay>
            </template>
          </body-card>
        </card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
import { tcbCommonForward, designationWiseUser } from '../api/routes'

export default {
  components: {
  },
  data () {
    return {
      loading: false,
      designationLoading: false,
      officerLoading: false,
      form: {
        org_id: 7,
        office_type_id: '0',
        office_id: '0',
        designation_id: '0',
        note_en: '',
        note_bn: '',
        step_id: '0',
        receiver_id: '0',
        status: 0,
        attachment: ''
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      officerList: [],
      assignDesignationList: [],
      attachmentDemo: []
    }
  },
  created () {
    this.form.step_id = this.$route.query.stepId
    this.officeTypeList = this.getOfficeTypeList(7)
    this.getAssignDesignationList()
    this.setOrgAndOffice()
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getParentOfficeList(newVal)
      }
    },
    'form.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getDesignationList(newVal)
      }
    },
    'form.designation_id': function (newVal) {
      this.getOfficerList(newVal)
    },
    'form.step_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.form.step_id = newVal
      }
    }
  },
  computed: {
    stepList () {
      const tcbStep = this.$store.state.LicenseRegistrationService.commonObj.tcbStepList.filter(item => item.value !== 5)
      const tcbStepList = tcbStep.map(item => {
        return this.$i18n.locale === 'bn' ? { value: item.value, text: item.text_bn } : { value: item.value, text: item.text_en }
      })
      return tcbStepList
    },
    applicationIds () {
      return this.$route.query.applications
    }
  },
  methods: {
    onChange (e) {
      const selectedFile = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form[e.target.name] = event.target.result
      }
      reader.readAsDataURL(selectedFile)
    },
    back () {
      this.$router.go(-1)
    },
    setOrgAndOffice () {
        const ownorg = this.$store.state.Auth.authUser.org_id
        const ownofficetype = this.$store.state.Auth.authUser.office_type_id
        const ownoffice = this.$store.state.Auth.authUser.office_id
        this.form.org_id = ownorg
        this.form.office_type_id = ownofficetype
        this.form.office_id = ownoffice
    },
    getOfficeTypeList (orgId = null) {
      const officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1)
      if (orgId) {
          return officeTypeList.filter(office => office.org_id === orgId).map(obj => {
              if (this.$i18n.locale === 'bn') {
                  return { value: obj.value, text: obj.text_bn }
              } else {
                  return { value: obj.value, text: obj.text }
              }
          })
      }
      return officeTypeList
    },
    async saveData () {
        this.loading = true
        var formData = new FormData()
        Object.keys(this.form).map(key => {
          formData.append(key, this.form[key])
        })
        formData.append('application_ids', this.applicationIds)
        const result = await RestApi.postData(licenseRegistrationServiceBaseUrl, tcbCommonForward, formData)
        this.loading = false
        if (result.success) {
            this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
            })
          this.$router.go(-1)
        } else {
            this.$refs.form.setErrors(result.errors)
        }
    },
    getParentOfficeList (officeTypeId = null) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
          return officeList.filter(office => office.office_type_id === officeTypeId && office.org_id === 7)
      }
      return officeList
    },
    async getAssignDesignationList () {
      this.designationLoading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(commonServiceBaseUrl, 'organogram/assign-designations/get-all')
      if (result.success) {
        this.assignDesignationList = result.data
      } else {
        this.assignDesignationList = []
      }
      this.designationLoading = false
      this.getDesignationList(this.form.office_id)
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getDesignationList (officeId) {
      const assignDesignationList = this.assignDesignationList.filter(item => item.office_id === officeId && item.org_id === 7 && item.office_type_id === this.form.office_type_id)
      this.designationList = assignDesignationList.map(item => {
        const designation = this.$store.state.CommonService.commonObj.designationList.find(obj => obj.value === item.designation_id)
        return designation
      })
    },
    async getOfficerList (designationId) {
      this.officerLoading = true
        const params = {
          org_id: 7,
          office_type_id: parseInt(this.form.office_type_id),
          office_id: parseInt(this.form.office_id),
          designation_id: parseInt(this.form.designation_id)
        }
        await RestApi.getData(licenseRegistrationServiceBaseUrl, designationWiseUser, params)
        .then(response => {
          if (response.success) {
            const data = response.data
            this.officerList = data.map(item => {
              return Object.assign({ value: item.user_id, text: this.$i18n.locale === 'bn' ? item.name_bn : item.name })
            })
          } else {
            this.officerList = []
          }
          this.officerLoading = false
      })
    }
  }
}
</script>
<style scoped>
  .form-control {
    height: auto
  }
</style>
