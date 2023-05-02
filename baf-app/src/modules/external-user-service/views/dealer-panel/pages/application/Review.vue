<template>
  <b-row>
    <b-col md="12" lg="12" sm="12">
      <div class="text-center mt-2">
        <b-form-radio-group
          id="review_type"
          v-model="type"
          :options="paidTypeList"
        ></b-form-radio-group>
      </div>
    </b-col>
    <b-col md="12" lg="12" sm="12">
          <ValidationObserver ref="from" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" autocomplete="off">
              <b-overlay :show="saveloading">
                <div class="row">
                    <div class="col-md-12">
                      <ValidationProvider name="Comment" :vid="`comment`" :rules="`required`">
                          <b-form-group
                              class="row"
                              label-cols-sm="3"
                              label-for="comment"
                              slot-scope="{ valid, errors }"
                              style="font-size: 13px"
                          >
                              <template v-slot:label>
                                  {{ $t('globalTrans.comments') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-textarea
                                  id="comment"
                                  rows="6"
                                  v-model="formData.comment"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-textarea>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                          </b-form-group>
                        </ValidationProvider>
                    </div>
                    <div class="col-md-12">
                      <b-form-group
                          class="row"
                          label-cols-sm="3"
                          label-for="rating"
                          style="font-size: 13px"
                          >
                          <template v-slot:label>
                              {{ $t('license_config.rating') }} <span class="text-danger">*</span>
                          </template>
                        <div>
                          <b-form-rating variant="warning" v-model="formData.rating"></b-form-rating>
                        </div>
                      </b-form-group>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12 text-right">
                        <b-button type="submit" variant="primary" class="mr-2 btn-sm">{{ $t('globalTrans.save') }}</b-button>
                        <b-button variant="danger" class="mr-1 btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                    </div>
                </div>
              </b-overlay>
            </b-form>
          </ValidationObserver>
        </b-col>
  </b-row>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { reviewStore } from '../../api/routes'
import { EventBus } from '@/EventBusLayout'

export default {
  props: ['application'],
  name: 'Review',
  components: {
  },
  data () {
    return {
      formData: {
        comment: '',
        rating: 5
      }
    }
  },
  computed: {
  },
  created () {
  },
  methods: {
     async saveFormData () {
        let result = null
        this.saveloading = true
        const saveData = Object.assign(this.formData, {
          tcb_application_id: this.application.id
        })
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, reviewStore, saveData)
        this.saveloading = false
        if (result.success) {
            this.$toast.success({
              title: 'Success',
              message: 'Your Review Successfully Submited.'
            })
            this.$bvModal.hide('modal-form')
            EventBus.$emit('offlinePaymentSubmit')
        } else {
            this.$refs.form.setErrors(result.errors)
              this.$toast.error({
                title: 'Error',
                message: 'Review failed.'
              })
        }
    }
  }
}
</script>
