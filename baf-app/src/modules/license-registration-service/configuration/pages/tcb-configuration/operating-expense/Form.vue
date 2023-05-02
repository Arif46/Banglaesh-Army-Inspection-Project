<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Seller Type" vid="seller_type" rules="required|min_value:1">
              <b-form-group
                label-for="seller_type"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('license_config.seller_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.seller_type"
                :options="sellerTypeList"
                id="seller_type"
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
            <ValidationProvider name="Distance" vid="distance" rules="required|min_value:1">
              <b-form-group
                label-for="distance"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('license_config.distance')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.distance"
                :options="distanceList"
                id="distance"
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
            <ValidationProvider name="Expense Amount" vid="expense_amount" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('license_config.expense_amount') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="expense_amount"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  v-model="form.expense_amount"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Effective date" vid="effective_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="effective_date">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.effective_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="effective_date"
                  v-model="form.effective_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
        <!--    <ValidationProvider name="Effective date" vid="effective_date" rules="required" v-slot="{ errors }">
              <b-form-group
              class="row"
              label-for="effective_date"
              >
              <template v-slot:label>
                {{ $t('tcbconfiguration.effective_date') }} <span class="text-danger">*</span>
              </template>
                <date-picker
                  id="effective_date"
                  v-model="form.effective_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="config"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>-->
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
import { optExpStore, optExpUpdate } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 8,
        seller_type: 0,
        dispatch: '',
        distance: 0,
        expense_amount: '',
        effective_date: null
      },
      config: { static: true }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getItemEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    sellerTypeList () {
      const sellerTypeList = this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList
        return sellerTypeList.map(item => {
          return { value: item.value, text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en }
        })
    },
    distanceList () {
      const distanceList = this.$store.state.LicenseRegistrationService.commonObj.distanceList
        return distanceList.map(item => {
          return { value: item.value, text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en }
        })
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${optExpUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, optExpStore, this.form)
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
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
