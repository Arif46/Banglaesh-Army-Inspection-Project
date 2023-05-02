<template>
  <b-row>
    <b-overlay :show="unitLoad">
      <template>
        <div class="bg-primary mb-3">
            <h5 class="text-white text-center"> {{ $t('externalUser.attachment') }}</h5>
        </div>
      </template>
      <b-col md="12">
        <ValidationObserver ref="formattachment"  v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
              <b-row>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Latest year tax certificate" vid="attachment_all_doc.latest_year_tax_certificate" :rules="attachment_all_doc.latest_year_tax_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.latest_year_tax_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.latest_year_tax_certificate')}} <span v-if="attachment_all_doc.latest_year_tax_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'latest_year_tax_certificate_input')"
                      v-model="latest_year_tax_certificate_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                    <span v-if="attachment_all_doc.latest_year_tax_certificate_oldfile">
                      <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.latest_year_tax_certificate_oldfile" title="Latest year tax certificate" class="mr-3"> <span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                    </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Vat certificate" vid="attachment_all_doc.vat_certificate" :rules="attachment_all_doc.vat_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.vat_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.vat_certificate')}} <span v-if="attachment_all_doc.vat_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'vat_certificate_input')"
                      v-model="vat_certificate_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.vat_certificate_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.vat_certificate_oldfile" title="Vat certificate" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Custom duty certificate" vid="attachment_all_doc.custom_duty_certificate" :rules="attachment_all_doc.custom_duty_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.custom_duty_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.custom_duty_certificate')}} <span v-if="attachment_all_doc.custom_duty_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-model="custom_duty_certificate_input"
                      v-on:change="commonFileUpload($event, 'custom_duty_certificate_input')"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.custom_duty_certificate_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.custom_duty_certificate_oldfile" title="Custom duty certificate" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue" vid="attachment_all_doc.income_tax_certificate" :rules="attachment_all_doc.income_tax_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.income_tax_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.income_tax_certificate')}} <span v-if="attachment_all_doc.income_tax_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'income_tax_certificate_input')"
                      v-model="income_tax_certificate_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                    <span v-if="attachment_all_doc.income_tax_certificate_oldfile">
                      <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.income_tax_certificate_oldfile" title="Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                    </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Related Banks Non-Loan Defaulter Certificate" vid="attachment_all_doc.loan_certificate" :rules="attachment_all_doc.loan_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.loan_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.loan_certificate')}} <span v-if="attachment_all_doc.loan_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'loan_certificate_input')"
                      v-model="loan_certificate_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.loan_certificate_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.loan_certificate_oldfile" title="Related Banks Non-Loan Defaulter Certificate" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Certificate of Incorporation" vid="attachment_all_doc.incorporation_certificate" :rules="attachment_all_doc.incorporation_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.incorporation_certificate"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.incorporation_certificate')}} <span v-if="attachment_all_doc.incorporation_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'incorporation_certificate_input')"
                      v-model="incorporation_certificate_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.incorporation_certificate_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.incorporation_certificate_oldfile" title="Certificate of Incorporation" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Bank PRC (Last Fiscal Year)" vid="attachment_all_doc.bank_prc_last_fical_year" :rules="attachment_all_doc.bank_prc_last_fical_year_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.bank_prc_last_fical_year"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.bank_prc_last_fical_year')}} <span v-if="attachment_all_doc.bank_prc_last_fical_year_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'bank_prc_last_fical_year_input')"
                      v-model="bank_prc_last_fical_year_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.bank_prc_last_fical_year_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.bank_prc_last_fical_year_oldfile" title="Bank PRC (Last Fiscal Year)" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
                <b-col xl="8" lg="8" sm="8">
                  <ValidationProvider name="Bank PRC (Latest Fiscal Year)" vid="attachment_all_doc.bank_prc_latest_fical_year" :rules="attachment_all_doc.bank_prc_latest_fical_year_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment_all_doc.bank_prc_latest_fical_year"
                        label-cols-sm="6"
                      >
                      <template v-slot:label>
                        {{ $t('externalUser.bank_prc_latest_fical_year')}} <span v-if="attachment_all_doc.bank_prc_latest_fical_year_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                      </template>
                      <b-form-file
                      plain
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-on:change="commonFileUpload($event, 'bank_prc_latest_fical_year_input')"
                      v-model="bank_prc_latest_fical_year_input"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xl="4" lg="4" sm="4">
                  <span v-if="attachment_all_doc.bank_prc_latest_fical_year_oldfile">
                    <a target="_blank" :href="baseUrl + 'download-attachment?file=' + attachment_all_doc.bank_prc_latest_fical_year_oldfile" title="Bank PRC (Latest Fiscal Year)" class="mr-3"><span class="bg-primary text-white p-1 rounded"> {{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </span></a>
                  </span>
                </b-col>
              </b-row>
          </b-form>
        </ValidationObserver>
      </b-col>
    </b-overlay>
  </b-row>
</template>

<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipApplicationAttachmentStoreApi } from '../../api/routes'
export default {
    props: ['app_id', 'attachment_all_doc', 'app_status'],
    data () {
      return {
        baseUrl: exportTrophyCIPServiceBaseUrl,
        valid: null,
        unitLoad: false,
        isFileLarge: false,
        latest_year_tax_certificate_input: [],
        vat_certificate_input: [],
        custom_duty_certificate_input: [],
        income_tax_certificate_input: [],
        loan_certificate_input: [],
        incorporation_certificate_input: [],
        bank_prc_last_fical_year_input: [],
        bank_prc_latest_fical_year_input: []
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      sizeValidation (e, inputFieldName) {
        const bytesize = e.target.files[0].size
        const kbsize = bytesize / 1024
        if (kbsize > 2048) {
          this.isFileLarge = true
          if (inputFieldName === 'latest_year_tax_certificate_input') {
              this.attachment_all_doc.latest_year_tax_certificate = ''
              this.latest_year_tax_certificate_input = []
            }
            if (inputFieldName === 'vat_certificate_input') {
              this.attachment_all_doc.vat_certificate = ''
              this.vat_certificate_input = []
            }
            if (inputFieldName === 'custom_duty_certificate_input') {
              this.attachment_all_doc.custom_duty_certificate = ''
              this.custom_duty_certificate_input = []
            }
            if (inputFieldName === 'income_tax_certificate_input') {
              this.attachment_all_doc.income_tax_certificate = ''
              this.income_tax_certificate_input = []
            }
            if (inputFieldName === 'loan_certificate_input') {
              this.attachment_all_doc.loan_certificate = ''
              this.loan_certificate_input = []
            }
            if (inputFieldName === 'incorporation_certificate_input') {
              this.attachment_all_doc.incorporation_certificate = ''
              this.incorporation_certificate_input = []
            }
            if (inputFieldName === 'bank_prc_last_fical_year_input') {
              this.attachment_all_doc.bank_prc_last_fical_year = ''
              this.bank_prc_last_fical_year_input = []
            }
            if (inputFieldName === 'bank_prc_latest_fical_year_input') {
              this.attachment_all_doc.bank_prc_latest_fical_year = ''
              this.bank_prc_latest_fical_year_input = []
            }
          this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: this.$t('externalUser.filesize'),
            color: '#ee5253'
          })
        } else {
          this.isFileLarge = false
        }
      },
      commonFileUpload (e, inputFieldName) {
        this.unitLoad = true
        this.sizeValidation(e, inputFieldName)
        if (this.isFileLarge) {
          this.unitLoad = false
          return
        }
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            if (inputFieldName === 'latest_year_tax_certificate_input') {
              this.attachment_all_doc.latest_year_tax_certificate = e.target.result
            }
            if (inputFieldName === 'vat_certificate_input') {
              this.attachment_all_doc.vat_certificate = e.target.result
            }
            if (inputFieldName === 'custom_duty_certificate_input') {
              this.attachment_all_doc.custom_duty_certificate = e.target.result
            }
            if (inputFieldName === 'income_tax_certificate_input') {
              this.attachment_all_doc.income_tax_certificate = e.target.result
            }
            if (inputFieldName === 'loan_certificate_input') {
              this.attachment_all_doc.loan_certificate = e.target.result
            }
            if (inputFieldName === 'incorporation_certificate_input') {
              this.attachment_all_doc.incorporation_certificate = e.target.result
            }
            if (inputFieldName === 'bank_prc_last_fical_year_input') {
              this.attachment_all_doc.bank_prc_last_fical_year = e.target.result
            }
            if (inputFieldName === 'bank_prc_latest_fical_year_input') {
              this.attachment_all_doc.bank_prc_latest_fical_year = e.target.result
            }
          }
          reader.readAsDataURL(input.files[0])
          const myObj = {
            attachment_all_doc: this.attachment_all_doc,
            app_id: this.app_id
          }
          setTimeout(() => {
            RestApi.postData(exportTrophyCIPServiceBaseUrl, cipApplicationAttachmentStoreApi, myObj).then(result => {
              if (result.success) {
                if (result.data.latest_year_tax_certificate) {
                  this.attachment_all_doc.latest_year_tax_certificate_oldfile = result.data.latest_year_tax_certificate
                  this.attachment_all_doc.latest_year_tax_certificate = ''
                  this.latest_year_tax_certificate_input = []
                }
                if (result.data.vat_certificate) {
                  this.attachment_all_doc.vat_certificate_oldfile = result.data.vat_certificate
                  this.attachment_all_doc.vat_certificate = ''
                  this.vat_certificate_input = []
                }
                if (result.data.custom_duty_certificate) {
                  this.attachment_all_doc.custom_duty_certificate_oldfile = result.data.custom_duty_certificate
                  this.attachment_all_doc.custom_duty_certificate = ''
                  this.custom_duty_certificate_input = []
                }
                if (result.data.income_tax_certificate) {
                  this.attachment_all_doc.income_tax_certificate_oldfile = result.data.income_tax_certificate
                  this.attachment_all_doc.income_tax_certificate = ''
                  this.income_tax_certificate_input = []
                }
                if (result.data.loan_certificate) {
                  this.attachment_all_doc.loan_certificate_oldfile = result.data.loan_certificate
                  this.attachment_all_doc.loan_certificate = ''
                  this.loan_certificate_input = []
                }
                if (result.data.incorporation_certificate) {
                  this.attachment_all_doc.incorporation_certificate_oldfile = result.data.incorporation_certificate
                  this.attachment_all_doc.incorporation_certificate = ''
                  this.incorporation_certificate_input = []
                }
                if (result.data.bank_prc_last_fical_year) {
                  this.attachment_all_doc.bank_prc_last_fical_year_oldfile = result.data.bank_prc_last_fical_year
                  this.attachment_all_doc.bank_prc_last_fical_year = ''
                  this.bank_prc_last_fical_year_input = []
                }
                if (result.data.bank_prc_latest_fical_year) {
                  this.attachment_all_doc.bank_prc_latest_fical_year_oldfile = result.data.bank_prc_latest_fical_year
                  this.attachment_all_doc.bank_prc_latest_fical_year = ''
                  this.bank_prc_latest_fical_year_input = []
                }
                this.unitLoad = false
                return result
              }
            }, error => {
              if (error) {
              }
            })
          }, 2000)
        }
      },
      async submit () {
        var check = await this.$refs.formattachment.validate()
        if (check) {
          this.unitLoad = true
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          const loadingState = { loading: false, listReload: false }
          const myObj = {
            attachment_all_doc: this.attachment_all_doc,
            app_id: this.app_id,
            app_status: this.app_status
          }

          const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, cipApplicationAttachmentStoreApi, myObj)
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)
          this.unitLoad = false
          if (result.success) {
            this.$toast.success({
              title: 'Success',
              message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            return result
          } else {
            this.$refs.formattachment.setErrors(result.errors)
            this.$toast.error({
              title: this.$t('globalTrans.error'),
              message: this.$t('globalTrans.form_error_msg'),
              color: '#ee5253'
            })
          }
        }
      }
    }
}
</script>

<style>

</style>
