<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <!-- <b-col md="12 text-center">
          <span class="badge badge-primary card-title"><h5>{{ $t('meetingManagement.meeting_notification') }}</h5></span>
        </b-col> -->
        <b-row v-for="(detail, index) in form.notifications" :key="index" mt-2>
          <b-col xs="8" sm="8" md="5" lg="5" xl="5">
              <ValidationProvider name="Designation" vid="designation_id" rules="required" v-slot="{ errors }">
                  <b-form-group
                  label-for="designation_id">
                  <template v-slot:label>
                      {{ $t('globalTrans.designation')}} <span class="text-danger">*</span>
                  </template>

                  <b-form-select
                      plain
                      v-model="detail.designation_id"
                      :options="designationList"
                      @change="getUserList(detail)"
                      id="designation_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0> {{ $t('globalTrans.select') }} </b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="8" sm="8" md="5" lg="5" xl="5">
              <ValidationProvider name="Employee" vid="employee_user_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                  label-for="employee_user_id">
                  <template v-slot:label>
                      {{ $t('stakeholder.employee_name')}} <span class="text-danger">*</span>
                  </template>

                  <b-form-select
                      plain
                      v-model="detail.employee_user_id"
                      :options="detail.userList"
                      id="employee_user_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0> {{ usersLoading ? "Loading..." :  $t('globalTrans.select') }} </b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xl="2" lg="2" sm="4" class="mt-4">
              <b-button v-show="index == form.notifications.length-1" variant="iq-bg-success" size="sm" @click="addUser()"><i class="ri-add-line m-0"></i></b-button>
              <b-button v-show="index || ( !index && form.notifications.length > 1)" variant=" iq-bg-danger" size="sm" @click="remove(index)"><i class="ri-delete-bin-line m-0"></i></b-button>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-employee')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
          <!-- {{ form.notifications }} -->
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { createMeetingNotificationStoreApi, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      usersLoading: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.save') : this.$t('globalTrans.save'),
      errors: [],
      locationIndex: '',
      form: {
        edit_id: this.id,
        notifications: [
          {
            designation_id: 0,
            employee_user_id: 0,
            userList: []
          }
        ]
      },
      userList: []
    }
  },
  created () {
    // if (this.id) {
    //   const tmp = this.getMeetingData()
    //   this.form = tmp
    //   this.form.edit_id = this.id
    // }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    designationList () {
      return this.$store.state.CommonService.commonObj.componentDesignationList
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, createMeetingNotificationStoreApi, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
         this.$bvModal.hide('modal-employee')
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
    getMeetingData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async getUserList (detail) {
      this.usersLoading = true
      const designationId = detail.designation_id
      const params = Object.assign({}, { designation_id: designationId })
      const userIDs = []
      this.form.notifications.forEach(item => {
        userIDs.push(item.employee_user_id)
      })
      await RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
        if (response.success) {
          const userList = response.data.filter(obj => {
            if (userIDs.indexOf(obj.id) === -1) {
              return obj
            }
          }).map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.$set(detail, 'userList', userList)
          this.usersLoading = false
        }
      })
    },
    addUser () {
      const tmp = {
        designation_id: 0,
        employee_user_id: 0,
        userList: []
      }
      this.form.notifications.push(tmp)
      },
    remove (key) {
      this.form.notifications.splice(key, 1)
    }
  }
}
</script>
