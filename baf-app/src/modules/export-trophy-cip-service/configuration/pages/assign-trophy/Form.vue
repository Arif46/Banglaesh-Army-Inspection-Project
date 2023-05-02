<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
            <ValidationProvider name="Award Type" vid="award_type" rules="required|min_value:1">
                <b-form-group
                  label-cols-lg="2"
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
                      :disabled="id ? disabled : disabled = false"
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
              label-cols-lg="4"
              slot-scope="{ valid, errors }"
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
              label-cols-lg="4"
              slot-scope="{ valid, errors }"
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
        <b-col sm="6" v-if="hideYear">
          <ValidationProvider name="CIP Category" vid="cip_category" rules="required|min_value:1">
            <b-form-group
              label-for="cip_category"
              label-cols-lg="4"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyConfig.cip_category')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.cip_category"
              :options="cipCategoryList"
              id="cip_category"
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
        </b-col>
        <b-col sm="12">
          <table class="table table-striped table-hover table-bordered" v-if="form.award_type === 1">
            <thead>
              <tr>
                <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                <th scope="col"> {{ $t('exportTrophyConfig.cip_sector') }} </th>
                <th scope="col">{{ $t('globalTrans.quantity') }}</th>
              </tr>
            </thead>
            <tbody>
              <template v-if="form.cip_category === 1">
                <tr v-for="(item, index) in cipExportSectorList" :key="index">
                  <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                  <td v-if="id">
                    {{ getSectorId(item.cip_sector_id) }}
                  </td>
                  <td v-else>
                    {{ currentLocale === 'bn' ? item.text_bn : item.text_en }}
                  </td>
                  <td>
                    <ValidationProvider name="Quantity" :vid="`quantity${index}`" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-input
                        id="quantity"
                        v-model="item.quantity"
                        :state="errors[0] ? false : (valid ? true : null)"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </ValidationProvider>
                  </td>
                </tr>
              </template>
              <template v-if="form.cip_category === 2">
                <tr v-for="(item, index) in cipTradeSectorList" :key="index">
                  <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                  <td v-if="id">
                    {{ getSectorId(item.cip_sector_id) }}
                  </td>
                  <td v-else>
                    {{ currentLocale === 'bn' ? item.text_bn : item.text_en }}
                  </td>
                  <td>
                    <ValidationProvider name="Quantity" :vid="`quantity${index}`" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-input
                        id="quantity"
                        v-model="item.quantity"
                        :state="errors[0] ? false : (valid ? true : null)"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
          <table class="table table-striped table-hover table-bordered" v-if="form.award_type === 2">
            <thead>
              <tr>
                <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                <th scope="col"> {{ $t('exportTrophyConfig.medal') }} </th>
                <th scope="col">{{ $t('globalTrans.quantity') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row"> {{ $n(1) }} </th>
                <td>
                  {{ $t('exportTrophyConfig.gold') }}
                </td>
                <td>
                  <ValidationProvider name="Gold" vid="gold" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-input
                      id="gold"
                      v-model="form.gold"
                      :state="errors[0] ? false : (valid ? true : null)"
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </ValidationProvider>
                </td>
              </tr>
              <tr>
                <th scope="row"> {{ $n(2) }} </th>
                <td>
                  {{ $t('exportTrophyConfig.silver') }}
                </td>
                <td>
                  <ValidationProvider name="Silver" vid="silver" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-input
                      id="silver"
                      v-model="form.silver"
                      :state="errors[0] ? false : (valid ? true : null)"
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </ValidationProvider>
                </td>
              </tr>
              <tr>
                <th scope="row"> {{ $n(3) }} </th>
                <td>
                  {{ $t('exportTrophyConfig.bronze') }}
                </td>
                <td>
                  <ValidationProvider name="bronze" vid="bronze" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-input
                      id="bronze"
                      v-model="form.bronze"
                      :state="errors[0] ? false : (valid ? true : null)"
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </ValidationProvider>
                </td>
              </tr>
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
import { assignTrophyStoreApi, assignTrophyUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        award_type: '',
        fiscal_year_id: 0,
        year: 0,
        cip_category: 0,
        details: [],
        gold: 0,
        silver: 0,
        bronze: 0
      },
      cipExportSectorDetails: [],
      hideYear: false,
      hideFiscalYear: false,
      disabled: true
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAssignTrophy()
      this.form = tmp
    }
  },
  watch: {
    'form.award_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal === 1) {
          this.hideYear = true
          this.hideFiscalYear = false
          this.form.fiscal_year_id = 0
          this.form.gold = 0
          this.form.silver = 0
          this.form.bronze = 0
        }
        if (newVal === 2) {
          this.hideFiscalYear = true
          this.hideYear = false
          this.form.year = 0
          this.form.cip_category = 0
          this.form.details = []
        }
      }
    },
    'form.cip_category': function (newVal, oldVal) {
      if ((this.form.award_type === 1) && (newVal !== oldVal)) {
        this.setDetailsData(newVal)
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
    fiscalYear () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    YearList: function () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    cipCategoryList: function () {
      return [
        {
          value: 1,
          text: this.currentLocale === 'bn' ? 'সিআইপি রপ্তানি' : 'CIP Export'
        },
        {
          value: 2,
          text: this.currentLocale === 'bn' ? 'সিআইপি ট্রেড' : 'CIP Trade'
        }
      ]
    },
    cipSectorList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.filter(el => el.status === 1)
    },
    cipTradeSectors () {
      return this.cipSectorList.filter(el => el.cip_category === 2).map(el => {
        const data = {
          cip_sector_id: typeof el !== 'undefined' ? el.value : '',
          quantity: '',
          text_bn: typeof el !== 'undefined' ? el.text_bn : '',
          text_en: typeof el !== 'undefined' ? el.text_en : ''
        }
        return Object.assign({}, data)
      })
    },
    cipExportSectors () {
      return this.cipSectorList.filter(el => el.cip_category === 1).map(el => {
        const data = {
          cip_sector_id: typeof el !== 'undefined' ? el.value : '',
          quantity: '',
          text_bn: typeof el !== 'undefined' ? el.text_bn : '',
          text_en: typeof el !== 'undefined' ? el.text_en : ''
        }
        return Object.assign({}, data)
      })
    }
  },
  methods: {
    changeCalView () {
      this.form.details = this.cipSectorList.filter(el => el.cip_category === this.form.cip_category && el.status === 1).map(el => {
        const data = {
          cip_sector_id: el !== undefined ? el.value : '',
          quantity: '',
          text_bn: el !== undefined ? el.text_bn : '',
          text_en: el !== undefined ? el.text_en : ''
        }
        return Object.assign({}, data)
      })
    },
    getSectorId (cipSectorId) {
      const sectorObj = this.cipSectorList.find(cipSec => cipSec.value === cipSectorId)
      if (sectorObj !== undefined) {
        return this.$i18n.locale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
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

      const formData = Object.assign(this.form, { details: this.form.cip_category === 1 ? this.cipExportSectorList : this.cipTradeSectorList })

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${assignTrophyUpdateApi}/${this.id}`, formData)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, assignTrophyStoreApi, formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.info({
          title: 'Warning',
          message: result.message,
          color: '#bd2130'
        })
        return
      }

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
    getAssignTrophy () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      if (tmpData.award_type === 1) {
        const tmpSectors = tmpData.cip_category === 1 ? this.cipExportSectors : this.cipTradeSectors
        const tmpDetails = tmpSectors.map(el => {
          const editSector = tmpData.details.find(item => item.cip_sector_id === el.cip_sector_id)
          const data = {
            cip_sector_id: el.cip_sector_id,
            quantity: typeof editSector !== 'undefined' ? editSector.quantity : '',
            text_bn: typeof el !== 'undefined' ? el.text_bn : '',
            text_en: typeof el !== 'undefined' ? el.text_en : ''
          }
          return Object.assign({}, data)
        })

        if (tmpData.cip_category === 1) {
          this.cipExportSectorList = tmpDetails
          this.cipTradeSectorList = this.cipTradeSectors
        } else if (tmpData.cip_category === 2) {
          this.cipExportSectorList = this.cipExportSectors
          this.cipTradeSectorList = tmpDetails
        }
      }
      return JSON.parse(JSON.stringify(tmpData))
    },
    setDetailsData (cipCategoryType) {
      if (!this.id) {
        this.cipExportSectorList = this.cipExportSectors
        this.cipTradeSectorList = this.cipTradeSectors
      }
    }
  }
}
</script>
