<template>
    <div class="inner-section a11-wrapper">
      <body-card>
        <template v-slot:headerTitle>
          <h4 class="card-title">
            <span v-if="appDetails.service">{{ currentLocale === 'en' ? appDetails.service.service_name_en : appDetails.service.service_name_bn }}</span></h4>
        </template>
        <template v-slot:body>
          <div class="d-flex justify-content-between mb-4">
            <p>{{ $t('teaGardenService.application_id') }}: {{ appDetails.app_id }}</p>
            <p>{{ $t('globalTrans.date') }}: {{ appDetails.application_date | dateFormat }}</p>
          </div>
          <div class="apps-subject-wrapper mb-4">
            <p class="mb-0">{{ $t('teaGardenBtriService.director_label') }}</p>
            <p class="mb-0">{{ $t('teaGardenBtriService.btb_label') }}</p>
            <p class="mb-0">{{ $t('teaGardenBtriService.upazila_label') }}</p>
            <p class="mb-0">{{ $t('globalTrans.district') }}- {{ $t('teaGardenBtriService.district_name') }}</p>
          </div>
          <p class="mb-4">{{ $t('teaGardenBtriService.subject') }}:
            {{ appDetails.tea_sample_test_type_id === 1 ? $t('teaGardenBtriService.tea_sample_test_subject_organoleptic') : $t('teaGardenBtriService.tea_sample_test_subject_lab_test') }}
            </p>
          <div class="cover-letter-wrapper" style="text-align: justify">
            <p class="mb-2">{{ $t('teaGardenBtriService.dear') }}</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{ $t('teaGardenBtriService.greeting_heading') }} <span class="dynamic-line-wrapper">{{ getGardenName(appDetails.garden_id) }}</span> {{ appDetails.tea_sample_test_type_id === 1 ? $t('teaGardenBtriService.tea_sample_taste_organoleptic_end_label') : $t('teaGardenBtriService.tea_sample_taste_lab_test_end_label') }}
           </p>
          </div>
          <b-col sm="12 mt-5">
              <table class="table table-sm table-bordered section-tree-view-table">
                  <thead>
                      <tr>
                          <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                          <th class="text-center">{{ $t('teaGardenConfig.grade_name') }}</th>
                          <th class="text-center">{{ $t('teaGardenBtriService.sample_no') }}</th>
                          <th class="text-center">{{ $t('teaGardenBtriService.packets') }}</th>
                      </tr>
                  </thead>
                  <tbody>
                      <slot v-for="(item, index) in appDetails.details">
                        <tr :key="index">
                          <td class="text-center" style="width:5%"> {{ $n(index + 1) }}</td>
                          <td class="text-center"><span v-if="item.made_tea_grade_id">{{ getMadeTeaGradeName(item.made_tea_grade_id) }}</span></td>
                          <td class="text-center"><span v-if="item.sample_no">{{ $n(item.sample_no, { useGrouping: false }) }}</span></td>
                          <td class="text-center"><span v-if="item.packets">{{ $n(item.packets) }}</span></td>
                        </tr>
                      </slot>
                      <tr>
                          <td colspan="3" class="text-right"><b>{{ $t('teaGardenBtriService.totalPackets') }}</b></td>
                          <td colspan="2" class="text-center"><b>{{ $n(appDetails.total_packets) }}</b></td>
                      </tr>
                  </tbody>
              </table>
          </b-col>
          <div class="d-flex justify-content-between mt-5 mx-3">
            <p>{{ $t('teaGardenBtriService.thanks') }}</p>
            <p>{{ $t('teaGardenBtriService.your_faith') }} <br> <br>
            ---------------
           </p>
          </div>
        </template>
      </body-card>
    </div>
  </template>
  <script>
  export default {
    props: ['app_detail'],
    data () {
      return {
        appDetails: this.app_detail
      }
    },
    computed: {
      currentLocale () {
          return this.$i18n.locale
      }
    },
    methods: {
      getGardenName (id) {
        const garden = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
        if (garden && this.$i18n.locale === 'bn') {
            return garden.text_bn
        } else if (garden && this.$i18n.locale === 'en') {
            return garden.text_en
        }
      },
      getMadeTeaGradeName (id) {
        const teaGrade = this.$store.state.TeaGardenService.commonObj.masterMadeTeaGradeList.find(item => item.value === id)
        if (teaGrade && this.$i18n.locale === 'bn') {
            return teaGrade.text_bn
        } else if (teaGrade && this.$i18n.locale === 'en') {
            return teaGrade.text_en
        }
      }
    }
  }
  </script>
