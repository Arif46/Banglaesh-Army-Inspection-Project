<template>
    <b-container fluid>
        <Search @LOAD_DATA="getSearchData" :key="componentKey" :orgId="orgId" :serviceId="service_id"/>
        <b-row>
            <b-col md="12">
                <body-card>
                    <template v-slot:headerTitle>
                        <h4 class="card-title">{{ $t('li_step.application_entry') }}</h4>
                    </template>
                    <template v-slot:headerAction>
                        <router-link :to="`application-form-entry`" :title="$t('globalTrans.add_new')" size="sm">
                        <b-button variant="primary" class="btn-sm">
                            {{  $t('globalTrans.add_new') }}
                        </b-button>
                        </router-link>
                    </template>
                    <template v-slot:body>
                        <b-overlay :show="listLoading">
                            <b-row>
                                <b-col md="12" class="table-responsive dataList">
                                    <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                                        <template v-slot:cell(index)="data">
                                            {{ $n(data.index + pagination.slOffset) }}
                                        </template>
                                        <template v-slot:cell(org_id)="data">
                                            {{ getMainStoreData('orgList', data.item.org_id) }}
                                        </template>
                                        <template v-slot:cell(service_id)="data">
                                            {{ getStoreData('licenseRegistration', 'serviceNamesList', data.item.service_id) }}
                                        </template>
                                        <template v-slot:cell(application_id)="data">
                                            {{ $n(data.item.application_id, { useGrouping: false }) }}
                                        </template>
                                        <template v-slot:cell(type)="data">
                                            <span class="badge pay-status badge-success" v-if="data.item.type === 2">
                                                {{ $t('globalTrans.renew') }}
                                            </span>
                                            <span v-else>
                                                {{ $t('globalTrans.new') }}
                                            </span>
                                        </template>
                                        <template v-slot:cell(expire_date)="data">
                                            <span v-if="data.item.expire_date">
                                                {{ data.item.expire_date | dateFormat }}
                                            </span>
                                        </template>
                                        <template v-slot:cell(status)="data">
                                            {{ getStepName(data.item.current_step) + ' ' + ServiceLastStepCheck(data.item.service_id, data.item.current_step, data.item.status) }}
                                        </template>
                                        <template v-slot:cell(payment_status)="data">
                                        <!-- <span v-if="servicePayment(data.item.service_id).application_fee" :class="data.item.type_pay_status ? `badge pay-status badge-success` : ` badge pay-status blink_me badge-warning`">{{ $t('externalLrcpn.application_fee') }}</span> -->
                                            <span v-if="paymentCheck(data.item.service_id, data.item.current_step) && data.item.type === 1" :class="data.item.step_pay_status ? `badge pay-status badge-success` : `blink_me badge pay-status badge-warning`">{{ $t('externalLrcpn.payments') }} {{ data.item.step_pay_status ? $t('globalTrans.paid') : '' }}</span>
                                            <span v-if="servicePayment(data.item.service_id).renew && data.item.type === 2" :class="data.item.renew_pay_status ? `badge pay-status badge-success` : `blink_me badge pay-status badge-warning`">{{ $t('externalLrcpn.renew_fee') }}</span>
                                        <!-- <span v-if="servicePayment(data.item.service_id).lost && data.item.status === 1" :class="data.item.lost_pay_status ? `badge pay-status badge-success` : `blink_me badge pay-status badge-warning`">{{ $t('externalLrcpn.lost_fee') }}</span> -->
                                        </template>
                                        <template v-slot:cell(action)="data">
                                            <span>
                                                <!-- Application View (Details) -->
                                                <span @click="SetStep(data.item, 1)">
                                                    <router-link :to="{ name: 'app_detail', params: { stepChange }}" :title="$t('globalTrans.details')" :class="`btn btn-sm btn-info m-1`" size="sm"><i :class="`ri-eye-line`" @click="SetStep(data.item, 1)"></i></router-link>
                                                </span>
                                                <!-- License View -->
                                                <template v-if="data.item.generate_id !== null">
                                                    <span @click="SetStep(data.item, 1)">
                                                        <router-link :to="{ name: getBtn(5).url, params: { stepChange }}" :title="getBtn(5).text" :class="`btn btn-sm `+ getBtn(5).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(5).icon"></i></span></router-link>
                                                    </span>
                                                </template>
                                                <!-- Publish Document -->
                                                <a class="btn btn-success m-1 btn-sm" target = '_blank'  :href="licenseRegistrationServiceBaseUrl + 'uploads/lrcpn/' + data.item.attachment" download v-if="data.item.attachment !== null" :title="$t('globalTrans.doc_download')"><i class="fa fa-download" aria-hidden="true"></i></a>
                                                <!-- All receipt -->
                                                <b-button v-if="paymentStatus(data.item) > 0 || data.item.renew_pay_status === 1" class="btn btn-warning m-1 btn-sm" :title="$t('externalLrcpn.payment_receipt')" v-b-modal.modal-payment-receipt @click="setupReceipt(data.item)"><i class="fas fa-receipt"></i></b-button>
                                                <!-- All Payment -->
                                                <b-button v-if="paymentCheck(data.item.service_id, data.item.current_step) && paymentStatus(data.item) === 0 && data.item.type === 1" class="btn btn-warning m-1 btn-sm" title="Service Step Payment" v-b-modal.modal-payment style="padding:4px 3px !important" @click="paymentData(data.item)">{{ $t('globalTrans.pay') }}</b-button>
                                                <!-- renew payment -->
                                                <b-button v-if="servicePayment(data.item.service_id).renew && data.item.renew_pay_status === 0 && data.item.type === 2" class="btn btn-warning m-1 btn-sm" :title="$t('externalLrcpn.renew_payment')" v-b-modal.modal-payment-renew @click="setupPayment(data.item)" style="padding:4px 3px !important">{{ $t('globalTrans.pay') }}</b-button>                                            </span>
                                        </template>
                                    </b-table>
                                    <b-pagination
                                    v-model="pagination.currentPage"
                                    :per-page="pagination.perPage"
                                    :total-rows="pagination.totalRows"
                                    @input="searchData"
                                    />
                                </b-col>
                            </b-row>
                        </b-overlay>
                    </template>
                </body-card>
                <b-modal id="modal-payment-receipt" size="lg" :title="$t('externalLrcpn.payment_receipt')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
                    <PaymentReceipt :payment="payReceipt" />
                </b-modal>
                <b-modal id="modal-payment" size="lg" :title="$t('globalTrans.payment')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
                    <PaymentAll :payment="payment" />
                </b-modal>
                <b-modal id="modal-payment-renew" size="lg" :title="$t('externalLrcpn.renew_payment')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
                    <RenewPayment :payment="otherPayment" />
                </b-modal>
            </b-col>
        </b-row>
    </b-container>
