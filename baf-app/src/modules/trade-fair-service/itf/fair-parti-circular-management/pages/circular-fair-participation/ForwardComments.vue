<template>
    <div>
      <b-overlay :show="userLoading">
        <b-row class="mt-3" v-if="forwardList">
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
                    <tr v-for="(details, index) in forwardList.forwards" :key="index">
                      <td>
                        {{ getNameReceiver(details.sender_id) }}
                      </td>
                      <td>
                        {{ getUserDesignatioin(details.sender_id) }}
                      </td>
                      <td>
                        {{ currentLocale === 'bn' ? details.comment_bn : details.comment_en }}
                      </td>
                    </tr>
                </tbody>
            </table>
            </div>
          </b-col>
        </b-row>
        <b-row class="mt-3" v-if="forwardList">
          <b-col sm="12" v-if="forwardList.appr_return_by !== null">
            <h5 class="card-title"><b>{{ forwardList.status === 3 || forwardList.status === 5 ? $t('exportTrophyGazette.approve_comment') : $t('globalTrans.review') }}</b></h5>
          </b-col>
          <b-col sm="12" v-if="forwardList.appr_return_by !== null">
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
                        {{ getNameReceiver(forwardList.appr_return_by) }}
                      </td>
                      <td>
                        {{ getUserDesignatioin(forwardList.appr_return_by) }}
                      </td>
                      <td>
                        {{ forwardList.comments }}
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
import { itfFairPartiCircularForwardCommentsApi } from '../../api/routes'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      errors: [],
      userLoading: false,
      forwardList: null,
      userList: [],
      form: []
    }
  },
  created () {
    if (this.item) {
      this.getForwardComments(this.item.id)
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
      RestApi.getData(internationalTradeFairServiceBaseUrl, `${itfFairPartiCircularForwardCommentsApi}/${circularId}`).then(response => {
        if (response.success) {
          this.forwardList = response.forwardItem
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
      if (id) {
        const userName = this.userList.find(user => user.value === parseInt(id))
        if (userName !== undefined) {
          if (this.$i18n.locale === 'bn') {
            return userName.text_bn
          } else {
            return userName.text_en
          }
        }
      }
    },
    getUserDesignatioin (id) {
      if (id) {
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
}
</script>
