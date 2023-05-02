<template>
  <div class="section-wrapper">
      <b-overlay :show="loading">
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.assign_task_basic_info') }}</h4>
            </template>
            <template v-slot:body>
                <b-table-simple bordered responsive>
                  <b-tr>
                    <b-th>{{ $t('configuration.document_type') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.document_type_bn : form.document_type }}</b-td>
                    <b-th>{{ $t('globalTrans.title') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>
                      <slot v-if="form.document_type_id === 1">
                        {{ ($i18n.locale === 'bn') ? form.prepare_eoi.title_bn : form.prepare_eoi.title }}
                      </slot>
                      <slot v-else-if="form.document_type_id === 2">
                        {{ ($i18n.locale === 'bn') ? form.prepare_rfp.rfp_title_bn : form.prepare_rfp.rfp_title_en }}
                      </slot>
                      <slot v-else-if="form.document_type_id === 3">
                        {{ ($i18n.locale === 'bn') ? form.research.topic_bn : form.research.topic }}
                      </slot>
                      <slot v-else-if="form.document_type_id === 4">
                        {{ ($i18n.locale === 'bn') ? form.policy.policy_title_bn : form.policy.policy_title }}
                      </slot>
                    </b-td>
                  </b-tr>
                  <b-tr>
                    <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.organization_ministry_division_bn : form.organization_ministry_division }}</b-td>
                    <b-th>{{$t('research_plan_management.reference_no')}}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ form.reference_no }}</b-td>
                  </b-tr>
                </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.assign_task_coordinator') }}</h4>
            </template>
            <template v-slot:body>
                <b-table-simple bordered responsive>
                  <b-tr>
                    <b-th>{{ $t('globalTrans.designation') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.designation_bn : form.designation }}</b-td>
                    <b-th>{{$t('research_plan_management.responsible_person')}}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.responsible_person_bn : form.responsible_person }}</b-td>
                  </b-tr>
                  <b-tr>
                    <b-th>{{ $t('research_plan_management.assign_date') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ form.assign_date | dateFormat }}</b-td>
                    <b-th></b-th>
                    <b-th class="text-center"></b-th>
                    <b-td></b-td>
                  </b-tr>
                </b-table-simple>
            </template>
          </body-card>
          <body-card v-if="form.document_upload_forwards.length" class="mt-3">
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
                <tr v-for="(item, index) in form.document_upload_forwards" :key="index">
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
                      <b-badge variant="success">{{ $t('globalTrans.rejected') }}</b-badge>
                    </template>
                    <template v-else>
                      <b-badge variant="danger">{{ $t('globalTrans.review') }}</b-badge>
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

          <body-card v-if="form.document_upload" class="mt-3">
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_execution.document_history') }}</h4>
            </template>
            <template v-slot:body>
              <table class="table table-sm table-bordered">
                <thead>
                <tr>
                  <th width="12%">{{ $t('globalTrans.sl_no') }}</th>
                  <th class="text-left">{{ $t('globalTrans.status') }}</th>
                  <th class="text-left">{{ $t('globalTrans.date') }}</th>
                  <th class="text-left">{{ $t('globalTrans.comments') }}</th>
                  <th class="text-left">{{ $t('globalTrans.attachment') }}</th>
                </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>{{ $n(1) }}</td>
                    <td class="text-left">
                      {{ $t('research_execution.uploaded') }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.created_at | dateFormat }}
                    </td>
                    <td class="text-left"></td>
                    <td class="text-left">
                      <template v-if="form.document_upload.id && form.document_upload.file">
                        <a :href="bftiResReportServiceBaseUrl + (isImage(form.document_upload.file) ? 'storage/' : '') + form.document_upload.file" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                      </template>
                    </td>
                  </tr>
                  <tr v-if="form.document_upload.submit_date">
                    <td>{{ $n(2) }}</td>
                    <td class="text-left">
                      {{ $t('globalTrans.submitted') }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.submit_date | dateFormat }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.submit_comment}}
                    </td>
                    <td class="text-left">
                      <template v-if="form.document_upload.id && form.document_upload.submit_file">
                        <a :href="bftiResReportServiceBaseUrl + (isImage(form.document_upload.submit_file) ? 'storage/' : '') + form.document_upload.submit_file" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                      </template>
                    </td>
                  </tr>
                  <tr v-if="form.document_upload.awarded_date">
                    <td>{{ $n(3) }}</td>
                    <td class="text-left">
                      {{ $t('research_execution.awarded') }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.awarded_date | dateFormat }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.awarded_comment}}
                    </td>
                    <td class="text-left">
                      <template v-if="form.document_upload.id && form.document_upload.awarded_file">
                        <a :href="bftiResReportServiceBaseUrl + (isImage(form.document_upload.awarded_file) ? 'storage/' : '') + form.document_upload.awarded_file" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                      </template>
                    </td>
                  </tr>
                  <tr v-if="form.document_upload.non_awarded_date">
                    <td>{{ $n(3) }}</td>
                    <td class="text-left">
                      {{ $t('research_execution.non_awarded') }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.non_awarded_date | dateFormat }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.non_awarded_comment}}
                    </td>
                    <td class="text-left"></td>
                  </tr>
                  <tr v-if="form.document_upload.cancelled_date">
                    <td>{{ $n(3) }}</td>
                    <td class="text-left">
                      {{ $t('research_execution.cancelled') }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.cancelled_date | dateFormat }}
                    </td>
                    <td class="text-left">
                      {{ form.document_upload.cancelled_comment}}
                    </td>
                    <td class="text-left"></td>
                  </tr>
                </tbody>
              </table>
            </template>
          </body-card>
      </b-overlay>
  </div>
</template>
<script>
import RestApi, { authServiceBaseUrl, bftiResReportServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      userList: [],
      loading: false,
      form: {
        designation_id: 0,
        document_upload_forwards: []
      },
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl
    }
  },
  watch: {
  },
  created () {
    if (this.id) {
      const tmp = this.getInfo()
      this.form = tmp
    }
    this.getUserList()
  },
  computed: {
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    async getUserList () {
      this.loading = true
      // const params = { org_id: 10 }
      const params = {}
      const result = await RestApi.getData(authServiceBaseUrl, '/user-management/user/get-all', params)
      if (result.success) {
        this.userList = result.data
        this.form.document_upload_forwards = this.form.document_upload_forwards.map(item => {
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
    },
    getInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    }
  }
}
</script>
