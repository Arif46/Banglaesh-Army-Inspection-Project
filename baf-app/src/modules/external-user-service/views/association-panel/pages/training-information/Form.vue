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
            <ValidationProvider name="Number of trainees" vid="number_of_trainees" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="number_of_trainees">
                <template v-slot:label>
                  {{ $t('InformationTraining.number_of_trainees') }}
                </template>
                <b-form-input
                  id="number_of_trainees"
                  v-model="form.number_of_trainees"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6"></b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainee Organization (En)" vid="trainee_organization" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="trainee_organization">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainee_organization') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="trainee_organization"
                  v-model="form.trainee_organization"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainee Organization (Bn)" vid="trainee_organization_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="trainee_organization_bn">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainee_organization') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="trainee_organization_bn"
                  v-model="form.trainee_organization_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainer Name (En)" vid="trainer_name" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="trainer_name">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainer_name') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="trainer_name"
                  v-model="form.trainer_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainer Name (Bn)" vid="trainer_name_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="trainer_name_bn">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainer_name') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="trainer_name_bn"
                  v-model="form.trainer_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainer Information (En)" vid="trainer_information" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="trainer_information">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainer_information') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="trainer_information"
                    rows="3"
                    v-model="form.trainer_information"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainer Information (Bn)" vid="trainer_information_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="trainer_information_bn">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainer_information') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="trainer_information_bn"
                    rows="3"
                    v-model="form.trainer_information_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Trainer honorarium" vid="trainer_honorarium" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="trainer_honorarium">
                <template v-slot:label>
                  {{ $t('InformationTraining.trainer_honorarium') }}
                </template>
                <b-form-input
                  id="trainer_honorarium"
                  v-model="form.trainer_honorarium"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Program Image" vid="program_image" :rules="attachmentReq">
                <b-form-group
                  label-for="program_image"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('InformationTraining.program_image')}} ({{ $t('InformationTraining.image_label') }})<span class="text-danger">*</span>
                  </template>
                <b-form-file id="program_image"
                v-model="form.file"
                v-on:change="onImageFileChange"
                accept=".jpg,.jpeg,.png"
                class="mt-2" plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              <div id="preview">
                <img v-if="form.program_image" :src="form.program_image" style="height:100px;width:100px;"/>
              </div>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Report attachment" vid="report_attachment" rules="">
                <b-form-group
                  label-for="report_attachment"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('InformationTraining.report_upload')}} {{ $t('Advocacy.attachment_type') }}
                  </template>
                <b-form-file id="report_attachment"
                v-model="form.report_file"
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
import { trainingInformationStore, trainingInformationUpdate } from '../../api/routes'
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
          program_name: '',
          program_name_bn: '',
          trainer_name: '',
          trainer_name_bn: '',
          trainer_organization: '',
          trainer_organization_bn: '',
          number_of_trainees: 0,
          trainer_honorarium: 0,
          program_image: '',
          report_attachment: ''
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
       this.form.report_attachment = ''
       this.form.program_image = ''
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    typeOfBusinessList () {
       return this.$store.state.ExternalUserService.eBizPanel.commonObj.typeOfBusinessList.filter(item => item.status === 1)
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
    onImageFileChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.program_image = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.program_image = ''
          }
      },
    onAttachmentFileChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.report_attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.report_attachment = ''
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
            result = await RestApi.putData(eBizServiceBaseUrl, `${trainingInformationUpdate}/${this.id}`, this.form)
          } else {
            result = await RestApi.postData(eBizServiceBaseUrl, trainingInformationStore, this.form)
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
