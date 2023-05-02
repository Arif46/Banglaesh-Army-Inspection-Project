<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
       <b-col sm="12">
          <ValidationProvider :name="$t('complain_management.approve_note') +' '+ $t('globalTrans.en')" vid="approve_note" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="approve_note">
              <template v-slot:label>
                {{ $t('complain_management.approve_note') }} {{ $t('globalTrans.en')}} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
                rows="3"
                id="approve_note"
                v-model="complainReport.approve_note"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider :name="$t('complain_management.approve_note') +' '+ $t('globalTrans.bn')" vid="approve_note_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="approve_note_bn">
              <template v-slot:label>
                {{ $t('complain_management.approve_note') }} {{ $t('globalTrans.bn')}} <span class="text-danger">*</span>
              </template>
             <b-form-textarea
                rows="3"
                id="approve_note_bn"
                v-model="complainReport.approve_note_bn"
                :state="errors[0] ? false : (valid ? true : null)"
             ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider name="Attachment" vid="attachment">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('docuement_management.attachment') }}
                </template>
                <b-form-file
                    id="attachment"
                    v-model="complainReport.file"
                    @change="onChange"
                    drop-placeholder="Drop file here..."
                ></b-form-file>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-1')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { complainApproveSubmit } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      complainReport: {
        complain_id: this.id,
        approve_note: '',
        approve_note_bn: '',
        attachment: '',
        file: []
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDocument()
      this.complainReport = tmp
      this.complainReport.oldfile = tmp.attachment
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.complainReport.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.complainReport.attachment = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: false }

      const config = {
        headers: { 'content-type': 'multipart/form-data' }
      }

      var formData = new FormData()
      Object.keys(this.complainReport).map(key => {
        formData.append(key, this.complainReport[key])
      })
      result = await RestApi.postData(commonServiceBaseUrl, complainApproveSubmit, formData, config)
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-1')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    },
    getDocument () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
