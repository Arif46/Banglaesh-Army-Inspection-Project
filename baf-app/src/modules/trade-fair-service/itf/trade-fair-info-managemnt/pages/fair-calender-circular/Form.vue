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
                  v-model="data.fiscal_year_id"
                  @input="getFiscalYear(data.fiscal_year_id)"
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
            <ValidationProvider name="Circular Memo No" vid="circular_memo_number" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="circular_memo_number">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.circular_memo_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="circular_memo_number"
                  v-model="data.circular_memo_number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Subject (En)" vid="subject_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="subject_en">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.subject') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="subject_en"
                  v-model="data.subject_en"
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
                label-for="subject_bn">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.subject') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="subject_bn"
                  v-model="data.subject_bn"
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
                label-for="fair_sector_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="data.description_en"
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
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="data.description_bn"
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
            <ValidationProvider name="Submition Deadline" vid="submission_deadline" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.submission_deadline') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="submission_deadline"
                  class="form-control"
                  v-model="data.submission_deadline"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  :config="{ static: true, minDate: 'today', maxDate: maxDate }"
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
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('globalTrans.attachment') }}
                  <span v-if="data?.attachment">
                    <a target="_blank" :href="baseUrl + 'storage/' + data?.attachment" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                  </span>
                </template>
                <b-form-file id="attachment"
                  v-model="data.file"
                  v-on:change="onFileChange"
                  accept=".doc,.docx,.pdf"
                  class="mt-2" plain
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                <div class="invalid-feedback d-block text-muted">
                  {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
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
import { fairCalenderCircularStore, fairCalenderCircularUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      assignDesignationList: [],
      baseUrl: internationalTradeFairServiceBaseUrl,
      minDate: '',
      maxDate: '',
      data: {
        create_user_id: this.$store.state.Auth.authUser.user_id,
        designation_id: this.$store.state.Auth.authUser.office_detail.designation_id,
        fiscal_year_id: 0,
        circular_memo_number: '',
        subject_en: '',
        subject_bn: '',
        description_en: '',
        description_bn: '',
        submission_deadline: '',
        attachment: '',
        file: []
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getSubsidyCategory()
      this.data = tmp
      this.data.oldfile = tmp.attachment
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  methods: {
    getFiscalYear (id) {
      const fiscalyear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      this.minDate = fiscalyear.start_date
      this.maxDate = fiscalyear.end_date
    },
    onFileChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.data.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.data.attachment = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairCalenderCircularUpdate}/${this.id}`, this.data)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairCalenderCircularStore, this.data)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        // this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getSubsidyCategory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
