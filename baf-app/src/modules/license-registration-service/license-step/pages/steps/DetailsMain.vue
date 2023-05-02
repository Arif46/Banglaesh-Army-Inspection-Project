<template>
    <b-container fluid class="mt-5">
        <b-overlay :show="unitLoad">
            <b-row v-if="transferData.all_service_data">
                <b-col md="12">
                    <span v-if="transferData.all_service_data.is_transferred === 1">
                        <AppDetails :transferData="transferData" :stepData="stepChange" :nothiSend="nothiSend" ref="appDetails"/>
                    </span>
                    <span v-if="transferData.all_service_data.is_transferred === 2">
                        <TransferDetail :transferData="transferData" :stepData="stepChange" ref="transferDetails"/>
                    </span>
                </b-col>
            </b-row>
        </b-overlay>
    </b-container>
</template>

<script>
import AppDetails from './AppDetails.vue'
import TransferDetail from './TransferDetail.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepFormDetailsData } from '../../api/routes'
import { isNotEmpty } from '@/utils/fliter'

export default {
    components: {
        AppDetails,
        TransferDetail
    },
    props: ['stepChange', 'nothiSend'],
    data () {
        return {
            transferData: {},
            unitLoad: true
        }
    },
    created () {
        if (this.stepChange) {
            this.loadFrom(parseInt(this.stepChange.service_id))
        }
    },
    methods: {
        async loadFrom (serviceId) {
            const formData = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => item.service_id === serviceId && item.form_type === 2)
            if (typeof formData !== 'undefined') {
                const formId = formData.form_id
                this.unitLoad = true
                const params = {
                id: formId,
                service_id: parseInt(this.stepChange.service_id),
                step_id: this.getGridStep(parseInt(this.stepChange.service_id)).step_id,
                current_step: parseInt(this.stepChange.step_id),
                applicationID: parseInt(this.stepChange.application_id[0]),
                org_id: parseInt(this.stepChange.org_id),
                receiver_id: this.$store.state.Auth.authUser.user_id
                }
                await RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormDetailsData, params).then(response => {
                    if (isNotEmpty(response.data)) {
                        this.transferData = response.data
                    }
                })
                this.unitLoad = false
            }
        },
        getGridStep (serviceId) {
            const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
            if (typeof tmpService === 'undefined') {
                return {}
            } else {
                return tmpService
            }
        }
    }
}
</script>
