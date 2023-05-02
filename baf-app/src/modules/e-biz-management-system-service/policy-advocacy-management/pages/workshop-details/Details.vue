<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 25px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 17%">{{$t('teaGardenService.application_id')}}</th>
                                <td style="width: 35%" >: {{items.application_idd}}</td>
                                <th style="width: 17%">{{$t('policyAdvocacy.workshop_name')}}</th>
                                <td style="width: 35%" > : {{ ($i18n.locale === 'bn') ? items.workshop_name_bn : items.workshop_name }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{ $t('policyAdvocacy.workshop_place_name')}}</th>
                                <td style="width: 35%">: {{ ($i18n.locale === 'bn') ? items.workshop_place_bn : items.workshop_place }}</td>
                                <th style="width: 17%">{{ $t('policyAdvocacy.workshop_date_from')}}</th>
                                <td style="width: 35%">: {{ items.start_date | dateFormat }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{ $t('policyAdvocacy.workshop_date_to')}}</th>
                                <td style="width: 35%">: {{ items.end_date | dateFormat }}</td>
                                <th style="width: 17%">{{ $t('globalTrans.attachment')}}</th>
                                <td style="width: 35%">: <a target="_blank" class="btn btn-primary btn-sm btn-outline mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.attachment" :title="$t('globalTrans.download')"><i class="ri-file-download-line"></i>&nbsp;</a></td>
                            </tr>
                            <tr>
                                <th style="width: 17%">{{$t('globalTrans.description')}}</th>
                                <td colspan="3" style="width: 85%">: <div v-html="items.description"></div> </td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
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
              eBizServiceBaseUrl: eBizServiceBaseUrl
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
    }
}

</script>
