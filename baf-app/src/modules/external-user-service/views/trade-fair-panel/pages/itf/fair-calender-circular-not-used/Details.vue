<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title mb-0" style="font-weight:550;"> {{ $t('tradeFairInfoManagement.fair_calender_circular') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 28%"> {{$t('globalTrans.fiscal_year')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">{{currentLocale === 'bn'? viewData.fiscal_year_bn : viewData.fiscal_year_en}}</td>
                  </tr>
                  <tr>
                    <th style="width: 28%"> {{$t('tradeFairInfoManagement.circular_memo_no')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">{{ viewData.circular_memo_number}}</td>
                  </tr>
                  <tr>
                    <th style="width: 28%"> {{$t('tradeFairInfoManagement.subject')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">{{currentLocale === 'bn'? viewData.subject_bn : viewData.subject_en}}</td>
                  </tr>
                  <tr>
                    <th style="width: 28%"> {{$t('globalTrans.description')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">{{currentLocale === 'bn'? viewData.description_bn : viewData.description_en}}</td>
                  </tr>
                  <tr>
                    <th style="width: 28%"> {{$t('tradeFairInfoManagement.submission_deadline')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">{{ viewData.submission_deadline | dateFormat }}</td>
                  </tr>
                  <tr>
                    <th style="width: 28%"> {{ $t('globalTrans.attachment')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 68%">
                      <a target="_blank" v-if="viewData.attachment" :href="internationalTradeFairServiceBaseUrl + 'storage/itf/tfim/fcc/' + viewData.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                      <a target="_blank" v-else>{{ $t('externalTradeFair.not_uploaded') }} </a>
                    </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
      </b-col>
    </b-row>
</template>
<script>
import { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      viewData: [],
      detailsItemId: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCalenderCircular()
      this.viewData = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getCalenderCircular () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
