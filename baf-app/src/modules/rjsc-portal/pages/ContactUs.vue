<template>
    <b-overlay :show="loading">
        <main id="contactUs">
            <div class="contact-us-page">
                <div class="box p-2">
                    <!-- {{ data }} -->
                    <strong class="py-2">{{ $t('rjsc_portal.rjsc_office') }}</strong>
                    <p class="mb-2"> {{ $t('rjsc_portal.first_title') }} </p>
                    <div class="office" v-for="(item, index) in data" :key="index">
                        <address>
                            <h6>{{ ($i18n.locale === 'bn') ? item.name_bn : item.name_en }}</h6>
                            <span>
                                {{ ($i18n.locale === 'bn') ? item.address_bn : item.address_en }}
                                <ul>
                                    <li>{{ $t('globalTrans.telephone') }}: {{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(item.telephone, { useGrouping: false }) }}</li>
                                    <li>{{ $t('globalTrans.fax') }}: {{ $n(item.fax, { useGrouping: false }) }}</li>
                                </ul>
                                <a href="mailto: rjsc@roc.gov.bd"> {{ $t('globalTrans.email') }}: {{ item.email }}</a>
                            </span>
                        </address>
                    </div>
                    <p>  {{ $t('rjsc_portal.second_title') }} </p>
                    <strong class="py-2">  {{ $t('rjsc_portal.admin_dis_cover') }} </strong>
                    <p></p>
                    <div class="table-wrapper">
                        <table class="fl-table">
                            <thead>
                                <tr>
                                    <template v-for="(item, index) in data">
                                        <th :key="index"> {{ ($i18n.locale === 'bn') ? item.name_bn : item.name_en }} </th>
                                    </template>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(districtArr, index) in rows" :key="index">
                                    <td :key="ind" v-for="(item, ind) in districtArr">{{ getDistrictName(item) }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'contactUs',
    data () {
        return {
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            data: [],
            districtList: [],
            rows: []
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        async loadData () {
            this.loading = true
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/office-list')
            if (result.success) {
                this.data = result.data.data
                this.rows = result.data.rows
            } else {
                this.data = []
            }
            this.loading = false
        },
        getRelationalObject (data) {
            const districts = this.$store.state.RjscPortalService.commonObj.districtList
            return data.map(item => {
                var districtList = []
                return JSON.parse(item.districts).map(item1 => {
                    const district = districts.find(el => el.value === parseInt(item1))
                    const distObj = { district_name_en: typeof district !== 'undefined' ? district.text_en : '', district_name_bn: typeof district !== 'undefined' ? district.text_bn : '' }
                    districtList = [...districtList, distObj]
                })
            })
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
<style>
.contact-us-page .office {
    display: flex;
    justify-content: space-between;
}

.contact-us-page .office address {
    padding: 0.5rem;
    border-radius: 5px;
    width: 100%;
    background: #fff;
    border: 1px solid #ddd;
    margin: 0 1rem 1rem 0;
}
.contact-us-page .office address:last-child {
    margin-right: 0;
}

.contact-us-page .office address a {
    color: black;
}
</style>
