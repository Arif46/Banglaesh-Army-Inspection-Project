<template>
    <div class="inner-section application-form-wrapper">
        <bread-cumb />
        <!-- <div class="form-wrapper application-form-wrapper"> -->
            <body-card>
                <template v-slot:headerTitle>
                    <h4 class="card-title">{{ $t('teaGardenPanel.tea_garden_app_title') }}</h4>
                </template>
                <template v-slot:body>
                    <b-overlay :show="loading">
                    <form-wizard shape="circle" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('teaGardenPduService.applicant_info')" icon="ri-file-cloud-line" :before-change="tabSubmitApplicantInfo" >
                            <ApplicantInfoForm :key="formData.id" :tabFormData.sync="formData" ref="garden_info_form" :status.sync="status"/>
                        </tab-content>
                        <tab-content :title="$t('teaGardenPduService.other_info')" icon="ri-map-pin-2-fill" :before-change="tabSubmitOtherInfo">
                            <OthersInfoForm :key="formData.id" :tabFormData="formData" ref="others_info_form" :status.sync="status" :isUpdate="isUpdateRequest" />
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-light ml-1 mr-1" @click.native="props.prevTab()" v-if="props.activeTabIndex > 0" style="background: #eee"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</wizard-button>
                                <wizard-button
                                    type="submit"
                                    class="btn btn-primary ml-1 mr-1"
                                    title="Create Draft and Save!"
                                    @click.native="props.nextTab(), status = 1"
                                ><i class="ri-draft-line"></i> {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button
                                    type="submit"
                                    v-if="!props.isLastStep"
                                    @click.native="props.nextTab(), status = 2"
                                    class="btn btn-success ml-1 mr-1"
                                    title="Draft and go to next!"
                                    :style="props.fillButtonStyle"
                                ><i class="ri-save-2-line"></i> {{ $t('priceMonitoring.save_next') }}
                                </wizard-button>
                                <wizard-button
                                    v-else
                                    type="submit"
                                    class="btn btn-success ml-1"
                                    title="Submit!"
                                    @click.native="props.nextTab(), status = 2"
                                ><i class="ri-send-plane-fill"></i> {{ $t('globalTrans.submit')}}
                                </wizard-button>
                                <wizard-button
                                    type="button"
                                    class="btn btn-danger ml-1 mr-1"
                                    title="Cancel"
                                >
                                    <router-link to="course-application" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
                                </wizard-button>
                            </div>
                        </template>
                    </form-wizard>
                    </b-overlay>
                </template>
            </body-card>
        <!-- </div> -->
    </div>
</template>
<script>
    import BreadCumb from '@/components/BreadCumb.vue'
    import { FormWizard, TabContent } from 'vue-form-wizard'
    import 'vue-form-wizard/dist/vue-form-wizard.min.css'
    import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
    import ApplicantInfoForm from './ApplicantInfoForm'
    import OthersInfoForm from './OthersInfoForm'
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { applicantInfoShowApi } from '../../api/routes'
    export default {
        components: { BreadCumb, FormWizard, TabContent, WizardButton, ApplicantInfoForm, OthersInfoForm },
        data () {
            return {
                app_id: this.$route.query.id,
                activeIndex: 0,
                formData: {
                    id: 0,
                    circular_id: 0,
                    circular_name_en: '',
                    circular_name_bn: '',
                    applicant_name_en: '',
                    applicant_name_bn: '',
                    father_name_en: '',
                    father_name_bn: '',
                    mother_name_en: '',
                    mother_name_bn: '',
                    nationality: '',
                    date_of_birth: '',
                    pr_area_type_id: 0,
                    pr_division_id: 0,
                    pr_district_id: 0,
                    pr_city_corporation_id: 0,
                    pr_upazila_id: 0,
                    pr_pauroshoba_id: 0,
                    pr_union_id: 0,
                    pr_ward_id: 0,
                    pr_post_code: '',
                    pr_address_en: '',
                    pr_address_bn: '',
                    is_same_as_present: 0,
                    pm_area_type_id: 0,
                    pm_division_id: 0,
                    pm_district_id: 0,
                    pm_city_corporation_id: 0,
                    pm_upazila_id: 0,
                    pm_pauroshoba_id: 0,
                    pm_union_id: 0,
                    pm_ward_id: 0,
                    pm_post_code: '',
                    pm_address_en: '',
                    pm_address_bn: '',
                    expense_type: null,
                    company_name_en: null,
                    company_name_bn: null,
                    company_adsress_en: null,
                    company_adsress_bn: null,
                    sponsor_noc: '',
                    contact_no: '',
                    email: '',
                    educational_infos: [],
                    employment_infos: []
                },
                status: 1,
                showDraftButton: true,
                isUpdateRequest: false
            }
        },
        created () {
            if (this.$route.query.id) {
                this.isLoading = true
                this.app_id = this.$route.query.id
                this.getFormData()
            } else {
                this.isLoading = false
                if (this.$route.query.circular_id) {
                    this.formData.circular_id = this.$route.query.circular_id
                    this.setCircularName(this.$route.query.circular_id)
                }
            }
        },
        computed: {
            loading: function () {
                return this.$store.state.commonObj.loading
            }
        },
        watch: {
            activeIndex: function (newVal) {
                // this.setDraftButtonStatus(newVal)
            }
        },
        methods: {
            // setDraftButtonStatus (activeTabIndex) {
            //     if (activeTabIndex === 0) {
            //         if (this.formData.id > 0 && this.formData.status === 1) {
            //             this.showDraftButton = false
            //         } else {
            //             this.showDraftButton = true
            //         }
            //     } else {
            //         if (this.formData.proprietor_identity.id > 0 && this.formData.proprietor_identity.status === 1) {
            //             this.showDraftButton = false
            //         } else {
            //             this.showDraftButton = true
            //         }
            //     }
            // },
            finalSave () {
                this.$swal({
                    title: this.$t('globalTrans.final_save_msg'),
                    showCancelButton: true,
                    confirmButtonText: this.$t('globalTrans.yes'),
                    cancelButtonText: this.$t('globalTrans.no'),
                    focusConfirm: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.tabOwnerInfo()
                    } else {
                        this.app_status = 1
                    }
                })
            },
            setCircularName (id, lang = null) {
                const obj = this.$store.state.TeaGardenService.commonObj.pduCircularList.find(item => item.value === parseInt(id))
                this.formData.circular_name_en = obj?.text_en
                this.formData.circular_name_bn = obj?.text_bn
            },
            async getFormData () {
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const result = await RestApi.getData(teaGardenServiceBaseUrl, applicantInfoShowApi + '/' + this.app_id)
                if (result.success) {
                    // if (result.data.other_info) {
                    //     this.formData = Object.assign({}, this.formData, { other_info: result.data.other_info })
                    // }
                    // delete result.data.other_info
                    this.formData = Object.assign({}, this.formData, result.data)
                    if (this.formData.educational_infos.length) {
                        this.isUpdateRequest = true
                    }
                    this.setCircularName(this.formData.circular_id)
                    this.isLoading = false
                    // this.setDraftButtonStatus(this.activeIndex)
                }
                this.$store.dispatch('mutateCommonProperties', { loading: false })
            },
            async tabSubmitApplicantInfo () {
                // if (this.status === 2) {
                //     return true
                // }
                const result = await this.$refs.garden_info_form.submit()
                if (result.success) {
                    this.formData = Object.assign({}, this.formData, result.model)
                    if (!this.$route.query.id) {
                        this.formData = Object.assign(
                            {},
                            this.formData,
                            result.model
                        )
                    }
                    if (this.status === 2) {
                        return true
                    }
                }
            },
            async tabSubmitOtherInfo () {
                const result = await this.$refs.others_info_form.submit()
                if (result.success) {
                    this.formData = Object.assign(
                    {},
                        this.formData,
                        result.model
                    )
                    this.formData.educational_infos = Object.assign(
                      {},
                      this.formData.educational_infos,
                      result.model.educational_infos
                    )
                    this.formData.employment_infos = Object.assign(
                      {},
                      this.formData.employment_infos,
                      result.model.employment_infos
                    )
                    this.isUpdateRequest = true
                    if (this.status === 2) {
                        return this.$router.push({ path: 'course-application' })
                    }
                }
            }
        }
    }
</script>
