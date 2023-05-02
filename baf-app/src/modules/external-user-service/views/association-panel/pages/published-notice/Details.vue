<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.fiscal_year')}}</th>
                                <td style="width: 30%">: {{ getFiscalYear(items.fiscal_year_id) }}</td>
                                <th style="width: 20%">{{ $t('eBizProposal.source_of_fund')}}</th>
                                <td style="width: 30%">: {{ soFundName(items.source_of_fund) }}</td>
                            </tr>
                            <tr>
                                <th v-if="items.source_of_fund === 2" style="width: 20%">{{$t('eBizProposal.project_name')}}</th>
                                <td v-if="items.source_of_fund === 2" style="width: 30%">: {{  getProjectName(items.project_name_id) }} </td>
                                <th v-if="items.source_of_fund === 3" style="width: 20%"> {{ $t('eBizProposal.budget_title') }}</th>
                                <td v-if="items.source_of_fund === 3" style="width: 30%">: {{ items.budget_title }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.title') }}</th>
                                <td style="width: 30%">: {{ currentLocale == 'bn' ? items.title_bn : items.title_en }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.description') }}</th>
                                <td style="width: 50%" colspan="3">: {{ currentLocale == 'bn' ? items.description_bn : items.description_en }}</td>
                            </tr>
                            <tr>
                                <th style="width: 17%"> {{ $t('globalTrans.attachment') }}</th>
                                <td style="width: 30%">:
                                    <span><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.attachment" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                </td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
            </template>
            <template v-if="items.proposal">
                <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h5 class="text-white text-left">
                        {{ $t('associationPnl.initital_proposal') }}
                    </h5>
                </div>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('associationPnl.proposal_no')}}</th>
                                <td style="width: 30%">: {{ items.proposal.proposal_id }}</td>
                                <th style="width: 20%">{{ $t('eBizProposal.council_name')}}</th>
                                <td style="width: 30%">: {{ getCouncilName(items.proposal.council_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.association_name')}}</th>
                                <td style="width: 30%" colspan="2">: {{ getAssociationName(items.proposal.association_info_id) }}</td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
                 <b-row>
                  <b-col md="12">
                    <!--  Proposal Details  -->
                        <div class="table-wrapper table-responsive">
                          <table class="table table-striped table-hover table-bordered">
                              <thead>
                                  <tr class="bg-primary">
                                      <th scope="col" style="width: 10%;"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" class="text-center">
                                        <div>{{$t('associationPanel.program_name')}}</div>
                                      </th>
                                      <th scope="col" class="text-center">
                                        <div> {{ $t('associationPanel.duration') }}</div>
                                       </th>
                                      <th scope="col" class="text-center">
                                        <div> {{ $t('associationPnl.amount') }}</div>
                                       </th>
                                      <th scope="col" class="text-center">
                                        <div> {{ $t('globalTrans.attachment') }}</div>
                                       </th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="proposalDetails && proposalDetails.length > 0">
                                      <tr v-for="(item, index) in proposalDetails" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }}</td>
                                          <td class="text-center">{{ currentLocale == 'bn' ? item.programe_name_bn : item.programe_name_en }}</td>
                                          <td class="text-center">{{ $n(item.duration) }}</td>
                                          <td class="text-center">{{ $n(item.amount) }}</td>
                                          <td class="text-center">
                                            <span><a target="_blank" class="btn btn-primary btn-sm btn-outline mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+item.attachment" :title="$t('globalTrans.download')"><i class="ri-file-download-line"></i>&nbsp;</a></span>
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
                        <!-- Proposal Details -->
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
    created () {
      this.proposalDetails = this.items.proposal?.details
    },
    data () {
        return {
            proposalDetails: [],
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
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        getAssociationName (associationId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
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
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.projectNameList.find(item => item.value === projectId)
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
