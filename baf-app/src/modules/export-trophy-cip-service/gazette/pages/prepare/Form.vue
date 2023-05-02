<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="6">
          <ValidationProvider name="Award Type" vid="type" rules="required|min_value:1">
            <b-form-group
              class="row"
              label-for="type"
              slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.type')}} <span class="text-danger">*</span>
              </template>
              <b-form-radio-group
                  v-model="form.type"
                  :options="typeList"
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
        <b-col sm="6">
          <ValidationProvider name="Memo No" vid="memo_no" rules="required">
            <b-form-group
              label-for="memo_no"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.memo_no')}} <span class="text-danger">*</span>
            </template>
            <b-form-input
              plain
              v-model="form.memo_no"
              id="memo_no"
              :state="errors[0] ? false : (valid ? true : null)"
            >
            </b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Date En" vid="date" rules="required">
            <b-form-group
              label-for="date"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ $t('globalTrans.date') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
              </template>
                <date-picker
                  class="form-control"
                  plain
                  v-model="form.date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  id="date"
                >
                </date-picker>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col md="12">
          <ValidationProvider name="Title (En)" vid="title_en" rules="required">
            <b-form-group
              label-for="title_en"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.title_en')}} <span class="text-danger">*</span>
            </template>
            <b-form-input
              plain
              v-model="form.title_en"
              id="title_en"
              :state="errors[0] ? false : (valid ? true : null)"
            >
            </b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col md="12">
          <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required">
            <b-form-group
              label-for="title_bn"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyCircular.title_bn')}} <span class="text-danger">*</span>
            </template>
            <b-form-input
              plain
              v-model="form.title_bn"
              id="title_bn"
              :state="errors[0] ? false : (valid ? true : null)"
            >
            </b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="4">
          <ValidationProvider name="Bangla year" vid="bn_year" rules="required|min_value:1">
            <b-form-group
              label-for="bn_year"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyGazette.bn_year')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.bn_year"
              :options="banglaYearList"
              id="bn_year"
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
        <b-col sm="4">
          <ValidationProvider name="Bangla month" vid="bn_month" rules="required|min_value:1">
            <b-form-group
              label-for="bn_month"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyGazette.bn_month')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.bn_month"
              :options="banglaMonthList"
              id="bn_month"
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
        <b-col sm="4">
          <ValidationProvider name="Bangla day" vid="bn_day" rules="required|min_value:1">
            <b-form-group
              label-for="bn_day"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('exportTrophyGazette.bn_day')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.bn_day"
              :options="banglaMonthDays"
              id="day"
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
        <b-col sm="12" v-if="form.type === 1">
          <ValidationProvider name="CIP Facilities (En)" vid="cip_facilities_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="cip_facilities_en">
                <template v-slot:label>
                  {{ $t('exportTrophyGazette.cip_facilities_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="cip_facilities_en"
                  v-model="form.cip_facilities_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="10"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
        </b-col>
        <b-col sm="12" v-if="form.type === 1">
          <ValidationProvider name="CIP Facilities (Bn)" vid="cip_facilities_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="cip_facilities_bn">
                <template v-slot:label>
                  {{ $t('exportTrophyGazette.cip_facilities_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="cip_facilities_bn"
                  v-model="form.cip_facilities_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="10"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
        </b-col>
        <b-col sm="12" v-if="form.type === 1">
          <ValidationProvider name="Timeline (En)" vid="timeline_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="timeline_en">
                <template v-slot:label>
                  {{ $t('exportTrophyGazette.timeline_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="timeline_en"
                  v-model="form.timeline_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="10"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
        </b-col>
        <b-col sm="12" v-if="form.type === 1">
          <ValidationProvider name="Timeline (Bn)" vid="timeline_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="timeline_bn">
                <template v-slot:label>
                  {{ $t('exportTrophyGazette.timeline_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="timeline_bn"
                  v-model="form.timeline_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="10"
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
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { gazetteStoreApi, gazetteUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  components: {
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        type: 0,
        fiscal_year_id: 0,
        year: 0,
        memo_no: '',
        title_en: '',
        title_bn: '',
        timeline_en: '',
        timeline_bn: '',
        date: '',
        bn_year: 0,
        bn_month: 0,
        bn_day: 0,
        cip_facilities_en: '',
        cip_facilities_bn: ''
      },
      hideYear: false,
      hideFiscalYear: false
    }
  },
  watch: {
    'form.type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal === 1) {
          this.hideYear = true
          this.hideFiscalYear = false
          this.form.fiscal_year_id = 0
        }
        if (newVal === 2) {
          this.hideFiscalYear = true
          this.hideYear = false
          this.form.year = 0
          this.form.cip_facilities_en = ''
          this.form.cip_facilities_bn = ''
          this.form.timeline_en = ''
          this.form.timeline_bn = ''
        }
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getGazeetteInfo()
      tmp.cip_facilities_en = tmp.cip_facilities_en.replaceAll('<br />', '')
      tmp.cip_facilities_bn = tmp.cip_facilities_bn.replaceAll('<br />', '')
      tmp.timeline_en = tmp.timeline_en.replaceAll('<br />', '')
      tmp.timeline_bn = tmp.timeline_bn.replaceAll('<br />', '')
      this.form = tmp
      this.form.oldfile = tmp.attachment
    } else {
      this.form.type = 1
    }
  },
  computed: {
    typeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    designationList: function () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList
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
    },
    banglaMonthList () {
      return this.$store.state.commonObj.banglaMonthList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    banglaMonthDays () {
      return this.$store.state.commonObj.banglaMonthDays.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    banglaYearList () {
      const currentEnMin = new Date().getFullYear()
      const currentBnYear = (currentEnMin - 593)
      const BnOldMax = currentBnYear - 5
      const BnNewMax = currentBnYear + 5
      const newBnYears = []
      const oldBnYears = []
      for (let i = BnOldMax; i < currentBnYear; i++) {
        oldBnYears.push(i)
      }
      for (let j = currentBnYear; j <= BnNewMax; j++) {
        newBnYears.push(j)
      }
      const BanglaYearList = [...oldBnYears, ...newBnYears]
      return BanglaYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
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

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${gazetteUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, gazetteStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.error({
          title: 'Warning',
          message: result.message,
          color: '#e77171'
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
    getGazeetteInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
