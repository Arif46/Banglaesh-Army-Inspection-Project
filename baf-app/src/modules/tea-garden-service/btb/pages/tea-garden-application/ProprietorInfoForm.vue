<template>
     <div class="application-itmes">
         <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
             <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                 <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="6">
                            <ValidationProvider name="Company Name (En)" vid="company_name_en" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="company_name_en"
                                >
                                    <template v-slot:label>
                                        {{ $t('dealer.company_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-model="formData.company_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="company_name_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('dealer.company_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-model="formData.company_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.identity_of_proprietor')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Identity of Proprietor" vid="proprietor_type" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors, ariaDescribedby }"
                                                      label-for="proprietor_type"
                                                    >
                                                        <b-form-radio-group
                                                          class="custom-control-inline-wrapper mb-0"
                                                          size="lg"
                                                          v-model="formData.proprietor_type"
                                                          :options="proprietorTypeList"
                                                          :aria-describedby="ariaDescribedby"
                                                          name="radio-options1"
                                                          :disabled="isRenew"
                                                        >
                                                        </b-form-radio-group>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Name (En)" vid="garden_owner_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Name (Bn)" vid="garden_owner_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Father Name (En)" vid="garden_owner_father_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_father_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_father_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_father_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Father Name (Bn)" vid="garden_owner_father_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_father_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_father_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_father_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Mother Name (En)" vid="garden_owner_mother_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_mother_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_mother_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_mother_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Owner’s Mother Name (Bn)" vid="garden_owner_mother_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_owner_mother_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_mother_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.garden_owner_mother_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Permanent Address (En)" vid="permanent_address_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="permanent_address_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.permanent_address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-textarea
                                                          v-model="formDataAddMore.permanent_address_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-textarea>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Permanent Address (Bn)" vid="permanent_address_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="permanent_address_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.permanent_address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-textarea
                                                          v-model="formDataAddMore.permanent_address_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-textarea>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mobile No" vid="mobile" rules="|min:11|max:11">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="mobile"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.mobile') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="tel"
                                                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                          v-model="formDataAddMore.mobile"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
            <!--                                    <ValidationProvider name="Garden Owner’s Nationality" vid="garden_owner_nationality" rules="">-->
            <!--                                        <b-form-group-->
            <!--                                          slot-scope="{ valid, errors }"-->
            <!--                                          label-cols-sm="12"-->
            <!--                                          label-for="garden_owner_nationality"-->
            <!--                                        >-->
            <!--                                            <template v-slot:label>-->
            <!--                                                {{ $t('teaGardenPanel.garden_owner_nationality') }}<span class="text-danger">*</span>-->
            <!--                                            </template>-->
            <!--                                            <b-form-input-->
            <!--                                              v-model="formDataAddMore.garden_owner_nationality"-->
            <!--                                              :state="errors[0] ? false : (valid ? true : null)"-->
            <!--                                            ></b-form-input>-->
            <!--                                            <div class="invalid-feedback">-->
            <!--                                                {{ errors[0] }}-->
            <!--                                            </div>-->
            <!--                                        </b-form-group>-->
            <!--                                    </ValidationProvider>-->
                                                <ValidationProvider name="Garden Owner’s Nationality" vid="garden_owner_nationality" rules="" v-slot="{ errors }">
                                                    <b-form-group label-for="garden_owner_nationality">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_owner_nationality') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                          plain
                                                          v-model="formDataAddMore.garden_owner_nationality"
                                                          :options="nationalityList"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
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
                                            <b-col sm="12">
                                                <b-button type="button" class="add-more-btn" size="sm" @click="addDataItem" :disabled="isRenew"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_info') }}</b-button>
                                            </b-col>
                                            <b-col sm="12">
                                                <b-table-simple resonsive bordered class="mt-3 mb-0">
                                                    <b-thead>
                                                        <b-tr>
                                                            <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                                            <b-th>{{ $t('teaGardenPanel.owner_name') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.father_name') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.mobile') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.nationality') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.action') }}</b-th>
                                                        </b-tr>
                                                    </b-thead>
                                                    <b-tbody>
                                                        <template v-if="formData.owners.length">
                                                            <b-tr v-for="(item, index) in formData.owners" :key="index">
                                                                <b-td>{{ $n(index + 1) }}</b-td>
                                                                <b-td>{{ currentLocale === 'en' ? item.garden_owner_name_en : item.garden_owner_name_bn }}</b-td>
                                                                <b-td>{{ currentLocale === 'en' ? item.garden_owner_father_name_en : item.garden_owner_father_name_bn }}</b-td>
                                                                <b-td>{{ item.mobile | mobileNumber }}</b-td>
                                                                <b-td>{{ getNationalityName(item.garden_owner_nationality) }}</b-td>
                                                                <b-td class="text-center">
                                                                    <a v-if="!isRenew" href="javascript:" class="text-danger" title="Delete" @click="deleteItem(index)"><i class="ri-delete-bin-6-line"></i></a>
                                                                    <a v-else href="javascript:" class="text-danger btn-disabled" title="Delete" disabled><i class="ri-delete-bin-6-line"></i></a>
                                                                </b-td>
                                                            </b-tr>
                                                        </template>
                                                        <template v-else>
                                                            <b-tr>
                                                                <b-td colspan="6" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                                                            </b-tr>
                                                        </template>
                                                    </b-tbody>
                                                </b-table-simple>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Experience (En)" vid="experience_en" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="experience_en"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.experience') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="experience_en"
                                      v-model="formData.experience_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      rows="4"
                                      :disabled="isRenew"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Experience (Bn)" vid="experience_bn" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="experience_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.experience') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="experience_bn"
                                      v-model="formData.experience_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      rows="4"
                                      :disabled="isRenew"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                    </b-row>
                 </b-overlay>
             </b-form>
         </ValidationObserver>
    </div>
