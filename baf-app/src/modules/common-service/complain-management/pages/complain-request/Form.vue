<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('organogram.org')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.org_id"
                :options="orgList"
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
            <ValidationProvider name="Service" vid="service_id" rules="">
              <b-form-group
                label-for="service_id"
              >
              <template v-slot:label>
                {{$t('menu.service')}}
              </template>
              <b-form-select
                plain
                v-model="form.service_id"
                :options="serviceList"
                id="service_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
              <b-form-group
                label-for="division_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.division')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.division_id"
                :options="divisionList"
                id="division_id"
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
            <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
              <b-form-group
                label-for="district_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.division')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.district_id"
                :options="districtList"
                id="district_id"
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
            <ValidationProvider name="Upazila" vid="upazila_id" rules="required|min_value:1">
              <b-form-group
                label-for="upazila_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.upazila')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.upazila_id"
                :options="upazilaList"
                id="upazila_id"
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
            <ValidationProvider name="Union" vid="union_id" rules="required|min_value:1">
              <b-form-group
                label-for="union_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.union')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.union_id"
                :options="unionList"
                id="union_id"
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
            <ValidationProvider name="Complain Title (En)" vid="com_title" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="com_title">
                <template v-slot:label>
                  {{ $t('complain_management.complain_title_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="com_title"
                  v-model="form.com_title"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Complain Title (Bn)" vid="com_title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="com_title_bn">
                <template v-slot:label>
                  {{ $t('complain_management.complain_title_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="com_title_bn"
                  v-model="form.com_title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
              <b-form-group
                label-for="email">
                <template v-slot:label>
                  {{ $t('globalTrans.email') }}
                </template>
                <b-form-input
                  id="email"
                  v-model="form.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Mobile" vid="mobile_no" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="mobile_no">
                <template v-slot:label>
                  {{ $t('globalTrans.mobile') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="mobile_no"
                  v-model="form.mobile_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col><b-col sm="12">
            <ValidationProvider name="Description (En)" vid="description_en" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description_en') }}
                </template>
                <vue-editor
                id="description_en"
                v-model="form.description"
                ></vue-editor>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Description (Bn)" vid="description_bn" rules="">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description_bn') }}
                </template>
                <vue-editor
                id="description_bn"
                v-model="form.description_bn"
                ></vue-editor>
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { complainSubmitStore, complainSubmitUpdate } from '../../api/routes'
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
      form: {
        org_id: 0,
        component_id: 0,
        module_id: 0,
        service_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        com_title: '',
        com_title_bn: '',
        email: '',
        mobile_no: '',
        description: '',
        description_bn: ''
      },
      moduleList: [],
      serviceList: [],
      districtList: [],
      upazilaList: [],
      unionList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getComplain()
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
    'form.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList()
      }
    },
    'form.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList()
      }
    },
    'form.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList()
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
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
    getDistrictList () {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.division_id === this.form.division_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUpazilaList () {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.district_id === this.form.district_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUnionList () {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.division_id === this.form.division_id && item.district_id === this.form.district_id && item.upazila_id === this.form.upazila_id).map(obj => {
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
        result = await RestApi.putData(commonServiceBaseUrl, `${complainSubmitUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, complainSubmitStore, this.form)
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
    getComplain () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
