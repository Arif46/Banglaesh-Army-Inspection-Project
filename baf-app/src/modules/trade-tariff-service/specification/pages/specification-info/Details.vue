<template>
    <div class="table-wrapper table-responsive">
         <h3 class="text-center capitalize" style="font-size:20px">TECHNICAL SPECIFICATION - {{ items.item_name.toUpperCase() }} <span v-if="items.quantity">({{ items.quantity }})</span></h3>
        <table class="table table-striped table-hover table-bordered">
            <b-thead>
            <tr>
                <b-th class="text-center">SL NO</b-th>
                <b-th class="text-center">Description</b-th>
                <b-th class="text-center">Specification Specified</b-th>
            </tr>
            </b-thead>
            <b-tbody>
            <template v-if="items.specifications.length">
                <template v-for="(item, index) in items.specifications">
                    <b-tr :key="index">
                        <b-td class="text-center">{{ index+1 }}</b-td>
                        <b-td class="text-left">{{ item.s_description }}</b-td>
                        <b-td class="text-left">{{ item.s_specified }}</b-td>
                    </b-tr>
                    <b-tr v-for="(childItem, childIndex) in item.childs" :key="childIndex">
                        <b-td v-if="childIndex === 0" class="text-center" :rowspan="item.childs.length"></b-td>
                        <b-td class="text-left">{{ (childIndex + 10).toString(36) }}) {{ childItem.s_description }}</b-td>
                        <b-td class="text-left">{{ childItem.s_specified }}</b-td>
                    </b-tr>
                    <b-tr v-if="item.has_blank_row" :key="'p-black-row-' + index">
                        <b-td colspan="4" class="text-center">{{ item.blank_row_text }}</b-td>
                    </b-tr>
                </template>
            </template>
            </b-tbody>
        </table>
    </div>
</template>
<script>
export default {
    props: ['item'],
    components: {},
    data () {
        return {
        }
    },
    created () {
        this.items = this.item
    },
    methods: {
    }
}
</script>
<style scoped>
    .header {
        font-size: 17px;
    }
    .Personal {
        font-size: 25px;
    }
    .break {
        flex-basis: 100%;
        height: 0;
    }
</style>
