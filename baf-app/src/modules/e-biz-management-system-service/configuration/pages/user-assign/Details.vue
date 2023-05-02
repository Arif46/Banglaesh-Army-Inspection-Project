<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 15%">{{$t('eBizConfig.council_name')}}</th>
                                <td style="width: 30%">: {{ getCouncilName(items.council_info_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 15%">{{$t('globalTrans.user')}}</th>
                                <td style="width: 30%">: {{ getUserName(items.user_id) }}</td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
export default {
    props: ['items', 'users'],
    components: {
    },
    created () {
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        getUserName (userId) {
            const user = this.users.find(user => parseInt(user.value) === parseInt(userId))
            return typeof user !== 'undefined' ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
        },
        getCouncilName (councilNameId) {
                const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
                if (cateObj !== undefined) {
                    if (this.$i18n.locale === 'bn') {
                        return cateObj.text_bn
                    } else {
                        return cateObj.text_en
                    }
                }
        }
    }
}

</script>