</template>

<script>
import Search from './search'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { officeEntryList } from '../../api/routes'
import routeBaseMasterList from '@/mixins/list'
import common from '@/mixins/common-lrcpn'
import PaymentAll from '@/modules/external-user-service/views/lrcpn-panel/pages/application/PaymentAll'
import RenewPayment from '@/modules/external-user-service/views/lrcpn-panel/pages/application/PaymentRenew'
import PaymentReceipt from '@/modules/external-user-service/views/lrcpn-panel/pages/application/PaymentReceipt'
export default {
    mixins: [routeBaseMasterList, common],
    components: {
        Search,
        PaymentAll,
        RenewPayment,
        PaymentReceipt
    },
    data () {
        return {
            componentKey: 0,
            orgId: 0,
            step_id: 0,
            service_id: 0,
            listLoading: false,
            search: {},
            columns: [],
            allData: {},
            gridLangData: '',
            gridData: false,
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
            commonGrid: true,
            listGetData: '',
            payment: {},
            otherPayment: {},
            payReceipt: {},
            stepChange: {
                application_id: [],
                step_id: 0,
                service_id: 0,
                org_id: 0,
                status: 1
            },
            officerId: 0
        }
    },
    created () {
        this.officerId = this.$store.state.Auth.authUser.user_id
        this.orgId = this.$store.state.Auth.authUser.org_id
        this.setCommonGrid()
        this.loadData()
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    watch: {
        laodList: function (n, o) {
            if (n !== o) {
                this.loadData()
            }
        },
        local: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.getLanguateWisedata()
                this.componentKey = this.componentKey + 1
            }
        }
    },
    methods: {
        getBtn (value) {
            return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
        },
        getLanguateWisedata () {
            if (this.commonGrid === true) {
                this.setCommonGrid()
            } else {
                this.setGridData(this.gridLangData)
            }
        },
        searchData () {
            this.loadData()
        },
        loadData () {
            const params = Object.assign({}, this.search, {
                page: this.pagination.currentPage,
                per_page: this.pagination.perPage,
                step_id: this.step_id,
                is_org_admin: this.$store.state.Auth.authUser.is_org_admin,
                office_id: this.$store.state.Auth.authUser.office_id,
                org_id: this.orgId,
                createdBy: this.officerId
            })
            this.listLoading = true
            RestApi.getData(licenseRegistrationServiceBaseUrl, officeEntryList, params).then(response => {
                if (response.success) {
                    this.listGetData = response.data.data
                    if (this.gridData === true) {
                        this.gridLangData.forEach(item => {
                            if (item.fieldType === 'number') {
                            this.listGetData.forEach(listitem => {
                                const value = this.$n(listitem[item.fieldName], { useGrouping: false })
                                listitem[item.fieldName] = value
                            })
                            } else if (item.fieldType === 'dropdown') {
                                if (item.drpComponent === '1') {
                                    this.listGetData.forEach(listitem => {
                                    const drpvalue = this.getCommonStoreData(item.drpName, listitem[item.fieldName])
                                    listitem[item.fieldName] = drpvalue
                                    })
                                }
                            }
                        })
                    }
                    this.$store.dispatch('setList', response.data.data)
                    this.paginationData(response.data)
                }
                this.listLoading = false
            })
        },
        getSearchData (res) {
            this.step_id = res.step_id
            this.service_id = res.service_id
            this.officerId = res.searchData.createdBy
            if (res.type === 2) {
                this.allData = res.data
                this.search = res.searchData
                if (res.data.success) {
                    if (res.data.grid_field.length) {
                        const dynamicGrid = res.data.grid_field.map(item => {
                            const tmpData = JSON.parse(item.data)
                            if (tmpData.field_type === 'dropdown') {
                                const componentId = tmpData.dropdownData.component_id
                                const dropdownName = tmpData.dropdownData.dropdown_name
                                return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '', fieldType: tmpData.field_type, fieldName: tmpData.field_name, drpComponent: componentId, drpName: dropdownName }
                            } else {
                                return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '', fieldType: tmpData.field_type, fieldName: tmpData.field_name }
                            }
                        })
                        this.gridLangData = dynamicGrid
                        this.gridData = true
                        this.commonGrid = false
                        this.setGridData(dynamicGrid)
                    } else {
                        this.commonGrid = true
                        this.gridData = false
                    }
                } else {
                    this.commonGrid = true
                    this.gridData = false
                    this.setCommonGrid()
                }
            } else {
                this.commonGrid = true
                this.search = res.data
                this.gridData = false
            }
            this.loadData()
        },
        setGridData (data) {
            const newArray = data.map(item => {
                if ((this.local === 'en' && item.langType === 'en') || (this.local === 'en' && item.langType === '')) {
                return { label: item.text_en, class: 'text-left', key: item.value }
                } else if (this.local === 'bn' && item.langType === 'en' && item.fieldType === 'number') {
                return { label: item.text_bn, class: 'text-left', key: item.value }
                } else if ((this.local === 'bn' && item.langType === 'bn') || (this.local === 'bn' && item.langType === '') || (this.local === 'bn' && item.langType === 'en' && item.field_type === 'number')) {
                return { label: item.text_bn, class: 'text-left', key: item.value }
                }
            })
            this.columns = newArray
            this.setSlAction(1)
        },
        setCommonGrid () {
            this.columns = [
                { label: this.$t('globalTrans.org_name'), class: 'text-left', key: 'org_id' },
                { label: this.$t('service_name.service_name'), class: 'text-left', key: 'service_id' }
            ]
            this.setSlAction(2)
        },
        setSlAction (type) {
            this.columns = [
                { label: this.$t('globalTrans.sl_no'), class: 'text-left', key: 'index' },
                { label: this.$t('globalTrans.application_id'), class: 'text-left', key: 'application_id' }
                ].concat(this.columns)
            this.columns.push({ label: this.$t('globalTrans.type'), class: 'text-left', key: 'type' })
            this.columns.push({ label: this.$t('li_step.expire_date'), class: 'text-left', key: 'expire_date' })
            this.columns.push({ label: this.$t('globalTrans.status'), class: 'text-left', key: 'status' })
            this.columns.push({ label: this.$t('li_step.pay_status'), class: 'text-left', key: 'payment_status' })
            this.columns.push({ label: this.$t('globalTrans.action'), class: 'text-left', key: 'action' })
        },
        SetStep (item, status) {
            this.stepChange.application_id[0] = item.application_id
            this.stepChange.step_id = item.current_step
            this.stepChange.service_id = item.service_id
            this.stepChange.org_id = item.org_id
            this.stepChange.status = status
        },
        getStepName (stId) {
            const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
            return step !== undefined ? step.text : ''
        },
        ServiceLastStepCheck (serviceId, stepId, status) {
            const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
            const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(stepId))
            const order = tmpIndVStepList.order
            const orderCheck = tmpStepList.find(item => item.order === order + 1)
            if (status === 0) {
                return this.$t('globalTrans.pending')
            } else if (status === 2) {
                return this.$t('globalTrans.rejected')
            } else if (typeof orderCheck !== 'undefined') {
                return this.$t('globalTrans.pending')
            } else {
                return this.$t('globalTrans.completed')
            }
        },
        servicePayment (serId) {
            return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === parseInt(serId))
        },
        paymentStatus (data) {
            return data.payment.filter(item => item.step_id === data.current_step).length
        },
        expiredDateCheck (expiredDate) {
            if (expiredDate === null) {
                return false
            }
            const currentDate = this.currentDate()
            const noOfDay = this.getNumberOfDays(currentDate, expiredDate)
            if (noOfDay > 31) {
                return false
            } else {
                return true
            }
        },
        currentDate () {
            const current = new Date()
            const date = `${current.getFullYear()}-${current.getMonth() + 1}-${current.getDate()}`
            return date
        },
        getNumberOfDays (start, end) {
            const date1 = new Date(start)
            const date2 = new Date(end)

            // One day in milliseconds
            const oneDay = 1000 * 60 * 60 * 24

            // Calculating the time difference between two dates
            const diffInTime = date2.getTime() - date1.getTime()

            // Calculating the no. of days between two dates
            const diffInDays = Math.round(diffInTime / oneDay)
            return diffInDays
        },
        paymentCheck (serviceId, currentStep) {
            const steps = this.$store.state.LicenseRegistrationService.commonObj.stepFeeList.find(item => item.service_id === serviceId && item.step_id === currentStep && item.fee_id !== 0)
            const stepFee = typeof steps !== 'undefined' ? steps : { fee_id: '' }
            const otherPay = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => item.step_id === currentStep && item.service_id === serviceId)
            const otherFee = typeof otherPay !== 'undefined' ? otherPay : { checkbox_payment: false, field_payment: false }
            if (stepFee.fee_id || (otherFee.checkbox_payment.length > 1) || (otherFee.field_payment.length > 1)) {
                return true
            } else {
                return false
            }
        },
        setupReceipt (data) {
            this.payReceipt =
            {
                application_id: data.application_id,
                service_id: data.service_id
            }
        },
        setupPayment (data) {
            this.otherPayment =
            {
                org_id: data.org_id,
                application_id: data.application_id,
                step_id: data.current_step,
                service_id: data.service_id,
                application_type: data.type,
                expire_date: data.old_expire_date
            }
        },
        paymentData (data) {
        this.payment = Object.assign(this.payment,
        {
            org_id: data.org_id,
            application_id: data.application_id,
            step_id: data.current_step,
            service_id: data.service_id,
            application_type: data.type,
            expire_date: data.old_expire_date
        })
        },
        findRenewExpireDate (oldAppId) {
        let expireDate = ''
        if (oldAppId) {
            const app = this.$store.state.list.find(item => item.application_id === oldAppId)
            expireDate = (typeof app === 'undefined') ? '' : app.expire_date
        }
        return expireDate
        },
        async paymentStatusUpdate () {
            if (this.$route.params.status && this.$route.query.transId) {
                const status = this.$route.params.status
                const tranId = this.$route.query.transId
                this.$bvModal.show('modal-processing')
                await RestApi.getData(licenseRegistrationServiceBaseUrl, '/application/payment/' + status, { transId: tranId }).then(response => {
                this.$bvModal.hide('modal-processing')
                if (response.success) {
                    this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: response.message,
                    color: '#D6E09B'
                    })
                } else {
                    this.$toast.error({
                    title: 'Error',
                    message: response.message
                    })
                }
                })
                this.$router.push('/lrcpn/application')
                this.$store.dispatch('ExternalLrcpn/setLaodList', true)
            }
        }
    }
}
</script>
<style scope='css'>
  .dataList .btn {
    font-size: 11px !important;
    padding: 3px 8px !important;
  }
  .dataList .btn i {
      margin-right: 0px !important;
  }
  .dataList .pay-status {
    color: black !important;
    padding: 4px !important;
    margin: 2px !important;
    font-size: 10px !important;
  }
  .blink_me {
    animation: blinker 1.3s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      background-color: green;
    }
  }
</style>
