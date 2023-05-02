<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('externalTradeFair.fair_participation_payment') + ' ' + ($route.query.id ? $t('globalTrans.update') : $t('globalTrans.entry')) }}</h4>
      </template>
      <template v-slot:body>
          <b-overlay :show="!dataLoaded">
            <b-row>
                <!-- <b-col v-if="noteList.length > 0" sm="12">
                    <div class="fair-note-wrapper">
                        <p v-for="(item, index) in noteList" :key="index">
                            <span class="note-title">{{ $t('externalTradeFair.note') }}</span>
                            {{ $i18n.locale == 'en' ? item.text_en : item.text_bn }}
                        </p>
                    </div>
                </b-col> -->
                <b-col sm="12" v-if="!dataLoaded" style="min-height: 400px"></b-col>
                <b-col sm="12" v-else>
                    <form-wizard class="fair-tab-wrapper" shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('externalTradeFair.applicant_info')" icon="ri-home-4-line" :before-change="tab1Submit" >
                            <Tab1
                                :app_id="app_id"
                                :application="application"
                                :circular="circular"
                                ref="tab_1_form"/>
                        </tab-content>
                        <tab-content :title="$t('globalTrans.org_address')" icon="ri-list-settings-line" :before-change="tab2Submit">
                            <Tab2
                                :app_id="app_id"
                                ref="tab_2_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalTradeFair.org_owner_info')" icon="ri-list-settings-line" :before-change="tab3Submit">
                            <Tab3 :app_id="app_id" ref="tab_3_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalTradeFair.business_type_and_product')" icon="ri-list-settings-line" :before-change="tab4Submit">
                            <Tab4 :app_id="app_id" ref="tab_4_form"/>
                        </tab-content>
                        <tab-content :title="$t('tradeFairConfig.stall_information')" icon="ri-list-settings-line" :before-change="tab5Submit">
                            <Tab5 :app_id="app_id" ref="tab_5_form"/>
                        </tab-content>

                        <tab-content :title="$t('externalUser.attachment')" icon="ri-list-settings-line" :before-change="tabLastSubmit">
                            <TabLast :app_id="app_id" :attachments="attachments" :app_status="app_status" :baseUrl="baseUrl" ref="tab_last_form"/>
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-secondary rounded-pill" @click.native="props.prevTab(), step--"  v-if="props.activeTabIndex > 0" :style="props.fillButtonStyle">{{ $t('globalTrans.back') }}</wizard-button>
                                <wizard-button
                                    type="submit"
                                    class="btn btn-warning ml-1 mr-1 rounded-pill"
                                    title="Create Draft and Save!"
                                    @click.native="props.nextTab(), draft = 1"
                                >
                                    {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button
                                    type="submit"
                                    v-if="!props.isLastStep"
                                    @click.native="props.nextTab(), isNext = true"
                                    class="btn btn-success ml-1 mr-1 rounded-pill"
                                    title="Draft and go to next!"
                                    :style="props.fillButtonStyle"
                                >{{ $t('globalTrans.draft_n_next') }}
                                </wizard-button>
                                <wizard-button
                                    v-else
                                    type="submit"
                                    class="btn btn-success ml-1 rounded-pill"
                                    title="Submit!"
                                    @click.native="finalSave(), app_status = 2"
                                >
                                    {{ $t('globalTrans.finalSave')}}
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

import Tab1 from './Tab1'
import Tab2 from './Tab2'
import Tab3 from './Tab3'
import Tab4 from './Tab4'
import Tab5 from './Tab5'
import TabLast from './TabLast'

// import NoImage from '@/assets/images/user/no-image.jpg'
import BreadCumb from '@/components/BreadCumb.vue'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
import { mapGetters } from 'vuex'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairInfoByCircularApi, fairPartListDetailsApi } from '../../../api/routes'

