<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="fiscal_year_id">
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fiscal_year_id"
                  :options="fiscalYearList"
                  v-model="formData.fiscal_year_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Circular Memo No" vid="circular_memo_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="circular_memo_no">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.circular_memo_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="circular_memo_no"
                  v-model="formData.circular_memo_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Fair name" vid="fair_name_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="fair_name_id">
                <template v-slot:label>
                  {{ $t('externalTradeFair.fair_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fair_name_id"
                  :options="fairNameList"
                  v-model="formData.fair_name_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0 disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Date From" vid="date_from">
              <b-form-group
                label-cols-sm="4"
                label-for="date_from"
              >
              <template v-slot:label>
                {{ $t('externalTradeFair.date_from') }}
              </template>
              <date-picker
                id="date_from"
                class="form-control"
                v-model="fairInfo.date_from"
                disabled
                :class="errors[0] ? 'is-invalid' : ''"
                :placeholder="$t('globalTrans.select')"
                :config="{ static: true }"
              >
              </date-picker>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Date To" vid="date_to">
              <b-form-group
                label-cols-sm="4"
                label-for="date_to"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.date_to') }}
                </template>
                <date-picker
                  id="date_to"
                  class="form-control"
                  disabled
                  v-model="fairInfo.date_to"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :placeholder="$t('globalTrans.select')"
                >
                </date-picker>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Country" vid="country_id">
              <b-form-group
                label-cols-sm="4"
                label-for="country_id">
                <template v-slot:label>
                  {{ $t('externalTradeFair.country') }}
                </template>
                <b-form-select
                  plain
                  id="country_id"
                  disabled
                  :options="countryList"
                  v-model="fairInfo.country_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="City (En)" vid="city">
              <b-form-group
                label-cols-sm="4"
                label-for="city"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="city"
                  disabled
                  v-model="fairInfo.city"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="City (Bn)" vid="city_bn">
              <b-form-group
                label-cols-sm="4"
                label-for="city_bn"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="city_bn"
                  disabled
                  v-model="fairInfo.city_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="mb-3">
                <div class="bg-dark w-50 m-auto rounded-pill">
                    <h6 class="text-white text-center py-1"> {{ $t('tradeFairPartiCircularManagement.fair_parti_cir_info') }}</h6>
                </div>
                <div v-if="!stallInfo && !subsidyInfo">
                    <p class="text-center blink_me mt-3 mb-3" style="font-size: 18px">
                      {{ (currentLocale === 'bn') ? 'মেলায় অংশগ্রহণের বিজ্ঞপ্তি তৈরি করার পূর্বে, অনুগ্রহ করে মেলার স্টলের তথ্য এবং ভর্তুকির তথ্য কনফিগার করুন!' : 'Before Create Fair Participation Circular, Please Configure Fair Stall Information & Subsidy Information!' }}
                    </p>
                </div>
                <div v-else>
                  <table width="100%" style="margin-top: 10px">
                    <thead>
                      <tr><th colspan="6" class="text-center">{{ $t('tradeFairPartiCircularManagement.stall_info') }}</th></tr>
                      <tr>
                        <th style="width:10%">{{ $t('globalTrans.sl_no') }}</th>
                        <th style="width:15%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                        <th style="width:30%">{{ $t('tradeFairConfig.stall_size') }}</th>
                        <th style="width:15%">{{ $t('tradeFairConfig.stall_type') }}</th>
                        <th style="width:15%">{{ $t('tradeFairConfig.booth_rent') }}</th>
                        <th style="widht:15%">{{ $t('externalTradeFair.corner_booth_rent') }}</th>
                      </tr>
                    </thead>
                    <b-tbody v-for="(item, catId, index) in stallInfo" :key="index">
                        <b-tr v-for="(itm, indx) in stallInfo[catId]" :key="indx">
                            <b-td v-if="indx == 0" :rowspan="stallInfo[catId].length" class="text-center align-middle" style="width: 8%">{{ $n(index + 1) }}</b-td>
                            <b-td v-if="indx == 0" :rowspan="stallInfo[catId].length" class="text-center align-middle" style="width: 15%">{{ getStallCategoryName(catId) }}</b-td>
                            <b-td>{{ $n(itm.stall_size) + ' ' + (getMeasurementUnitList(itm.measurement_id)) }}</b-td>
                            <b-td>{{ getStallType(itm.stall_type) }} </b-td>
                            <b-td>{{ $n(itm.booth_rent, { useGrouping: false }) }} </b-td>
                            <b-td>{{ $i18n.locale === 'en' ? itm.description_en : itm.description_bn }}</b-td>
                        </b-tr>
                        <b-tr v-if="!stallInfo">
                          <td colspan="6" class="text-center">
                            <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                          </td>
                        </b-tr>
                    </b-tbody>
                  </table>
                  <table width="100%" v-if="subsidyInfo && stallInfo">
                    <thead>
                      <tr><th colspan="4" class="text-center">{{ $t('tradeFairConfig.subsidy_information') }}</th></tr>
                      <tr><td colspan="4" class="text-left"><b>{{ $t('tradeFairConfig.fair_sector') + ': ' }}</b> {{ getFairSector(subsidyInfo.circular.fair_sector_id) }}</td></tr>
                      <tr>
                        <th style="width:10%">{{ $t('globalTrans.sl_no') }}</th>
                        <th style="width:30%">{{ $t('tradeFairConfig.subsidy_category') }}</th>
                        <th style="width:30%">{{ $t('externalTradeFair.subsidy_range_data') }}</th>
                        <th style="width:30%">{{ $t('externalTradeFair.subsidy_p') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                        <b-tr v-for="(item, index) in subsidyInfo?.details.filter(el => parseInt(el.fair_sector_id) === fairInfo.fair_sector_id)" :key="index">
                            <b-td>{{ $n(index + 1) }} </b-td>
                            <b-td>{{ getSubsidyCatName(item.subsidy_cat_id) }}</b-td>
                            <b-td>{{ $i18n.locale === 'en' ? item.range_en : item.range_bn }}</b-td>
                            <b-td>{{ $n(item.subsidy) + '%' }}</b-td>
                        </b-tr>
                        <b-tr v-if="!subsidyInfo.details.length">
                          <td colspan="4" class="text-center">
                            <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                          </td>
                        </b-tr>
                    </b-tbody>
                  </table>
                  <table width="100%" v-if="subsidyInfo && stallInfo">
                    <thead>
                      <tr><td colspan="4" class="text-left"><b>{{ $t('tradeFairConfig.fair_sector') + ': ' }} </b> {{ currentLocale === 'bn' ? 'অন্যান্য' : 'Others' }}</td></tr>
                      <tr>
                          <th style="width:10%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:30%">{{ $t('tradeFairConfig.subsidy_category') }}</th>
                          <th style="width:30%">{{ $t('externalTradeFair.subsidy_range_data') }}</th>
                          <th style="width:30%">{{ $t('externalTradeFair.subsidy_p') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                        <b-tr v-for="(item, index2) in subsidyInfo.details.filter(el => parseInt(el.fair_sector_id) !== fairInfo.fair_sector_id)" :key="index2">
                            <b-td>{{ $n(index2 + 1) }}</b-td>
                            <b-td>{{ getSubsidyCatName(item.subsidy_cat_id) }}</b-td>
                            <b-td>{{ $i18n.locale === 'en' ? item.range_en : item.range_bn }}</b-td>
                            <b-td>{{ $n(item.subsidy) + '%' }}</b-td>
                        </b-tr>
                        <b-tr v-if="!subsidyInfo.details.length">
                          <td colspan="8" class="text-center">
                            <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                          </td>
                        </b-tr>
                    </b-tbody>
                  </table>
                </div>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Subject (En)" vid="subject_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="subject_en">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.subject') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="subject_en"
                  v-model="formData.subject_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Subject (Bn)" vid="subject_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="subject_bn">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.subject') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="subject_bn"
                  v-model="formData.subject_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en" rules="" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="fair_sector_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="formData.description_en"
                  rows="3"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="formData.description_bn"
                  rows="3"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Submition Deadline" vid="deadline" rules="required" v-slot="{ errors }">
              <b-form-group
                label-cols-sm="4"
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.submission_deadline') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="deadline"
                  class="form-control"
                  v-model="formData.deadline"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  :config="{ static: true }"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="attachment">
              <b-form-group
                label-cols-sm="4"
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="formData.oldfile" :href="internationalTradeFairServiceBaseUrl + '/storage/itf/FPCM/circular/' + formData.oldfile">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                </template>
                <b-form-file id="attachment"
                  v-model="formData.file"
                  v-on:change="onFileChange"
                  accept=".doc,.docx,.pdf"
                  class="mt-2" plain
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button type="submit" :disabled="(!stallInfo && !subsidyInfo) ? true : false" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartiCircularStore, fairPartiCircularUpdate, getFairStallSubsidyInfo } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      fairInfo: {
        date_from: '',
        date_to: '',
        country_id: 0,
        city: '',
        city_bn: ''
      },
      stallInfo: null,
      subsidyInfo: null,
      formData: {
        fiscal_year_id: 0,
        circular_memo_no: '',
        fair_name_id: 0,
        subject_en: '',
        subject_bn: '',
        description_en: '',
        description_bn: '',
        deadline: '',
        attachment: '',
        file: []
      },
      stallCategoryList: [],
      fairNameList: []
    }
  },
  created () {
    this.formData.fiscal_year_id = this.$store.state.currentFiscalYearId
    if (this.id) {
      const tmp = this.getFairPartiCircular()
      this.formData = tmp
      this.formData.oldfile = tmp.attachment
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    countryList () {
      return this.$store.state.CommonService.commonObj.countryList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    }
  },
  watch: {
    'formData.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    'formData.fair_name_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loading = true
        this.getStallSubsidyInfo(newVal)
      }
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  methods: {
    getFairNameList () {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.formData.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    getStallCategoryName (id) {
      const dataStallCategory = this.stallCategoryList.find(item => item.value === parseInt(id))
      if (typeof dataStallCategory !== 'undefined') {
        return this.$i18n.locale === 'en' ? dataStallCategory.text_en : dataStallCategory.text_bn
      } else {
        return ''
      }
    },
    getMeasurementUnitList (id) {
      const dataMeasurementUnit = this.$store.state.TradeFairService.commonObj.measurementUnitList.find(item => item.value === parseInt(id))
      if (typeof dataMeasurementUnit !== 'undefined') {
        return this.$i18n.locale === 'en' ? dataMeasurementUnit.text_en : dataMeasurementUnit.text_bn
      } else {
        return ''
      }
    },
    getStallType (id) {
      const stallObj = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === id)
      if (stallObj !== undefined) {
        return this.currentLocale === 'bn' ? stallObj.text_bn : stallObj.text_en
      }
    },
    getSubsidyCatName (id) {
      const subsidyCatObj = this.$store.state.TradeFairService.commonObj.subsidyCategoryList.find(item => item.value === id)
      if (subsidyCatObj !== undefined) {
        return this.currentLocale === 'bn' ? subsidyCatObj.text_bn : subsidyCatObj.text_en
      }
    },
    getFairSector (sector) {
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getStallSubsidyInfo (fairId) {
      RestApi.getData(internationalTradeFairServiceBaseUrl, `${getFairStallSubsidyInfo}/${fairId}`).then(response => {
        if (response.success) {
          this.fairInfo = response.fairInfo
          this.stallInfo = response.stallInfo
          this.subsidyInfo = response.subsidyInfo
          this.stallCategoryList = response.stallCategoryList
        }
        this.loading = false
      })
    },
    onFileChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.formData.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.formData.attachment = ''
      }
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairPartiCircularUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartiCircularStore, this.formData)
      }
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.loading = false
        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getFairPartiCircular () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
<style scoped>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
  .blink_me {
    animation: blinker 2.5s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      /* background-color: green; */
    }
  }
</style>
