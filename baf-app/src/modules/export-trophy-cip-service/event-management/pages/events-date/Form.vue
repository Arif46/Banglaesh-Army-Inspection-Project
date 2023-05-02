<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Event Title (En)" vid="title_en" rules="required">
            <b-form-group
              label-for="title_en"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('eventManage.event_title')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              plain
              v-model="event.title_en"
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
          <ValidationProvider name="Event Title (Bn)" vid="title_bn" rules="required">
            <b-form-group
              label-for="title_bn"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('eventManage.event_title')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              plain
              v-model="event.title_bn"
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
              v-model="event.venue_id"
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
          <ValidationProvider name="Date" vid="date" rules="required">
            <b-form-group
              label-for="date"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
              </template>
              <date-picker
                class="form-control"
                plain
                v-model="event.date"
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
          <ValidationProvider name="Start Time" vid="start_time" rules="required">
            <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="start_time"
                slot-scope="{ valid, errors }"
               >
                <template v-slot:label>
                    {{$t('eventManage.start_time')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="start_time"
                    type="time"
                    v-model="event.start_time"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name=" End Time" vid="end_time" rules="required">
            <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="end_time"
                slot-scope="{ valid, errors }"
               >
                <template v-slot:label>
                    {{$t('eventManage.end_time')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="end_time"
                    type="time"
                    v-model="event.end_time"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
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
                  v-model="event.description_en"
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
                  v-model="event.description_bn"
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
import { eventDateEntryStore, eventDateEntryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      event: {
        title_en: '',
        title_bn: '',
        venue_id: 0,
        date: '',
        start_time: '',
        end_time: '',
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEventData()
      this.event = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    venueList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.venueList.filter(item => item.status === 1)
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
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${eventDateEntryUpdate}/${this.id}`, this.event)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, eventDateEntryStore, this.event)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.error({
          title: 'Warning',
          message: this.$t('eventManage.event_exists'),
          color: '#D6E09B'
        })
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
    getEventData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
