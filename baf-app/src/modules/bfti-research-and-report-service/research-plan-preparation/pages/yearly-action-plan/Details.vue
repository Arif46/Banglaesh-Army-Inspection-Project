<template>
  <div class="section-wrapper">
    <b-overlay :show="loading">
      <b-row>
        <b-col lg="12" sm="12">
            <body-card>
              <template v-slot:headerTitle>
                <h4 class="card-title"> {{ $t('research_plan_management.yearly_action_plan') }}</h4>
              </template>
              <template v-slot:body>
                 <table class="table  table-sm table-borderless">
                   <tr>
                     <th> {{ $t('globalTrans.title') }}</th>
                     <td>: {{ currentLocale === 'bn'? detailsData.title_bn : detailsData.title_en }}</td>
                     <th> {{ $t('research_plan_management.client') }}</th>
                     <td>: {{ currentLocale === 'bn'? detailsData.client_bn : detailsData.client_en }}</td>
                   </tr>
                   <tr>
                     <th> {{ $t('research_plan_management.budget') }}</th>
                     <td>: {{ $n(detailsData.budget) }}</td>
                     <th> {{ $t('research_plan_management.budget_source') }}</th>
                     <td>: {{ currentLocale === 'bn'? detailsData.budget_source_bn : detailsData.budget_source_en }}</td>
                   </tr>
                   <tr>
                     <th> {{ $t('globalTrans.date_from') }}</th>
                     <td>: {{ detailsData.date_from | dateFormat }}</td>
                     <th> {{ $t('globalTrans.date_to') }}</th>
                     <td>: {{ detailsData.date_to | dateFormat }}</td>
                   </tr>
                   <tr>
                     <th> {{ $t('research_plan_management.duration') }}</th>
                     <td>: {{ currentLocale === 'bn'? detailsData.duration_bn : detailsData.duration_en }}</td>
                     <th>{{ $t('globalTrans.remarks') }}</th>
                     <td>: {{ detailsData.remarks }}</td>
                   </tr>
                   <tr v-if="detailsData.attachment">
                     <th>{{ $t('bfti.attachment') }}</th>
                     <td>
                       : <a :href="bftiResReportServiceBaseUrl + (isImage(detailsData.attachment) ? 'storage/' : '') + detailsData.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a>
                     </td>
                   </tr>
                 </table>
              </template>
            </body-card>

            <body-card v-if="detailsData.forwards.length" class="mt-3">
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
                  <tr v-for="(item, index) in detailsData.forwards" :key="index">
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
                      <template v-else>
                        <b-badge variant="danger">{{ $t('globalTrans.rejected') }}</b-badge>
                      </template>
                    </td>
                    <td class="text-left">
                      {{ item.comment}}
                    </td>
                  </tr>
                  </tbody>
                </table>
              </template>
            </body-card>
          </b-col>
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { authServiceBaseUrl, bftiResReportServiceBaseUrl } from '@/config/api_config'

export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      valid: null,
      loading: false,
      detailsData: {},
      detailsItemId: '',
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      authServiceBaseUrl: authServiceBaseUrl,
      userList: []
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFormData()
      this.detailsData = tmp
    }
    this.getUserList()
  },
  methods: {
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    },
    async getUserList () {
      this.loading = true
      // const params = { org_id: 10 }
      const params = {}
      const result = await RestApi.getData(authServiceBaseUrl, '/user-management/user/get-all', params)
      if (result.success) {
        this.userList = result.data
        this.detailsData.forwards = this.detailsData.forwards.map(item => {
          const sender = this.userList.find(obj => obj.value === item.sender_id)
          const receiver = this.userList.find(obj => obj.value === item.receiver_id)
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
    }
  }
}
</script>
