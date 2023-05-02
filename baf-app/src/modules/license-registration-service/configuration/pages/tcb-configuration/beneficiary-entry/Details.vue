<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                        <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('bazarMonitoring.area_type')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? beneficiary.area_type_name : beneficiary.area_type_name_bn }} </td>
                                <th style="width: 20%">{{ $t('globalTrans.division')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? beneficiary.division_name : beneficiary.division_name_bn }} </td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.district') }}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? beneficiary.district_name : beneficiary.district_name_bn }} </td>
                                <th style="width: 20%" v-if="beneficiary.city_corporation_id">{{ $t('globalTrans.city_corporation') }}</th>
                                <td style="width: 30%" v-if="beneficiary.city_corporation_id">{{ currentLocale === 'en'? beneficiary.city_corporation : beneficiary.city_corporation_bn }} </td>
                            </tr>
                            <tr>
                                <th style="width: 20%" v-if="beneficiary.upazila_id">{{ $t('globalTrans.upazila') }}</th>
                                <td style="width: 30%" v-if="beneficiary.upazila_id">{{ getUpazilaList(beneficiary.upazila_id) }} </td>
                                <th style="width: 20%" v-if="beneficiary.pauroshoba_id">{{ $t('globalTrans.pouroshova') }}</th>
                                 <td style="width: 30%" v-if="beneficiary.pauroshoba_id">{{ pauroshobaName(beneficiary.pauroshoba_id) }} </td>
                            </tr>
                            <!-- <tr>
                                <th style="width: 20%" v-if="beneficiary.union_id">{{ $t('globalTrans.union') }}</th>
                                <td style="width: 30%" v-if="beneficiary.union_id">{{ unionName(beneficiary.union_id) }} </td>
                            </tr> -->
                        </table>
                    </b-col>
                </b-row>
                 <b-row>
                  <b-col md="12">
                <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                    <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                                <tr class="bg-primary">
                                    <th scope="col" style="width: 10%;" class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                                    <th scope="col" class="text-center">{{ $t('globalTrans.union') }}</th>
                                    <th scope="col" class="text-center">{{ $t('globalTrans.ward') }}</th>
                                    <th scope="col" class="text-center">{{ $t('tcbconfiguration.beneficiary_count') }}</th>
                                </tr>
                            </thead>
                        <tbody>
                            <template v-if="beneficiary.beficiary_details && beneficiary.beficiary_details.length > 0">
                                <tr v-for="(item, index) in beneficiary.beficiary_details" :key="index">
                                    <td  class="text-center">{{ $n(index+1) }}</td>
                                    <td class="text-center">{{ unionList(item.union_id) }}</td>
                                    <td class="text-center">{{ wardList(item.ward_id) }}</td>
                                    <td class="text-center">{{ $n(item.beneficiary_count, { useGrouping: false }) }}</td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                </tr>
                            </template>
                        </tbody>
                        </table>
                    </div>
                <!-- &&&&&&&&&&&&&&Manual Info Details End&&&&&&&&&&&&&&& -->
                  </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
    props: ['item'],
    components: {
    },
    created () {
      this.beneficiary = this.item
    },
    data () {
        return {
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        getUpazilaList (upazilaId) {
            const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === upazilaId)
            if (typeof upazilaObj !== 'undefined') {
                return (this.currentLocale === 'en' ? upazilaObj.text_en : upazilaObj.text_bn)
            }
        },
        wardList (wardId) {
            const wardObj = this.$store.state.CommonService.commonObj.wardList.find(item => item.value === wardId)
            if (wardObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return wardObj.text_bn
                } else {
                    return wardObj.text_en
                }
            }
        },
        pauroshobaName (pauId) {
            const pauroObj = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === pauId)
            if (pauroObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return pauroObj.text_bn
                } else {
                    return pauroObj.text_en
                }
            }
        },
        unionList (unionId) {
            const unionObj = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === unionId)
            if (unionObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return unionObj.text_bn
                } else {
                    return unionObj.text_en
                }
            }
        }
    }
}

</script>
