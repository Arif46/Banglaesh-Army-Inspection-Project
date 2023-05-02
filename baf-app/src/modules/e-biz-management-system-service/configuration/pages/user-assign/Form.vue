    <template v-slot:searchBody>
      <b-tabs small card>
        <!--    Accused Person Information Tab     -->
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(userAssignStore)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.org_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.org_id"
                          :options="OrgList"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="office_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('userManagement.office')}} <span class="text-danger">*</span>
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="designation_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.designation')}} <span class="text-danger">*</span>
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="officer Name" vid="user_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="user_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.fine_collector')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.user_id"
                          :options="userList"
                          id="user_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{ userLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="officer Name" vid="council_info_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="council_info_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('eBizConfig.council_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="form.council_info_id"
                          :options="councilInfo"
                          id="council_info_id"
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
                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm" @click="form.status = 2">{{ $t('globalTrans.submit') }}</b-button>
                    <b-button variant="success" class="btn-sm btn btn-danger" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        <!--    /Fine Details Tab     -->
      </b-tabs>
    </template>
<script>
import RestApi, { authServiceBaseUrl, eBizServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import {
  eBizUserAssignStore, userListByDesignWise
} from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      circularLoading: false,
      userLoading: false,
      loading: false,
      form: {
          org_id: 0,
          office_id: 0,
          designation_id: 0,
          council_info_id: 0,
          user_id: 0
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      userList: [],
      activeRoleId: this.$store.state.Auth.activeRoleId
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditEntry()
      this.form = tmp
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1 && this.$store.state.Auth.authUser.org_admin === 1) {
      this.form = Object.assign({}, this.form, {
        org_id: this.loggedUserPrivilege.org_id,
        office_id: this.loggedUserPrivilege.office_id,
        designation_id: this.loggedUserPrivilege.designation_id,
        user_id: this.loggedUserPrivilege.user_id
      })
    }
    const loadingState = { loading: false, listReload: false }
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (this.$route.params.id) {
      this.saveUpdate()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    OrgList: function () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1 && item.value === 8)
    },
    councilInfo: function () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },

  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.officeTypeList = this.getOfficeTypeList(newVal)
        this.officeList = this.getOfficeList(newVal)
        this.designationList = this.getDesingationList(newVal)
      } else {
        // this.officeTypeList = []
        this.officeList = []
        this.designationList = []
      }
    },
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    }
  },
  methods: {
    async userAssignStore () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(eBizServiceBaseUrl, eBizUserAssignStore, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.form.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === parseInt(OfficeTypeID))
    },
    getDesingationList (officeId) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === parseInt(officeId))
    },
    getUserList (degId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          const userData = response.data.filter(user => user.designation_id === degId)
          this.userList = userData.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.userLoading = false
        }
      })
    },
    getEditEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
