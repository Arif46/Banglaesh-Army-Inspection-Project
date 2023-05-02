<template>
    <div class="application-itmes">
      <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
          <b-overlay :show="loading">
            <b-row>
                <b-col sm="12">
                    <div class="group-form-card">
                        <b-card>
                            <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.other_facilities')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                <b-row>
                                    <b-col sm="4">
                                        <ValidationProvider name="Residence Facilities" vid="has_residence_facilities" rules="required">
                                            <b-form-group
                                              slot-scope="{ valid, errors, ariaDescribedby }"
                                              label-for="has_residence_facilities"
                                            >
                                                <template v-slot:label>
                                                  {{ $t('teaGardenPanel.residence_facilities') }}<span class="text-danger">*</span>
                                                </template>
                                                <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                                    size="lg" v-model="formData.has_residence_facilities"
                                                    :options="yesNoList"
                                                    :aria-describedby="ariaDescribedby"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    name="has_residence_facilities"
                                                    :disabled="isRenew"
                                                >
                                                </b-form-radio-group>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="School Facilities" vid="has_school_facilities" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors, ariaDescribedby }"
                                            label-for="has_school_facilities"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.school_facilities') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                                size="lg"
                                                id="has_school_facilities"
                                                v-model="formData.has_school_facilities"
                                                :options="yesNoList"
                                                :aria-describedby="ariaDescribedby"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                                name="has_school_facilities">
                                            </b-form-radio-group>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                      <ValidationProvider name="Hospital Facilities" vid="has_hospital_facilities" rules="required">
                                        <b-form-group
                                          slot-scope="{ valid, errors, ariaDescribedby }"
                                          label-for="has_hospital_facilities"
                                        >
                                          <template v-slot:label>
                                            {{ $t('teaGardenPanel.hospital_facilities') }}<span class="text-danger">*</span>
                                          </template>
                                          <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                              size="lg"
                                              id="has_hospital_facilities"
                                              v-model="formData.has_hospital_facilities"
                                              :options="yesNoList"
                                              :aria-describedby="ariaDescribedby"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              :disabled="isRenew"
                                              name="has_hospital_facilities">
                                          </b-form-radio-group>
                                          <div class="invalid-feedback">
                                            {{ errors[0] }}
                                          </div>
                                        </b-form-group>
                                      </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="Mosque/Temple Facilities" vid="has_mosque_facilities" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors, ariaDescribedby }"
                                            label-for="has_mosque_facilities"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.mosque_facilities') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                                size="lg"
                                                id="has_mosque_facilities"
                                                v-model="formData.has_mosque_facilities"
                                                :options="yesNoList"
                                                :aria-describedby="ariaDescribedby"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                                name="has_mosque_facilities">
                                            </b-form-radio-group>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="Club/Playground Facilities" vid="has_club_facilities" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors, ariaDescribedby }"
                                            label-for="has_club_facilities"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.club_facilities') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                                size="lg"
                                                id="has_club_facilities"
                                                v-model="formData.has_club_facilities"
                                                :options="yesNoList"
                                                :aria-describedby="ariaDescribedby"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                                name="has_club_facilities">
                                            </b-form-radio-group>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="Supply of Drinking Water Facilities" vid="has_drinking_water_facilities" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors, ariaDescribedby }"
                                            label-for="has_drinking_water_facilities"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.drinking_water_facilities') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                                                size="lg"
                                                id="has_drinking_water_facilities"
                                                v-model="formData.has_drinking_water_facilities"
                                                :options="yesNoList"
                                                :aria-describedby="ariaDescribedby"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                                name="has_drinking_water_facilities">
                                            </b-form-radio-group>
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
                            <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.manpower_information')" label-size="lg" label-class="font-weight-bold pt-0"
                                class="mb-0">
                                <b-row>
                                    <b-col sm="4">
                                        <ValidationProvider name="No. of Officers" vid="no_of_officers" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="no_of_officers"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.no_of_officers') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                              type="number"
                                              id="no_of_officers"
                                              v-model="formData.no_of_officers"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="No. of Staffs" vid="no_of_stuffs" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="no_of_stuffs"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.no_of_stuffs') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                              type="number"
                                              id="no_of_stuffs"
                                              v-model="formData.no_of_stuffs"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="4">
                                        <ValidationProvider name="No. of Workers" vid="no_of_workers" rules="required">
                                          <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="no_of_workers"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.no_of_workers') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                              type="number"
                                              id="no_of_workers"
                                              v-model="formData.no_of_workers"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              :disabled="isRenew"
                                            >
                                            </b-form-input>
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
          </b-overlay>
        </b-form>
      </ValidationObserver>
    </div>
</template>

<script>
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { otherInfoStoreApi, otherInfoUpdateApi } from '../../api/routes'

    export default {
        props: ['tabFormData', 'status', 'isRenew'],
        data () {
            return {
                valid: null,
                formData: this.tabFormData,
                teaGardenServiceBaseUrl: teaGardenServiceBaseUrl
            }
        },
        created () {
        },
        mounted () {
            this.formData = this.tabFormData
        },
        computed: {
            loading: function () {
                return this.$store.state.commonObj.loading
            },
            currentLocale () {
                return this.$i18n.locale
            },
            yesNoList () {
                return [
                    { text: this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ', value: 1, text_en: 'Yes', text_bn: 'হ্যাঁ' },
                    { text: this.currentLocale === 'en' ? 'No' : 'না', value: 2, text_en: 'No', text_bn: 'না' }
                ]
            }
        },
        watch: {
        },
        methods: {
            async submit () {
                var check = await this.$refs.form.validate()
                if (check) {
                    this.loading = true
                    this.$store.dispatch('mutateCommonProperties', { loading: true })
                    const loadingState = { loading: false, listReload: false }
                    let result
                    const data = Object.assign({}, this.formData, { status: this.status })
                    if (this.formData.id) {
                        result = await RestApi.putData(teaGardenServiceBaseUrl, otherInfoUpdateApi + '/' + this.formData.id, data)
                    } else {
                        result = await RestApi.postData(teaGardenServiceBaseUrl, otherInfoStoreApi, data)
                    }
                    loadingState.listReload = true
                    this.$store.dispatch('mutateCommonProperties', loadingState)
                    this.loading = false
                    if (result.success) {
                        this.$toast.success({
                            title: 'Success',
                            message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                            color: '#D6E09B'
                        })
                        return result
                    } else {
                        this.$toast.error({
                            title: this.$t('globalTrans.error'),
                            message: this.$t('globalTrans.form_error_msg'),
                            color: '#ee5253'
                        })
                    }
                }
            }
        }
    }
</script>
