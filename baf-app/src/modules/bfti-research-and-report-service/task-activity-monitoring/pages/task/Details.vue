<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('task_activity_monitoring.task_details') }}</h5>
          </template>
          <template v-slot:body>
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
              <b-overlay :show="load">
                <b-form @submit.prevent="handleSubmit(save)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                  <b-row>
                    <b-col lg="12" sm="12">
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
                        <tr v-if="item.status !== 1">
                          <th style="width: 30%"> {{$t('bfti.attachment')}}</th>
                          <th style="width: 2%">:</th>
                          <td style="width: 78%">
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Attachment" vid="file" v-slot="{ errors }">
                                <b-form-group
                                  label-for="file">
                                  <b-form-file
                                  id="file"
                                  v-model="item.attachment"
                                  @change="onChange"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  placeholder="Choose a file or drop it here..."
                                  drop-placeholder="Drop file here..."
                                  ></b-form-file>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                              <slot v-if="item.file">
                                <template class="pb-3" v-if="item.id && item.file">
                                  <a :href="bftiResReportServiceBaseUrl + item.file" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                </template>
                              </slot>
                            </b-col>
                          </td>
                        </tr>
                        <tr>
                          <th style="width: 30%"> {{$t('task_activity_monitoring.task_status')}}</th>
                          <th style="width: 2%">:</th>
                          <td style="width: 78%">
                              <b-form-radio-group
                                  id="task_status"
                                  v-model="item.status"
                                  :options="task_status"
                                  name="task_status"
                              ></b-form-radio-group>
                          </td>
                        </tr>
                      </table>
                      <b-row class="text-right">
                        <b-col>
                            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{$t('globalTrans.save')}}</b-button>
                        </b-col>
                      </b-row>
                    </b-col>
                  </b-row>
                </b-form>
              </b-overlay>
            </ValidationObserver>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { taskUpdate } from '../../api/routes'
import moment from 'moment'

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
      load: false,
      exclusions: this.$store.state.BftiResearchAndReportService.commonObj.holidayList,
      weekday: [1, 2, 3, 4, 5]
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
     onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.item.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.item.attachment = ''
      }
    },
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
    dateDiff (item) {
      const today = new Date().toISOString().slice(0, 10)
      if (item.actual_start_date) {
        require('moment-weekday-calc')
        const todayDiff = moment().weekdayCalc({
          rangeStart: item.actual_start_date,
          rangeEnd: today,
          weekdays: this.weekday,
          exclusions: this.exclusions
        })
        item.actual_days = todayDiff
        return item
      }
    },
    async save () {
      this.load = true
      if (this.item.status === 3) {
        this.item = this.dateDiff(this.item)
      }
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
