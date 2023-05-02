<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="RFP Type" vid="rfp_type">
              <b-form-group
                label-for="rfp_type"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('research_plan_management.rfp_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.rfp_type"
                  :options="rfpTypeList"
                  id="rfp_type"
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
          <b-col xs="12" sm="12" md="6" v-if="form.rfp_type === 1">
            <ValidationProvider name="EOI Title" vid="prepare_eoi_id">
              <b-form-group
                label-for="prepare_eoi_id"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('research_plan_management.eoi_title') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.prepare_eoi_id"
                  :options="eoiList"
                  id="prepare_eoi_id"
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
          <b-col xs="12" sm="12" md="6" v-if="form.rfp_type === 1">
            <ValidationProvider name="EOI Reference No" vid="eoi_reference_no " rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="eoi_reference_no">
                <template v-slot:label>
                  {{ $t('research_plan_management.eoi_reference_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="eoi_reference_no "
                  v-model="form.eoi_reference_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" v-if="form.rfp_type === 1">
            <ValidationProvider name="Procuring Entity" vid="procuring_entity" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="procuring_entity">
                <template v-slot:label>
                  {{ $t('research_plan_management.procuring_entity') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="procuring_entity"
                  v-model="form.procuring_entity"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="RFP Title (En)" vid="rfp_title_en" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="rfp_title_en">
                <template v-slot:label>
                  {{ $t('research_plan_management.rfp_title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="rfp_title_en"
                  v-model="form.rfp_title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="RFP Title (Bn)" vid="rfp_title_bn" rules="" v-slot="{ valid, errors }">
              <b-form-group
                label-for="rfp_title_bn">
                <template v-slot:label>
                  {{ $t('research_plan_management.rfp_title') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="rfp_title_bn"
                  v-model="form.rfp_title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization/Ministry/Division (En)" vid="organization_ministry_division" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="organization_ministry_division">
                <template v-slot:label>
                  {{ $t('research_plan_management.organization_ministry_division') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="organization_ministry_division"
                  v-model="form.organization_ministry_division"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :disabled="form.rfp_type === 1"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization/Ministry/Division (Bn)" vid="organization_ministry_division_bn" v-slot="{ valid, errors }">
              <b-form-group
                label-for="organization_ministry_division_bn">
                <template v-slot:label>
                  {{ $t('research_plan_management.organization_ministry_division') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="organization_ministry_division_bn"
                  v-model="form.organization_ministry_division_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :disabled="form.rfp_type === 1"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="RFP Date" vid="rfp_date" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                     id="rfp_date"
                     class="form-control"
                     v-model="form.rfp_date"
                     :state="errors[0] ? false : (valid ? true : null)"
                     :placeholder="$t('globalTrans.select')"
                     :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="RFP No" vid="rfp_no" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="rfp_no">
                <template v-slot:label>
                  {{ $t('research_plan_management.rfp_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="rfp_no"
                  v-model="form.rfp_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Proposal Submission Date" vid="proposal_submission_date" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('research_plan_management.proposal_submission_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                   id="proposal_submission_date"
                   class="form-control"
                   v-model="form.proposal_submission_date"
                   :state="errors[0] ? false : (valid ? true : null)"
                   :placeholder="$t('globalTrans.select')"
                   :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Proposal Submission Time" vid="proposal_submission_time" rules="required" v-slot="{ valid, errors }">
              <b-form-group
                label-for="proposal_submission_time">
                <template v-slot:label>
                  {{ $t('research_plan_management.proposal_submission_time') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type="time"
                  id="proposal_submission_time"
                  v-model="form.proposal_submission_time"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Attachment" vid="attachment" v-slot="{ valid, errors }">
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
                  :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <template class="pb-3" v-if="form.id && form.attachment">
              <a :href="bftiResReportServiceBaseUrl + (isImage(form.attachment) ? 'storage/' : '') +form.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
            </template>
          </b-col>
        </b-row>
        <div class="section-wrapper" v-if="form.rfp_type === 2">
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('research_plan_management.contact_person_info') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Name (En)" rules="required" :vid="'eoi_details.name'" v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="name">
                    <template v-slot:label>
                      {{ $t('globalTrans.name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
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
                <ValidationProvider name="Name (Bn)" :vid="'eoi_details.name_bn'"  v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="name_bn">
                    <template v-slot:label>
                      {{ $t('globalTrans.name') }} {{ $t('globalTrans.bn') }}
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
                <ValidationProvider name="Designation (En)" :vid="'eoi_details.designation'"  rules="required" v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="designation">
                    <template v-slot:label>
                      {{ $t('globalTrans.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
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
                <ValidationProvider name="Designation (Bn)" :vid="'eoi_details.designation_bn'"  v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="designation_bn">
                    <template v-slot:label>
                      {{ $t('globalTrans.designation') }} {{ $t('globalTrans.bn') }}
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
                <ValidationProvider name="Address" :vid="'eoi_details.address'" rules="required" v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="address">
                    <template v-slot:label>
                      {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                        id="address"
                        v-model="form.address"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Address" :vid="'eoi_details.address_bn'" rules="" v-slot="{ valid, errors }">
                  <b-form-group
                      label-for="address_bn">
                    <template v-slot:label>
                      {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}
                    </template>
                    <b-form-textarea
                        id="address_bn"
                        v-model="form.address_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" md="6" sm="12" xs="12">
                <ValidationProvider name="Contact No" :vid="'eoi_details.contact_no'" rules="required|min:11|max:11" v-slot="{ valid, errors }">
                  <b-form-group
                      label="Contact No"
                      label-for="contact_no"
                  >
                    <template v-slot:label>
                      {{ $t('globalTrans.contact_no')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="mobile"
                        v-model="form.contact_no"
                        type="tel"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" md="6" sm="12" xs="12">
                <ValidationProvider name="Email" :vid="'eoi_details.email'" rules="email" v-slot="{ valid, errors }">
                  <b-form-group
                      label="Email"
                      type="email"
                      label-for="email"
                  >
                    <template v-slot:label>
                      {{ $t('globalTrans.email')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="email"
                        v-model="form.email"
                        type="email"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </template>
        </body-card>
        </div>
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
import { prepareRfpStore, prepareRfpUpdate, prepareEioShow } from '../../api/routes'
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
        rfp_type: 0,
        prepare_eoi_id: 0,
        eoi_reference_no: '',
        procuring_entity: '',
        rfp_title_en: '',
        rfp_title_bn: '',
        rfp_no: '',
        rfp_date: '',
        organization_ministry_division: '',
        organization_ministry_division_bn: '',
        proposal_submission_date: '',
        proposal_submission_time: '',
        attachment: null,
        name: '',
        name_bn: '',
        designation: '',
        address: '',
        address_bn: '',
        contact_no: '',
        email: ''
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
    'form.prepare_eoi_id': function (newVal, oldVal) {
      if (newVal) {
        const eoi = this.eoiList.find(obj => obj.value === parseInt(newVal))
        this.form.eoi_reference_no = eoi?.eoi_reference_no
        this.form.procuring_entity = this.currentLocale === 'en' ? eoi?.name_of_procuring_entity : eoi?.name_of_procuring_entity_bn
        this.form.organization_ministry_division = eoi?.organization_ministry_division
        this.form.organization_ministry_division_bn = eoi?.organization_ministry_division_bn
      } else {
        this.form.eoi_reference_no = ''
        this.form.procuring_entity = ''
        if (this.form.rfp_type === 1) {
          this.form.organization_ministry_division = ''
          this.form.organization_ministry_division_bn = ''
        }
      }
    }
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
      return this.$store.state.BftiResearchAndReportService.commonObj.eoiList.filter(item => item.status === 4)
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
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${prepareRfpUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, prepareRfpStore, this.form)
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
