<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('externalUser.cip_application') + ' ' + ($route.query.id ? $t('globalTrans.update') : $t('globalTrans.apply')) }}</h4>
      </template>
      <template v-slot:body>
          <b-overlay :show="isLoading">
            <b-row>
                <b-col v-if="!dataLoaded" style="min-height: 400px">
                </b-col>
                <b-col v-else>
                    <form-wizard shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('externalUser.first_tab_name')" icon="ri-home-4-line" :before-change="tabSubmitBasic" >
                            <BasicForm :app_id="app_id" :application="application" :baseUrl="baseUrl" ref="basic_form"/>
                        </tab-content>
                        <tab-content :title="$t('globalTrans.address')" icon="ri-contacts-line" :before-change="tabSubmitAddress" >
                            <AddressForm :app_id="app_id" :address="address" :isShow="dataLoaded" ref="address_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.institute_info')" icon="ri-play-list-add-line" :before-change="tabSubmitOrganization">
                            <OrganizationForm :app_id="app_id" :orgTab="orgTab" :isShow="dataLoaded" ref="organization_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.group_based') + ' ' + $t('globalTrans.information')" icon="ri-map-pin-2-fill" :before-change="tabSubmitGroupBased">
                            <GroupBasedForm :app_id="app_id" :group_based_apps="group_based_apps" :applied_group="applied_group_of_companies" :baseUrl="baseUrl" ref="group_based_form"/>
                        </tab-content>
                        <tab-content :title="$t('sideBar.bank') + ' ' + $t('globalTrans.information')" icon="ri-list-settings-line" :before-change="tabSubmitBank">
                            <BankForm :app_id="app_id" :banks="banks" ref="bank_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.product_and_success') + ' ' + $t('globalTrans.description')" icon="ri-list-settings-line" :before-change="tabSubmitDescription">
                            <DescriptionForm v-if="loadSector" :app_id="app_id" :descriptions="descriptions" :sectorId="sectorId" ref="description_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.compliance_information')" icon="ri-list-settings-line" :before-change="tabSubmitOthers">
                            <OtherForm
                            :app_id="app_id" :other_compliance="other_compliance"
                            :export_destinations="export_destinations"
                            :export_products="export_products"
                            :cip_selecteds="cip_selecteds"
                            :baseUrl="baseUrl"
                            ref="other_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.attachment')" icon="ri-list-settings-line" :before-change="tabSubmitAttachment">
                            <AttachmentForm
                            :app_id="app_id" :attachment_all_doc="attachment_all_doc"
                            :app_status="app_status"
                            ref="attachment_form"/>
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-secondary rounded-pill" @click.native="props.prevTab(), step--"  v-if="props.activeTabIndex > 0" :style="props.fillButtonStyle">{{ $t('externalUser.previous_tab') }}</wizard-button>
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
import NoImage from '../../../../../../assets/images/user/no-image.jpg'
import BreadCumb from '@/components/BreadCumb.vue'
import BasicForm from './BasicForm'
import AddressForm from './AddressForm'
import OrganizationForm from './OrganizationForm'
import GroupBasedForm from './GroupBasedForm'
import BankForm from './BankForm'
import DescriptionForm from './DescriptionForm'
import OtherForm from './OtherForm'
import AttachmentForm from './AttachmentForm'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipApplicationDetailsApi, circularShow } from '../../api/routes'

