<template>
  <b-col md="12" sm="12" lg="12">
      <b-form-group
        label-cols-sm="4"
        :label-for="data.field_name"
      >
        <template v-slot:label v-if="!reportView">
          {{ $i18n.locale === 'bn' ? data.label_bn : data.label }}
        </template>
          <div v-if="data.value || data.value === 0">
            <div class="custom-data" v-if="data.dropdownData.component_id == 0">
              <span class="text-bold" style="font-weight: 600;"> <slot v-if="!reportView">:</slot> {{ getCustomData() }}</span>
            </div>
            <div v-else>
              <div class="custom-data" v-if="parseInt(data.dropdownData.component_id) === 1"><span class="text-bold" style="font-weight: 600;"> : {{ getCommonStoreDataUser(data.dropdownData.dropdown_name, data.value) }} </span></div>
              <div v-else><span class="text-bold" style="font-weight: 600;"> : {{ getStoreDataUserLrcpn(data.dropdownData.dropdown_name, data.value) }}</span></div>
            </div>
          </div>
          <p v-else class="text-bold" style="font-weight: 600;"> : ..................</p>
      </b-form-group>
  </b-col>
</template>
<script>
import CommonLrcpn from '@/mixins/common-lrcpn'
export default {
    mixins: [CommonLrcpn],
    props: ['data', 'reportView'],
    components: {
    },
    data () {
      return {
        drpList: []
      }
    },
    created () {
      if (this.data.dropdownData.component_id === 0) {
        this.data.value = this.data.dropdownData.selected_item
        const dropDowns = this.data.dropdownData.dropdown_options
        this.drpList = dropDowns.map((item, index) => {
          if (this.$i18n.locale === 'bn') {
            return { value: index, text: item.name }
          } else {
            return { value: index, text: item.name_bn }
          }
        })
      }
    },
    methods: {
      getStoreoptions (options) {
        return options.map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
        })
      },
      getCustomData () {
        const tmp = this.data.dropdownData.dropdown_options.find((item, index) => (index === parseInt(this.data.dropdownData.selected_item)))
        if (typeof tmp === 'undefined') {
          return ''
        } else {
          return this.$i18n.locale === 'bn' ? tmp.name_bn : tmp.name
        }
      }
    }
}
</script>
