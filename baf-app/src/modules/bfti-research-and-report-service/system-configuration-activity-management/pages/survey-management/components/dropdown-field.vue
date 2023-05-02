<template>
  <b-col md="12" sm="12" lg="12">
      <b-form-group
        label-cols-sm="12"
        :label-for="data.field_name"
      >
        <template v-slot:label>
           {{ local === 'bn' ? data.label_bn : data.label }} <span class="text-danger" v-if="data.isRequired">*</span><span v-if="data.help_text !== ''" class="ml-2" style="border:1px solid #66cc99;border-radius:50%;cursor:pointer" data-toggle="tooltip" data-placement="top" :title="data.help_text">?</span>
        </template>
        <b-form-select
          plain
          v-model="data.value"
          :id="data.field_name"
          :options="drpList[data.field_name]"
        >
          <template v-slot:first>
            <b-form-select-option value="" >{{$t('globalTrans.select')}}</b-form-select-option>
          </template>
        </b-form-select>
      </b-form-group>
  </b-col>
</template>
<script>
export default {
  props: ['data'],
  data () {
    return {
      drpList: []
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
        this.getoptions()
      }
    }
  },
  created () {
    if (this.data.dropdownData.component_id === '0') {
      const dropDowns = this.data.dropdownData.dropdown_options
      this.drpList[this.data.field_name] = dropDowns.map((item, index) => {
        if (this.local === 'bn') {
          const optionsData = { value: index, text: item.name_bn }
          return Object.assign({}, item, optionsData)
        } else {
          const optionsData = { value: index, text: item.name }
          return Object.assign({}, item, optionsData)
        }
      })
    }
  },
  methods: {
    getoptions () {
      if (this.data.dropdownData.component_id === '0') {
        const dropDowns = this.data.dropdownData.dropdown_options
        this.drpList[this.data.field_name] = dropDowns.map((item, index) => {
          if (this.local === 'bn') {
            const optionsData = { value: index, text: item.name_bn }
            return Object.assign({}, item, optionsData)
          } else {
            const optionsData = { value: index, text: item.name }
            return Object.assign({}, item, optionsData)
          }
        })
      }
    }
  }
}
</script>
