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
                                <td colspan="3" style="width: 30%">: {{ currentLocale == 'bn' ? items.title_bn : items.title_en }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('eBizProposal.description') }}</th>
                                <td style="width: 80%" colspan="3">: {{ currentLocale == 'bn' ? items.description_bn : items.description_en }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%"> {{ $t('globalTrans.attachment') }}</th>
                                <td style="width: 30%">:
                                    <span><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+items.attachment" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                </td>
                            </tr>
                        </table>
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
