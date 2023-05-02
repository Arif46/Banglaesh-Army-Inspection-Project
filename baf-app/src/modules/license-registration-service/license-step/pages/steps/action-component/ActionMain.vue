<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
          <b-overlay :show="loading">
              <b-row>
                <b-col md="12" lg="12" sm="12">
                  <b-card no-body>
                      <b-overlay>
                        <b-row v-if ="checkApp">
                          <b-col>
                            <h4 class="p-4">{{ $t('li_step.already_submit_note') }}</h4>
                            <button @click="$router.go(-1)" class="btn btn-success btn-sm ml-4"><i class="ri-arrow-left-s-line mr-0"></i> {{ $t('globalTrans.back') }}</button>
                          </b-col>
                        </b-row>
                        <b-row v-if ="!checkApp">
                          <ActionForm :transferData="transferData" ref="ActionForm"/>
                        </b-row>
                      </b-overlay>
                  </b-card>
                </b-col>
              </b-row>
          </b-overlay>
      </template>
    </iq-card>
  </b-container>
</template>
<script>
import ActionForm from './ActionForm.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepFormData } from '../../../api/routes'
import { isNotEmpty } from '@/utils/fliter'
export default {
  components: {
    ActionForm
  },
  data () {
    return {
      transferData: {},
      loading: false,
      checkApp: false
    }
  },
  created () {
    this.step_id = parseInt(this.$route.query.step_id)
    this.loadFromWithData()
  },
  methods: {
    loadFromWithData () {
      const formId = 26
      const serviceId = this.$route.query.service_id
      const stepId = this.$route.query.step_id
      const params = {
        id: formId,
        service_id: serviceId,
        step_id: stepId,
        applicationID: parseInt(this.$route.query.application_id)
      }
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormData, params).then(response => {
        this.loading = false
        if (isNotEmpty(response.data)) {
            this.transferData = response.data
            if (response.data.applicationData.length) {
              this.checkApp = true
            } else {
              this.checkApp = false
            }
          }
      })
    },
    backStep () {
      this.$router.go(-1)
    }
  }
}
</script>
