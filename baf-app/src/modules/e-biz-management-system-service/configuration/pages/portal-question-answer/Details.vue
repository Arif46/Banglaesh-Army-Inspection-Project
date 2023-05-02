<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 13px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 5%">{{$t('globalTrans.name')}}</th>
                                <td style="width: 40%">: {{ items.name }}</td>
                                <th style="width: 5%">{{$t('globalTrans.email')}}</th>
                                <td style="width: 40%">: {{ items.email_address }} </td>
                            </tr>
                            <tr>
                                <th style="width: 15%">{{ $t('eBizConfig.contact_no')}}</th>
                                <td style="width: 30%">: {{ $n(items.mobile_no, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 30%">{{ $t('eBizConfig.question')}}</th>
                                <td style="width: 40%">: {{ items.question }}</td>
                            </tr>
                            <tr>
                                <th style="width: 30%">{{$t('eBizConfig.answer')}}</th>
                                <td style="width: 40%" colspan="2">: {{ currentLocale === 'en' ? items.answer_en : items.answer_bn }}</td>
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
