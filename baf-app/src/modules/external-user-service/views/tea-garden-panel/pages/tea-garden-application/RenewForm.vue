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
                        <tab-content :title="$t('teaGardenConfig.garden_info')" icon="ri-file-cloud-line" :before-change="tabSubmitGardenInfo" >
                            <GardenInfoForm :key="formData.id" :tabFormData.sync="formData" ref="garden_info_form" :status.sync="status" :parentId.sync="parentId" :isRenew="true"/>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.identity_info')" icon="ri-contacts-line"  :before-change="tabSubmitProprietorQuantity">
                            <ProprietorInfoForm :key="formData.proprietor_identity" :tabFormData="formData.proprietor_identity" ref="proprietor_info_form" :status.sync="status" :isRenew="true"/>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.landlease_info')" icon="ri-play-list-add-line" :before-change="tabSubmitLandOwnerShipInfo">
                           <LandOwnershipInfoForm :key="formData.land_ownership_info" :tabFormData.sync="formData.land_ownership_info" ref="land_ownership_form" :status.sync="status" :parentId.sync="parentId" :isRenew="true" />
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.other_info')" icon="ri-map-pin-2-fill" :before-change="tabSubmitOtherInfo">
                            <OthersInfoForm :key="formData.other_info" :tabFormData="formData.other_info" ref="others_info_form" :status.sync="status" />
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.witness_info')" icon="ri-list-settings-line" :before-change="tabSubmitWitnessInfo">
                            <WitnessInfoForm :key="formData.witness_info" :tabFormData="formData.witness_info" ref="witness_info_form" :status.sync="status" :isRenew="true" />
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-light ml-1 mr-1" @click.native="props.prevTab()" v-if="props.activeTabIndex > 0" style="background: #eee"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</wizard-button>
                                <wizard-button
                                    type="submit"
                                    class="btn btn-primary ml-1 mr-1"
                                    title="Create Draft and Save!"
                                    @click.native="props.nextTab(), status = 2"
                                    v-if="showDraftButton"
                                ><i class="ri-draft-line"></i> {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button
                                    type="submit"
                                    v-if="!props.isLastStep"
                                    @click.native="props.nextTab(), status = 1"
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
                                    @click.native="props.nextTab(), status = 1"
                                ><i class="ri-send-plane-fill"></i> {{ $t('globalTrans.submit')}}
                                </wizard-button>
                                <wizard-button
                                    type="button"
                                    class="btn btn-danger ml-1 mr-1"
                                    title="Cancel"
                                >
                                    <router-link to="/tea-garden-panel/tea-garden-application" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
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
    import GardenInfoForm from './GardenInfoForm'
    import ProprietorInfoForm from './ProprietorInfoForm'
    import LandOwnershipInfoForm from './LandOwnershipInfoForm'
    import OthersInfoForm from './OthersInfoForm'
    import WitnessInfoForm from './WitnessInfoForm'
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { gardenInfoShowApi } from '../../api/routes'
    export default {
        components: { BreadCumb, FormWizard, TabContent, WizardButton, GardenInfoForm, ProprietorInfoForm, LandOwnershipInfoForm, OthersInfoForm, WitnessInfoForm },
        data () {
            return {
                app_id: this.$route.query.id,
                activeIndex: 0,
                formData: {
                    id: 0,
                    applicant_name_en: '',
                    applicant_name_bn: '',
                    designation_en: '',
                    designation_bn: '',
                    tea_garden_name_en: '',
                    tea_garden_name_bn: '',
                    area_type_id: 0,
                    division_id: 0,
                    district_id: 0,
                    city_corporation_id: 0,
                    upazila_id: 0,
                    paurashoba_id: 0,
                    union_id: 0,
                    ward_id: 0,
                    post_code: '',
                    address_en: '',
                    address_bn: '',
                    have_other_tea_garden: 1,
                    has_investing_capability: 1,
                    income_tax_amount: '',
                    bank_solvency_certificate: '',
                    reason_of_rejection: '',
                    trade_license_no: '',
                    chief_executive_name_en: '',
                    chief_executive_name_bn: '',
                    mobile: '',
                    email: '',
                    others: [],
                    proprietor_identity: {
                        id: 0,
                        garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
                        company_name_en: '',
                        company_name_bn: '',
                        proprietor_type: 1,
                        experience_en: '',
                        experience_bn: '',
                        status: 2,
                        owners: []
                    },
                    land_ownership_info: {
                        id: 0,
                        garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
                        ownership_acquired_type: 1,
                        year_of_granting_lease: '',
                        period_of_lease: '',
                        total_grant_area: '',
                        area_under_tea: '',
                        total_suitable_land: '',
                        total_unsuitable_land: '',
                        favour_garden_land_en: '',
                        favour_garden_land_bn: '',
                        mouja: '',
                        khotian_no: '',
                        dag_no: '',
                        garden_sketch_map: '',
                        land_schedule_copy: '',
                        khotian_attested_copy: '',
                        registered_deed_attested_copy: '',
                        year_plantation: '',
                        year_production: '',
                        average_production: '',
                        average_sale_price: '',
                        appointed_broker_name_en: '',
                        appointed_broker_name_bn: '',
                        does_garden_possesses_factory: 1,
                        production_capacity: '',
                        transformer_capacity: '',
                        withering_capacity: '',
                        status: 2
                    },
                    other_info: {
                        id: 0,
                        garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
                        has_residence_facilities: 1,
                        has_school_facilities: 1,
                        has_hospital_facilities: 1,
                        has_mosque_facilities: 1,
                        has_club_facilities: 1,
                        has_drinking_water_facilities: 1,
                        no_of_officers: '',
                        no_of_stuffs: '',
                        no_of_workers: '',
                        status: 2
                    },
                    witness_info: {
                        id: 0,
                        garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
                        first_witness_name_en: '',
                        first_witness_name_bn: '',
                        first_witness_address_en: '',
                        first_witness_address_bn: '',
                        second_witness_name_en: '',
                        second_witness_name_bn: '',
                        second_witness_address_en: '',
                        second_witness_address_bn: '',
                        are_agree: false,
                        status: 2
                    }
                },
                status: 2,
                showDraftButton: true,
                parentId: 0
            }
        },
        created () {
            this.formData = this.getInitialData()
            this.parentId = this.formData.application.id
            this.formData = Object.assign({}, this.formData, { id: 0 })
            this.formData.others = this.formData.others.map(item => {
                return Object.assign({}, item, { id: 0, garden_info_id: 0 })
            })
            this.formData.proprietor_identity = Object.assign(
              {},
              this.formData.proprietor_identity,
              { id: 0, garden_info_id: 0 }
            )
            this.formData.proprietor_identity.owners = this.formData.proprietor_identity.owners.map(item => {
                return Object.assign({}, item, { id: 0, proprietor_identity_id: 0 })
            })
            this.formData.land_ownership_info = Object.assign(
              {},
              this.formData.land_ownership_info,
              { id: 0, garden_info_id: 0 }
            )
            this.formData.other_info = Object.assign(
              {},
              this.formData.other_info,
              { id: 0, garden_info_id: 0 }
            )
            this.formData.witness_info = Object.assign(
              {},
              this.formData.witness_info,
              { id: 0, garden_info_id: 0 }
            )
            if (this.$route.query.id) {
                this.isLoading = true
                this.app_id = this.$route.query.id
                this.getFormData()
            } else {
                this.isLoading = false
            }
        },
        computed: {
            loading: function () {
                return this.$store.state.commonObj.loading
            }
            // parentId () {
            //     return this.$route.params.id ? parseInt(this.$route.params.id) : 0
            // }
        },
        watch: {
            activeIndex: function (newVal) {
                this.setDraftButtonStatus(newVal)
            }
        },
        methods: {
            setDraftButtonStatus (activeTabIndex) {
                if (activeTabIndex === 0) {
                    if (this.formData.id > 0 && this.formData.status === 1) {
                        this.showDraftButton = false
                    } else {
                        this.showDraftButton = true
                    }
                } else if (activeTabIndex === 1) {
                    if (this.formData.proprietor_identity.id > 0 && this.formData.proprietor_identity.status === 1) {
                    this.showDraftButton = false
                    } else {
                    this.showDraftButton = true
                    }
                } else if (activeTabIndex === 2) {
                    if (this.formData.land_ownership_info.id > 0 && this.formData.land_ownership_info.status === 1) {
                        this.showDraftButton = false
                    } else {
                        this.showDraftButton = true
                    }
                } else if (activeTabIndex === 3) {
                    if (this.formData.other_info.id > 0 && this.formData.other_info.status === 1) {
                    this.showDraftButton = false
                    } else {
                    this.showDraftButton = true
                    }
                } else if (activeTabIndex === 4) {
                    if (this.formData.witness_info.id > 0 && this.formData.witness_info.status === 1) {
                    this.showDraftButton = false
                    } else {
                    this.showDraftButton = true
                    }
                } else {
                    this.showDraftButton = true
                }
            },
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
            getInitialData () {
                const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.params.id))
                return JSON.parse(JSON.stringify(tmpData))
            },
            async getFormData () {
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const result = await RestApi.getData(teaGardenServiceBaseUrl, gardenInfoShowApi + '/' + this.app_id)
                if (result.success) {
                    if (result.data.proprietor_identity) {
                        this.formData = Object.assign({}, this.formData, { proprietor_identity: result.data.proprietor_identity })
                    }
                    if (result.data.land_ownership_info) {
                        this.formData = Object.assign({}, this.formData, { land_ownership_info: result.data.land_ownership_info })
                    }
                    if (result.data.other_info) {
                        this.formData = Object.assign({}, this.formData, { other_info: result.data.other_info })
                    }
                    if (result.data.witness_info) {
                        this.formData = Object.assign({}, this.formData, { witness_info: result.data.witness_info })
                    }
                    delete result.data.proprietor_identity
                    delete result.data.land_ownership_info
                    delete result.data.other_info
                    delete result.data.witness_info
                    this.formData = Object.assign({}, this.formData, result.data)
                    this.isLoading = false
                    this.setDraftButtonStatus(this.activeIndex)
                }
                this.$store.dispatch('mutateCommonProperties', { loading: false })
            },
            async tabOwnerInfo () {
                const result = await this.$refs.owner_info_form.submit()
                if (result.success) {
                    if (this.draft) {
                        this.$router.push({ path: 'tea-farmer-application' })
                    } else {
                        this.$router.push({ path: 'tea-farmer-application' })
                    }
                }
            },
            async tabSubmitGardenInfo () {
                const result = await this.$refs.garden_info_form.submit()
                if (result.success) {
                    this.formData = Object.assign({}, this.formData, result.model)
                    if (!this.$route.query.id) {
                        this.formData.proprietor_identity = Object.assign(
                            {},
                            this.formData.proprietor_identity,
                            { garden_info_id: result.model.id }
                        )
                        this.formData.land_ownership_info = Object.assign(
                            {},
                            this.formData.land_ownership_info,
                            { garden_info_id: result.model.id }
                        )
                        this.formData.other_info = Object.assign(
                            {},
                            this.formData.other_info,
                            { garden_info_id: result.model.id }
                        )
                        this.formData.witness_info = Object.assign(
                            {},
                            this.formData.witness_info,
                            { garden_info_id: result.model.id }
                        )
                    }
                    if (this.status === 1) {
                        return true
                    }
                }
            },
            async tabSubmitProprietorQuantity () {
                const result = await this.$refs.proprietor_info_form.submit()
                if (result.success) {
                    this.formData.proprietor_identity = Object.assign(
                    {},
                    this.formData.proprietor_identity,
                    { id: result.model.id }
                    )
                    if (this.status === 1) {
                        return true
                    }
                }
            },
            async tabSubmitLandOwnerShipInfo () {
                const result = await this.$refs.land_ownership_form.submit()
                if (result.success) {
                    this.formData.land_ownership_info = Object.assign(
                    {},
                    this.formData.land_ownership_info,
                    { id: result.model.id }
                    )
                    if (this.status === 1) {
                        return true
                    }
                }
            },
            async tabSubmitOtherInfo () {
                const result = await this.$refs.others_info_form.submit()
                if (result.success) {
                    this.formData.other_info = Object.assign(
                    {},
                    this.formData.other_info,
                    { id: result.model.id }
                    )
                    if (this.status === 1) {
                        return true
                    }
                }
            },
            async tabSubmitWitnessInfo () {
                const result = await this.$refs.witness_info_form.submit()
                if (result.success) {
                    this.formData.witness_info = Object.assign(
                        {},
                        this.formData.witness_info,
                        { id: result.model.id }
                    )
                    if (this.status === 1) {
                        if (result.is_payment) {
                        const baseTableId = result.base_table_id
                        this.$router.push({ name: 'tea_garden_panel.payment', params: { id: baseTableId }, query: { from: 'tea_garden_panel.tea_garden_application' } })
                        } else {
                            this.$router.push({ name: 'tea_garden_panel.tea_garden_application' })
                        }
                    }
                }
            }
        }
    }
</script>
