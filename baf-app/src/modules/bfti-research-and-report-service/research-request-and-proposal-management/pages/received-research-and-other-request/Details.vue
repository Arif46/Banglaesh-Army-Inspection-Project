<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('bfti.research_and_other_request') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 20%"> {{$t('bfti.doc_type')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{currentLocale === 'bn'? item.doc_type.document_type_bn : item.doc_type.document_type_en}}</td>
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{$t('bfti.topic')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{ ($i18n.locale === 'bn') ? item.topic_bn : item.topic }}</td>
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{$t('bfti.description')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{ ($i18n.locale === 'bn') ? item.description_bn : item.description }}</td>
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{ $t('bfti.budget')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{$n(item.budget)}}</td>
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{ $t('bfti.budget_source')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{ ($i18n.locale === 'bn') ? item.budget_source_bn : item.budget_source }}</td>
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{ $t('bfti.duration')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">{{getDuration(item.duration_start_date, item.duration_end_date)}}</td>
                    <!-- <td style="width: 78%">{{item.duration}}</td> -->
                  </tr>
                  <tr>
                    <th style="width: 20%"> {{ $t('bfti.attachment')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 78%">
                      <a target="_blank" v-if="item.attachment" :href="bftiResReportServiceBaseUrl + item.attachment">{{ $t('bfti.attachment_down')}}</a>
                    </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('bfti.contact_information') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-sm table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('bfti.contact_person')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.name_bn : item.name }}</td>
                  <th style="width: 18%"> {{$t('bfti.designation')}}</th>
                    <th style="width: 2%">:</th>
                  <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.designation_bn : item.designation }}</td>
                  </tr>
                  <tr>
                    <th style="width: 18%"> {{ $t('globalTrans.organization')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.organization_bn : item.organization }}</td>
                    <th style="width: 18%"> {{ $t('bfti.email')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{item.email}}</td>
                  </tr>
                  <tr>
                    <th style="width: 18%"> {{ $t('bfti.contact_number')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(item.contact_no, { useGrouping: false }) }}</td>
                    <th style="width: 18%"> {{ $t('bfti.submission_date')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">
                      {{item.submission_date|dateFormat}}
                    </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
        <b-row class="text-right mt-2">
          <b-col>
              <!-- <b-button variant="success" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.approved') }}</b-button> -->
              <b-button variant="success" class="btn-sm" @click="Approval(item, 2)">{{ $t('globalTrans.approved') }}</b-button>
              <b-button variant="danger" class="btn-sm ml-1" @click="Approval(item, 3)">{{ $t('globalTrans.rejected') }}</b-button>
              <b-button variant="danger" class="btn-sm ml-1" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { bftiResearchRequestApproveRejectApi } from '../../api/routes'
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
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getDuration (startingDate, endingDate) {
            var startDate = new Date(new Date(startingDate).toISOString().substr(0, 10))
            if (!endingDate) {
                endingDate = new Date().toISOString().substr(0, 10)
            }
            var endDate = new Date(endingDate)
            if (startDate > endDate) {
                var swap = startDate
                startDate = endDate
                endDate = swap
            }
            var startYear = startDate.getFullYear()
            var february = (startYear % 4 === 0 && startYear % 100 !== 0) || startYear % 400 === 0 ? 29 : 28
            var daysInMonth = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            var yearDiff = endDate.getFullYear() - startYear
            var monthDiff = endDate.getMonth() - startDate.getMonth()
            if (monthDiff < 0) {
                yearDiff--
                monthDiff += 12
            }
            var dayDiff = endDate.getDate() - startDate.getDate()
            if (dayDiff < 0) {
                if (monthDiff > 0) {
                    monthDiff--
                } else {
                    yearDiff--
                    monthDiff = 11
                }
                dayDiff += daysInMonth[startDate.getMonth()]
            }

            if (this.$i18n.locale === 'bn') {
                const year = this.$n(yearDiff, { useGrouping: false })
                const month = this.$n(monthDiff, { useGrouping: false })
                const day = this.$n(dayDiff, { useGrouping: false })
                const result = year + ' বছর, ' + month + ' মাস, ' + day + ' দিন'
                return result
            } else {
                const result = yearDiff + ' Year, ' + monthDiff + ' Month, ' + dayDiff + ' Days'
                return result
            }
    },
    Approval (item, type) {
      let msg = ''
      if (type === 2) {
        msg = window.vm.$t('globalTrans.approveMsg')
      } else {
        msg = window.vm.$t('globalTrans.rejectMsg')
      }
      window.vm.$swal({
        title: msg,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.acceptReject(item.id, type)
        }
      })
    },
    acceptReject (id, type) {
      const params = {
        id: id,
        status: type,
        document_type_id: this.item.document_type_id,
        research_request_id: this.item.id,
        organization: this.item.organization,
        organization_bn: this.item.organization_bn
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      RestApi.getData(bftiResReportServiceBaseUrl, bftiResearchRequestApproveRejectApi, params)
      .then(response => {
        if (response.success) {
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
          window.vm.$toast.success({
            title: 'Success',
            message: 'Data Updated Successfully',
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-form-details')
          this.loadData()
        } else {
          window.vm.$toast.error({
            title: 'Error',
            message: 'Operation failed! Please, try again.'
          })
        }
      })
    }
  }
}
</script>
