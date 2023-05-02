<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
           <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Council Name" vid="council_info_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="council_info_id"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.council_info_id"
                  :options="councilInfoList"
                  id="council_info_id"
                  disabled
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Association Name" vid="association_info_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="association_info_id"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.association_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.association_info_id"
                  :options="associationInfoList"
                  disabled
                  id="association_info_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="fiscal_year_id"
                >
                <template v-slot:label>
                  {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.fiscal_year_id"
                  :options="fiscalYearList"
                  id="fiscal_year_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          <b-col xs="12" sm="12" md="6"></b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Training type (En)" vid="training_type" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="training_type">
                <template v-slot:label>
                  {{ $t('informationTraining.training_type') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="training_type"
                  v-model="form.training_type"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Training type (Bn)" vid="training_type_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="training_type_bn">
                <template v-slot:label>
                  {{ $t('informationTraining.training_type') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="training_type_bn"
                  v-model="form.training_type_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Program Name (En)" vid="program_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="program_name">
                <template v-slot:label>
                  {{ $t('eBizProgram.program_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="program_name"
                  v-model="form.program_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Program Name (Bn)" vid="program_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="program_name_bn">
                <template v-slot:label>
                  {{ $t('eBizProgram.program_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="program_name_bn"
                  v-model="form.program_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Content Name (En)" vid="content_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="content_name">
                <template v-slot:label>
                  {{ $t('informationTraining.content_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="content_name"
                  v-model="form.content_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Content Name (Bn)" vid="content_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="content_name_bn">
                <template v-slot:label>
                  {{ $t('informationTraining.content_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="content_name_bn"
                  v-model="form.content_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remarks (En)" vid="remarks" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="remarks"
                    rows="3"
                    v-model="form.remarks"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remarks (Bn)" vid="remarks_bn" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="remarks_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="remarks_bn"
                    rows="3"
                    v-model="form.remarks_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Content attachment" vid="content_attachment" :rules="attachmentReq">
                <b-form-group
                  label-for="content_attachment"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('informationTraining.content_attachment')}} <span class="text-danger">{{ $t('InformationTraining.doucument_type') }} *</span>
                  </template>
                <b-form-file id="content_attachment"
                v-model="form.file"
                v-on:change="onAttachmentFileChange"
                accept=".doc,.docx,.pdf"
                class="mt-2" plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="warning" @click="formStatus(1)" class="mr-2 btn-sm">{{ draftBtnName }}</b-button>
              <b-button type="submit" variant="success" @click="formStatus(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { contentManagementStore, contentManagementUpdate } from '../../api/routes'
export default {
  name: 'Form',
  components: {
  },
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.submit'),
      errors: [],
      isDisable: false,
      draftBtnName: this.$t('globalTrans.draft'),
      form: {
          council_info_id: 0,
          association_info_id: 0,
          fiscal_year_id: 0,
          training_type: '',
          training_type_bn: '',
          program_name: '',
          program_name_bn: '',
          content_name: '',
          content_name_bn: '',
          remarks: '',
          remarks_bn: '',
          content_attachment: ''
      },
      attachmentReq: 'required',
      profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile,
      associationInfoList: []
    }
  },
  created () {
    if (this.profile !== undefined) {
      this.form.council_info_id = this.profile.council_info_id
      this.form.association_info_id = this.profile.association_info_id
    }
    if (this.id) {
      this.attachmentReq = ''
      this.isDisable = true
      const tmp = this.getData()
      this.form = tmp
      this.form.content_attachment = ''
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    fiscalYearList () {
       return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
     }
  },
  watch: {
    'form.council_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.associationInfoList = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
        }
    },
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    }
  },
  methods: {
    onAttachmentFileChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.content_attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.content_attachment = ''
          }
    },
    formStatus (status) {
        this.form.status = status
    },
    async saveUpdate () {
      const isValid = await this.$refs.form.validate()
      if (isValid) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          if (this.id) {
            result = await RestApi.putData(eBizServiceBaseUrl, `${contentManagementUpdate}/${this.id}`, this.form)
          } else {
            result = await RestApi.postData(eBizServiceBaseUrl, contentManagementStore, this.form)
          }

          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)

          if (result.success) {
           this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.$bvModal.hide('modal-form')
          } else {
            this.$refs.form.setErrors(result.errors)
          }
       }
    },
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
