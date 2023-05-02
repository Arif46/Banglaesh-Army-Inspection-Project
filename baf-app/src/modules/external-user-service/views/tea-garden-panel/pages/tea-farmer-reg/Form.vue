<template>
  <div class="inner-section application-form-wrapper">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('teaGardenPanel.tea_farmer_registration_create') }}</h4>
      </template>
      <template v-slot:body>
          <b-overlay :show="isLoading">
            <b-row>
                <b-col>
                    <form-wizard shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('teaGardenPanel.garden_info')" icon="ri-home-4-line" :before-change="tabSubmitBasic" >
                            <div class="application-itmes">
                                 <BasicForm :key="key" :app_id="app_id" :basisFormData="application" :isShow="dataLoaded" :baseUrl="baseUrl" :isRenew="false" ref="basic_form"/>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenPanel.owner_info')" icon="ri-list-settings-line" :before-change="tabOwnerInfo">
                            <div class="application-itmes">
                                 <OwnerInfo :key="key" :app_id="app_id" :ownerInfoData="application.owner_info" :draft="draft" :isRenew="false" ref="owner_info_form"/>
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
                                    <router-link to="tea-farmer-application" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
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
import BasicForm from './BasicForm'
import OwnerInfo from './OwnerInfo'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
import { mapGetters } from 'vuex'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { teaFarmerApplicationDetailsApi } from '../../api/routes'
export default {
  components: { BreadCumb, BasicForm, OwnerInfo, FormWizard, TabContent, WizardButton },
  name: 'Form',
  props: ['circular_id'],
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
            app_id: 0,
            parent_id: null,
            user_id: 0,
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            owner_info: { // Table Name: small_tea_farmer_reg_owner_infos
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0
            }
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
        this.getTeaFarmerData()
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
                this.tabOwnerInfo()
            } else {
                this.app_status = 1
            }
        })
    },
    async getTeaFarmerData () {
        const result = await RestApi.getData(teaGardenServiceBaseUrl, teaFarmerApplicationDetailsApi, { app_id: this.app_id })
        if (result.success) {
            const data = result.data
            if (data) {
                this.application = data
                this.application.app_id = this.app_id
                this.key++
            }
            this.isLoading = false
            this.dataLoaded = true
        } else {
            this.isLoading = false
        }
    },
    async tabOwnerInfo () {
        const result = await this.$refs.owner_info_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'tea-farmer-application' })
            } else {
                if (result.is_payment) {
                    const baseTableId = result.base_table_id
                    this.$router.push({ name: 'tea_garden_panel.payment', params: { id: baseTableId }, query: { from: 'tea_garden_panel.tea_farmer_application' } })
                } else {
                    this.$router.push({ name: 'tea_garden_panel.tea_farmer_application' })
                }
            }
        }
    },
    async tabSubmitBasic () {
        const result = await this.$refs.basic_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'tea-farmer-application' })
            } else {
                this.app_id = result.data.id
                return true
            }
        }
    }
  }
}
</script>
