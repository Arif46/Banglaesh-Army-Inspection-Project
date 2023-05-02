<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('task_activity_monitoring.task_details') }}</h5>
          </template>
          <template v-slot:body>
            <table class="table table-borderless">
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.task_name')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskHeadingList,'value', item.task_heading_id) }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.sub_task_name')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskSubHeadingList,'value', item.sub_task_heading_id) }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.approx_start_date')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  {{ item.start_date| dateFormat }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.approx_end_date')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  {{ item.end_date| dateFormat }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.actual_start_date')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%" v-if="item.actual_start_date">
                  {{ item.actual_start_date| dateFormat }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.actual_end_date')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%" v-if="item.actual_end_date">
                  {{ item.actual_end_date| dateFormat }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('task_activity_monitoring.note')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  {{ item.note }}
                </td>
              </tr>
              <tr>
                <th style="width: 30%"> {{$t('bfti.attachment')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 78%">
                  <slot v-if="item.file">
                    <template class="pb-3" v-if="item.id && item.file">
                      <a :href="bftiResReportServiceBaseUrl + item.file" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                    </template>
                  </slot>
                </td>
              </tr>
            </table>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { taskUpdate } from '../../api/routes'
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      errors: [],
      detailsData: [],
      item: [],
      detailsItemId: '',
      load: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDetails()
      this.item = tmp
    }
  },
  computed: {
    task_status: function () {
      return [
        { text: this.currentLocale === 'en' ? 'Pending' : 'বিচারাধীন', value: 1 },
        { text: this.currentLocale === 'en' ? 'Ongoing' : 'চলমান', value: 2 },
        { text: this.currentLocale === 'en' ? 'Done' : 'সম্পন্ন', value: 3 }
      ]
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getColumnName (list, field, groupId) {
      const obj = list.find(item => item[field] === groupId)
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return obj.text_bn
        } else {
          return obj.text_en
        }
      } else {
        return ''
      }
    },
    async save () {
      this.load = true
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${taskUpdate}/${this.id}`, this.item)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.load = false
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form-details')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.load = false
      }
    },
    getDetails () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
