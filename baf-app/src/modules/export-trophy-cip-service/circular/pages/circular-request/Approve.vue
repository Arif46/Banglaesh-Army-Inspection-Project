<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <h5 class="card-title"><b>{{ $t('exportTrophyCircular.title') }} : {{ currentLocale === 'bn' ? form.title_bn : form.title_en }}</b></h5>
        </b-col>
        <b-col sm="12">
          <ValidationProvider name="Approve note" vid="note_en" rules="required">
            <b-form-group
              label-for="note_en"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{$t('exportTrophyCircular.approve_note')}} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
                  id="note_en"
                  v-model="form.approve_note"
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
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-approve')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { circularApproveApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.approve'),
      errors: [],
      form: {
        approve_note: ''
      },
      userList: [],
      userLoading: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircular()
      this.form = tmp
      // this.form.sender_id = this.$store.state.Auth.authUser.user_id
    }
  },
  watch: {
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
    getCircular () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, circularApproveApi, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: result.message,
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form-approve')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
