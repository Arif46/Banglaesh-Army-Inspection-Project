<template>
    <b-container fluid>
        <b-overlay :show="loading">
            <b-row>
                <b-col lg="12" md="12" sm="12">
                    <b-table-simple striped bordered small>
                        <b-thead>
                            <b-tr>
                                <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                <b-th>{{ $t('globalTrans.name') }}</b-th>
                                <b-th>{{ $t('globalTrans.office') }}</b-th>
                                <b-th>{{ $t('globalTrans.designation') }}</b-th>
                                <b-th>{{ $t('globalTrans.comments') }}</b-th>
                            </b-tr>
                        </b-thead>
                        <b-tbody>
                            <b-tr v-for="(comment, index) in comments" :key="index">
                                <b-td>{{ $n(index+1) }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? comment.name_bn : comment.name_en }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? comment.office_namme_bn : comment.office_namme_en }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? comment.desgination_namme_bn : comment.desgination_namme_en }}</b-td>
                                <b-td>{{ comment.note }}</b-td>
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
import { profileVerificationCommentsApi } from '../../api/routes'
export default {
    props: ['id'],
    data () {
        return {
            loading: false,
            comments: []
        }
    },
    created () {
        this.getForwardComments()
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        async getForwardComments () {
            this.loading = true
            // this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, `${profileVerificationCommentsApi}/${this.id}`)
            this.loading = false
            if (result.success) {
                this.comments = this.getRelationalData(result.data, result.users)
            } else {
                this.comments = []
            }
            // this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        },
        getRelationalData (data, users) {
            const userList = users
            const officeList = this.$store.state.CommonService.commonObj.officeList
            const designationList = this.$store.state.CommonService.commonObj.assignDesignationList
            return data.map((item, index) => {
                const tmpUser = userList.find(user => user.value === item.sender_id)
                const tmpOffice = officeList.find(office => office.value === tmpUser.office_id)
                const tmpDesgination = designationList.find(desg => desg.value === tmpUser.designation_id)
                const userData = {
                    serial: index,
                    name_en: tmpUser.text_en,
                    name_bn: tmpUser.text_bn,
                    office_namme_en: tmpOffice.text_en,
                    office_namme_bn: tmpOffice.text_bn,
                    desgination_namme_en: tmpDesgination.text_en,
                    desgination_namme_bn: tmpDesgination.text_bn
                }
                return Object.assign({}, item, userData)
            })
        }
    }
}
</script>
