<template>
    <div>
      <b-row>
        <b-col class="sm">
          <b-button variant="primary" @click="pdfExport" class="mb-2 float-right">
            {{  $t('globalTrans.export_pdf') }}
          </b-button>
      </b-col>
      </b-row>
      <b-card>
        <b-row>
           <report-heading/>
        </b-row>
        <b-row>
          <b-col xs="12" sm="12" md="10" lg="10" xl="10">
          </b-col>
          <b-col xs="12" sm="12" md="2" lg="2" xl="2" class="text-left">
            <p class="tagBorder">{{ $t('portal.first_tag')}}</p>
          </b-col>
        </b-row>
        <b-row class="mt-2">
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              {{ $t('exportTrophyCircular.memo_no')}} : {{ EngBangNum(details.memorial_no) }}
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" class="text-right">
              {{ $t('globalTrans.date')}} : {{ details.notice_date | dateFormat }}
          </b-col>
        </b-row>
        <b-row>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-center mt-2">
              <h3 class="titlebold">{{ currentLocale === 'bn' ? details.title_bn : details.title_en }}</h3>
            </b-col>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="mt-2 fontSize titleLighter">
                <div v-if="currentLocale === 'en'" v-html="details.description_en"></div>
                <div v-if="currentLocale === 'bn'" v-html="details.description_bn"></div>
            </b-col>
        </b-row>
      </b-card>
      <b-row>
          <b-col xs="12" sm="12" md="8" lg="8" xl="8">
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" style="margin-top: 14rem !important">
            <p class="text-center"> {{ $t('portal.detail_bottom_tile')}}</p>
          </b-col>
        </b-row>
        <b-row class="text-right mt-4">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import ReportHeading from '../../components/ReportHeadingDealerPortal.vue'
import ExportPdf from './export_pdf_details'
export default {
  name: 'Details',
  props: ['id', 'item'],
  components: {
    ReportHeading
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      valid: null,
      errors: [],
      form: []
    }
  },
  created () {
      this.details = this.item
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
     EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    pdfExport () {
      ExportPdf.exportPdfDetails(this, this.details, this.EngBangNum)
    }
  }
}
</script>
<style scoped>
 .fontSize{
    text-align: justify;
    text-justify: inter-word;
  }
  .titlebold{
    font-weight: bold;
  }
  .titleLighter {
    font-weight: lighter;
    font-size: 20px;
  }
  .tagBorder {
    border: 1px solid black;
    padding: 10px;
    margin-right: -9px
  }
</style>
