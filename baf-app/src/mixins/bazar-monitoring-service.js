import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedBazarMonitoringService () {
      return this.$store.state.BazarMonitoringService.commonObj.hasDropdownLoaded
    },
    orgId () {
      const orgId = this.$store.state.Auth.authUser.office_detail.org_id
      return [1, 11].includes(orgId) ? orgId : 11
    }
  },
  watch: {
    hasDropdownLoadedBazarMonitoringService: function (newValue) {
      if (!newValue) {
        this.loadCommonDropdown()
      }
    }
  },
  created () {
    this.loadCommonDropdown()
  },
  methods: {
    async loadCommonDropdown () {
      const response = await RestApi.getData(bazarMonitoringServiceBaseUrl, 'common-dropdowns', null)
      if (response.success) {
        let marketList = response.data.marketDirectoryList
        const activeRoleId = this.$store.state.Auth.activeRoleId
        if (activeRoleId !== 1) {
          RestApi.getData(bazarMonitoringServiceBaseUrl, '/configuration/market-assigns/details/' + this.$store.state.Auth.authUser.user_id, null).then(responseData => {
            if (responseData.success) {
              marketList = this.getMarketList(marketList, responseData.data.market_id)
              this.storeMainFn(response, marketList, responseData.data)
              this.customizeCommonService()
            } else {
              this.storeMainFn(response, [], [])
            }
          })
        } else {
          this.storeMainFn(response, marketList, [])
        }
      }
    },
    addressCustomFn (loggedUser) {
      const addressCustom = {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        market_id: 0
      }
      if (loggedUser.area_type_id) {
        if (loggedUser.area_type_id.length === 1) {
          addressCustom.area_type_id = loggedUser.area_type_id[0]
        }
      }
      if (loggedUser.city_corporation_id) {
        if (loggedUser.city_corporation_id.length === 1) {
          addressCustom.city_corporation_id = loggedUser.city_corporation_id[0]
        }
      }
      if (loggedUser.pauroshoba_id) {
        if (loggedUser.pauroshoba_id.length === 1) {
          addressCustom.pauroshoba_id = loggedUser.pauroshoba_id[0]
        }
      }
      if (loggedUser.division_id) {
        if (loggedUser.division_id.length === 1) {
          addressCustom.division_id = loggedUser.division_id[0]
        }
      }
      if (loggedUser.district_id) {
        if (loggedUser.district_id.length === 1) {
          addressCustom.district_id = loggedUser.district_id[0]
        }
      }
      if (loggedUser.upazila_id) {
        if (loggedUser.upazila_id.length === 1) {
          addressCustom.upazila_id = loggedUser.upazila_id[0]
        }
      }
      if (loggedUser.market_id) {
        if (loggedUser.market_id.length === 1) {
          addressCustom.market_id = loggedUser.market_id[0]
        }
      }
      return addressCustom
    },
    storeMainFn (response, marketList, loggedUser) {
      const addressCustom = this.addressCustomFn(loggedUser)
      this.$store.dispatch('BazarMonitoringService/mutateCommonObj', {
        hasDropdownLoaded: true,
        loggedUserPrivilege: loggedUser,
        addressCustomUser: addressCustom,
        priceCategoryList: response.data.priceCategoryList,
        commodityGroupList: response.data.commodityGroupList,
        commodityNameList: response.data.commodityNameList,
        lawEntryList: response.data.lawEntryList,
        marketDirectoryList: marketList,
        unitList: response.data.unitList,
        sectionList: response.data.sectionList,
        alertList: response.data.alertList
      })
      this.$store.dispatch('BazarMonitoringService/localizeDropdown', { value: this.$i18n.locale })
    },
    getMarketList (marketAll, marketId) {
      let marketList = []
      if (marketId) {
        if (marketId.length > 0) {
          marketId.forEach((item, key) => {
            const marketAllLists = marketAll.filter(item1 => item1.value === parseInt(item))
            marketAllLists.forEach((item1, key) => {
              marketList.push(item1)
            })
          })
        }
      } else {
        marketList = marketAll
      }
      return marketList
    },
    customizeCommonService () {
      let areaTypeList = []
      let divisionList = []
      let districtList = []
      let upazilaList = []
      let cityCorporationList = []
      let municipalityList = []
      const loggedUser = this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
      areaTypeList = this.$store.state.commonObj.areaTypeList
      divisionList = this.$store.state.CommonService.commonObj.divisionList
      districtList = this.$store.state.CommonService.commonObj.districtList
      upazilaList = this.$store.state.CommonService.commonObj.upazilaList
      cityCorporationList = this.$store.state.CommonService.commonObj.cityCorporationList
      municipalityList = this.$store.state.CommonService.commonObj.municipalityList
      areaTypeList = this.customizeData(areaTypeList, loggedUser.area_type_id)
      this.$store.dispatch('mutateCommonProperties', {
        areaTypeList: areaTypeList
      })
      divisionList = this.customizeData(divisionList, loggedUser.division_id)
      districtList = this.customizeData(districtList, loggedUser.district_id)
      upazilaList = this.customizeData(upazilaList, loggedUser.upazila_id)
      cityCorporationList = this.customizeData(cityCorporationList, loggedUser.city_corporation_id)
      municipalityList = this.customizeData(municipalityList, loggedUser.pauroshoba_id)

      this.$store.dispatch('CommonService/mutateCommonObj', {
        hasDropdownLoaded: true,
        divisionList: divisionList,
        districtList: districtList,
        upazilaList: upazilaList,
        cityCorporationList: cityCorporationList,
        municipalityList: municipalityList
      })
      this.$store.dispatch('CommonService/localizeDropdown', { value: this.$i18n.locale })
    },
    customizeData (dataAll, dataId) {
      let data = []
      if (dataId) {
        if (dataId.length > 0) {
          dataId.forEach((item, key) => {
            const dataItem = dataAll.find(item1 => item1.value === parseInt(item))
            data.push(dataItem)
          })
        }
      } else {
        data = dataAll
      }
      return data
    }
  }
}
