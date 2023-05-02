<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <!-- course_name -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Course Name" vid="course_id" rules="required|min_value:1">
              <b-form-group
                  label-for="course_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('teaGardenPduService.course_name')}}  <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                  plain
                  v-model="data.course_id"
                  :options="courseList"
                  id="service_id"
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
          <!-- course_fee -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Course Fee" vid="course_fee" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="course_fee">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.course_fee') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  @keypress="isNumber"
                  id="course_fee"
                  v-model="data.course_fee"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- circular_title_en -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Circular Name (En)" vid="circular_title_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="circular_title_en">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.circular_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="circular_title_en"
                  v-model="data.circular_title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- circular_title_bn -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Circular Name (Bn)" vid="circular_title_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="circular_title_bn">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.circular_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="circular_title_bn"
                  v-model="data.circular_title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- batch_no -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Course Fee" vid="batch_no" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="batch_no">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.batch_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  @keypress="isNumber"
                  id="batch_no"
                  v-model="data.batch_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- duration -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Duration" vid="duration" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="duration">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.duration') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  @keypress="isNumber"
                  id="duration"
                  v-model="data.duration"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- total_candidate -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Total Candidate" vid="total_candidate" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="total_candidate">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.total_candidate') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  @keypress="isNumber"
                  id="total_candidate"
                  v-model="data.total_candidate"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- nominated_candidate -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Nominated Candidate" vid="nominated_candidate" :rules="{ required: true, max_value :data.total_candidate }">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="nominated_candidate">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.nominated_candidate') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  :max="data.total_candidate"
                  @keypress="isNumber"
                  id="nominated_candidate"
                  v-model="data.nominated_candidate"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- general_candidate -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="General Candidate" vid="general_candidate" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="general_candidate">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.general_candidate') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  :min="0"
                  @keypress="isNumber"
                  id="general_candidate"
                  v-model="data.general_candidate"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- tentative_start_date -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Tentative Start Date" vid="tentative_start_date" rules="required">
              <b-form-group
                class="row"
                label-for="tentative_start_date"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.tentative_start_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="tentative_start_date"
                  v-model="data.tentative_start_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="config"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- tentative_end_date -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Tentative End Date" vid="tentative_end_date" rules="required">
              <b-form-group
                class="row"
                label-for="tentative_end_date"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.tentative_end_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="tentative_end_date"
                  v-model="data.tentative_end_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="config"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- start_time -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Start Time" vid="start_time" rules="required">
              <b-form-group
                class="row"
                label-for="start_time"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.start_time') }}  <span class="text-danger">*</span>
                </template>
                <input v-model="data.start_time" id="start_time" type="time" class="form-control"/>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- end_time -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="End Time" vid="end_time" rules="required">
              <b-form-group
                class="row"
                label-for="end_time"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.end_time') }}  <span class="text-danger">*</span>
                </template>
                <input v-model="data.end_time" id="end_time" type="time" class="form-control"/>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- application_deadline -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Application Deadline" vid="application_deadline" rules="required">
              <b-form-group
                class="row"
                label-for="application_deadline"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.application_deadline') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="application_deadline"
                  v-model="data.application_deadline"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="config"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- attachment -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment" :rules="{required: false}">
              <b-form-group
                class="row"
                label-for="attachment"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenPduService.attachment') }}
                </template>
                <div class="d-flex">
                    <b-form-file accept="application/pdf,image/*" id="attachment" v-model="data.attachment"
                      @change="onChange" :state="errors[0] ? false : (valid ? true : null)"
                      :placeholder="$t('globalTrans.attachment_placeholder')"
                      :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                      <a target="_blank" style = "margin-left: 8px;" v-if="data.attachment && checkBase64(data.attachment) === false" :href="isImage(data.attachment) ? teaGardenServiceBaseUrl + 'storage' + data.attachment : teaGardenServiceBaseUrl + data.attachment" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                  </div>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- description_en -->
           <b-col xs="12" sm="12">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                </template>
                <vue-editor
                  id="description_en"
                  v-model="data.description_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></vue-editor>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- description_bn -->
           <b-col xs="12" sm="12">
            <ValidationProvider name="Description (Bn)" vid="description_bn">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <vue-editor
                  id="description_bn"
                  v-model="data.description_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></vue-editor>
                <div class="invalid-feedback">
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { circularStore, circularUpdate, getCircularBatchNumber } from '../../api/routes'
import { helpers } from '@/utils/helper-functions'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      valid: null,
      config: { static: true },
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      data: {
        course_id: 0,
        course_fee: 0,
        batch_no: 0
      },
      course_info: {}
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircularList()
      this.data = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    courseList: function () {
      return this.$store.state.TeaGardenService.commonObj.pduCourseList.filter(item => item.status === 1)
    },
    currentLocale () {
        return this.$i18n.locale
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${circularUpdate}/${this.id}`, this.data)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, circularStore, this.data)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
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
    isNumber (evt) {
        helpers.isNumber(evt)
    },
    getCircularList () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getCourseInfo (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.pduCourseList.find(item => item.value === id)
      if (obj) {
        this.course_info = obj
        this.data.course_fee = obj.course_fee
      } else {
        this.data.course_fee = 0
      }
    },
    async getBatchNumber (courseId) {
      let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, `${getCircularBatchNumber}/${courseId}`)
      if (result) {
          this.data.batch_no = result
      }
    },
    onChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
                this.data.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
        } else {
            this.data.attachment = ''
        }
      },
      checkBase64 (string) {
          var result = ''
          result = string.match('data:')
          if (result) {
              return true
          } else {
              return false
          }
      },
      isImage (path) {
        return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
      }
  },
  watch: {
    'data.course_id': function (newVal, oldVal) {
      if (newVal) {
        this.getCourseInfo(newVal)
        // only for when circular create
        if (!this.id) {
          this.getBatchNumber(newVal)
        }
      } else {
        this.data.course_fee = 0
        this.data.batch_no = 0
      }
    },
    'data.nominated_candidate': function (newVal, oldVal) {
      if (this.data.total_candidate) {
        this.data.general_candidate = this.data.total_candidate - this.data.nominated_candidate
      }
    }
  }
}
</script>
