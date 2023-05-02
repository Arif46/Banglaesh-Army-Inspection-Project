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
                                            <ValidationProvider name="Remarks" rules="">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="3"
                                                    label-for="return_remarks"
                                                    slot-scope="{ valid, errors }"
                                                >
                                                <template v-slot:label>
                                                    {{ $t('globalTrans.remarks') }}
                                                </template>
                                                    <b-form-textarea
                                                    id="return_remarks"
                                                    v-model="data.return_remarks"
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
                                          <b-button type="submit" variant="primary" class="mr-2">{{ $t('globalTrans.return') }}</b-button>
                                          <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-4')">{{ $t('globalTrans.cancel') }}</b-button>
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
import { applicationReturn } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['item', 'id'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
    created () {
      if (this.item) {
        this.data = this.item
        this.data.return_remarks = ''
      }
    },
    data () {
        return {
          data: {
            return_remarks: ''
          }
        }
    },
    computed: {
      loading () {
        return this.$store.state.commonObj.loading
      }
    },
    methods: {
      async register () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadinState = { loading: false, listReload: true }
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${applicationReturn}/${this.id}`, this.data)
        this.$store.dispatch('mutateCommonProperties', loadinState)
        if (result.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-4')
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    }
}
</script>
