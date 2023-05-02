<template>
<b-container fluid>
    <b-row>
    <b-overlay :show="loading">
      <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
         <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Upload Agreement" vid="attachment" rules="">
                <b-form-group
                    label-for="attachment"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('eBizProgram.upload_agreement') }}
                    </template>
                <b-form-file id="attachment"
                v-model="formData.file"
                v-on:change="onFileChange"
                accept=".doc,.docx,.pdf"
                class="mt-2" plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                    <div class="invalid-feedback">
                    {{ errors[0] }}
                    </div>
                </b-form-group>
            </ValidationProvider>
            </b-col>
        </b-row>
        </b-form>
    </ValidationObserver>
        <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('make-agreement')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
        </b-row>
    </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { saveAgreement } from '../../api/routes'
export default {
  name: 'Form',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.items.id ? this.$t('eBizProgram.agreement') : this.$t('globalTrans.save'),
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      errors: [],
      formData: {
        id: 0,
        attachment: '',
        file: []
      }
    }
  },
  created () {
    if (this.items.id) {
      const tmp = this.getFeeEntry()
      // this.formData = tmp
      this.formData.id = tmp.id
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  watch: {
  },
  methods: {
     onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.formData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.formData.attachment = ''
        }
    },
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.items.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${saveAgreement}/${this.items.id}`, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.items.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('make-agreement')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.items.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
