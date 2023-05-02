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
                                <b-th>{{ $t('globalTrans.org_name') }}</b-th>
                                <b-td>{{ (this.$i18n.locale == 'bn') ? detailsData.org_name_bn : detailsData.org_name }}</b-td>
                                <b-th>{{ $t('userManagement.office_type') }}</b-th>
                                <b-td >{{ (this.$i18n.locale=='bn')? detailsData.office_type_name_bn : detailsData.office_type_name }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-th>{{ $t('userManagement.office') }}</b-th>
                                <b-td>{{ (this.$i18n.locale=='bn')? detailsData.office_name_bn : detailsData.office_name }}</b-td>
                                <b-th>{{ $t('globalTrans.name') }}</b-th>
                                <b-td >{{ (this.$i18n.locale=='bn')? detailsData.name_bn : detailsData.name }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-th v-if="detailsData.area_type_id">{{ $t('bazarMonitoring.area_type') }}</b-th>
                                <b-td v-if="detailsData.area_type_id">{{ (this.$i18n.locale=='bn') ? detailsData.area_type_bn : detailsData.area_type }}</b-td>
                                <b-th v-if="detailsData.city_corporation_id">{{ $t('globalTrans.city_corporation') }}</b-th>
                                <b-td v-if="detailsData.city_corporation_id">{{ (this.$i18n.locale=='bn') ? detailsData.city_corporation_bn : detailsData.city_corporation }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-th v-if="detailsData.division_id">{{ $t('globalTrans.division') }}</b-th>
                                <b-td v-if="detailsData.division_id">{{ (this.$i18n.locale=='bn') ? detailsData.division_name_bn : detailsData.division_name }}</b-td>
                                <b-th v-if="detailsData.district_id">{{ $t('globalTrans.district') }}</b-th>
                                <b-td v-if="detailsData.district_id">{{ (this.$i18n.locale=='bn') ? detailsData.district_name_bn : detailsData.distrct_name }}</b-td>
                              </b-tr>
                              <b-tr>
                                <b-th v-if="detailsData.upazila_id">{{ $t('globalTrans.upazila') }}</b-th>
                                <b-td v-if="detailsData.upazila_id">{{ (this.$i18n.locale=='bn') ? detailsData.upazila_name_bn : detailsData.upazila_name }}</b-td>
                                <b-th v-if="detailsData.market_id">{{ $t('bazarMonitoring.market_name') }}</b-th>
                                <b-td v-if="detailsData.market_id">{{ (this.$i18n.locale=='bn')? detailsData.market_name_bn : detailsData.market_name_en }}</b-td>
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
        getDivisionNameList (divisionTyes) {
        const divisionList = JSON.parse(divisionTyes)
        const arr = []
        if (divisionList.length > 0) {
            divisionList.map((item, index) => {
                const divisionType = this.$store.state.CommonService.commonObj.divisionList.find(obj => obj.value === item)
                const divisionName = this.currentLocale === 'bn' ? divisionType.text_bn : divisionType.text_en
                if (index === 0) {
                    arr.push(divisionName)
                } else {
                    arr.push(' ' + divisionName)
                }
            })
        }
        return arr.toString()
        }
    }
}
</script>
