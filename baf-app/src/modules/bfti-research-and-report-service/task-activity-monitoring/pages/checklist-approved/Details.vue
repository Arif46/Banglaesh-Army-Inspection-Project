<template>
  <div class="section-wrapper">
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title"> {{ $t('research_plan_management.assign_task_basic_info') }}</h4>
      </template>
      <template v-slot:body>
          <b-table-simple bordered>
            <b-tr>
              <b-th>{{ $t('configuration.document_type') }}</b-th>
              <b-th class="text-center">:</b-th>
              <b-td>{{ ($i18n.locale === 'bn') ? detailsData.document_type_bn : detailsData.document_type }}</b-td>
              <b-th>{{ $t('globalTrans.title') }}</b-th>
              <b-th class="text-center">:</b-th>
              <b-td>
                <slot v-if="detailsData.document_type_id === 1">
                  {{ ($i18n.locale === 'bn') ? detailsData.prepare_eoi.title_bn : detailsData.prepare_eoi.title }}
                </slot>
                <slot v-else-if="detailsData.document_type_id === 2">
                  {{ ($i18n.locale === 'bn') ? detailsData.prepare_rfp.rfp_title_bn : detailsData.prepare_rfp.rfp_title_en }}
                </slot>
                <slot v-else-if="detailsData.document_type_id === 3">
                  {{ ($i18n.locale === 'bn') ? detailsData.research.topic_bn : detailsData.research.topic }}
                </slot>
                <slot v-else-if="detailsData.document_type_id === 4">
                  {{ ($i18n.locale === 'bn') ? detailsData.policy.policy_title_bn : detailsData.policy.policy_title }}
                </slot>
              </b-td>
            </b-tr>
            <b-tr>
              <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
              <b-th class="text-center">:</b-th>
              <b-td>{{ ($i18n.locale === 'bn') ? detailsData.organization_ministry_division_bn : detailsData.organization_ministry_division }}</b-td>
              <b-th>{{$t('research_plan_management.reference_no')}}</b-th>
              <b-th class="text-center">:</b-th>
              <b-td>{{ detailsData.reference_no }}</b-td>
            </b-tr>
          </b-table-simple>
      </template>
    </body-card>
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title"> {{ $t('globalTrans.details') }}</h4>
      </template>
      <template v-slot:body>
        <b-row>
          <b-col>
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
          </b-col>
        </b-row>
      </template>
    </body-card>
  </div>
</template>
<style>
  .datepicker-form {
    font-size: 8px !important;
  }
</style>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      detailsData: {},
      detailsItemId: '',
      authServiceBaseUrl: authServiceBaseUrl,
      userList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFormData()
      this.detailsData = tmp
    }
    this.getUserList()
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
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
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
