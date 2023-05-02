<template>
    <div>
        <b-row>
            <b-col sm="6">
                {{$t('exportTrophyConfig.awardType')}} : {{ getAwardType(form.award_type) }}
            </b-col>
            <b-col sm="6" v-if="form.award_type === 1">
                {{$t('globalTrans.year')}} : {{ $n(form.year, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" v-else>
                {{$t('globalTrans.fiscal_year')}} : {{ getFiscalYear(form.fiscal_year_id) }}
            </b-col>
        </b-row>
        <b-row class="mt-3">
            <b-col>
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr>
                            <th scope="col"> {{ $t('globalTrans.sl_no') }} </th>
                            <th scope="col" v-if="form.award_type === 1"> {{ $t('exportTrophyConfig.product_sector_name') }} </th>
                            <th scope="col" v-else> {{ $t('exportTrophyConfig.product_and_service_sector') }} </th>
                            <th scope="col">{{ $t('exportTrophyConfig.minimum_income_usd') }}</th>
                        </tr>
                    </thead>
                    <tbody v-if="form.details.length !== 0">
                        <tr v-for="(item, index) in form.details" :key="index">
                        <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                        <td>
                            {{ getServiceProduct(item.product_service_sector_id) }}
                        </td>
                        <td>
                            {{ $n(item.minimum_income, { useGrouping: false }) }}
                        </td>
                        </tr>
                    </tbody>
                </table>
            </b-col>
        </b-row>
        <b-row class="text-right">
            <b-col>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
      </b-row>
    </div>
</template>
<script>
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      valid: null,
      errors: [],
      form: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAssignIncome()
      this.form = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getAssignIncome () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getAwardType (assignTypeId) {
      const awardType = this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.find(assignType => assignType.value === parseInt(assignTypeId))
      if (awardType !== 'undefined') {
        return this.currentLocale === 'bn' ? awardType.text_bn : awardType.text_en
      }
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getServiceProduct (serviceProduct) {
      const exportSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(exportSector => exportSector.value === parseInt(serviceProduct))
      if (exportSectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? exportSectorObj.text_bn : exportSectorObj.text_en
      }
    }
  }
}
</script>
