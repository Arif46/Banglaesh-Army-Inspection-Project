<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="org_id" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_category')}} <span class="text-danger">*</span>
                </template>
                <b-form-radio-group
                  id="organization_category"
                  v-model="form.organization_category"
                  :options="orgTypeList"
                  @change="orgShow()"
                  name="organization_category"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showInternalOrg">
            <ValidationProvider name="Organization" vid="organization_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.organization_id"
                  :options="orgList"
                  id="organization_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization Type" vid="organization_type_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.organization_type_id"
                  :options="organizationTypeList"
                  id="organization_type_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization Sub Type" vid="organization_sub_type_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_sub_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_sub_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.organization_sub_type_id"
                  :options="organizationSubTypeList"
                  id="organization_sub_type_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization" vid="organization_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.organization_id"
                  :options="organizationNameList"
                  id="organization_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('stakeholder.stakeholder_info') }} {{ $t('globalTrans.search') }}</h5>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Stakeholder Name (En)" vid="stakeholder_name_en" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="stakeholder_name_en"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.name_en')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="stakeholder_name_en"
                  v-model="form.stakeholder_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Stakeholder Name (Bn)" vid="stakeholder_name_bn">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="stakeholder_name_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.name_bn')}}
                </template>
                <b-form-input
                  id="stakeholder_name_bn"
                  v-model="form.stakeholder_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Designation" vid="stakeholder_designation" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="stakeholder_designation"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="stakeholder_designation"
                  v-model="form.stakeholder_designation"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Designation (Bn)" vid="stakeholder_designation_bn">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="stakeholder_designation_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.designation_bn')}}
                </template>
                <b-form-input
                  id="stakeholder_designation_bn"
                  v-model="form.stakeholder_designation_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Contact No." vid="contact_no" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="contact_no"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.contact_no')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_no"
                  v-model="form.contact_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Email" vid="email" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="email"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.email')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email"
                  v-model="form.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Address" vid="address" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="address"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.address')}} <span class="text-danger">*</span>
                </template>
               <b-form-textarea
                  rows="3"
                  id="address"
                  v-model="form.address"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Address (Bn)" vid="address_bn">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="address_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.address_bn')}}
                </template>
               <b-form-textarea
                  rows="3"
                  id="address_bn"
                  v-model="form.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('stakeholder.follow_up') }}</h5>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="designation" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="designation"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.designation"
                  :options="designationList"
                  id="designation"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="employee_name" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="employee_name"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.employee_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.employee_name"
                  :options="userList"
                  id="employee_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
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
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { stakeholderStore, stakeholderUpdate, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      loading: false,
      showExternalOrg: false,
      showInternalOrg: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        organization_id: 0,
        organization_category: 0,
        organization_type_id: 0,
        organization_sub_type_id: 0,
        designation: 0,
        employee_name: 0
      },
      userList: [],
      attachmentDemo: [],
      orgTypeList: [
        { value: 1, text: 'Moc Stakeholder' },
        { value: 2, text: 'Other' }
      ]
    }
  },
  created () {
    if (this.id) {
      this.loading = true
      const tmp = this.getCommitteeData()
      // this.loading = false
      this.form = tmp
      this.orgShow()
    }
  },
  computed: {
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList
    },
    designationList () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
    },
    organizationTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList
    },
    organizationSubTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.filter(orgSubType => orgSubType.organization_type_id === this.form.organization_type_id)
    },
    organizationNameList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationNameList.filter(externalOrg => externalOrg.organization_sub_type_id === this.form.organization_sub_type_id)
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  watch: {
    'form.designation': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    }
  },
  methods: {
    getCommitteeData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    orgShow () {
      if (this.form.organization_category === 1) {
        this.showExternalOrg = false
        this.showInternalOrg = true
      }
      if (this.form.organization_category === 2) {
        this.showInternalOrg = false
        this.showExternalOrg = true
      }
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${stakeholderUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, stakeholderStore, this.form)
      }
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getUserList (designationId) {
      this.loading = true
      const params = Object.assign({}, { designation_id: designationId })
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
        if (response.success) {
          this.userList = response.data.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.loading = false
        }
      })
    }
  }
}
</script>