export default {
  components: { BreadCumb, BasicForm, AddressForm, OrganizationForm, GroupBasedForm, BankForm, DescriptionForm, OtherForm, FormWizard, TabContent, WizardButton, AttachmentForm },
  name: 'Form',
  props: ['circular_id'],
  data () {
    return {
        baseUrl: exportTrophyCIPServiceBaseUrl,
        valid: null,
        saveBtnName: this.$t('globalTrans.update'),
        errors: [],
        step: 0,
        activeIndex: 0,
        sectorId: 0,
        application: {
            circular_id: 0,
            preview: NoImage,
            photo: '',
            photo_file: '',
            circular_name: '',
            latent_exporter: 1,
            product_service_sector_id: 0,
            user_id: 0,
            year: '',
            app_type: 0,
            designation_en: '',
            designation_bn: '',
            father_title_en: '',
            father_title_bn: '',
            mother_title_en: '',
            mother_title_bn: '',
            husband_title_en: '',
            husband_title_bn: '',
            husband_name_en: '',
            husband_name_bn: '',
            district_of_birth: '',
            country_of_birth: '',
            passport_info: {
                passport_no: '',
                country_id: 0,
                issue_date: '',
                duration: ''
            },
            tax_info: {
                tin_no: '',
                tax_circle: '',
                tax_region_en: '',
                tax_region_bn: ''
            },
            contact_info: {
                telephone_no: '',
                mobile_no: '',
                email: '',
                fax_no: ''
            }
        },
        address: {
            pr_address: {},
            pm_address: {}
        },
        orgTab: {
            org_info: {
                owner_name_en: '',
                owner_name_bn: '',
                org_name_en: '',
                org_name_bn: '',
                designation_en: '',
                designation_bn: '',
                bin_no: '',
                org_type: 0,
                epz_affiliated_org: 2,
                bangladeshi_owned_company: 2,
                legal_form: ''
            },
            org_tax_info: {
                tin_no: '',
                tax_circle: '',
                tax_region_en: '',
                tax_region_bn: ''
            },
            office_contact_info: {
                telephone_no: '',
                mobile_no: '',
                email: '',
                fax_no: ''
            },
            factory_contact_info: {
                telephone_no: '',
                mobile_no: '',
                email: '',
                fax_no: ''
            },
            contact_person_info: {
                name_en: '',
                name_bn: '',
                mobile: '',
                designation_en: '',
                designation_bn: ''
            },
            org_address: {
                country_id: 0,
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                ward_id: 0,
                post_code: '',
                address_details_en: '',
                address_details_bn: ''
            },
            additional_org_address: {
                country_id: 0,
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                ward_id: 0,
                postal_code: '',
                address_details_en: '',
                address_details_bn: ''
            }
        },
        applied_group_of_companies: '2',
        group_based_apps: [
            {
                group_name_en: '',
                group_name_bn: '',
                export_value: '',
                org_name_en: '',
                org_name_bn: '',
                attachments: [
                    {
                        attachment: null
                    }
                ]
            }
        ],
        banks: [],
        descriptions: [],
        other_compliance: {
            export_leather_shoes: 2,
            merchandising_prc: '',
            merchandising_prc_file: '',
            dispute_settled_document: '',
            dispute_settled_document_file: '',
            report: '',
            report_file: '',
            signature: '',
            signature_file: '',
            compliance_current_fiscal_year: 2,
            merchandising_sector: 1,
            export_destination_add: 2,
            export_products_add: 2,
            trade_dispute_current_fiscal_year: 2,
            dispute_settled: 2,
            applicant_selected_cip_past_year: 2,
            other_information: ''
        },
        attachment_all_doc: {
            latest_year_tax_certificate: '',
            latest_year_tax_certificate_oldfile: '',
            vat_certificate: '',
            vat_certificate_oldfile: '',
            custom_duty_certificate: '',
            custom_duty_certificate_oldfile: '',
            income_tax_certificate: '',
            income_tax_certificate_oldfile: '',
            loan_certificate: '',
            loan_certificate_oldfile: '',
            incorporation_certificate: '',
            incorporation_certificate_oldfile: '',
            bank_prc_last_fical_year: '',
            bank_prc_last_fical_year_oldfile: '',
            bank_prc_latest_fical_year: '',
            bank_prc_latest_fical_year_oldfile: ''
        },
        export_destinations: [],
        export_products: [],
        cip_selecteds: [],
        app_id: 0,
        app_status: 1,
        draft: 0,
        isLoading: false,
        dataLoaded: false,
        loadSector: true
    }
  },
  created () {
    if (this.$route.query.id) {
        this.isLoading = true
        this.app_id = this.$route.query.id
        this.getCipData()
    } else {
        this.isLoading = false
    }
    if (this.$route.query.circular_id) {
        this.getCurrentCircular(this.$route.query.circular_id)
        this.application.circular_id = this.$route.query.circular_id
        this.isLoading = false
        this.dataLoaded = true
    }
    this.application.user_id = this.authUser.user_id
    this.application.name_en = this.authUser.name
    this.application.name_bn = this.authUser.name_bn
    this.application.father_name_en = this.commonProfile.father_name_en
    this.application.father_name_bn = this.commonProfile.father_name_bn
    this.application.mother_name_en = this.commonProfile.mother_name_en
    this.application.mother_name_bn = this.commonProfile.mother_name_bn
    this.application.gender = this.commonProfile.gender
    this.application.dob = this.commonProfile.dob
    this.application.nid = this.commonProfile.nid_no
    this.application.mobile = this.commonProfile.mobile
    this.application.email = this.commonProfile.email

    this.application.contact_info.mobile_no = this.commonProfile.mobile
    this.application.contact_info.email = this.commonProfile.email
  },
  computed: {
    circularList: function () {
        return this.$store.state.ExternalUserService.cipPanel.commonObj.circularList
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
                this.tabSubmitAttachment()
            } else {
                this.app_status = 1
            }
        })
    },
    async getCurrentCircular (circularId) {
        const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, `${circularShow}/${circularId}`)
        if (result.success) {
            this.application.year = result.data.year
            this.$store.commit('ExternalUserService/addCurrentCircular', result.data)
        } else {
            this.isLoading = false
        }
    },
    async getCipData () {
        const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, cipApplicationDetailsApi, { app_id: this.app_id })
        if (result.success) {
            const data = result.data
            this.getCurrentCircular(data.circular_id)
            if (data) {
                // tab - 1
                this.sectorId = data.product_service_sector_id
                this.application = {
                    circular_id: data.circular_id,
                    circular: data.circular,
                    circular_name: this.$i18n.locale === 'bn' ? data.circular.title_en : data.circular.title_bn,
                    latent_exporter: data.latent_exporter,
                    product_service_sector_id: data.product_service_sector_id,
                    name_en: data.name_en,
                    name_bn: data.name_bn,
                    father_name_en: data.father_name_en,
                    father_name_bn: data.father_name_bn,
                    mother_name_en: data.mother_name_en,
                    mother_name_bn: data.mother_name_bn,
                    designation_en: data.designation_en,
                    designation_bn: data.designation_bn,
                    father_title_en: data.father_title_en,
                    father_title_bn: data.father_title_bn,
                    mother_title_en: data.mother_title_en,
                    mother_title_bn: data.mother_title_bn,
                    husband_title_en: data.husband_title_en,
                    husband_title_bn: data.husband_title_bn,
                    district_of_birth: data.district_of_birth,
                    country_of_birth: data.country_of_birth,
                    husband_name_en: data.husband_name_en,
                    husband_name_bn: data.husband_name_bn,
                    gender: data.gender,
                    dob: data.dob,
                    nid: data.nid,
                    mobile: data.mobile,
                    email: data.email,
                    preview: NoImage,
                    photo: data.photo,
                    photo_file: '',
                    user_id: data.user_id,
                    app_type: data.app_type,
                    passport_info: data.passport_info,
                    tax_info: data.tax_info,
                    contact_info: data.contact_info
                }
                this.activeIndex = 1
                // tab - 2
                if (data.address) {
                    const pRaddress = {}
                    const pMaddress = {}
                    Object.keys(data.address).forEach(key => {
                        const keyName = key
                        if (keyName.match('pr_')) {
                            pRaddress[key] = data.address[key]
                        }
                        if (keyName.match('pm_')) {
                            pMaddress[key] = data.address[key]
                        }
                    })
                    pRaddress.pr_pauroshoba_id = data.address.pr_paurashava_id
                    pMaddress.pm_pauroshoba_id = data.address.pm_paurashava_id
                    this.address = {
                        pr_address: pRaddress,
                        pm_address: pMaddress,
                        is_same_as_present: data.address.is_same_as_present
                    }
                    this.activeIndex = 2
                }
                if (data.org_info) {
                    this.orgTab = {
                        org_info: data.org_info,
                        org_tax_info: data.org_tax_info,
                        office_contact_info: data.office_contact_info,
                        factory_contact_info: data.factory_contact_info,
                        contact_person_info: data.contact_person_info,
                        org_address: data.org_address,
                        additional_org_address: data.additional_org_address
                    }
                    this.activeIndex = 3
                }
                if (data.group_based_app.length > 0) {
                    this.applied_group_of_companies = data.applied_group_of_companies
                    const GropB = data.group_based_app.map(itm => {
                        const Att = itm.attachments.map(el => {
                            return Object.assign({}, el, { file: '' })
                        })
                        return Object.assign({}, itm, { attachments: Att })
                    })
                    this.group_based_apps = GropB
                    this.activeIndex = 4
                }
                if (data.bank.length > 0) {
                    this.banks = data.bank
                    this.activeIndex = 5
                }
                if (data.product_success_description.length > 0) {
                    this.descriptions = data.product_success_description
                    this.activeIndex = 6
                }
                if (data.other_compliance) {
                    this.other_compliance = data.other_compliance
                    this.other_compliance.merchandising_prc_file = ''
                    this.other_compliance.report_file = ''
                    this.other_compliance.signature_file = ''
                    this.other_compliance.dispute_settled_document_file = ''
                    if (data.other_compliance.export_leather_shoes === 0) {
                        this.other_compliance.export_leather_shoes = 2
                    }
                    if (data.other_compliance.compliance_current_fiscal_year === 0) {
                        this.other_compliance.compliance_current_fiscal_year = 2
                    }
                    if (data.other_compliance.trade_dispute_current_fiscal_year === 0) {
                        this.other_compliance.trade_dispute_current_fiscal_year = 2
                    }
                    if (data.other_compliance.dispute_settled === 0) {
                        this.other_compliance.dispute_settled = 2
                    }
                    if (data.export_destination.length > 0) {
                        this.export_destinations = data.export_destination
                    }
                    if (data.export_product.length > 0) {
                        this.export_products = data.export_product
                    }
                    if (data.cip_selected.length > 0) {
                        this.cip_selecteds = data.cip_selected
                    }
                    this.activeIndex = 7
                }

                if (data.attachment_all_doc) {
                    if (data.attachment_all_doc.latest_year_tax_certificate !== null || data.attachment_all_doc.latest_year_tax_certificate !== '') {
                        this.attachment_all_doc.latest_year_tax_certificate_oldfile = data.attachment_all_doc.latest_year_tax_certificate
                        this.attachment_all_doc.latest_year_tax_certificate = ''
                    }
                    if (data.attachment_all_doc.vat_certificate !== null || data.attachment_all_doc.vat_certificate !== '') {
                        this.attachment_all_doc.vat_certificate_oldfile = data.attachment_all_doc.vat_certificate
                        this.attachment_all_doc.vat_certificate = ''
                    }
                    if (data.attachment_all_doc.custom_duty_certificate !== null || data.attachment_all_doc.custom_duty_certificate !== '') {
                        this.attachment_all_doc.custom_duty_certificate_oldfile = data.attachment_all_doc.custom_duty_certificate
                        this.attachment_all_doc.custom_duty_certificate = ''
                    }
                    if (data.attachment_all_doc.income_tax_certificate !== null || data.attachment_all_doc.income_tax_certificate !== '') {
                        this.attachment_all_doc.income_tax_certificate_oldfile = data.attachment_all_doc.income_tax_certificate
                        this.attachment_all_doc.income_tax_certificate = ''
                    }
                    if (data.attachment_all_doc.loan_certificate !== null || data.attachment_all_doc.loan_certificate !== '') {
                        this.attachment_all_doc.loan_certificate_oldfile = data.attachment_all_doc.loan_certificate
                        this.attachment_all_doc.loan_certificate = ''
                    }
                    if (data.attachment_all_doc.incorporation_certificate !== null || data.attachment_all_doc.incorporation_certificate !== '') {
                        this.attachment_all_doc.incorporation_certificate_oldfile = data.attachment_all_doc.incorporation_certificate
                        this.attachment_all_doc.incorporation_certificate = ''
                    }
                    if (data.attachment_all_doc.bank_prc_last_fical_year !== null || data.attachment_all_doc.bank_prc_last_fical_year !== '') {
                        this.attachment_all_doc.bank_prc_last_fical_year_oldfile = data.attachment_all_doc.bank_prc_last_fical_year
                        this.attachment_all_doc.bank_prc_last_fical_year = ''
                    }
                    if (data.attachment_all_doc.bank_prc_latest_fical_year !== null || data.attachment_all_doc.bank_prc_latest_fical_year !== '') {
                        this.attachment_all_doc.bank_prc_latest_fical_year_oldfile = data.attachment_all_doc.bank_prc_latest_fical_year
                        this.attachment_all_doc.bank_prc_latest_fical_year = ''
                    }
                }
            }
            this.loadSector = true
            this.isLoading = false
            this.dataLoaded = true
        } else {
            this.isLoading = false
        }
    },
    async tabSubmitOthers () {
        const result = await this.$refs.other_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitAttachment () {
        const result = await this.$refs.attachment_form.submit()
        if (result === undefined) {
            this.app_status = 1
        }
        if (result.success) {
            this.$router.push({ path: 'cip-application' })
        }
    },
    async tabSubmitDescription () {
        // return true
        const result = await this.$refs.description_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitBank () {
        // return true
        const result = await this.$refs.bank_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitGroupBased () {
        // return true
        const result = await this.$refs.group_based_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitOrganization () {
        // return true
        const result = await this.$refs.organization_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitAddress () {
        const result = await this.$refs.address_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitBasic () {
        this.loadSector = false
        const result = await this.$refs.basic_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'cip-application' })
            } else {
                this.sectorId = result.data.product_service_sector_id
                this.app_id = result.data.id
                this.loadSector = true
                return true
            }
        }
    }
  }
}
</script>
