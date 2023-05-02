<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
                <b-overlay :show="loader">
                    <b-row>
                        <b-col xl="12" lg="12" sm="12">
                            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                                <b-form @submit.prevent="handleSubmit(register)" @reset.prevent="reset">
                                    <b-row>
                                        <b-col lg="12" sm="12">
                                            <ValidationProvider name="Comment" vid='comment_en' rules="required">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="2"
                                                    label-for="reason"
                                                    slot-scope="{ valid, errors }"
                                                >
                                                <template v-slot:label>
                                                    {{ $t('globalTrans.comments')}} <span class="text-danger">*</span>
                                                </template>
                                                    <b-form-textarea
                                                    id="reason"
                                                    v-model="data.comment_en"
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
                                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                                        <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-7')">{{ $t('globalTrans.cancel') }}</b-button>
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
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairCalenderCircularReturn } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['item', 'id'],
    created () {
      if (this.item) {
        this.data = this.item
        this.data.comment_en = ''
      }
    },
    mounted () {
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.review') : this.$t('globalTrans.save'),
            data: {
              comment_en: ''
            },
            loader: false
        }
    },
    methods: {
        async register () {
            this.loader = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadinState = { loading: false, listReload: true }
            result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairCalenderCircularReturn}/${this.id}`, this.data)
            this.$store.dispatch('mutateCommonProperties', loadinState)
            if (result.success) {
                this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
                // if (result.notification) {
                //     this.$socket.emit('send-notification', result.notification)
                // }
                this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
                })
                this.$bvModal.hide('modal-7')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
            this.loader = false
        }
    }
}
</script>
