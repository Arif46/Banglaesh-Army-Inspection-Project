<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 10%">{{ $t('eBizConfig.type_of_business')}}</th>
                                <td style="width: 35%">: {{ currentLocale === 'bn' ? itemList.type_of_business_bn : itemList.type_of_business_en }}</td>
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
