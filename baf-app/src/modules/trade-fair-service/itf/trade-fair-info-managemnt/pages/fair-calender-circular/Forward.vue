<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="office_id"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.office')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                    plain
                    v-model="forward.office_id"
                    :options="officeList"
                    id="office_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Designation Id" vid="designation_id" rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="designation_id"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                    plain
                    v-model="forward.designation_id"
                    :options="designationList"
                    id="designation_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Employee Name" vid='reciver_id' rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="reciver_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('research_plan_management.employee_name')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                  plain
                  v-model="forward.reciver_id"
                  :options="userNameList"
                  id="reciver_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                      <b-form-select-option :value="0">{{ userLoading ? 'Loading..' : $t('globalTrans.select') }}</b-form-select-option>
                  </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Comment"  vid='comment_en' rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="comment_en"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{ $t('globalTrans.description')}} <span class="text-danger">*</span>
              </template>
                  <b-form-textarea
                  id="comment_en"
                  v-model="forward.comment_en"
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
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.forward') }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-5')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl, commonServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { fairCalenderCircularForward } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      errors: [],
      assignDesignationList: [],
      designationList: [],
      userList: [],
      userLoading: false,
      forward: {
        office_id: 0,
        designation_id: 0,
        sender_id: this.$store.state.Auth.authUser.user_id,
        reciver_id: 0,
        comment_en: ''
      }
    }
  },
  created () {
    this.getAssignDesignationList()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    officeList: function () {
      return this.$store.state.CommonService.commonObj.officeList.filter(office => office.status === 1 && office.org_id === 2)
    },
    userNameList: function () {
      return this.userList.filter(obj => obj.value !== this.$store.state.Auth.authUser.user_id).map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    }
  },
  watch: {
    'forward.office_id': function (newVal, oldVal) {
        this.getDesignationList(newVal)
    },
    'forward.designation_id': function (newVal, oldVal) {
        this.getUserList(newVal)
    },
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.localizeUserList(newVal)
        }
    }
  },
  methods: {
    async getAssignDesignationList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(commonServiceBaseUrl, '/organogram/assign-designations/get-all')
      if (result.success) {
          this.assignDesignationList = result.data
      } else {
          this.assignDesignationList = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getDesignationList (officeId) {
      const assignDesignationList = this.assignDesignationList.filter(item => item.office_id === parseInt(officeId))
      this.designationList = assignDesignationList.map(item => {
        const designation = this.$store.state.CommonService.commonObj.designationList.find(obj => obj.value === item.designation_id)
        return designation
      })
    },
    async getUserList (designationId = null) {
      this.userLoading = true
      await RestApi.getData(authServiceBaseUrl, `user/users-by-designation-id/${designationId}`).then(response => {
        const userList = response.filter(obj => obj.value !== this.$store.state.Auth.authUser.user_id).map((obj, index) => {
          return Object.assign({}, obj, {
            text: this.currentLocale === 'en' ? obj.text_en : obj.text_bn
          })
      })
        this.userList = userList
        return userList
      })
      this.userLoading = false
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairCalenderCircularForward}/${this.id}`, this.forward)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-5')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
