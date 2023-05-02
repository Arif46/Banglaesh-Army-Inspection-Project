<template>
    <div class="inner-section">
        <card>
            <!-- search section start -->
            <template v-slot:searchHeaderTitle>
                <h4 class="card-title">{{ $t('teaGardenConfig.plucking_target') }}</h4>
            </template>
            <template v-slot:searchBody>
                <b-row>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <b-form-group label-for="garden_id">
                            <template v-slot:label>
                                {{ $t('teaGardenConfig.tea_garden_name') }}
                            </template>
                            <b-form-select plain
                               v-model="search.garden_id"
                               :options="teaGardenGenInfoList"
                               id="garden_id">
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                            </b-form-select>
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
                <h4 class="card-title">{{ $t('teaGardenConfig.plucking_target_list') }} {{ $t('globalTrans.list') }}</h4>
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
                                    <template v-slot:cell(garden_id)="data">
                                        {{ getTeaGardenName(data.item.garden_id) }}
                                    </template>
                                    <template v-slot:cell(target)="data">
                                        {{ $n(data.item.target )}}
                                    </template>
                                    <template v-slot:cell(target_date)="data">
                                        {{ data.item.target_date | dateFormat }}
                                    </template>
                                    <template v-slot:cell(status)="data">
                                        <span class="badge badge-primary"
                                            v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                                        <span class="badge badge-success"
                                            v-else-if="data.item.status == 2">{{$t('globalTrans.inactive')}}</span>
                                        <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                                    </template>
                                    <template v-slot:cell(action)="data">
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
    </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { pluckingTargetListApi, pluckingTargetToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
    mixins: [ModalBaseMasterList],
    components: {
        Form
    },
    data () {
        return {
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            sortBy: '',
            editItemId: 0,
            sortDesc: true,
            sortDirection: 'desc',
            search: {
                garden_id: 0,
                limit: 20
            },
            labelData: [
                { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
                { labels: 'teaGardenConfig.tea_garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
                { labels: 'teaGardenConfig.target', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '12%' } },
                { labels: 'teaGardenConfig.target_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '13%' } },
                { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
                { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '10%' } }
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
                    { key: 'target' },
                    { key: 'target_date' },
                    { key: 'status' },
                    { key: 'action' }
                ]
            } else {
                keys = [
                    { key: 'serial' },
                    { key: 'garden_id' },
                    { key: 'target' },
                    { key: 'target_date' },
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
            return (this.editItemId === 0) ? this.$t('teaGardenConfig.target_entry') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.target_information') + ' ' + this.$t('globalTrans.modify')
        },
        teaGardenGenInfoList: function () {
            return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
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
            const result = await RestApi.getData(teaGardenServiceBaseUrl, pluckingTargetListApi, params)
            if (result.success) {
                const listData = result.data.data.map((item, index) => {
                    return Object.assign({}, item, { serial: index })
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
            this.changeStatus(3, teaGardenServiceBaseUrl, pluckingTargetToggleApi, item)
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
