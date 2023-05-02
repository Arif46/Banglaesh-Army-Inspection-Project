<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('bsri_demandDIS.forward') }}</h4>
          </template>
          <template v-slot:body>
            <b-overlay :show="loading">
              <b-row>
                <b-col lg="12" sm="12" md="12">
                  <b-form-group
                    class="row"
                    label-cols-sm="2"
                    label-for="application_id"
                  >
                    <template v-slot:label>
                      {{ $t('li_step.application_id') }} <span class="text-danger">*</span>
                    </template>
                    <div v-for="(item, index) in stepChange.application_id" :key="index" class="d-inline mr-2">
                      <span  class="badge badge-success">{{ item }}</span>
                    </div>
                  </b-form-group>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="Step Name" vid="step_id" rules="required|min_value:1">
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
                        v-model="form.next_step_id"
                        :options="stepList"
                        id="step_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
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
                          <ValidationProvider name="Organization" rules="required|min_value:1">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="org_id"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('org_pro.organization')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                  plain
                                  v-model="form.org_id"
                                  :options="orgList"
                                  id="org_id"
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
                          <ValidationProvider name="Office Type">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="office_type_id"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('org_pro.office_type')}}
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
                                  label-for="office_type_id"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('globalTrans.office')}}
                                  </template>
                                  <b-form-select
                                  plain
                                  v-model="form.office_id"
                                  :options="officeList"
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
                          <ValidationProvider name="Designation Id" vid="designation_id" rules="required|min_value:1">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="office_type_id"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('user_role.designation')}}
                                  </template>
                                  <b-form-select
                                  plain
                                  v-model="form.designation_id"
                                  :options="designationList"
                                  id="office_type_id"
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
                                  {{ $t('budget.officer')}}
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
                        <b-col lg="6" sm="12"></b-col>
                        <b-col lg="6" sm="12">
                          <ValidationProvider name="Select Note" vid="note_id">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="note_id"
                                  >
                                  <template v-slot:label>
                                  {{ $t('li_step.select_note')}}
                                  </template>
                                  <b-form-select
                                  plain
                                  v-model="form.note_id"
                                  :options="noteList"
                                  id="note_id"
                                  >
                                  <template v-slot:first>
                                      <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                                  </template>
                                  </b-form-select>
                              </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" sm="12"></b-col>
                        <b-col lg="6" sm="12">
                          <ValidationProvider name="Note" vid="note">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="note"
                            >
                                <template v-slot:label>
                                    {{ $t('li_step.note_en') }}
                                </template>
                                <b-form-textarea
                                    plain
                                    v-model="form.note_en"
                                    id="note"
                                >
                                </b-form-textarea>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" sm="12">
                          <ValidationProvider name="Note" vid="note">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="note"
                                slot-scope="{ valid, errors }"
                            >
                                <template v-slot:label>
                                    {{ $t('li_step.note_bn') }}
                                </template>
                                <b-form-textarea
                                    plain
                                    v-model="form.note_bn"
                                    id="note"
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
                          <ValidationProvider name="attachment" vid="attachment" :rules="actions(stepChange.service_id).is_doc_required ? 'required' : ''">
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
                                v-model="form.attachment"
                                v-on:change="onFileChange"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-file>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col md='12' lg="12" v-if='actions(stepChange.service_id).is_doc_required'>
                          {{ $t('globalTrans.note') + ' : ' }} {{ $t('li_step.forward_message') }}
                        </b-col>
                      </b-row>
                      <div class="row">
                        <div class="col-8 offset-4" sm="12">
                            <div class="text-right">
                                <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                &nbsp;
                                <b-button variant="danger" class="mr-1" @click="back()">{{ $t('globalTrans.cancel') }}</b-button>
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
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { forwardStore, designationWiseUser } from '../../api/routes'

