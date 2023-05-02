<template>
    <div>
      <b-overlay :show="userLoading">
        <b-row class="mt-3" v-if="forwardList.length !== 0">
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
                    <tr v-for="(details, index) in forwardList" :key="index">
                      <td>
                        {{ getNameReceiver(details.sender_id) }}
                      </td>
                      <td>
                        {{ getForwardUserDesignation(details.sender_id) }}
                      </td>
                      <td>
                        {{ currentLocale === 'bn' ? details.note_bn : details.note }}
                      </td>
                    </tr>
                </tbody>
            </table>
            </div>
          </b-col>
        </b-row>
        <b-row class="mt-3" v-if="approveItem">
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
                        {{ getNameReceiver(approveItem.appr_rejected_by) }}
                      </td>
                      <td>
                        {{ getForwardUserDesignation(approveItem.appr_rejected_by) }}
                      </td>
                      <td>
                        {{ approveItem.comments }}
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
      </b-overlay>
    </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { getForwardCommentsApi } from '../../api/routes'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      errors: [],
      userLoading: false,
      forwardList: [],
      approveItem: null,
      userList: [],
      form: []
    }
  },
  created () {
    if (this.items) {
      this.getForwardComments(this.items.id)
      this.userList = this.userDetails
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getForwardComments (circularId) {
      this.userLoading = true
      RestApi.getData(internationalTradeFairServiceBaseUrl, `${getForwardCommentsApi}/${circularId}`).then(response => {
        if (response.success) {
          this.forwardList = response.forwardList
          this.approveItem = response.approve
          this.userList = response.users
        }
        this.userLoading = false
      })
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
