<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchBody>
        <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
                  <b-col lg="12" xl="12">
                    <table class="table table-sm table-bordered">
                      <tr>
                        <th width="50%" colspan="2" class="text-center">{{ $t('globalTrans.from') }} ({{ $t('dynamic_form.form') }}) </th>
                        <th width="50%" colspan="2" class="text-center">{{ $t('globalTrans.to') }} ({{ $t('dynamic_form.form') }}) </th>
                      </tr>
                      <tr>
                        <td width="50%" colspan="2">
                          <ValidationProvider name="Organization" vid="org_id_from" rules="required|min_value:1">
                            <b-form-group
                                :label-for="`org_id_from`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.org_id_from"
                                :options="orgProfileList"
                                id="org_id_from"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('component_settings.select_organization')}}</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td width="50%" colspan="2">
                          <ValidationProvider name="Organization" vid="org_id_to" rules="required|min_value:1">
                            <b-form-group
                                :label-for="`org_id_from`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.org_id_to"
                                :options="orgProfileList"
                                id="org_id_to"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('component_settings.select_organization')}}</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                      </tr>
                      <tr>
                        <td width="25%">
                          <ValidationProvider name="Service Name" vid="service_id_from" rules="required|min_value:1">
                            <b-form-group
                              class="row"
                                label-cols-sm="12"
                                :label-for="`service_id_from`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('dropdown_settings.service') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.service_id_from"
                                :options="serviceListFrom"
                                id="org_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option :value="0" >{{$t('component_settings.select_service')}}</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td width="25%">
                          <ValidationProvider name="Form" vid="form_id_from" rules="required">
                            <b-form-group
                              class="row"
                                label-cols-sm="12"
                                :label-for="`form_id_from`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('dynamic_form.form') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.form_id_from"
                                :options="formListFrom"
                                id="org_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option value="" >{{$t('component_settings.select_form')}}</b-form-select-option>
                                  <b-form-select-option value=0 >Profile form</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td width="25%">
                          <ValidationProvider name="Service Name" vid="service_id_to" rules="required|min_value:1">
                            <b-form-group
                              class="row"
                                label-cols-sm="12"
                                :label-for="`service_id_to`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('dropdown_settings.service') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.service_id_to"
                                :options="serviceListTo"
                                id="org_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option :value="0" >{{$t('component_settings.select_service')}}</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td width="25%">
                          <ValidationProvider name="Form" vid="form_id_to" rules="required|min_value:1">
                            <b-form-group
                              class="row"
                                label-cols-sm="12"
                                :label-for="`form_id_to`"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('dynamic_form.form') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="form.form_id_to"
                                :options="formListTo"
                                id="org_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                  <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                      </tr>
                      <tr>
                        <td width="50%" colspan="2">
                          <b-row>
                            <b-col lg="10" xl="10">
                              <ValidationProvider name="Field" :vid="`field_id_from`" rules="">
                                <b-form-group
                                  class="row"
                                  label-cols-sm="4"
                                  :label-for="`field_id_from`"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('globalTrans.select_field') }}
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="form.field_id_from"
                                    :options="inputListFrom"
                                    :id="`field_id_from`"
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
                          </b-row>
                        </td>
                        <td colspan="2">
                          <b-row>
                            <b-col lg="10" xl="10">
                              <ValidationProvider name="Field" :vid="`field_id_to`" rules="">
                                <b-form-group
                                  class="row"
                                  label-cols-sm="4"
                                  :label-for="`field_id_to`"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('globalTrans.select_field') }}
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="form.field_id_to"
                                    :options="inputListTo"
                                    :id="`field_id_to`"
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
                            <b-col lg="2" xl="2">
                              <b-button @click="addNew()" type="button" variant="primary" class="mr-2">{{ $t('globalTrans.add') }}</b-button>
                            </b-col>
                          </b-row>
                        </td>
                      </tr>
                    </table>
                  </b-col>
                  <b-col lg="12" xl="12">
                    <table class="table table-sm table-bordered">
                      <tr>
                        <th width="50%" colspan="2" class="text-center">{{ $t('globalTrans.from') }} {{ $t('component_settings.field') }}</th>
                        <th width="50%" colspan="2" class="text-center">{{ $t('globalTrans.to') }}  {{ $t('component_settings.field') }}</th>
                      </tr>
                      <tr v-for="(item, index) in form.details" :key="index">
                        <td width="50%" colspan="2">
                          <b-row>
                            <b-col lg="10" xl="10">
                              <ValidationProvider name="Field" :vid="`field_id_from`+index" rules="required">
                                <b-form-group
                                  class="row"
                                  label-cols-sm="4"
                                  :label-for="`field_id_from`+index"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="item.field_id_from"
                                    :options="inputListFrom"
                                    disabled
                                    :id="`field_id_from`+index"
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
                          </b-row>
                        </td>
                        <td colspan="2">
                          <b-row>
                            <b-col lg="10" xl="10">
                              <ValidationProvider name="Field" :vid="`field_id_to`+index" rules="required">
                                <b-form-group
                                  class="row"
                                  label-cols-sm="4"
                                  :label-for="`field_id_to`+index"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                  {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="item.field_id_to"
                                    :options="inputListTo"
                                    disabled
                                    :id="`field_id_to`+index"
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
                            <b-col lg="2" xl="2">
                              <b-button @click="remove(index)" type="button" variant="danger" class="mr-2">x</b-button>
                            </b-col>
                          </b-row>
                        </td>
                      </tr>
                    </table>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                      <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                      <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-row>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { fieldAssignStore, fieldAssignUpdate, dynamicFormEditData } from '../../api/routes'
import { snakeToWords } from '@/utils/fliter'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id_from: 0,
        org_id_to: 0,
        service_id_from: 0,
        service_id_to: 0,
        form_id_from: '',
        form_id_to: 0,
        field_id_f: 0,
        field_id_to: 0,
        details: []
      },
      formListTo: [],
      formListFrom: [],
      inputListFrom: [],
      inputListTo: [],
      serviceListFrom: [],
      serviceListTo: [],
      loading: false
    }
  },
  created () {
    if (this.$route.query.id) {
      this.form = this.getEditData()
    }
  },
  watch: {
    'form.org_id_from': function (newVal) {
      this.serviceListFrom = this.getServiceList(newVal)
    },
    'form.org_id_to': function (newVal) {
      this.serviceListTo = this.getServiceList(newVal)
    },
    'form.service_id_from': function (n, o) {
        if (n !== o) {
          this.formListFrom = this.getStepWiseForm(n, 2)
        }
    },
    'form.service_id_to': function (n, o) {
       if (n !== o) {
        this.formListTo = this.getStepWiseForm(n, 2)
       }
    },
    'form.form_id_from': function (n, o) {
       if (n !== o) {
        if (n > 0) {
          this.inputListFrom = this.getInputList(n)
        } else {
          this.inputListFrom = this.allFormField
        }
       }
    },
    'form.form_id_to': function (n, o) {
       if (n !== o) {
        this.inputListTo = this.getInputList(n)
       }
    }
  },
  computed: {
    allFormField: function () {
      return [
        {
          value: 'name',
          field_type: 'InputField',
          text: 'Name'
        },
        {
          value: 'name_bn',
          field_type: 'InputField',
          text: 'Name Bn'
        },
        {
          value: 'email',
          field_type: 'InputField',
          text: 'Email'
        },
        {
          value: 'mobile_no',
          field_type: 'InputField',
          text: 'Mobile No'
        },
        {
          value: 'nid',
          field_type: 'InputField',
          text: 'Nid'
        },
        {
          value: 'photo',
          field_type: 'Attachment',
          text: 'Photo'
        },
        {
          value: 'dob',
          field_type: 'Date',
          text: 'Dob'
        },
        {
          value: 'gender',
          field_type: 'Dropdown',
          text: 'Gender'
        },
        {
          value: 'religion',
          field_type: 'InputField',
          text: 'Religion'
        },
        {
          value: 'father_name',
          field_type: 'InputField',
          text: 'Father Name'
        },
        {
          value: 'father_name_bn',
          field_type: 'InputField',
          text: 'Father Name Bn'
        },
        {
          value: 'mother_name',
          field_type: 'InputField',
          text: 'Mother Name'
        },
        {
          value: 'mother_name_bn',
          field_type: 'InputField',
          text: 'Mother Name Bn'
        },
        {
          value: 'spouse_name',
          field_type: 'InputField',
          text: 'Spouse Name'
        },
        {
          value: 'spouse_name_bn',
          field_type: 'InputField',
          text: 'Spouse Name Bn'
        },
        {
          value: 'occupation',
          field_type: 'InputField',
          text: 'Occupation'
        },
        {
          value: 'occupation_bn',
          field_type: 'InputField',
          text: 'Occupation Bn'
        },
        {
          value: 'division_id',
          field_type: 'Dropdown',
          text: 'Division Id'
        },
        {
          value: 'district_id',
          field_type: 'Dropdown',
          text: 'District Id'
        },
        {
          value: 'upazilla_id',
          field_type: 'Dropdown',
          text: 'Upazilla Id'
        },
        {
          value: 'present_address',
          field_type: 'Paragraph',
          text: 'Present Address'
        },
        {
          value: 'permanent_address',
          field_type: 'Paragraph',
          text: 'Permanent Address'
        }
      ]
    },
    orgProfileList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    dynamicButtonList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.filter(item => item.status === 1)
    }
  },
  methods: {
    addNew () {
      const tmp = {
        field_id_from: this.form.field_id_from,
        field_id_to: this.form.field_id_to
      }
      this.form.details.push(tmp)
    },
    remove (index) {
      this.form.details.splice(index, 1)
    },
    removeBtn (index) {
      this.form.custom_actions.splice(index, 1)
    },
    getStepWiseForm (stepOrServiceId, type) {
        const tmpFormList = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.filter(item => (item.service_id === parseInt(stepOrServiceId)))
        const stepList = tmpFormList.map(item => {
            if (this.$i18n.locale === 'bn') {
              return { text: item.form_title, value: item.form_id }
            } else {
              return { text: item.form_title, value: item.form_id }
            }
        })
        return stepList
    },
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.query.id))
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${fieldAssignUpdate}/${this.$route.query.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, fieldAssignStore, this.form)
      }
      this.loading = false
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$router.go(-1)
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    },
    getInputList (dynamicFormId) {
      this.loading = true
      const finalList = []
      RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + dynamicFormId).then(response => {
        if (response.success) {
          response.data.tabs.forEach(item => {
            const tmpList = {
                label: snakeToWords(item.tab_name),
                options: []
              }
            item.layouts.forEach(i => {
              const input = JSON.parse(i.data)
              if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'options' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date') {
                  tmpList.options.push({
                    text: input.label, value: input.field_name
                  })
                }
            })
            finalList.push(tmpList)
          })
          finalList.push({ text: 'License Number', value: 'generate_id' })
          finalList.push({ text: 'Issue Date', value: 'issue_date' })
          this.loading = false
        }
      })
      return finalList
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    }
  }
}
</script>