export default {
  components: {
    ValidationObserver,
    ValidationProvider
  },
  props: ['stepChange'],
  data () {
    return {
      loading: false,
      designationLoading: false,
      officerLoading: false,
      saveBtnName: this.$t('globalTrans.send'),
      form: {
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        designation_id: 0,
        note_en: '',
        note_bn: '',
        application_id: [],
        service_id: 0,
        step_id: 0,
        next_step_id: 0,
        sender_id: this.$store.state.Auth.authUser.user_id,
        receiver_id: 0,
        status: 0,
        note_id: 0,
        attachment: ''
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      officerList: [],
      stepList: [],
      assignDesignationList: [],
      attachmentDemo: []
    }
  },
  created () {
    this.getAssignDesignationList()
    this.form.application_id = this.stepChange.application_id
    if (this.stepChange.step_id) {
      this.form.step_id = this.stepChange.step_id
      this.form.next_step_id = this.stepChange.step_id
    }
    if (this.stepChange.service_id) {
      this.form.service_id = this.stepChange.service_id
      this.stepList = this.getServiceWiseStep(this.form.service_id)
    }
    this.setOrgAndOffice()
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (oldVal !== newVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
      }
    },
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getParentOfficeList(newVal)
      }
    },
    'form.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== undefined) {
        this.getDesignationList(newVal)
      }
    },
    'form.designation_id': function (newVal) {
      if (newVal !== 0) {
        this.getOfficerList(newVal)
      }
    },
    'form.next_step_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.form.next_step_id = newVal
      }
    },
    'form.note_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.setNote(newVal)
      }
    }
  },
  computed: {
    orgList: function () {
      const componentOrgList = this.$store.state.CommonService.commonObj.orgComponentList.filter(item => item.component_id === parseInt(7))
      const loadingOrg = componentOrgList.map(item => {
        const org = this.$store.state.CommonService.commonObj.orgProfileList.find(orgItem => orgItem.value === item.org_id)
          if (this.$i18n.locale === 'bn') {
            return { text: org.text_bn, value: org.value }
          } else {
            return { text: org.text_en, value: org.value }
          }
      })
      return loadingOrg
    },
    noteList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.orgNotesList.filter(item => item.status === 1)
    }
  },
  methods: {
    actions (serviceId) {
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.stepChange.step_id && item.service_id === serviceId)
      if (typeof actions === 'undefined') {
        return {}
      } else {
        return actions
      }
    },
    onFileChange (e) {
      this.getBase64(e.target.files[0]).then(res => {
        this.attachmentDemo = res
      })
    },
    getBase64 (file) {
      return new Promise(function (resolve, reject) {
        const reader = new FileReader()
        let imgResult = ''
        reader.readAsDataURL(file)
        reader.onload = function () {
            imgResult = reader.result
        }
        reader.onerror = function (error) {
            reject(error)
        }
        reader.onloadend = function () {
            resolve(imgResult)
        }
      })
    },
    setNote (noteId) {
      const note = this.noteList.find(item => item.value === noteId)
      if (note !== undefined) {
        this.form.note_en = note.text_en
        this.form.note_bn = note.text_bn
      }
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
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId) && item.order !== 1)
        const stepList = tmpStepList.map(item => {
            if (this.$i18n.locale === 'bn') {
              return { text: item.step_name_bn, value: item.step_id, order_id: item.order }
            } else {
              return { text: item.step_name, value: item.step_id, order_id: item.order }
            }
        })
        return stepList
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
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }
        const config = { headers: { 'content-type': 'multipart/form-data' } }
        var formData = new FormData()
        Object.keys(this.form).map(key => {
            if (key === 'attachment') {
            formData.append(key, this.attachmentDemo)
            } else if (key === 'application_id') {
              this.form[key].forEach((item) => {
                formData.append('application_id[]', item)
              })
            } else {
              formData.append(key, this.form[key])
            }
        })
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, forwardStore, formData, config)

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        if (result.success) {
            this.$store.commit('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
            this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
            })
        } else {
            this.$refs.form.setErrors(result.errors)
        }
        this.$router.go(-1)
    },
    getParentOfficeList (officeTypeId = null) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
          return officeList.filter(office => office.office_type_id === officeTypeId)
      }
      return officeList
    },
    getAssignDesignationList () {
      this.assignDesignationList = this.$store.state.CommonService.commonObj.assignDesignationList.filter(item => item.org_id === this.stepChange.org_id)
    },
    getDesignationList (officeId) {
      const assignDesignationList = this.assignDesignationList.filter(item => item.office_id === officeId && item.org_id === this.form.org_id && item.office_type_id === this.form.office_type_id)
      this.designationList = assignDesignationList.map(item => {
        const designation = this.$store.state.CommonService.commonObj.designationList.find(obj => obj.value === item.value)
        return designation
      })
    },
    async getOfficerList (designationId) {
      this.officerLoading = true
        const params = {
          org_id: parseInt(this.form.org_id),
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
