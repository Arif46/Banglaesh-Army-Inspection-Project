import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      mixinComponentId: 0
    }
  },
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.CommonService.commonObj.hasDropdownLoaded
    },
    ...mapGetters({
      commonObj: 'CommonService/commonObj',
      authUser: 'Auth/authUser',
      activeRoleId: 'Auth/getActiveRole'
    }),
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList
    }
  },
  watch: {
    hasDropdownLoadedCommonService: function (newValue) {
      if (!newValue) {
        this.loadCommonServiceDropdown()
      }
    },
    fiscalYearList (newValue) {
      this.setCurrentFiscalYear(newValue)
    }
  },
  created () {
    const hasDropdownLoadedCommonService = this.$store.state.CommonService.commonObj.hasDropdownLoaded
    if (!hasDropdownLoadedCommonService || window.performance) {
      this.loadCommonServiceDropdown()
      this.setOrgDesignationList()
    }
  },
  methods: {
    setOrgDesignationList () {
      if (!this.mixinComponentId) {
        return
      }
      RestApi.getData(commonServiceBaseUrl, `organogram/component-designaiton/comp-designations/${this.mixinComponentId}`)
      .then(response => {
        if (response.success) {
          let newDesignationList = []
          const desigList = response.data
          if (desigList.length > 0) {
            const orgDesigList = desigList.map(item => {
              const desigObj = this.commonObj.designationList.find(desig => desig.value === item.designation_id)
              return Object.assign({}, desigObj, { text: this.$i18n.locale === 'en' ? desigObj.text_en : desigObj.text_bn })
            })
            newDesignationList = this.getDesignationByUserType(orgDesigList)
          }
          this.$store.commit('CommonService/mutateCommonObj', { componentDesignationList: newDesignationList })
        }
      })
    },
    mixinSetComponentOrgList () {
      const orgComponents = this.getOrgAdminData()
      const orgCompList = orgComponents.map(item => {
        const orgObj = this.commonObj.orgProfileList.find(org => org.value === item.org_id)
        return Object.assign({}, orgObj, { text: this.$i18n.locale === 'en' ? orgObj.text_en : orgObj.text_bn })
      })

      this.$store.commit('CommonService/mutateCommonObj', { componentOrgList: this.getOrgByUserType(orgCompList) })
    },
    loadCommonServiceDropdown () {
      RestApi.getData(commonServiceBaseUrl, 'common-dropdowns-external', null).then(response => {
        if (response.success) {
          this.$store.dispatch('CommonService/mutateCommonObj', {
            hasDropdownLoaded: true,
            componentList: response.data.componentList,
            orgComponentList: response.data.orgComponentList,
            divisionList: response.data.divisionList,
            districtList: response.data.districtList,
            upazilaList: response.data.upazilaList,
            serviceList: response.data.serviceList,
            unionList: response.data.unionList,
            cityCorporationList: response.data.cityCorporationList,
            orgProfileList: response.data.orgProfileList,
            municipalityList: response.data.municipalityList,
            fiscalYearList: this.fiscalYearBnAdd(response.data.fiscalYearList),
            wardList: response.data.wardList,
            designationList: response.data.designationList,
            officeTypeList: response.data.officeTypeList,
            officeList: response.data.officeList,
            countryList: response.data.countryList,
            bankNameList: response.data.bankNameList,
            branchNameList: response.data.branchNameList
          })
          this.$store.dispatch('CommonService/localizeDropdownExternal', { value: this.$i18n.locale })
          this.mixinSetComponentOrgList()
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
    },
    getOrgAdminData () {
      // if (this.authUser.org_admin) {
      //   return this.commonObj.orgComponentList.filter(item => (item.component_id === this.mixinComponentId) && (item.org_id === this.authUser.org_id))
      // }
      return this.commonObj.orgComponentList.filter(item => item.component_id === this.mixinComponentId)
    },
    getOrgByUserType (orgProfileList) {
      return orgProfileList
      // if (this.activeRoleId === 1) {
      //   return orgProfileList
      // }
      // else {
      //   return orgProfileList.filter(item => item.value === parseInt(this.authUser.org_id))
      // }
    },
    getDesignationByUserType (designationList) {
      if (this.activeRoleId === 1) {
        return designationList
      }
      // else {
      //   return designationList.filter(item => item.org_id === parseInt(this.authUser.org_id))
      // }
    }
  }
}
