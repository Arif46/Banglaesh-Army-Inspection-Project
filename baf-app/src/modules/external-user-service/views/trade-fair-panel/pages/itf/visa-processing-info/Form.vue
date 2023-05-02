<template>
  <b-row>
    <b-col class="mb-3">
        <h5 class="text-center">{{ $i18n.locale == 'en' ? visa_data.fair_name_en : visa_data.fair_name_bn }}</h5>
        <div class="text-center mb-2">{{ $i18n.locale == 'en' ? visa_data.fiscal_year_en : visa_data.fiscal_year_bn }}</div>
        <h6 class="text-center font-weight-bold">{{ visa_data ? $t('tradeFairConfig.visa_related_info') : $t('tradeFairConfig.visa_related_attach') }}</h6>
    </b-col>
    <b-col v-if="!uploadAction" xs="12" sm="12" md="12" lg="12" xl="12">
        <visa-info :visa_detail="visa_data" :baseUrl="baseUrl" />
    </b-col>
    <b-col v-else xs="12" sm="12" md="12" lg="12" xl="12">
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
          <b-form id="form" @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
            <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider :name="$t('tradeFairConfig.valid_from', 'en')" vid="visa_start_date" rules="required" v-slot="{ errors }">
                    <b-form-group class="row mb-2"
                      label-cols-sm="12"
                      label-for="visa_start_date"
                    >
                      <template v-slot:label>
                        {{ $t('tradeFairConfig.valid_from') }} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        class="form-control"
                        id="visa_start_date"
                        v-model="visa.visa_start_date"
                        :placeholder="$t('globalTrans.select_date')"
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
                  <ValidationProvider :name="$t('tradeFairConfig.expiration_date', 'en')" vid="visa_end_date" rules="required" v-slot="{ errors }">
                    <b-form-group class="row mb-2"
                      label-cols-sm="12"
                      label-for="visa_end_date"
                    >
                      <template v-slot:label>
                        {{ $t('tradeFairConfig.expiration_date') }} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        class="form-control"
                        id="visa_end_date"
                        v-model="visa.visa_end_date"
                        :placeholder="$t('globalTrans.select_date')"
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
                    <ValidationProvider :name="$t('tradeFairConfig.upload_visa_info', 'en')" vid="visa_attachment" rules="required"
                        v-slot="{ errors }"
                    >
                        <b-form-group class="row mb-2"
                            label-cols-sm="12"
                            label-for="visa_attachment">
                            <template v-slot:label>
                                {{ $t('tradeFairConfig.upload_visa_info')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-file
                                plain
                                v-on:change="onFileChange($event)"
                                v-model="attachment_input"
                                accept=".jpg,.jpeg,.pdf"
                                :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-file>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                            <div class="invalid-feedback d-block text-muted">
                                {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is JPG/JPEG/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট JPG/JPEG/PDF]' }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Comments" vid="participant_note" rules="">
                    <b-form-group
                      label-for="participant_note"
                      label-cols-sm="12"
                      slot-scope="{ errors }"
                    >
                      <template v-slot:label>
                        {{ $t('globalTrans.comments') }}
                      </template>
                      <b-form-input
                          id="participant_note"
                          v-model="visa.participant_note"
                          :state="errors[0] ? false : (valid ? true : null)"
                      >
                      </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
            </b-row>
            <b-row class="text-right">
              <b-col class="mt-2 text-right">
                  <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                  <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-2')">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </b-overlay>
      </ValidationObserver>
    </b-col>
  </b-row>
</template>
<script>
import VisaInfo from './VisaInfo'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { visaProcessingInfoStoreApi } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'uploadAction'],
  components: {
    VisaInfo
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      baseUrl: internationalTradeFairServiceBaseUrl,
      visa_data: {},
      attachment_input: [],
      visa: {
        participant_note: '',
        visa_start_date: '',
        visa_end_date: '',
        visa_attachment: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getStoreData()
      this.visa_data = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onFileChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
          this.vias.visa_attachment = event.target.files[0]
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.visa.participation_id = this.id
      const formData = new FormData()
      Object.keys(this.visa).map(key => {
          if (key === 'visa_attachment') {
              formData.append(key, this.attachment_input)
          } else {
              formData.append(key, this.visa[key])
          }
      })

      if (this.id) {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, visaProcessingInfoStoreApi, formData)
      }
      if (result.success) {
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-2')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getStoreData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
