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
              <pre>
                {{ attachment_all_doc }}
              </pre>
              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Latest year tax certificate" vid="attachment_all_doc.latest_year_tax_certificate" :rules="!$route.query.id || attachment_all_doc.latest_year_tax_certificate === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.latest_year_tax_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.latest_year_tax_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.latest_year_tax_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.latest_year_tax_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.latest_year_tax_certificate_oldfile" title="Latest year tax certificate" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeLatestYearTaxCertificate"
                    v-model="latest_year_tax_certificate_input"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Vat certificate" vid="attachment_all_doc.vat_certificate" :rules="!$route.query.id || attachment_all_doc.vat_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.vat_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.vat_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.vat_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.vat_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.vat_certificate_oldfile" title="Vat certificate" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeVatCertificate"
                    v-model="vat_certificate"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Custom duty certificate" vid="attachment_all_doc.custom_duty_certificate" :rules="!$route.query.id || attachment_all_doc.custom_duty_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.custom_duty_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.custom_duty_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.custom_duty_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.custom_duty_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.custom_duty_certificate_oldfile" title="Custom duty certificate" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeCustomDutyCertificate"
                    v-model="custom_duty_certificate"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue" vid="attachment_all_doc.income_tax_certificate" :rules="!$route.query.id || attachment_all_doc.income_tax_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.income_tax_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.income_tax_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.income_tax_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.income_tax_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.income_tax_certificate_oldfile" title="Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeIncomeTaxCertificate"
                    v-model="income_tax_certificate"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Related Banks Non-Loan Defaulter Certificate" vid="attachment_all_doc.loan_certificate" :rules="!$route.query.id || attachment_all_doc.loan_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.loan_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.loan_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.loan_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.loan_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.loan_certificate_oldfile" title="Related Banks Non-Loan Defaulter Certificate" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeLoanCertificate"
                    v-model="loan_certificate"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Certificate of Incorporation" vid="attachment_all_doc.incorporation_certificate" :rules="!$route.query.id || attachment_all_doc.incorporation_certificate_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.incorporation_certificate"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.incorporation_certificate')}} <span v-if="!$route.query.id || attachment_all_doc.incorporation_certificate_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.incorporation_certificate_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.incorporation_certificate_oldfile" title="Certificate of Incorporation" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeIncorporationCertificate"
                    v-model="incorporation_certificate"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Bank PRC (Last Fiscal Year)" vid="attachment_all_doc.bank_prc_last_fical_year" :rules="!$route.query.id || attachment_all_doc.bank_prc_last_fical_year_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.bank_prc_last_fical_year"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.bank_prc_last_fical_year')}} <span v-if="!$route.query.id || attachment_all_doc.bank_prc_last_fical_year_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.bank_prc_last_fical_year_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.bank_prc_last_fical_year_oldfile" title="Bank PRC (Last Fiscal Year)" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeBankPrcLastFicalYear"
                    v-model="bank_prc_last_fical_year"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
              </b-col>

              <b-col xl="12" lg="12" sm="12">
                <ValidationProvider name="Bank PRC (Latest Fiscal Year)" vid="attachment_all_doc.bank_prc_latest_fical_year" :rules="!$route.query.id || attachment_all_doc.bank_prc_latest_fical_year_oldfile === '' ? 'required' : ''" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment_all_doc.bank_prc_latest_fical_year"
                      label-cols-sm="4"
                    >
                    <template v-slot:label>
                      {{ $t('externalUser.bank_prc_latest_fical_year')}} <span v-if="!$route.query.id || attachment_all_doc.bank_prc_latest_fical_year_oldfile === '' ? 'required' : ''" class="text-danger">*</span>
                        <span v-if="$route.query.id && attachment_all_doc.bank_prc_latest_fical_year_oldfile">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=storage/' + attachment_all_doc.bank_prc_latest_fical_year_oldfile" title="Bank PRC (Latest Fiscal Year)" class="mr-3"><i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                    plain
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-on:change="onFileChangeBankPrcLatestFicalYear"
                    v-model="bank_prc_latest_fical_year"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                </ValidationProvider>
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
import { etApplicationAttachmentStoreApi } from '../../api/routes'
export default {
    props: ['app_id', 'attachment_all_doc'],
    data () {
      return {
        baseUrl: exportTrophyCIPServiceBaseUrl,
        valid: null,
        unitLoad: false,
        latest_year_tax_certificate_input: [],
        vat_certificate: [],
        custom_duty_certificate: [],
        income_tax_certificate: [],
        loan_certificate: [],
        incorporation_certificate: [],
        bank_prc_last_fical_year: [],
        bank_prc_latest_fical_year: []
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      sizeValidation (e) {
        const bytesize = e.target.files[0].size
        const kbsize = bytesize / 1024
        if (kbsize > 2048) {
          this.attachment_all_doc.latest_year_tax_certificate = ''
          this.latest_year_tax_certificate_input = []
          this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: this.$t('externalUser.filesize'),
            color: '#ee5253'
          })
        }
      },
      onFileChangeLatestYearTaxCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.latest_year_tax_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.latest_year_tax_certificate = ''
        }
      },
      onFileChangeVatCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.vat_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.vat_certificate = ''
        }
      },
      onFileChangeCustomDutyCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.custom_duty_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.custom_duty_certificate = ''
        }
      },
      onFileChangeIncomeTaxCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.income_tax_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.income_tax_certificate = ''
        }
      },
      onFileChangeLoanCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.loan_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.loan_certificate = ''
        }
      },
      onFileChangeIncorporationCertificate (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.incorporation_certificate = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.incorporation_certificate = ''
        }
      },
      onFileChangeBankPrcLastFicalYear (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.bank_prc_last_fical_year = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.bank_prc_last_fical_year = ''
        }
      },
      onFileChangeBankPrcLatestFicalYear (e) {
        this.sizeValidation(e)
        const input = e.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.attachment_all_doc.bank_prc_latest_fical_year = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.attachment_all_doc.bank_prc_latest_fical_year = ''
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

          const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, etApplicationAttachmentStoreApi, myObj)
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
