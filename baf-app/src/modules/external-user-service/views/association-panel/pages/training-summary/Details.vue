<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 10%">{{$t('eBizConfig.council_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getCouncilName(items.council_info_id)}} </td>
                            </tr>
                            <tr>
                                <th style="width: 10%">{{$t('eBizConfig.association_name')}}</th>
                                <td colspan="3" style="width: 85%">: {{ getAssociationName(items.association_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 10%">{{$t('eBizProgram.program_name')}}</th>
                                <td style="width: 35%" > : {{ currentLocale == 'bn' ? items.program_name_bn : items.program_name}}</td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 10%">{{$t('InformationTraining.training_description')}}</th>
                                <td colspan="3" style="width: 85%"> : {{ currentLocale == 'bn' ? items.summary.training_description_bn : items.summary.training_description}} </td>
                            </tr>
                            <tr>
                            <th style="width: 17%"> {{ $t('globalTrans.attachment') }}</th>
                                <td style="width: 30%">:
                                    <span v-if="items.summary.training_documents !== null"><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.summary.training_documents" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                    <span v-else>N/A</span>
                                </td>
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
      getTypeOfBusiness (businessId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.typeOfBusinessList.filter(item => item.status === 1).find(item => item.value === businessId)
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
