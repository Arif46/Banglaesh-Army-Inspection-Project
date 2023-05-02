<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
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
                :options="yearList"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Holiday Date" vid="duration_start_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('configuration.holiday_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="holiday_date"
                  class="form-control"
                  v-model="form.holiday_date"
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
            <ValidationProvider name="Holiday Title En" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_en">
                <template v-slot:label>
                  {{ $t('configuration.holiday_title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
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
            <ValidationProvider name="Holiday Title Bn" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('configuration.holiday_title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
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
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { holidayStore, holidayUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        year: '',
        title_en: '',
        title_bn: '',
        holiday_date: ''
      },
      current_year: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAlertPercentage()
      this.form = tmp
    }
    if (!this.id) {
      const currentDate = new Date()
      const currentYear = currentDate.getFullYear()
      this.form.year = currentYear
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.$n(item, { useGrouping: false }) }
        } else {
          return { value: item, text: item }
        }
      })
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${holidayUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, holidayStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getAlertPercentage () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
