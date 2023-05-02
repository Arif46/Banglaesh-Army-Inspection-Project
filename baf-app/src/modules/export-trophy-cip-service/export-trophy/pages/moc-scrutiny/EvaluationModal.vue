<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="unitLoad">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <div class="w-50 m-auto">
            <h5 class="text-center font-weight-bold"> {{ $t('externalUser.export_product_sector') }} : {{ sector_name }}</h5>
        </div>
        <b-col lg="12" sm="12" class="mt-3" style="font-size: 14px">
            <b-row>
                <b-col class="float-left">
                    <span><strong>{{ $t('exportTrophy.org_name_address') }} </strong></span><br>
                    <span>{{ currentLocale === 'bn' ? application.org_info.org_name_bn : application.org_info.org_name_en }} <br/>
                    {{ AddressHelper.getCommonAddress(application.org_address) }}</span>
                </b-col>
                <b-col class="float-right" sm="8">
                    <b-table-simple bordered class="p-0">
                        <thead>
                            <tr>
                                <th class="text-center p-1" width="100px">{{ $t('globalTrans.sl_no') }}</th>
                                <th class="p-1" scope="col">{{ $t('exportTrophy.section') }}</th>
                                <th class="text-center p-1" scope="col">{{ $t('globalTrans.total_number') }}</th>
                                <th class="text-center p-1" scope="col">{{ $t('globalTrans.total') }}</th>
                            </tr>
                        </thead>
                        <b-tbody>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(1) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_export_earning') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(60, { useGrouping: false }) }}</td>
                                <td class="align-middle text-center" rowspan="5" scope="col">{{ $n(100, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(2) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_increase_income') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(10, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(3) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.number_on_product_new_market') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(10, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(4) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_number_new_product_add') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(10, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(5) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_number_on_compliance') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(10, { useGrouping: false }) }}</td>
                            </tr>
                        </b-tbody>
                    </b-table-simple>
                </b-col>
            </b-row>
            <h6 class="mb-2 font-weight-bold">{{ $t('exportTrophy.evaluation') + ' ' + $t('globalTrans.entry') + ' :' }}</h6>
            <b-table-simple bordered>
                <thead class="text-center bg-primary text-white">
                    <tr>
                        <th colspan="3" class="align-middle">{{ $t('exportTrophy.export_income_fob') }}</th>
                        <th rowspan="2" class="align-middle">
                          <span v-if="currentLocale === 'en'">{{ 'Income growth in ' }}</span>
                          {{ fiscalYearName(application.product_success_description[0].fiscal_year_id) }}
                          <span>{{ currentLocale === 'bn' ? ' এর তুলনায়' : ' fiscal year compared to'}}</span>
                          {{ fiscalYearName(application.product_success_description[1].fiscal_year_id) }}
                          <span v-if="currentLocale === 'bn'">{{ ' অর্থ বছরের রপ্তানি প্রবৃদ্ধি' }}</span>
                        </th>
                        <!-- <th rowspan="2" class="align-middle">{{ 'প্রধান প্রধান রপ্তানি বাজার' }}</th> -->
                        <th rowspan="2" class="align-middle">{{ $t('exportTrophy.entering_new_market') }}</th>
                        <th rowspan="2" class="align-middle">{{ $t('exportTrophy.new_product_addition') }}</th>
                        <th rowspan="2" class="align-middle">{{ $t('exportTrophy.compliance') }}</th>
                        <th rowspan="2" class="align-middle">{{ $t('exportTrophy.position') + ' ' + $t('globalTrans.and') + ' ' + $t('exportTrophy.number_obtained') }}</th>
                    </tr>
                    <tr>
                        <th class="align-middle">{{ fiscalYearName(application.product_success_description[0].fiscal_year_id) }}</th>
                        <th colspan="2" class="align-middle">{{ fiscalYearName(application.product_success_description[1].fiscal_year_id) }}</th>
                    </tr>
                    <tr>
                        <td>{{ $n(1) }}</td>
                        <td>{{ $t('exportTrophy.b_prc') }}</td>
                        <td>{{ $t('exportTrophy.bb_data') }}</td>
                        <td>{{ $n(2) }}</td>
                        <td>{{ $n(3) }}</td>
                        <td>{{ $n(4) }}</td>
                        <td>{{ $n(5) }}</td>
                        <td>{{ $n(6) }}</td>
                        <!-- <td>{{ $n(7) }}</td> -->
                    </tr>
                </thead>
                <b-tbody>
                    <b-tr class="text-center">
                        <b-td>{{ $n(application.evaluation.previous_export_income_usd) }}</b-td>
                        <b-td>{{ $n(application.evaluation.current_export_income_usd) }}</b-td>
                        <b-td>{{ $n(application.evaluation.bb_export_income_usd) }}</b-td>
                        <b-td>{{ $n(application.evaluation.income_growth, { useGrouping: false }) + '%' }}</b-td>
                        <b-td v-if="new_destinations.length > 0">
                          <span v-for="(item, index) in new_destinations" :key="index">
                            {{ countryName(item) }} <span v-if="new_destinations.length !== (index + 1)">{{ ', ' }}</span>
                          </span>
                        </b-td>
                        <b-td v-else>-</b-td>
                        <b-td v-if="new_products.length > 0">
                          <span v-for="(item, index) in new_products" :key="index">
                            {{ productName(item) }} <span v-if="new_products.length !== (index + 1)">{{ ', ' }}</span>
                          </span>
                        </b-td>
                        <b-td v-else>-</b-td>
                        <b-td>
                          <span v-if="compliance === 1">
                            {{  currentLocale === 'bn' ? 'প্রতিষ্ঠানটি কমপ্লায়েন্স-এর কাগজাদি দাখিল করেছে।' : 'The company has filed compliance documents.' }}
                          </span>
                          <span v-else>-</span>
                        </b-td>
                        <b-td rowspan="2">
                          <div>
                            <span>{{ $t('exportTrophy.position') + ': ' + $n(application.evaluation.position, { useGrouping: false }) }} </span>
                          </div>
                          <br><span>{{ $t('exportTrophy.number_obtained') + ': ' + $n(application.evaluation.total_number) }}</span>
                        </b-td>
                    </b-tr>
                    <b-tr class="text-center">
                        <b-td>-</b-td>
                        <b-td>-</b-td>
                        <b-td>{{ $n(application.evaluation.bb_export_income_number, { useGrouping: false }) }}</b-td>
                        <b-td>{{ $n(application.evaluation.income_growth_number, { useGrouping: false }) }}</b-td>
                        <b-td>{{ $n(application.evaluation.new_destination_number, { useGrouping: false }) }}</b-td>
                        <b-td>{{ $n(application.evaluation.new_product_number, { useGrouping: false }) }}</b-td>
                        <b-td>{{ $n(application.evaluation.compliance_number, { useGrouping: false }) }}</b-td>
                    </b-tr>
                </b-tbody>
            </b-table-simple>
        </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { applicantDataForEvaluationApi } from '../../api/routes'
import AddressHelper from '@/utils/area-type-address'
export default {
  name: 'Form',
  props: ['id', 'sector_name'],
  data () {
    return {
      AddressHelper: AddressHelper,
      application: {},
      new_destinations: [],
      new_products: [],
      compliance: null,
      unitLoad: false
    }
  },
  created () {
    if (this.id) {
        const tmp = this.getStorageData()
        this.application = tmp
        this.loadData()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async loadData () {
        this.unitLoad = true
        let result = null
        result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, applicantDataForEvaluationApi, { app_id: this.id })
        if (result.success) {
          this.new_destinations = result.data.new_countries
          this.new_products = result.data.new_products
          this.compliance = result.data.compliance
          this.unitLoad = false
        } else {
          this.unitLoad = false
          this.new_destinations = []
          this.new_products = []
          this.compliance = null
        }
    },
    fiscalYearName (Id) {
      const Obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === Id)
      if (typeof Obj !== 'undefined') {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ''
      }
    },
    countryName (Id) {
        const Obj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
        } else {
            return ''
        }
    },
    getStorageData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
<style scoped>
.overlay {
    position: absolute;
    left: 65%;
    z-index: 9999;
    top: 10px;
    text-align: center;
}
</style>
