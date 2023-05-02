<template>
  <div class="section-wrapper">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.prepare_rfp') }}</h4>
            </template>
            <template v-slot:body>
               <table class="table table-sm table-borderless">
<!--                 <tr>-->
<!--                   <th width="40%">{{$t('research_plan_management.rfp_type')}}</th>-->
<!--                   <th width="7%">:</th>-->
<!--                   <td>{{ currentLocale === 'bn'? detailsData.rfp_type_bn : detailsData.rfp_type_en }}</td>-->
<!--                 </tr>-->
<!--                 <tr v-if="detailsData.rfp_type === 1">-->
<!--                   <th>{{ $t('research_plan_management.eoi_reference_no') }}</th>-->
<!--                   <th>:</th>-->
<!--                   <td>{{ detailsData.eoi_reference_no }}</td>-->
<!--                 </tr>-->
<!--                 <tr v-if="detailsData.rfp_type === 1">-->
<!--                   <th>{{ $t('research_plan_management.eoi_title') }}</th>-->
<!--                   <th>:</th>-->
<!--                   <td>{{ currentLocale === 'bn'? detailsData.eoi_title_bn : detailsData.eoi_title_en }}</td>-->
<!--                 </tr>-->
                 <tr>
                   <th style="width: 20%"> {{$t('research_plan_management.rfp_type')}}</th>
                   <td style="width: 30%">: {{ currentLocale === 'bn'? detailsData.rfp_type_bn : detailsData.rfp_type_en }}</td>
                   <th style="width: 20%" v-if="detailsData.rfp_type === 1"> {{ $t('research_plan_management.eoi_reference_no') }}</th>
                   <td v-if="detailsData.rfp_type === 1">: {{ detailsData.eoi_reference_no }}</td>
                 </tr>
                 <tr v-if="detailsData.rfp_type === 1">
                   <th> {{ $t('research_plan_management.eoi_title') }}</th>
                   <td colspan="3">: {{ currentLocale === 'bn'? detailsData.eoi_title_bn : detailsData.eoi_title_en }}</td>
                 </tr>
                 <tr v-if="detailsData.rfp_type === 1">
                   <th> {{ $t('research_plan_management.procuring_entity') }}</th>
                   <td colspan="3">: {{ detailsData.procuring_entity }}</td>
                 </tr>
                 <tr>
                   <th> {{ $t('research_plan_management.rfp_title') }}</th>
                   <td colspan="3">: {{ currentLocale === 'bn'? detailsData.rfp_title_bn : detailsData.rfp_title_en }}</td>
                 </tr>
                 <tr>
                   <th> {{ $t('research_plan_management.rfp_no') }}</th>
                   <td>: {{ detailsData.rfp_no }}</td>
                   <th> {{ $t('globalTrans.date') }}</th>
                   <td>: {{ detailsData.rfp_date | dateFormat }}</td>
                 </tr>
                 <tr>
                   <th> {{ $t('research_plan_management.proposal_submission_date') }}</th>
                   <td>: {{ detailsData.proposal_submission_date | dateFormat }}</td>
                   <th> {{ $t('research_plan_management.proposal_submission_time') }}</th>
                   <td>: {{ detailsData.proposal_submission_time }}</td>
                 </tr>
                 <tr v-if="detailsData.attachment">
                   <th>{{ $t('bfti.attachment') }}</th>
                   <td>
                     : <a :href="bftiResReportServiceBaseUrl + (isImage(detailsData.attachment) ? 'storage/' : '') +detailsData.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a>
                   </td>
                 </tr>
               </table>
            </template>
          </body-card>
        </b-col>
      </b-row>
  </div>
</template>
<script>
import { bftiResReportServiceBaseUrl } from '@/config/api_config'

export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      valid: null,
      loading: false,
      detailsData: {},
      detailsItemId: '',
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl
    }
  },
  computed: {
    rfpTypeList () {
      return [
        {
          value: 1,
          text_en: 'EOI',
          text_bn: 'ইওআই',
          text: this.currentLocale === 'bn' ? 'ইওআই' : 'EOI'
        },
        {
          value: 2,
          text_en: 'Without EOI',
          text_bn: 'ইওআই ছাড়া',
          text: this.currentLocale === 'bn' ? 'ইওআই ছাড়া' : 'Without EOI'
        }
      ]
    },
    currentLocale () {
      return this.$i18n.locale
    },
    eoiList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.eoiList
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFormData()
      this.detailsData = tmp
      const eoi = this.eoiList.find(obj => obj.value === parseInt(this.detailsData.prepare_eoi_id))
      this.detailsData.eoi_reference_no = eoi?.eoi_reference_no
      this.detailsData.procuring_entity = this.currentLocale === 'en' ? eoi?.name_of_procuring_entity : eoi?.name_of_procuring_entity_bn
      this.detailsData.proposal_submission_time = this.c24hTo12h(this.detailsData.proposal_submission_time)
    }
  },
  methods: {
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    },
    c24hTo12h (time) {
      // Check correct time format and split into components
      time = time.toString().match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time]
      if (time.length > 1) { // If time format correct
        time = time.slice(1) // Remove full string match value
        time[5] = +time[0] < 12 ? ' AM' : ' PM' // Set AM/PM
        time[0] = +time[0] % 12 || 12 // Adjust hours
        time[0] = ('0' + +time[0]).slice(-2) // add zero for number less than 10
      }
      return time.join('') // return adjusted time or original string
    }
  }
}
</script>
