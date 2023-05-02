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
                          <b-table-simple bordered hover small>
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
                          </b-table-simple>
                          <b-table-simple bordered hover small>
                              <b-tbody>
                                  <tr>
                                      <b-th colspan="8" class="text-center p-2" style="background: #e3e3e3">{{ $t('tradeFairConfig.committee_member_info') }}</b-th>
                                  </tr>
                                  <tr>
                                      <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                      <b-th class="text-center">{{ $t('globalTrans.name') }}</b-th>
                                      <b-th class="text-center">{{ $t('globalTrans.designation') }}</b-th>
                                      <b-th class="text-center">{{ $t('tradeFairConfig.committee_roll') }}</b-th>
                                      <b-th class="text-center">{{ $t('globalTrans.org_name') }}</b-th>
                                      <b-th class="text-center">{{ $t('tradeFairConfig.contract_no') }}</b-th>
                                      <b-th class="text-center">{{ $t('globalTrans.email') }}</b-th>
                                      <b-th class="text-center">{{ $t('globalTrans.address') }}</b-th>
                                  </tr>
                                  <tr v-for="(detail, inx) in detailsData.details" :key="inx">
                                      <b-td class="text-center" style="width: 7%">{{ $n(inx + 1) }}</b-td>
                                      <b-td class="text-left" style="width: 13%">{{ $i18n.locale === 'en' ? detail.name_en : detail.name_bn }}</b-td>
                                      <b-td class="text-left" style="width: 13%">{{ $i18n.locale === 'en' ? detail.designation_en : detail.designation_bn }}</b-td>
                                      <b-td class="text-left" style="width: 13%">{{ getRoll(detail.committee_roll_id) }}</b-td>
                                      <b-td class="text-left" style="width: 15%">{{ $i18n.locale === 'en' ? detail.org_name_en : detail.org_name_bn }}</b-td>
                                      <!-- <b-td class="text-left" style="width: 13%">{{ detail.contract_no }}</b-td> -->
                                      <b-td class="text-left" style="width: 13%">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(detail.contact_no, { useGrouping: false }) }}</b-td>
                                      <b-td class="text-left" style="width: 13%">{{ detail.email }}</b-td>
                                      <b-td class="text-left" style="width: 13%">{{ $i18n.locale === 'en' ? detail.address_en : detail.address_bn }}</b-td>
                                  </tr>
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
      const dataRoll = this.$store.state.TradeFairService.commonObj.committeeRollList.find(item => item.status === 1 && item.value === id)
      if (typeof dataRoll !== 'undefined') {
        return this.currentLocale === 'bn' ? dataRoll.text_bn : dataRoll.text_en
      } else {
        return ''
      }
    },
    getCommitteeInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
    }
}
</script>
