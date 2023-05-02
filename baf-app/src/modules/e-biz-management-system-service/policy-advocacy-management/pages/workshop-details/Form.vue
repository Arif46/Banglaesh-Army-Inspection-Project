<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="application id" vid='application_id' rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="application_id"
                  >
                      <template v-slot:label>
                          {{ $t('teaGardenService.application_id') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.application_id"
                          :options="applicationListt"
                          id="gender"
                          :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
            <ValidationProvider name="Workshop Name (En)" vid="workshop_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="workshop_name_en">
                <template v-slot:label>
                  {{ $t('policyAdvocacy.workshop_name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="workshop_name_en"
                  v-model="form.workshop_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Workshop Name (Bn)" vid="workshop_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="workshop_name_bn">
                <template v-slot:label>
                  {{ $t('policyAdvocacy.workshop_name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="workshop_name_bn"
                  v-model="form.workshop_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Workshop Place Name (En)" vid="workshop_place_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="workshop_place_name_en">
                <template v-slot:label>
                  {{ $t('policyAdvocacy.workshop_place_name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="workshop_place_name_en"
                  v-model="form.workshop_place_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Workshop Place Name (Bn)" vid="workshop_place_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="workshop_place_name_bn">
                <template v-slot:label>
                  {{ $t('policyAdvocacy.workshop_place_name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="workshop_place_name_bn"
                  v-model="form.workshop_place_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Program Duration" vid="program_duration" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="program_duration">
                    <template v-slot:label>
                      {{ $t('policyAdvocacy.workshop_duration') }} <span class="text-danger">*</span>
                    </template>
                    <date-picker
                      id="program_duration"
                      v-model="programDuration"
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
          <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Attachment" vid="attachment" :rules="attachValidation">
                  <b-form-group
                    label-for="attachment"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{ $t('globalTrans.attachment') }}<span class="text-danger">*</span>
                    </template>
                  <b-form-file id="attachment"
                  v-model="form.file"
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
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description" vid="description" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description"
              >
              <template v-slot:label>
                {{$t('globalTrans.description')}} <span class="text-danger">*</span>
              </template>
              <vue-editor
                v-model="form.workshop_description_en"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </vue-editor>
              <div class="invalid-feedback d-block">
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
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { workshopDetailsStore, workshopDetailsUpdate, workshopDetailsList } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
import flatpickr from 'flatpickr'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      isDisable: false,
      programDuration: '',
      ItemShow: false,
      attachValidation: 'required',
      UnionItemShow: false,
      form: {
        application_id: 0,
        workshop_details: '',
        workshop_details_list: '',
        workshop_name_en: '',
        workshop_name_bn: '',
        file: [],
        workshop_place_name_en: '',
        workshop_place_name_bn: '',
        workshop_date_from: '',
        workshop_date_to: '',
        workshop_description_en: '',
        workshop_description_bn: '',
        attachment: ''
      },
        associationInfoList: [],
        applicationListt: []
    }
  },
  created () {
    this.applicationList()
    if (this.id) {
      this.editCheck()
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  mounted () {
    if (this.id) {
        flatpickr('#program_duration', {
          mode: 'range',
          minDate: 'today',
          defaultDate: [this.form.workshop_date_from, this.form.workshop_date_to]
        })
    } else {
        flatpickr('#program_duration', {
          mode: 'range',
          minDate: 'today'
        })
    }
  },
  watch: {
    'form.council_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.associationInfoList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
        }
    },
    programDuration: function (newVal, oldVal) {
      const dateArray = newVal.split('to')
      if (dateArray.length > 1) {
        this.form.workshop_date_from = dateArray[0]
        this.form.workshop_date_to = dateArray[1]
      } else {
        this.form.workshop_date_from = dateArray[0]
        this.form.workshop_date_to = dateArray[0]
      }
     }
     },
  currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    },
  methods: {
    editCheck () {
      this.attachValidation = ''
      this.form.attachment = ''
      this.isDisable = true
      const tmp = this.getData()
      this.form.workshop_name_en = tmp.workshop_name
      this.form.workshop_name_bn = tmp.workshop_name_bn
      this.form.workshop_place_name_en = tmp.workshop_place
      this.form.workshop_place_name_bn = tmp.workshop_place_bn
      this.form.workshop_date_from = tmp.start_date
      this.form.workshop_date_to = tmp.end_date
      this.programDuration = tmp.start_date + ' to ' + tmp.end_date
      this.form.workshop_description_en = tmp.description
      this.form.application_id = tmp.application_id
    },
    onFileChange (event) {
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
    async applicationList () {
      let result = null
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
      result = await RestApi.getData(eBizServiceBaseUrl, workshopDetailsList, this.getData())
      } else {
              result = await RestApi.getData(eBizServiceBaseUrl, workshopDetailsList, null)
      }

      if (result.success) {
        this.applicationListt = result.data.map(el => {
            return Object.assign({ value: el.id, text: el.application_id })
        })
      this.$store.dispatch('mutateCommonProperties', loadingState)
      }
    },
      async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${workshopDetailsUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, workshopDetailsStore, this.form)
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
    },
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
