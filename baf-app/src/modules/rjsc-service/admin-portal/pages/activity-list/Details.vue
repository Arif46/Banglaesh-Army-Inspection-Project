<template>
    <b-row>
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-row>
                      <b-col lg="12" sm="12">
                        <div>
                          <b-table-simple hover small>
                            <b-tr>
                              <b-th style="width:20%">{{ $t('rjscAdminPortal.activity_name') }}</b-th>
                              <b-th style="width:2%">:</b-th>
                              <b-td style="width:78%">{{ (this.$i18n.locale == 'bn') ? detailsData.name_bn : detailsData.name_en }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th style="width:20%">{{ $t('rjscAdminPortal.logo') }}</b-th>
                              <b-th style="width:2%">:</b-th>
                              <b-td style="width:78%">
                                <img :src="rjscServiceBaseUrl + 'storage/' + detailsData.logo" style="width: 60px; height: 40px; border-radius: 50% !important;" class="center">
                              </b-td>
                            </b-tr>
                          </b-table-simple>
                          <b-table-simple bordered hover small>
                            <b-tbody>
                              <tr>
                                <b-th colspan="3" class="text-center">
                                  <h5 style="background: #e3e3e3; padding: 10px;">{{ $t('rjscAdminPortal.activity_list') }}</h5>
                                </b-th>
                              </tr>
                              <tr>
                                <b-th style="width:20%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                <b-th style="width:30%" class="text-left">{{ $t('globalTrans.title') }}</b-th>
                                <b-th style="width:50%" class="text-left">{{ $t('globalTrans.url') }}</b-th>
                              </tr>
                              <tr v-for="(detail, inx) in detailsData.lists" :key="inx">
                                <b-td class="text-center">{{ $n(inx + 1) }}</b-td>
                                <b-td class="text-left">{{ $i18n.locale === 'en' ? detail.title_en : detail.title_bn }}</b-td>
                                <b-td class="text-left">{{ detail.url }}</b-td>
                              </tr>
                            </b-tbody>
                          </b-table-simple>
                        </div>
                      </b-col>
                    </b-row>
                  </b-col>
              </b-row>
            </template>
          </body-card>
        </b-col>
      </b-row>
    </b-row>
</template>
<script>

import { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'Details',
    props: ['id'],
    data () {
      return {
      valid: null,
      rjscServiceBaseUrl: rjscServiceBaseUrl,
      loading: false,
      errors: [],
      detailsData: []
      }
    },
    created () {
    if (this.id) {
      const tmp = this.getPortInfo()
      this.detailsData = tmp
    }
    },
    methods: {
    getPortInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
    }
}
</script>
