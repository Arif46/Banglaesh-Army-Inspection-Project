<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12" v-if="items.feedback != null">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{$t('globalTrans.feedback')}} {{$t('globalTrans.description')}}</th>
                                <td colspan="3" style="width: 35%" > : {{currentLocale === 'en'? items.feedback.feedback_description  : items.feedback.feedback_description_bn}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('policyAdvocacy.policy')}} {{$t('policyAdvocacy.recommendation')}}</th>
                                <td colspan="3" style="width: 35%" > : {{currentLocale === 'en'? items.feedback.policy_recommendation  : items.feedback.policy_recommendation_bn}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.date')}} </th>
                                <td style="width: 35%">: {{ items.feedback.date | dateFormat}}</td>
                            </tr>
                              <tr>
                                <th style="width: 20%">{{ $t('globalTrans.feedback')}}  {{ $t('globalTrans.attachment')}} </th>
                                <td style="width: 35%">:
                                    <span v-if="items.feedback.feedback_attachment">
                                        <a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.feedback.feedback_attachment" title="Application Attachment"><i class="ri-file-download-line"></i>&nbsp;
                                        </a>
                                    </span>
                                    <span v-else>{{ 'N/A' }}</span></td>
                            </tr>
                              <tr>
                                <th style="width: 20%"> {{$t('policyAdvocacy.recommendation')}}  {{ $t('globalTrans.attachment')}} </th>
                                <td style="width: 35%">:
                                    <span v-if="items.feedback.recommendation_attachment">
                                        <a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.feedback.recommendation_attachment" title="Application Attachment"><i class="ri-file-download-line"></i>&nbsp;
                                        </a>
                                    </span>
                                    <span v-else>{{ 'N/A' }}</span></td>
                            </tr>
                        </table>
                    </b-col>
                    <b-col md="12" v-else>
                       <p class="text-danger"> {{$t('Advocacy.feedback_msg')}}</p>
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
        getDivisionName (Id) {
            const Obj = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === parseInt(Id))
            if (Obj) {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
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
