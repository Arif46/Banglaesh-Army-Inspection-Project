<template>
    <b-container fluid>
        <iq-card>
            <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('li_step.application_search') }}</h4>
            </template>
            <template v-slot:body>
                <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
                <b-form  @submit.prevent="handleSubmit(searchData)" >
                    <b-row>
                        <b-col lg="4" sm="4" md="4">
                            <ValidationProvider name="Application Id" vid="application_id">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="12"
                                    label-for="org_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('li_step.application_id') }}
                                    </template>
                                    <b-form-input
                                    plain
                                    v-model="search.application_id"
                                    id="application_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    </b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="4" sm="4" md="4">
                            <ValidationProvider name="From Date" vid="from_date" >
                            <b-form-group
                                class="row"
                                label-cols-sm="12"
                                label-for="from_date"
                                slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                {{ $t('globalTrans.from_date') }}
                                </template>
                                <b-form-input
                                plain
                                v-model="search.from_date"
                                id="from_date"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                </b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="4" sm="4" md="4">
                            <ValidationProvider name="To Date" vid="to_date" >
                            <b-form-group
                                class="row"
                                label-cols-sm="12"
                                label-for="to_date"
                                slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                {{ $t('globalTrans.to_date') }}
                                </template>
                                <b-form-input
                                plain
                                v-model="search.to_date"
                                id="to_date"
                                :state="errors[0] ? false : (valid ? true : null)"
                                >
                                </b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col class="text-right col-md-12">
                            <b-button type="submit" variant="primary">{{ $t('globalTrans.search')}}</b-button>
                        </b-col>
                    </b-row>
                </b-form>
                </ValidationObserver>
            </template>
        </iq-card>
        <b-row>
            <b-col md="12">
                <iq-card>
                    <template v-slot:headerTitle>
                        <h4 class="card-title">{{ $t('external_sidebar.application_list') }}</h4>
                    </template>
                    <template v-slot:body>
                        <b-row>
                            <b-col md="12" class="table-responsive">
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
                                <template v-slot:cell(status)>
                                    {{ $t('li_step.archived') }}
                                </template>
                                <template v-slot:cell(action)="data">
                                    <span @click="SetStep(data.item, 1)">
                                        <!-- Application View (Details) -->
                                        <router-link :to="{ name: 'app_detail', params: { stepChange }}" :title="$t('globalTrans.details')" :class="`btn btn-sm btn-info m-1`" size="sm"><i :class="`ri-eye-line`"></i></router-link>
                                    </span>
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
                    </template>
                </iq-card>
            </b-col>
        </b-row>
        <b-modal id="modal-1" size="xl" :title="$t('li_step.lab_assign')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <LabForm :stepId="stepId" :appDetails="appDetails"></LabForm>
        </b-modal>
    </b-container>
</template>

<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { archiveApplications } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'
import LabForm from './Form'
import flatpickr from 'flatpickr'

export default {
    mixins: [ModalBaseMasterList, common],
    components: {
        LabForm
    },
    data () {
        return {
        listLoading: false,
        stepChange: {
            application_id: [],
            step_id: 0,
            service_id: 0,
            org_id: 0,
            status: 1
        },
        search: {
            application_id: '',
            sample_number: ''
        },
        adminView: false,
        columns: [],
        appDetails: ''
        }
    },
    created () {
      this.service_id = this.$route.params.id
      this.setCommonGrid()
      this.loadData()
    },
    computed: {
        organizationList: function () {
            return this.$store.state.commonObj.organizationProfileList.filter(item => item.status === 0)
        },
        auth () {
            return this.$store.state.Auth
        },
        laodList () {
            return this.$store.state.licenseRegistration.commonObj.laodList
        },
        local: function () {
            return this.$i18n.locale
        }
    },
    mounted () {
        flatpickr('#from_date', {})
        flatpickr('#to_date', {})
    },
    watch: {
        laodList: function (n, o) {
        if (n !== o) {
            this.loadData()
        }
        }
    },
    methods: {
        searchData () {
            this.loadData()
        },
        loadData () {
            const params = Object.assign({}, this.search, {
                page: this.pagination.currentPage,
                per_page: this.pagination.perPage,
                service_id: this.search.service_id,
                office_id: this.$store.state.Auth.authUser.office_id
            })
            this.listLoading = true
            RestApi.getData(licenseRegistrationServiceBaseUrl, archiveApplications, params).then(response => {
                if (response.success) {
                this.$store.dispatch('setList', response.data.data)
                this.paginationData(response.data)
                }
                this.listLoading = false
            })
        },
        setCommonGrid () {
            this.columns = [
                { label: this.$t('globalTrans.sl_no'), class: 'text-left', key: 'index' },
                { label: this.$t('globalTrans.org_name'), class: 'text-left', key: 'org_id' },
                { label: this.$t('service_name.service_name'), class: 'text-left', key: 'service_id' },
                { label: this.$t('globalTrans.application_id'), class: 'text-left', key: 'application_id' },
                { label: this.$t('globalTrans.status'), class: 'text-left', key: 'status' }
            ].concat(this.columns)
            this.columns.push({ label: this.$t('globalTrans.action'), class: 'text-left', key: 'action' })
        },
        getStepName (stId) {
            const step = this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === stId)
            return step !== undefined ? step.text : ''
        },
        SetStep (item, status) {
            this.stepChange.application_id[0] = item.application_id
            this.stepChange.step_id = item.current_step
            this.stepChange.service_id = item.service_id
            this.stepChange.org_id = item.org_id
            this.stepChange.status = status
        },
        setApplication (item) {
            this.appDetails = item
        }
    }
  }
</script>
