<template>
  <div class="inner-section">
    <bread-cumb />
    <div class="form-wrapper application-form-wrapper">
        <b-card :title="$t('teaGardenService.tree_disposal_service') + ' ' + ($route.query.id ? $t('globalTrans.update') : $t('globalTrans.apply'))">
            <b-card-text>
                <form-wizard class="garden-forest-resource-cutting-wrapper" shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('teaGardenConfig.garden_info')" icon="ri-file-cloud-line">
                            <div class="application-itmes">
                                 <GardenInfo @change-garden="changeGarden" :key="garden_id_set" :garden_id_set="garden_id_set" :app_id="app_id" :gardenInfoData="gardenInfo" :isShow="dataLoaded" :isGardenAdmin="isGardenAdmin" :baseUrl="baseUrl" ref="garden_info"/>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.tree_details_Category')" icon="ri-file-cloud-line" :before-change="tabTreeDetailsCategory">
                            <div class="application-itmes">
                                 <TreeDetailsCategory :key="garden_id_set" :garden_id_set="garden_id_set" :app_id="app_id" :applicationData="application" :isShow="dataLoaded" :baseUrl="baseUrl" ref="tree_details_category"/>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.purpose_tree_cutting')" icon="ri-contacts-line" :before-change="tabCuttingPurpose">
                            <div class="application-itmes">
                                 <CuttingPurpose :key="garden_id_set" :garden_id_set="garden_id_set" :app_id="app_id" :cuttingPurposeData="application.cutting_purpose" :isShow="dataLoaded" :baseUrl="baseUrl" ref="cutting_purpose"/>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.previous_permission_story')" icon="ri-play-list-add-line">
                            <div class="application-itmes">
                                 <PreviousPermissionStory :key="garden_id_set" :garden_id_set="garden_id_set" :app_id="app_id" :isShow="dataLoaded" :baseUrl="baseUrl" ref="previous_permission_story"/>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.garden_development_planning')" icon="ri-map-pin-2-fill" :before-change="tabDevelopmentPlanning" >
                            <div class="application-itmes">
                                 <DevelopmentPlanning :key="garden_id_set" :garden_id_set="garden_id_set" :app_id="app_id" :developmentPlanningData="application.development_planing" :draft="draft" :isShow="dataLoaded" :baseUrl="baseUrl" ref="development_planning"/>
                            </div>
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-secondary" @click.native="props.prevTab(), step--"  v-if="props.activeTabIndex > 0" :style="props.fillButtonStyle">{{ $t('globalTrans.back') }}</wizard-button>
                                <wizard-button
                                    type="submit"
                                    class="btn btn-primary ml-1 mr-1"
                                    title="Create Draft and Save!"
                                    @click.native="props.nextTab(), draft = 1"
                                >
                                <i class="ri-draft-line"></i> {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button
                                    type="submit"
                                    v-if="!props.isLastStep"
                                    @click.native="props.nextTab(), isNext = true"
                                    class="btn btn-success ml-1 mr-1"
                                    title="Draft and go to next!"
                                    :style="props.fillButtonStyle"
                                ><i class="ri-save-2-line"></i> {{$t('globalTrans.draft_n_next')}}
                                </wizard-button>
                                <wizard-button
                                    v-else
                                    type="submit"
                                    class="btn btn-success ml-1"
                                    title="Submit!"
                                    @click.native="finalSave(), app_status = 2"
                                >
                                <i class="ri-send-plane-fill"></i> {{ $t('globalTrans.finalSave')}}
                                </wizard-button>
                                <wizard-button
                                    type="button"
                                    class="btn btn-danger ml-1 mr-1"
                                    title="Cancel"
                                >
                                    <router-link to="tree-disposal-registration" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
                                </wizard-button>
                            </div>
                        </template>
                </form-wizard>
            </b-card-text>
        </b-card>
    </div>
  </div>
</template>
<script>
// import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import BreadCumb from '@/components/BreadCumb.vue'
import GardenInfo from './GardenInfo'
import TreeDetailsCategory from './TreeDetailsCategory'
import CuttingPurpose from './CuttingPurpose'
import PreviousPermissionStory from './PreviousPermissionStory'
import DevelopmentPlanning from './DevelopmentPlanning'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
import { mapGetters } from 'vuex'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { treeDisposalAppDetailsApi } from '../../api/routes'
export default {
  components: { BreadCumb, GardenInfo, TreeDetailsCategory, CuttingPurpose, PreviousPermissionStory, DevelopmentPlanning, FormWizard, TabContent, WizardButton },
  name: 'Form',
  data () {
    return {
        baseUrl: teaGardenServiceBaseUrl,
        valid: null,
        saveBtnName: this.$t('globalTrans.update'),
        errors: [],
        step: 0,
        activeIndex: 0,
        sectorId: 0,
        isGardenAdmin: false,
        garden_id_set: 0,
        application: {
            app_id: 0,
            garden_id: 0,
            tree_class_of_forest_resources: [],
            unit_quantity: null,
            plantation_year: null,
            number_of_trees: null,
            size: null,
            quantity_approx: null,
            tree_cutting_locations: [],
            development_planing: {
                id: 0,
                tree_cutting_id: 0,
                fiscal_year_id: 0,
                expansion_planting: null,
                re_plantation: null,
                rubber: null,
                afforestation: null,
                other_plants: null
            },
            cutting_purpose: {
                id: 0,
                tree_cutting_id: 1,
                purpose_of_tree_felling: [],
                total_cutable_trees: 0,
                number_of_re_plantable_tree: 0,
                number_of_very_old_trees: 0,
                number_of_rubber_tree: 0,
                number_of_disease_tree: 0,
                number_of_other_trees: 0
            }
        },
        gardenInfo: {
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0
        },
        app_id: 0,
        app_status: 1,
        draft: 0,
        isLoading: false,
        dataLoaded: false
    }
  },
  created () {
    if (this.$route.query.id) {
        this.isLoading = true
        this.app_id = this.$route.query.id
        this.getTreeDisposalData()
    } else {
        this.isLoading = false
    }
    // check garden admin
    this.isGardenAdminCheck()
  },
  computed: {
    loading: function () {
        return this.$store.state.commonObj.loading
    },
    ...mapGetters({
        commonProfile: 'Auth/commonProfile',
        authUser: 'Auth/authUser'
    })
  },
  methods: {
    finalSave () {
        this.$swal({
            title: this.$t('globalTrans.final_save_msg'),
            showCancelButton: true,
            confirmButtonText: this.$t('globalTrans.yes'),
            cancelButtonText: this.$t('globalTrans.no'),
            focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
                this.tabDevelopmentPlanning()
            } else {
                this.app_status = 1
            }
        })
    },
    async getTreeDisposalData () {
        const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalAppDetailsApi, { app_id: this.app_id })
        if (result.success) {
            const data = result.data
            if (data) {
                this.application = data
                this.application.app_id = this.app_id
                this.garden_id_set = this.application.garden_id

                // check relational data
                if (!data.cutting_purpose) {
                    this.application.cutting_purpose = {
                        id: 0,
                        app_id: 0,
                        tree_cutting_id: 0,
                        purpose_of_tree_felling: [],
                        total_cutable_trees: 0,
                        number_of_re_plantable_tree: 0,
                        number_of_very_old_trees: 0,
                        number_of_rubber_tree: 0,
                        number_of_disease_tree: 0,
                        number_of_other_trees: 0
                   }
                }
                if (!data.development_planing) {
                    this.application.development_planing = {
                        id: 0,
                        app_id: 0,
                        tree_cutting_id: 0,
                        fiscal_year_id: 0,
                        expansion_planting: null,
                        re_plantation: null,
                        rubber: null,
                        afforestation: null,
                        other_plants: null
                    }
                }
            }
            this.isLoading = false
            this.dataLoaded = true
        } else {
            this.isLoading = false
        }
    },
    async tabDevelopmentPlanning () {
        const result = await this.$refs.development_planning.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'tree-disposal-registration' })
            } else {
                if (result.is_payment) {
                    const baseTableId = result.base_table_id
                    this.$router.push({ name: 'tea_garden_service.btb.payment', params: { id: baseTableId }, query: { from: 'tea_garden_service.btb.tree_disposal_registration' } })
                } else {
                    this.$router.push({ name: 'tea_garden_service.btb.tree_disposal_registration' })
                }
            }
        }
    },
    async tabCuttingPurpose () {
        const result = await this.$refs.cutting_purpose.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'tree-disposal-registration' })
            } else {
                this.app_id = result.data.tree_cutting_id
                return true
            }
        }
    },
    async tabTreeDetailsCategory () {
        const result = await this.$refs.tree_details_category.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'tree-disposal-registration' })
            } else {
                this.app_id = result.data.id
                return true
            }
        }
    },
    changeGarden (gardenId) {
      this.garden_id_set = gardenId
    },
    isGardenAdminCheck () {
        if (this.authUser.office_detail && this.authUser.office_detail.office_id !== null) {
            const officeId = this.authUser.office_detail.office_id
            const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.office_id === officeId)
            if (gardenInfo) {
                if (!this.$route.query.id) {
                    this.garden_id_set = gardenInfo.value
                }
                this.isGardenAdmin = true
            }
        }
    }
  }
 }
</script>
