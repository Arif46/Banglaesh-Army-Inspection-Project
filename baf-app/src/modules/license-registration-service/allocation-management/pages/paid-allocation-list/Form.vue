<template>
<b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="DO No" vid="do_no" rules="required|min_value:1">
                      <b-form-group
                        label-for="do_no"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.do_no')}} <span class="text-danger">*</span>
                      </template>
                     <b-form-input
                            id="do_no"
                            readonly
                            v-model="formData.do_no"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                      </b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Dealer Name" vid="dealer_name" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="dealer_name">
                          <template v-slot:label>
                            {{ $t('allocation_management.dealer_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            readonly
                            id="dealer_name"
                            v-model="formData.applicant_name"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                   </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Company Name" vid="company_name" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="company_name">
                          <template v-slot:label>
                            {{ $t('allocation_management.company_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="company_name"
                            disabled
                            v-model="formData.company_name"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                   </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Region" vid="office_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="office_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.regional_office')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        disabled
                        v-model="formData.office_id"
                        :options="regionalOfficeList"
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
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Warehouse" vid="warehouse_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="warehouse_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.warehouse')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.warehouse_id"
                        :options="warehouseList"
                        id="warehouse_id"
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
                </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
      <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paidAllocationSend } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.send') : this.$t('globalTrans.save'),
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      errors: [],
      formData: {
      },
      itemList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
      this.formData.warehouse_id = 0
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    warehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === this.formData.office_id)
    },
    regionalOfficeList (orgId = 7) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.org_id === 7) && item.is_regional_office === 1)
    }
  },
  watch: {
  },
  methods: {
    // ================Allotment Order Modify Start=================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }
        if (this.id) {
          result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${paidAllocationSend}/${this.id}`, this.formData)
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
          this.$refs.mainForm.setErrors(result.errors)
        }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
