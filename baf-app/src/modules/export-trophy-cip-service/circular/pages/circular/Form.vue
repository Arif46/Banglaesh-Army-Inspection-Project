<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="4">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
              <b-form-group
                label-for="fiscal_year_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('externalUser.et')}} {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.fiscal_year_id"
                :options="fiscalYearList"
                id="fiscal_year_id"
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
          <b-col sm="3">
            <ValidationProvider name="Year" vid="year" rules="required|min_value:1">
            <b-form-group
              label-for="year"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('externalUser.cip')}} {{$t('globalTrans.year')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.year"
              :options="YearList"
              id="year"
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
          <b-col sm="5">
            <ValidationProvider name="Memo No" vid="memo_no" rules="required|max:255">
              <b-form-group
                label-for="memo_no"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.memo_no')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.memo_no"
                id="memo_no"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Title (En)" vid="title_en" rules="required|max:255">
              <b-form-group
                label-for="title_en"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.title_en')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.title_en"
                id="title_en"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required|max:255">
              <b-form-group
                label-for="title_bn"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.title_bn')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.title_bn"
                id="title_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="app_start_date" vid="app_start_date" rules="required">
              <b-form-group
                label-for="app_start_date"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('exportTrophyCircular.app_start_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  class="form-control"
                  :config="{ static: true }"
                  v-model="form.app_start_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  id="app_start_date"
                >
                </date-picker>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Deadline" vid="deadline" rules="required">
              <b-form-group
                label-for="deadline"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('exportTrophyCircular.deadline') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  class="form-control"
                  :config="{ static: true }"
                  v-model="form.deadline"
                  :state="errors[0] ? false : (valid ? true : null)"
                  id="deadline"
                >
                </date-picker>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Date" vid="date" rules="required">
              <b-form-group
                label-for="date"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('exportTrophyCircular.circular_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  class="form-control"
                  :config="{ static: true }"
                  v-model="form.date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  id="date"
                >
                </date-picker>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Attachment" vid="attachment" :rules="!id ?'required|size:2048':''">
              <b-form-group
                label-for="attachment"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('exportTrophyCircular.attachment_type')}} <span class="text-danger" v-if="!id">*</span>
                </template>
                <b-form-file
                    accept="application/pdf,application/doc,application/docx"
                    id="attachment"
                    v-model="form.file"
                    @change="handleAttachment"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-file>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              <span v-if="id && form.oldfile">
                <a :href="exportTrophyCIPServiceBaseUrl + 'download-attachment?file=' + form.oldfile" class="badge badge-primary mt-4">
                  <i class="ri-cloud-fill"></i>
                  {{ $t('globalTrans.attachment') }}
                </a>
              </span>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <ValidationProvider name="Description (En)" vid="description_en">
            <b-form-group
              label-for="description_en"
              slot-scope="{ errors }"
            >
            <template v-slot:label>
              {{$t('globalTrans.description_en')}}
            </template>
              <vue-editor v-model="form.description_en"></vue-editor>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
          <ValidationProvider name="Description (Bn)" vid="description_bn">
            <b-form-group
              label-for="description_bn"
              slot-scope="{ errors }"
            >
            <template v-slot:label>
              {{$t('globalTrans.description_bn')}}
            </template>
              <vue-editor v-model="form.description_bn"></vue-editor>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-row>
        <b-row>
          <b-col sm="4">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.org_id"
                :options="orgList"
                id="org_id"
                disabled
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
          <b-col sm="4">
            <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
              <b-form-group
                label-for="designation_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('globalTrans.designation') }} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.designation_id"
                :options="designationList"
                id="designation_id"
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
          <b-col sm="4">
            <ValidationProvider name="Officer name" vid="contract_user_id" rules="required|min_value:1">
              <b-form-group
                label-for="contract_user_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('exportTrophyCircular.employee') }} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.contract_user_id"
                :options="userList"
                id="contract_user_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{ userLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Contact Person Name (En)" vid="contact_person_name_en" rules="required">
              <b-form-group
                label-for="contact_person_name_en"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.contact_person_name_en')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                disabled
                v-model="form.contact_person_name_en"
                id="contact_person_name_en"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Contact Person Name (Bn)" vid="contact_person_name_bn" rules="required">
              <b-form-group
                label-for="contact_person_name_bn"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.contact_person_name_bn')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                disabled
                v-model="form.contact_person_name_bn"
                id="contact_person_name_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Contact number" vid="contact_person_mobile" rules="required|max:20">
              <b-form-group
                label-for="contact_person_mobile"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.contact_person_mobile')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.contact_person_mobile"
                id="contact_person_mobile"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Contact Person Email" vid="contact_person_email" rules="required">
              <b-form-group
                label-for="contact_person_email"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.contact_person_email')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.contact_person_email"
                id="contact_person_email"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
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
import RestApi, { authServiceBaseUrl, exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { userListByDesignationApi, circularStoreApi, circularUpdateApi } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
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
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      form: {
        fiscal_year_id: 0,
        year: 0,
        memo_no: '',
        title_en: '',
        title_bn: '',
        description_en: '',
        description_bn: '',
        attachment: null,
        date: '',
        app_start_date: '',
        deadline: '',
        org_id: 2,
        contact_person_name_en: '',
        contact_person_name_bn: '',
        contact_person_mobile: '',
        contact_person_email: '',
        designation_id: 0,
        file: [],
        contract_user_id: 0
      },
      userList: [],
      tmpUserList: [],
      userLoading: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircularInfo()
      this.form = tmp
      this.form.oldfile = tmp.attachment
      this.loading = true
      this.getUserNameGetUserName(this.form.contract_user_id)
      this.loading = false
      this.form.app_start_date = this.form.app_date
      this.form.deadline = this.form.deadline_date
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.localizeUserList(newVal)
      }
    },
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getUser(newVal)
      }
    },
    'form.contract_user_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getUserNameGetUserName(newVal)
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    designationList: function () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.value === 2).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    YearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item) }
        } else {
          return { value: item, text: item }
        }
      })
    }
  },
  methods: {
    getUser (designationId) {
      this.getUserList(designationId)
    },
    getUserList (designationId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, `${userListByDesignationApi}/${designationId}`).then(response => {
        this.tmpUserList = response
        const userList = response.map((obj, index) => {
          return Object.assign({}, obj, {
            value: obj.value,
            text: this.currentLocale === 'en' ? obj.text_en : obj.text_bn
          })
        })
        this.userList = userList
        this.userLoading = false
        return userList
      })
    },
    localizeUserList (locale) {
      const tmp = this.userList.map(item => {
        return Object.assign({}, item, {
          text: locale === 'en' ? item.text_en : item.text_bn
        })
      })
      this.userList = tmp
    },
    getUserNameGetUserName (val) {
      if (this.tmpUserList.length > 0) {
        const user = this.tmpUserList.find(el => el.value === val)
        this.form.contact_person_name_en = ''
        this.form.contact_person_name_bn = ''
        if (user !== undefined) {
          this.form.contact_person_name_en = user.text_en
          this.form.contact_person_name_bn = user.text_bn
        }
      }
    },
    handleAttachment (e) {
      const bytesize = e.target.files[0].size
      const kbsize = bytesize / 1024
      if (kbsize > 2048) {
        this.form.attachment = ''
        this.form.file = []
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('exportTrophyCircular.fileType'),
          color: '#ee5253'
        })
        return
      }
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = null
      }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.toString().replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.toString().replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${circularUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, circularStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.error({
          title: 'Warning',
          message: this.$t('exportTrophyCircular.circular_exist'),
          color: '#9d0007'
        })
        return
      }
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
    getCircularInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getServiceProduct (serviceProduct) {
      const exportSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(exportSector => exportSector.value === parseInt(serviceProduct))
      if (exportSectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? exportSectorObj.text_bn : exportSectorObj.text_en
      }
    }
  }
}
</script>
