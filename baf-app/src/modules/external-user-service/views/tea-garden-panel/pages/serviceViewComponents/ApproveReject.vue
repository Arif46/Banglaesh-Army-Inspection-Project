<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12" class="mt-5">
        <iq-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ parseInt(stepChange.status) === 1 ? $t('globalTrans.approve') : $t('globalTrans.reject') }}</h4>
          </template>
          <template v-slot:body>
            <b-overlay :show="loading">
              <b-row>
                <b-col lg="10" sm="12" offset-lg="1">
                  <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                        <ValidationProvider name="Select Note" vid="note_id">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="note_id"
                                >
                                <template v-slot:label>
                                {{ $t('li_step.select_note')}}
                                </template>
                                <b-form-select
                                plain
                                v-model="form.note_id"
                                :options="noteList"
                                id="note_id"
                                >
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                                </b-form-select>
                            </b-form-group>
                        </ValidationProvider>
                        <ValidationProvider name="Note" vid="note" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="note"
                                slot-scope="{ valid, errors }"
                            >
                                <template v-slot:label>
                                    {{ $t('budget.note') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-textarea
                                plain
                                v-model="form.note"
                                id="note"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                </b-form-textarea>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                        <ValidationProvider name="attachment" vid="attachment" rules="">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="attachment"
                                >
                                <template v-slot:label>
                                {{ $t('globalTrans.attachment') }}
                                </template>
                                <b-form-file
                                id="attachment"
                                v-model="form.attachment"
                                v-on:change="onFileChange"
                                ></b-form-file>
                            </b-form-group>
                        </ValidationProvider>
                      <div class="row">
                        <div class="col-8 offset-4" sm="12">
                          <div class="text-right">
                            <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                              &nbsp;
                            <b-button variant="danger" class="mr-1" @click="cancleBtn()">{{ $t('globalTrans.cancel') }}</b-button>
                          </div>
                        </div>
                      </div>
                    </b-form>
                  </ValidationObserver>
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </iq-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dynamicFormAppRej } from '../../api/routes'
import router from '../../../../../router'

export default {
  props: ['stepChange', 'fromdetails'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      loading: false,
      saveBtnName: this.$t('globalTrans.save'),
      form: {
        step_id: this.stepChange.step_id,
        service_id: this.stepChange.service_id,
        application_id: this.stepChange.application_id,
        status: this.stepChange.status,
        note: '',
        next_step_id: '',
        note_id: 0,
        attachment: ''
      }
    }
  },
  created () {
    this.form.next_step_id = this.getServiceWiseStep(this.stepChange.service_id)
  },
  watch: {
    'form.note_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.setNote(newVal)
      }
    }
  },
  computed: {
    noteList: function () {
      return this.$store.state.licenseRegistration.commonObj.orgNotesList.filter(item => item.status === 1)
    }
  },
  methods: {
    setNote (noteId) {
      const note = this.noteList.find(item => item.value === noteId)
      if (note !== undefined) {
        if (this.$i18n.locale === 'bn') {
          this.form.note = note.text_bn
        } else {
          this.form.note = note.text_en
        }
      }
    },
    cancleBtn () {
      if (this.fromdetails !== undefined) { // this will check the source weather it is come from deatails page or List
        router.go(-2)
      } else {
        router.go(-1)
      }
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.stepChange.step_id))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (this.stepChange.status === 2) {
          return this.stepChange.step_id
        } else if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        } else {
          return this.stepChange.step_id
        }
    },
    async saveData () {
        this.loading = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, dynamicFormAppRej, this.form)
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        this.loading = false

        if (result.success) {
            this.$store.commit('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
            this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
            })
            this.cancleBtn()
        } else {
            this.$refs.form.setErrors(result.errors)
        }
    },
    onFileChange (e) {
      this.getBase64(e.target.files[0]).then(res => {
        this.form.attachment = res
      })
    },
    getBase64 (file) {
      return new Promise(function (resolve, reject) {
        const reader = new FileReader()
        let imgResult = ''
        reader.readAsDataURL(file)
        reader.onload = function () {
            imgResult = reader.result
        }
        reader.onerror = function (error) {
            reject(error)
        }
        reader.onloadend = function () {
            resolve(imgResult)
        }
      })
    }
  }
}
</script>
