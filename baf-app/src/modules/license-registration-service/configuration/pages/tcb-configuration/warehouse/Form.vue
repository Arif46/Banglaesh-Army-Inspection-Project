<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="4">
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
                :disabled="true"
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
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="office_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('tcbconfiguration.office_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.office_type_id"
                :options="officeTypeList"
                id="office_type_id"
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
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
              <b-form-group
                label-for="office_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('tcbconfiguration.office')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.office_id"
                :options="officeList"
                id="office_id"
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
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Warehouse Code" vid="warehouse_code" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="warehouse_code">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.warehouse_code') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  id="warehouse_code"
                  v-model="form.warehouse_code"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Warehouse (En)" vid="warehouse_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="warehouse_name_en">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.warehouse') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="warehouse_name_en"
                  v-model="form.warehouse_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Warehouse (Bn)" vid="warehouse_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="warehouse_name_bn">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.warehouse') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="warehouse_name_bn"
                  v-model="form.warehouse_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { warehouseStore, warehouseUpdate } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      officeTypeList: [],
      officeList: [],
      form: {
        org_id: 7,
        office_type_id: 0,
        office_id: 0,
        warehouse_code: '',
        warehouse_name_en: '',
        warehouse_name_bn: ''
      },
      per: false
    }
  },
  created () {
    this.officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === 7)
    if (this.id) {
      const tmp = this.getOfficeEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === newVal)
      if (this.per) {
        this.form.office_id = 0
      }
        this.per = true
      }
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${warehouseUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, warehouseStore, this.form)
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
    getOfficeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
