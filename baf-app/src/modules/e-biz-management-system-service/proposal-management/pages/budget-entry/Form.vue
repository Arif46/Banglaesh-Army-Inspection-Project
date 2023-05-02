<template>
 <div class="inner-section">
    <bread-cumb />
       <body-card>
       <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('eBizProposal.budget') }}  {{  id > 0 ? $t('globalTrans.edit') : $t('globalTrans.add') }}</h4>
      </template>
          <b-container fluid>
              <b-row>
              <b-overlay :show="loading">
                <b-col sm="12" class="mt-3">
                  <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                        <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                            <b-row>
                          <slot>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Fiscal Year" vid="fiscal_year" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="fiscal_year"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.fiscal_year_id"
                                    :options="fiscalYearList"
                                    :disabled="arrBudgetEntryData.length > 0"
                                    id="fiscal_year"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                              </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Source Of Fund" vid="source_of_fund" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="source_of_fund"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProposal.source_of_fund')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.source_of_fund"
                                    :options="sourceOfFund"
                                    :disabled="arrBudgetEntryData.length > 0"
                                    id="source_of_fund"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                   <template>
                                    <div v-if="has_buget">
                                      <p class="text-danger">{{$t('eBizProposal.budget_message')}}</p>
                                    </div>
                                  </template>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="parseInt(formData.source_of_fund) === 2">
                            <ValidationProvider name="Project Name" vid="project_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="project_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProposal.project_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.project_name_id"
                                    :options="projectNameList"
                                    id="project_id"
                                    :disabled="arrBudgetEntryData.length > 0"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="parseInt(formData.source_of_fund) === 3">
                                <ValidationProvider name="Budget Title" vid="budget_title" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                      label-for="budget_title">
                                      <template v-slot:label>
                                        {{ $t('eBizProposal.budget_title') }} <span class="text-danger">*</span>
                                      </template>
                                      <b-form-input
                                        id="budget_title"
                                        v-model="formData.budget_title"
                                        :disabled="arrBudgetEntryData.length > 0"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                        {{ errors[0] }}
                                      </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="BPC Total Budget" vid="bpc_total_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="bpc_total_budget">
                                  <template v-slot:label>
                                    {{ $t('eBizProposal.bpc_total') }} {{ $t('eBizProposal.budget') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="bpc_total_budget"
                                    v-model="formData.bpc_total_budget"
                                    :disabled="arrBudgetEntryData.length > 0"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Remaining Budget" vid="remaining_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="remaining_budget">
                                  <template v-slot:label>
                                    {{ $t('eBizProposal.remaining') }} {{ $t('eBizProposal.budget') }}
                                  </template>
                                  <b-form-input
                                    id="remaining_budget"
                                    v-model="formData.remaining_budget"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    disabled
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                          </slot>
                            </b-row>
                          </b-form>
                        <!-- </b-overlay> -->
                  </ValidationObserver>
                  <slot>
                          <!-- =============End Main========= -->
                    <template>
                          <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                              <h5 class="text-white text-left">
                                  {{ $t('eBizProposal.budget') }} {{ $t('globalTrans.details') }}
                              </h5>
                          </div>
                    </template>
                      <hr>
                      <!-- =================Add More Start===================== -->
                    <div >
                      <ValidationObserver ref="budgetEntryForm" v-slot="{ handleSubmit, reset }">
                        <!-- <b-overlay :show="loading"> -->
                          <b-form @submit.prevent="handleSubmit(budgetEntryAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                            <b-row>
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Council Name" vid="council_info_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="council_info_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="councilEntryData.council_info_id"
                                    :options="councilInfoList"
                                    id="council_info_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Budget Amount" vid="budget_amount" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="budget_amount">
                                    <template v-slot:label>
                                      {{ $t('eBizProposal.budget') }} {{ $t('eBizProposal.amount') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="budget_amount"
                                      v-model="councilEntryData.budget_amount"
                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                            </b-row>
                            <b-row class="text-right">
                              <b-col>
                                  <b-button type="submit" :disabled="formData.bpc_total_budget > 0 ?false : true" variant="success" class="mr-2 btn-sm">
                                      <span v-if="loading">
                                          <b-spinner small label="Loading..."></b-spinner>
                                      </span>
                                      <span v-else>
                                          <i class="fas fa-plus-circle m-0"></i>
                                      </span>
                                      {{arrBudgetEntryData && arrBudgetEntryData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
                                  </b-button>
                              </b-col>
                            </b-row>
                          </b-form>
                        <!-- </b-overlay> -->
                      </ValidationObserver>
                    </div>
                    <br/>
                      <!-- Budget Details Start -->
                       <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('eBizProposal.council_name') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('eBizProposal.budget') }} {{ $t('eBizProposal.amount') }}</div></th>
                                        <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="arrBudgetEntryData && arrBudgetEntryData.length > 0">
                                        <tr v-for="(item, index) in arrBudgetEntryData" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td class="text-center">{{ getCouncilName(item.council_info_id) }}</td>
                                            <td style="width: 40%" class="text-center" >
                                                <ValidationProvider name="Budget Amount" :vid="`budget_amount${index}`" rules="required" v-slot="{ errors }">
                                                  <b-form-group
                                                    :label-for="`budget_amount${index}`">
                                                    <b-form-input
                                                      id="budget_amount"
                                                      v-model.number="item.budget_amount"
                                                      @keyup="calculateAmount()"
                                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                    </div>
                                                  </b-form-group>
                                                </ValidationProvider>
                                            </td>
                                            <td class="text-center">
                                                <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="budgetEntryRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                            </td>
                                        </tr>
                                    </template>
                                    <template v-else>
                                        <tr>
                                            <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                        </div>
                        <!-- Budget Details End -->
                    <!-- =================Add More End===================== -->
                    <br>
                    <!-- attachemnt  -->
                </slot>
                <b-row class="text-right mb-3">
                    <b-col>
                        <b-button v-if="overBudget" :disabled="isDisabled"  type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                        <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
                </b-col>
                </b-overlay>
              </b-row>
          </b-container>
     </body-card>
  </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { budgetEntryStore, budgetEntryUpdate, budgetInfo } from '../../api/routes'
import BreadCumb from '../../../../../components/BreadCumb.vue'
export default {
  name: 'Form',
  props: ['id'],
  components: { BreadCumb },
  data () {
    return {
      valid: null,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        fiscal_year_id: 0,
        source_of_fund: 0,
        project_name_id: 0,
        budget_title: '',
        bpc_total_budget: 0,
        remaining_budget: 0,
        budgetEntryDataArr: []
      },
      councilEntryData: {
        council_info_id: 0,
        council_name_en: '',
        council_name_bn: '',
        budget_amount: 0
      },
      exitBudgetShow: false,
      has_buget: false,
      overBudget: true,
      arrBudgetEntryData: [],
      disableBudget: this.has_buget ? 'disabled' : ''
      // itemList: []
    }
  },
  created () {
    if (this.$route.query.id) {
      const tmp = this.getEditEntry()
      this.formData = tmp
      this.formData.budgetEntryDataArr = tmp.details
      this.arrBudgetEntryData = tmp.details
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    isDisabled: function () {
    return this.has_buget
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    projectNameList () {
      return this.$store.state.EBizManagementSystemService.commonObj.projectNameList.filter(item => item.status === 1)
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    sourceOfFund () {
      let fundList = [
        {
          value: '1',
          text_en: 'Gov',
          text_bn: 'সরকারি'
        },
        {
            value: '2',
            text_en: 'Project',
            text_bn: 'প্রজেক্ট'
        },
        {
            value: '3',
            text_en: 'Other',
            text_bn: 'অন্যান্য'
        }
      ]
       fundList = fundList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return fundList
    }
  },
  watch: {
    'formData.source_of_fund': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getBugetGivenOrNot(newVal)
        if (!this.$route.query.id) {
          this.formData.bpc_total_budget = 0
          this.formData.remaining_budget = 0
        }
      }
    },
    'formData.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getBugetGivenOrNot(this.formData.source_of_fund)
      }
    },
    'formData.project_name_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getBugetGivenOrNot(this.formData.source_of_fund)
      }
    },
    'formData.bpc_total_budget': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.$route.query.id) {
          this.formData.remaining_budget = newVal
        }
      }
    },
    'formData.remaining_budget': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal > this.formData.bpc_total_budget) {
          this.exitBudgetShow = true
        } else {
          this.exitBudgetShow = false
        }
      }
    }
  },
  methods: {
    getCouncilName (councilNameId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
       calculateAmount () {
        const budget = this.formData.budgetEntryDataArr.reduce((total, item) => total + parseFloat(item.budget_amount), 0)
        const remBudget = this.formData.bpc_total_budget - parseFloat(budget)
        if (remBudget < 0) {
          this.overBudget = false
          this.$toast.success({
              title: 'Error',
              message: this.$t('eBizProposal.invalid_budget'),
              color: '#FF0000'
          })
        } else {
          this.overBudget = true
          this.formData.remaining_budget = this.formData.bpc_total_budget - parseFloat(budget)
        }
      },
    // ================Edu Info Start=================
        async budgetEntryAddItem () {
               const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.find(council => council.value === this.councilEntryData.council_info_id)
               var obj = {
                    council_info_id: this.councilEntryData.council_info_id,
                    council_name_en: cateObj !== undefined ? cateObj.text_en : '',
                    council_name_bn: cateObj !== undefined ? cateObj.text_bn : '',
                    budget_amount: parseFloat(this.councilEntryData.budget_amount)
                }
                  // this.loading = true
                      if (this.councilEntryData.key === undefined) {
                        const extCouncil = this.formData.budgetEntryDataArr.find(eCouncil => eCouncil.council_info_id === this.councilEntryData.council_info_id)
                        if (extCouncil === undefined) {
                          if (parseFloat(this.councilEntryData.budget_amount) <= this.formData.remaining_budget) {
                            this.formData.budgetEntryDataArr.push(obj)
                            this.formData.remaining_budget -= parseFloat(this.councilEntryData.budget_amount)
                          } else {
                            this.$toast.success({
                              title: 'Error',
                                message: this.$t('eBizProposal.invalid_budget'),
                                color: '#FF0000'
                              })
                          }
                        } else {
                          const budget = this.formData.budgetEntryDataArr.reduce((total, item) => total + parseFloat(item.budget_amount), 0)
                          const sumOfBudget = (parseFloat(budget) + parseFloat(this.councilEntryData.budget_amount))
                          if (sumOfBudget <= parseFloat(this.formData.bpc_total_budget)) {
                            extCouncil.budget_amount += parseFloat(this.councilEntryData.budget_amount)
                             this.formData.remaining_budget -= parseFloat(this.councilEntryData.budget_amount)
                          } else {
                            this.$toast.success({
                              title: 'Error',
                                message: this.$t('eBizProposal.invalid_budget'),
                                color: '#FF0000'
                              })
                          }
                        }
                      } else {
                          this.formData.budgetEntryDataArr[this.councilEntryData.key].council_info_id = this.allotmentOrderData.council_info_id
                          this.formData.budgetEntryDataArr[this.councilEntryData.key].council_name_en = cateObj !== undefined ? cateObj.text_en : ''
                          this.formData.budgetEntryDataArr[this.councilEntryData.key].council_name_bn = cateObj !== undefined ? cateObj.text_bn : ''
                          this.formData.budgetEntryDataArr[this.councilEntryData.key].budget_amount = this.councilEntryData.budget_amount
                      }
                      this.councilEntryData = {
                            council_info_id: 0,
                            council_name_en: '',
                            council_name_bn: '',
                            budget_amount: 0
                      }
                      this.arrBudgetEntryData = this.formData.budgetEntryDataArr
                      this.$refs.budgetEntryForm.reset()
                      // this.loading = false
        },
        cancel () {
          this.$router.push({ path: '/e-biz-management-system-service/proposal-management/budget-entry' })
        },
        budgetEntryRemove (key) {
          this.formData.remaining_budget += parseFloat(this.formData.budgetEntryDataArr[key].budget_amount)
          this.formData.budgetEntryDataArr.splice(key, 1)
        },
        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.budgetEntryDataArr.length > 0 && this.overBudget) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${budgetEntryUpdate}/${this.$route.query.id}`, this.formData)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, budgetEntryStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        // this.$bvModal.hide('modal-form')
        this.$router.push({ path: '/e-biz-management-system-service/proposal-management/budget-entry' })
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    async getBugetGivenOrNot (fundId) {
        const params = {
          fiscal_year_id: this.formData.fiscal_year_id,
          project_name_id: this.formData.project_name_id,
          source_of_fund: fundId
        }
      const loadingState = { loading: false, listReload: false }
      let result = null
      result = await RestApi.getData(eBizServiceBaseUrl, budgetInfo, params)
      loadingState.listReload = true
      if (result.success) {
        if (result.data > 0) {
          // this.has_buget = true
          if (!this.$route.query.id) {
            this.has_buget = true
          }
          // this.$toast.success({
          //   title: 'Error',
          //   message: this.$t('Buget Already Exist on This fiscal year and source of fund'),
          //   color: '#D6E09B'
          // })
        } else {
          this.has_buget = false
        }
      }
    },
    getEditEntry () {
      const itemId = this.$route.query.id
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
