<template>
    <div>
      <b-card>
        <b-row>
            <b-col sm="12" class="mt-2">
            <b> {{ $t('exportTrophyCircular.title') }} </b> : {{ currentLocale === 'bn' ? form.title_bn : form.title_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.year')}} </b> : {{ EngBangNum(form.year.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{$t('externalUser.et')}} {{ $t('globalTrans.fiscal_year')}} </b> : {{ getFiscalYear(form.fiscal_year_id) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.memo_no')}} </b> : {{ form.memo_no }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.circular_date') }} </b> : {{ form.date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.app_start_date')}} </b> : {{ form.app_start_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyCircular.deadline')}} </b> : {{ form.deadline | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2" v-if="id && form.attachment !== null">
              <a :href="exportTrophyCIPServiceBaseUrl + 'download-attachment?file=' + form.attachment" class="badge badge-primary">
                <i class="ri-cloud-fill"></i>
                {{ $t('globalTrans.attachment') }}
              </a>
            </b-col>
            <b-col sm="6" class="mt-2" v-else>
              {{ $t('globalTrans.attachment') }} : {{ $t('exportTrophyCircular.notGiven') }}
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
        <b-row class="mt-3" v-if="form.details.length !== 0">
          <b-col sm="12">
            <h5 class="card-title"><b>{{ $t('exportTrophyCircular.forward_comments') }}</b></h5>
          </b-col>
          <b-col sm="12">
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                    <tr>
                      <th scope="col"> {{ $t('exportTrophyCircular.commentedBy') }} </th>
                      <th scope="col"> {{ $t('globalTrans.designation') }} </th>
                      <th scope="col"> {{ $t('globalTrans.comments') }} </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(details, index) in form.details" :key="index">
                      <td>
                        {{ getNameReceiver(details.sender_id) }}
                      </td>
                      <td>
                        {{ getForwardUserDesignation(details.sender_id) }}
                      </td>
                      <td>
                        {{ currentLocale === 'bn' ? details.note_bn : details.note_en }}
                      </td>
                    </tr>
                </tbody>
            </table>
            </div>
          </b-col>
        </b-row>
        <b-row class="mt-3" v-if="form.approve !== null">
          <b-col sm="12">
            <h5 class="card-title"><b>{{ $t('exportTrophyCircular.approveBy') }}</b></h5>
          </b-col>
          <b-col sm="12">
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                    <tr>
                      <th scope="col"> {{ $t('exportTrophyCircular.commentedBy') }} </th>
                      <th scope="col"> {{ $t('globalTrans.designation') }} </th>
                      <th scope="col"> {{ $t('globalTrans.comments') }} </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                      <td>
                        {{ getNameReceiver(form.approve.receiver_id) }}
                      </td>
                      <td>
                        {{ getForwardUserDesignation(form.approve.receiver_id) }}
                      </td>
                      <td>
                        {{ form.approve_note }}
                      </td>
                    </tr>
                </tbody>
            </table>
            </div>
          </b-col>
        </b-row><b-row class="mt-3" v-if="form.approve !== null && form.approve.publishedBy !== null">
          <b-col sm="12">
            <h5 class="card-title"><b>{{ $t('exportTrophyCircular.publishedBy') }}</b></h5>
          </b-col>
          <b-col sm="12">
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                    <tr>
                      <th scope="col"> {{ $t('exportTrophyCircular.commentedBy') }} </th>
                      <th scope="col"> {{ $t('globalTrans.designation') }} </th>
                      <th scope="col"> {{ $t('globalTrans.comments') }} </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                      <td>
                        {{ getNameReceiver(form.approve.publishedBy) }}
                      </td>
                      <td>
                        {{ getForwardUserDesignation(form.approve.publishedBy) }}
                      </td>
                      <td>
                        {{ form.published_note }}
                      </td>
                    </tr>
                </tbody>
            </table>
            </div>
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
  props: ['id', 'userDetails'],
  data () {
    return {
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      valid: null,
      errors: [],
      userList: [],
      form: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCircular()
      this.form = tmp
      this.userList = this.userDetails
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
    getAwardType (assignTypeId) {
      const awardType = this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.find(assignType => assignType.value === parseInt(assignTypeId))
      if (awardType !== 'undefined') {
        return this.currentLocale === 'bn' ? awardType.text_bn : awardType.text_en
      }
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getOrg (orgId) {
      const orgObj = this.$store.state.CommonService.commonObj.componentOrgList.find(org => org.value === parseInt(orgId))
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
    },
    getNameReceiver (id) {
      const userName = this.userList.find(user => user.value === id)
      if (this.$i18n.locale === 'bn') {
        return userName.text_bn
      } else {
        return userName.text_en
      }
    },
    getForwardUserDesignation (id) {
      const userName = this.userList.find(user => user.value === id)
      const designationObj = this.$store.state.CommonService.commonObj.designationList.find(deg => deg.value === parseInt(userName.designation_id))
      if (designationObj !== 'undefined') {
        return this.currentLocale === 'bn' ? designationObj.text_bn : designationObj.text_en
      }
    }
  }
}
</script>
