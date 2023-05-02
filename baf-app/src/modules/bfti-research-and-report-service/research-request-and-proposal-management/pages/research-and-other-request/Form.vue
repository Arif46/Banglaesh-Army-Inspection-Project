<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('bfti.research_and_other_request') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6" >
                  <ValidationProvider name="Document" vid="doc_type" rules="required|min_value:1">
                    <b-form-group
                      label-for="doc_type"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('bfti.doc_type')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.doc_type_id"
                        :options="docTypeList"
                        id="doc_type"
                        :disabled="id ? true: false"
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
                <b-col xs="12" sm="12" md="6" v-if="form.doc_type_id === 3">
                  <ValidationProvider name="Research Type" vid="research_type" rules="required|min_value:1">
                    <b-form-group
                      label-for="research_type"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('researchRequestManagement.research_type')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.research_type"
                        :options="researchTypeList"
                        id="research_type"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :disabled="id ? true: false"
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
                <b-col xs="12" sm="12" md="6" v-if="form.doc_type_id === 3 && form.research_type === 1">
                  <ValidationProvider name="RFP Title" vid="prepare_rfp_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="prepare_rfp_id"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('research_plan_management.rfp_title')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.prepare_rfp_id"
                        :options="currentLocale === 'en' ? rfpListEn : rfpListBn"
                        id="prepare_rfp_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :disabled="id ? true: false"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{ rfpLoading ? $t('globalTrans.loading') : $t('globalTrans.select')}}</b-form-select-option>
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
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Topic (En)" vid="topic" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="topic">
                      <template v-slot:label>
                        {{ $t('bfti.topic') }}  {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="topic"
                        v-model="form.topic"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Topic (Bn)" vid="topic_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="topic_bn">
                      <template v-slot:label>
                        {{ $t('bfti.topic') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="topic_bn"
                        v-model="form.topic_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Description (En)" vid="description" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="heading_bn">
                      <template v-slot:label>
                        {{ $t('bfti.description') }}  {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                      </template>
                      <b-form-textarea
                        id="heading_bn"
                        v-model="form.description"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-textarea>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="description_bn">
                      <template v-slot:label>
                        {{ $t('bfti.description') }}  {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-textarea
                        id="description_bn"
                        v-model="form.description_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-textarea>
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
                        {{ $t('bfti.budget') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="budget"
                        type="number"
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
                  <ValidationProvider name="Budget Source (En)" vid="budget_source" v-slot="{ errors }">
                    <b-form-group
                      label-for="budget_source">
                      <template v-slot:label>
                        {{ $t('bfti.budget_source') }} {{ $t('globalTrans.en') }}
                      </template>
                      <b-form-input
                        id="budget_source"
                        v-model="form.budget_source"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Budget Source (Bn)" vid="budget_source_bn" rules="" v-slot="{ errors }">
                    <b-form-group
                      label-for="budget_source_bn">
                      <template v-slot:label>
                        {{ $t('bfti.budget_source') }} {{ $t('globalTrans.bn') }}
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
                  <ValidationProvider name="Date From" vid="duration_start_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="date"
                    >
                      <template v-slot:label>
                        {{ $t('globalTrans.date_from') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="duration_start_date"
                        class="form-control"
                        v-model="form.duration_start_date"
                        :class="errors[0] ? 'is-invalid' : ''"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :placeholder="$t('globalTrans.select')"
                        :locale="currentLocale"
                        @input="diffYearMonthDay"
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
                  <ValidationProvider name="Date To" vid="duration_end_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="date"
                    >
                      <template v-slot:label>
                        {{ $t('globalTrans.date_to') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="duration_end_date"
                        class="form-control"
                        :class="errors[0] ? 'is-invalid' : ''"
                        v-model="form.duration_end_date"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :placeholder="$t('globalTrans.select')"
                        :locale="currentLocale"
                        @input="diffYearMonthDay"
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
                  <ValidationProvider name="Duration" vid="duration" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="duration">
                      <template v-slot:label>
                        {{ $t('research_plan_management.duration') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="duration"
                        v-model="form.duration"
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
                  <ValidationProvider name="Duration Bn" vid="duration_bn" rules="required" v-slot="{ errors }">
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
                  <ValidationProvider name="Attachment" vid="attachment" :rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="attachment">
                      <template v-slot:label>
                        {{ $t('bfti.attachment') }} <span v-if="required === 'required'" class="text-danger">*</span>
                      </template>
                      <b-form-file
                        id="attachment"
                        v-model="form.file"
                        @change="onChange"
                        :state="errors[0] ? false : (valid ? true : null)"
                        accept=".pdf"
                        placeholder="Choose a file or drop it here..."
                        drop-placeholder="Drop file here..."
                      ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                <template class="pb-3" v-if="form.attachment && form.id">
                  <a target="_blank" :href="bftiResReportServiceBaseUrl +form.attachment">{{ $t('bfti.attachment_down')}}</a> <br>
                </template>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('bfti.contact_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Name (En)" vid="name" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="name">
                      <template v-slot:label>
                        {{ $t('bfti.contact_person') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="name"
                        v-model="form.name"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Name (bn)" vid="name_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="name_bn">
                      <template v-slot:label>
                        {{ $t('bfti.contact_person') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="name_bn"
                        v-model="form.name_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Designation (En)" vid="designation" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="designation">
                      <template v-slot:label>
                        {{ $t('bfti.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="designation"
                        v-model="form.designation"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Designation (Bn)" vid="designation_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="designation_bn">
                      <template v-slot:label>
                        {{ $t('bfti.designation') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="designation_bn"
                        v-model="form.designation_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Organization (En)" vid="organization" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="organization">
                      <template v-slot:label>
                        {{ $t('globalTrans.organization') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="organization"
                        v-model="form.organization"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Organization (Bn)" vid="organization_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="organization_bn">
                      <template v-slot:label>
                        {{ $t('globalTrans.organization') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="organization_bn"
                        v-model="form.organization_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contact Number" vid="contact_number" rules="required|min:11|max:11" v-slot="{ errors }">
                    <b-form-group
                      label-for="contact_number">
                      <template v-slot:label>
                        {{ $t('bfti.contact_number') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="contact_number"
                        v-model="form.contact_number"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Email" vid="email" rules="" v-slot="{ errors }">
                    <b-form-group
                      label-for="email">
                      <template v-slot:label>
                        {{ $t('bfti.email') }}
                      </template>
                      <b-form-input
                        id="email"
                        type="email"
                        v-model="form.email"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Submission date" vid="submission_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="submission_date">
                      <template v-slot:label>
                        {{ $t('bfti.submission_date') }} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="submission_date"
                        v-model="form.submission_date"
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                      </date-picker>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
              <b-button type="submit" @click="form.flag = 2 " variant="primary" class="mr-2">{{$t('configuration.final_save')}}</b-button>
              <b-button type="submit" @click="form.flag = 1 " variant="warning" class="mr-2">{{$t('configuration.save_draft')}}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { bftiResearchRequestStoreApi, bftiResearchRequestUpdateApi } from '../../api/routes'
import { helpers } from '@/utils/helper-functions'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      required: 'required',
      form: {
        doc_type_id: 3,
        is_admin: 1,
        topic: '',
        topic_bn: '',
        description: '',
        description_bn: '',
        budget: '',
        budget_source: '',
        budget_source_bn: '',
        duration_start_date: '',
        duration_end_date: '',
        duration: '',
        name: '',
        name_bn: '',
        designation: '',
        designation_bn: '',
        organization: '',
        organization_bn: '',
        contact_number: '',
        email: '',
        flag: 1,
        submission_date: new Date(),
        file: [],
        user_id: this.$store.state.Auth.authUser.user_id,
        type: this.$store.state.Auth.authUser.user_type,
        externalFlag: false, // this flag will check in backend api either it come from admin or external
        research_type: 0,
        status: 1,
        prepare_rfp_id: 0
      },
      rfpLoading: false,
      rfpListEn: [],
      rfpListBn: []
    }
  },
  created () {
    if (this.id) {
      this.required = ''
      const tmp = this.getInfo()
      this.form = tmp
      this.form.doc_type_id = this.form.document_type_id
      this.form.contact_number = this.form.contact_no
    } else {
      this.required = 'required'
    }
  },
  watch: {
    'form.research_type': function (newVal, oldVal) {
      this.getRfpList()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    researchTypeList () {
      return [
        {
          value: 1,
          text_en: 'RFP',
          text_bn: 'আরএফপি',
          text: this.currentLocale === 'bn' ? 'আরএফপি' : 'RFP'
        },
        {
          value: 2,
          text_en: 'Without RFP',
          text_bn: 'আরএফপি ছাড়া',
          text: this.currentLocale === 'bn' ? 'আরএফপি ছাড়া' : 'Without RFP'
        }
      ]
    }
  },
  methods: {
    getInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
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
    saveUpdate () {
      let msg = ''
      if (this.form.flag === 1) {
        msg = window.vm.$t('configuration.save_draft_mess')
      }
      if (this.form.flag === 2) {
        msg = window.vm.$t('configuration.final_save_mess')
      }
      window.vm.$swal({
        title: msg,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.Approval()
        }
      })
    },
    async Approval () {
      if (this.form.flag === 2) {
        this.form.status = 2
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.form.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${bftiResearchRequestUpdateApi}/${this.form.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, bftiResearchRequestStoreApi, this.form)
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
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    diffYearMonthDay () {
      if (this.form.duration_start_date && this.form.duration_end_date) {
        const dt1 = new Date(this.form.duration_start_date)
        const dt2 = new Date(this.form.duration_end_date)
        const time = (dt2.getTime() - dt1.getTime()) / 1000
        const divisionNumberForYear = 60 * 60 * 24 * 365
        const divisionNumberForMonth = 60 * 60 * 24 * 30
        const divisionNumberForDay = 60 * 60 * 24
        const year = Math.abs(Math.floor(time / divisionNumberForYear))
        const month = Math.abs(Math.floor((time - (year * divisionNumberForYear)) / divisionNumberForMonth))
        const days = Math.abs(Math.floor((time - (year * divisionNumberForYear) - (month * divisionNumberForMonth)) / divisionNumberForDay))
        this.form.duration = year + ' ' + this.$t('research_plan_management.years', 'en') + ', ' + month + ' ' + this.$t('research_plan_management.months', 'en') + ', ' + days + ' ' + this.$t('research_plan_management.days', 'en')
        this.form.duration_bn = helpers.convertEnglishToBanglaNumber(year) + ' ' + this.$t('research_plan_management.years', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(month) + ' ' + this.$t('research_plan_management.months', 'bn') + ', ' + helpers.convertEnglishToBanglaNumber(days) + ' ' + this.$t('research_plan_management.days', 'bn')
      }
    },
    async getRfpList () {
      if (this.form.research_type === 1) {
        this.rfpLoading = true
        const result = await RestApi.getData(bftiResReportServiceBaseUrl, '/research-plan-preparation/prepare-rfp/rfp-list')
        if (result.success) {
          const resultData = result.data.filter(item => item.status === 4)
          this.rfpListEn = resultData.map(item => {
            const customItem = {
              text: item.text_en
            }
            return Object.assign({}, item, customItem)
          })
          this.rfpListBn = resultData.map(item => {
            const customItem = {
              text: item.text_bn
            }
            return Object.assign({}, item, customItem)
          })
        } else {
          this.rfpListEn = []
          this.rfpListBn = []
        }
        this.rfpLoading = false
      } else {
        this.rfpListEn = []
        this.rfpListBn = []
      }
    }
  }
}
</script>
