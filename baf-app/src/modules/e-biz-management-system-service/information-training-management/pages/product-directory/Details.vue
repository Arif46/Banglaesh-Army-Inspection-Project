<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{$t('InformationTraining.product_image')}}</th>
                                <td colspan="3"><img class="img w-75" :src="eBizServiceBaseUrl + 'download-attachment?file=storage/' + items.product_image" alt="Profile Image"></td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.council_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{currentLocale == 'bn' ? items.council_name_bn : items.council_name_en}} </td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.association_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{currentLocale == 'bn' ? items.association_name_bn : items.association_name_en}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.product_name')}}</th>
                                <td style="width: 35%" > : {{currentLocale == 'bn' ? items.product_info_bn : items.product_info_en}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('InformationTraining.price_local')}}</th>
                                <td style="width: 35%" > : {{ $n(items.price_local) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('InformationTraining.price_fob')}} </th>
                                <td style="width: 35%">: {{ $n(items.price_fob) }}</td>
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
              profile: this.$store.state.ExternalUserService.eBizPanel.commonObj.associationProfile
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
     getCouncilName (councilNameId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
     },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
      getTypeOfBusiness (businessId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.typeOfBusinessList.find(item => item.value === businessId)
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
