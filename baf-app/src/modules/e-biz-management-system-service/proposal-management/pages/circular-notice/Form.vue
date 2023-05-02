<template>
<b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
              <b-row>
              <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Fiscal Year" vid="fiscal_year" rules="required|min_value:1">
                  <b-form-group
                    label-for="fiscal_year"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formData.fiscal_year_id"
                    :options="fiscalYearList"

                    id="fiscal_year"
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
          <ValidationProvider name="Source Of Fund" vid="source_of_fund" rules="required|min_value:1">
                <b-form-group
                  label-for="source_of_fund"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.source_of_fund')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formData.source_of_fund"
                  :options="sourceOfFund"
                  id="source_of_fund"
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
         <b-col xs="12" sm="12" md="6" v-if="parseInt(formData.source_of_fund) === 2">
            <ValidationProvider name="Project Name" vid="project_id" rules="">
                  <b-form-group
                      label-for="project_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eBizProposal.project_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formData.project_name_id"
                      :options="projectNameList"
                      id="project_id"
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
            <b-col xs="12" sm="12" md="6" v-if="parseInt(formData.source_of_fund) === 3">
              <ValidationProvider name="Budget Title" vid="budget_title" rules="" v-slot="{ errors }">
                  <b-form-group
                    label-for="budget_title">
                    <template v-slot:label>
                      {{ $t('eBizProposal.budget_title') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      id="budget_title"
                      v-model="formData.budget_title"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Title (En)" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_en">
                <template v-slot:label>
                  {{ $t('eBizProposal.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_en"
                  v-model="formData.title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('eBizProposal.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="formData.title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Deadline" vid="deadline" rules="required">
              <b-form-group
                  label-for="deadline"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('eBizProposal.deadline')}} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="deadline"
                  v-model="formData.deadline"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
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
         <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="parseInt(formData.source_of_fund) <= 1">
         </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="description_en"
                    rows="3"
                    v-model="formData.description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="description_bn"
                    rows="3"
                    v-model="formData.description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Attachment" vid="attachment" :rules="attachValidation">
                    <b-form-group
                      label-for="attachment"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{ $t('globalTrans.attachment') }}<span class="text-danger">*</span>
                      </template>
                    <b-form-file id="attachment"
                    v-model="formData.file"
                    v-on:change="onFileChange"
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
            </b-form>
          </b-overlay>
        </ValidationObserver>
      <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="warning" @click="saveData(1)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button type="submit" variant="success" @click="saveData(2)" class="mr-2 btn-sm">{{ finalSaveBtn }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { circularNoticeStore, circularNoticeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.draft'),
      finalSaveBtn: this.$t('globalTrans.finalSave'),
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      errors: [],
      attachValidation: 'required',
      formData: {
        fiscal_year_id: 0,
        source_of_fund: 0,
        project_name_id: 0,
        title_en: '',
        title_bn: '',
        attachment: '',
        file: [],
        deadline: '',
        description_en: '',
        description_bn: '',
        status: 0
      }
    }
  },
  created () {
    if (this.id) {
      this.attachValidation = ''
      const tmp = this.getFeeEntry()
      this.formData = tmp
      this.formData.attachment = ''
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    projectNameList () {
      return this.$store.state.EBizManagementSystemService.commonObj.projectNameList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    sourceOfFund () {
      let fundList = [
        {
          value: '1',
          text_en: 'Gov',
          text_bn: 'সরকারি'
        },
        {
            value: '2',
            text_en: 'Project',
            text_bn: 'প্রজেক্ট'
        },
        {
            value: '3',
            text_en: 'Other',
            text_bn: 'অন্যান্য'
        }
      ]
       fundList = fundList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return fundList
    }
  },
  watch: {
  },
  methods: {
    // ================Allotment Order Modify Start=================
     onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.formData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.formData.attachment = ''
        }
    },
    async saveData (status) {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
      this.formData.status = status
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${circularNoticeUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, circularNoticeStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
