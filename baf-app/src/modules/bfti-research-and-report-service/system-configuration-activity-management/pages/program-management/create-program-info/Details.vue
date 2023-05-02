<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.memo_no')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ item.memo_no }}</td>
                     <th style="width: 18%"> {{$t('meeting_management.program_type_id')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{currentLocale === 'bn'? item.program_type_bn : item.program_type_en}}</td>
                  </tr>
                  <tr>
                    <th style="width: 21%"> {{$t('meeting_management.total_participant')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{$n(item.total_participant)}}</td>
                     <th style="width: 18%"> {{$t('meeting_management.title')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 80%" colspan="3">{{currentLocale === 'bn'? item.title_bn : item.title}}</td>
                  </tr>
                </table>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.details')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 80%" colspan="3">{{currentLocale === 'bn'? item.details_bn : item.details}}</td>
                  </tr>
                </table>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.organized_by')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{currentLocale === 'bn'? item.organized_by_bn : item.organized_by}}</td>
                    <th style="width: 18%"> {{$t('meeting_management.venue')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{currentLocale === 'bn'? item.venue_bn : item.venue}}</td>
                  </tr>
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.program_date')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{item.program_date|dateFormat}}</td>
                    <th style="width: 18%"> {{$t('meeting_management.start_time')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{EngBangNum(tConvert(item.start_time))}}</td>
                  </tr>
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.end_time')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{EngBangNum(tConvert(item.end_time))}}</td>
                  </tr>
                </table>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('meeting_management.remarks')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 80%" colspan="3">{{currentLocale === 'bn'? item.remarks_bn : item.remarks}}</td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title"> {{ $t('meeting_management.prdi') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <b-table bordered hover :items="item.attachment" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                      <template v-slot:cell(index)="data">
                          {{ $n(data.index + 1) }}
                      </template>
                      <template v-slot:cell(attachment)="data">
                          <a target="_blank" v-if="data.item.attachment" :href="bftiResReportServiceBaseUrl + 'storage' + data.item.attachment">{{ $t('bfti.attachment_down')}}</a>
                      </template>
                  </b-table>
              </b-col>
            </b-row>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import { bftiResReportServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      loading: false,
      errors: [],
      detailsData: [],
      detailsItemId: ''
    }
  },
  created () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('meeting_management.document_title'), class: 'text-center' },
          { label: this.$t('meeting_management.curriculum_vitae'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'title' },
          { key: 'attachment' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'title' },
          { key: 'attachment' }
        ]
      }

      return labels.map((item, index) => {
          return Object.assign(item, keys[index])
      })
    }
  },
  methods: {
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    tConvert (time) {
      // Check correct time format and split into components
      time = time
        .toString()
        .match(/^([01]\d|2[0-3])(:)([0-5]\d)(:[0-5]\d)?$/) || [time]
      if (time.length > 1) {
        time = time.slice(1)
        time[5] = +time[0] < 12 ? ' ' + this.$t('meeting_management.am') : ' ' + this.$t('meeting_management.pm')
        time[0] = +time[0] % 12 || 12
      }
      return time.join('')
    }
  }
}
</script>
