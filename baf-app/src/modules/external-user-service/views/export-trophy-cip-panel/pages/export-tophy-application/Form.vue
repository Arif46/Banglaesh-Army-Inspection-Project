<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('externalUser.export_data_application_form') + ' ' + ($route.query.id ? $t('globalTrans.update') : $t('globalTrans.apply')) }}</h4>
      </template>
      <template v-slot:body>
          <b-overlay :show="isLoading">
            <b-row>
                <b-col v-if="!dataLoaded" style="min-height: 400px">
                </b-col>
                <b-col v-else>
                    <form-wizard shape="circle" color="#005B5B" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('externalUser.first_tab_name')" icon="ri-home-4-line" :before-change="tabSubmitBasic" >
                            <BasicForm :app_id="app_id" :application="application" :isShow="dataLoaded" :baseUrl="baseUrl" ref="basic_form"/>
                        </tab-content>
                        <tab-content :title="$t('externalUser.institute_info')" icon="ri-play-list-add-line" :before-change="tabSubmitOrganization">
                            <OrganizationForm :app_id="app_id" :orgTab="orgTab" ref="organization_form"/>
                        </tab-content>
                        <tab-content :title="$t('globalTrans.address')" icon="ri-contacts-line" :before-change="tabSubmitAddress" >
                            <AddressForm :app_id="app_id" :address="address" :isShow="dataLoaded" ref="address_form"/>
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
                            :et_selecteds="et_selecteds"
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
                                    class="btn btn-danger ml-1 mr-1 rounded-pill"
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
                                >{{$t('globalTrans.draft_n_next')}}
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
// import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import NoImage from '../../../../../../assets/images/user/no-image.jpg'
import BreadCumb from '@/components/BreadCumb.vue'
import BasicForm from './BasicForm'
import AddressForm from './AddressForm'
import OrganizationForm from './OrganizationForm'
// import GroupBasedForm from './GroupBasedForm'
import BankForm from './BankForm'
import DescriptionForm from './DescriptionForm'
import OtherForm from './OtherForm'
import AttachmentForm from './AttachmentForm'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { etApplicationDetailsApi, circularShow } from '../../api/routes'
export default {
  components: { BreadCumb, BasicForm, AddressForm, OrganizationForm, BankForm, DescriptionForm, OtherForm, FormWizard, TabContent, WizardButton, AttachmentForm },
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
            preview: NoImage,
            photo: '',
            photo_file: '',
            circular_id: 0,
            circular_name: '',
            latent_exporter: 1,
            product_service_sector_id: 0,
            user_id: 0,
            app_type: 0,
            org_info: { // Table Name: et_org_infos
                org_name_en: '',
                org_name_bn: '',
                bin_no: '',
                org_type: 0,
                epz_affiliated_org: 2,
                bangladeshi_owned_company: 2,
                legal_form: ''
            },
            org_tax_info: { // Table Name: et_org_tax_infos
                tin_no: '',
                tax_circle: '',
                tax_region_en: '',
                tax_region_bn: ''
            },
            org_address: { // Table Name: et_org_addresses
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
            },
            office_contact_info: { // Table Name:  et_office_contact_infos
                telephone_no: '',
                mobile_no: '',
                email: '',
                fax_no: ''
            },
            factory_contact_info: { // Table Name: et_factory_contact_infos
                telephone_no: '',
                mobile_no: '',
                email: '',
                fax_no: ''
            },
            contact_person_info: { // Table Name: et_contact_person_infos
                name_en: '',
                name_bn: '',
                mobile: '',
                designation_en: '',
                designation_bn: ''
            }
        },
        orgTab: {
            owner_info: { // Table Name: et_org_owner_infos
                owner_name_en: '',
                owner_name_bn: '',
                father_title_en: '',
                father_title_bn: '',
                father_husband_name_en: '',
                father_husband_name_bn: '',
                mother_title_en: '',
                mother_title_bn: '',
                mother_name_en: '',
                mother_name_bn: '',
                husband_title_en: '',
                husband_title_bn: '',
                husband_name_en: '',
                husband_name_bn: '',
                nid_no: '',
                gender: '',
                smart_id_no: '',
                designation_en: '',
                designation_bn: '',
                dob: '',
                district_of_birth: '',
                country_of_birth: ''
            },
            entrepreneurs: { // Table name: et_entrepreneurs
                name_en: '',
                name_bn: '',
                license_no: '',
                designation_en: '',
                designation_bn: '',
                license: '', // copy of update license
                certificate: '', // Certification of first class officer of the concerned bank
                product_service_name_details: [
                    {
                        name_en: '',
                        name_bn: ''
                    }
                ], // This array contain minimum one service or product table name et_entrepreneur_product_services
                directly_involced_business: 0
            },
            passport_info: { // Table Name: et_org_owner_passports
                women_entrepreneur: 2,
                passport_no: '',
                country_id: 0,
                issue_date: '',
                duration: ''
            },
            tax_info: { // Table Name: et_owner_tax_infos
                tin_no: '',
                tax_circle: '',
                tax_region_en: '',
                tax_region_bn: ''
            },
            contact_info: { // Table Name: et_owner_contact_infos
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
            applicant_selected_et_past_year: 2,
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
        et_selecteds: [],
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
        this.getEtData()
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
    this.application.name_en = this.commonProfile.name_en
    this.application.name_bn = this.commonProfile.name_bn
    this.application.mobile = this.commonProfile.mobile
    this.application.email = this.commonProfile.email

    this.orgTab.contact_info.mobile_no = this.commonProfile.mobile
    this.orgTab.contact_info.email = this.commonProfile.email
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
            this.$store.commit('ExternalUserService/addCurrentCircular', result.data)
        } else {
            this.isLoading = false
        }
    },
    async getEtData () {
        const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, etApplicationDetailsApi, { app_id: this.app_id })
        if (result.success) {
            const data = result.data
            this.getCurrentCircular(data.circular_id)
            if (data) {
                // tab - 1
                this.sectorId = data.product_service_sector_id
                this.application = {
                    user_id: data.user_id,
                    circular_id: data.circular_id,
                    product_service_sector_id: data.product_service_sector_id,
                    legal_form: data.legal_form,
                    latent_exporter: data.latent_exporter,
                    preview: NoImage,
                    photo: data.photo,
                    photo_file: '',
                    circular: data.circular,
                    circular_name: this.$i18n.locale === 'bn' ? data.circular.title_bn : data.circular.title_en,
                    org_info: data.org_info,
                    org_tax_info: data.org_tax_info,
                    org_address: data.org_address,
                    additional_org_address: data.additional_org_address !== null ? data.additional_org_address : data.additional_org_address,
                    office_contact_info: data.office_contact_info,
                    factory_contact_info: data.factory_contact_info,
                    contact_person_info: data.contact_person_info
                }
                this.activeIndex = 1
                // tab - 2
                if (data.owner_info) {
                    this.orgTab = {
                        owner_info: data.owner_info,
                        passport_info: data.passport_info,
                        tax_info: data.tax_info,
                        contact_info: data.contact_info,
                        entrepreneurs: data.entrepreneurs !== null ? data.entrepreneurs : this.orgTab.entrepreneurs
                    }
                    this.activeIndex = 2
                }
                // Tab 3
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
                    this.activeIndex = 3
                }
                // Tab 4
                if (data.bank.length > 0) {
                    this.banks = data.bank
                    this.activeIndex = 4
                }
                if (data.product_success_description.length > 0) {
                    this.descriptions = data.product_success_description
                    this.activeIndex = 5
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
                    if (data.et_selected.length > 0) {
                        this.et_selecteds = data.et_selected
                    }
                    this.activeIndex = 6
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
                this.$router.push({ path: 'export-trophy-application' })
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
            this.$router.push({ path: 'export-trophy-application' })
        }
    },
    async tabSubmitDescription () {
        const result = await this.$refs.description_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'export-trophy-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitBank () {
        const result = await this.$refs.bank_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'export-trophy-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitAddress () {
        const result = await this.$refs.address_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'export-trophy-application' })
            } else {
                return true
            }
        }
    },
    async tabSubmitOrganization () {
        const result = await this.$refs.organization_form.submit()
        if (result.success) {
            if (this.draft) {
                this.$router.push({ path: 'export-trophy-application' })
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
                this.$router.push({ path: 'export-trophy-application' })
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
