<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
                  v-model="form.org_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Formation Date" vid="formation_date" rules="required">
              <b-form-group
                  label-for="formation_date"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.formation_date')}} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker
                  b-form-datepicker
                  id="formation_date"
                  v-model="form.formation_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Committee Name (En)" vid="committee_name" rules="required">
              <b-form-group
                  label-for="committee_name"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.committee_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="committee_name"
                  v-model="form.committee_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Committee Name (Bn)" vid="committee_name_bn" rules="required">
              <b-form-group
                  label-for="committee_name_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.committee_name_bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="committee_name_bn"
                  v-model="form.committee_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Purpose (En)" vid="purpose" rules="required">
                <b-form-group
                  label-for="purpose"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.purpose')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  rows="3"
                  id="purpose"
                  v-model="form.purpose"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Purpose (Bn)" vid="purpose_bn" rules="required">
                <b-form-group
                  label-for="purpose_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.purpose_bn')}} <span class="text-danger">*</span>
                </template>
               <b-form-textarea
                  rows="3"
                  id="purpose_bn"
                  v-model="form.purpose_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
         <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Duration" vid="duration" rules="required">
                <b-form-group
                  label-for="duration"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.committee_duration_with_day')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="duration"
                  v-model="form.duration"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Document Name" vid="document_name" rules="required">
                <b-form-group
                  label-for="document_name"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.document_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="document_name"
                  v-model="form.document_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment" rules="">
                <b-form-group
                  label-for="attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.attachment')}} <span class="text-danger">*</span>
                </template>
                 <b-form-file
                    id="attachment"
                    v-model="form.attachment"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here..."
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
         <b-row v-for="(detail, index) in form.committee" :key="index" mt-2>
              <b-col xs="8" sm="8" md="5" lg="5" xl="5">
                  <ValidationProvider name="User" vid="user_id" rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="user_id">
                      <template v-slot:label>
                          {{ $t('committee.choose_user')}} <span class="text-danger">*</span>
                      </template>

                     <b-form-select
                          plain
                          v-model="detail.user_id"
                          :options="userList"
                          id="user_id"
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
              <b-col xl="2" lg="2" sm="4" class="mt-4">
                  <b-button v-show="index == form.committee.length-1" variant="iq-bg-success" size="sm" @click="addUser()"><i class="ri-add-line m-0"></i></b-button>
                  <b-button v-show="index || ( !index && form.committee.length > 1)" variant=" iq-bg-danger" size="sm" @click="remove(index)"><i class="ri-delete-bin-line m-0"></i></b-button>
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
import RestApi, { commonServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { committeeStore, committeeUpdate, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        committee: [
          {
            user_id: 0
          }
        ]
      },
      userList: [],
      attachmentDemo: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCommitteeData()
      this.form = tmp
    }
  },
  computed: {
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
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    }
  },
  methods: {
    getCommitteeData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    onChange (e) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    },
    addUser () {
      const tmp = {
        user_id: 0
      }
      this.form.committee.push(tmp)
      },
    remove (key) {
      this.form.committee.splice(key, 1)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${committeeUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, committeeStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getUserList (orgId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          const userData = response.data.filter(user => user.org_id === orgId)
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
    }
  }
}
</script>