</template>

<script>
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { proprietorIdentityStoreApi, proprietorIdentityUpdateApi } from '../../api/routes'
    export default {
        props: ['tabFormData', 'status', 'isRenew'],
        data () {
            return {
                valid: null,
                formData: this.tabFormData,
                formDataAddMore: {
                    garden_owner_name_en: '',
                    garden_owner_name_bn: '',
                    garden_owner_father_name_en: '',
                    garden_owner_father_name_bn: '',
                    garden_owner_mother_name_en: '',
                    garden_owner_mother_name_bn: '',
                    permanent_address_en: '',
                    permanent_address_bn: '',
                    mobile: '',
                    garden_owner_nationality: 1
                }
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
            proprietorTypeList () {
                return [
                    { text: this.currentLocale === 'en' ? 'Owner' : 'মালিক', value: 1, text_en: 'Owner', text_bn: 'মালিক' },
                    { text: this.currentLocale === 'en' ? 'Share holder' : 'শেয়ারহোল্ডার', value: 2, text_en: 'Share holder', text_bn: 'শেয়ারহোল্ডার' },
                    { text: this.currentLocale === 'en' ? 'Directors' : 'পরিচালকগণ', value: 3, text_en: 'Directors', text_bn: 'পরিচালকগণ' }
                ]
            },
            nationalityList () {
                return [
                    { text: this.currentLocale === 'en' ? 'Bangladeshi' : 'বাংলাদেশী', value: 1, text_en: 'Bangladeshi', text_bn: 'বাংলাদেশী' },
                    { text: this.currentLocale === 'en' ? 'Others' : 'অন্যান্য', value: 2, text_en: 'Others', text_bn: 'অন্যান্য' }
                ]
            }
        },
        watch: {
        },
        methods: {
            async submit () {
                if (!this.formData.owners.length) {
                    return this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: 'Please add owner info',
                        color: '#ee5253'
                    })
                }
                var check = await this.$refs.form.validate()
                if (check) {
                    this.$store.dispatch('mutateCommonProperties', { loading: true })
                    const loadingState = { loading: false, listReload: false }
                    let result
                    const data = Object.assign({}, this.formData, { status: this.status })
                    if (this.formData.id) {
                        result = await RestApi.putData(teaGardenServiceBaseUrl, proprietorIdentityUpdateApi + '/' + this.formData.id, data)
                    } else {
                        result = await RestApi.postData(teaGardenServiceBaseUrl, proprietorIdentityStoreApi, data)
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
            addDataItem () {
                if (this.formDataAddMore.garden_owner_name_en && this.formDataAddMore.garden_owner_name_bn && this.formDataAddMore.mobile) {
                    const objExist = this.formData.owners.find(item => ((item.garden_owner_name_en === this.formDataAddMore.garden_owner_name_en.trim()) || (item.garden_owner_name_bn === this.formDataAddMore.garden_owner_name_bn.trim())) && item.mobile === this.formDataAddMore.mobile.trim())
                    if (objExist !== undefined) {
                        return this.$toast.error({
                            title: 'Error',
                            message: 'This owner info already exists',
                            color: '#ee5253'
                        })
                    }
                    this.formData.owners.push(this.formDataAddMore)
                    this.formDataAddMore = Object.assign({}, {
                        garden_owner_name_en: '',
                        garden_owner_name_bn: '',
                        garden_owner_father_name_en: '',
                        garden_owner_father_name_bn: '',
                        garden_owner_mother_name_en: '',
                        garden_owner_mother_name_bn: '',
                        permanent_address_en: '',
                        mobile: '',
                        garden_owner_nationality: 1
                    })
                } else {
                    this.$toast.error({
                        title: 'Error',
                        message: 'Please fill owner information correctly',
                        color: '#ee5253'
                    })
                }
            },
            deleteItem (index) {
                this.formData.owners.splice(index, 1)
            },
            getNationalityName (id) {
                const obj = this.nationalityList.find(item => item.value === id)
                return obj?.text
            }
        }
    }
</script>
