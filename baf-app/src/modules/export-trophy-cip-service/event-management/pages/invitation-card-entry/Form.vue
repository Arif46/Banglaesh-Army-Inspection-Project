<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Award Type" vid="award_type" rules="required|min_value:1">
            <b-form-group
              class="row"
              label-cols-sm="4"
              label-for="award_type"
              slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('eventManage.award_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-radio-group
                  class="mt-2"
                  v-model="form.award_type"
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
         <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="hideFiscalYear">
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
        <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="hideYear">
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
      </b-row>
      <b-row>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Event" vid="event_id" rules="required|min_value:1">
            <b-form-group
              label-for="event_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{ $t('eventManage.event') }} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.event_id"
              :options="eventList"
              id="event_id"
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
          <ValidationProvider name="Venue" vid="venue_id" rules="required|min_value:1">
            <b-form-group
              label-for="venue_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{ $t('eventManage.venue') }} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.venue_id"
              :options="venueList"
              id="venue_id"
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
          <ValidationProvider name="Date" vid="date_time" rules="required">
            <b-form-group
              label-for="date_time"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ $t('globalTrans.date') }}<span class="text-danger">*</span>
              </template>
              <date-picker
                class="form-control"
                plain
                v-model="form.date_time"
                id="date"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </date-picker>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Attachment" vid="attachment">
            <b-form-group
              label-for="attachment"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.attachment')}}
                <span v-if="id != 0 && form.attachment !== null">
                 <a target="_blank" :href="exportTrophyCIPServiceBaseUrl + form.attachment" class="text-muted text-success"><i class="ri-mail-download-fill"></i>{{ $t('globalTrans.download') }}</a>
              </span>
              </template>
              <b-form-file
                  id="attachment"
                  accept=".doc,.docx,.pdf"
                  v-model="form.file"
                  @change="handleAttachment"
                  :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-file>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Description (En)" vid="description_en">
            <b-form-group
              label-for="description_en"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.description_en')}}
              </template>
              <b-form-textarea
                  id="description_en"
                  v-model="form.description_en"
              >
              </b-form-textarea>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Description (Bn)" vid="description_bn">
            <b-form-group
              label-for="description_bn"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.description_bn')}}
              </template>
              <b-form-textarea
                  id="description_bn"
                  v-model="form.description_bn"
              >
              </b-form-textarea>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
          <b-button type="submit" id="save" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
          <b-button variant="danger" id="cancel" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { invitationCardStore, invitationCardUpdate } from '../../api/routes'
// import moment from 'moment'

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
        year: 0,
        title_en: '',
        title_bn: '',
        venue_id: 0,
        date_time: '',
        attachment: null,
        description_en: '',
        description_bn: '',
        event_id: 0,
        file: []
      },
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      hideYear: false,
      hideFiscalYear: false
    }
  },
  watch: {
    'form.award_type': function (newVal, oldVal) {
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
        }
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getInvitationCard()
      this.form = tmp
      this.form.oldfile = tmp.attachment
    } else {
      this.form.award_type = 1
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
    fiscalYear () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    venueList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.venueList.filter(item => item.status === 1)
    },
    eventList: function () {
      //  const today = moment(new Date()).format('YYYY-MM-DD')
      return this.$store.state.ExportTrophyCipService.commonObj.eventList
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
    handleAttachment (e) {
      const selectedFile = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.attachment = event.target.result
      }
      reader.readAsDataURL(selectedFile)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${invitationCardUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, invitationCardStore, this.form)
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
    getInvitationCard () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
