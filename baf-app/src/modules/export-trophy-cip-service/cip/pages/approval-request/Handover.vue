<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
            <b-row>
                <b-col lg="12" md="12" sm="12">
                    <ValidationProvider name="Type" vid="type" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="type"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('cip.signature_type') }} :
                        </template>
                        <b-form-radio-group
                            class="mt-2"
                            v-model="form.type"
                            :options="signatureTypeList"
                            value-field="value"
                            text-field="text"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-radio-group>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                    <ValidationProvider name="CIP List" vid="cip_list">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="cip_list"
                        >
                            <template v-slot:label>
                                {{ $t('cip.cip_list') }} :
                            </template>
                            <b-button variant="success" class="btn-xs mr-2" @click="downloadCipList" :title="$t('globalTrans.download')"><i class="ri-download-cloud-fill"></i></b-button>
                            <!-- <b-button variant="success" class="btn-xs" :title="$t('globalTrans.view')"><i class="ri-eye-line"></i></b-button> -->
                        </b-form-group>
                    </ValidationProvider>
                    <ValidationProvider name="Handover to" vid="handover_to">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="handover_to"
                        >
                            <template v-slot:label>
                                {{ $t('cip.handover_to') }} :
                            </template>
                            <h4 class="mt-1">{{ handoverTo }}</h4>
                        </b-form-group>
                    </ValidationProvider>
                   <ValidationProvider name="Signature" vid="signature">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="type"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('globalTrans.signature') }} :
                        </template>
                         <b-form-input
                            v-if="!attachmentShow"
                            class="mt-2"
                            v-model="form.signature"
                            :readonly=true
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <b-form-file
                            v-else
                            class="mt-2"
                            @change="getAttachment"
                            accept="image/jpg, image/png"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-file>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
            </b-row>
            <b-row class="text-right">
                <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm" id="forwardSubmit">{{ $t('globalTrans.submit') }}</b-button>
                    <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-handover')" id="forwardCancel">{{ $t('globalTrans.cancel') }}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { applicantsTradesApi, approvalReqHandoverApi } from '../../api/routes'
import moment from 'moment'
import ExportPdf from './cip_app_trade_pdf'

export default {
    props: ['handover_to'],
    data () {
        return {
            handoverTo: '',
            loading: false,
            attachmentShow: false,
            applications: [],
            form: {
                user_id: this.$store.state.Auth.authUser.user_id,
                type: 2,
                handover_to: 1,
                year: moment(new Date()).format('YYYY'),
                signature: '',
                attachment: null
            },
            signatureTypeList: [
                { value: 1, text: 'Manual', text_en: 'Manual', text_bn: 'ম্যানুয়াল' },
                { value: 2, text: 'Automated', text_en: 'Automated', text_bn: 'স্বয়ংক্রিয়' }
            ]
        }
    },
    created () {
        this.getHandover()
        this.getCurrentUser()
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        },
        ...mapGetters({
            authUser: 'Auth/authUser'
        })
    },
    watch: {
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.localizeList(newVal)
            }
        },
        'form.type': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.checkSignatureOrAttachment(newVal)
            }
        }
    },
    methods: {
        getHandover () {
            this.handoverTo = this.handover_to === 1 ? this.$t('cip.cabinet') : this.$t('cip.pmo')
            this.form.handover_to = this.handover_to
        },
        async submit () {
            this.loading = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadingState = { loading: false, listReload: false }
            result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, approvalReqHandoverApi, this.form)
            this.loading = false
            loadingState.listReload = true
            this.$store.dispatch('mutateCommonProperties', loadingState)

            if (result.success) {
                this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.$t('globalTrans.update_msg'),
                    color: '#D6E09B'
                })
                this.$store.dispatch('ExportTrophyCipService/setPendingForward', true)
                this.$bvModal.hide('modal-handover')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
        },
        localizeList (locale) {
            return this.signatureTypeList.map(item => {
                return Object.assign({}, item, {
                    text: locale === 'en' ? item.text_en : item.text_bn
                })
            })
        },
        checkSignatureOrAttachment (type) {
            if (type === 1) {
                this.attachmentShow = true
            } else {
                this.attachmentShow = false
            }
        },
        getAttachment (e) {
            const selectedFile = e.target.files[0]
            const reader = new FileReader()
            reader.onload = (event) => {
                this.form.attachment = event.target.result
            }
            reader.readAsDataURL(selectedFile)
        },
        getCurrentUser () {
            const officeList = this.$store.state.CommonService.commonObj.officeList
            const assignDesignationList = this.$store.state.CommonService.commonObj.assignDesignationList

            const tmpOffice = officeList.find(tmp => tmp.value === this.authUser.office_detail.office_id)
            const tmpDesgination = assignDesignationList.find(tmp => tmp.value === this.authUser.office_detail.designation_id)

            const name = this.currentLocale === 'bn' ? this.authUser.name_bn : this.authUser.name
            const office = this.currentLocale === 'bn' ? tmpOffice.text_bn : tmpOffice.text_en
            const designation = this.currentLocale === 'bn' ? tmpDesgination.text_bn : tmpDesgination.text_en

            this.form.signature = name + ', ' + office + ', ' + designation
        },
        async downloadCipList () {
            this.loading = true
            this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, applicantsTradesApi, this.search)
            this.loading = false
            if (result.success) {
                // this.applications = this.getRelationalData(result.data, result.users)
                this.applications = result.data
                this.pdfExport()
            } else {
                this.applications = []
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        },
        pdfExport () {
            const reportTitle = this.$t('cip.cip_list_for_approval')
            ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.form.type, this.form.signature)
        }
    }
}
</script>
