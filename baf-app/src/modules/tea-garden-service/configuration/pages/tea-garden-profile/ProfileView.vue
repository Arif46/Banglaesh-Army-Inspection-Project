<template>
    <div class="section-wrapper">
        <breadcumb />
        <b-overlay :show="loading">
        <div class="form-wrapper tea-garden-profile-wrapper">
            <b-card header-tag="header">
                <template #header>
                    <h6 class="mb-0">{{ $t('teaGardenConfig.tea_garden_profile') }}</h6>
                    <b-button variant="primary" @click="pdfExport" size="sm"><i class="ri-printer-fill"></i>  {{ $t('teaGardenConfig.Print') }}</b-button>
                </template>
                <b-card-text>
                    <h6 class="pro-title"><i class="ri-folder-info-line"></i> {{ $t('teaGardenConfig.general_information') }}</h6>
                    <b-row class="mb-2">
                        <b-col sm="12">
                            <table class="table table-bordered tea-profile-table">
                                <tbody>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_id_no') }}</th>
                                        <td>{{ EngBangNum(formData.garden_id_no) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.owner_name') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                            {{ formData.owner_name_bn }}
                                            </span>
                                            <span v-else>
                                            {{ formData.owner_name_en }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_authority_email') }}</th>
                                        <td>{{ formData.email }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_authority_mobile') }}</th>
                                        <td>{{ EngBangNum(formData.mobile) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.company_name') }}</th>
                                        <td>{{ getTeaCompanyName(formData.tea_company_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.company_address') }}</th>
                                        <td>{{ getTeaCompanyAddress(formData.tea_company_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.tea_garden_name') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                            {{ formData.tea_garden_name_bn }}
                                            </span>
                                            <span v-else>
                                            {{ formData.tea_garden_name_en }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_type') }}</th>
                                        <td><span v-if="formData.garden_type !== 0">{{ getTeaGardenTypeName(formData.garden_type) }}</span></td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.registration_no') }}</th>
                                        <td>
                                            <span v-if="formData.registration_no_en">
                                            {{ formData.registration_no_en }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.has_own_garden') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                              <span v-if="formData.has_own_garden === 1">
                                                হ্যাঁ
                                              </span>
                                              <span v-else>
                                                না
                                              </span>
                                            </span>
                                            <span v-else>
                                                <span v-if="formData.has_own_garden === 1">
                                                Yes
                                              </span>
                                              <span v-else>
                                                No
                                              </span>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_class') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                            {{ formData.garden_class_bn }}
                                            </span>
                                            <span v-else>
                                            {{ formData.garden_class_en }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.tea_garden_valley') }}</th>
                                        <td>{{ getValleyName(formData.valley_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.division') }}</th>
                                        <td>{{ getDivisionName(formData.division_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.district') }}</th>
                                        <td>{{ getDistrictName(formData.district_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_address') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                            {{ formData.garden_address_bn }}
                                            </span>
                                            <span v-else>
                                            {{ formData.garden_address_en }}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.garden_history') }}</th>
                                        <td>
                                            <span v-if="$i18n.locale === 'bn'">
                                            {{ formData.garden_history_bn }}
                                            </span>
                                            <span v-else>
                                            {{ formData.garden_history_en }}
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </b-col>
                    </b-row>
                    <h6 class="pro-title"><i class="ri-information-line"></i> {{ $t('teaGardenConfig.land_lease_information') }}</h6>
                    <b-row class="mb-2">
                        <b-col sm="12">
                            <table class="table table-bordered tea-profile-table">
                                <tbody>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.total_land') }}</th>
                                        <td>{{ $n(formData.land_lease_info.total_land) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.lease_start_date') }}</th>
                                        <td>{{ EngBangNum(formData.land_lease_info.lease_start_date) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.lease_end_date') }}</th>
                                        <td>{{EngBangNum(formData.land_lease_info.lease_end_date)  }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.lease_duration') }}</th>
                                        <td>{{ $n(formData.land_lease_info.lease_duration) }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.reg_lease_deed_no') }}</th>
                                        <td>{{ formData.land_lease_info.reg_lease_deed_no }}</td>
                                    </tr>
                                    <tr>
                                        <th scope="col">{{ $t('teaGardenConfig.lease_deed_date') }}</th>
                                        <td>{{ EngBangNum(formData.land_lease_info.lease_deed_date)  }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </b-col>
                    </b-row>
                    <h6 class="pro-title"><i class="ri-information-line"></i> {{ $t('teaGardenConfig.human_resource_information') }}</h6>
                    <b-row>
                        <b-col sm="12">
                            <table class="table table-bordered tea-profile-table">
                                <tbody>
                                    <tr>
                                        <th scope="col" style="width: 33.33%">{{ $t('teaGardenConfig.register_info_heading') }}</th>
                                        <th scope="col" style="width: 33.33%">{{ $t('teaGardenConfig.unregister_info_heading') }}</th>
                                        <th scope="col" style="width: 33.33%">{{ $t('teaGardenConfig.dependent_info_heading') }}</th>
                                    </tr>
                                    <tr>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.male') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.register_labor_male">
                                                                {{ $n(formData.human_resource_info.register_labor_male) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.male') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.unregister_labor_male">
                                                                {{ $n(formData.human_resource_info.unregister_labor_male) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.male') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.dependent_labor_male">
                                                                {{ $n(formData.human_resource_info.dependent_labor_male) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.female') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.register_labor_female">
                                                                {{ $n(formData.human_resource_info.register_labor_female) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.female') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.unregister_labor_female">
                                                                {{  $n(formData.human_resource_info.unregister_labor_female) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td class="p-0">
                                            <table class="table mb-0 sub-table">
                                                <tbody>
                                                    <tr>
                                                        <td class="w-50">{{ $t('teaGardenConfig.female') }}</td>
                                                        <td class="w-50">
                                                            <span v-if="formData.human_resource_info && formData.human_resource_info.dependent_labor_female">
                                                                {{ $n(formData.human_resource_info.dependent_labor_female) }}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </b-col>
                    </b-row>
                    <router-link :to="{ name: 'tea_garden_service.configuration.tea_garden_profile' }" variant="light"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</router-link>
                </b-card-text>
            </b-card>
        </div>
        </b-overlay>
    </div>
</template>
<script>
    import ExportPdf from './export_pdf_profile'
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { teaGardenProfileView } from '../../api/routes'
    const today = new Date().toISOString().substr(0, 10)
    export default {
      name: 'ProfileView',
      data () {
        return {
          formData: {
            id: '',
            garden_id_no: '',
            tea_company_id: 0,
            tea_garden_name_en: '',
            tea_garden_name_bn: '',
            garden_type: 0,
            registration_no_en: '',
            has_own_garden: 2,
            garden_class_en: '',
            garden_class_bn: '',
            valley_id: 0,
            area_type_id: '0',
            city_corporation_id: '0',
            pauroshoba_id: '0',
            ward_id: '0',
            country_id: 1,
            division_id: '0',
            district_id: '0',
            upazila_id: '0',
            union_id: '0',
            garden_address_en: '',
            garden_address_bn: '',
            mobile: '',
            email: '',
            garden_history_en: '',
            garden_history_bn: '',
            land_lease_info: {
              id: '',
              tea_garden_gen_info_id: 0,
              total_land: '',
              lease_start_date: today,
              lease_end_date: '',
              lease_duration: '',
              reg_lease_deed_no: '',
              lease_deed_date: today
            },
            human_resource_info: {
              id: '',
              tea_garden_gen_info_id: '',
              register_labor_male: '',
              register_labor_female: '',
              unregister_labor_male: '',
              unregister_labor_female: '',
              dependent_labor_male: '',
              dependent_labor_female: ''
            }
          }
        }
      },
      created () {
        if (this.$route.query.id) {
          this.getData(this.$route.query.id)
        }
      },
      computed: {
         currentLocale () {
           return this.$i18n.locale
         },
         loading () {
            return this.$store.state.commonObj.loading
         }
      },
      methods: {
        EngBangNum (n) {
            if (this.$i18n.locale === 'bn') {
                return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
            } else {
                return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
            }
        },
        async getData (id) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${teaGardenProfileView}/${id}`)
        this.formData = result.data
        this.$store.dispatch('mutateCommonProperties', { loading: false })
        },
        getValleyName (id) {
        const valleyInfo = this.$store.state.TeaGardenService.commonObj.masterValleyList.find(item => item.value === id)
            if (valleyInfo && this.$i18n.locale === 'bn') {
                return valleyInfo.text_bn
            } else if (valleyInfo && this.$i18n.locale === 'en') {
                return valleyInfo.text_en
            }
        },
        getTeaCompanyName (id) {
        const companyInfo = this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.find(item => item.value === id)
            if (companyInfo && this.$i18n.locale === 'bn') {
                return companyInfo.text_bn
            } else if (companyInfo && this.$i18n.locale === 'en') {
                return companyInfo.text_en
            }
        },
        getTeaCompanyAddress (id) {
        const companyInfo = this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.find(item => item.value === id)
            if (companyInfo && this.$i18n.locale === 'bn') {
                return companyInfo.address_bn
            } else if (companyInfo && this.$i18n.locale === 'en') {
                return companyInfo.address_en
            }
        },
        getTeaGardenTypeName (id) {
        const gardenType = this.$store.state.TeaGardenService.commonObj.gardenType.find(item => item.value === id)
            if (gardenType && this.$i18n.locale === 'bn') {
                return gardenType.text_bn
            } else if (gardenType && this.$i18n.locale === 'en') {
                return gardenType.text_en
            }
        },
        getDivisionName  (id) {
        const division = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
            if (division && this.$i18n.locale === 'bn') {
                return division.text_bn
            } else if (division && this.$i18n.locale === 'en') {
                return division.text_en
            }
        },
        getDistrictName (id) {
        const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
            if (district && this.$i18n.locale === 'bn') {
                return district.text_bn
            } else if (district && this.$i18n.locale === 'en') {
                return district.text_en
            }
        },
        pdfExport () {
            const reportTitle = this.$t('teaGardenConfig.tea_garden_profile')
            const generalTitle = this.$t('teaGardenConfig.general_information')
            const landLeaseTitle = this.$t('teaGardenConfig.land_lease_information')
            const humanInfoTitle = this.$t('teaGardenConfig.human_resource_information')
            ExportPdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this, generalTitle, landLeaseTitle, humanInfoTitle)
        }
      }
    }
    </script>
