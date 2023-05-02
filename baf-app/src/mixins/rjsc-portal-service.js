import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
  data () {
    return {
      divisionList: [],
      districtList: []
    }
  },
  computed: {
    hasAllDropdownLoaded () {
      return this.$store.state.RjscPortalService.commonObj.hasDropdownLoaded
    },
    fiscalYearList () {
      return this.$store.state.RjscPortalService.commonObj.fiscalYearList
    }
  },
  watch: {
    hasAllDropdownLoaded: function (newValue) {
      if (!newValue) {
        this.loadDivisionDistrcts()
      }
    },
    fiscalYearList (newValue) {
      this.setCurrentFiscalYear(newValue)
    }
  },
  created () {
    this.loadDivisionDistrcts()
    // this.loadCommonDropdown()
  },
  methods: {
    async loadDivisionDistrcts () {
      await RestApi.getData(commonServiceBaseUrl, 'rjsc-portal-common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('RjscPortalService/mutateCommonObj', {
            hasDropdownLoaded: true,
            divisionList: response.data.divisionList,
            districtList: response.data.districtList
          })
          this.$store.dispatch('RjscPortalService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    },
    fiscalYearBnAdd (data) {
      const bnList = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯']
      const bnAdded = data.map(item => {
        const fiscalYearData = {}
        const result = item.text_bn.split('').map(item => item === '-' ? '-' : bnList[item])
        fiscalYearData.text_bn = result.join('')
        return Object.assign({}, item, fiscalYearData)
      })
      return bnAdded
    },
    setCurrentFiscalYear (fiscalYearList) {
      if (fiscalYearList.length === 0) {
        return
      }
      const currentDate = new Date()
      const [month, year] = [currentDate.getMonth(), currentDate.getFullYear()]
      /** Define the year position  */
      const yearPosition = month < 7 ? 5 : 0
      const yearStr = `${year}`
      let currentFiscalYearId = 0
      fiscalYearList.forEach(element => {
        if (element.text_en.indexOf(yearStr) === yearPosition) {
          currentFiscalYearId = element.value
        }
      })
      this.$store.dispatch('setCurrentFiscalYearId', currentFiscalYearId)
    }
  }
}
