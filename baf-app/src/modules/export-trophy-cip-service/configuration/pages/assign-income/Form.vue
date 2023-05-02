<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
            <ValidationProvider name="Award Type" vid="award_type" rules="required|min_value:1">
                <b-form-group
                  label-cols-lg="2"
                  label-size="sm"
                  label-for="award_type"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('exportTrophyConfig.awardType')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-radio-group
                    v-model="form.award_type"
                    :options="assignTypeList"
                    value-field="value"
                    text-field="text"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-radio-group>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
            </ValidationProvider>
        </b-col>
        <b-col sm="6" v-if="hideFiscalYear">
          <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
            <b-form-group
              label-for="fiscal_year_id"
              slot-scope="{ valid, errors }"
              label-cols-lg="4"
              label-size="sm"
            >
            <template v-slot:label>
              {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.fiscal_year_id"
              :options="fiscalYear"
              id="fiscal_year_id"
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
        <b-col sm="6" v-if="hideYear">
          <ValidationProvider name="Year" vid="year" rules="required|min_value:1">
            <b-form-group
              label-for="year"
              slot-scope="{ valid, errors }"
              label-cols-lg="4"
              label-size="sm"
            >
            <template v-slot:label>
              {{$t('globalTrans.year')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.year"
              :options="YearList"
              id="year"
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
        <b-col sm="12">
          <table class="table table-striped table-hover table-bordered">
            <thead>
              <tr>
                <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                <th scope="col" v-if="form.award_type === 1"> {{ $t('exportTrophyConfig.product_sector_name') }} </th>
                <th scope="col" v-else> {{ $t('exportTrophyConfig.product_and_service_sector') }} </th>
                <th scope="col">{{ $t('exportTrophyConfig.minimum_income_usd') }}</th>
              </tr>
            </thead>
            <tbody>
              <template v-if="form.award_type === 1">
                <tr v-for="(item, index) in cipDetails" :key="index">
                  <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                  <td v-if="id">
                    {{ getServiceProduct(item.product_service_sector_id) }}
                  </td>
                  <td v-else>
                    {{ currentLocale === 'bn' ? item.text_bn : item.text_en }}
                  </td>
                  <td>
                    <ValidationProvider name="Minimum Income" :vid="`minimum_income${index}`" rules="required" v-slot="{ errors }">
                        <b-form-input
                        id="minimum_income"
                        v-model="item.minimum_income"
                        :state="errors[0] ? false : (valid ? true : null)"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        maxlength="8"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </ValidationProvider>
                  </td>
                </tr>
              </template>
              <template v-if="form.award_type === 2">
                <tr v-for="(item, index) in etDetails" :key="index">
                  <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                  <td v-if="id">
                    {{ getServiceProduct(item.product_service_sector_id) }}
                  </td>
                  <td v-else>
                    {{ currentLocale === 'bn' ? item.text_bn : item.text_en }}
                  </td>
                  <td>
                    <ValidationProvider name="Minimum Income" :vid="`minimum_income${index}`" rules="required" v-slot="{ errors }">
                        <b-form-input
                        id="minimum_income"
                        v-model="item.minimum_income"
                        :state="errors[0] ? false : (valid ? true : null)"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        maxlength="8"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </ValidationProvider>
                  </td>
                </tr>
              </template>
            </tbody>
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
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { assignIncomeStoreApi, assignIncomeUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        award_type: 0,
        fiscal_year_id: 0,
        year: 0
      },
      hideYear: false,
      hideFiscalYear: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAssignIncome()
      this.form = tmp
    }
  },
  watch: {
    'form.award_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.setDetailsData(newVal)
        if (newVal === 1) {
          this.hideYear = true
          this.hideFiscalYear = false
        }
        if (newVal === 2) {
          this.hideFiscalYear = true
          this.hideYear = false
        }
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    exportSectorList () {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(item => item.status === 1).map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    cipList () {
      return this.exportSectorList.filter(el => el.assign_for === 1).map(el => {
        const data = {
          product_service_sector_id: el !== undefined ? el.value : '',
          minimum_income: '',
          text_bn: el !== undefined ? el.text_bn : '',
          text_en: el !== undefined ? el.text_en : ''
        }
        return Object.assign({}, data)
      })
    },
    etList () {
      return this.exportSectorList.filter(el => el.assign_for === 2).map(el => {
        const data = {
          product_service_sector_id: el !== undefined ? el.value : '',
          minimum_income: '',
          text_bn: el !== undefined ? el.text_bn : '',
          text_en: el !== undefined ? el.text_en : ''
        }
        return Object.assign({}, data)
      })
    },
    fiscalYear () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    YearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item) }
        } else {
          return { value: item, text: item }
        }
      })
    }
  },
  methods: {
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.toString().replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.toString().replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      const formData = Object.assign(this.form, { details: this.form.award_type === 1 ? this.cipDetails : this.etDetails })

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${assignIncomeUpdateApi}/${this.id}`, formData)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, assignIncomeStoreApi, formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getAssignIncome () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      const productServiceList = tmpData.award_type === 1 ? this.cipList : this.etList
      const tmpDetails = productServiceList.map(el => {
        const editProductService = tmpData.details.find(item => item.product_service_sector_id === el.product_service_sector_id)
        const data = {
          product_service_sector_id: el.product_service_sector_id,
          minimum_income: typeof editProductService !== 'undefined' ? editProductService.minimum_income : '',
          text_bn: typeof el !== 'undefined' ? el.text_bn : '',
          text_en: typeof el !== 'undefined' ? el.text_en : ''
        }
        return Object.assign({}, data)
      })

      if (tmpData.award_type === 1) {
        this.cipDetails = tmpDetails
        this.etDetails = this.etList
      } else if (tmpData.award_type === 2) {
        this.etDetails = tmpDetails
        this.cipDetails = this.cipList
      }
      return JSON.parse(JSON.stringify(tmpData))
    },
    getServiceProduct (serviceProduct) {
      const exportSectorObj = this.exportSectorList.find(el => el.value === parseInt(serviceProduct))
      if (exportSectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? exportSectorObj.text_bn : exportSectorObj.text_en
      }
    },
    setDetailsData (awardType) {
      if (!this.id) {
        if (awardType === 1) {
          this.cipDetails = this.cipList
        } else if (awardType === 2) {
          this.etDetails = this.etList
        }
      }
    }
  }
}
</script>
