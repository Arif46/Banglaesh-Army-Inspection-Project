<template>
  <div class="inner-section">
    <card>
        <!-- search section start -->
        <template v-slot:searchHeaderTitle>
            <h4 class="card-title">{{ $t('authentication.changePassword') }}</h4>
        </template>
        <template v-slot:searchBody>
            <b-row>
                <b-col lg="8" sm="12">
                    <b-overlay :show="loading">
                        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                            <b-form @submit.prevent="handleSubmit(loginSubmit)" @reset.prevent="reset">
                                <ValidationProvider name="Old Password" vid="old_password" rules="required|min:6">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="4"
                                        label-for="old_password"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{ $t('authentication.oldPassword') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            type="password"
                                            id="old_password"
                                            v-model="form.old_password"
                                            :placeholder="$t('authentication.oldPassword')"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                                <ValidationProvider name="New Password" vid="new_password" rules="required|min:6">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="4"
                                        label-for="new_password"
                                        slot-scope="{ valid, errors }"
                                    >
                                         <template v-slot:label>
                                            {{ $t('authentication.newPassword') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            type="password"
                                            id="new_password"
                                            v-model="form.new_password"
                                            :placeholder="$t('authentication.newPassword')"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                                <ValidationProvider name="Repeat New Password" vid="repeat_new_password" rules="required|confirmed:new_password|min:6">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="4"
                                        label-for="repeat_new_password"
                                        slot-scope="{ valid, errors }"
                                    >
                                        <template v-slot:label>
                                            {{ $t('authentication.repeatNewPassword') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            type="password"
                                            id="repeat_new_password"
                                            v-model="form.repeat_new_password"
                                            :placeholder="$t('authentication.repeatNewPassword')"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                                <b-button type="submit" variant="primary">{{ $t('globalTrans.submit') }}</b-button>
                                &nbsp;
                                <b-button variant="danger" class="mr-1" type="reset" @click="resetForm">{{ $t('globalTrans.reset') }}</b-button>
                            </b-form>
                        </ValidationObserver>
                    </b-overlay>
                </b-col>
            </b-row>
        </template>
    </card>
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { changePassword } from '../api/routes'

export default {
  data () {
    return {
        loading: false,
        form: {
            old_password: '',
            new_password: '',
            repeat_new_password: ''
        }
    }
  },
  computed: {
    ...mapGetters({
      authUser: 'Auth/authUser'
    })
  },
  methods: {
    async loginSubmit () {
        this.loading = true
        const formData = Object.assign(this.form, { user_type: this.authUser.user_type, user_id: this.authUser.user_id })
        const response = await RestApi.postData(authServiceBaseUrl, changePassword, formData)
        this.loading = false
        if (response.success) {
            this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: response.message,
                color: '#D6E09B'
            })
        } else {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                color: '#ee5253',
                message: response.message
            })
            this.$refs.form.setErrors(response.errors)
        }
    },
    resetForm () {
        this.$nextTick(() => {
            this.$refs.form.reset()
        })
        // this.$refs.form.reset()
        // this.form.old_password = this.form.new_password = this.form.repeat_new_password = ''
    }
  }
}
</script>
