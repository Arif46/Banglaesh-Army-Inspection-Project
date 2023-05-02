<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
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
                    <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Circular (Fair Participation)" vid="fair_circular_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="fiscal_year_id">
                <template v-slot:label>
                  {{ $t('exhibitCircularManagement.circular_fair_parti') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fair_circular_id"
                  :options="partiCir"
                  v-model="formData.fair_circular_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Country" vid="country_id">
              <b-form-group
                label-for="country_id">
                <template v-slot:label>
                  {{ $t('externalTradeFair.country') }}
                </template>
                <b-form-select
                  plain
                  id="country_id"
                  disabled
                  :options="countryList"
                  v-model="partiCircular.calendar_info.country_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="City (En)" vid="city">
              <b-form-group
                label-for="city"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="city"
                  disabled
                  v-model="partiCircular.calendar_info.city"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="City (Bn)" vid="city_bn">
              <b-form-group
                label-for="city_bn"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="city_bn"
                  disabled
                  v-model="partiCircular.calendar_info.city_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <div class="bg-dark w-50 m-auto rounded-pill">
                <h6 class="text-white text-center py-1"> {{ $t('exhibitCircularManagement.exhibition_cir_info') }}</h6>
            </div>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Circular Memo No" vid="circular_memo_no" rules="required" v-slot="{ errors }">
              <b-form-group
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
            <ValidationProvider name="Subject (En)" vid="subject_en" rules="required|max:255" v-slot="{ errors }">
              <b-form-group
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
            <ValidationProvider name="Subject (Bn)" vid="subject_bn" rules="required|max:255" v-slot="{ errors }">
              <b-form-group
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
            <ValidationProvider name="Description (En)" vid="description_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
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
            <ValidationProvider name="Description (Bn)" vid="description_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
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
             <ValidationProvider name="Date From" vid="date_from" rules="required"  v-slot="{ errors }">
              <b-form-group
                label-for="date_from"
              >
              <template v-slot:label>
                {{ $t('externalTradeFair.date_from') }} <span class="text-danger">*</span>
              </template>
              <date-picker
                id="date_from"
                class="form-control"
                v-model="formData.exhibit_date_from"
                :class="errors[0] ? 'is-invalid' : ''"
                :placeholder="$t('globalTrans.select')"
                :state="errors[0] ? false : (valid ? true : null)"
                :config="{ static: true }"
              >
              </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Date To" vid="date_to" rules="required"  v-slot="{ errors }">
              <b-form-group
                label-for="date_to"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.date_to') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="date_to"
                  class="form-control"
                  v-model="formData.exhibit_date_to"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :placeholder="$t('globalTrans.select')"
                  :state="errors[0] ? false : (valid ? true : null)"
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
            <ValidationProvider name="Submition Deadline" vid="deadline" rules="required" v-slot="{ errors }">
              <b-form-group
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
            <ValidationProvider name="attachment" v-slot="{ errors }">
              <b-form-group
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="formData.oldfile" :href="internationalTradeFairServiceBaseUrl + 'storage/' + formData.oldfile">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
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
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairExhibitCircularStore, fairExhibitCircularUpdate, getPartiCircularInfo } from '../../api/routes'
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
      partiCir: [],
      partiCircular: {
        calendar_info: {
          country_id: 0,
          city: '',
          city_bn: ''
        },
        subject_en: '',
        subject_bn: ''
      },
      stallInfo: null,
      subsidyInfo: null,
      formData: {
        fiscal_year_id: 0,
        fair_circular_id: 0,
        circular_memo_no: '',
        subject_en: '',
        subject_bn: '',
        description_en: '',
        description_bn: '',
        exhibit_date_from: '',
        exhibit_date_to: '',
        deadline: '',
        attachment: '',
        file: []
      }
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
        this.loading = true
        this.loadFairCircular(newVal)
      }
    },
    'formData.fair_circular_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getPartiCircularInfo(newVal)
      }
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  methods: {
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
    getPartiCircularInfo (fairId) {
      const Obj = this.partiCir.find(el => el.value === fairId)
      if (typeof Obj !== 'undefined') {
        this.partiCircular = Obj
      } else {
        this.partiCircular = ''
      }
    },
    loadFairCircular (fairId) {
      RestApi.getData(internationalTradeFairServiceBaseUrl, `${getPartiCircularInfo}/${fairId}`).then(response => {
        if (response.success) {
          this.loading = false
          this.partiCir = response.data.map(el => {
            return Object.assign({}, el, { value: el.id, text: this.$i18n.locale === 'en' ? el.subject_en : el.subject_bn })
          })

          // this.partiCircular = response.data
          // this.formData.fair_circular_id = response.data.id
          // this.partiCir = [{
          //   value: response.data.id,
          //   text: this.currentLocale === 'bn' ? response.data.subject_bn : response.data.subject_en
          // }]
        } else {
          this.partiCir = []
          this.partiCircular = ''
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
        result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairExhibitCircularUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairExhibitCircularStore, this.formData)
      }

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
        this.loading = false
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
</style>
