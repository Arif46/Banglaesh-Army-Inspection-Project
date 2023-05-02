<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="12">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('eBizConfig.project_name')}}</th>
                                <td style="width: 80%">: {{ currentLocale === 'en' ? itemList.project_name_en : itemList.project_name_bn}}</td>
                            </tr>
                            <tr>
                                 <th style="width: 20%">{{ $t('globalTrans.description')}}</th>
                                <td style="width: 80%">: {{ currentLocale === 'en' ? itemList.description_en : itemList.description_bn }}</td>
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
