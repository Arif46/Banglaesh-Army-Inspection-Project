<template>
  <div>
    <b-row >
      <b-col md="10" offset-md="1">
        <b-overlay :show="loading">
          <b-row v-for="(application, appIndex) in applications" :key="appIndex" style="border: 1px solid #1b67b3;border-radius: 5px;">
              <b-col md="12 mt-3">
                <div>
                  <h6 class="mb-3">
                    <span class="badge badge-info float-left mb-3">{{ $t('dealer.application_id') }} : {{ $n(application.application_id, { useGrouping: false }) }}</span>
                    <span class="ml-2" v-if="application.expire_date && application.type == 1"> {{ $t('externalLrcpn.expire_date') + ' : '}} {{ application.expire_date | dateFormat }}</span>
                    <span class="ml-2" v-if="application.agreement_no && application.type == 2"> {{ $t('externalLrcpn.expire_date') + ' : '}} {{ application.expire_date | dateFormat }}</span>
                    <span class="ml-2" v-if="application.expire_date && application.type == 3"> {{ $t('externalLrcpn.expire_date') + ' : '}} {{ application.expire_date | dateFormat }}</span>
                    <span v-if="application.approval_status > 1" :class="application.approval_status === 2 ? `badge badge-danger float-right` : `badge badge-warning float-right`">{{ getStatusName(application.approval_status) }}</span>
                    <span v-else>
                      <span v-if="appIndex === 0" class="badge badge-success float-right">{{ $t('dealer.running') }}</span>
                    </span>
                  </h6>
                </div>
              </b-col>
              <b-col md="10">
                <div class="stepper-wrapper">
                  <div :class="item.value <= application.status ? ( application.approval_status <= 1 ? `stepper-item completed` : notcomplete_style) : `stepper-item`" v-for="(item, index) in stepList" :key="index">
                    <div class="step-counter">
                      <i v-if="item.value < application.status || application.agreement_no" class="ri-check-fill"></i>
                      <span v-else>{{ $n(index + 1) }}</span>
                    </div>
                    <div class="step-name">{{ item.text }}</div>
                  </div>
                </div>
              </b-col>
              <b-col md="2" class="text-left">
                  <div class="text-center">
                    <button @click="viewApp(application)" style="border-radius: 40px" :title="$t('globalTrans.view')" class="mt-1 btn btn-warning btn-sm"><i class="ri-eye-line"></i></button>
                    <br />{{ $t('dealer.view_application') }}
                  </div>
                  <button v-if="application.approval_status===2" @click="newApp()" style="border-radius: 40px" :title="$t('dealer.new_application')" class="mt-1 btn btn-success ml-1"><i class="ri-file-add-line"></i></button>
                  <button v-if="application.approval_status===3" @click="resubmitApp(application.id)" style="border-radius: 40px" :title="$t('dealer.resubmit')" class="mt-1 btn btn-success ml-1"><i class="ri-reply-fill"></i></button>
              </b-col>
          </b-row>
          <b-modal id="application_form" size="lg" :title="$t('dealer.application_form')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
              <Detail :appDetail="appDetail" :applications="applications" :isModal="true" />
          </b-modal>
        </b-overlay>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { changeAppStatus } from '../../api/routes'
import Detail from './Details.vue'
export default {
  props: ['applications'],
  name: 'AppStep',
  components: {
    Detail
  },
  data () {
    return {
      notcomplete_style: 'stepper-item completed-red',
      notcomplete_text: '',
      appDetail: {},
      loading: false
    }
  },
  created () {
  },
  computed: {
    stepList () {
      const tcbStepList = this.$store.state.ExternalUserService.dealerPanel.commonObj.tcbStepList.filter(item => item.value !== 5).map(item => {
        return this.$i18n.locale === 'bn' ? { value: item.value, text: item.text_bn } : { value: item.value, text: item.text_en }
      })
      return tcbStepList
    }
  },
  methods: {
    getStatusName (status) {
      if (status === 2) {
        this.notcomplete_style = 'stepper-item completed-red'
      } else {
        this.notcomplete_style = 'stepper-item completed-warning'
      }
      return status === 2 ? this.$t('dealer.reject') : this.$t('dealer.resubmited')
    },
    viewApp (item) {
      this.appDetail = item
      this.$bvModal.show('application_form')
    },
    newApp () {
      this.$emit('enableNew')
    },
    resubmitApp (id) {
      window.vm.$swal({
        title: window.vm.$t('license_management.resubmitStatus'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.resubmitStatus(id)
        }
      })
    },
    resubmitStatus (id) {
      this.loading = true
      RestApi.deleteData(licenseRegistrationServiceBaseUrl, `${changeAppStatus}/${id}`).then(response => {
        this.loading = false
        this.$emit('submitForm')
      })
    }
  }
}
</script>
