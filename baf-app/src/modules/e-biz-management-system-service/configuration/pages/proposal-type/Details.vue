<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 30%">{{ $t('eBizConfig.proposal_type_name')}}</th>
                                <td style="width: 25%">: {{ currentLocale === 'en' ? itemList.proposal_type_name_en : itemList.proposal_type_name_bn }}</td>
                            </tr>
                            <tr>
                                <th style="width: 30%">{{ $t('eBizConfig.description')}}</th>
                                <td style="width:70%">: {{ currentLocale === 'en' ? itemList.description_en : itemList.description_bn }}</td>
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
      this.itemList = this.items
    },
    data () {
        return {
            itemList: {}
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
