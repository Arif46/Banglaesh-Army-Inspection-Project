<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.org_id"
                :options="orgProfileList"
                id="org_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Service Name (En)" vid="service_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('service_name.service_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="service_name"
                  v-model="form.service_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Service Name (Bn)" vid="service_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="service_name">
                <template v-slot:label>
                  {{ $t('service_name.service_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="service_name_bn"
                  v-model="form.service_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Validity Period (Year)" vid="validity_period_yearly" rules="">
              <b-form-group
                label-for="validity_period_yearly">
                <template v-slot:label>
                  {{$t('service_name.validity_period_yearly')}}
                </template>
                <b-form-select
                  plain
                  id="validity_period_yearly"
                  v-model="form.validity_period_yearly">
                  <b-form-select-option value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                  <b-form-select-option v-for="n in 10" :value="n" :key="n">{{ $n(n) }}</b-form-select-option>
                </b-form-select>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Validity Period (Month)" vid="validity_period_monthly" rules="">
              <b-form-group
                label-for="validity_period_monthly">
                <template v-slot:label>
                  {{$t('service_name.validity_period_monthly')}}
                </template>
                <b-form-select
                  plain
                  id="validity_period_monthly"
                  v-model="form.validity_period_monthly">
                  <b-form-select-option value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                  <b-form-select-option v-for="n in 12" :value="n" :key="n">{{ $n(n) }}</b-form-select-option>
                </b-form-select>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col>
            <ValidationProvider name="Fee Info" vid="fee_id" rules="">
              <b-form-group
                label-for="fee_id">
                <template v-slot:label>
                  {{$t('service_name.fee_info')}}
                </template>
                <b-form-checkbox-group
                  v-model="form.fee_id"
                  :options="feeNameList"
                ></b-form-checkbox-group>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <template>
          <div style="background-color: #66cc99;margin-bottom: 5px; text-align:center">
            <h5 class="text-white pl-2"> {{ $t('service_name.permission') }} </h5>
          </div>
        </template>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" class="mt-3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="8"
              label-for="public_application"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('service_name.public_application') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="public_application"
              v-model="form.public_application"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" class="mt-3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="5"
              label-for="renew"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('component_settings.renew') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="renew"
              v-model="form.renew"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" class="mt-3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="7"
              label-for="lost"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('component_settings.lost') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="lost"
              v-model="form.lost"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" class="mt-3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="8"
              label-for="choose_payment"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('component_settings.choose_payment') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="choose_payment"
              v-model="form.choose_payment"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="5"
              label-for="transfer"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('component_settings.transfer') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="transfer"
              v-model="form.transfer"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="7"
              label-for="withdraw"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
              {{ $t('component_settings.withdraw') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="withdraw"
              v-model="form.withdraw"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" offset="1">
            <ValidationProvider>
              <b-form-group
              class="row"
              label-cols-sm="8"
              label-for="cancel"
              slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{ $t('globalTrans.cancel') }}
              </template>
              <b-form-checkbox
              class="mt-2"
              id="cancel"
              v-model="form.cancel"
              ></b-form-checkbox>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <template>
          <div style="background-color: #66cc99;margin-bottom: 5px; text-align:center">
            <h5 class="text-white pl-2"> {{ $t('component_settings.office_info') }} </h5>
          </div>
        </template>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" class="mt-3" offset="3">
            <ValidationProvider name="custom_office" vid="custom_office">
              <b-form-group
                class="row"
                label-cols-sm="6"
                label-for="custom_office"
              >
                <template v-slot:label>
                  {{$t('component_settings.fixed_office')}}
                </template>
                <b-form-checkbox
                  class="mt-2"
                  id="custom_office"
                  v-model="form.custom_office"
                >
                </b-form-checkbox>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row v-if="form.custom_office">
          <b-col xs="12" sm="12" md="6" lg="6">
            <ValidationProvider name="Office Type" vid="office_type_id">
              <b-form-group
              label-for="office_type_id">
                <template v-slot:label>
                  {{$t('userManagement.office_type')}}
                </template>
                <b-form-select
                plain
                v-model="form.office_type_id"
                :options="officeTypeList"
                id="office_type_id">
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6">
            <ValidationProvider name="Office Name" vid="office_name_id">
              <b-form-group
              label-for="office_name_id">
                <template v-slot:label>
                  {{$t('userManagement.office')}}
                </template>
                <b-form-select
                plain
                v-model="form.office_name_id"
                :options="officeList"
                id="office_name_id">
                <template v-slot:first>
                <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
                </b-form-select>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <template>
          <div style="background-color: #66cc99;margin-bottom: 5px; text-align:center">
            <h5 class="text-white pl-2"> {{ $t('userManagement.office_category') }} </h5>
          </div>
        </template>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6">
            <ValidationProvider name="office_category_check" vid="office_category_check">
              <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="office_category_check">
                <template v-slot:label>
                  {{$t('userManagement.office_category')}}
                </template>
                <b-form-checkbox
                  class="mt-2"
                  id="office_category_check"
                  v-model="form.office_category_check">
                </b-form-checkbox>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6">
            <ValidationProvider name="regional_office_check" vid="regional_office_check">
              <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="regional_office_check">
                <template v-slot:label>
                  {{$t('userManagement.is_regional_office')}}
                </template>
                <b-form-checkbox
                  class="mt-2"
                  id="regional_office_check"
                  v-model="form.regional_office_check"
                >
                </b-form-checkbox>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { serviceStore, serviceUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        fee_id: [],
        service_name: '',
        service_name_bn: '',
        validity_period_yearly: 0,
        validity_period_monthly: 0,
        public_application: 0,
        office_type_id: 0,
        office_name_id: 0,
        office_category_check: '',
        regional_office_check: '',
        choose_payment: 0
      },
      officeList: [],
      officeTypeList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getServiceEntry()
      let custom
      if (tmp.office_type_id) {
         custom = true
      } else {
        custom = false
      }
      this.form = Object.assign(tmp, { custom_office: custom })
    }
  },
  watch: {
  'form.org_id': function (newVal, oldVal) {
    if (newVal) {
      this.officeTypeList = this.getOfficeTypeList(newVal)
    }
  },
  'form.office_type_id': function (newVal, oldVal) {
    if (newVal) {
      this.officeList = this.getOfficeList(newVal)
    }
  }
},
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        const pp = this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
        return pp
    },
    feeNameList: function () {
      const feeDataList = this.$store.state.LicenseRegistrationService.commonObj.feeNamesList.filter(item => item.status === 1 && item.org_id === this.form.org_id)
      return feeDataList.map(item => {
          if (this.$i18n.locale === 'bn') {
              return { value: item.value, text: item.text_bn }
          } else {
              return { value: item.value, text: item.text_en }
          }
      })
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${serviceUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, serviceStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
    },
    getOfficeTypeList (orgID) {
      const officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgID)
      return officeTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getServiceEntry () {
      let tmpData = this.$store.state.list.find(item => item.id === this.id)
      const isApplicationFee = Boolean(tmpData.public_application)
      const isWithDraw = Boolean(tmpData.withdraw)
      const isCancel = Boolean(tmpData.cancel)
      const isTransfer = Boolean(tmpData.transfer)
      const isRenew = Boolean(tmpData.renew)
      const isLost = Boolean(tmpData.lost)
      const isChoosePayment = Boolean(tmpData.choose_payment)
      const isOfficeCategoryCheck = Boolean(tmpData.office_category_check)
      const isRegionalOfficeCheck = Boolean(tmpData.regional_office_check)
      tmpData = Object.assign({}, tmpData, {
        public_application: isApplicationFee,
        withdraw: isWithDraw,
        cancel: isCancel,
        transfer: isTransfer,
        renew: isRenew,
        lost: isLost,
        choose_payment: isChoosePayment,
        office_category_check: isOfficeCategoryCheck,
        regional_office_check: isRegionalOfficeCheck,
        fee_id: tmpData.fees.map(ut => ut.fee_id)
      })
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
