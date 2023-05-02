<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
                <b-overlay :show="loading">
                    <b-row>
                        <b-col xl="12" lg="12" sm="12">
                            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                                <b-form @submit.prevent="handleSubmit(register)" @reset.prevent="reset">
                                    <b-row>
                                        <b-col lg="12" sm="12">
                                          <ValidationProvider name="Attachment" vid="attachment" rules="required">
                                              <b-form-group
                                                slot-scope="{ valid, errors }"
                                                class="row"
                                                label-cols-sm="3"
                                                label-for="attachment"
                                              >
                                                  <template v-slot:label>
                                                      {{ $t('globalTrans.attachment') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-file
                                                    id="attachment"
                                                    v-model="data.attachment"
                                                    @change="onChange"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    :placeholder="$t('globalTrans.attachment_placeholder')"
                                                    :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                    :disabled="isRenew"
                                                  ></b-form-file>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                              </b-form-group>
                                          </ValidationProvider>
                                      </b-col>
                                      <b-col lg="12" sm="12">
                                        <ValidationProvider name="Remarks" rules="">
                                            <b-form-group
                                                class="row"
                                                label-cols-sm="3"
                                                label-for="remarks"
                                                slot-scope="{ valid, errors }"
                                            >
                                            <template v-slot:label>
                                                {{ $t('globalTrans.remarks') }}
                                            </template>
                                                <b-form-textarea
                                                id="remarks"
                                                v-model="data.remarks"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-textarea>
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
                                          <b-button type="submit" variant="primary" class="mr-2">{{ $t('globalTrans.upload') }}</b-button>
                                          <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-7')">{{ $t('globalTrans.cancel') }}</b-button>
                                      </div>
                                    </div>
                                </b-form>
                            </ValidationObserver>
                        </b-col>
                    </b-row>
                </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { reportPrepare } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['item', 'id'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
    created () {
      if (this.item) {
        // this.data.user_id = this.authUser.user_id
        // this.data.designation_id = this.authUser.office_detail.designation_id
        // this.data.office_type_id = this.authUser.office_detail.office_type_id
        // this.data.office_id = this.authUser.office_detail.office_id
        // this.data.remarks = ''
        this.data = Object.assign({}, {
          user_id: this.authUser.user_id,
          designation_id: this.authUser.office_detail.designation_id,
          office_type_id: this.authUser.office_detail.office_type_id,
          office_id: this.authUser.office_detail.office_id,
          remarks: '',
          attachment: ''
        })
      }
    },
    data () {
        return {
          data: {
            user_id: '',
            designation_id: '',
            office_type_id: '',
            office_id: '',
            remarks: '',
            attachment: ''
          }
        }
    },
    computed: {
      loading () {
        return this.$store.state.commonObj.loading
      },
      authUser () {
        return this.$store.state.Auth.authUser
      }
    },
    methods: {
      onChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
              const reader = new FileReader()
              reader.onload = (e) => {
                  this.data.attachment = e.target.result
              }
              reader.readAsDataURL(input.files[0])
          } else {
              this.data.attachment = ''
          }
      },
      async register () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadinState = { loading: false, listReload: true }
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${reportPrepare}/${this.id}`, this.data)
        this.$store.dispatch('mutateCommonProperties', loadinState)
        if (result.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-7')
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    }
}
</script>
