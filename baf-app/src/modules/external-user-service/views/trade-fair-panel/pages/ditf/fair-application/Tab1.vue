<template>
    <b-row>
        <b-col sm="12">
            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                    <b-overlay :show="unitLoad">
                        <b-row class="mb-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1">{{ $t('externalTradeFair.applicant_info') }}</h6>
                            </div>
                        </b-row>
                        <div class="application-form-wrapper">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="jumbotron" style="padding: 1rem">
                                            <p><b class="text-alt">{{ $t('exportTrophyCircular.circular') }} :</b> <span class="lead">{{ circular_name }}</span></p>
                                        </div>
                                    </b-col>
                                </b-row>
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.company_basic_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.applicant_name') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.name_en" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.applicant_name') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.name_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Designation (En)" vid="designation_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="designation_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.designation') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.designation_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Designation (Bn)" vid="designation_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="designation_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.designation') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.designation_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.exporter_business_entity_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (En)" vid="comp_name_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="comp_name_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.org_comp_name') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.comp_name_en" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (Bn)" vid="comp_name_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="comp_name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.org_comp_name') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.comp_name_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Telephone No." vid="phone_no" rules="max:11" v-slot="{ errors }">
                                                                <b-form-group label-for="phone_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalUser.telephone_no') }}
                                                                    </template>
                                                                    <b-form-input v-model="application.phone_no" :state="errors[0] ? false : (valid ? true : null)"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Mobile No." vid="mobile_no" rules="required|max:11" v-slot="{ errors }">
                                                                <b-form-group label-for="mobile_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.mobile_no') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.mobile_no" :state="errors[0] ? false : (valid ? true : null)"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
                                                                <b-form-group label-for="email">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.email') }}
                                                                    </template>
                                                                    <b-form-input id="org_bn" type="email" v-model="application.email"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </div>
                    </b-overlay>
                </b-form>
            </ValidationObserver>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartStoreOneApi } from '../../../api/routes'
import { mapGetters } from 'vuex'

export default {
    props: ['app_id', 'application', 'circular'],
    components: {},
    data () {
        return {
            errors: [],
            valid: null,
            unitLoad: false,
            circular_name: ''
        }
    },
    created () {
        this.circular_name = this.$i18n.locale === 'bn' ? this.circular.subject_bn : this.circular.subject_en
    },
    watch: {
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.circular_name = this.$i18n.locale === 'bn' ? this.circular.subject_bn : this.circular.subject_en
            }
        }
    },
    computed: {
        yearList () {
            return this.$store.state.commonObj.yearList.map(el => {
                return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'en' ? el : this.$n(el, { useGrouping: false }) })
            })
        },
        ...mapGetters({
            commonProfile: 'Auth/commonProfile',
            authUser: 'Auth/authUser'
        }),
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        async submit () {
            var check = await this.$refs.form.validate()
            if (check) {
                this.unitLoad = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                this.application.prev_exports = this.prev_exports
                const result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartStoreOneApi, this.application)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.unitLoad = false
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: result.message,
                        color: '#ee5253'
                    })
                    this.$refs.form.setErrors(result.errors)
                }
            }
        }
    }
}
</script>
