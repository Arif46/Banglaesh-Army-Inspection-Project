<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.proposal_no')}} </b> : {{ items.program?.proposal?.proposal_id }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.program_no')}} </b> : {{ $n(items.proposal_detail_id, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.program_name')}} </b> : {{ currentLocale === 'bn' ? items.program.programe_name_bn : items.program.programe_name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.start_date')}} </b> : {{ items.start_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.end_date')}} </b> : {{ items.end_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.status')}} </b> : {{ statusText(items.status) }}
            </b-col>
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
      <b-card>
        <b-row>
          <b-col xs="12" sm="12" md="12">
          <!-- Evaluation Start -->
          <div v-if="items.evaluations.length > 0" class="table-wrapper table-responsive">
               <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr class="bg-primary">
                                <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('eBizProgram.evaluation') }} {{ $t('globalTrans.attachment') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('eBizProgram.comment') }}</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="items.evaluations?.length > 0">
                                <tr v-for="(item, index) in items.evaluations" :key="index">
                                    <td  class="text-center">{{ index+1 }}</td>
                                    <td style="width: 30%" class="text-center">
                                    <span><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+item.attachment" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                </td>
                                    <td  class="text-center">{{ item.comment }}</td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td colspan="3" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                </tr>
                            </template>
                        </tbody>
                  </table>
          </div>
          <!-- Evaluation End -->
          </b-col>
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
    </b-overlay>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('evaluation-view')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import { eBizServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'ViewEvaluation',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      valid: null,
      loading: false
    }
  },
  created () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    requestStatusList: function () {
      const list = [
            { value: 1, text: this.$i18n.locale === 'en' ? 'Draft' : 'খসড়া' },
            { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ' },
            { value: 3, text: this.$i18n.locale === 'en' ? 'Processing' : 'প্রক্রিয়াধীন' },
            { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত' },
            { value: 5, text: this.$i18n.locale === 'en' ? 'Agreement' : 'চুক্তি' }
            ]
           return list
    }
  },
  methods: {
        statusText (sta) {
          const reqStatusObj = this.requestStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
        }
    }
}
</script>
