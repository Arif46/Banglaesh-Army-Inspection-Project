<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <div class="row mb-3">
                  <div class="col-md-3">
                  <img :src="bftiResReportServiceBaseUrl + 'storage/' +item.image" alt="image" width="110" height="100"></div>
                  <div class="col-md-8">
                    <h4 class="mt-1" style="color:#035EAE !important; font-size:30px">{{(currentLocale === 'bn'? item.name_bn : item.name_en)}}</h4>
                    <p><b>{{(($i18n.locale === 'bn') ? item.organization_bn : item.organization)}}</b></p>
                    <p><b>{{(($i18n.locale === 'bn') ? item.designation_bn : item.designation)}}</b></p>
                  </div>
                </div>
              </b-col>
              <hr>
              <b-col lg="12" sm="12">
                <template>
                    <div style="font-size:12px; font-color:white; background-color: #dddddd; padding:6px">
                        <h5 class="card-title text-center" style="margin-bottom: 0;color: #214162;font-size: 1.40rem;"> {{ $t('configuration.ger_info') }}</h5>
                    </div>
                </template>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 25%"> {{$t('configuration.contact_no')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(item.contact_no, { useGrouping: false }) }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('globalTrans.email')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.email : item.email }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('configuration.area_of_interest')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.area_of_interests_bn : item.area_of_interests_en }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('configuration.area_of_specialization')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.area_of_specialization_bn : item.area_of_specialization_en }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('configuration.general_expertise')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.general_expertise_bn : item.general_expertise_en }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('configuration.curriculum_vitae')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">
                      <a target="_blank" v-if="item.curriculum_vitae" :href="bftiResReportServiceBaseUrl + item.curriculum_vitae">{{ $t('bfti.attachment_down')}}</a>
                    </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
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
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      loading: false,
      item: {},
      errors: [],
      detailsData: [],
      detailsItemId: ''
    }
  },
  created () {
    const tmp = this.getLawEntry()
    this.item = tmp
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
