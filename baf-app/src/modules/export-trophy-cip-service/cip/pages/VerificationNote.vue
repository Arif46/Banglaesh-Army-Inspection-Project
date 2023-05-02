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
                                <b-th>{{ $t('globalTrans.note') }}</b-th>
                                <b-th>{{ $t('globalTrans.attachment') }}</b-th>
                            </b-tr>
                        </b-thead>
                        <b-tbody>
                            <b-tr v-for="(note, index) in notes" :key="index">
                                <b-td>{{ $n(index+1) }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? note.name_bn : note.name_en }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? note.office_namme_bn : note.office_namme_en }}</b-td>
                                <b-td>{{ currentLocale === 'bn' ? note.desgination_namme_bn : note.desgination_namme_en }}</b-td>
                                <b-td>{{ note.remark }}</b-td>
                                <b-td>
                                    <a v-if="note.attachment" class="btn btn-success btn-sm rounded-pill" target="_blank" :href="baseUrl + 'download-attachment?file=' + note.attachment" title="attachment"><i class="ri-download-cloud-fill"></i></a>
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
import { verficationNoteApi } from '../api/routes'
export default {
    props: ['id'],
    data () {
        return {
            baseUrl: exportTrophyCIPServiceBaseUrl,
            loading: false,
            notes: []
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
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, `${verficationNoteApi}/${this.id}`)
            this.loading = false
            if (result.success) {
                this.notes = this.getRelationalData(result.data, result.users)
            } else {
                this.notes = []
            }
        },
        getRelationalData (data, users) {
            const userList = users
            const officeList = this.$store.state.CommonService.commonObj.officeList
            const designationList = this.$store.state.CommonService.commonObj.assignDesignationList
            return data.map((item, index) => {
                const tmpUser = userList.find(user => user.value === item.user_id)
                const tmpOffice = officeList.find(office => office.value === tmpUser.office_id)
                const tmpDesgination = designationList.find(desg => desg.value === tmpUser.designation_id)
                const userData = {
                    serial: index,
                    name_en: typeof tmpUser !== 'undefined' ? tmpUser.text_en : '',
                    name_bn: typeof tmpUser !== 'undefined' ? tmpUser.text_bn : '',
                    office_namme_en: typeof tmpOffice !== 'undefined' ? tmpOffice.text_en : '',
                    office_namme_bn: typeof tmpOffice !== 'undefined' ? tmpOffice.text_bn : '',
                    desgination_namme_en: typeof tmpDesgination !== 'undefined' ? tmpDesgination.text_en : '',
                    desgination_namme_bn: typeof tmpDesgination !== 'undefined' ? tmpDesgination.text_bn : ''
                }
                return Object.assign({}, item, userData)
            })
        }
    }
}
</script>
