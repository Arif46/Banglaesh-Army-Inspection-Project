<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <!-- committees  -->
      <div class="row">
          <div class="col-md-12">
            <div class="row" v-for="(committee, index) in committees" :key="index">
              <div class="col-md-3">
               <ValidationProvider name="Role" vid="role_id" rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="3"
                        :label="$t('userManagement.role')"
                        label-for="role_id"
                        slot-scope="{ valid, errors }"
                    >
                        <b-form-select
                        plain
                        :id="committee.role_id.toString()"
                        v-model="committee.role_id"
                        :options="committee.roleList"
                        @change="getUserList(committee)"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
              </div>
              <div class="col-md-3">
                 <ValidationProvider name="User" vid="user_id" rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="3"
                        :label="$t('userManagement.user')"
                        label-for="user_id"
                        slot-scope="{ valid, errors }"
                    >
                    <b-form-select
                        plain
                        :id="committee.user_id.toString()"
                        v-model="committee.user_id"
                        :options="committee.userList"
                        @change="getDesignationList(committee)"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                        <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                 </ValidationProvider>
              </div>
              <div class="col-md-4">
               <ValidationProvider name="Designation" vid="designation_id" rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label="$t('globalTrans.designation')"
                        label-for="designation_id"
                        slot-scope="{ valid, errors }"
                        >
                        <b-form-select
                        plain
                        :id="committee.designation_id.toString()"
                        v-model="committee.designation_id"
                        :options="committee.designationList"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
              </div>
              <div class="col-md-1">
                <div class="d-grid w-100 h-100">
                  <!-- <b-button v-if="index !== 0" variant=" iq-bg-danger" size="sm" @click.prevent="removeCommittee(index)"><i class="ri-delete-bin-line m-0"></i></b-button> -->
                  <!-- <b-button v-if="index === 0" variant=" iq-bg-success" size="sm" @click="addNew"><i class="ri-add-line m-0"></i></b-button> -->
                  <b-button type="button" v-if="index === 0" @click="addCommittee" class="m-auto" variant="primary"><i class="ri-add-line p-0 m-0"></i></b-button>
                  <b-button type="button" v-if="index !== 0" @click="removeCommittee(index)" class="m-auto" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                </div>
              </div>
            </div>
          </div>
      </div>
      <b-row class="text-right">
        <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-6')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { serviceStoreApi, serviceUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      baseUrl: commonServiceBaseUrl,
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      service: {
        component_id: 0,
                complain_id: this.id,
                role_id: 0,
                user_id: 0,
                designation_id: 0,
                userList: [],
                roleList: [],
                designationList: []
      },
      committees: [
        {
            role_id: 0,
            user_id: 0,
            designation_id: 0
        }
      ],
      api_manager: [],
      operating_procedure: [],
      orgList: [],
      exOrgList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getServiceData()
      this.service = tmp
      this.service.api_manager_file = tmp.api_manager
      this.service.api_manager = null
      if (tmp.committees.length > 0) {
        this.committees = tmp.committees
      }
      const customerType = tmp.customers.map(item => {
        return item.id
      })
      this.service.customer_type_id = customerType
      if (this.service.service_type_id === 1) {
        const orgList = tmp.org_list.map(item => {
          return item.id
        })
        this.service.org_id = orgList
      }
    }
  },
  computed: {
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.filter(item => item.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'service.service_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
          this.service.service_url = ''
          this.service.component_id = 0
          this.service.api_manager = ''
        }
      }
    },
    'service.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
        }
        this.orgList = this.getOrgList(newVal)
      }
    },
    'service.ministry_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.ex_org_id = 0
        }
        this.exOrgList = this.getExOrgList(newVal)
      }
    }
  },
  methods: {
    addCommittee () {
      const tmpFee = {
        role_id: 0,
        user_id: 0,
        designation_id: 0
      }
      this.committees.push(tmpFee)
    },
    removeCommittee (index) {
      this.committees.splice(index, 1)
    },
    getRoleList () {
        const user = this.$store.state.Auth.authUser
        RestApi.getData(authServiceBaseUrl, 'role/role-list-select/' + user.org_id)
        .then(response => {
            const roleObject = response.map((obj, index) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.id, text: obj.role_name_bn }
                } else {
                    return { value: obj.id, text: obj.role_name }
                }
            })
            this.committees.map(item => {
                item.roleList = roleObject
                item.userList = this.getUserList(item)
                item.designationList = this.getDesignationList(item)
                return Object.assign({}, item, item.roleList, item.userList, item.designationList)
            })
        })
    },
    getExOrgList (Id) {
      return this.$store.state.CommonService.commonObj.exOrgList.filter(item => item.ministry_id === parseInt(Id) && item.status === 1)
    },
    getOrgList (compId) {
      const orgComponentList = this.$store.state.CommonService.commonObj.orgComponentList.filter(comp => comp.component_id === compId)
      return orgComponentList.map(item => {
        if (typeof item !== 'undefined') {
          const org = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === item.org_id)
          return (this.$i18n.locale === 'bn') ? Object.assign({}, org, { text: org.abbreviation_bn }) : Object.assign({}, org, { text: org.abbreviation })
        }
      })
    },
    onFileChangePro (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.process = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.process = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.service.committees = this.committees
      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${serviceUpdateApi}/${this.id}`, this.service)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, serviceStoreApi, this.service)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('mutateCommonProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-6')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getServiceData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
