import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
  data () {
    return {}
  },
  computed: {
    hasAllDropdownLoaded () {
      return this.$store.state.Portal.commonObj.hasDropdownLoaded
    },
    fiscalYearList () {
      return this.$store.state.Portal.commonObj.fiscalYearList
    }
  },
  watch: {
    hasAllDropdownLoaded: function (newValue) {
      if (!newValue) {
        this.loadCommonDropdown()
      }
    },
    fiscalYearList (newValue) {
      this.setCurrentFiscalYear(newValue)
    }
  },
  created () {
    this.loadCommonDropdown()
  },
  methods: {
    async loadCommonDropdown () {
      RestApi.getData(commonServiceBaseUrl, 'portal-common-dropdowns', null).then(response => {
        if (response.success) {
          const portalData = response.data
          this.$store.commit('Portal/mutateCommonDropdown', {
            hasDropdownLoaded: true,
            orgProfileList: portalData.orgProfileList,
            designationList: portalData.designationList,
            fiscalYearList: this.fiscalYearBnAdd(portalData.fiscalYearList),
            countryList: portalData.countryList,
            basicInfoList: portalData.basicInfoList
          })
          this.$store.dispatch('Portal/localizeCommonDropdown', { value: this.$i18n.locale })
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
