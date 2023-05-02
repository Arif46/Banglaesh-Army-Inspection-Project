<template>
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
              <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
                        <b-form-group slot-scope="{ valid, errors }" label-for="garden_id">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.select_garden') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select plain v-model="sectionMain.garden_id" :options="teaGardenGenInfoList" id="garden_id"
                                :state="errors[0] ? false : (valid ? true : null)">
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                    </b-col>
                    <!-- section start here-->
                    <div>
                        <div>
                            <h6 class="card-title" style="width: 100%"> {{ $t('teaGardenConfig.section_details') }}</h6>
                        </div>
                        <b-table-simple style="width: 100%" bordered>
                            <b-tr>
                                <b-th class="text-center"> {{ $t('teaGardenConfig.section') }} {{ $t('globalTrans.en') }}  <span class="text-danger">*</span></b-th>
                                <b-th class="text-center"> {{ $t('teaGardenConfig.section') }} {{ $t('globalTrans.bn') }}  <span class="text-danger">*</span></b-th>
                                <b-th class="text-center"> {{ $t('globalTrans.action') }}</b-th>
                            </b-tr>
                            <template v-if="sectionMain.details.length">
                                <template v-for="(item, index) in sectionMain.details">
                                    <b-tr :key="index">
                                        <b-td style="padding: 0px 5px;">
                                            <ValidationProvider name="Section (En)" :vid="'section_en.'+index" rules="required">
                                                <b-form-group class="mb-0" :label-for="'section_en.'+index" slot-scope="{ valid, errors }">
                                                    <b-form-input :id="'section_en.'+index" v-model="item.section_en"
                                                        :placeholder="$t('teaGardenConfig.section')"
                                                        :state="errors[0] ? false : (valid ? true : null)">
                                                    </b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-td>
                                        <b-td style="padding: 0px 5px;">
                                            <ValidationProvider name="Section (Bn)" :vid="'section_bn.'+index" rules="required">
                                                <b-form-group class="mb-0" :label-for="'section_bn.'+index" slot-scope="{ valid, errors }">
                                                    <b-form-input :id="'section_bn.'+index" v-model="item.section_bn"
                                                        :placeholder="$t('teaGardenConfig.section')"
                                                        :state="errors[0] ? false : (valid ? true : null)">
                                                    </b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-td>
                                        <b-td>
                                            <b-button @click="addSection" v-if="index === Object.keys(sectionMain.details).length - 1" class="btn btn-sm btn-success mr-1">+</b-button>
                                            <b-button @click="removeSection(index)" class="btn btn-sm btn-danger"
                                                v-if="Object.keys(sectionMain.details).length > 1">-</b-button>
                                        </b-td>
                                    </b-tr>
                                </template>
                            </template>
                        </b-table-simple>
                    </div>
                    <!-- section details end here-->
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Description (En)" vid="description_en">
                        <b-form-group label-for="description_en">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                            </template>
                            <b-form-textarea id="description_en" v-model="sectionMain.description_en"
                                :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Description (Bn)" vid="description_bn">
                        <b-form-group label-for="description_bn">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                            </template>
                            <b-form-textarea id="description_bn" v-model="sectionMain.description_bn"
                                :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="text-right">
                <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                    <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{
                    $t('globalTrans.cancel') }}</b-button>
                </b-col>
              </b-row>
        </b-form>
    </b-overlay>
</ValidationObserver>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { sectionMainStoreApi, sectionMainUpdateApi } from '../../api/routes'
export default {
    name: 'Form',
    props: ['id'],
    data () {
        return {
            valid: null,
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            errors: [],
            sectionMain: {
                garden_id: 0,
                description_en: '',
                description_bn: '',
                details: [
                    {
                        section_en: '',
                        section_bn: ''
                    }
                ]
            }
        }
    },
    created () {
        if (this.id) {
            const tmp = this.getSectionMain()
            this.sectionMain = tmp
        }
    },
    computed: {
        loading: function () {
            return this.$store.state.commonObj.loading
        },
        currentLocale () {
            return this.$i18n.locale
        },
        teaGardenGenInfoList: function () {
            return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
        }
    },
    methods: {
        async saveUpdate () {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadingState = { loading: false, listReload: false }
            if (this.id) {
                result = await RestApi.putData(teaGardenServiceBaseUrl, `${sectionMainUpdateApi}/${this.id}`, this.sectionMain)
            } else {
                result = await RestApi.postData(teaGardenServiceBaseUrl, sectionMainStoreApi, this.sectionMain)
            }

            loadingState.listReload = true
            this.$store.dispatch('mutateCommonProperties', loadingState)

            if (result.success) {
                this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
                this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })

                this.$bvModal.hide('modal-form')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
        },
        getSectionMain () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        addSection () {
            this.sectionMain.details.push(
                {
                    section_en: '',
                    section_bn: ''
                }
            )
        },
        removeSection (index) {
            this.sectionMain.details.splice(index, 1)
        }
    }
}
</script>
