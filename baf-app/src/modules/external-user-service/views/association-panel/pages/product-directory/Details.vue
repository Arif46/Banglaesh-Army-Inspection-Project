<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.council_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getCouncilName(items.council_info_id)}} </td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.association_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getAssociationName(items.association_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.type_of_business')}}</th>
                                <td style="width: 35%" > : {{ getProductInfo(items.product_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('InformationTraining.company_name')}}</th>
                                <td style="width: 35%" > : {{currentLocale == 'bn' ? items.company_name_bn : items.company_name}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('InformationTraining.price_local')}} </th>
                                <td style="width: 35%">: {{ $n(items.price_local) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('InformationTraining.price_fob')}}</th>
                                <td style="width: 35%">: {{ $n(items.price_fob) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('InformationTraining.minimum_order')}}</th>
                                <td style="width: 35%" > : {{ $n(items.minimum_order)}}</td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 20%">{{$t('InformationTraining.product_details')}}</th>
                                <td colspan="3" style="width: 85%"> : {{ currentLocale == 'bn' ? items.product_details_bn : items.product_details}} </td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
import AddressHelper from '@/utils/area-type-address'
import { eBizServiceBaseUrl } from '@/config/api_config'
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
              AddressHelper: AddressHelper,
              eBizServiceBaseUrl: eBizServiceBaseUrl,
              profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
     getCouncilName (councilNameId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
     },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
      getProductInfo (businessId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.productInfoList.filter(item => item.status === 1).find(item => item.value === businessId)
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
