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
                                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
                                    <b-row>
                                      <b-col lg="6" sm="12">
                                        <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                                          <b-form-group
                                              class="row"
                                              label-cols-sm="12"
                                              label-for="service_id"
                                              slot-scope="{ valid, errors }"
                                              >
                                              <template v-slot:label>
                                              {{ $t('teaGardenConfig.service_name')}}  <span class="text-danger">*</span>
                                              </template>
                                              <b-form-select
                                              plain
                                              @change="serviceOnChange"
                                              v-model="data.service_id"
                                              :options="serviceList"
                                              id="service_id"
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
                                              v-model="data.office_id"
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
                                                v-model="data.designation_id"
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
                                          <ValidationProvider name="Employee Name" vid='user_id' rules="required|min_value:1">
                                              <b-form-group
                                                  class="row"
                                                  label-cols-sm="12"
                                                  label-for="user_id"
                                                  slot-scope="{ valid, errors }"
                                                  >
                                                  <template v-slot:label>
                                                      {{$t('research_plan_management.employee_name')}}<span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                  plain
                                                  v-model="data.user_id"
                                                  :options="userList"
                                                  id="user_id"
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
                                      <b-col lg="6" sm="12">
                                        <ValidationProvider name="Email" vid="email">
                                          <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="email">
                                            <template v-slot:label>
                                              {{ $t('teaGardenConfig.email') }}
                                            </template>
                                            <b-form-input
                                              id="email"
                                              v-model="data.email"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                      </b-col>
                                      <b-col lg="6" sm="12">
                                        <ValidationProvider name="Mobile" vid="mobile">
                                          <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="mobile">
                                            <template v-slot:label>
                                              {{ $t('teaGardenConfig.mobile') }}
                                            </template>
                                            <b-form-input
                                              id="mobile"
                                              v-model="data.mobile"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                      </b-col>
                                      <b-col lg="3" sm="12">
                                          <ValidationProvider name="Show Name" vid='show_name' rules="required|min_value:0">
                                              <b-form-group
                                                label-cols-sm="12"
                                                label-for="show_name"
                                                >
                                                <b-form-checkbox
                                                  id="show_name"
                                                  v-model="data.show_name"
                                                  name="checkbox-1"
                                                  value="1"
                                                  unchecked-value="0"
                                                > {{$t('teaGardenConfig.show_name')}}
                                              </b-form-checkbox>
                                              </b-form-group>
                                          </ValidationProvider>
                                      </b-col>
                                      <b-col lg="3" sm="12">
                                          <ValidationProvider name="Show Signature" vid='show_signature' rules="required|min_value:0">
                                              <b-form-group
                                                label-cols-sm="12"
                                                label-for="show_signature"
                                                >
                                                <b-form-checkbox
                                                  id="show_signature"
                                                  v-model="data.show_signature"
                                                  name="checkbox-1"
                                                  value="1"
                                                  unchecked-value="0"
                                                > {{$t('teaGardenConfig.show_signature')}}
                                              </b-form-checkbox>
                                              </b-form-group>
                                          </ValidationProvider>
                                      </b-col>
                                    </b-row>
                                    <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col text-right">
                                        <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                        &nbsp;
                                        <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
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
import { documentSignatoryStore, documentSignatoryUpdate } from '../../api/routes'

export default {
    name: 'Form',
    props: ['id'],
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            data: {
                service_id: 0,
                designation_id: 0,
                user_id: 0,
                office_id: 0,
                show_name: 1,
                show_signature: 1,
                name_en: '',
                name_bn: '',
                designation_en: '',
                designation_bn: '',
                office_en: '',
                office_bn: '',
                signature: '',
                mobile: '',
                email: ''
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
    created () {
      this.officeList = this.getParentOfficeList()
      if (this.id) {
        const tmp = this.getFormData()
        this.data = tmp
      }
    },
    watch: {
      'data.office_id': function (newVal, oldVal) {
        this.getDesignationList()
        this.getOfficeName(newVal)
      },
      'data.designation_id': function (newVal, oldVal) {
        this.getUserList(newVal)
        this.getDesignationName(newVal)
      },
      'data.user_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          if (newVal > 0) {
            const userList = this.userList.find(item => item.value === newVal)
            if (userList) {
              this.data.name_en = userList.text_en
              this.data.name_bn = userList.text_bn
              this.data.email = userList.email
              this.data.mobile = userList.mobile
              this.data.signature = userList.signature
            }
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
        },
        serviceList () {
          return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
        }
    },
    methods: {
      getParentOfficeList () {
        const officeType = this.$store.state.CommonService.commonObj.officeTypeList.find(item => (item.org_id === 5) && (item.text_en.toLowerCase() === 'head office'))
        const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
        if (officeType !== undefined) {
          return officeList.filter(office => office.office_type_id === officeType.value)
        }
        return officeList
      },
      async saveUpdate () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }
        if (this.id) {
            result = await RestApi.putData(teaGardenServiceBaseUrl, `${documentSignatoryUpdate}/${this.id}`, this.data)
        } else {
            result = await RestApi.postData(teaGardenServiceBaseUrl, documentSignatoryStore, this.data)
        }

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })

          this.$bvModal.hide('modal-form')
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      },
      async getDesignationList () {
        this.designationLoading = true
        const params = {
          component_id: 5,
          office_id: this.data.office_id,
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
                  if (serviceArr.includes(this.data.service_id.toString())) {
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
      serviceOnChange (e) {
         this.data.designation_id = 0
         this.data.user_id = 0
      },
      getDesignationName (id) {
        const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
        this.data.designation_en = obj?.text_en
        this.data.designation_bn = obj?.text_bn
        return true
      },
      getOfficeName (id) {
        const obj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(id))
        this.data.office_en = obj?.text_en
        this.data.office_bn = obj?.text_bn
        return true
      },
      localizeUserList (locale) {
          const tmp = this.userList.map(item => {
              return Object.assign({}, item, {
                  text: locale === 'en' ? item.text_en : item.text_bn
              })
          })
          this.userList = tmp
      },
      getFormData () {
        const tmpData = this.$store.state.list.find(item => item.id === this.id)
        return JSON.parse(JSON.stringify(tmpData))
      }
    }
}
</script>
