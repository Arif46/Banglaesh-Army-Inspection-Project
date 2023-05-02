<template>
    <div class="application-itmes">
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="6">
                            <ValidationProvider name="Circular Name" vid="circular_name" rules="">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="circular_name"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPduService.circular_name') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-if="currentLocale === 'en'"
                                      v-model="formData.circular_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      disabled
                                    ></b-form-input>
                                    <b-form-input
                                      v-else
                                      v-model="formData.circular_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      disabled
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                    </b-row>
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('globalTrans.basic_information')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Name (En)" vid="applicant_name_en" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="applicant_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.applicant_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.applicant_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isSelfApplicant"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Name (Bn)" vid="applicant_name_bn" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="applicant_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.applicant_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.applicant_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isSelfApplicant"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Father Name (En)" vid="father_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="father_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.father_name') }} {{ $t('globalTrans.en') }}
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.father_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Father Name (Bn)" vid="father_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="father_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.father_name') }} {{ $t('globalTrans.bn') }}
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.father_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>

                                            <b-col sm="6">
                                                <ValidationProvider name="Mother Name (En)" vid="mother_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="mother_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.mother_name') }} {{ $t('globalTrans.en') }}
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.mother_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mother Name (Bn)" vid="mother_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="mother_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.mother_name') }} {{ $t('globalTrans.bn') }}
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.mother_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Contact No" vid="contact_no" rules="required|min:11|max:11">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="contact_no"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.contact_no') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="tel"
                                                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                          v-model="formData.contact_no"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isSelfApplicant"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="E-mail" vid="email" rules="required|email">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="email"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.email') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          id="email"
                                                          v-model="formData.email"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isSelfApplicant"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Nationality" vid="nationality" rules="" v-slot="{ errors }">
                                                    <b-form-group label-for="nationality">
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.nationality') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                          plain
                                                          v-model="formData.nationality"
                                                          :options="nationalityList"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-select>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Date of Birth" vid="date_of_birth" rules="required">
                                                    <b-form-group
                                                      class="row"
                                                      label-for="date_of_birth"
                                                      slot-scope="{ valid, errors }">
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.dob') }}  <span class="text-danger">*</span>
                                                        </template>
                                                        <date-picker
                                                          id="date_of_birth"
                                                          v-model="formData.date_of_birth"
                                                          class="form-control"
                                                          :placeholder="$t('globalTrans.select_date')"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :class="errors[0] ? 'is-invalid' : ''"
                                                          :locale="currentLocale"
                                                        >
                                                        </date-picker>
                                                        <div class="invalid-feedback d-block">
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
                                    <h6 class="card-title mb-4">{{ $t('globalTrans.applicant_address') }}</h6>
                                    <b-form-group label-cols-lg="3" :label="$t('globalTrans.present_address')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <Address :key="pr_address.area_type_id" :data.sync="pr_address" :addressType="'address'" :param="fieldObj" @address-data="receivePrAddress" title="Present Address"/>
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-checkbox
                                                  id="checkbox-1"
                                                  v-model.number="formData.is_same_as_present"
                                                  name="checkbox-1"
                                                  value="1"
                                                  unchecked-value="0"
                                                >
                                                    {{ $t('tcbconfiguration.is_same') }}
                                                </b-form-checkbox>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>

                                    <b-form-group label-cols-lg="3" :label="$t('globalTrans.permanent_address')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <Address :key="JSON.stringify(pm_address)" :data.sync="pm_address" :addressType="'address'" :param="fieldObj" @address-data="receivePmAddress" title="Permanent Address"/>
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
import { applicantInfoStoreApi, applicantInfoUpdateApi } from '../../api/routes'
import Address from '@/components/Address.vue'
export default {
    props: ['tabFormData', 'status'],
    components: { Address },
    data () {
        return {
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            fieldObj: {
                xl: 6,
                lg: 6,
                md: 6,
                sm: 12,
                labelCols: 12,
                noCountry: true,
                noAddress: false,
                isPaurashavaNullable: true,
                isUnionNullable: true,
                hasPostCode: true,
                isPostCodeNullable: true,
                noMargin: true
            },
            valid: null,
            formData: {
            },
            pr_address: {
              area_type_id: 0,
              division_id: 0,
              district_id: 0,
              city_corporation_id: 0,
              paurashava_id: 0,
              upazila_id: 0,
              union_id: 0,
              ward_id: 0,
              post_code: '',
              address_details_en: '',
              address_details_bn: ''
            },
            pm_address: {
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                ward_id: 0,
                post_code: '',
                address_details_en: '',
                address_details_bn: ''
            }
        }
    },
    created () {
    },
    mounted () {
        this.formData = this.tabFormData
        this.formData = Object.assign({}, this.formData, this.tabFormData)
        // if (this.$route.query.circular_id) {
        //     this.formData.circular_id = this.$route.query.circular_id
        //     this.formData.circular_name = this.getCircularName(this.$route.query.circular_id)
        // } else {
        //     this.formData.circular_name = this.getCircularName(this.formData.circular_id)
        // }
        if (this.isSelfApplicant) {
            this.formData = Object.assign({}, this.formData, {
                applicant_name_en: this.authUser.name,
                applicant_name_bn: this.authUser.name_bn,
                email: this.authUser.email,
                contact_no: this.authUser.mobile
            })
        }
        this.pr_address = {
            area_type_id: this.formData.pr_area_type_id,
            division_id: this.formData.pr_division_id,
            district_id: this.formData.pr_district_id,
            city_corporation_id: this.formData.pr_city_corporation_id,
            paurashava_id: this.formData.pr_pauroshoba_id,
            upazila_id: this.formData.pr_upazila_id,
            union_id: this.formData.pr_union_id,
            ward_id: this.formData.pr_ward_id,
            post_code: this.formData.pr_post_code,
            address_details_en: this.formData.pr_address_en,
            address_details_bn: this.formData.pr_address_bn
        }
        this.pm_address = {
            area_type_id: this.formData.pm_area_type_id,
            division_id: this.formData.pm_division_id,
            district_id: this.formData.pm_district_id,
            city_corporation_id: this.formData.pm_city_corporation_id,
            paurashava_id: this.formData.pm_pauroshoba_id,
            upazila_id: this.formData.pm_upazila_id,
            union_id: this.formData.pm_union_id,
            ward_id: this.formData.pm_ward_id,
            post_code: this.formData.pm_post_code,
            address_details_en: this.formData.pm_address_en,
            address_details_bn: this.formData.pm_address_bn
        }
    },
    computed: {
        loading: function () {
            return this.$store.state.commonObj.loading
        },
        currentLocale () {
            return this.$i18n.locale
        },
        authUser () {
            return this.$store.state.Auth.authUser
        },
        isSelfApplicant () {
            return this.$store.state.Auth.activeRoleId !== 1
        },
        nationalityList () {
            return [
                { text: this.currentLocale === 'en' ? 'Bangladeshi' : 'বাংলাদেশী', value: 1, text_en: 'Bangladeshi', text_bn: 'বাংলাদেশী' },
                { text: this.currentLocale === 'en' ? 'Others' : 'অন্যান্য', value: 2, text_en: 'Others', text_bn: 'অন্যান্য' }
            ]
        }
    },
    watch: {
        'formData.is_same_as_present': function (newVal) {
            if (newVal === 1) {
                this.setPermanentAddress()
            }
        }
    },
    methods: {
        async submit () {
            var isValidated = await this.$refs.form.validate()
            if (isValidated) {
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                let result
                const data = Object.assign({}, this.formData)
                if (this.formData.id) {
                  result = await RestApi.putData(teaGardenServiceBaseUrl, applicantInfoUpdateApi + '/' + this.formData.id, data)
                } else {
                  result = await RestApi.postData(teaGardenServiceBaseUrl, applicantInfoStoreApi, data)
                }
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$refs.form.setErrors(result.errors)
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: this.$t('globalTrans.form_error_msg'),
                        color: '#ee5253'
                    })
                }
            }
        },
        receivePrAddress (address) {
            this.pr_address = address
            this.formData = Object.assign({}, this.formData, {
              pr_area_type_id: this.pr_address.area_type_id,
              pr_division_id: this.pr_address.division_id,
              pr_district_id: this.pr_address.district_id,
              pr_city_corporation_id: this.pr_address.city_corporation_id,
              pr_pauroshoba_id: this.pr_address.paurashava_id,
              pr_upazila_id: this.pr_address.upazila_id,
              pr_union_id: this.pr_address.union_id,
              pr_ward_id: this.pr_address.ward_id,
              pr_post_code: this.pr_address.post_code,
              pr_address_en: this.pr_address.address_details_en,
              pr_address_bn: this.pr_address.address_details_bn
            })
        },
        receivePmAddress (address) {
            this.pm_address = address
            this.formData = Object.assign({}, this.formData, {
                pm_area_type_id: this.pm_address.area_type_id,
                pm_division_id: this.pm_address.division_id,
                pm_district_id: this.pm_address.district_id,
                pm_city_corporation_id: this.pm_address.city_corporation_id,
                pm_pauroshoba_id: this.pm_address.paurashava_id,
                pm_upazila_id: this.pm_address.upazila_id,
                pm_union_id: this.pm_address.union_id,
                pm_ward_id: this.pm_address.ward_id,
                pm_post_code: this.pm_address.post_code,
                pm_address_en: this.pm_address.address_details_en,
                pm_address_bn: this.pm_address.address_details_bn
            })
        },
        getCircularName (id) {
            const obj = this.$store.state.TeaGardenService.commonObj.pduCircularList.find(item => item.value === parseInt(id))
            return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
        },
        isImage (path) {
          return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
        },
        isFile (path) {
            return /\.(jpg|jpeg|png|webp|avif|gif|svg|docs|doc|pdf|csv|xsl|xslx|ppt|pptx)$/.test(path)
        },
        setPermanentAddress () {
            this.pm_address = this.pr_address
            // this.formData = Object.assign({}, this.formData, {
            //     pm_area_type_id: this.pr_address.area_type_id,
            //     pm_division_id: this.formData.pr_division_id,
            //     pm_district_id: this.formData.pr_district_id,
            //     pm_city_corporation_id: this.formData.pr_city_corporation_id,
            //     pm_pauroshoba_id: this.formData.pr_pauroshoba_id,
            //     pm_upazila_id: this.formData.pr_upazila_id,
            //     pm_union_id: this.formData.pr_union_id,
            //     pm_ward_id: this.formData.pr_ward_id,
            //     pm_post_code: this.formData.pr_post_code,
            //     pm_address_en: this.formData.pr_address_details_en,
            //     pm_address_bn: this.formData.pr_address_details_bn
            // })
        }
    }
}
</script>
