<template>
        <b-col md="12" sm="12" lg="12">
            <b-form-group
                label-cols-sm="4"
                :label-for="data.field_name"
            >
                <template v-slot:label>
                    {{ data.label }} <span v-if="data.help_text !== ''" class="ml-2" style="border:1px solid #66cc99;border-radius:50%;cursor:pointer" data-toggle="tooltip" data-placement="top" :title="data.help_text">?</span>
                </template>
            </b-form-group>
        </b-col>
</template>
<script>
export default {
    props: ['data'],
    data () {
        return {
        }
    }
}
</script>
