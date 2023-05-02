<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchBody>
        <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
                  <b-col xs="12" sm="12" md="6">
                    <ValidationProvider name="Condition Type" vid="condition_type" rules="required">
                      <b-form-group
                        label-for="condition_type"
                        slot-scope="{ valid, errors }">
                        <template v-slot:label>
                            {{$t('component_settings.condition_type')}}<span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="form.condition_type"
                        id="condition_type"
                        :options="conditionTypeList"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-select>
                            <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row v-if="form.condition_type === 'depend_other'">
                  <b-col lg="6" xl="6">
                    <ValidationProvider name="Organization" vid="org_id_from" rules="required|min_value:1">
                      <b-form-group
                          :label-for="`org_id_from`"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('globalTrans.organization') }} ({{ $t('globalTrans.from') }}) <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.org_id_from"
                          :options="orgProfileList"
                          id="org_id_from"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('component_settings.select_organization')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="6" xl="6">
                    <ValidationProvider name="Organization" vid="org_id_to" rules="required|min_value:1">
                      <b-form-group
                          :label-for="`org_id_from`"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('globalTrans.organization') }} ({{ $t('globalTrans.to') }})<span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.org_id_to"
                          :options="orgProfileList"
                          id="org_id_to"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('component_settings.select_organization')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="6" xl="6">
                    <ValidationProvider name="Service Name" vid="service_id_from" rules="required|min_value:1">
                      <b-form-group
                          :label-for="`service_id_from`"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('dropdown_settings.service') }} ({{ $t('globalTrans.from') }})<span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.service_id_from"
                          :options="serviceListFrom"
                          id="org_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0" >{{$t('component_settings.select_service')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="6" xl="6">
                    <ValidationProvider name="Service Name" vid="service_id_to" rules="required|min_value:1">
                      <b-form-group
                          :label-for="`service_id_to`"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('dropdown_settings.service') }} ({{ $t('globalTrans.to') }})<span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.service_id_to"
                          :options="serviceListTo"
                          id="org_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0" >{{$t('component_settings.select_service')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                    <b-col lg="6" sm="6">
                    <ValidationProvider name="Year" vid="year" rules="required">
                      <b-form-group
                        label-for="year"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          plain
                          v-model="form.year"
                          id="org_id"
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
                  <b-row v-if="form.condition_type === 'depend_other'">
                      <b-col lg="12" sm="12" md="12">
                        <h5>{{ $t('step_name.rules') }}</h5>
                      </b-col>
                      <b-col lg="10" sm="10" md="10">
                          <ValidationProvider name="Rules En" vid="rule_en">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="2"
                                  label-for="rule_en"
                              >
                                  <template v-slot:label>
                                      {{$t('component_settings.rule_input_en')}}
                                  </template>
                                  <b-form-input
                                  id="label"
                                  v-model="rule_item.text"
                                  :placeholder="$t('component_settings.rule_input_en')"
                                  ></b-form-input>
                              </b-form-group>
                          </ValidationProvider>
                          <ValidationProvider name="Rules Bn" vid="rule_bn">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="2"
                                  label-for="rule_bn"
                              >
                                  <template v-slot:label>
                                      {{$t('component_settings.rule_input_bn')}}
                                  </template>
                                  <b-form-input
                                  id="label"
                                  v-model="rule_item.text_bn"
                                  :placeholder="$t('component_settings.rule_input_bn')"
                                  ></b-form-input>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="2" sm="2" md="2">
                          <b-button @click="addItem" variant="primary" class="btn-sm"><i class="ri-add-fill"></i></b-button>
                      </b-col>
                  </b-row>
                  <b-row v-if="form.condition_type === 'depend_other'">
                      <b-col>
                          <table class="table">
                              <tr v-for="(item, index) in form.rules" :key="index">
                                  <td>
                                      <ValidationProvider name="Rule En" vid="rule_en">
                                          <b-form-group
                                              class="row"
                                              label-cols-sm="4"
                                              label-for="rule_en"
                                          >
                                              <template v-slot:label>
                                                  {{$t('component_settings.rule_input_en')}}
                                              </template>
                                              <b-form-input
                                                  id="label"
                                                  v-model="item.text"
                                                  :placeholder="$t('component_settings.rule_input_bn')"
                                              ></b-form-input>
                                          </b-form-group>
                                      </ValidationProvider>
                                      <ValidationProvider name="Rule Bn" vid="rule_bn">
                                          <b-form-group
                                              class="row"
                                              label-cols-sm="4"
                                              label-for="rule_bn"
                                          >
                                              <template v-slot:label>
                                                  {{$t('component_settings.rule_input_bn')}}
                                              </template>
                                              <b-form-input
                                                  id="label"
                                                  v-model="item.text_bn"
                                                  :placeholder="$t('component_settings.rule_input_bn')"
                                              ></b-form-input>
                                          </b-form-group>
                                      </ValidationProvider>
                                  </td>
                                  <td class="text-right">
                                      <button @click="deleteItem(index)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i></button>
                                  </td>
                              </tr>
                          </table>
                      </b-col>
                  </b-row>
                  <b-row v-if="form.condition_type === 'notice'">
                    <b-col lg="6" xl="6">
                      <ValidationProvider name="Organization" vid="org_id_from" rules="required|min_value:1">
                        <b-form-group
                            :label-for="`org_id_from`"
                            slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            v-model="form.org_id"
                            :options="orgProfileList"
                            id="org_id_from"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                              <b-form-select-option :value="0">{{$t('component_settings.select_organization')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" xl="6">
                      <ValidationProvider name="Service Name" vid="service_id_from" rules="required|min_value:1">
                        <b-form-group
                            :label-for="`service_id_from`"
                            slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{ $t('dropdown_settings.service') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            v-model="form.service_id_from"
                            :options="serviceListTo"
                            id="org_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                              <b-form-select-option :value="0" >{{$t('component_settings.select_service')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" xl="6">
                      <ValidationProvider name="Notice" vid="notice_id" rules="required|min_value:1">
                        <b-form-group
                            :label-for="`notice_id`"
                            slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{ $t('component_settings.notice') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            v-model="form.notice_id"
                            :options="noticeList"
                            id="notice_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                              <b-form-select-option :value="0">{{$t('component_settings.select_notice')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" sm="12">
                        <ValidationProvider name="Start date" vid="start_date" rules="required">
                            <b-form-group
                                label-for="start_date"
                                slot-scope="{ valid, errors }"
                            >
                                <template v-slot:label>
                                    {{$t('globalTrans.start_date')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-datepicker
                                  b-form-datepicker
                                  id="end_date"
                                  v-model="form.start_date"
                                  :placeholder="$t('globalTrans.select_date')"
                                  :state="errors[0] ? false : (valid ? true : null)">
                                </b-form-datepicker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col lg="6" sm="12">
                        <ValidationProvider name="End date" vid="end_date" rules="required">
                            <b-form-group
                                label-for="end_date"
                                slot-scope="{ valid, errors }"
                            >
                                <template v-slot:label>
                                    {{$t('globalTrans.end_date')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-datepicker
                                  b-form-datepicker
                                  id="end_date"
                                  v-model="form.end_date"
                                  :placeholder="$t('globalTrans.select_date')"
                                  :state="errors[0] ? false : (valid ? true : null)">
                                </b-form-datepicker>
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
        </b-row>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { preconditionStore, preconditionUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        condition_type: 'depend_other',
        org_id: 0,
        org_id_from: 0,
        org_id_to: 0,
        service_id_from: 0,
        service_id_to: 0,
        year: '',
        rules: [],
        notice_id: 0,
        start_date: '',
        end_date: ''
      },
      rule_item: {
        text: '',
        text_bn: '',
        checked: false
      },
      serviceListFrom: [],
      serviceListTo: [],
      loading: false,
      preConditionTypeList: [
        { item: 'depend_other', text_en: 'Otehr Service Dependent', text_bn: 'অন্যান্য সেবা নির্ভর' },
        { item: 'notice', text_en: 'Notice', text_bn: 'নোটিস' }
      ],
      noticeList: []
    }
  },
  created () {
    if (this.$route.query.id) {
      const tmp = this.getEditData()
      this.form = tmp
      this.form.rules = JSON.parse(tmp.rules)
    }
  },
  watch: {
    'form.org_id_from': function (newVal) {
      this.serviceListFrom = this.getServiceList(newVal)
    },
    'form.org_id_to': function (newVal) {
      this.serviceListTo = this.getServiceList(newVal)
    },
    'form.org_id': function (newVal) {
      this.serviceListTo = this.getServiceList(newVal)
    },
    'form.service_id_from': function (newVal) {
      if (this.form.condition_type === 'notice') {
        this.form.service_id_to = newVal
        this.noticeList = this.$store.state.LicenseRegistrationService.commonObj.noticeList.filter(item => item.service_id === parseInt(newVal))
      }
    },
    'form.notice_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const data = this.$store.state.LicenseRegistrationService.commonObj.noticeList.find(item => item.value === newVal)
        this.form.start_date = data.start_date
        this.form.end_date = data.end_date
      }
    }
},
  computed: {
    orgProfileList () {
        const pp = this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
        return pp
    },
    conditionTypeList: function () {
        return this.preConditionTypeList.map(item => {
            return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
        })
    }
  },
  methods: {
    addItem () {
        const drpOption = JSON.parse(JSON.stringify(this.rule_item))
        this.form.rules.push(drpOption)
        this.rule_item.text = ''
        this.rule_item.text_bn = ''
    },
    deleteItem (index) {
      this.form.rules.splice(index, 1)
    },
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.query.id))
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      this.loading = true
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${preconditionUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, preconditionStore, this.form)
      }
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$router.go(-1)
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    }
  }
}
</script>
