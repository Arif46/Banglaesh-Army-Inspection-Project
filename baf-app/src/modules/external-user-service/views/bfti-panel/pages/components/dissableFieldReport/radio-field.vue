<template>
    <b-col md="12" sm="12" lg="12">
            <b-form-group
                label-cols-sm="4"
                :label-for="data.field_name"
            >
                <template v-slot:label v-if="!reportView">
                    {{ local === 'bn' ? data.label_bn : data.label }}
                </template>
                <p class="text-bold" style="font-weight: 600;" v-if="data.value.length"> <slot v-if="!reportView">:</slot> {{ radioCheck(data.value.toString()) }}</p>
                <p class="text-bold" style="font-weight: 600;" v-else>: ..................</p>
            </b-form-group>
    </b-col>
</template>
<script>
export default {
    props: ['data', 'reportView'],
    components: {
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
    data () {
        return {
           listData: []
        }
    },
    methods: {
        radioCheck (fieldVal) {
            const listData = this.listData.find(listData => listData.value === fieldVal)
            if (typeof listData !== 'undefined') {
                if (this.$i18n.locale === 'bn') {
                    return listData.text_bn
                } else {
                    return listData.text_en
                }
            }
        }
    }
}
</script>
