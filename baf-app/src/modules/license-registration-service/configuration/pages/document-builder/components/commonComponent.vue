<template>
    <b-row>
        <b-col md="12" lg="12" sm="12" :class="pageData[0].align">
            <span v-for="(item, index) in pageData" :key="index">
                <p v-if="item.type === 'Empty'"></p>
                <span class="text-left" v-if="item.type === 'Paragraph' || item.type === 'InputField' || item.type === 'Date' || item.type === 'DocumentID' || item.type === 'FirstIssueDate'" :style="{ color: item.color, 'font-weight': getFontWeight(item)}">{{ item.value }}</span>
                    <h1 v-if="item.field_type === 'h1'" :style="{ color: item.color}">{{ item.value }}</h1>
                    <h2 v-if="item.field_type === 'h2'" :style="{ color: item.color}">{{ item.value }}</h2>
                    <h3 v-if="item.field_type === 'h3'" :style="{ color: item.color}">{{ item.value }}</h3>
                    <h4 v-if="item.field_type === 'h4'" :style="{ color: item.color}">{{ item.value }}</h4>
                    <h5 v-if="item.field_type === 'h5'" :style="{ color: item.color}">{{ item.value }}</h5>
                    <h6 v-if="item.field_type === 'h6'" :style="{ color: item.color}">{{ item.value }}</h6>
                    <table class="table table-bordered" v-if="item.type === 'Table'">
                        <tr v-for="(col, index) in pageData[0].column" :key="index">
                            <td>{{ col.label }}</td>
                            <td></td>
                        </tr>
                    </table>
                    <span v-if="item.type === 'QR'">{{ $t('component_settings.qr_code') }}</span>
                    <img :src="item.value" style="max-width: 100%;text-align: center;" v-if="item.type === 'Attachment'">
            </span>
        </b-col>
    </b-row>
</template>
<script>
export default {
    props: ['Sdata'],
    data () {
        return {
            pageData: ''
        }
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    watch: {
        local: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.getLanguateWisedata()
            }
        }
    },
    created () {
        if (this.Sdata) {
            this.pageData = this.Sdata
            return this.pageData.map(sitem => {
                if (sitem.type === 'InputField') {
                    sitem.value = '................'
                } else if (sitem.type === 'DocumentID') {
                    sitem.value = '.................'
                } else if (sitem.type === 'FirstIssueDate') {
                    sitem.value = '.................'
                } else if (sitem.type === 'Date' && sitem.field_type === 'dynamic') {
                    sitem.value = '.................'
                } else if (sitem.type === 'Attachment') {
                    const val = sitem.value
                    sitem.value = val
                } else if (sitem.type === 'QR') {
                    const val = sitem.value
                    sitem.value = val
                } else {
                    if (this.$i18n.locale === 'bn') {
                        sitem.value = sitem.value_bn
                    } else {
                        sitem.value = sitem.value_en
                    }
                }
            })
        }
    },
    methods: {
        getFontWeight (item) {
            if (item.is_bold === true) {
                return 'bold'
            } else {
                return 'normal'
            }
        },
        getLanguateWisedata () {
            return this.pageData.map(sitem => {
                if (sitem.type === 'InputField') {
                    sitem.value = '................'
                } else if (sitem.type === 'DocumentID') {
                    sitem.value = '.................'
                } else if (sitem.type === 'FirstIssueDate') {
                    sitem.value = '.................'
                } else if (sitem.type === 'Date' && sitem.field_type === 'dynamic') {
                    sitem.value = '.................'
                } else if (sitem.type === 'Attachment') {
                    const val = sitem.value
                    sitem.value = val
                } else if (sitem.type === 'QR') {
                    const val = sitem.value
                    sitem.value = val
                } else {
                    if (this.$i18n.locale === 'bn') {
                        sitem.value = sitem.value_bn
                    } else if (this.$i18n.locale === 'en') {
                        sitem.value = sitem.value_en
                    }
                }
            })
        }
    }
}
</script>
<style scoped>
    .center {
        display: block !important;
        margin: auto !important;
        text-align: center !important;
        position: absolute !important;
    }
    .left {
        display: block !important;
        margin: auto !important;
        text-align: left !important;
        position: absolute !important;
    }
    .right {
        display: block !important;
        margin: auto !important;
        text-align: right !important;
        position: absolute !important;
    }
</style>
