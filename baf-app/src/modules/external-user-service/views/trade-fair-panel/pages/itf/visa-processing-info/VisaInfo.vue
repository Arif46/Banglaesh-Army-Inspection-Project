<template>
  <b-row>
    <b-col xs="12" sm="12" md="12" lg="12" xl="12">
        <b-table-simple v-if="visa_detail?.visa_docs.length" bordered hover small>
            <b-thead>
                <!-- <b-tr>
                    <b-th colspan="4" class="text-center p-2" style="background: #e3e3e3">{{ $t('tradeFairConfig.visa_related_attach') }}</b-th>
                </b-tr> -->
                <b-tr class="bg-primary">
                    <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th>{{ $t('globalTrans.document_name') }}</b-th>
                    <b-th style="width:25%" class="text-center">{{ $t('globalTrans.attachment') }}</b-th>
                    <b-th class="text-center">{{ $t('globalTrans.comments') }}</b-th>
                </b-tr>
            </b-thead>
            <b-tbody>
                <b-tr v-for="(item, index) in visa_detail?.visa_docs" :key="index">
                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                    <b-td>{{ $i18n.locale === 'en' ? item.doc_name_en : item.doc_name_bn }}</b-td>
                    <b-td class="text-center">
                        <a target="_blank" v-if="item.attachment" :href="baseUrl + 'storage/' + item.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                    </b-td>
                    <b-td v-if="index == 0" :rowspan="visa_detail.visa_docs.length">{{ visa_detail.visa_info.author_remarks }}</b-td>
                </b-tr>
            </b-tbody>
        </b-table-simple>
        <b-table-simple v-if="visa_detail.visa_info?.visa_start_date" hover small>
            <b-tr>
               <b-th colspan="4" class="text-center p-2" style="background: #e3e3e3">{{ $t('tradeFairConfig.participant_visa_info') }}</b-th>
            </b-tr>
            <b-tr>
                <b-th style="width:20%">{{ $t('tradeFairConfig.valid_from') }}</b-th>
                <b-td style="width:30%">: {{ visa_detail.visa_info.visa_start_date | dateFormat }}</b-td>
                <b-th style="width:20%">{{ $t('tradeFairConfig.expiration_date') }}</b-th>
                <b-td style="width:30%">: {{ visa_detail.visa_info.visa_end_date | dateFormat }}</b-td>
            </b-tr>
            <b-tr>
                <b-th>{{ $t('globalTrans.attachment') }}</b-th>
                <b-td colspan="3">
                    : <a target="_blank" v-if="visa_detail.visa_info.visa_attachment" :href="baseUrl + 'storage/' + visa_detail.visa_info.visa_attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                </b-td>
            </b-tr>
            <b-tr>
                <b-th>{{ $t('tradeFairConfig.participant_note') }}</b-th>
                <b-td colspan="3">: {{ visa_detail.visa_info.participant_note }}</b-td>
            </b-tr>
        </b-table-simple>
    </b-col>
  </b-row>
</template>
<script>
export default {
  name: 'VisaInfo',
  props: ['visa_detail', 'baseUrl'],
  data () {
    return {}
  }
}
</script>
