<template>
    <ValidationObserver ref="form2"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(addItem)" @reset.prevent="reset">
            <b-overlay :show="unitLoad">
                <!-- <b-row class="mb-3">
                    <div class="bg-dark w-50 m-auto rounded-pill">
                        <h6 class="text-white text-center py-1"> {{ $t('externalTradeFair.representative_data') }}</h6>
                    </div>
                </b-row> -->
                <div class="application-form-wrapper">
                    <div class="application-itmes">
                        <b-row>
                            <b-col sm="12">
                                <div class="group-form-card">
                                    <b-card>
                                        <b-form-group label-cols-lg="3"
                                            :label="$t('externalTradeFair.representative_data')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                            <b-row>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Name (En)" vid="repres_name_en" rules="required" v-slot="{ errors }">
                                                        <b-form-group label-for="repres_name_en">
                                                            <template v-slot:label>
                                                                {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                            </template>
                                                            <b-form-input v-model="detail_obj.repres_name_en"
                                                                :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                            <div class="invalid-feedback">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Name (Bn)" vid="repres_name_bn" rules="required" v-slot="{ errors }">
                                                        <b-form-group label-for="repres_name_bn">
                                                            <template v-slot:label>
                                                                {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                            </template>
                                                            <b-form-input v-model="detail_obj.repres_name_bn"
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
                                                            <b-form-input v-model="detail_obj.designation_en"
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
                                                            <b-form-input v-model="detail_obj.designation_bn"
                                                                :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                            <div class="invalid-feedback">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Nationality (En)" vid="nationality_en" rules="required" v-slot="{ errors }">
                                                        <b-form-group label-for="nationality_en">
                                                            <template v-slot:label>
                                                                {{ $t('globalTrans.nationality') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                            </template>
                                                            <b-form-input v-model="detail_obj.nationality_en"
                                                                :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                            <div class="invalid-feedback">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Nationality (En)" vid="nationality_bn" rules="required" v-slot="{ errors }">
                                                        <b-form-group label-for="nationality_bn">
                                                            <template v-slot:label>
                                                                {{ $t('globalTrans.nationality') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                            </template>
                                                            <b-form-input v-model="detail_obj.nationality_bn"
                                                                :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                            <div class="invalid-feedback">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Passport No." vid="passport_no" rules="required" v-slot="{ errors }">
                                                        <b-form-group label-for="passport_no">
                                                            <template v-slot:label>
                                                                {{ $t('externalUser.passport_no') }}
                                                            </template>
                                                            <b-form-input v-model="detail_obj.passport_no"
                                                                :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                            <div class="invalid-feedback">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Travelled Country" vid="travelled_country" rules="required|min_value:1"
                                                        v-slot="{ errors }">
                                                        <b-form-group label-for="travelled_country">
                                                            <template v-slot:label>
                                                                {{$t('externalTradeFair.country_travelled')}} <span class="text-danger">*</span>
                                                            </template>
                                                            <v-select multiple :reduce="op => op.value" v-model="detail_obj.travelled_country" :options="countryList" :state="errors[0] ? false : (valid ? true : null)" label='text' :placeholder="$t('globalTrans.select')">
                                                            </v-select>
                                                            <div class="invalid-feedback d-block">
                                                                {{ errors[0] }}
                                                            </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </b-col>
                                                <b-col>
                                                    <div class="text-right">
                                                        <b-button type="submit" size="sm" variant="primary" class="mr-1"><i class="ri-add-fill" style="vertical-align: bottom;"></i> {{ editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
                                                        <b-button type="button" v-if="editIndex !== ''" size="sm" variant="danger" @click="cancelItem()"><i class="ri-close-fill" style="vertical-align: bottom;"></i> {{ $t('globalTrans.cancel') }}</b-button>
                                                    </div>
                                                </b-col>
                                            </b-row>
                                        </b-form-group>
                                    </b-card>
                                </div>
                            </b-col>
                        </b-row>
                    </div>
                </div>
                <b-row>
                    <!-- <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Name (En)" vid="repres_name_en" rules="required" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="repres_name_en"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                                v-model="detail_obj.repres_name_en"
                                :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Name (Bn)" vid="repres_name_bn" rules="required" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="repres_name_bn"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                                v-model="detail_obj.repres_name_bn"
                                :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Designation (En)" vid="designation_en" rules="required" v-slot="{ errors }">
                            <b-form-group label-for="designation_en" label-cols-sm="5">
                                <template v-slot:label>
                                    {{ $t('globalTrans.designation')  + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="detail_obj.designation_en"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Designation (Bn)" vid="designation_bn" rules="required" v-slot="{ errors }">
                            <b-form-group label-for="designation_bn" label-cols-sm="5">
                                <template v-slot:label>
                                    {{ $t('globalTrans.designation')  + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="detail_obj.designation_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Nationality (En)" vid="nationality_en" rules="required" v-slot="{ errors }">
                            <b-form-group label-for="nationality_en" label-cols-sm="5">
                                <template v-slot:label>
                                    {{ $t('globalTrans.nationality')  + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="detail_obj.nationality_en"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Nationality (En)" vid="nationality_bn" rules="required" v-slot="{ errors }">
                            <b-form-group label-for="nationality_bn" label-cols-sm="5">
                                <template v-slot:label>
                                    {{ $t('globalTrans.nationality')  + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="detail_obj.nationality_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col> -->
                    <!-- <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Nationality" vid="nationality_id" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group
                            label-for="nationality_id"
                            label-cols-sm="5"
                            >
                            <template v-slot:label>
                                {{$t('globalTrans.nationality')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                                plain
                                v-model="detail_obj.nationality_id"
                                :options="nationalityList"
                                :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col> -->
                    <!-- <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Passport No." vid="passport_no" rules="required" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="passport_no"
                            >
                            <template v-slot:label>
                                {{ $t('externalUser.passport_no') }}
                                </template>
                                <b-form-input
                                    v-model="detail_obj.passport_no"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Travelled Country" vid="travelled_country" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group
                            label-for="travelled_country"
                            label-cols-sm="5"
                            >
                            <template v-slot:label>
                            {{$t('externalTradeFair.country_travelled')}} <span class="text-danger">*</span>
                            </template>
                            <v-select
                                multiple
                                :reduce="op => op.value"
                                v-model="detail_obj.travelled_country"
                                :options="countryList"
                                :state="errors[0] ? false : (valid ? true : null)"
                                label='text'
                                :placeholder="$t('globalTrans.select')"
                            >
                            </v-select>
                            <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                            </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col>
                        <div class="text-right mb-3">
                            <b-button type="button" v-if="editIndex !== ''" variant="danger" class="mr-1" @click="cancelItem()">{{ $t('globalTrans.cancel') }}</b-button>
                            <b-button type="submit" variant="success">{{ editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
                        </div>
                    </b-col> -->
                </b-row>
                <b-row>
                    <b-col xl="12" lg="12" sm="12">
                        <b-table-simple bordered>
                            <thead class="text-white bg-primary">
                                <tr>
                                    <th class="text-center" width="100px">{{ $t('globalTrans.sl_no') }}</th>
                                    <th scope="col">{{ $t('globalTrans.name') }}</th>
                                    <th scope="col">{{ $t('globalTrans.designation') }}</th>
                                    <th scope="col">{{ $t('globalTrans.nationality') }}</th>
                                    <th scope="col">{{ $t('externalUser.passport_no') }}</th>
                                    <th scope="col">{{ $t('externalTradeFair.country_travelled') }}</th>
                                    <th width="15%" class="text-center">{{ $t('globalTrans.action') }}</th>
                                </tr>
                            </thead>
                            <b-tbody>
                                <b-tr v-for="(item, index) in repres" :key="index">
                                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.repres_name_en : item.repres_name_bn }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.designation_en : item.designation_bn }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.nationality_en : item.nationality_bn }}</b-td>
                                    <!-- <b-td>{{ nationalityName(item.nationality_id) }}</b-td> -->
                                    <b-td>{{ item.passport_no }}</b-td>
                                    <b-td>
                                        <span v-for="(itm, indx) in item.travelled_country" :key="indx">
                                            <span>{{ countryName(itm) }}</span><span v-if="indx+1 < item.travelled_country.length">{{ ', ' }}</span>
                                        </span>
                                    </b-td>
                                    <b-td class="text-center">
                                        <b-button @click="editItem(item, index)" title="Edit" class="btn btn-success btn-sm mr-1"><i class="ri-pencil-fill m-0"></i></b-button>
                                        <b-button type="button" @click="deleteItem(index)" title="Delete" class="btn btn-danger" size="sm"><i class="ri-delete-bin-2-line"></i></b-button>
                                    </b-td>
                                </b-tr>
                                <b-tr v-if="repres.length <= 0">
                                    <td colspan="7" class="text-center">
                                        <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                                    </td>
                                </b-tr>
                            </b-tbody>
                        </b-table-simple>
                    </b-col>
                    <b-col xl="12" lg="12" sm="12">
                        <div class="fair-note-wrapper">
                            <span class="note-title">{{ $t('externalTradeFair.note') }}</span>
                            <p v-for="(item, index) in representative_note" :key="index">
                                <span><strong>{{ item.text }}</strong></span>
                            </p>
                        </div>
                    </b-col>
                </b-row>
            </b-overlay>
        </b-form>
    </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartStoreThreeApi } from '../../../api/routes'

export default {
    props: ['app_id', 'representatives'],
    data () {
      return {
        valid: null,
        unitLoad: false,
        editIndex: '',
        repres: [],
        detail_obj: {
            repres_name_en: '',
            repres_name_bn: '',
            designation_en: '',
            designation_bn: '',
            // nationality_id: 0,
            nationality_en: '',
            nationality_bn: '',
            passport_no: '',
            travelled_country: []
        }
      }
    },
    computed: {
        representative_note () {
            const arrayOfEn = [
                { text: '1) Nominated representatives must have adequate technical expertise on the products and communication skill to motivate potential buyers.' },
                { text: '2) In case of replacing any representative after submission of this application, additional fees will be charged.' }
            ]
            const arrayOfBn = [
                { text: '১) সম্ভাব্য ক্রেতাদের অনুপ্রাণিত করার জন্য মনোনীত প্রতিনিধিদের অবশ্যই পণ্যের উপর পর্যাপ্ত প্রযুক্তিগত দক্ষতা এবং যোগাযোগ দক্ষতা থাকতে হবে।' },
                { text: '২) এই আবেদন জমা দেওয়ার পর কোনো প্রতিনিধি প্রতিস্থাপনের ক্ষেত্রে অতিরিক্ত ফি নেওয়া হবে।' }
            ]
            return this.$i18n.locale === 'en' ? arrayOfEn : arrayOfBn
        },
        countryList () {
            return this.$store.state.CommonService.commonObj.countryList.filter(el => el.status === 1)
        },
        // nationalityList () {
        //     return this.$store.state.CommonService.commonObj.countryList.map(el => {
        //         return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.nationality_bn : el.nationality })
        //     })
        // },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    created () {
        if (this.$route.query.id) {
            this.repres = this.representatives.map(el => {
                return Object.assign({}, el, { travelled_country: JSON.parse(el.travelled_country) })
            })
        } else {
            this.repres = [...this.representatives]
        }
    },
    methods: {
        cancelItem () {
            this.detail_obj = {}
            this.editIndex = ''
            this.$refs.form2.reset()
        },
        editItem (item, index) {
            this.detail_obj = Object.assign({}, item)
            // if (!this.$route.query.id) {
                this.detail_obj.travelled_country = item.travelled_country
            // } else {
            //     this.detail_obj.travelled_country = JSON.parse(item.travelled_country)
            // }
            this.editIndex = index
        },
        deleteItem (index) {
            this.repres.splice(index, 1)
        },
        async addItem () {
            let result = []
            if (this.editIndex !== '') {
                const editList = [...this.repres]
                editList.splice(parseInt(this.editIndex), 1)
                result = [...editList]
            } else {
                result = this.repres
            }
            const Name = this.detail_obj.repres_name_en
            const Desig = this.detail_obj.designation_en
            const newData = result.find(item => item.repres_name_en === Name && item.designation_en === Desig)
            if (typeof newData === 'undefined') {
                    if (this.editIndex !== '') {
                        this.repres[parseInt(this.editIndex)] = this.detail_obj
                    } else {
                        this.repres.push(JSON.parse(JSON.stringify(this.detail_obj)))
                    }
                    this.detail_obj = {
                        repres_name_en: '',
                        repres_name_bn: '',
                        designation_en: '',
                        designation_bn: '',
                        // nationality_id: 0,
                        nationality_en: '',
                        nationality_bn: '',
                        passport_no: '',
                        travelled_country: []
                    }
                    this.editIndex = ''
            } else {
                this.$toast.error({
                    title: '!',
                    message: 'Item already added',
                    color: '#ee5253'
                })
            }
            this.$nextTick(() => {
                this.$refs.form2.reset()
            })
        },
        countryName (Id) {
          const Obj = this.$store.state.CommonService.commonObj.countryList.find(item => item.value === parseInt(Id))
          if (typeof Obj !== 'undefined') {
              return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        // nationalityName (Id) {
        //     const Obj = this.$store.state.CommonService.commonObj.countryList.find(item => item.value === parseInt(Id))
        //     if (typeof Obj !== 'undefined') {
        //         return this.$i18n.locale === 'bn' ? Obj.nationality_bn : Obj.nationality
        //     } else {
        //         return ''
        //     }
        // },
        async submit () {
            if (!this.repres.length) {
                return this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: 'Add at least one item!',
                    color: 'red'
                })
            }
            this.unitLoad = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            const loadingState = { loading: false, listReload: false }
            const params = {
                app_id: this.app_id,
                representatives: this.repres
                // repres: JSON.stringify(this.repres)
            }
            const result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartStoreThreeApi, params)
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
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                })
            }
        }
    }
}
</script>
