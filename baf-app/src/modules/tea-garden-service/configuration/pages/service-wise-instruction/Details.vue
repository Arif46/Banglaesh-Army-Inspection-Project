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
                        <h5 class="card-title text-center" style="margin-bottom: 0;color: #214162;font-size: 1.40rem;"> {{ $t('teaGardenConfig.instruction_list') }} {{ $t('globalTrans.details') }}</h5>
                    </div>
                </template>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 10%"> {{$t('teaGardenConfig.service_name')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.service_bn : item.service_en }}</td>
                  </tr>
                   <tr>
                    <th style="width: 25%"> {{$t('teaGardenConfig.instruction')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 70%">
                      <div v-if="$i18n.locale === 'bn'" v-html="item.instruction_bn">
                      </div>
                      <div v-else v-html="item.instruction_en">
                      </div>
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
import { teaGardenServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
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
