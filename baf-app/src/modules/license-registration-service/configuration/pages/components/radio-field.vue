<template>
        <b-col md="12" sm="12" lg="12">
            <b-form-group
                label-cols-sm="4"
                :label-for="data.field_name"
            >
                <template v-slot:label>
                    {{ local === 'bn' ? data.label_bn : data.label }} <span class="text-danger" v-if="data.isRequired === true">*</span><span v-if="data.help_text !== ''" class="ml-2" style="border:1px solid #66cc99;border-radius:50%;cursor:pointer" data-toggle="tooltip" data-placement="top" :title="data.help_text">?</span>
                </template>
                <b-form-radio-group v-if="data.is_multiple"
                    :id="data.field_name"
                    v-model="data.value"
                    :options="listData"
                ></b-form-radio-group>
                <b-form-radio v-else
                    :id="data.field_name"
                    v-model="data.value"
                    :options="listData"
                ></b-form-radio>
            </b-form-group>
        </b-col>
</template>
<script>
export default {
    props: ['data'],
    data () {
        return {
           listData: []
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
        }
    }
}
</script>
