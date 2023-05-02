<template>
    <div>
      <b-card>
        <b-row>
            <b-col sm="12">
              <b> {{ $t('exportTrophyCircular.title') }} </b> : {{ currentLocale === 'bn' ? form.title_bn : form.title_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.year')}} </b> : {{ EngBangNum(form.year.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.fiscal_year')}} </b> : {{ getFiscalYear(form.fiscal_year_id) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.app_start_date')}} </b> : {{ form.app_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.deadline')}} </b> : {{ form.deadline_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.memo_no')}} </b> : {{ form.memo_no }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <a :href="baseUrl + 'download-attachment?file=' + form.attachment" class="badge badge-primary">
                <i class="ri-cloud-fill"></i>{{ $t('globalTrans.attachment') }}
              </a>
            </b-col>
            <b-col sm="12" class="mt-2">
                <p>
                  <b> {{ $t('globalTrans.description') }} : </b>
                </p>
                <div v-if="currentLocale === 'en'" v-html="form.description_en"></div>
                <div v-if="currentLocale === 'bn'" v-html="form.description_bn"></div>
            </b-col>
        </b-row>
      </b-card>
        <b-row>
          <b-col sm="12" class="mt-2">
            <p class="text-center">( {{ currentLocale === 'bn' ? form.contact_person_name_bn : form.contact_person_name_en }} )</p>
            <p class="text-center"> {{ getDesignation(form.designation_id) }} </p>
            <p class="text-center"> {{ getOrg(form.org_id) }} </p>
            <p class="text-center"> {{ $t('globalTrans.phone_no') }} - {{ EngBangNum(form.contact_person_mobile) }} </p>
            <p class="text-center"> {{ $t('globalTrans.email') }} : {{ form.contact_person_email }} </p>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      baseUrl: exportTrophyCIPServiceBaseUrl,
      form: {}
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircular()
      this.form = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getCircular () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getOrg (orgId) {
      const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(orgId))
      if (orgObj !== 'undefined') {
        return this.currentLocale === 'bn' ? orgObj.text_bn : orgObj.text_en
      }
    },
    getDesignation (designationId) {
      const designationObj = this.$store.state.CommonService.commonObj.designationList.find(deg => deg.value === parseInt(designationId))
      if (designationObj !== 'undefined') {
        return this.currentLocale === 'bn' ? designationObj.text_bn : designationObj.text_en
      }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    }
  }
}
</script>
