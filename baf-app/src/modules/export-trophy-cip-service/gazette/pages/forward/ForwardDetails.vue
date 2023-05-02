<template>
    <div>
        <b-row class="mt-3" v-if="form.details.length !== 0">
          <b-col sm="12">
            <h5 class="card-title"><b>{{ $t('exportTrophyGazette.forward_comment') }}</b></h5>
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
            <h5 class="card-title"><b>{{ $t('exportTrophyGazette.approve_comment') }}</b></h5>
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
            <h5 class="card-title"><b>{{ $t('exportTrophyGazette.publish_comment') }}</b></h5>
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
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-forward-details')">{{ $t('globalTrans.cancel') }}</b-button>
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
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    getNameReceiver (id) {
      const userName = this.userList.find(user => user.value === parseInt(id))
      if (userName !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return userName.text_bn
        } else {
          return userName.text_en
        }
      }
    },
    getForwardUserDesignation (id) {
      const userName = this.userList.find(user => user.value === parseInt(id))
      if (userName !== undefined) {
        const designationObj = this.$store.state.CommonService.commonObj.designationList.find(deg => deg.value === parseInt(userName.designation_id))
        if (designationObj !== undefined) {
          return this.currentLocale === 'bn' ? designationObj.text_bn : designationObj.text_en
        }
      }
    }
  }
}
</script>
