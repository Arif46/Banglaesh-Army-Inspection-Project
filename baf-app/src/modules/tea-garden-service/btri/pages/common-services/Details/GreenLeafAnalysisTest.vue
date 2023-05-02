<template>
  <div class="inner-section a11-wrapper">
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ currentLocale === 'en' ? appDetails.service.service_name_en : appDetails.service.service_name_bn }}</h4>
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
        <p class="mb-4">{{ $t('teaGardenBtriService.subject') }}: <span v-if="currentLocale === 'en'">{{ $t('teaGardenBtriService.subject_end') }}</span> <span class="dynamic-line-wrapper">{{ currentLocale === 'en' ? appDetails.service.service_name_en : appDetails.service.service_name_bn }}</span> <span v-if="currentLocale === 'bn'">{{ $t('teaGardenBtriService.subject_end') }}</span></p>
        <div class="cover-letter-wrapper">
          <p class="mb-2">{{ $t('teaGardenBtriService.dear') }}</p>
          <p v-if="currentLocale === 'bn'">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;উপর্যুক্ত বিষয়ে, <span class="dynamic-line-wrapper">{{ getGardenName(appDetails.garden_id) }}</span> এর
            <span v-for="(item, index) in detailsInfo" :key="index">
              <span class="dynamic-line-wrapper">{{ getSectionName(item.section_id) }}</span> নং সেকশনের <span class="dynamic-line-wrapper">{{ $n(1) }}</span> টি <slot  v-if="index !== (detailsInfo.length - 1)">, </slot>
            </span>
            করে মোট <span class="dynamic-line-wrapper">{{ $n(appDetails.total_samples) }}</span> টি সবুজ পাতার নমুনা (ভেতরে ট্যাগসহ) রাসায়নিক (পুষ্টি উপাদান) বিশ্লেষণপূর্বক প্রয়োজনীয় সুপারিশসহ পরামর্শ প্রদানের জন্য প্রেরণ করা হলো। প্রয়োজনীয় ব্যবস্থা গ্রহনের জন্য আপনাকে বিনীত অনুরোধ জানাচ্ছি।
          </p>
          <p v-else>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Regarding the above, a total of <span class="dynamic-line-wrapper">{{ $n(appDetails.total_samples) }}</span> green leaf samples (with tags inside) of
            <span v-for="(item, index) in detailsInfo" :key="index">
              <span class="dynamic-line-wrapper">{{ $n(1) }}</span> of section no <span class="dynamic-line-wrapper">{{ getSectionName(item.section_id) }}</span><slot  v-if="index !== (detailsInfo.length - 1)">, </slot>
            </span>
            of <span class="dynamic-line-wrapper">{{ getGardenName(appDetails.garden_id) }} </span> were sent for chemical (nutrient) analysis and advice along with necessary recommendations. I humbly request you to take necessary action.
          </p>
          <div class="table-responsive mt-5">
            <table class="table table-sm table-bordered section-tree-view-table">
              <thead>
              <tr>
                <th>{{ $t('globalTrans.sl_no') }}</th>
                <th>{{ $t('teaGardenConfig.section') }}</th>
                <th>{{ $t('teaGardenBtriService.sample_no') }}</th>
                <th>{{ $t('teaGardenBtriService.packets') }}</th>
              </tr>
              </thead>
              <tbody>
              <slot v-for="(item, index) in detailsInfo">
                <tr :key="index">
                  <td class="text-center"> {{ $n(index + 1) }}</td>
                  <td><span v-if="item.section_id">{{ getSectionName(item.section_id) }}</span></td>
                  <td>
                    {{ $n(item.sample_no, { useGrouping: false }) }}
                  </td>
                  <td class="text-center">
                    {{ $n(item.packets) }}
                  </td>
                </tr>
              </slot>
              <tr>
                <td colspan="3" class="text-right"><b>{{ $t('teaGardenBtriService.totalPackets') }}</b></td>
                <td colspan="2" class="text-center"><b>{{ $n(appDetails.total_packets) }}</b></td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
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
      appDetails: this.app_detail,
      contentEn: '',
      contentBn: ''
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    detailsInfo () {
      return this.appDetails.details
    },
    masterSectionList () {
      return this.$store.state.TeaGardenService.commonObj.masterSectionList.filter(item => item.status === 1)
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
    getFertilizerTypeName (id) {
      const fertilizerType = this.$store.state.TeaGardenService.commonObj.organicFertilizerTypes.find(item => item.value === id)
      if (fertilizerType && this.$i18n.locale === 'bn') {
        return fertilizerType.text_bn
      } else if (fertilizerType && this.$i18n.locale === 'en') {
        return fertilizerType.text_en
      }
    },
    getSectionName (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.masterSectionList.find(item => item.value === id)
      if (obj && this.$i18n.locale === 'bn') {
        return obj.text_bn
      } else if (obj && this.$i18n.locale === 'en') {
        return obj.text_en
      }
    }
  }
}
</script>
