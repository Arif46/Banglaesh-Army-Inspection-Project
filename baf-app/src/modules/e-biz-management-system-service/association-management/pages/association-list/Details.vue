<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <!-- <tr>
                                <th style="width: 17%">{{$t('eBizConfig.council_name')}} </th>
                                <td style="width: 35%">: {{ getCouncilName(items.council_info_id)}}</td>
                                <th style="width: 17%">{{$t('eBizConfig.association_name')}}</th>
                                <td style="width: 35%"> : {{ getAssociationName(items.association_info_id) }} </td>
                            </tr> -->
                            <tr>
                                <th style="width: 17%">{{$t('eBizConfig.council_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getCouncilName(items.council_info_id)}} </td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{$t('eBizConfig.association_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getAssociationName(items.association_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{$t('associationPnl.establish_date')}}</th>
                                <td style="width: 35%" >: {{items.establish_date | dateFormat}}</td>
                                <th style="width: 17%">{{$t('eBizConfig.contact_person_name')}}</th>
                                <td style="width: 35%" > : {{currentLocale === 'en'? items.contact_person_name_en : items.contact_person_name_bn}}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{ $t('eBizConfig.mobile_no')}} </th>
                                <td style="width: 35%">: {{ items.mobile | mobileNumber }}</td>
                                <th style="width: 17%">{{ $t('globalTrans.email')}}</th>
                                <td style="width: 35%">: {{ items.email }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{ $t('globalTrans.gender')}}</th>
                                <td style="width: 35%">: {{ getGenderName(items.gender) }}</td>
                                <th style="width: 17%">{{ $t('globalTrans.nid')}}</th>
                                <td style="width: 35%">: {{ items.nid }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{$t('eBizConfig.description')}}</th>
                                <td colspan="3" style="width: 85%">: {{ currentLocale === 'en'? items.description_en : items.description_bn}} </td>
                            </tr>
                        </table>
                        <b-row>
                    <b-col lg="12" sm="12">
                        <p class="text-black" style="border-bottom: 1px solid #ddd; font-weight: bold">
                            {{ $t('globalTrans.present_address') + ' :' }}
                        </p>
                    </b-col>
                    <b-col lg="12" sm="12">
                        <table class="table table-sm table-borderless">
                          <tr>
                              <th width="15%">{{$t('globalTrans.division')}}</th>
                              <td width="35%">: {{ getDivisionName(items.division_id) }}</td>
                              <th width="15%">{{$t('globalTrans.district')}}</th>
                              <td width="35%">: {{ AddressHelper.getDistrictName(items.district_id) }}</td>
                          </tr>
                          <tr>
                              <th>{{$t('globalTrans.upazila')}}</th>
                              <td>: {{ items.upazila_id ? AddressHelper.getUpazilaName(items.upazila_id) : 'N/A' }}</td>
                              <th>{{$t('globalTrans.city_corporation')}}</th>
                              <td>: {{ items.city_corporation_id ? AddressHelper.getCityCorporationName(items.city_corporation_id) : 'N/A' }}</td>
                          </tr>
                          <tr>
                              <th>{{$t('globalTrans.pouroshova')}}</th>
                              <td>: {{ items.pauroshoba_id ? AddressHelper.getPauroshobaName(items.pauroshoba_id) : 'N/A' }}</td>
                              <th>{{$t('globalTrans.union')}}</th>
                              <td>: {{ items.union_id ? AddressHelper.getUnionName(items.union_id) : 'N/A' }}</td>
                          </tr>
                        </table>
                    </b-col>
                </b-row>
                    </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
import AddressHelper from '@/utils/area-type-address'
export default {
    props: ['items'],
    components: {
    },
    created () {
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
              AddressHelper: AddressHelper
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
    getDivisionName (Id) {
      const Obj = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === parseInt(Id))
      if (Obj) {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ''
      }
    },
     getCouncilName (councilNameId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
     },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
      getGenderName (genId) {
        const cateObj = this.$store.state.commonObj.genderList.find(item => item.value === genId)
        if (cateObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return cateObj.text_bn
            } else {
                return cateObj.text_en
            }
        }
      }
    }
}

</script>
