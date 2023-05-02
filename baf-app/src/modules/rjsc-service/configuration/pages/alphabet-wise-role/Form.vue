<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
            <b-col md="6" sm="12">
              <ValidationProvider name="Alphabet" vid="alphabet_id" rules="required|min_value:1">
                <b-form-group
                  label-for="alphabet_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('rjscConfig.alphabet')}} <span class="text-danger">*</span>
                </template>
                <v-select
                  id="alphabet_id"
                  v-model="form.alphabets"
                  multiple
                  :reduce="op => op.value"
                  :options="alphabetList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </v-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col md="6" sm="12">
              <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.office_type_id"
                  :options="officeTypeList"
                  id="office_type_id"
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Officer Name" vid="user_id" rules="required|min_value:1">
                <b-form-group
                  label-for="user_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('priceMonitoring.officer_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.user_id"
                  :options="userList"
                  id="user_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{ userLoading ? 'Loading....' : $t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
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
import RestApi, { rjscServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { alphabetWiseRoleStore, alphabetWiseRoleUpdate, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      userLoading: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        alphabets: '',
        office_type_id: 0,
        office_id: 0,
        designation_id: 0,
        user_id: 0,
        name_en: '',
        name_bn: ''
      },
      officeList: [],
      userList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getListData()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    officeTypeList (id) {
      return this.$store.state.RjscService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === this.$rjscOrgId)
    },
    alphabetList () {
      return this.$store.state.commonObj.alphabetList
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
        this.designationList = this.getDesignationList(this.$rjscOrgId) // 15 = rjsc org_id
      } else {
        this.officeList = []
        this.designationList = []
      }
    },
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.findUser(newVal)
      } else {
        this.userList = []
      }
    },
    'form.user_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getUserName(newVal)
      }
    }
  },
  methods: {
    getDesignationList (orgId) {
      return this.$store.state.RjscService.commonObj.designationList.filter(item => item.org_id === orgId).map(obj => {
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
        result = await RestApi.putData(rjscServiceBaseUrl, `${alphabetWiseRoleUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, alphabetWiseRoleStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getListData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      tmpData.alphabets = JSON.parse(tmpData.alphabets)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getOfficeList (officeTypeId) {
      return this.$store.state.RjscService.commonObj.officeList.filter(office => office.office_type_id === officeTypeId)
    },
    findUser (designId) {
      const params = Object.assign({}, { designation_id: designId })
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
        if (response.success) {
          this.userList = response.data.map(obj => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn, name_en: obj.name, name_bn: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name, name_en: obj.name, name_bn: obj.name_bn }
            }
          })
        }
        this.userLoading = false
      })
    },
    getUserName (value) {
      const user = this.userList.find(user => user.value === value)
      this.form.name_bn = user.name_bn
      this.form.name_en = user.name_en
    }
  }
}
</script>
