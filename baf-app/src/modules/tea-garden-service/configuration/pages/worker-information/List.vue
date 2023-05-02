<template>
    <div class="inner-section">
        <card>
            <!-- search section start -->
            <template v-slot:searchHeaderTitle>
                <h4 class="card-title">{{ $t('teaGardenConfig.worker_information') }}</h4>
            </template>
            <template v-slot:searchBody>
                <b-row>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <b-form-group label-for="worker_type">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.worker_type') }}
                            </template>
                            <b-form-select plain
                                v-model="search.worker_type"
                                :options="customWorkerTypeList"
                                id="worker_type"
                            >
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                            </b-form-select>
                        </b-form-group>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <b-form-group label-for="mobile">
                            <template v-slot:label>
                                {{  $t('teaGardenConfig.mobile') }}
                            </template>
                            <b-form-input id="mobile"
                            v-model="search.mobile"
                            ></b-form-input>
                        </b-form-group>
                    </b-col>
                    <b-col sm="4">
                        <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
                            <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                        </b-button>
                    </b-col>
                </b-row>
            </template>
            <!-- search section end -->
        </card>

        <body-card>
            <!-- table section start -->
            <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('teaGardenConfig.worker_list') }} {{ $t('globalTrans.list') }}</h4>
            </template>
            <template v-slot:headerAction>
                <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i>
                    {{ $t('globalTrans.add_new') }}</a>
            </template>
            <template v-slot:body>
                <b-overlay :show="loadingState">
                    <select-column-check :labelData="labelData" :search="search" :columns="columns" />
                    <b-row>
                        <b-col md="12" class="table-responsive">
                            <slot v-if="columns.filter(item => item.show === '1').length > 0">
                                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc"
                                    :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData"
                                    :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover
                                    :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                                    <template v-slot:cell(serial)="data">
                                        {{ $n(data.item.serial + pagination.slOffset) }}
                                    </template>
                                    <template v-slot:cell(mobile)="data">
                                        {{ EngBangNum(data.item.mobile) }}
                                    </template>
                                    <template v-slot:cell(garden_id)="data">
                                        {{ getTeaGardenName(data.item.garden_id) }}
                                    </template>
                                    <template v-slot:cell(designation_id)="data">
                                        {{ getDesignation(data.item.designation_id) }}
                                    </template>
                                    <template v-slot:cell(pf_id)="data">
                                        {{ EngBangNum(data.item.pf_id) }}
                                    </template>
                                    <template v-slot:cell(nid)="data">
                                        {{ EngBangNum(data.item.nid) }}
                                    </template>
                                    <template v-slot:cell(status)="data">
                                        <span class="badge badge-primary"
                                            v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                                        <span class="badge badge-success"
                                            v-else-if="data.item.status == 2">{{$t('globalTrans.inactive')}}</span>
                                        <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                                    </template>
                                    <template v-slot:cell(action)="data">
                                        <b-button class="moc-action-btn moc-view-btn" v-b-modal.modal-form-details @click="details(data.item)" :title="$t('globalTrans.view')">
                                            <i class="ri-eye-line"></i>
                                        </b-button>
                                        <b-button class="moc-action-btn moc-edit-btn" v-b-modal.modal-form @click="edit(data.item)" :title="$t('globalTrans.edit')">
                                            <i class="ri-pencil-fill"></i>
                                        </b-button>
                                        <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="remove(data.item)">
                                             <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
                                         </b-button>
                                    </template>
                                </b-table>
                            </slot>
                            <div class="pagination-wrapper mt-3"
                                v-if="columns.filter(item => item.show === '1').length > 0">
                                <b-pagination v-model="pagination.currentPage" :perPage="search.limit"
                                    :total-rows="pagination.totalRows" @input="searchData" />
                            </div>
                        </b-col>
                    </b-row>
                </b-overlay>
            </template>
            <!-- search section end -->
        </body-card>
        <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only
            ok-variant="danger">
            <Form :id="editItemId" :key="editItemId" />
        </b-modal>
        <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')"
            ok-only ok-variant="danger">
            <Details :id="editItemId" :key="editItemId" ref="details" />
        </b-modal>
    </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { workerinformationListApi, workerinformationToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
    mixins: [ModalBaseMasterList],
    components: {
        Form, Details
    },
    data () {
        return {
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            sortBy: '',
            editItemId: 0,
            sortDesc: true,
            sortDirection: 'desc',
            search: {
                worker_type: 0,
                mobile: '',
                limit: 20
            },
            labelData: [
                { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
                { labels: 'teaGardenConfig.garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
                { labels: 'teaGardenConfig.pf_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '8%' } },
                { labels: 'teaGardenConfig.worker_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: 'auto' } },
                { labels: 'teaGardenConfig.father_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: 'auto' } },
                { labels: 'teaGardenConfig.worker_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '12%' } },
                { labels: 'teaGardenConfig.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '8%' } },
                { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '8%' } },
                { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 9, thStyle: { width: '12%' } }
            ],
            actions: {
                edit: true,
                toogle: true,
                details: true,
                delete: false
            }
        }
    },
    created () {
        this.loadData()
    },
    watch: {
        'search.limit': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.loadData()
            }
        }
    },
    computed: {
        columns () {
            const labelData = this.labelData
            const labels = labelData.map((item, index) => {
                return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
            })
            let keys = []
            if (this.$i18n.locale === 'bn') {
                keys = [
                    { key: 'serial' },
                    { key: 'garden_id' },
                    { key: 'pf_id' },
                    { key: 'worker_name_bn' },
                    { key: 'father_name_bn' },
                    { key: 'worker_type_bn' },
                    { key: 'mobile' },
                    { key: 'status' },
                    { key: 'action' }
                ]
            } else {
                keys = [
                    { key: 'serial' },
                    { key: 'garden_id' },
                    { key: 'pf_id' },
                    { key: 'worker_name_en' },
                    { key: 'father_name_en' },
                    { key: 'worker_type_en' },
                    { key: 'mobile' },
                    { key: 'status' },
                    { key: 'action' }
                ]
            }
            return labels.map((item, index) => {
                return Object.assign(item, keys[index])
            })
        },
        currentLocale () {
            return this.$i18n.locale
        },
        formTitle () {
            return (this.editItemId === 0) ? this.$t('teaGardenConfig.worker_entry') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.worker_information') + ' ' + this.$t('globalTrans.modify')
        },
        detailsTitle () {
            return this.$t('teaGardenConfig.worker_details') + ' ' + this.$t('globalTrans.details')
        },
        designationList: function () {
            return this.$store.state.TeaGardenService.commonObj.designationList.filter(item => item.status === 1)
        },
        customWorkerTypeList: function () {
            return this.$store.state.TeaGardenService.commonObj.workerType
        }
    },
    methods: {
        searchData () {
            this.loadData()
        },
        EngBangNum (n) {
            if (this.$i18n.locale === 'bn') {
                return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
            } else {
                return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
            }
        },
        edit (item) {
            this.editItemId = item.id
        },
        async loadData () {
            const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
            this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
            const result = await RestApi.getData(teaGardenServiceBaseUrl, workerinformationListApi, params)
            if (result.success) {
                const listData = result.data.data.map((item, index) => {
                    const orgObj = this.$store.state.TeaGardenService.commonObj.masterDesignationList.find(law => law.value === parseInt(item.designation_id))
                    const workerType = this.$store.state.TeaGardenService.commonObj.workerType.find(el => el.value === parseInt(item.worker_type))
                    const tmpData = {
                        designation_en: typeof orgObj !== 'undefined' ? orgObj.text_en : '',
                        designation_bn: typeof orgObj !== 'undefined' ? orgObj.text_bn : '',
                        worker_type_en: typeof workerType !== 'undefined' ? workerType.text_en : '',
                        worker_type_bn: typeof workerType !== 'undefined' ? workerType.text_bn : ''
                    }
                    return Object.assign({}, item, { serial: index }, tmpData)
                })
                this.$store.dispatch('setList', listData)
                this.paginationData(result.data, this.search.limit)
            } else {
                this.$store.dispatch('setList', [])
                this.paginationData([])
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        },
        remove (item) {
            this.changeStatus(3, teaGardenServiceBaseUrl, workerinformationToggleApi, item)
        },
        getDesignation (id) {
            const designation = this.$store.state.TeaGardenService.commonObj.masterDesignationList.find(item => item.value === id)
            if (designation && this.$i18n.locale === 'bn') {
                return designation.text_bn
            } else if (designation && this.$i18n.locale === 'en') {
                return designation.text_en
            }
        },
        details (item) {
            this.editItemId = item.id
        },
        getTeaGardenName (id) {
        const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            if (gardenInfo && this.$i18n.locale === 'bn') {
                return gardenInfo.text_bn
            } else if (gardenInfo && this.$i18n.locale === 'en') {
                return gardenInfo.text_en
            }
        }
    }
}
</script>
