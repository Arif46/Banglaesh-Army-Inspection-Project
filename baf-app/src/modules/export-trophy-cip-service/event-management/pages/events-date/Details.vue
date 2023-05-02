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
                          <b-table-simple striped bordered small>
                            <b-tr>
                              <b-th>{{ $t('eventManage.event_title') }}</b-th>
                              <b-td>{{ (this.$i18n.locale == 'bn') ? detailsData.title_bn : detailsData.title_en }}</b-td>
                              <b-th>{{ $t('eventManage.venue') }}</b-th>
                              <b-td >{{ (this.$i18n.locale=='bn')? detailsData.venue_name_bn : detailsData.venue_name }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.date') }}</b-th>
                              <b-td>{{  detailsData.date | dateFormat }}</b-td>
                              <b-th>{{ $t('eventManage.start_time') }}</b-th>
                              <b-td >{{ EngBangNum(detailsData.start_time )}}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('eventManage.end_time') }}</b-th>
                              <b-td >{{ EngBangNum(detailsData.end_time) }}</b-td>
                              <b-th>{{ $t('globalTrans.description') }}</b-th>
                              <b-td >{{ (this.$i18n.locale == 'bn')? detailsData.description_bn : detailsData.description_en }}</b-td>
                            </b-tr>
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
export default {
    name: 'Details',
    props: ['id', 'item'],
    data () {
        return {
        valid: null,
        loading: false,
        errors: [],
        detailsData: [],
        detailsItemId: ''
        }
    },
    created () {
        if (this.id) {
          const tmp = this.item
          this.detailsData = tmp
        }
    },
    methods: {
      EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
          return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
          return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
      }
    }
}
</script>
