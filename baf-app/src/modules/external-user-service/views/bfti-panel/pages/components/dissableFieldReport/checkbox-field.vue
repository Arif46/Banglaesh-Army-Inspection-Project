<template>
    <b-col md="12" sm="12" lg="12">
        <b-form-group
            label-cols-sm="4"
            :label-for="data.field_name"
        >
            <template v-slot:label v-if="!reportView">
                {{ local === 'bn' ? data.label_bn : data.label }}
            </template>
            <p class="text-bold" style="font-weight: 600;" v-if="data.value"> <slot v-if="!reportView">:</slot>
                <!-- {{ data.value.toString() }} -->
                {{ checkBoxCheck(data.value.toString()) }}
                <!-- {{$t('globalTrans.yes')}} -->
            </p>
            <p class="text-bold" style="font-weight: 600;" v-else> : ..................</p>
        </b-form-group>
    </b-col>
</template>
<script>
export default {
    props: ['data', 'reportView'],
    components: {
    },
    data () {
        return {
        }
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    created () {
        this.listData = this.data.options.map(item => {
          if (this.$i18n.locale === 'bn') {
            const optionsData = { value: item.value, text: item.text_bn }
            return Object.assign({}, item, optionsData)
          } else {
            const optionsData = { value: item.value, text: item.text }
            return Object.assign({}, item, optionsData)
          }
        })
    },
    watch: {
        local: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.getoptions()
            }
        }
    },
    methods: {
        getoptions () {
            this.listData = this.data.options.map(item => {
                if (this.$i18n.locale === 'bn') {
                    const optionsData = { value: item.value, text: item.text_bn }
                    return Object.assign({}, item, optionsData)
                } else {
                    const optionsData = { value: item.value, text: item.text }
                    return Object.assign({}, item, optionsData)
                }
            })
        },
        checkBoxCheck (fieldVal) {
            const myArray = fieldVal.split(',')
            let valData = ''
            // let sl = 0
            myArray.map((item, index) => {
                const listData = this.listData.find(listData => listData.value === item)
                if (typeof listData !== 'undefined') {
                    if (this.$i18n.locale === 'bn') {
                        if (index === 0) {
                            valData = listData.text_bn
                        } else {
                            if (valData) {
                                valData = valData + ',' + listData.text_bn
                            } else {
                                valData = listData.text_bn
                            }
                        }
                    } else {
                        if (index === 0) {
                            valData = listData.text
                        } else {
                            if (valData) {
                                valData = valData + ',' + listData.text
                            } else {
                                valData = listData.text
                            }
                        }
                    }
                }
            })
            return valData
        }
    }
}
</script>
