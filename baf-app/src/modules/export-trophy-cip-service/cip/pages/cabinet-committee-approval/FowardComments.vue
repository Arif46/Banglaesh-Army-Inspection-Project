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
                            <b-tr v-for="(comment, index) in forwards" :key="index">
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
export default {
    props: ['forwards'],
    data () {
        return {
            loading: false,
            comments: []
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    }
}
</script>
