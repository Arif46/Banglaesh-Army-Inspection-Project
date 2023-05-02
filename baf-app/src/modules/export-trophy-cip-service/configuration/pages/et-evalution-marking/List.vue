<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophyConfig.et_evaluation_marking') }}</h4>
      </template>
      <template>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
              <b-row class="pl-3 pt-3">
                <b-col sm="5">
                  <ValidationProvider name="Total number on export earnings" vid="total_number_export_earning" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="total_number_export_earning"
                      label-cols-lg="9"
                      >
                      <template v-slot:label>
                        {{ $t('exportTrophyConfig.total_number_export_earning') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="total_number_export_earning"
                        v-model="formData.total_number_export_earning"
                        :state="errors[0] ? false : (valid ? true : null)"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="pl-3">
                <b-col sm="5">
                  <ValidationProvider name="Total number on Increase in Export Income" vid="total_number_export_income" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="total_number_export_income"
                      label-cols-lg="9"
                      >
                      <template v-slot:label>
                        {{ $t('exportTrophyConfig.total_number_export_income') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="total_number_export_income"
                        v-model="formData.total_number_export_income"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="pl-3">
                <b-col sm="5">
                  <ValidationProvider name="Numbers on product marketing in new markets" vid="total_number_product_marketing_in_new_market" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="total_number_product_marketing_in_new_market"
                      label-cols-lg="9"
                      >
                      <template v-slot:label>
                        {{ $t('exportTrophyConfig.total_number_product_marketing_in_new_market') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="total_number_product_marketing_in_new_market"
                        v-model="formData.total_number_product_marketing_in_new_market"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="pl-3">
                <b-col sm="5">
                  <ValidationProvider name="Total number on new product additions" vid="total_number_new_product_addition" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="total_number_new_product_addition"
                      label-cols-lg="9"
                      >
                      <template v-slot:label>
                        {{ $t('exportTrophyConfig.total_number_new_product_addition') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="total_number_new_product_addition"
                        v-model="formData.total_number_new_product_addition"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="pl-3">
                <b-col sm="5">
                  <ValidationProvider name="Total number on compliance" vid="total_number_compliance" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="total_number_compliance"
                      label-cols-lg="9"
                      >
                      <template v-slot:label>
                        {{ $t('exportTrophyConfig.total_number_compliance') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="total_number_compliance"
                        v-model="formData.total_number_compliance"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="text-right mb-2 ml-1 mr-4">
                <b-col sm="5">
                  <b-button :disabled="isDisabled" type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                </b-col>
              </b-row>
            </b-form>
          </b-overlay>
        </ValidationObserver>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { etEvaluationGetApi, etEvaluationApi } from '../../api/routes'

export default {
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      loading: false,
      total: 0,
      isDisabled: false,
      formData: {
        total_number_export_earning: '',
        total_number_export_income: '',
        total_number_product_marketing_in_new_market: '',
        total_number_new_product_addition: '',
        total_number_compliance: ''
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'formData.total_number_export_earning': function (newVal, oldVal) {
      this.totalCalculation()
    },
    'formData.total_number_export_income': function (newVal, oldVal) {
      this.totalCalculation()
    },
    'formData.total_number_product_marketing_in_new_market': function (newVal, oldVal) {
      this.totalCalculation()
    },
    'formData.total_number_new_product_addition': function (newVal, oldVal) {
      this.totalCalculation()
    },
    'formData.total_number_compliance': function (newVal, oldVal) {
     this.totalCalculation()
    }
  },
  methods: {
    totalCalculation () {
      const totalNumberExportEarning = Number(this.formData.total_number_export_earning)
      const totalNumberExportIncome = Number(this.formData.total_number_export_income)
      const totalNumberProductMarketingInNewMarket = Number(this.formData.total_number_product_marketing_in_new_market)
      const totalNumberNewProductAddition = Number(this.formData.total_number_new_product_addition)
      const totalNumberCompliance = Number(this.formData.total_number_compliance)
      const result = totalNumberExportEarning + totalNumberExportIncome + totalNumberProductMarketingInNewMarket + totalNumberNewProductAddition + totalNumberCompliance
      if (result > 100 || result < 100) {
        this.isDisabled = true
        this.$toast.error({
          title: 'Wairning',
          message: this.$t('exportTrophyConfig.hundred'),
          color: '#ee5253'
        })
      } else {
        this.isDisabled = false
      }
    },
    async loadData () {
      this.loading = true
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, etEvaluationGetApi)
      if (result.success) {
        if (result.data === null) {
          this.formData.total_number_export_earning = ''
          this.formData.total_number_export_income = ''
          this.formData.total_number_product_marketing_in_new_market = ''
          this.formData.total_number_new_product_addition = ''
          this.formData.total_number_compliance = ''
        } else {
          this.formData = result.data
        }
        this.loading = false
      }
    },
    async saveUpdate () {
      this.loading = true
      let result = null
      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, etEvaluationApi, this.formData)

      this.loading = false
      if (result.success) {
        this.formData = result.data
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$toast.error({
          title: 'Wairning',
          message: this.$t('exportTrophyConfig.hundred'),
          color: '#ee5253'
        })
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
