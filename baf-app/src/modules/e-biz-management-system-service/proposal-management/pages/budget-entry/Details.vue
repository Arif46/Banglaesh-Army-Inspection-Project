<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 15%">{{ $t('globalTrans.fiscal_year')}}</th>
                                <td style="width: 30%"> : {{ getFiscalYear(items.fiscal_year_id) }}</td>
                                <th style="width: 15%">{{ $t('eBizProposal.source_of_fund')}}</th>
                                <td style="width: 30%"> : {{ soFundName(items.source_of_fund) }}</td>
                            </tr>
                            <tr>
                                <th v-if="items.source_of_fund === 2" style="width: 15%">{{$t('eBizProposal.project_name')}}</th>
                                <td v-if="items.source_of_fund === 2" style="width: 30%"> : {{  getProjectName(items.project_name_id) }} </td>
                                <th v-if="items.source_of_fund === 3" style="width: 15%"> {{ $t('eBizProposal.budget_title') }}</th>
                                <td v-if="items.source_of_fund === 3" style="width: 30%"> : {{ items.budget_title }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.bpc_total') }} {{ $t('eBizProposal.budget') }}</th>
                                <td style="width: 30%"> : {{ $n(items.bpc_total_budget) }}</td>
                                <th style="width: 20%">{{ $t('eBizProposal.remaining') }} {{ $t('eBizProposal.budget') }}</th>
                                <td style="width: 30%"> : {{  $n(items.remaining_budget) }}</td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
                 <b-row>
                  <b-col md="12">
                    <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                        <div class="table-wrapper table-responsive">
                          <table class="table table-striped table-hover table-bordered">
                              <thead>
                                  <tr class="bg-primary">
                                      <th scope="col" style="width: 10%;"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" style="width: 70%;" class="text-center"><div>{{$t('eBizProposal.council_name')}}</div></th>
                                      <th scope="col" class="text-center"><div> {{ $t('eBizProposal.budget') }} {{ $t('eBizProposal.amount') }}</div></th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="budgetEntryData && budgetEntryData.length > 0">
                                      <tr v-for="(item, index) in budgetEntryData" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }} </td>
                                          <td class="text-left">{{ getCouncilName(item.council_info_id) }}</td>
                                          <td class="text-right">{{ $n(item.budget_amount) }}</td>
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
                        <!-- &&&&&&&&&&&&&&Manual Info Details End&&&&&&&&&&&&&&& -->
                  </b-col>
                </b-row>
            </template>
        </b-row>
  </b-container>
</template>
<script>
import { eBizServiceBaseUrl } from '@/config/api_config'
export default {
    props: ['items'],
    components: {
    },
    created () {
      this.budgetEntryData = this.items.details
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
            budgetEntryData: [],
            eBizServiceBaseUrl: eBizServiceBaseUrl
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        },
        sourceOfFundList: function () {
            const list = [
                { value: 1, text: this.$i18n.locale === 'en' ? 'Gov' : 'সরকারি' },
                { value: 2, text: this.$i18n.locale === 'en' ? 'Project' : 'প্রজেক্ট' },
                { value: 3, text: this.$i18n.locale === 'en' ? 'Other' : 'অন্যান্য' }
            ]
           return list
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
        getFiscalYear (yearId) {
            const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        getProjectName (projectId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.projectNameList.find(item => item.value === projectId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        soFundName (fundId) {
            const cateObj = this.sourceOfFundList.find(item => item.value === fundId)
            if (cateObj !== undefined) {
                return cateObj.text
            }
        }
    }
}

</script>
