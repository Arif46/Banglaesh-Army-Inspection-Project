<template>
  <table style="width: 100%; display: inline-table;" border="0">
      <template>
        <tr>
          <b-th class="text-center" :colspan="colspan" style="font-size:18px;">
            {{ $t('globalTrans.government_republic_of_bangladesh') }}
          </b-th>
        </tr>
        <tr>
          <b-th class="text-center" :colspan="colspan" style="font-size:16px;">
            {{ orgName }}
          </b-th>
        </tr>
        <tr>
          <b-th class="text-center" :colspan="colspan" style="font-size:14px;">
            {{ address }}
          </b-th>
        </tr>
      </template>
  </table>
</template>

<script>
import RestApi from '@/config/api_config'

export default {
  props: {
    baseUrl: String,
    params: Object,
    uri: String,
    orgId: Number,
    colspan: Number,
    loadingState: Boolean
  },
  data () {
    return {
      orgName: '',
      leftLogo: '',
      rightLogo: '',
      address: '',
      projectName: ''
    }
  },
  computed: {
    langChange () {
      return this.$i18n.locale
    },
    getParams () {
        const defaultParam = { leftPath: 'uploads/config/left-logo/original/', rightPath: 'uploads/config/right-logo/original/' }
        if (this.params && typeof this.params !== 'undefined' && Object.keys(this.params).length > 0) {
            return this.params
        } else {
            return defaultParam
        }
    }
  },
  watch: {
    loadingState: function (newVal, oldVal) {
      if (newVal === true) {
        this.getReportHead(this.orgId)
      }
    },
    langChange: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getReportHead(this.orgId)
      }
    }
  },
  created () {
    this.getReportHead(this.orgId)
  },
  methods: {
    getReportHead (orgId) {
      if (!orgId) {
        return
      }
      RestApi.getData(this.baseUrl, this.uri + '/' + this.orgId, this.getParams).then(response => {
        if (typeof response.success !== 'undefined' && response.success) {
          const orgData = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === this.orgId)
          this.leftLogo = response.data.left_logo
          this.rightLogo = response.data.right_logo
          this.address = this.$i18n.locale === 'en' ? response.data.address : response.data.address_bn
          this.orgName = this.$i18n.locale === 'en' ? orgData.text_en : orgData.text_bn

          if (Object.prototype.hasOwnProperty.call(response.data, 'project_name')) {
            this.projectName = this.$i18n.locale === 'en' ? response.data.project_name : response.data.project_name_bn
          }
        }
      })
    }
  }
}
</script>
<style scoped>
  .report-title {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 20px;
    margin-top: 15px;
    color: var(--iq-dark)
  }
</style>
