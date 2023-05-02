<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <b-overlay :show="loading">
          <iq-card>
            <template v-slot:body>
              <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
                <b-form  @submit.prevent="handleSubmit(register)" >
                  <b-row>
                    <b-col lg="10" sm="12">
                      <ValidationProvider name="Service" vid="service_id">
                        <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="Service"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('globalTrans.attachment') }}
                          </template>
                          <b-form-file
                            id="attachment"
                            v-on:change="onFileChange"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <div class="row">
                    <div class="col-sm-3"></div>
                    <div class="col text-right">
                      <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                      &nbsp;
                      <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-6')">{{ $t('globalTrans.cancel') }}</b-button>
                    </div>
                  </div>
                </b-form>
              </ValidationObserver>
            </template>
          </iq-card>
        </b-overlay>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '../../../../../config/api_config'
import { servicePublishwithDoc } from '../../api/routes'

export default {
  props: ['id', 'pDatas'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      saveBtnName: this.$t('globalTrans.publish'),
      publishData: {
        application_id: 0,
        attachment: ''
      },
      attachmentDemo: [],
      loading: false
    }
  },
  created () {
    this.publishData.application_id = parseInt(this.pDatas) // application id assign
  },
  methods: {
    onFileChange (e) {
      // this.attachmentDemo = e.target.files[0]
      this.getBase64(e.target.files[0]).then(res => {
        this.attachmentDemo = res
      })
    },
    getBase64 (file) {
      return new Promise(function (resolve, reject) {
        const reader = new FileReader()
        let imgResult = ''
        reader.readAsDataURL(file)
        reader.onload = function () {
            imgResult = reader.result
        }
        reader.onerror = function (error) {
            reject(error)
        }
        reader.onloadend = function () {
            resolve(imgResult)
        }
      })
    },
    async register () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null

      const config = { headers: { 'content-type': 'multipart/form-data' } }
      var formData = new FormData()
      Object.keys(this.publishData).map(key => {
          if (key === 'attachment') {
          formData.append(key, this.attachmentDemo)
          } else {
          formData.append(key, this.publishData[key])
          }
      })

      const loadinState = { loading: false, listReload: false }
      this.loading = true

      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, servicePublishwithDoc, formData, config)

      this.loading = false
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-6')
        this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    }
  }
}
</script>
