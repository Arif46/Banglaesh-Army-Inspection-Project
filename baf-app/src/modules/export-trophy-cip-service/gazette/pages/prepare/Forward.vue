<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="4">
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
              @change="getUser"
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
        <b-col sm="4">
          <ValidationProvider name="Officer Name" vid="receiver_id" rules="required|min_value:1">
            <b-form-group
              label-for="receiver_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{ $t('exportTrophyCircular.employee') }} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.receiver_id"
              :options="userList"
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
        <b-col sm="4">
          <ValidationProvider name="Forward Date" vid="forward_date" rules="required">
            <b-form-group
              label-for="forward_date"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ $t('exportTrophyCircular.forward_date') }} <span class="text-danger">*</span>
              </template>
              <date-picker
                  class="form-control"
                  :config="{ static: true }"
                  v-model="form.forward_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  id="forward_date"
                >
                </date-picker>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Comment (En)" vid="note_en" rules="max:255">
            <b-form-group
              label-for="note_en"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.comment_en')}}
              </template>
              <b-form-textarea
                  id="note_en"
                  v-model="form.note_en"
                  :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-textarea>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="6">
          <ValidationProvider name="Comment (Bn)" vid="note_bn" rules="max:255">
            <b-form-group
              label-for="note_bn"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.comment_bn')}}
              </template>
              <b-form-textarea
                  id="note_bn"
                  v-model="form.note_bn"
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
          <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-forward')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { authServiceBaseUrl, exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { gazetteForwardStoreApi, userListByDesignationApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.forward'),
      errors: [],
      form: {
        designation_id: 0,
        receiver_id: 0,
        forward_date: '',
        note_en: '',
        note_bn: ''
      },
      userList: [],
      userLoading: false
    }
  },
  created () {
    if (this.id) {
      this.form.gazette_id = this.id
      this.form.sender_id = this.$store.state.Auth.authUser.user_id
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.localizeUserList(newVal)
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    designationList: function () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    getUser (designationId) {
      this.getUserList(designationId)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, gazetteForwardStoreApi, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: result.message,
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form-forward')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getUserList (designationId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, `${userListByDesignationApi}/${designationId}`).then(response => {
        const userList = response.map((obj, index) => {
          return Object.assign({}, obj, {
            value: obj.value,
            text: this.currentLocale === 'en' ? obj.text_en : obj.text_bn
          })
        })
        this.userList = userList
        this.userLoading = false
        return userList
      })
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
