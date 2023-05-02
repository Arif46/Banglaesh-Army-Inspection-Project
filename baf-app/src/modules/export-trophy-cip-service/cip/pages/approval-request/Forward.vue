<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
            <b-row>
                <b-col lg="6" md="6" sm="6">
                    <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                        <b-form-group
                        label-for="office_type_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('sideBar.office_type') }} <span class="text-danger">*</span>
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
                <b-col lg="6" md="6" sm="6">
                    <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
                        <b-form-group
                        label-for="office_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('globalTrans.office') }} <span class="text-danger">*</span>
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
                <b-col lg="6" md="6" sm="6">
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
                <b-col lg="6" md="6" sm="6">
                    <ValidationProvider name="Officer" vid="receiver_id" rules="required|min_value:1">
                        <b-form-group
                        label-for="receiver_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('sideBar.officer') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="form.receiver_id"
                            :options="officerList"
                            id="receiver_id"
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
                <b-col lg="12" md="12" sm="12">
                    <ValidationProvider name="Note" vid="note" rules="required">
                        <b-form-group
                            label-for="note"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{$t('globalTrans.note')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-textarea
                                id="note"
                                v-model="form.note"
                                :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-textarea>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
            </b-row>
            <b-row class="text-right">
                <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm" id="forwardSubmit">{{ $t('globalTrans.submit') }}</b-button>
                    <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-forward')" id="forwardCancel">{{ $t('globalTrans.cancel') }}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { approvalReqForwardApi, designationWiseUser } from '../../api/routes'

export default {
  data () {
    return {
      loading: false,
      userLoading: false,
      form: {
        office_type_id: 0,
        office_id: 0,
        designation_id: 0,
        sender_id: this.$store.state.Auth.authUser.user_id,
        receiver_id: 0,
        note: ''
      },
      officeList: [],
      designationList: [],
      officerList: []
    }
  },
  computed: {
    officeTypeList () {
      return this.$store.state.CommonService.commonObj.officeTypeList
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
      }
    },
    'form.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.designationList = this.getDesginationList(newVal)
      }
    },
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getOfficerList(newVal)
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.localizeUserList(newVal)
      }
    }
  },
  methods: {
    getOfficerList (designationId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, `${designationWiseUser}/${designationId}`).then(data => {
        const userList = data
        const tmp = userList.map(item => {
          return Object.assign({ value: item.value, text: this.currentLocale === 'bn' ? item.text_bn : item.text_en })
        })
        this.userLoading = false
        this.officerList = tmp
      })
    },
    async submit () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, approvalReqForwardApi, this.form)
      this.loading = false

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.update_msg'),
          color: '#D6E09B'
        })
        // this.$store.dispatch('ExportTrophyCipService/setPendingForward', true)
        this.$bvModal.hide('modal-forward')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getOfficeList (officeTypeId) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.office_type_id === officeTypeId && item.org_id === 1)
    },
    getDesginationList (officeId) {
      return this.$store.state.CommonService.commonObj.assignDesignationList.filter(el => el.office_id === officeId).map(item => {
        return Object.assign({ value: item.value, text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en })
      })
    },
    localizeUserList (locale) {
      const tmp = this.officerList.map(item => {
        return Object.assign({}, item, {
          text: locale === 'en' ? item.text_en : item.text_bn
        })
      })
      this.officerList = tmp
    }
  }
}
</script>
