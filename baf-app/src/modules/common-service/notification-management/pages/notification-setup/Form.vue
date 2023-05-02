<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="6">
          <ValidationProvider name="Component" vid="component_id" rules="required|min_value:1">
            <b-form-group
              label-for="component_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('menu.component')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.component_id"
              :options="componentList"
              id="component_id"
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
          <ValidationProvider name="Module" vid="module_id" rules="required|min_value:1">
            <b-form-group
              label-for="module_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('menu.module')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.module_id"
              :options="moduleList"
              id="module_id"
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
          <ValidationProvider name="Service" vid="service_id" rules="min_value:1">
            <b-form-group
              label-for="service_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('menu.service')}}
            </template>
            <b-form-select
              plain
              v-model="form.service_id"
              :options="serviceList"
              id="service_id"
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
          <ValidationProvider name="Menu" vid="menu_id" rules="required|min_value:1">
            <b-form-group
              label-for="menu_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('menu.menu')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.menu_id"
              :options="menuList"
              id="menu_id"
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
          <ValidationProvider name="Button" vid="button_id" rules="required|min_value:1">
            <b-form-group
              label-for="button_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('notification.button')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.button_id"
              :options="buttonList"
              id="button_id"
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
          <ValidationProvider name="Template" vid="template_id" rules="required|min_value:1">
            <b-form-group
              label-for="template_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('notification.template')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.template_id"
              :options="templateList"
              id="template_id"
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
          <ValidationProvider name="Mobile" vid="mobile" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="mobile">
              <template v-slot:label>
                {{ $t('notification.mobile') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="mobile"
                v-model="form.mobile_text"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Menu Name (Bn)" vid="email_web_text" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="email_web_text">
              <template v-slot:label>
                {{ $t('notification.email_web_text') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="email_web_text"
                v-model="form.email_web_text"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Media" vid="media_id" rules="required">
          <b-form-group
              class="row"
              label-cols-sm="3"
              label-for="media_id"
              slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
              {{$t('notification.media')}} <span class="text-danger">*</span>
          </template>
              <b-form-checkbox-group
                  v-model="form.media_id"
                  :options="mediaList"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-checkbox-group>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
          </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Recipients" vid="recipient_id" rules="required">
          <b-form-group
              class="row"
              label-cols-sm="3"
              label-for="recipient_id"
              slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
              {{$t('notification.recipients')}} <span class="text-danger">*</span>
          </template>
              <b-form-checkbox-group
                  v-model="form.recipient_id"
                  :options="recipientList"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-checkbox-group>
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
import { notificationSetupStore, notificationSetupUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        component_id: 0,
        module_id: 0,
        service_id: 0,
        menu_id: 0,
        template_id: 0,
        button_id: 0,
        mobile_text: '',
        email_web_text: '',
        media_id: [],
        recipient_id: []
      },
      moduleList: [],
      serviceList: [],
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
    'form.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.moduleList = this.getModuleList(newVal)
      }
    },
    'form.module_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.getServiceList()
      }
    },
    'form.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.menuList = this.getMenuList()
      }
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
    templateList: function () {
      return this.$store.state.CommonService.commonObj.notificationTemplateList
    },
    mediaList: function () {
      return this.$store.state.CommonService.commonObj.menuList
    },
    recipientList: function () {
      return this.$store.state.CommonService.commonObj.menuList
    },
    buttonList: function () {
      return [
        { value: 1, text: 'Pending', text_bn: 'Pending' },
        { value: 2, text: 'Processing', text_bn: 'Processing' },
        { value: 3, text: 'Approved', text_bn: 'Approved' },
        { value: 4, text: 'Reject', text_bn: 'Reject' },
        { value: 5, text: 'Send', text_bn: 'Send' },
        { value: 6, text: 'Forward', text_bn: 'Forward' },
        { value: 7, text: 'Receive', text_bn: 'Receive' },
        { value: 8, text: 'Application', text_bn: 'Application' },
        { value: 9, text: 'Assign', text_bn: 'Assign' }
      ]
    }
  },
  methods: {
    getModuleList (componentId) {
      return this.$store.state.CommonService.commonObj.moduleList.filter(item => item.component_id === componentId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getServiceList () {
      return this.$store.state.CommonService.commonObj.serviceList.filter(item => item.component_id === this.form.component_id && item.module_id === this.form.module_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getMenuList () {
      return this.$store.state.CommonService.commonObj.menuList.filter(item => item.component_id === this.form.component_id && item.module_id === this.form.module_id && item.service_id === this.form.service_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${notificationSetupUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, notificationSetupStore, this.form)
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
