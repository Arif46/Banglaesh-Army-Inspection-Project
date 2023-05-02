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
            <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Type of business" vid="type_of_business_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="type_of_business_id"
                >
                <template v-slot:label>
                  {{$t('eBizConfig.type_of_business')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.type_of_business_id"
                  :options="typeOfBusinessList"
                  id="type_of_business_id"
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
            </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Name (En)" vid="company_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="company_name">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_name"
                  v-model="form.company_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="company_name_bn">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_name_bn"
                  v-model="form.company_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Mobile" vid="company_mobile" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="company_mobile">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_mobile') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_mobile"
                  v-model="form.company_mobile"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Email" vid="company_email" v-slot="{ errors }" rules="required|email">
              <b-form-group
                label-for="company_email">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_email') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_email"
                  type="company_email"
                  v-model="form.company_email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Address (En)" vid="company_address" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="company_address">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_address') }} {{ $t('globalTrans.en') }}  <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="company_address"
                    rows="3"
                    v-model="form.company_address"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Company Address (Bn)" vid="company_address_bn" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="company_address_bn">
                <template v-slot:label>
                  {{ $t('InformationTraining.company_address') }} {{ $t('globalTrans.bn') }}  <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="company_address_bn"
                    rows="3"
                    v-model="form.company_address_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
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
import { businessDirectoryStore, businessDirectoryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  components: {
  },
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.finalSave'),
      errors: [],
      isDisable: false,
      draftBtnName: this.$t('globalTrans.draft'),
      form: {
          council_info_id: 0,
          association_info_id: 0,
          type_of_business_id: 0,
          company_name: '',
          company_name_bn: '',
          company_address: '',
          company_address_bn: '',
          company_mobile: '',
          company_email: ''
      },
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
            result = await RestApi.putData(eBizServiceBaseUrl, `${businessDirectoryUpdate}/${this.id}`, this.form)
          } else {
            result = await RestApi.postData(eBizServiceBaseUrl, businessDirectoryStore, this.form)
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
