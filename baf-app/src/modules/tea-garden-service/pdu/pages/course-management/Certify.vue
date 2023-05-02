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
                                            <ValidationProvider name="Registration No" vid="registration_no" rules="required">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="3"
                                                    label-for="registration_no"
                                                    slot-scope="{ valid, errors }">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenBtriService.registration_no') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                    id="registration_no"
                                                    v-model="data.registration_no"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
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
                                            <b-button type="submit" variant="primary" class="mr-2">{{ $t('teaGardenPduService.certify') }}</b-button>
                                            &nbsp;
                                            <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-8')">{{ $t('globalTrans.cancel') }}</b-button>
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { reportPublish } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['id'],
    created () {
      if (this.id) {
        const tmp = this.getInfo()
        this.data = tmp
      }
    },
    mounted () {
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.publish') : this.$t('globalTrans.save'),
            data: {
              id: 0,
              registration_no: ''
            },
            loader: false
        }
    },
    methods: {
        getInfo () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        async register () {
            this.loader = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadinState = { loading: false, listReload: true }
            result = await RestApi.putData(teaGardenServiceBaseUrl, `${reportPublish}/${this.data.id}`, this.data)
            this.$store.dispatch('mutateCommonProperties', loadinState)
            if (result.success) {
                this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })
                this.$bvModal.hide('modal-8')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
            this.loader = false
        }
    }
}
</script>
