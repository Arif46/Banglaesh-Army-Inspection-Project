<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider name="Notification Type Name (En)" vid="not_type_name" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="not_type_name">
              <template v-slot:label>
                {{ $t('notification.notification_type_name') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="not_type_name"
                v-model="notification.not_type_name"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider name="Notification Type Name (Bn)" vid="not_type_name_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="not_type_name_bn">
              <template v-slot:label>
                {{ $t('notification.notification_type_name_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="not_type_name_bn"
                v-model="notification.not_type_name_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
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
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { notificationTypeStore, notificationTypeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      notification: {
        not_type_name: '',
        not_type_name_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getNotification()
      this.notification = tmp
    }
  },
   computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${notificationTypeUpdate}/${this.id}`, this.notification)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, notificationTypeStore, this.notification)
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
    getNotification () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
