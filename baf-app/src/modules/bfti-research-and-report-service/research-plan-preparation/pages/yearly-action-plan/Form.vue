<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Title (En)" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_en">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_en"
                  v-model="form.title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="form.title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Client (Organization/Ministry/ Division) (En)" vid="client_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="client_en">
                <template v-slot:label>
                  {{ $t('research_plan_management.client_organization_ministry_division') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="client_en"
                  v-model="form.client_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Client (Organization/Ministry/ Division) (Bn)" vid="client_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="client_bn">
                <template v-slot:label>
                  {{ $t('research_plan_management.client_organization_ministry_division') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="client_bn"
                  v-model="form.client_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Budget" vid="budget" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="budget">
                <template v-slot:label>
                  {{ $t('research_plan_management.budget') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type="number"
                  id="budget"
                  v-model="form.budget"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Budget Source (En)" vid="budget_source_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="budget_source_en">
                <template v-slot:label>
                  {{ $t('research_plan_management.budget_source') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="budget_source_en"
                  v-model="form.budget_source_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Budget Source (Bn)" vid="budget_source_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="budget_source_bn">
                <template v-slot:label>
                  {{ $t('research_plan_management.budget_source') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="budget_source_bn"
                  v-model="form.budget_source_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Date From" vid="date_from" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.date_from') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                                   id="date_from"
                                   class="form-control"
                                   v-model="form.date_from"
                                   :state="errors[0] ? false : (valid ? true : null)"
                                   :placeholder="$t('globalTrans.select')"
                                   :locale="currentLocale"
                                   @input="diffYearMonthDay"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Date To" vid="date_to" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.date_to') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                                   id="date_to"
                                   class="form-control"
                                   v-model="form.date_to"
                                   :state="errors[0] ? false : (valid ? true : null)"
                                   :placeholder="$t('globalTrans.select')"
                                   :locale="currentLocale"
                                   @input="diffYearMonthDay"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Duration (En)" vid="duration_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="duration_en">
                <template v-slot:label>
                  {{ $t('research_plan_management.duration') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="duration_en"
                  v-model="form.duration_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Duration (Bn)" vid="duration_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="duration_bn">
                <template v-slot:label>
                  {{ $t('research_plan_management.duration') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="duration_bn"
                  v-model="form.duration_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Reamrks" vid="remarks" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }}
                </template>
                <b-form-textarea
                  id="remarks"
                  v-model="form.remarks"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Attachment" vid="attachment" v-slot="{ errors }">
              <b-form-group
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('bfti.attachment') }}
                </template>
                <b-form-file
                  id="attachment"
                  v-model="form.attachment"
                  @change="onChange"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.attachment_placeholder')"
                  drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <template class="pb-3" v-if="form.id && form.attachment">
              <a :href="bftiResReportServiceBaseUrl + (isImage(form.attachment) ? 'storage/' : '') + form.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
            </template>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm" id="btn-submit">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')" id="btn-cancel">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { yearlyActionPlanStore, yearlyActionPlanUpdate, prepareEioShow } from '../../api/routes'
import { helpers } from '@/utils/helper-functions'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      form: {
        title_en: '',
        title_bn: '',
        client_en: '',
        client_bn: '',
        budget: '',
        budget_source_en: '',
        budget_source_bn: '',
        date_from: '',
        date_to: '',
        duration_en: '',
        duration_bn: '',
        remarks: '',
        attachment: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFormData()
      this.form = tmp
    }
  },
  watch: {
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    rfpTypeList () {
      return [
        {
          value: 1,
          text_en: 'EOI',
          text_bn: 'ইওআই',
          text: this.currentLocale === 'bn' ? 'ইওআই' : 'EOI'
        },
        {
          value: 2,
          text_en: 'Without EOI',
          text_bn: 'ইওআই ছাড়া',
          text: this.currentLocale === 'bn' ? 'ইওআই ছাড়া' : 'Without EOI'
        }
      ]
    },
    currentLocale () {
      return this.$i18n.locale
    },
    eoiList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.eoiList
    }
  },
  methods: {
    async loadData () {
      const loadingState = { loading: true, listReload: false }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, prepareEioShow + '/' + this.$route.params.id)
      if (result.success) {
        this.form = result.data
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    },
    diffYearMonthDay () {
      if (this.form.date_from && this.form.date_to) {
        const dt1 = new Date(this.form.date_from)
        const dt2 = new Date(this.form.date_to)
        const time = (dt2.getTime() - dt1.getTime()) / 1000
        const divisionNumberForYear = 60 * 60 * 24 * 365
        const divisionNumberForMonth = 60 * 60 * 24 * 30
        const divisionNumberForDay = 60 * 60 * 24
        const year = Math.abs(Math.floor(time / divisionNumberForYear))
        const month = Math.abs(Math.floor((time - (year * divisionNumberForYear)) / divisionNumberForMonth))
        const days = Math.abs(Math.floor((time - (year * divisionNumberForYear) - (month * divisionNumberForMonth)) / divisionNumberForDay))
        this.form.duration_en = year + ' ' + this.$t('research_plan_management.years', 'en') + ', ' + month + ' ' + this.$t('research_plan_management.months', 'en') + ', ' + days + ' ' + this.$t('research_plan_management.days', 'en')
        this.form.duration_bn = helpers.convertEnglishToBanglaNumber(year) + ' ' + this.$t('research_plan_management.years', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(month) + ' ' + this.$t('research_plan_management.months', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(days) + ' ' + this.$t('research_plan_management.days', 'bn')
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${yearlyActionPlanUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, yearlyActionPlanStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
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
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    }
  }
}
</script>
