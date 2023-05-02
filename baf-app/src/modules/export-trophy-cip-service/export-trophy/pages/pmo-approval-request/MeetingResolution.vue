<template>
    <b-container fluid>
        <b-overlay :show="loading">
            <b-row>
                <b-col lg="12" md="12" sm="12">
                    <b-table-simple striped bordered small>
                        <b-thead>
                            <b-tr>
                                <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                <b-th>{{ $t('globalTrans.from') }}</b-th>
                                <b-th>{{ $t('globalTrans.remark') }}</b-th>
                                <b-th>{{ $t('globalTrans.attachment') }}</b-th>
                            </b-tr>
                        </b-thead>
                        <b-tbody>
                            <b-tr v-for="(remark, index) in remarks" :key="index">
                                <b-td>{{ $n(index+1) }}</b-td>
                                <b-td>{{ getMenuName(remark.menu_name_id) }}</b-td>
                                <b-td>{{ remark.remark }}</b-td>
                                <b-td>
                                    <a v-if="remark.attachment" :href="baseUrl + 'download-attachment?file=' + remark.attachment" class="btn-add mr-2">
                                        <i class="ri-download-cloud-line"></i>
                                    </a>
                                    <p v-else> N/A</p>
                                </b-td>
                            </b-tr>
                        </b-tbody>
                    </b-table-simple>
                </b-col>
            </b-row>
        </b-overlay>
    </b-container>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { meetingResolutionsListApi } from '../../api/routes'
export default {
    props: ['circular_id'],
    data () {
        return {
            baseUrl: exportTrophyCIPServiceBaseUrl,
            loading: false,
            remarks: []
        }
    },
    created () {
        this.getPreviousMeetingResolutions()
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        async getPreviousMeetingResolutions () {
            this.loading = true
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, `${meetingResolutionsListApi}/${this.circular_id}`)
            this.loading = false
            if (result.success) {
                this.remarks = result.data
            } else {
                this.remarks = []
            }
        },
        getMenuName (menuNameId) {
            if (menuNameId === 1) {
                return this.$t('exportTrophy.primary_sorting')
            } else if (menuNameId === 2) {
                return this.$t('cip.profile_scrutiny_evaluation')
            } else if (menuNameId === 3) {
                return this.$t('cip.moc_committee_approval')
            }
        }
    }
}
</script>
