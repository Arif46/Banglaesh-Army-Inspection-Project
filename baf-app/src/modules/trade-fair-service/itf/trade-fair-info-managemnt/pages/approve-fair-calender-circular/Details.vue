<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <b-overlay :show="loading">
          <list-report-head :base-url="internationalTradeFairServiceBaseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('tradeFairInfoManagement.fair_calender_circular') }}
          </list-report-head>
          <body-card>
            <template v-slot:body>
              <b-row>
                <b-col lg="12" sm="12">
                  <table class="table table-borderless">
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{$t('globalTrans.fiscal_year')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{currentLocale === 'bn'? viewData.fiscal_year_bn : viewData.fiscal_year_en}}</td>
                    </tr>
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{$t('tradeFairInfoManagement.circular_memo_no')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{ viewData.circular_memo_number}}</td>
                    </tr>
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{$t('tradeFairInfoManagement.subject')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{currentLocale === 'bn'? viewData.subject_bn : viewData.subject_en}}</td>
                    </tr>
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{$t('globalTrans.description')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{currentLocale === 'bn'? viewData.description_bn : viewData.description_en}}</td>
                    </tr>
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{$t('tradeFairInfoManagement.submission_deadline')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{ viewData.submission_deadline | dateFormat }}</td>
                    </tr>
                    <tr>
                      <th style="width: 28%; padding-bottom: 0"> {{ $t('globalTrans.attachment')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">
                        <a target="_blank" v-if="viewData.attachment" :href="internationalTradeFairServiceBaseUrl + 'storage/' + viewData.attachment">{{ $t('bfti.attachment_down')}}</a>
                      </td>
                    </tr>
                    <tr v-if="viewData.status === 3 || viewData.status === 5">
                      <th style="width: 28%; padding-bottom: 0"> {{ $t('tradeFairInfoManagement.approve_message')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{ viewData.comment_en }}</td>
                    </tr>
                    <tr v-if="viewData.status === 5">
                      <th style="width: 28%; padding-bottom: 0"> {{ $t('globalTrans.status')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 68%; padding-bottom: 0">{{$t('globalTrans.publish')}}</td>
                    </tr>
                  </table>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card v-if="viewData.forwards.length > 0" class="mt-3">
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.received_history') }}</h4>
            </template>
            <template v-slot:body>
              <table class="table table-sm table-bordered">
                <thead>
                <tr>
                  <th width="12%">{{ $t('globalTrans.sl_no') }}</th>
                  <th class="text-left">{{ $t('globalTrans.sender') }}</th>
                  <th class="text-left">{{ $t('globalTrans.receiver') }}</th>
                  <th class="text-left">{{ $t('globalTrans.status') }}</th>
                  <th class="text-left">{{ $t('globalTrans.comments') }}</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(item, index) in viewData.forwards" :key="index">
                  <td>{{ $n(index + 1) }}</td>
                  <td class="text-left">
                    {{ currentLocale === 'bn' ? item.sender_name_bn : item.sender_name_en }}
                  </td>
                  <td class="text-left">
                    {{ currentLocale === 'bn' ? item.receiver_name_bn : item.receiver_name_en }}
                  </td>
                  <td class="text-left">
                    <template v-if="item.status === 1">
                      <b-badge variant="warning">{{ $t('globalTrans.pending') }}</b-badge>
                    </template>
                    <template v-else-if="item.status === 2">
                      <b-badge variant="primary">{{ $t('globalTrans.forward') }}</b-badge>
                    </template>
                    <template v-else-if="item.status === 3">
                      <b-badge variant="success">{{ $t('globalTrans.approved') }}</b-badge>
                    </template>
                    <template v-else-if="item.status === 4">
                      <b-badge variant="danger">{{ $t('globalTrans.return') }}</b-badge>
                    </template>
                    <template v-else>
                      <b-badge variant="success">{{ $t('globalTrans.publish') }}</b-badge>
                    </template>
                  </td>
                  <td class="text-left">
                    {{ item.comment_en}}
                  </td>
                </tr>
                </tbody>
              </table>
            </template>
          </body-card>
        </b-overlay>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'
export default {
  name: 'Details',
  props: ['id'],
  components: {
    ListReportHead
  },
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      errors: [],
      viewData: [],
      userList: [],
      detailsItemId: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getSubsidyCategory()
      this.viewData = tmp
    }
    // if (this.viewData.forwards.length > 0) {
      this.getUserList()
    // }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    async getUserList () {
      this.loading = true
      const params = {}
      const result = await RestApi.getData(authServiceBaseUrl, '/user-management/user/get-all', params)
      if (result.success) {
        this.userList = result.data
        this.viewData.forwards = this.viewData.forwards.map(item => {
          const sender = this.userList.find(obj => obj.value === item.sender_id)
          const receiver = this.userList.find(obj => obj.value === item.reciver_id)
          const customItem = {
            sender_name_en: sender?.text_en,
            sender_name_bn: sender?.text_bn,
            receiver_name_en: receiver?.text_en,
            receiver_name_bn: receiver?.text_bn
          }
          return Object.assign({}, item, customItem)
        })
      }
      this.loading = false
    },
    getSubsidyCategory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    pdfExport () {
      const reportTitle = this.$t('tradeFairInfoManagement.fair_calender_circular')
      ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/itf-configuration/report-head/detail', 2, reportTitle, this)
    }
  }
}
</script>
