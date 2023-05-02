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
                                        <b-col xs="12" sm="12" md="12">
                                            <ValidationProvider name="Attachment" vid="attachment">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                     label-cols-sm="3"
                                                    label-for="attachment">
                                                    <template v-slot:label>
                                                        {{ $t('globalTrans.attachment') }}
                                                    </template>
                                                    <b-form-file
                                                        id="attachment"
                                                        v-model="data.file"
                                                        @change="onChange"
                                                        accept=".pdf"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        placeholder="Choose a file or drop it here..."
                                                        drop-placeholder="Drop file here..."
                                                    ></b-form-file>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-col>
                                        <b-col lg="12" sm="12">
                                            <ValidationProvider name="Reason" rules="required">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="3"
                                                    label-for="reason"
                                                    slot-scope="{ valid, errors }"
                                                >
                                                <template v-slot:label>
                                                    {{ $t('globalTrans.comments')}} <span class="text-danger">*</span>
                                                </template>
                                                    <b-form-textarea
                                                    id="reason"
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
                                            <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                            &nbsp;
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { applicantApprove } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['id'],
    created () {
      if (this.id) {
        const tmp = this.getInfo()
        this.data.base_table_id = tmp.id
        this.data.status = 5
        this.data.attachment = ''
        this.data.user_id = this.$store.state.Auth.authUser.user_id
        this.data.designation_id = this.$store.state.Auth.authUser.office_detail.designation_id
        this.data.office_type_id = this.$store.state.Auth.authUser.office_detail.office_type_id
        this.data.office_id = this.$store.state.Auth.authUser.office_detail.office_id
      }
    },
    mounted () {
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.reject') : this.$t('globalTrans.save'),
            data: {
                file: '',
                remarks: ''
            },
            loader: false
        }
    },
    methods: {
        getInfo () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
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
            this.loader = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadinState = { loading: false, listReload: true }
            result = await RestApi.postData(teaGardenServiceBaseUrl, `${applicantApprove}`, this.data)
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
            this.loader = false
        }
    }
}
</script>