export default {
  components: {
    BreadCumb, FormWizard, TabContent, WizardButton, Tab1, Tab2, Tab3, Tab4, Tab5, TabLast
  },
  name: 'Form',
  props: [],
  data () {
    return {
        baseUrl: internationalTradeFairServiceBaseUrl,
        valid: null,
        errors: [],
        step: 0,
        activeIndex: 0,
        circular: {},
        application: {
            circular_id: 0,
            year: 0,
            circular_type: 0,
            fair_id: 0,
            name_en: '',
            name_bn: '',
            designation_en: '',
            designation_bn: '',
            comp_name_en: '',
            comp_name_bn: '',
            phone_no: '',
            mobile_no: '',
            email: ''
        },
        address: {
            country_type: 0,
            country_id: 0,
            state_en: '',
            state_bn: '',
            city_en: '',
            city_bn: '',
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            ward_id: 0,
            post_code: null,
            address_details_en: '',
            address_details_bn: '',
            fax: ''
        },
        officer_owners: [{
            info_type: 1,
            name_en: '',
            name_bn: '',
            designation_en: '',
            designation_bn: '',
            address_en: '',
            address_bn: '',
            mobile_no: '',
            phone_no: ''
        }],
        business_type_ids: [],
        products: [{
            prod_name_en: '',
            prod_name_bn: ''
        }],
        stalls: [],
        attachments: {
            applicant_photo: '',
            trade_license: '',
            vat_regi_certificate: '',
            export_regi_certificate: '',
            prc_certificate: '',
            tax_certificate: '',
            chamber_certificate: '',
            bank_certificate: '',
            nid_attachment: '',
            signature: '',
            license_issue: 0
        },
        app_id: 0,
        app_status: 1,
        draft: 0,
        dataLoaded: false
    }
  },
  created () {
    window.scrollTo(0, 0)
    if (this.$route.query.id) {
        this.app_id = this.$route.query.id
        this.getParticipateData()
    }
    if (this.$route.query.circular_id) {
        const circularId = this.$route.query.circular_id
        this.application.fair_circular_id = circularId
        // this.getFairByCircularIdInfo(circularId)
        this.dataLoaded = true
    }
  },
  computed: {
    noteList: function () {
        return this.$store.state.ExternalUserService.tradeFair.commonObj.noteList
    },
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
                this.tabLastSubmit()
            } else {
                this.app_status = 1
            }
        })
    },
    async getParticipateData () {
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairPartListDetailsApi, { app_id: this.app_id })
        if (result.success) {
            const data = result.data
            if (data) {
                this.getFairByCircularIdInfo(data.fair_circular?.id)
                // tab - 1
                this.application = {
                    fair_circular_id: data.fair_circular?.id,
                    name_en: data.name_en,
                    name_bn: data.name_bn,
                    address_en: data.address_en,
                    address_bn: data.address_bn,
                    factory_address_en: data.factory_address_en,
                    factory_address_bn: data.factory_address_bn,
                    web_page_url: data.web_page_url,
                    phone_no: data.phone_no,
                    email: data.email,
                    company_type: data.company_type,
                    other_comp_type_en: data.other_comp_type_en,
                    other_comp_type_bn: data.other_comp_type_bn,
                    company_nature: data.company_nature,
                    other_comp_nature_en: data.other_comp_nature_en,
                    other_comp_nature_bn: data.other_comp_nature_bn,
                    establishment_year: data.establishment_year,
                    erc_no: data.erc_no,
                    tin_no: data.tin_no,
                    bin_no: data.bin_no,
                    display_product_en: data.display_product_en,
                    display_product_bn: data.display_product_bn,
                    production_capacity: data.production_capacity,
                    employee_number: data.employee_number,
                    is_exported: data.is_exported,
                    main_market_en: data.main_market_en,
                    main_market_bn: data.main_market_bn
                }
                this.activeIndex = 1
                // tab - 2
                if (data.objective) {
                    this.objective = data.objective
                    this.activeIndex = 2
                }
                // tab - 3
                if (data.representatives.length > 0) {
                    this.representatives = data.representatives
                    this.activeIndex = 3
                }
                // tab - 4
                if (data.attachment_tab) {
                    this.attachments = data.attachment_tab
                }
            }
            // this.dataLoaded = true
        } else {
            this.dataLoaded = false
        }
    },
    async getFairByCircularIdInfo (circularId) {
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairInfoByCircularApi, { circular_id: circularId })
        if (result.success) {
            const fData = result.data
            if (fData) {
                this.circular = fData.circular
            }
            this.dataLoaded = true
        } else {
            this.$router.push({ path: 'fair-participation-circular' })
        }
    },
    async tabLastSubmit () {
        // this.$router.push({ path: 'fair-participation' })
        const result = await this.$refs.tab_last_form.submit()
        // if (result === undefined) {
        //     this.app_status = 1
        // }
        if (result.success) {
            this.$router.push({ path: 'fair-application' })
        }
    },
    async tab5Submit () {
        return true
        // const result = await this.$refs.tab_4_form.submit()
        // if (result.success) {
        //     if (this.draft) {
        //         this.$router.push({ path: 'fair-application' })
        //     } else {
        //         return true
        //     }
        // }
    },
    async tab4Submit () {
        return true
        // const result = await this.$refs.tab_4_form.submit()
        // if (result.success) {
        //     if (this.draft) {
        //         this.$router.push({ path: 'fair-application' })
        //     } else {
        //         return true
        //     }
        // }
    },
    async tab3Submit () {
        return true
        // const result = await this.$refs.tab_3_form.submit()
        // if (result.success) {
        //     if (this.draft) {
        //         this.$router.push({ path: 'fair-application' })
        //     } else {
        //         return true
        //     }
        // }
    },
    async tab2Submit () {
        return true
        // const result = await this.$refs.tab_2_form.submit()
        // if (result.success) {
        //     if (this.draft) {
        //         this.$router.push({ path: 'fair-application' })
        //     } else {
        //         return true
        //     }
        // }
    },
    async tab1Submit () {
        return true
        // const result = await this.$refs.tab_1_form.submit()
        // if (result.success) {
        //     if (this.draft) {
        //         this.$router.push({ path: 'fair-application' })
        //     } else {
        //         this.app_id = result.data.id
        //         return true
        //     }
        // }
    }
  }
}
</script>
<style>
.fair-note-wrapper {
    margin-bottom: 20px;
}
.fair-note-wrapper p {
    margin-bottom: 10px;
}
.fair-note-wrapper .note-title {
    background: #ffb01e;
    margin-right: 2px;
    padding: 2px 5px;
    font-weight: 600;
    border-radius: 2px;
}
.fair-tab-wrapper.vue-form-wizard.md .wizard-navigation .wizard-nav-pills li {
    padding: 5px 0 20px;
}
</style>
