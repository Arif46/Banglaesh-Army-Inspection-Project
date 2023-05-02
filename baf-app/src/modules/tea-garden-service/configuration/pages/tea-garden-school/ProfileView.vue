<template>
    <div class="section-wrapper">
        <breadcumb />
        <b-overlay :show="loading">
        <div class="form-wrapper tea-garden-school-wrapper">
            <div class="header-title-wrapper">
                <h6 class="mb-0">{{ $t('teaGardenConfig.tea_garden_school') }}</h6>
            </div>
            <b-row>
                <b-col sm="4">
                    <b-card class="school-img-wrapper">
                        <b-card-text>
                            <img src="../../../../../assets/images/School-profile.png" class="img-fluid" alt="" />
                            <h5 class="school-name">
                                <span v-if="$i18n.locale === 'bn'">
                                {{ formData.school_name_bn }}
                                </span>
                                <span v-else>
                                {{ formData.school_name_en }}
                                </span>
                            </h5>
                            <p class="garden-name">{{ getTeaGardenName(formData.garden_id) }}</p>
                            <p class="garden-name address">
                                {{ $t('teaGardenConfig.division') }} #{{ getDivisionName(formData.division_id) }},
                                {{ $t('teaGardenConfig.district') }} #{{ getDistrictName(formData.district_id) }}
                                <span v-if="formData.city_corporation_id && formData.city_corporation_id !== 0">,{{ $t('teaGardenConfig.city_corporation') }} #{{ getCityCorporationName(formData.city_corporation_id) }}</span>
                                <span v-if="formData.upazila_id && formData.upazila_id !== 0">,{{ $t('teaGardenConfig.upazila') }} #{{ getUpzillaName(formData.upazila_id) }}</span>
                                <span v-if="formData.pauroshoba_id && formData.pauroshoba_id !== 0">,{{ $t('teaGardenConfig.municipality_name') }} #{{ getPauroshobaName(formData.pauroshoba_id) }}</span>
                                <span v-if="formData.union_id && formData.union_id !== 0">,{{ $t('teaGardenConfig.union') }} #{{ getUnionName(formData.union_id) }}</span>
                                <span v-if="$i18n.locale === 'bn'">,#{{ formData.address_bn }}</span>
                                <span v-else>,#{{ formData.address_en }}</span>
                            </p>
                            <div>
                                <router-link :to="{ name: 'tea_garden_service.configuration.tea-garden-school' }" class="mr-2 btn btn-light btn-sm"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</router-link>
                                <b-button @click="pdfExport" variant="primary" size="sm"><i class="ri-printer-fill"></i>  {{ $t('teaGardenConfig.Print') }}</b-button>
                            </div>
                        </b-card-text>
                    </b-card>
                    <b-card class="school-items-wrapper">
                        <b-card-text style="padding: 5px 10px;">
                            <ul>
                                <li>
                                    <span><i class="ri-function-line"></i> {{ $t('teaGardenConfig.school_category') }}</span>
                                    <span v-if="formData.school_category">{{ getSchoolCategoryName(formData.school_category) }}</span>
                                </li>
                                <li>
                                    <span><i class="ri-focus-2-line"></i> {{ $t('teaGardenConfig.school_type') }}</span>
                                    <span>
                                        {{ getSchoolTypeNameArrayData(formData.school_type) }}
                                    </span>
                                </li>
                                <li>
                                    <span><i class="ri-bubble-chart-line"></i> {{ $t('teaGardenConfig.school_status') }}</span>
                                    <span v-if="formData.school_status">{{ getSchoolStatusName(formData.school_status) }}</span>
                                </li>
                                <li>
                                    <span><i class="ri-user-location-line"></i> {{ $t('teaGardenConfig.school_location') }}</span>
                                    <span v-if="formData.school_location">{{ getSchoolLocationName(formData.school_location) }}</span>
                                </li>
                            </ul>
                        </b-card-text>
                    </b-card>
                </b-col>
                <b-col sm="8">
                    <b-card class="tea-school-card">
                        <b-card-text style="padding: 0 1.2rem;">
                            <b-row>
                                <b-col sm="12">
                                    <table class="table tea-school-table">
                                        <tbody>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.head_master_name') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                    {{ formData.h_master_name_bn }}
                                                    </span>
                                                    <span v-else>
                                                    {{ formData.h_master_name_en }}
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.mobile_no') }}</th>
                                                <td><span v-if="formData.h_master_mobile">{{ EngBangNum(formData.h_master_mobile) }}</span></td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.email') }}</th>
                                                <td>{{ formData.h_master_email }}</td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.establishment_year') }}</th>
                                                <td><span v-if="formData.estabs_year">{{EngBangNum(formData.estabs_year)  }}</span></td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.is_office_room') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                        <span v-if="formData.is_office_room === 1">
                                                            হ্যাঁ
                                                        </span>
                                                        <span v-else>
                                                            না
                                                        </span>
                                                    </span>
                                                    <span v-else>
                                                        <span v-if="formData.is_office_room === 1">
                                                        Yes
                                                         </span>
                                                        <span v-else>
                                                            No
                                                        </span>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.num_of_teacher') }}</th>
                                                <td><span v-if="formData.num_of_teacher">{{ EngBangNum(formData.num_of_teacher) }}</span></td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.num_of_latrine') }}</th>
                                                <td><span v-if="formData.num_of_latrine">{{ EngBangNum(formData.num_of_latrine) }}</span></td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.have_playground') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                        <span v-if="formData.have_playground === 1">
                                                            হ্যাঁ
                                                        </span>
                                                        <span v-else>
                                                            না
                                                        </span>
                                                    </span>
                                                    <span v-else>
                                                        <span v-if="formData.have_playground === 1">
                                                        Yes
                                                         </span>
                                                        <span v-else>
                                                            No
                                                        </span>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.have_flag_pillar') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                        <span v-if="formData.have_flag_pillar === 1">
                                                            হ্যাঁ
                                                        </span>
                                                        <span v-else>
                                                            না
                                                        </span>
                                                    </span>
                                                    <span v-else>
                                                        <span v-if="formData.have_flag_pillar === 1">
                                                        Yes
                                                         </span>
                                                        <span v-else>
                                                            No
                                                        </span>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.description') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                    {{ formData.description_bn }}
                                                    </span>
                                                    <span v-else>
                                                    {{ formData.description_en }}
                                                    </span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </b-col>
                            </b-row>
                        </b-card-text>
                    </b-card>
                </b-col>
            </b-row>
        </div>
        </b-overlay>
    </div>
