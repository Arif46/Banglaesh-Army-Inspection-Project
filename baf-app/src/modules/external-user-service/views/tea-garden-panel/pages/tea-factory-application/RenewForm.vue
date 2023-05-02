<template>
    <div class="inner-section application-form-wrapper">
      <bread-cumb />
      <body-card>
        <template v-slot:headerTitle>
          <h4 class="card-title">{{ $t('teaGardenPanel.tea_factory_service') + ' ' + ($route.query.id ? $t('globalTrans.update') : $t('globalTrans.apply')) }}</h4>
        </template>
        <template v-slot:body>
            <b-overlay :show="isLoading">
              <b-row>
                  <b-col>
                      <form-wizard shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                          <tab-content :title="$t('teaGardenPanel.applicant_tab')" icon="ri-home-4-line" :before-change="tabSubmitApplicant">
                              <div class="application-itmes">
                                   <ApplicantForm :key="key" :app_id="app_id" :applicantFormData="application" :isShow="dataLoaded" :baseUrl="baseUrl" :isRenew="true" ref="applicant_form"/>
                              </div>
                          </tab-content>
                          <tab-content :title="$t('teaGardenPanel.factory_tab')" icon="ri-list-settings-line" :before-change="tabFactoryInfo">
                              <div class="application-itmes">
                                   <FactoryInfo :key="key" :app_id="app_id" :factoryInfoData="application.factory_info" :allData="application" :isRenew="true" ref="factory_info_form"/>
                              </div>
                          </tab-content>
                          <tab-content :title="$t('teaGardenPanel.machineries_tab')" icon="ri-list-settings-line" :before-change="tabMachineriesInfo">
                              <div class="application-itmes">
                                   <MachineriesInfo :key="key" :app_id="app_id" :machineriesInfoData="application.machineries_info" :isRenew="true" ref="machineries_info_form"/>
                              </div>
                          </tab-content>
                          <tab-content :title="$t('teaGardenPanel.attachment_tab')" icon="ri-list-settings-line" :before-change="tabAttachmentInfo">
                              <div class="application-itmes">
                                   <AttachmentInfo :key="key" :app_id="app_id" :attachmentInfoData="application.attachment_file" :attachmentAddMoreData="application.add_more_files" :allData="application" :draft="draft" :isRenew="true" ref="attachment_file_form"/>
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
                                      <router-link to="/tea-garden-panel/tea-factory-application" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
                                  </wizard-button>
                              </div>
                          </template>
                      </form-wizard>
                  </b-col>
              </b-row>
            </b-overlay>
        </template>
      </body-card>
    </div>
  </template>
  <script>
  // import RestApi, { authServiceBaseUrl } from '@/config/api_config'
  import BreadCumb from '@/components/BreadCumb.vue'
  import ApplicantForm from './ApplicantForm'
  import FactoryInfo from './FactoryInfo'
  import MachineriesInfo from './MachineriesInfo'
  import AttachmentInfo from './AttachmentInfo'
  import { FormWizard, TabContent } from 'vue-form-wizard'
  import 'vue-form-wizard/dist/vue-form-wizard.min.css'
  import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
  import { mapGetters } from 'vuex'
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { factoryInfoDetailsApi } from '../../api/routes'
  export default {
    components: { BreadCumb, ApplicantForm, FactoryInfo, MachineriesInfo, AttachmentInfo, FormWizard, TabContent, WizardButton },
    name: 'Form',
  data () {
    return {
        baseUrl: teaGardenServiceBaseUrl,
        valid: null,
        saveBtnName: this.$t('globalTrans.update'),
        errors: [],
        step: 0,
        key: 0,
        activeIndex: 0,
        sectorId: 0,
        application: {
            factory_type_id: 0,
            applicant_type: 0,
            garden_id: 0,
            app_id: 0,
            parent_id: null,
            user_id: 0,
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            country_id: 1,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            factory_info: {
                btb_tea_factory_reg_main_id: 0,
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                country_id: 1,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                processed_area: [],
                factory_name_en: null,
                factory_name_bn: null
            },
            machineries_info: [],
            attachment_file: {
                btb_tea_factory_reg_main_id: 0,
                app_id: 0
            },
            add_more_files: [
                { file_name_en: '', file: '' }
            ]
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
        this.getTeaFactoryData(this.$route.query.id)
    } else if (this.$route.params.parent_id) {
        this.isLoading = true
        this.getTeaFactoryData(this.$route.params.parent_id)
        this.app_id = 0
    } else {
        this.isLoading = false
    }
    this.application.user_id = this.authUser.user_id
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
                this.tabAttachmentInfo()
            } else {
                this.app_status = 1
            }
        })
    },
    async getTeaFactoryData (appId) {
        const result = await RestApi.getData(teaGardenServiceBaseUrl, factoryInfoDetailsApi, { app_id: appId })
        if (result.success) {
            const data = result.data
            if (data) {
                this.application = data
                if (this.$route.query.id) {
                    this.application.app_id = this.app_id
                } else if (this.$route.params.parent_id) {
                    this.application.app_id = 0
                }
                // check relational data
                if (!data.factory_info) {
                    this.application.factory_info = {
                        id: 0,
                        btb_tea_factory_reg_main_id: 0,
                        area_type_id: 0,
                        division_id: 0,
                        district_id: 0,
                        country_id: 1,
                        city_corporation_id: 0,
                        paurashava_id: 0,
                        upazila_id: 0,
                        union_id: 0,
                        processed_area: [],
                        factory_name_en: null,
                        factory_name_bn: null
                   }
                }
                if (!data.machineries_info) {
                    this.application.machineries_info = {
                        id: 0,
                        btb_tea_factory_reg_main_id: 0
                   }
                }
                if (!data.attachment_file) {
                    this.application.attachment_file = {
                        btb_tea_factory_reg_main_id: 0,
                        app_id: 0
                    }
                }
                if (!Object.keys(data.add_more_files).length) {
                    this.application.add_more_files = [
                        { file_name_en: '', file: '' }
                    ]
                }
                this.key++
            }
            this.isLoading = false
            this.dataLoaded = true
        } else {
            this.isLoading = false
        }
    },
    async tabSubmitApplicant () {
        const result = await this.$refs.applicant_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: '/tea-garden-panel/tea-factory-application' })
            } else {
                this.app_id = result.data.id
                this.key++
                return true
            }
        }
    },
    async tabFactoryInfo () {
        const result = await this.$refs.factory_info_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: '/tea-garden-panel/tea-factory-application' })
            } else {
                this.app_id = result.data.btb_tea_factory_reg_main_id
                return true
            }
        }
    },
    async tabMachineriesInfo () {
        const result = await this.$refs.machineries_info_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: '/tea-garden-panel/tea-factory-application' })
            } else {
                this.app_id = result.data.id
                return true
            }
        }
    },
    async tabAttachmentInfo () {
        const result = await this.$refs.attachment_file_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: '/tea-garden-panel/tea-factory-application' })
            } else {
                if (result.is_payment) {
                    const baseTableId = result.base_table_id
                    this.$router.push({ name: 'tea_garden_panel.payment', params: { id: baseTableId }, query: { from: 'tea_garden_panel.tea_factory_application' } })
                } else {
                    this.$router.push({ name: 'tea_garden_panel.tea_factory_application' })
                }
            }
        }
    }
  }
}
</script>
