<template>
  <div class="inner-section market-assign-form-wrapper">
    <card>
      <!-- formData section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.service_assign') }}</h4>
      </template>
      <template v-slot:searchHeaderAction>
        <router-link class="btn-add" to="/tea-garden-service/configuration/service-assign"><i class="ri-arrow-left-line"></i> {{  $t('teaGardenConfig.service_assign') }} {{  $t('globalTrans.list') }}</router-link>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(createData)" @reset.prevent="reset" autocomplete="off">
              <b-row>
                <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                  <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('globalTrans.org_name')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.org_id"
                        :options="orgList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        @input="userPrivilegeData()"
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
                <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                  <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="office_type_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('userManagement.office_type')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.office_type_id"
                        :options="officeTypeList"
                        id="office_type_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        @input="userPrivilegeData()"
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
                <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
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
                      v-model="formData.office_id"
                      :options="officeList"
                      id="office_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      @input="userPrivilegeData()"
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
              <b-overlay :show="loadingdata">
                <body-card>
                  <template v-slot:headerTitle>
                    <h4 class="card-title">{{ $t('teaGardenConfig.service_assign') }} {{ $t('globalTrans.entry')}} </h4>
                  </template>
                  <template v-slot:body>
                    <br/>
                    <div class="table-responsive" style="min-height: 150px;margin-bottom: 0">
                      <table class="table" border="1">
                        <thead class="thead thead-light">
                          <tr>
                            <th style="width: 10%" class="text-center">{{$t('globalTrans.sl_no')}}</th>
                            <th style="width: 10%">{{$t('globalTrans.name')}}</th>
                            <th style="width: 15%">{{$t('globalTrans.mobile')}}</th>
                            <th style="width: 15%">{{$t('globalTrans.designation')}}</th>
                            <th style="width: 30%;text-align:left">{{$t('teaGardenConfig.service_name')}}</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(detail,index) in formData.details" :key="index">
                            <td class="text-center">{{$n(index+1)}}</td>
                            <td>{{ ($i18n.locale === 'bn' ? detail.text_bn : detail.text_en) }}</td>
                            <td>
                              {{(($i18n.locale === 'bn') ? '০' : '0') + '' + ($n(detail.mobile, { useGrouping: false }))}}
                            </td>
                            <td>{{ ($i18n.locale === 'bn' ? detail.designation_name_bn : detail.designation_name) }}</td>
                            <td>
                              <keep-alive>
                                <ValidationProvider :vid="'detail' + index" name="Service" rules="required">
                                  <div class="service_id" slot-scope="{ valid, errors }">
                                    <v-select
                                      :id="'service_id' + index"
                                      v-model="detail.service_id"
                                      :reduce="op => op.value"
                                      multiple
                                      :options="detail.serviceList"
                                      label="text"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :class="errors[0] ? 'is-invalid' : ''"
                                    >
                                    </v-select>
                                    <div class="error text-left d-block invalid-feedback" role="alert">
                                      {{ errors[0] }}
                                    </div>
                                  </div>
                                </ValidationProvider>
                              </keep-alive>
                            </td>
                          </tr>
                        </tbody>
                        <template v-if="formData.details.length === 0">
                          <tr>
                            <th colspan="10" class="text-center text-danger">
                              <br/>
                              <br/>
                              {{$t('globalTrans.noDataFound')}}
                              <br/>
                              <br/>
                              <br/>
                            </th>
                          </tr>
                        </template>
                      </table>
                    </div>
                  </template>
                </body-card>
              </b-overlay>
              <b-row class="text-right">
                <b-col>
                  <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                </b-col>
              </b-row>
            </b-form>
          </b-overlay>
        </ValidationObserver>
      </template>
   </card>
  </div>
</template>
<style>
.is-invalid > div{
  border-color: #dc3545;
  padding-right: calc(1.5em + 0.75rem) !important;
  background-repeat: no-repeat;
  background-position: right calc(0.375em + 0.1875rem) center;
  background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
}
</style>
<script>
import RestApi, { teaGardenServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { masterServiceAssignStore, AllUserList, masterServiceAssignLst } from '../../api/routes'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
        valid: null,
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        loading: false,
        formData: {
            org_id: 0,
            office_type_id: 0,
            office_id: 0,
            details: []
        },
        officeTypeList: [],
        officeList: [],
        userList: [],
        districtList: [],
        userLoading: false,
        loadingdata: false,
        detailsErrors: []
    }
  },
  created () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.formData = Object.assign({}, this.formData, {
        org_id: this.loggedUserPrivilege.org_id,
        office_type_id: this.loggedUserPrivilege.office_type_id,
        office_id: this.loggedUserPrivilege.office_id
      })
      this.userPrivilegeData()
    }
  },
  mounted () {
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.TeaGardenService.commonObj.loggedUserPrivilege
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    }
  },
  watch: {
    'formData.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
        if (oldVal) {
          this.formData.office_type_id = 0
        }
      } else {
        this.officeTypeList = []
      }
    },
    'formData.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.formData.office_id = 0
        this.officeList = this.getOfficeList(newVal)
        if (oldVal) {
           this.formData.office_id = 0
        }
      } else {
        this.officeList = []
      }
    }
  },
  methods: {
    async userPrivilegeData () {
      if (this.formData.org_id && this.formData.office_type_id && this.formData.office_id) {
        this.loadingdata = true
        const searchData = {
          office_type_id: this.formData.office_type_id,
          office_id: this.formData.office_id,
          org_id: this.formData.org_id
        }
        const result = await RestApi.getData(teaGardenServiceBaseUrl, masterServiceAssignLst, searchData)
          if (result.success) {
              this.userList = result.data
          } else {
              this.userList = []
          }
        this.loadData()
      }
    },
    async loadData () {
      if (this.formData.org_id && this.formData.office_type_id && this.formData.office_id) {
        const searchData = {
          office_type_id: this.formData.office_type_id,
          office_id: this.formData.office_id,
          org_id: this.formData.org_id,
          user_type: 1
        }
        const result = await RestApi.getData(authServiceBaseUrl, AllUserList, searchData)
        if (result.success) {
          const datas = result.data.map(item => {
            const desigObj = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === parseInt(item.designation_id))
            const isThere = this.userList.find(userList => userList.user_id === parseInt(item.id))
            const desigData = {
              user_id: item.id,
              designation_id: item.designation_id,
              serviceList: this.$store.state.TeaGardenService.commonObj.masterServiceList,
              service_id: typeof isThere !== 'undefined' ? isThere.service_id : []
            }
            if (typeof desigObj !== 'undefined') {
              desigData.designation_name = desigObj.text_en
              desigData.designation_name_bn = desigObj.text_bn
            } else {
              desigData.designation_name = ''
              desigData.designation_name_bn = ''
            }
            return Object.assign({}, item, desigData)
          })
          this.formData.details = datas
        } else {
          this.formData.details = []
        }
        this.loadingdata = false
      }
    },
    async createData () {
      this.loading = true
      let result = null
      result = await RestApi.postData(teaGardenServiceBaseUrl, masterServiceAssignStore, this.formData)
      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push({ path: '/tea-garden-service/configuration/service-assign' })
      } else {
        this.detailsErrors = result.errors
      }
      this.loading = false
    },
    getOfficeTypeList (orgId) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === OfficeTypeID)
    }
  }
}
</script>

<style scoped>
  .main {
    padding: 45px 50px;
  }
  .flex {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }
</style>
