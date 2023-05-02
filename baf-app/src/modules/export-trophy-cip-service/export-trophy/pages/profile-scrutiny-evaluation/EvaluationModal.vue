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
                    <b-table-simple bordered class="p-0" v-if="marking">
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
                                <td class="text-center p-1" scope="col">{{ $n(marking.total_number_export_earning, { useGrouping: false }) }}</td>
                                <td class="align-middle text-center" rowspan="5" scope="col">{{ $n(totalMarking, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(2) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_increase_income') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(marking.total_number_export_income, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(3) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.number_on_product_new_market') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(marking.total_number_product_marketing_in_new_market, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(4) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_number_new_product_add') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(marking.total_number_new_product_addition, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td class="text-center p-1" scope="col">{{ $n(5) }}</td>
                                <td class="p-1" scope="col">{{ $t('exportTrophy.total_number_on_compliance') }}</td>
                                <td class="text-center p-1" scope="col">{{ $n(marking.total_number_compliance, { useGrouping: false }) }}</td>
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
                        <b-td>{{ $n(evaluation.previous_export_income_usd, { useGrouping: false }) }}</b-td>
                        <b-td>{{ $n(evaluation.current_export_income_usd, { useGrouping: false }) }}</b-td>
                        <b-td>
                          <ValidationProvider name="BB Data" vid="bb_export_income_usd" :rules="{min_value: 1, required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="bb_export_income_usd"
                              >
                                  <b-form-input
                                      style="height: 30px"
                                      v-model="evaluation.bb_export_income_usd"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                        <b-td>{{ $n(evaluation.income_growth, { useGrouping: false }) + '%' }}</b-td>
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
                            <b-spinner v-if="spinLoader" class="overlay" variant="success" small label="Spinning" style="top: 0px; left: auto; position: inherit"
                            ></b-spinner>
                            <span v-if="evaluation.position > 0">{{ $t('exportTrophy.position') + ': ' + $n(evaluation.position, { useGrouping: false }) }} </span>
                            <br><span><a @click="getPositionData" href="javascript:">{{ currentLocale === 'en' ? 'Check Position' : 'মেধাক্রম দেখুন' }}</a></span>
                          </div>
                          <br><span>{{ $t('exportTrophy.number_obtained') + ': ' + $n(evaluation.total_number) }}</span>
                        </b-td>
                    </b-tr>
                    <b-tr class="text-center">
                        <b-td>-</b-td>
                        <b-td>-</b-td>
                        <b-td>
                          <ValidationProvider name="BB Income Number" vid="bb_export_income_number" :rules="{required: true, max_value: 60, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="bb_export_income_number"
                              >
                                  <b-form-input
                                      @input="calculateTotalNumber"
                                      style="height: 30px"
                                      v-model="evaluation.bb_export_income_number"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                        <b-td>
                          <ValidationProvider name="Income Growth Number" vid="income_growth_number" :rules="{required: true, max_value: 10, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="income_growth_number"
                              >
                                  <b-form-input
                                      @input="calculateTotalNumber"
                                      style="height: 30px"
                                      v-model="evaluation.income_growth_number"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                        <b-td>
                          <ValidationProvider name="New Destination Number" vid="new_destination_number" :rules="{required: true, max_value: 10, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="new_destination_number"
                              >
                                  <b-form-input
                                      @input="calculateTotalNumber"
                                      style="height: 30px"
                                      v-model="evaluation.new_destination_number"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                        <b-td>
                          <ValidationProvider name="New Product Number" vid="new_product_number" :rules="{required: true, max_value: 10, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="new_product_number"
                              >
                                  <b-form-input
                                      @input="calculateTotalNumber"
                                      style="height: 30px"
                                      v-model="evaluation.new_product_number"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                        <!-- <b-td>-</b-td> -->
                        <b-td>
                          <ValidationProvider name="Compliance Number" vid="compliance_number" :rules="{required: true, max_value: 10, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                              <b-form-group
                                  class="mb-0 w-100"
                                  label-for="compliance_number"
                              >
                                  <b-form-input
                                      @input="calculateTotalNumber"
                                      style="height: 30px"
                                      v-model="evaluation.compliance_number"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-td>
                    </b-tr>
                </b-tbody>
            </b-table-simple>
        </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
            <b-button type="submit" variant="success" class="mr-1 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { scrutinyEvaluationStoreApi, applicantDataForEvaluationApi, applicantPositionApi } from '../../api/routes'
import AddressHelper from '@/utils/area-type-address'
export default {
  name: 'Form',
  props: ['id', 'sector_id', 'circular_id', 'sector_name'],
  data () {
    return {
      valid: null,
      AddressHelper: AddressHelper,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      application: {},
      evaluation: {
        previous_export_income_usd: '',
        current_export_income_usd: '',
        income_growth: '',
        bb_export_income_usd: '',
        bb_export_income_number: '',
        income_growth_number: '',
        new_destination_number: '',
        new_product_number: '',
        compliance_number: '',
        total_number: 0,
        position: 0
      },
      marking: null,
      totalMarking: 0,
      new_destinations: [],
      new_products: [],
      compliance: null,
      unitLoad: false,
      spinLoader: false,
      checkPosition: false
    }
  },
  created () {
    if (this.id) {
        const tmp = this.getStorageData()
        this.application = tmp
        this.calculateNecessaryData(this.application)
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
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, applicantDataForEvaluationApi, { app_id: this.id, sector_id: this.sector_id, circular_id: this.circular_id })
      this.unitLoad = false
      if (result.success) {
        this.marking = result.data.marking
        this.evaluation = Object.assign(this.evaluation, result.data.marking_value)
        this.totalMarking = parseFloat(this.marking.total_number_export_earning + this.marking.total_number_export_income + this.marking.total_number_product_marketing_in_new_market + this.marking.total_number_new_product_addition + this.marking.total_number_compliance)
        this.new_destinations = result.data.new_countries
        this.new_products = result.data.new_products
        this.compliance = result.data.compliance
        this.calculateTotalNumber()
      } else {
        this.marking = null
        this.unitLoad = false
        this.new_destinations = []
        this.new_products = []
        this.compliance = null
      }
    },
    calculateTotalNumber () {
      this.evaluation.total_number = 0
      const bbIncomeNumber = parseFloat(this.evaluation.bb_export_income_number) > 0 ? parseFloat(this.evaluation.bb_export_income_number) : 0
      const incomeGrowthNumber = parseFloat(this.evaluation.income_growth_number) > 0 ? parseFloat(this.evaluation.income_growth_number) : 0
      const newDestinationNumber = parseFloat(this.evaluation.new_destination_number) > 0 ? parseFloat(this.evaluation.new_destination_number) : 0
      const newProductNumber = parseFloat(this.evaluation.new_product_number) > 0 ? parseFloat(this.evaluation.new_product_number) : 0
      const complianceNumber = parseFloat(this.evaluation.compliance_number) > 0 ? parseFloat(this.evaluation.compliance_number) : 0
      this.evaluation.total_number = bbIncomeNumber + incomeGrowthNumber + newDestinationNumber + newProductNumber + complianceNumber
      this.checkPosition = true
    },
    calculateNecessaryData (data) {
        const previousFiscal = data.product_success_description[0].fiscal_year_id
        const thisFiscal = data.product_success_description[1].fiscal_year_id
        // gel total income for current and previous fiscal year [index 0 always previous fiscal and index 1 current fiscal]
        this.evaluation.previous_export_income_usd = this.getTotalIncome(data, previousFiscal)
        this.evaluation.current_export_income_usd = this.getTotalIncome(data, thisFiscal)
        this.evaluation.bb_export_income_usd = this.evaluation.current_export_income_usd
        // calculate parsentage growth
        const value = parseFloat(this.evaluation.current_export_income_usd - this.evaluation.previous_export_income_usd)
        const growth = (value * 100) / parseFloat(this.evaluation.previous_export_income_usd)
        this.evaluation.income_growth = growth
    },
    getTotalIncome (data, fiscalId) {
      let totalIncome = 0
      const fiscalData = data.product_success_description.filter(el => el.fiscal_year_id === parseInt(fiscalId))
      fiscalData.forEach(el => {
        totalIncome = totalIncome + el.export_value_ssd
      })
      return totalIncome
    },
    async getPositionData () {
        var check = await this.$refs.form.validate()
        if (check) {
          this.spinLoader = true
          const myItem = {
            app_id: this.id,
            total_number: this.evaluation.total_number,
            circular_id: this.application.circular_id,
            sector_id: this.application.product_service_sector_id
          }
          let result = null
          result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, applicantPositionApi, myItem)
          if (result.success) {
            this.evaluation.position = result.data.position
            this.spinLoader = false
            this.checkPosition = false
          } else {
            this.spinLoader = false
          }
        }
    },
    async saveUpdate () {
      if (this.evaluation.position > 0 && this.checkPosition === false) {
        this.unitLoad = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }

        this.evaluation.app_id = this.id
        this.evaluation.circular_id = this.application.circular_id
        this.evaluation.sector_id = this.application.product_service_sector_id

        if (this.id) {
          result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, scrutinyEvaluationStoreApi, this.evaluation)
        }

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          // this.$store.dispatch('ExportTrophyCipService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: 'Success',
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })

          this.unitLoad = false
          this.$bvModal.hide('modal-form')
        } else {
          this.unitLoad = false
          this.$refs.form.setErrors(result.errors)
        }
      } else {
        this.$toast.error({
            title: '!',
            message: this.$i18n.locale === 'en' ? 'Please, check the position before saving.' : 'অনুগ্রহপূর্বক, সংরক্ষণ করার আগে মেধাক্রম দেখে নিন।',
            color: 'red'
        })
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
