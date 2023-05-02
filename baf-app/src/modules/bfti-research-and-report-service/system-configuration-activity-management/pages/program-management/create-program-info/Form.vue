<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Task Heading (Bn)" vid="memo_no"  v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="memo_no">
                <template v-slot:label>
                  {{ $t('meeting_management.memo_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="memo_no"
                  v-model="heading_details.memo_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                 <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Document Type" vid="document_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="document_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('meeting_management.document_type_id')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="heading_details.document_type_id"
                :options="documentTypeList"
                id="document_type_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option disabled :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col> -->
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Document Type" vid="program_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="program_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('meeting_management.program_type_id')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="heading_details.program_type_id"
                :options="programTypeList"
                id="program_type_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option disabled :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Task Heading (En)" vid="title" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title">
                <template v-slot:label>
                  {{ $t('meeting_management.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title"
                  v-model="heading_details.title"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Task Heading (Bn)" vid="title_bn">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('meeting_management.title') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="heading_details.title_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Details" vid="details" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="details">
                <template v-slot:label>
                  {{ $t('meeting_management.details') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="details"
                    rows="3"
                    v-model="heading_details.details"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Details" vid="details_bn">
              <b-form-group
                label-for="details_bn">
                <template v-slot:label>
                  {{ $t('meeting_management.details') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="details_bn"
                    rows="3"
                    v-model="heading_details.details_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Venue (En)" vid="venue" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="venue">
                <template v-slot:label>
                  {{ $t('meeting_management.venue') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="venue"
                  v-model="heading_details.venue"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Venue (Bn)" vid="venue_bn">
              <b-form-group
                label-for="venue_bn">
                <template v-slot:label>
                  {{ $t('meeting_management.venue') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="venue_bn"
                  v-model="heading_details.venue_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organized By" vid="organized_by" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="organized_by">
                <template v-slot:label>
                  {{ $t('meeting_management.organized_by') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="venue_bn"
                  v-model="heading_details.organized_by"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organized By" vid="organized_by_bn">
              <b-form-group
                label-for="organized_by_bn">
                <template v-slot:label>
                  {{ $t('meeting_management.organized_by') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="venue_bn"
                  v-model="heading_details.organized_by_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Program Date" vid="program_date" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="program_date">
                <template v-slot:label>
                {{ $t('meeting_management.program_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                 id="program_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  v-model="heading_details.program_date"
                 :state="errors[0] ? false : (valid ? true : null)"
                 :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
           <ValidationProvider name="Start Time" vid="start_time" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="start_time">
                <template v-slot:label>
                {{ $t('meeting_management.start_time') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="start_time"
                  type="time"
                  v-model="heading_details.start_time"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="End Time" vid="end_time" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="end_time">
                <template v-slot:label>
                  {{ $t('meeting_management.end_time') }} <span class="text-danger">*</span>
                </template>
                 <b-form-input
                  id="end_time"
                  type="time"
                  v-model="heading_details.end_time"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Total Participant" vid="total_participant" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="total_participant">
                <template v-slot:label>
                  {{ $t('meeting_management.total_participant') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type = number
                  id="total_participant"
                  v-model="heading_details.total_participant"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remarks (En)" vid="remarks">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('meeting_management.remarks') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="remarks"
                  v-model="heading_details.remarks"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Task Heading (Bn)" vid="remarks_bn">
              <b-form-group
                label-for="remarks_bn">
                <template v-slot:label>
                  {{ $t('meeting_management.remarks') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="remarks_bn"
                  v-model="heading_details.remarks_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('meeting_management.prdi') }}</h5>
          </b-col>
      </b-row>
      <!-- Attachment Name -->
      <div class="row" v-for="(value, index) in attachment" :key="index">
        <div class="col-md-1 text-center">
          <p class="text-dark font-weight-bold">{{index + 1}}.</p>
        </div>
        <div class="col-md-4">
          <ValidationProvider name="Title (En)" :vid="`name_`+index" rules="required">
            <b-form-group
              :label-for="`name_`+index"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
            {{$t('meeting_management.document_title')}} <span class="text-danger">*</span>
            </template>
              <b-form-input
                :id="`name_`+index"
                v-model="value.title"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </div>
        <b-col xs="12" sm="12" md="5" v-if="value.attachment === undefined ">
          <ValidationProvider name="Attachment" :vid="attachment+index" rules="required" v-slot="{ errors }">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('meeting_management.curriculum_vitae') }} <span class="text-danger">*</span>
                </template>
                <b-form-file
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-model="attachmentFile"
                    @change="onChange($event, index)"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here..."
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xs="12" sm="12" md="5" v-else>
          <ValidationProvider name="Attachment" :vid="attachment+index"  :rules="id ? '' : 'required'" v-slot="{ errors }">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('meeting_management.curriculum_vitae') }}
                </template>
                <b-form-file
                    accept="application/pdf,application/doc,application/docx,application/csv"
                    v-model="attachmentFile"
                    @change="onChange($event, index)"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here..."
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <div class="col-md-2">
          <div class="w-100 h-100 d-grid">
            <b-button v-if="index === 0" type="button" class="m-auto" @click="addAttachment" variant="primary"><i class="ri-add-line p-0 m-0"></i></b-button>
            <b-button v-if="index !== 0" type="button" class="m-auto" @click="removeAttachment(index)" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
          </div>
        </div>
      </div>
      <b-row class="text-right">
        <b-col>
            <b-button type="button" @click="draft"   variant="warning" class="mr-2 btn-sm">{{ $t('meeting_management.draft') }}</b-button>
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
import { programInfoStoreApi, programInfoUpdateApi } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      baseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      documentTypeList: [],
      programTypeList: [],
      attachmentFile: [],
      attachment: [
        {
          title: ''
        }
      ],
      heading_details: {
        title: '',
        title_bn: '',
        details: '',
        details_bn: '',
        venue: '',
        venue_bn: '',
        remarks: '',
        remarks_bn: '',
        organized_by: '',
        organized_by_bn: '',
        task_heading_en: '',
        is_sub_task: 0,
        task_heading_bn: '',
        curriculum: []
      }
    }
  },
  created () {
      this.documentTypeList = this.documentType()
      this.programTypeList = this.programType()
      if (this.id) {
        const tmp = this.getProgramInfoData()
        this.heading_details = tmp
        if (tmp.attachment[0].title === undefined) {
        } else {
          this.attachment = tmp.attachment
        }
      }
  },
  computed: {
    getAnswerList () {
      return this.answerList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.filter(item => item.status === 1)
    },
    ministryNameList () {
      return this.$store.state.CommonService.commonObj.ministryNameList.filter(el => el.status === 1)
    },
    portalServiceCategoryList () {
      return this.$store.state.CommonService.commonObj.portalServiceCategoryList.filter(item => item.status === 1)
    },
    portalCustomerTypeList () {
      return this.$store.state.CommonService.commonObj.portalCustomerTypeList.filter(el => el.status === 1)
    },
    serviceTypeList () {
      return this.$store.state.CommonService.commonObj.portalServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'service.service_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
          this.service.ex_org_id = 0
          this.service.service_url = ''
          this.service.component_id = 0
          this.service.ministry_id = 0
          this.service.api_manager = ''
        }
      }
    },
    'service.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
        }
        this.orgList = this.getOrgList(newVal)
      }
    },
    'service.ministry_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.ex_org_id = 0
        }
        this.exOrgList = this.getExOrgList(newVal)
      }
    }
  },
  methods: {
    documentType () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    programType () {
      return this.$store.state.BftiResearchAndReportService.commonObj.programTypeList.filter(item => item.status === 1)
    },
    onChange (event, index) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.attachment[index].file = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
         this.attachment[index].file = null
      }
    },
    addAttachment () {
      const tmpAtt = {
        title: ''
      }
      this.attachment.push(tmpAtt)
    },
    removeAttachment (index) {
      this.attachment.splice(index, 1)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      this.heading_details.value = this.attachment
      const loadingState = { loading: false, listReload: false }
      this.heading_details.draft = 1
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${programInfoUpdateApi}/${this.id}`, this.heading_details)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, programInfoStoreApi, this.heading_details)
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
    async draft () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      this.heading_details.value = this.attachment
      const loadingState = { loading: false, listReload: false }
      this.heading_details.draft = 0
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${programInfoUpdateApi}/${this.id}`, this.heading_details)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, programInfoStoreApi, this.heading_details)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('mutateCommonProperties', { hasDropdownLoaded: false })
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
    getProgramInfoData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
