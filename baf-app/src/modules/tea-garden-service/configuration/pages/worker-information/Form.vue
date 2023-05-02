<template>
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                    <!-- garden name -->
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
                        <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="garden_id">
                            <template v-slot:label>
                            {{ $t('teaGardenConfig.select_garden') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                                plain
                                v-model="workerInformation.garden_id"
                                :options="teaGardenGenInfoList"
                                id="garden_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="PF ID" vid="pf_id" rules="required">
                            <b-form-group slot-scope="{ valid, errors }" label-for="pf_id">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.pf_id') }}  <span class="text-danger">*</span>
                                </template>
                                <b-form-input id="pf_id" v-model="workerInformation.pf_id"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Worker Name (En)" vid="worker_name_en" rules="required">
                            <b-form-group  slot-scope="{ valid, errors }" label-for="worker_name_en">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.worker_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input id="worker_name" v-model="workerInformation.worker_name_en"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Worker Name(Bn)" vid="worker_name_bn" rules="required">
                            <b-form-group slot-scope="{ valid, errors }" label-for="worker_name_bn">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.worker_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input id="worker_name_bn" v-model="workerInformation.worker_name_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="designation" vid="designation_id" rules="required|min_value:1">
                            <b-form-group slot-scope="{ valid, errors }" label-for="designation_id">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.designation') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select plain v-model="workerInformation.designation_id" :options="designationList" id="designation_id"
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Father Name(En)" vid="father_name_en" rules="required">
                            <b-form-group slot-scope="{ valid, errors }" label-for="father_name_en">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.father_name') }} {{ $t('globalTrans.en') }} <span
                                        class="text-danger">*</span>
                                </template>
                                <b-form-input id="father_name_en" v-model="workerInformation.father_name_en"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Father Name(Bn)" vid="father_name_bn" rules="required">
                            <b-form-group slot-scope="{ valid, errors }" label-for="father_name_bn">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.father_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input id="father_name_bn" v-model="workerInformation.father_name_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Worker Type" vid="worker_type" rules="required|min_value:1">
                            <b-form-group slot-scope="{ valid, errors }" label-for="worker_type">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.worker_type') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select plain v-model="workerInformation.worker_type" :options="customWorkerTypeList" id="worker_type"
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Gender" vid="gender" rules="required|min_value:1">
                            <b-form-group slot-scope="{ valid, errors }" label-for="gender">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.gender') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select plain v-model="workerInformation.gender" :options="genderList" id="gender"
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Address (En)" vid="address_en">
                            <b-form-group label-for="address_en">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.en') }}
                                </template>
                                <b-form-textarea id="address_en" v-model="workerInformation.address_en"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Address (Bn)" vid="address_bn">
                            <b-form-group label-for="address_bn">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.bn') }}
                                </template>
                                <b-form-textarea id="address_bn" v-model="workerInformation.address_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="NID" vid="nid" rules="required|min:10|max:17">
                            <b-form-group slot-scope="{ valid, errors }" label-for="nid">
                                <template v-slot:label>
                                    {{ $t('teaGardenConfig.nid') }}
                                </template>
                                <b-form-input type="number" min="0" id="nid" v-model="workerInformation.nid"
                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Mobile No" vid="mobile" rules="required|min:11|max:11">
                        <b-form-group slot-scope="{ valid, errors }" label-for="mobile">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.mobile') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input id="mobile" v-model="workerInformation.mobile"
                                :state="errors[0] ? false : (valid ? true : null)" ></b-form-input>
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
import { workerinformationStoreApi, workerinformationUpdateApi, getPfIdApi } from '../../api/routes'
export default {
    name: 'Form',
    props: ['id'],
    data () {
        return {
            valid: null,
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            errors: [],
            workerInformation: {
                id: '',
                designation_id: 0,
                garden_id: 0,
                pf_id: '',
                worker_name_en: '',
                worker_name_bn: '',
                father_name_en: '',
                father_name_bn: '',
                nid: '',
                mobile: '',
                gender: 0,
                worker_type: 0,
                address_en: '',
                address_bn: ''
            }
        }
    },
    created () {
        if (this.id) {
            const tmp = this.getworkerInformation()
            this.workerInformation = tmp
        } else {
            this.getPfId()
        }
    },
    computed: {
        loading: function () {
            return this.$store.state.commonObj.loading
        },
        customWorkerTypeList: function () {
            return this.$store.state.TeaGardenService.commonObj.workerType
        },
        designationList: function () {
            return this.$store.state.TeaGardenService.commonObj.masterDesignationList
        },
        genderList: function () {
            return this.$store.state.TeaGardenService.commonObj.gender
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
                result = await RestApi.putData(teaGardenServiceBaseUrl, `${workerinformationUpdateApi}/${this.id}`, this.workerInformation)
            } else {
                result = await RestApi.postData(teaGardenServiceBaseUrl, workerinformationStoreApi, this.workerInformation)
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
        async getPfId () {
            let result = null
            result = await RestApi.getData(teaGardenServiceBaseUrl, getPfIdApi)
            if (result) {
                this.workerInformation.pf_id = result
            }
        },
        getworkerInformation () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        }
    }
}
</script>
