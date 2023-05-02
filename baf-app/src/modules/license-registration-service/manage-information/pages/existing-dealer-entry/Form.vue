<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Notice Date" vid="notice_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="notice_date">
                <template v-slot:label>
                  {{ $t('license_management.notice_date') }} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker b-form-datepicker
                  id="notice_date"
                  v-model="formData.notice_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Memorial No" vid="memorial_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="memorial_no">
                <template v-slot:label>
                  {{ $t('license_management.memorial_no') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="memorial_no"
                  v-model="formData.memorial_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Application Start Date" vid="start_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                  {{ $t('license_management.start_date') }} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker b-form-datepicker
                                    id="start_date"
                                    v-model="formData.start_date"
                                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Application End Date" vid="end_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('license_management.end_date') }} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker b-form-datepicker
                                    id="end_date"
                                    v-model="formData.end_date"
                                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Reason (En)" vid="reason">
              <b-form-group
                label-for="reason">
                <template v-slot:label>
                  {{ $t('license_management.reason_en') }}<span class="text-danger"></span>
                </template>
                <b-form-textarea
                  id="reason"
                  v-model="formData.reason"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Reason (Bn)" vid="reason_bn">
              <b-form-group
                label-for="reason_bn">
                <template v-slot:label>
                  {{ $t('license_management.reason_bn') }}<span class="text-danger"></span>
                </template>
                <b-form-textarea
                  id="reason_bn"
                  v-model="formData.reason_bn"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Comment (En)" vid="coment">
              <b-form-group
                label-for="coment">
                <template v-slot:label>
                  {{ $t('license_management.comment_en') }}<span class="text-danger"></span>
                </template>
                <b-form-textarea
                  id="coment"
                  v-model="formData.coment"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Comment (Bn)" vid="comment_bn">
              <b-form-group
                label-for="comment_bn">
                <template v-slot:label>
                  {{ $t('license_management.comment_bn') }}<span class="text-danger"></span>
                </template>
                <b-form-textarea
                  id="comment_bn"
                  v-model="formData.comment_bn"
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { recruitmentStore, recruitmentUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        notice_date: '',
        memorial_no: '',
        start_date: '',
        end_date: '',
        reason: '',
        reason_bn: '',
        coment: '',
        comment_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getRecruitmentNotice()
      this.formData = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${recruitmentUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, recruitmentStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getRecruitmentNotice () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
