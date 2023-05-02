<template>
  <div class="inner-section">
      <card>
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">{{ $t('globalTrans.search') }}</h4>
        </template>
        <template v-slot:searchHeaderAction>
          <router-link class="btn-add" to="assign-user-list"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }} {{ $t('globalTrans.list') }}</router-link>
        </template>
        <template v-slot:searchBody>
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(getUserRoledata)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
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
                              v-model="search.org_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
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
                            v-model="search.office_type_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
                    <ValidationProvider name="Office name" vid="office_id">
                        <b-form-group
                            label-for="office_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('organogram.office_name')}}
                        </template>
                        <b-form-select
                            plain
                            v-model="search.office_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
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
                        v-model="search.designation_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
                    <ValidationProvider name="Role" vid="role_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="role_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label :class="text-align-right" class="col-4">
                          {{ $t('userManagement.roles') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="search.role_id"
                          :options="roleListData"
                          id="roleList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{loadingSearch ? $t('globalTrans.loading') + '......' : $t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="2" xl="2" style="margin-top:28px">
                    <b-button style="font-size:12px" type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.search') }}</b-button>
                  </b-col>
                </b-row>
              </b-form>
            </ValidationObserver>
        </template>
      </card>
      <body-card>
        <template v-slot:headerTitle>
          <h4 class="card-title">{{ $t('userManagement.designation_wise_role') }}</h4>
        </template>
        <template v-slot:body>
          <b-row>
            <b-col xs="4" sm="4">
              <!-- <button
                class="btn-sm btn btn-primary btn-sm"
                variant="success"
                @click="checkAllChild()"
              >
                {{ $t('globalTrans.checkAll') }}
              </button> -->
              <b-form-checkbox v-model="isCheckAll" name="check-button" button button-variant="primary">
                <slot v-if="isCheckAll">
                  {{ $t('globalTrans.uncheckAll') }}
                </slot>
                <slot v-else>
                  {{ $t('globalTrans.checkAll') }}
                </slot>
              </b-form-checkbox>
            </b-col>
            <b-col xs="8" sm="8" style="text-align:right">
              <button
                class="btn-sm btn btn-primary btn-sm"
                variant="primary"
                v-on:click="SubmitData()"
              >
                <i class="fa fa-paper-plane"></i>
              </button>
            </b-col>
          </b-row>
          <br/>
          <b-row>
            <b-col xs="12" sm="12">
              <b-overlay :show="loadTable">
                <table class="table b-table tg table-striped table-hover table-bordered">
                  <thead class="thead">
                    <tr>
                      <th style="width:13%">{{$t('globalTrans.select')}}</th>
                      <th>{{$t('globalTrans.sl_no')}}</th>
                      <th>{{$t('globalTrans.name')}}</th>
                      <th>{{$t('globalTrans.mobile')}}</th>
                      <th>{{$t('globalTrans.email')}}</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(detail,index) in datas" :key="index">
                      <td style="text-align:center">
                        <b-form-checkbox
                          :id="'select-' + detail.id"
                          v-model="detail.select"
                          :name="'select-' + detail.id"
                          value=1
                          unchecked-value=0
                        >
                        </b-form-checkbox>
                      </td>
                      <td>{{$n(index+1)}}</td>
                      <td>
                        {{ ($i18n.locale === 'bn' ? detail.name_bn : detail.name) }}
                      </td>
                      <td>
                        {{ (($i18n.locale === 'bn') ? '০' : '0') + '' + ($n(detail.mobile, { useGrouping: false })) }}
                      </td>
                      <td>
                        {{ detail.email }}
                      </td>
                    </tr>
                  </tbody>
                  <template v-if="datas.length === 0">
                    <tr>
                      <th colspan="5" class="text-center text-danger" style="height: 150px">
                        <br/>
                        <br/>
                        {{$t('globalTrans.noDataFound')}}
                      </th>
                    </tr>
                  </template>
                </table>
              </b-overlay>
             </b-col>
          </b-row>
        </template>
      </body-card>
  </div>
</template>
<script>
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { desigRoleWiseUser, desigAssignUserRoleStore } from '../../api/routes'
import { mapGetters } from 'vuex'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      errors: [],
      isCheckAll: false,
      loadTable: false,
      search: {
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        role_id: 0,
        designation_id: 0
      },
      userRole: {
        user_ids: []
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      roleList: [],
      datas: [],
      loader: false,
      loadingSearch: false,
      is_hit: false
    }
  },
  created () {
    if (this.authUser.role_id === 0 && this.authUser.is_org_admin === 1) {
      this.search = Object.assign({}, this.search, {
        org_id: this.authUser.org_id
      })
    } else if (this.authUser.role_id === 0) {
      this.search = Object.assign({}, this.search, {
        org_id: this.authUser.office_detail.org_id,
        office_type_id: this.authUser.office_detail.office_type_id,
        office_id: this.authUser.office_detail.office_id,
        designation_id: this.authUser.office_detail.designation_id
      })
    }
  },
  computed: {
    roleListData: function () {
      const listObject = this.roleList
      const tmpList = listObject.map((obj, index) => {
        if (this.$i18n.locale === 'bn') {
            return { value: obj.id, text: obj.role_name_bn }
        } else {
            return { value: obj.id, text: obj.role_name }
        }
      })
      return tmpList
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    ...mapGetters({
      authUser: 'Auth/authUser'
    })
  },
  watch: {
    isCheckAll: function (newVal, oldVal) {
      this.checkAllChild(newVal)
    },
    'search.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
        this.designationList = this.getDesignationList(newVal)
        this.setOfficeList(newVal, this.search.office_type_id)
        this.setDesignationList(newVal)
      } else {
        this.officeTypeList = []
        this.designationList = []
      }
    },
    'search.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
        this.setOfficeList(this.search.org_id, newVal)
        this.getDesignationUser()
      } else {
        this.officeList = []
      }
    },
    'search.office_id': function (newVal) {
      this.getDesignationUser()
    },
    'search.designation_id': function (newVal, oldVal) {
      this.search.role_id = 0
      this.getDesignationUser()
    }
  },
  methods: {
    checkAllChild (newVal) {
      const datas = this.datas
      const exData = datas.map(item => {
        if (newVal) {
          item.select = 1
        } else {
          item.select = 0
        }
        return Object.assign({}, item)
      })
      this.datas = exData
    },
    getDesignationUser () {
      if (this.search.designation_id) {
       this.loadingSearch = true
        RestApi.getData(authServiceBaseUrl, 'user-management/role/desig-wise-role', this.search).then(response => {
          this.loadingSearch = false
          this.roleList = response.data
        }, error => {
          if (error) {
            this.loadingSearch = false
          }
        })
      }
    },
    getUserRoledata () {
      if (this.search.org_id && this.search.office_type_id && this.search.designation_id && this.search.role_id) {
        this.loadTable = true
        RestApi.getData(authServiceBaseUrl, desigRoleWiseUser, this.search).then(response => {
          if (response.success) {
            this.datas = response.data
            this.loadTable = false
          } else {
            this.datas = []
            this.loadTable = false
          }
        })
      }
    },
    setOfficeList (orgId, officeTypeId) {
      this.search.office_id = 0
      let officeList = []
      if (officeTypeId) {
         officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === officeTypeId)
         this.officeList = officeList
         return
      }
      officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === orgId)
      this.officeList = officeList
    },
    setDesignationList (orgId) {
      const desigList = this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === orgId)
      this.designationList = desigList
    },
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getOfficeList (id) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === id)
    },
    getDesignationList (id) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === id)
    },
    async confirmData () {
      let result = null
      this.loadTable = true
      result = await RestApi.postData(authServiceBaseUrl, desigAssignUserRoleStore + '/' + this.search.role_id, this.datas)
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: 'Data saved successfully',
          color: '#D6E09B'
        })
      }
      this.getUserRoledata()
    },
    async SubmitData () {
      this.$swal({
        title: this.$t('globalTrans.recommendentChangeMsg'),
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.confirmData()
        }
      })
    }
  }
}
</script>
<style scoped>
  .user-section .iq-card {
    border: solid 1px #e6e6e6
  }
  .role-section .iq-card {
    border: solid 1px #e6e6e6
  }
</style>
