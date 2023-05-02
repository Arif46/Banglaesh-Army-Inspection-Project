<template>
    <div>
        <b-row>
            <b-col sm="4">
                {{$t('exportTrophyConfig.awardType')}} : {{ getAwardType(form.award_type) }}
            </b-col>
            <b-col sm="4" v-if="form.award_type === 1">
                {{$t('globalTrans.year')}} : {{ $n(form.year, { useGrouping: false }) }}
            </b-col>
            <b-col sm="4" v-if="form.award_type === 1">
                {{$t('exportTrophyConfig.cip_category')}} : {{ cipCategoryItem(form.cip_category) }}
            </b-col>
            <b-col sm="4" v-else>
                {{$t('globalTrans.fiscal_year')}} : {{ getFiscalYear(form.fiscal_year_id) }}
            </b-col>
        </b-row>
        <b-row class="mt-3">
            <b-col>
              <table class="table table-striped table-hover table-bordered" v-if="form.award_type === 1 && form.details.length !== 0">
                <thead>
                  <tr>
                    <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                    <th scope="col"> {{ $t('exportTrophyConfig.cip_sector') }} </th>
                    <th scope="col">{{ $t('globalTrans.quantity') }}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in form.details" :key="index">
                    <th scope="row"> {{ $n(index + 1, { useGrouping:false }) }} </th>
                    <td v-if="id">
                      {{ getSectorId(item.cip_sector_id) }}
                    </td>
                    <td v-else>
                      {{ currentLocale === 'bn' ? item.text_bn : item.text_en }}
                    </td>
                    <td>
                      {{ $n(item.quantity, { useGrouping: false }) }}
                    </td>
                  </tr>
                </tbody>
              </table>
              <table class="table table-striped table-hover table-bordered" v-if="form.award_type === 2">
                <thead>
                  <tr>
                    <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                    <th scope="col"> {{ $t('exportTrophyConfig.medal') }} </th>
                    <th scope="col">{{ $t('globalTrans.quantity') }}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row"> {{ $n(1, { useGrouping: false }) }} </th>
                    <td>
                      {{ $t('exportTrophyConfig.gold') }}
                    </td>
                    <td>
                      {{ $n(form.gold, { useGrouping: false }) }}
                    </td>
                  </tr>
                  <tr>
                    <th scope="row"> {{ $n(2, { useGrouping: false }) }} </th>
                    <td>
                      {{ $t('exportTrophyConfig.silver') }}
                    </td>
                    <td>
                      {{ $n(form.silver, { useGrouping: false }) }}
                    </td>
                  </tr>
                  <tr>
                    <th scope="row"> {{ $n(3, { useGrouping: false }) }} </th>
                    <td>
                      {{ $t('exportTrophyConfig.bronze') }}
                    </td>
                    <td>
                      {{ $n(form.bronze, { useGrouping: false }) }}
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
      const tmp = this.getAssignTrophy()
      this.form = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    cipCategoryList: function () {
      return [
        {
          value: 1,
          text: this.currentLocale === 'bn' ? 'সিআইপি রপ্তানি' : 'CIP Export'
        },
        {
          value: 2,
          text: this.currentLocale === 'bn' ? 'সিআইপি ট্রেড' : 'CIP Trade'
        }
      ]
    }
  },
  methods: {
    getAssignTrophy () {
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
    getSectorId (cipSectorId) {
      const sectorObj = this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.find(cipSec => cipSec.value === cipSectorId)
      if (sectorObj !== undefined) {
        return this.$i18n.locale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    cipCategoryItem (item) {
      const cipCategoryObj = this.cipCategoryList.find(cipItem => cipItem.value === parseInt(item))
      if (cipCategoryObj !== undefined) {
        return cipCategoryObj.text
      }
    }
  }
}
</script>
