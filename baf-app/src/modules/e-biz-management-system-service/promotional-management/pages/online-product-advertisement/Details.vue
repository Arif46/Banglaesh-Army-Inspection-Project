<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{$t('globalTrans.application_id')}}</th>
                                <td colspan="3" style="width: 85%">: {{ items.application_id }} </td>
                            </tr>
                            <tr v-if="$i18n.locale === 'en'">
                                <th style="width: 20%">{{ $t('exportTrophyCircular.title') }}</th>
                                <td colspan="3" style="width: 85%">: {{ items.advertisement_title_en }}</td>
                            </tr>
                            <tr v-if="$i18n.locale === 'bn'">
                                <th style="width: 20%">{{ $t('exportTrophyCircular.title') }}</th>
                                <td colspan="3" style="width: 85%">: {{ items.advertisement_title_bn }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.price') }} </th>
                                <td style="width: 35%" >: {{ $n(items.price, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.offer_price') }}</th>
                                <td style="width: 35%">: {{  $n(items.offer_price, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 20%">{{ $t('globalTrans.url') }}</th>
                                <td style="width: 35%" >: {{items.url }}</td>
                            </tr>
                            <tr>
                                <th class="mt-2" style="width: 20%">{{$t('globalTrans.expiry_title')}}</th>
                                <td style="width: 35%" v-if="items.expiry_date > '0000-00-00' ">:
                                    {{ items.expiry_date | dateFormat }}
                                </td>
                            </tr>
                        </table>
                    </b-col>
                    <b-col md="12" v-if="$i18n.locale === 'en'">
                    {{$t('eBizConfig.description')}}
                        <span v-html="items.description_en"></span>
                    </b-col>
                        <b-col md="12" v-if="$i18n.locale === 'bn'">
                        {{$t('eBizConfig.description')}}
                        <span v-html="items.description_bn"></span>
                    </b-col>
                    <b-col md="12">
                        <b>{{ $t('globalTrans.attachment')}} </b>:
                        <br>
                    <span v-if="items.attachment_main">
                        <a target="_blank" :href="eBizServiceBaseUrl+'download-attachment?file='+ 'storage' +items.attachment_main" title="Download">
                        <img class="img-thumbnail w-25" style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_main" alt="Profile Image">
                        </a>
                    </span>
                    <span v-else>{{items.attachment_main}}</span>
                    </b-col>
                    <hr>
                    <b-col md="3">
                    <span v-if="items.attachment_one">
                        <a target="_blank" :href="eBizServiceBaseUrl+'download-attachment?file='+ 'storage' +items.attachment_one" title="Download">
                        <img class="img-thumbnail w-50" style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_one" alt="Profile Image">
                        </a>
                    </span>
                    <span v-else>{{items.attachment_one}}</span>
                    </b-col>
                    <b-col md="3">
                    <span v-if="items.attachment_two">
                        <a target="_blank" :href="eBizServiceBaseUrl+'download-attachment?file='+ 'storage' +items.attachment_two" title="Download">
                        <img class="img-thumbnail w-50" style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_two" alt="Profile Image">
                        </a>
                    </span>
                    <span v-else>{{items.attachment_two}}</span>
                    </b-col>
                    <b-col md="3">
                    <span v-if="items.attachment_three">
                        <a target="_blank" :href="eBizServiceBaseUrl+'download-attachment?file='+ 'storage' +items.attachment_three" title="Download">
                        <img class="img-thumbnail w-50" style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_three" alt="Profile Image">
                        </a>
                    </span>
                    <span v-else>{{items.attachment_three}}</span>
                    </b-col>
                    <b-col md="3">
                    <span v-if="items.attachment_four">
                        <a target="_blank" :href="eBizServiceBaseUrl+'download-attachment?file='+ 'storage' +items.attachment_four" title="Download">
                        <img class="img-thumbnail w-50" style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_four" alt="Profile Image">
                        </a>
                    </span>
                    <span v-else>{{items.attachment_four}}</span>
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
      }
    }
}

</script>
