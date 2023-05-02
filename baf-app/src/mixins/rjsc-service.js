import RestApi, { rjscServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'

export default {
  data () {
    return {
      divisionList: [],
      districtList: [],
      officeTypeList: [],
      officeList: []
    }
  },
  computed: {
    hasDropdownLoadedRjscService () {
      return this.$store.state.RjscService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedRjscService: function (newValue) {
      if (!newValue) {
        this.loadDivisionDistrcts()
        // this.loadRjscDropdown()
      }
    }
  },
  created () {
    this.loadDivisionDistrcts()
    // this.loadRjscDropdown()
  },
  methods: {
    async loadDivisionDistrcts () {
      await RestApi.getData(commonServiceBaseUrl, 'rjsc-portal-common-dropdowns', null).then(response => {
        if (response.success) {
          this.divisionList = response.data.divisionList
          this.districtList = response.data.districtList
          this.officeTypeList = response.data.officeTypeList
          this.officeList = response.data.officeList
        }
        this.loadRjscDropdown()
      })
    },
    async loadRjscDropdown () {
      await RestApi.getData(rjscServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('RjscService/mutateCommonObj', {
            hasDropdownLoaded: true,
            menuList: response.data.menuList,
            entitySectorList: response.data.entitySectorList,
            businessTypeList: response.data.businessTypeList,
            entityTypeList: response.data.entityTypeList,
            divisionList: this.divisionList,
            districtList: this.districtList,
            officeTypeList: this.officeTypeList,
            officeList: this.officeList
          })
          this.$store.dispatch('RjscService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
