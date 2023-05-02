<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 15%">{{$t('eBizConfig.council_name')}}</th>
                                <td style="width: 30%">: {{currentLocale === 'en'? items.council_name_en : items.council_name_bn}}</td>
                                <th style="width: 15%">{{$t('eBizConfig.address')}}</th>
                                <td style="width: 30%">: {{ currentLocale === 'en'? items.address_en : items.address_bn}} </td>
                            </tr>
                            <tr>
                                <th style="width: 15%">{{ $t('eBizConfig.mobile_no')}}</th>
                                <td style="width: 30%">: {{ $n(items.mobile_no, { useGrouping: false }) }}</td>
                                <th style="width: 15%">{{ $t('globalTrans.email')}}</th>
                                <td style="width: 30%">: {{ items.email_address }}</td>
                            </tr>
                            <tr>
                                <th style="width: 30%">{{$t('eBizConfig.contact_person_name')}}</th>
                                <td style="width: 40%" colspan="2">: {{currentLocale === 'en'? items.contact_person_name_en : items.contact_person_name_bn}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('eBizConfig.description')}}</th>
                                <td colspan="3" style="width: 30%">: {{ currentLocale === 'en'? items.description_en : items.description_bn}} </td>
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
    props: ['items'],
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
    }
}

</script>
