<template>
    <main id="entityDistrict">
        <div class="district-wrapper">
            <div class="box p-2">
                <b-overlay :show="loading">
                    <table class="fl-table">
                        <thead>
                            <tr>
                                <th> {{ $t('globalTrans.sl_no') }} </th>
                                <th> {{ $t('globalTrans.district') }} </th>
                                <th> {{ $t('rjsc_portal.no_of_entity') }} </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in data" :key="index">
                                <td>{{ $n(index + 1) }}</td>
                                <td>{{ getDistrictName(item.district_id) }}</td>
                                <td>{{ $n(item.no_of_entity) }}</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr class="border border-secondary font-weight-bold">
                                <td colspan="2" class="text-left"> {{ $t('globalTrans.total') + ' ' + $t('rjsc_portal.no_of_entity') }} </td>
                                <td> {{ $n(totalEntity) }} </td>
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
    name: 'entityDistrict',
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
            const params = Object.assign({}, { district_id: 1 })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/entity', params)
            if (result.success) {
                this.data = result.data
                this.totalEntity = result.totalEntity
            } else {
                this.data = []
                this.totalEntity = 0
            }
            this.loading = false
        },
        getDistrictName (id) {
            if (id) {
                const obj = this.$store.state.RjscPortalService.commonObj.districtList.find(item => item.value === id)
                if (this.$i18n.locale === 'bn') {
                    return obj.text_bn
                } else {
                    return obj.text_en
                }
            }
        }
    }
}
</script>
<style scoped>
.fl-table thead th {
    background: var(--info);
}
</style>
