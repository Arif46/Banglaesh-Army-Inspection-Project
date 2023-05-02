<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col md="6" sm="12">
            <ValidationProvider name="Inspection Date" vid="inspection_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="inspection_date">
                <template v-slot:label>
                  {{ $t('priceMonitoring.inspection_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="inspection_date"
                  v-model="form.inspection_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select')"
                  :locale="currentLocale"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback d-block" v-if="errors.length">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col md="6" sm="12">
            <ValidationProvider name="Market" vid="market_directory_ids" rules="required|min_value:1">
              <b-form-group
                label-for="market_directory_ids"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('priceMonitoring.inspection_market')}} <span class="text-danger">*</span>
              </template>
                <v-select
                    id="market_directory_ids"
                    v-model="form.market_directory_ids"
                    multiple
                    :reduce="op => op.value"
                    :options="marketDirectoryList"
                    label="text"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </v-select>
              <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col md="6" sm="12">
            <ValidationProvider name="Inspect By" vid="inspect_by" v-slot="{ errors }">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('priceMonitoring.inspect_by') }}
                </template>
                <b-form-radio-group
                  id="inspect_by"
                  v-model="form.inspect_by"
                  :options="inspectByList"
                  name="inspect_by"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :disabled="isDisabled"
                ></b-form-radio-group>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col md="6" sm="12">
            <ValidationProvider name="Remarks" vid="remarks" v-slot="{ errors }">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }}
                </template>
                <b-form-textarea
                    id="remarks"
                    rows="3"
                    v-model="form.remarks"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          </b-row>
          <b-row v-if="$store.state.Auth.activeRoleId !== 1 && $store.state.Auth.authUser.org_admin === 1">
            <b-col md="6" sm="12">
              <ValidationProvider name="Officer Name" vid="user_id" rules="required|min_value:1">
                <b-form-group
                  label-for="user_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('priceMonitoring.officer_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.user_id"
                  :options="userList"
                  id="user_id"
                  :disabled="$store.state.Auth.activeRoleId !== 1 ? true : (valid ? false : null)"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{ circularLoading ? 'Loading....' : $t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col md="6" sm="12">
              <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                <b-form-group
                  label-for="designation_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.designation_id"
                  :options="designationList"
                  id="designation_id"
                  :disabled="$store.state.Auth.activeRoleId !== 1 ? true : (valid ? false : null)"
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_id"
                  :options="officeList"
                  id="office_id"
                  :disabled="$store.state.Auth.activeRoleId !== 1 ? true : (valid ? false : null)"
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
            <!-- <b-col md="6" sm="12">
              <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_type_id"
                  :options="officeTypeList"
                  id="office_type_id"
                  :disabled="$store.state.Auth.activeRoleId !== 1 ? true : (valid ? false : null)"
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
            </b-col> -->
            <b-col md="6" sm="12">
              <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.org_id"
                  :options="componentOrgList"
                  id="org_id"
                  :disabled="$store.state.Auth.activeRoleId !== 1 ? true : (valid ? false : null)"
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
          <b-row v-else>
            <b-col md="6" sm="12">
              <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.org_id"
                  :options="componentOrgList"
                  id="org_id"
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
            <!-- <b-col md="6" sm="12">
              <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_type_id"
                  :options="officeTypeList"
                  id="office_type_id"
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
            </b-col> -->
            <b-col md="6" sm="12">
              <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_id"
                  :options="officeList"
                  id="office_id"
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                <b-form-group
                  label-for="designation_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.designation_id"
                  :options="designationList"
                  id="designation_id"
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Officer Name" vid="user_id" rules="required|min_value:1">
                <b-form-group
                  label-for="user_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('priceMonitoring.officer_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.user_id"
                  :options="userList"
                  id="user_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{ circularLoading ? 'Loading....' : $t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row>
          <b-col md="6" sm="12">
            <ValidationProvider name="No. of Cases" vid="no_of_cases" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="no_of_cases">
                <template v-slot:label>
                  {{ $t('priceMonitoring.no_of_cases') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="no_of_cases"
                  type="number"
                  v-model="form.no_of_cases"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row>
          <b-col md="12" sm="12">
            <ValidationProvider name="Remarks" vid="extra_remarks" v-slot="{ errors }">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }} ({{ $t('priceMonitoring.attach_additional_paper_if_necessary') }})
                </template>
                <b-form-textarea
                    id="extra_remarks"
                    rows="5"
                    v-model="form.extra_remarks"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
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
import RestApi, { bazarMonitoringServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { marketInspectionReportStore, marketInspectionReportUpdate, userListByDesignWise } from '../../api/routes'
const today = new Date().toISOString().substr(0, 10)
export default {
  name: 'Form',
  props: ['id'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      circularLoading: false,
      form: {
        inspection_date: today,
        market_directory_ids: [],
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        user_id: 0,
        designation_id: 0,
        no_of_cases: '',
        inspect_by: '',
        remarks: ''
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      userList: [],
      isDisabled: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getPriceCategory()
      this.form = tmp
    }
    if (this.$store.state.Auth.activeRoleId !== 1) {
      if (this.$store.state.Auth.authUser.office_detail.org_id === 1) {
        this.form.inspect_by = 1
      } else if (this.$store.state.Auth.authUser.office_detail.org_id === 11) {
        this.form.inspect_by = 2
      }
      this.isDisabled = true
    } else {
      this.isDisabled = false
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    marketDirectoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1)
    },
    inspectByList () {
      return this.$store.state.BazarMonitoringService.commonObj.inspectByList
    },
    componentOrgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1 && this.$store.state.Auth.authUser.org_admin === 1) {
      this.form = Object.assign({}, this.form, {
        org_id: this.loggedUserPrivilege.org_id,
        // office_type_id: this.loggedUserPrivilege.office_type_id,
        office_id: this.loggedUserPrivilege.office_id,
        designation_id: this.loggedUserPrivilege.designation_id,
        user_id: this.loggedUserPrivilege.user_id
      })
    }
    const loadingState = { loading: false, listReload: false }
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (this.$route.params.id) {
      this.saveUpdate()
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.officeTypeList = this.getOfficeTypeList(newVal)
        this.officeList = this.getOfficeList(newVal)
        this.designationList = this.getDesignationList(newVal)
      } else {
        // this.officeTypeList = []
        this.officeList = []
        this.designationList = []
      }
    },
    // 'form.office_type_id': function (newVal, oldVal) {
    //   if (newVal !== oldVal) {
    //     this.officeList = this.getOfficeList(newVal)
    //   } else {
    //     this.officeList = []
    //   }
    // },
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.findUser(newVal)
      } else {
        this.userList = []
      }
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${marketInspectionReportUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, marketInspectionReportStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getPriceCategory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getOfficeList (id) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getDesignationList (id) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === id)
    },
    findUser (degId) {
      this.circularLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          const userData = response.data.filter(user => user.designation_id === degId)
          this.userList = userData.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.circularLoading = false
        }
      })
    }
  }
}
</script>
