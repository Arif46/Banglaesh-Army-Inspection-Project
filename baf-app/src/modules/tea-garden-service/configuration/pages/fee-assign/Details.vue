<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <template>
                    <div style="font-size:12px; font-color:white; background-color: #dddddd; padding:6px">
                        <h5 class="card-title text-center" style="margin-bottom: 0;color: #214162;font-size: 1.40rem;"> {{ $t('teaGardenConfig.fee_assign') }} {{ $t('globalTrans.details') }}</h5>
                    </div>
                </template>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 10%"> {{$t('teaGardenConfig.service_name')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.service_bn : item.service_en }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('teaGardenConfig.fee_type')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.type_bn : item.type_en }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('teaGardenConfig.fee_amount')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ $n(item.amount) }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('teaGardenConfig.effective_from')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ item.effective_from | dateFormat }}</td>
                  </tr>
                  <tr>
                    <th style="width: 25%"> {{$t('teaGardenConfig.description')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">{{ ($i18n.locale === 'bn') ? item.description_bn : item.description_en }}</td>
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
import { teaGardenServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      valid: null,
      loading: false,
      errors: [],
      detailsData: [],
      detailsItemId: ''
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  }
}
</script>
