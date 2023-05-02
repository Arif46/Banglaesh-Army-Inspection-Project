<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('associationPnl.proposal_no')}}</th>
                                <td style="width: 30%">: {{ items.proposal_id }}</td>
                                <th style="width: 20%">{{ $t('eBizProposal.council_name')}}</th>
                                <td style="width: 30%">: {{ getCouncilName(items.council_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.association_name')}}</th>
                                <td style="width: 30%">: {{ getAssociationName(items.association_info_id) }}</td>
                            </tr>
                            <!-- <tr>
                                <th style="width: 20%">{{$t('associationPnl.proposal_type')}}</th>
                                <td style="width: 30%">
                                 <b-form-checkbox-group
                                  v-model="items.proposal_type_ids"
                                  :options="proposalTypeList"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                  </b-form-checkbox-group>
                                </td>
                            </tr> -->
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
                                      <th scope="col" class="text-center">
                                        <div>{{$t('associationPanel.program_name')}}</div>
                                      </th>
                                      <th scope="col" class="text-center">
                                        <div> {{ $t('associationPanel.duration') }}</div>
                                       </th>
                                      <th scope="col" class="text-center">
                                        <div> {{ $t('associationPanel.amount') }}</div>
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
                                          <td class="text-right">{{ $n(item.amount) }}</td>
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
      this.proposalDetails = this.items.details
    },
    mounted () {
        // core.index()
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
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        proposalTypeList () {
            return this.$store.state.EBizManagementSystemService.commonObj.proposalTypeList.filter(item => item.status === 1)
        },
        getAssociationName (associationId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
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
