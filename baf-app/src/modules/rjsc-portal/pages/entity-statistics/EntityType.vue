<template>
    <main id="entityType">
        <div class="entityType">
            <div class="box p-2">
                <b-overlay :show="loading">
                    <table class="fl-table">
                        <thead>
                            <tr>
                                <th> {{ $t('globalTrans.sl_no') }} </th>
                                <th>{{ $t('rjscAdminPortal.entity_type') }}</th>
                                <th>{{ $t('rjsc_portal.no_of_entity') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in data" :key="index">
                                <td>{{ $n(index + 1) }}</td>
                                <td>{{ ($i18n.locale === 'bn') ? item.name_bn : item.name_en }}</td>
                                <td>{{ $n(item.no_of_entity) }}</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr class="border border-secondary font-weight-bold">
                                <td colspan="2" class="text-left">{{ $t('globalTrans.total') + ' ' + $t('rjsc_portal.no_of_entity') }}</td>
                                <td>{{ $n(totalEntity) }}</td>
                            </tr>
                        </tfoot>
                    </table>
                </b-overlay>
            </div>
        </div>
    </main>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'entityType',
    data () {
        return {
            loading: false,
            data: [],
            totalEntity: 0
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        async loadData () {
            this.loading = true
            const params = Object.assign({}, { entity_type_id: 1 })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/entity', params)
            if (result.success) {
                this.data = result.data
                this.totalEntity = result.totalEntity
            } else {
                this.data = []
                this.totalEntity = 0
            }
            this.loading = false
        }
    }
}
</script>
<style scoped>
.fl-table thead th {
    background: var(--rjsc-brand);
}
</style>
