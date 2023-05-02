<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="6">
          <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
            <b-form-group
            label-for="org_id"
            slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
            plain
            v-model="form.org_id"
            :options="orgProfileList"
            id="org_id"
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
        <b-col sm="6">
          <ValidationProvider name="Notification Type" vid="notification_type_id" rules="required|min_value:1">
            <b-form-group
            label-for="notification_type_id"
            slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('notification.notification_type')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
            plain
            v-model="form.notification_type_id"
            :options="notificationTypeList"
            id="notification_type_id"
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
        <b-col sm="6">
          <ValidationProvider name="Notice Title (En)" vid="notice_title" rules="required" v-slot="{ errors }">
            <b-form-group
            label-for="notice_title">
            <template v-slot:label>
              {{ $t('notification.notice_title') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="notice_title"
              v-model="form.notice_title"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Notice Title (Bn)" vid="notice_title_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="notice_title_bn">
              <template v-slot:label>
              {{ $t('notification.notice_title_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
              id="notice_title_bn"
              v-model="form.notice_title_bn"
              :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Description (En)" vid="description" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="description">
              <template v-slot:label>
                {{ $t('notification.notice_description') }} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
                rows="3"
                id="mobile"
                v-model="form.description"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Description (Bn)" vid="description_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="description_bn">
              <template v-slot:label>
                {{ $t('notification.notice_description_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
              rows="3"
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
        <b-col sm="6">
          <ValidationProvider name="Notice For" vid="notice_for" rules="min_value:1">
              <b-form-group
              label-for="notice_for"
              slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('notification.notice_for')}}
              </template>
              <b-form-select
              plain
              v-model="form.notice_for"
              :options="noticeForList"
              id="notice_for"
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
        <b-col sm="6">
          <ValidationProvider name="Office name" vid="office_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_id"
                  :options="officeList"
                  id="office_id"
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
        <b-col sm="6">
         <ValidationProvider name="Designation Name" vid="designation_id" rules="required|min_value:1">
                <b-form-group
                  label-for="designation_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.designation_id"
                  :options="assignDesignationList"
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
        <b-col sm="6">
         <ValidationProvider name="Notice Date" vid="notice_date" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="notice_date">
              <template v-slot:label>
                {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
              </template>
              <b-form-datepicker b-form-datepicker id="notice_date" v-model="form.notice_date"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-datepicker>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
        </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Notice Time" vid="notice_time" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="notice_time">
              <template v-slot:label>
                {{ $t('globalTrans.time') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="notice_time"
                type="time"
                v-model="form.notice_time"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
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
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { circulateNoticeStore, circulateNoticeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        notification_type_id: 0,
        notice_title: '',
        notice_title_bn: '',
        description: '',
        description_bn: '',
        notice_for: 0,
        office_id: 0,
        designation_id: 0,
        notice_date: '',
        notice_time: ''
      },
      officeList: [],
      assignDesignationList: [],
      notificationTypes: [],
      menuList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getComponent()
      this.form = tmp
    }
  },
   watch: {
    'form.org_id': function (newVal, oldVal) {
      this.officeList = this.getOfficeList(newVal)
    },
    'form.office_id': function (newVal, oldVal) {
      this.assignDesignationList = this.getdesignationList(newVal)
    }
  },
  computed: {
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    orgProfileList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    notificationTypeList () {
      return this.$store.state.CommonService.commonObj.notificationTypeList.filter(item => item.status === 1)
    },
    // noticeForList: function () {
    //   return this.$store.state.CommonService.commonObj.noticeforList
    // },
     noticeForList: function () {
      return [
        { value: 1, text: 'Service Provider', text_bn: 'সার্ভিস প্রদানকারী' },
        { value: 2, text: 'Service Receiver', text_bn: 'সার্ভিস গ্রহণকারী' }
      ]
    }
  },
  methods: {
    getOfficeList (officeId) {
    return this.$store.state.CommonService.commonObj.officeList.filter(office => office.org_id === officeId)
    },
    getdesignationList (officeId) {
      return this.$store.state.CommonService.commonObj.assignDesignationList.filter(desgn => desgn.office_id === officeId && desgn.office_id === this.form.office_id && desgn.org_id === this.form.org_id)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${circulateNoticeUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, circulateNoticeStore, this.form)
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
    getComponent () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
