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
                                <th style="width: 20%">{{$t('informationTraining.program_name')}}</th>
                                <td style="width: 35%" > : {{currentLocale == 'bn' ? items.program_name_bn : items.program_name}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('globalTrans.fiscal_year')}}</th>
                                <td style="width: 35%"> : {{ getName(items.fiscal_year_id, 'fiscal_year') }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('informationTraining.training_type')}}</th>
                                <td style="width: 35%"> : {{currentLocale == 'bn' ? items.training_type_bn : items.training_type}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('informationTraining.content_name')}}</th>
                                <td style="width: 35%" > : {{currentLocale == 'bn' ? items.content_name_bn : items.content_name}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('informationTraining.content_attachment')}} </th>
                                <td style="width: 35%">:
                                    <span v-if="items.content_attachment !== null"><a target="_blank" class="btn btn-primary mr-2"
                                            :href="eBizServiceBaseUrl+'download-attachment?file='+items.content_attachment"
                                            title="Training Document"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                    <span v-else>N/A</span>
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('informationTraining.remarks')}}</th>
                                <td style="width: 35%" > : {{currentLocale == 'bn' ? items.remarks_bn : items.remarks}}</td>
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
              eBizServiceBaseUrl: eBizServiceBaseUrl
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
        getName (id, type) {
            let obj = {}
            if (type === 'fiscal_year') {
                obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
            }
            return this.$i18n.locale === 'bn' ? obj?.text_bn : obj?.text_en
        }
    }
}

</script>
