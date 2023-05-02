<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('task_activity_monitoring.review') }}</h5>
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
                          <th style="width: 30%">{{ $t('globalTrans.start_date') }}</th>
                          <th style="width: 2%">:</th>
                          <td style="width: 78%">
                            <b-col xs="12" sm="12" md="12">
                            <ValidationProvider name="Start Date" vid="start_date" rules="required" v-slot="{ errors }">
                              <b-form-group
                                label-for="start_date">
                                <date-picker
                                  id="start_date"
                                  v-model="data.start_date"
                                  class="form-control"
                                  :class="errors[0] ? 'is-invalid' : ''"
                                  :placeholder="$t('globalTrans.select_date')"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  :config="config1"
                                  @input="dateDiffs(data)"
                                >
                                </date-picker>
                                <div class="invalid-feedback d-block">
                                    {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                            </b-col>
                          </td>
                        </tr>
                        <tr>
                          <th style="width: 30%">{{ $t('globalTrans.end_date') }}</th>
                          <th style="width: 2%">:</th>
                          <td style="width: 78%">
                            <b-col xs="12" sm="12" md="12">
                              <ValidationProvider name="End Date" vid="end_date" rules="required" v-slot="{ errors }">
                              <b-form-group
                                label-for="end_date">
                                <date-picker
                                  id="end_date"
                                  v-model="data.end_date"
                                  class="form-control"
                                  :class="errors[0] ? 'is-invalid' : ''"
                                  :placeholder="$t('globalTrans.select_date')"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  :config="config"
                                  @input="dateDiffs(data)"
                                >
                                </date-picker>
                                <div class="invalid-feedback d-block">
                                    {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                            </b-col>
                          </td>
                        </tr>
                        <tr>
                          <th style="width: 30%">{{ $t('task_activity_monitoring.note') }}</th>
                          <th style="width: 2%">:</th>
                          <td style="width: 78%">
                            <b-col xs="12" sm="12" md="12">
                              <ValidationProvider name="Note">
                                <div slot-scope="{ valid, errors }">
                                  <b-form-textarea
                                    :id="'note'"
                                    v-model="data.note"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                  </b-form-textarea>
                                  <div class="error invalid-feedback" role="alert">
                                      {{ errors[0] }}
                                  </div>
                                </div>
                              </ValidationProvider>
                            </b-col>
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
import { taskReview } from '../../api/routes'
import moment from 'moment'

export default {
  name: 'Details',
  props: ['item', 'taskHistoryId'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      errors: [],
      detailsData: [],
      detailsItemId: '',
      data: {
        start_date: '',
        end_date: '',
        note: '',
        taskHistoryId: 0
      },
      load: false,
      config: { minDate: '' },
      config1: { maxDate: '' },
      exclusions: this.$store.state.BftiResearchAndReportService.commonObj.holidayList,
      weekday: [1, 2, 3, 4, 5]
    }
  },
  created () {
    this.data.taskHistoryId = this.taskHistoryId
    this.data.task_id = this.item.id
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
    dateDiffs (item) {
      this.config.minDate = item.start_date
      this.config1.maxDate = item.end_date
    },
    dateDiff (item) {
      if (item.start_date && item.end_date) {
        require('moment-weekday-calc')
        const todayDiff = moment().weekdayCalc({
          rangeStart: item.start_date,
          rangeEnd: item.end_date,
          weekdays: this.weekday,
          exclusions: this.exclusions
        })
        item.days = todayDiff
        return item
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
    async save () {
      this.load = true
      let result = null
      this.data = this.dateDiff(this.data)
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, `${taskReview}`, this.data)
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
        this.$emit('updateParent')
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
