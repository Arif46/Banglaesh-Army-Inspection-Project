<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
                <b-overlay :show="loading">
                    <b-row>
                        <b-col xl="12" lg="12" sm="12">
                            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                                <b-form @submit.prevent="handleSubmit(register)" @reset.prevent="reset">
                                    <b-row>
                                      <b-col lg="6" sm="12">
                                        <ValidationProvider name="Office Id" vid="office_id" rules="required|min_value:1">
                                          <b-form-group
                                              class="row"
                                              label-cols-sm="12"
                                              label-for="office_id"
                                              slot-scope="{ valid, errors }"
                                              >
                                              <template v-slot:label>
                                              {{ $t('globalTrans.office')}}  <span class="text-danger">*</span>
                                              </template>
                                              <b-form-select
                                              plain
                                              v-model="forward.office_id"
                                              :options="officeList"
                                              id="office_id"
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
                                      <b-col lg="6" sm="12">
                                        <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
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
                                                <b-form-select-option :value="0">{{ designationLoading ? $t('globalTrans.loading') : $t('globalTrans.select') }}</b-form-select-option>
                                              </template>
                                            </b-form-select>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                      </b-col>
                                      <b-col lg="6" sm="12">
                                          <ValidationProvider name="Employee Name" vid='receiver_id' rules="required|min_value:1">
                                              <b-form-group
                                                  class="row"
                                                  label-cols-sm="12"
                                                  label-for="receiver_id"
                                                  slot-scope="{ valid, errors }"
                                                  >
                                                  <template v-slot:label>
                                                      {{$t('research_plan_management.employee_name')}}<span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                  plain
                                                  v-model="forward.receiver_id"
                                                  :options="userList"
                                                  id="receiver_id"
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
                                      <b-col lg="6" sm="6">
                                        <ValidationProvider name="Remarks" vid="remarks" rules="">
                                          <b-form-group
                                              class="row"
                                              label-cols-sm="12"
                                              label-for="remarks"
                                              slot-scope="{ valid, errors }"
                                          >
                                            <template v-slot:label>
                                              {{ $t('globalTrans.comments')}}
                                            </template>
                                            <b-form-textarea
                                                id="reason"
                                                v-model="forward.remarks"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-textarea>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                      </b-col>
                                    </b-row>
                                    <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col text-right">
                                        <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                        &nbsp;
                                        <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-5')">{{ $t('globalTrans.cancel') }}</b-button>
                                    </div>
                                    </div>
                                </b-form>
                            </ValidationObserver>
                        </b-col>
                    </b-row>
                </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl, commonServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { applicationForward } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['id', 'service_id'],
    created () {
      this.officeList = this.getParentOfficeList()
      // this.officeList = this.getParentOfficeList(11)
    },
    watch: {
      'forward.office_id': function (newVal, oldVal) {
        this.getDesignationList()
      },
      'forward.designation_id': function (newVal, oldVal) {
        this.getUserList(newVal)
      },
      'forward.receiver_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          if (newVal > 0) {
            const userList = this.userList.find(item => item.value === newVal)
            this.forward.receiver_name = userList.text_en
            this.forward.receiver_name_bn = userList.text_bn
          }
        }
      },
      currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.localizeUserList(newVal)
        }
      }
    },
    computed: {
        loading () {
          return this.$store.state.commonObj.loading
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.forward') : this.$t('globalTrans.save'),
            forward: {
                designation_id: 0,
                sender_id: this.$store.state.Auth.authUser.user_id,
                receiver_id: 0,
                office_id: 0,
                receiver_name: '',
                receiver_name_bn: '',
                remarks: ''
            },
            loader: false,
            designationList: [],
            officeTypeList: [],
            userList: [],
            userLoading: false,
            designationLoading: false,
            officeList: []
        }
    },
    methods: {
      getParentOfficeList () {
        const officeType = this.$store.state.CommonService.commonObj.officeTypeList.find(item => item.text_en.toLowerCase() === 'btb organization')
        const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
        if (officeType !== undefined) {
            return officeList.filter(office => office.office_type_id === officeType.value)
        }
        return officeList
      },
      getOfficeTypeList (orgId = null) {
        const officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1)
        if (orgId) {
          return officeTypeList.filter(office => office.org_id === orgId).map(obj => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.value, text: obj.text_bn }
            } else {
                return { value: obj.value, text: obj.text }
            }
          })
        }
        return officeTypeList
      },
      async register () {
          this.loader = true
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadinState = { loading: false, listReload: true }
          result = await RestApi.putData(teaGardenServiceBaseUrl, `${applicationForward}/${this.id}`, this.forward)
          this.$store.dispatch('mutateCommonProperties', loadinState)
          if (result.success) {
               this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
              if (result.notification) {
                this.$socket.emit('send-notification', result.notification)
              }
              this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
              })
              this.$bvModal.hide('modal-5')
          } else {
              this.$refs.form.setErrors(result.errors)
          }
          this.loader = false
      },
      async getDesignationList () {
        this.designationLoading = true
        const params = {
          component_id: 5,
          office_id: this.forward.office_id,
          org_id: 5
        }
        const result = await RestApi.getData(commonServiceBaseUrl, '/organogram/designation/component-assign-designation-list', params)
        if (result.success) {
          this.designationList = result.data.filter(item => item.status === 1).map(item => {
            const customItem = {
              text: this.currentLocale === 'en' ? item.text_en : item.text_bn
            }
            return Object.assign({}, item, customItem)
          })
        }
        this.designationLoading = false
      },
      async getUserList (designationId = null) {
          this.userLoading = true
          await RestApi.getData(authServiceBaseUrl, `user/users-by-designation-id/${designationId}`).then(response => {
            const userList = response.map((obj, index) => {
                const assignUser = this.$store.state.TeaGardenService.commonObj.masterServiceAssign.find((userItem) => userItem.user_id === obj.value)
                if (assignUser) {
                  const serviceArr = assignUser.service_id.split(',')
                  if (serviceArr.includes(this.service_id.toString()) && (obj.value !== this.$store.state.Auth.authUser.user_id)) {
                    return Object.assign({}, obj, {
                    text: this.currentLocale === 'en' ? obj.text_en : obj.text_bn
                  })
                  }
                }
              })
              this.userList = userList.filter(item => item !== undefined)
              return userList
          })
          this.userLoading = false
      },
      localizeUserList (locale) {
          const tmp = this.userList.map(item => {
              return Object.assign({}, item, {
                  text: locale === 'en' ? item.text_en : item.text_bn
              })
          })
          this.userList = tmp
      }
    }
}
</script>
