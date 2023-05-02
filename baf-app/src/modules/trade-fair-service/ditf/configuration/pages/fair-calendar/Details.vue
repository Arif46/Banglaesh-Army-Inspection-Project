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
                          <!-- <b-table-simple bordered hover small>
                            <b-tr>
                              <b-th style="width:20%">{{ $t('tradeFairConfig.committee_type') }}</b-th>
                              <b-td style="width:30%">{{ (this.$i18n.locale == 'bn') ? detailsData.Committee_type_bn : detailsData.Committee_type_en }}</b-td>
                              <b-th style="width:20%">{{ $t('tradeFairConfig.committee_name') }}</b-th>
                              <b-td style="width:30%">{{ (this.$i18n.locale=='bn')? detailsData.committee_name_bn : detailsData.committee_name_en }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('tradeFairConfig.committee_formation_date') }}</b-th>
                              <b-td>{{ detailsData.committee_formation_date | dateFormat }}</b-td>
                              <b-th>{{ $t('tradeFairConfig.committee_tenure_date') }}</b-th>
                              <b-td >{{ detailsData.committee_tenure_date | dateFormat }}</b-td>
                            </b-tr>
                          </b-table-simple> -->
                          <b-table-simple bordered hover small>
                              <b-tbody>
                                  <tr>
                                      <b-th colspan="8" class="text-center p-2" style="background: #e3e3e3">{{ $t('ditfConfig.fair_calendar') }}</b-th>
                                  </tr>
                                  <tr>
                                      <b-th class="text-center">{{ $t('globalTrans.year') }}</b-th>
                                      <b-td class="text-left" colspan="3">{{ $n(detailsData.year, { useGrouping : false }) }}</b-td>
                                  </tr>
                                  <tr>
                                      <b-th class="text-center" style="width: 15%">{{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }}</b-th>
                                      <b-td class="text-left">{{ detailsData.title_en }}</b-td>
                                      <b-th class="text-center">{{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }}</b-th>
                                      <b-td class="text-left">{{ detailsData.title_bn }}</b-td>
                                  </tr>
                                  <tr>
                                      <b-th class="text-center">{{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }} </b-th>
                                      <b-td class="text-left">{{ detailsData.description_en }}</b-td>
                                      <b-th class="text-center" style="width: 15%">{{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}</b-th>
                                      <b-td class="text-left">{{ detailsData.description_bn }}</b-td>
                                  </tr>
                                  <tr>
                                      <b-th class="text-center">{{ $t('globalTrans.start_date') }}</b-th>
                                      <b-td class="text-left">{{ detailsData.start_date | dateFormat }}</b-td>
                                      <b-th class="text-center">{{ $t('globalTrans.end_date') }}</b-th>
                                      <b-td class="text-left">{{ detailsData.end_date | dateFormat }}</b-td>
                                  </tr>
                                  <!-- <tr>
                                      <b-th class="text-center">{{ $t('globalTrans.end_date') }}</b-th>
                                      <b-td class="text-center">{{ detailsData.end_date }}</b-td>
                                      <b-th class="text-center">{{ '' }}</b-th>
                                      <b-td class="text-center">{{ '' }}</b-td>
                                  </tr> -->
                              </b-tbody>
                          </b-table-simple>
                        </div>
                      </b-col>
                    </b-row>
                  </b-col>
              </b-row>
            </template>
            <!-- <pre>{{detailsData}}</pre> -->
          </body-card>
        </b-col>
      </b-row>
    </b-row>
</template>
<script>
export default {
    name: 'Details',
    props: ['id'],
    data () {
      return {
      valid: null,
      loading: false,
      errors: [],
      detailsData: []
      }
    },
    created () {
    if (this.id) {
      const tmp = this.getCommitteeInfo()
      this.detailsData = tmp
    }
    },
    methods: {
    getRoll (id) {
      const data = this.$store.state.TradeFairService.commonObj.committeeRollList.find(item => item.status === 1 && item.value === id)
      if (this.currentLocale === 'bn') {
        return data !== 'undefined' ? data.text_bn : ''
      } else {
        return data !== 'undefined' ? data.text_en : ''
      }
    },
    getCommitteeInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
    }
}
</script>