</template>
<script>
    import ExportPdf from './export_pdf_profile'
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { teaGardenSchoolProfileView } from '../../api/routes'
    export default {
      name: 'ProfileView',
      data () {
        return {
          formData: {
            id: '',
            have_playground: false,
            have_flag_pillar: false,
            is_office_room: false,
            school_category: 0,
            garden_id: '0',
            school_type: [],
            area_type_id: '0',
            city_corporation_id: '0',
            pauroshoba_id: '0',
            ward_id: '0',
            country_id: 1,
            division_id: '0',
            district_id: '0',
            upazila_id: '0',
            union_id: '0',
            address_en: '',
            address_bn: ''
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
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${teaGardenSchoolProfileView}/${id}`)
        this.formData = result.data
        this.$store.dispatch('mutateCommonProperties', { loading: false })
        },
        getTeaGardenName (id) {
        const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            if (gardenInfo && this.$i18n.locale === 'bn') {
                return gardenInfo.text_bn
            } else if (gardenInfo && this.$i18n.locale === 'en') {
                return gardenInfo.text_en
            }
        },
        getSchoolLocationName (id) {
        const schoolLocation = this.$store.state.TeaGardenService.commonObj.schoolLocation.find(item => item.value === id)
            if (schoolLocation && this.$i18n.locale === 'bn') {
                return schoolLocation.text_bn
            } else if (schoolLocation && this.$i18n.locale === 'en') {
                return schoolLocation.text_en
            }
        },
        getSchoolStatusName (id) {
        const schoolStatus = this.$store.state.TeaGardenService.commonObj.schoolStatus.find(item => item.value === id)
            if (schoolStatus && this.$i18n.locale === 'bn') {
                return schoolStatus.text_bn
            } else if (schoolStatus && this.$i18n.locale === 'en') {
                return schoolStatus.text_en
            }
        },
        getSchoolCategoryName (id) {
        const schoolCategory = this.$store.state.TeaGardenService.commonObj.schoolCategory.find(item => item.value === id)
            if (schoolCategory && this.$i18n.locale === 'bn') {
                return schoolCategory.text_bn
            } else if (schoolCategory && this.$i18n.locale === 'en') {
                return schoolCategory.text_en
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
        getCityCorporationName (id) {
        const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
            if (cityCorporation && this.$i18n.locale === 'bn') {
                return cityCorporation.text_bn
            } else if (cityCorporation && this.$i18n.locale === 'en') {
                return cityCorporation.text_en
            }
        },
        getUpzillaName (id) {
        const upzilla = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
            if (upzilla && this.$i18n.locale === 'bn') {
                return upzilla.text_bn
            } else if (upzilla && this.$i18n.locale === 'en') {
                return upzilla.text_en
            }
        },
        getPauroshobaName (id) {
        const municipality = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
            if (municipality && this.$i18n.locale === 'bn') {
                return municipality.text_bn
            } else if (municipality && this.$i18n.locale === 'en') {
                return municipality.text_en
            }
        },
        getUnionName (id) {
        const union = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
            if (union && this.$i18n.locale === 'bn') {
                return union.text_bn
            } else if (union && this.$i18n.locale === 'en') {
                return union.text_en
            }
        },
        getSchoolTypeNameArrayData (data) {
           var schoolTypesName = []
           if (Array.isArray(data)) {
                data.forEach(arrItem => {
                const schoolType = this.$store.state.TeaGardenService.commonObj.trustType.find(item => item.value === arrItem)
                if (schoolType && this.$i18n.locale === 'bn') {
                    schoolTypesName.push(schoolType.text_bn)
                } else if (schoolType && this.$i18n.locale === 'en') {
                    schoolTypesName.push(schoolType.text_en)
                }
               })
            }
           return schoolTypesName.toString()
        },
        pdfExport () {
            const reportTitle = this.$t('teaGardenConfig.tea_garden_school')
            ExportPdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this)
        }
      }
    }
    </script>
