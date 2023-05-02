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
                                <th style="width: 10%">{{$t('InformationTraining.number_of_trainees')}}</th>
                                <td style="width: 35%" > : {{ $n(items.number_of_trainees)}}</td>
                            </tr>
                            <tr>
                                <th style="width: 10%">{{ $t('InformationTraining.trainee_organization')}} </th>
                                <td style="width: 35%">: {{ currentLocale == 'bn' ? items.trainee_organization_bn : items.trainee_organization }}</td>
                            </tr>
                            <tr>
                                <th style="width: 10%">{{ $t('InformationTraining.trainer_name')}} </th>
                                <td style="width: 35%">: {{ currentLocale == 'bn' ? items.trainer_name_bn : items.trainer_name }}</td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 10%">{{$t('InformationTraining.trainer_information')}}</th>
                                <td colspan="3" style="width: 85%"> : {{ currentLocale == 'bn' ? items.trainer_information_bn : items.trainer_information}} </td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 10%">{{$t('InformationTraining.program_image')}}</th>
                                <td colspan="3" style="width: 85%">
                                    <div id="preview">
                                        <img v-if="items.program_image !== null || items.program_image !== ''" :src="eBizServiceBaseUrl + 'download-attachment?file=storage/' + items.program_image" style="height:200px;width:200px;"/>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                            <th style="width: 17%"> {{ $t('globalTrans.attachment') }}</th>
                                <td style="width: 30%">:
                                    <span><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.report_attachment" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
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
