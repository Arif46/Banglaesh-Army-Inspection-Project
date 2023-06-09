import Store from '@/store'
import RestApi from '@/config/api_config'

const changeStatus = (componentId, baseUrl, uri, item, destination = null, dropdownName = null) => {
  Store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
  RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
    if (response.success) {
      /** The following line commented as list is reloaded */
      // Store.dispatch('toggleStatus', item)
      if (destination !== null && dropdownName !== null) {
        Store.dispatch('toggleDropdownItemStatus', { itemId: item.id, destination: destination, dropdownName: dropdownName })
      }
      // call dropdown
      getComponentById(componentId)
      window.vm.$toast.success({
        title: window.vm.$t('globalTrans.success'),
        message: window.vm.$t('globalTrans.update_msg'),
        color: '#D6E09B'
      })
    } else {
        window.vm.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
      })
    }
    Store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
  })
}
const toggleStatus = (componentId, baseUrl, uri, item, destination = null, dropdownName = null) => {
  window.vm.$swal({
    title: window.vm.$t('globalTrans.statusChangeMsg'),
    showCancelButton: true,
    confirmButtonText: window.vm.$t('globalTrans.yes'),
    cancelButtonText: window.vm.$t('globalTrans.no'),
    focusConfirm: false
  }).then((result) => {
    if (result.isConfirmed) {
      changeStatus(componentId, baseUrl, uri, item, destination, dropdownName)
    }
  })
}

const getComponentById = (componentId) => {
  if (componentId === 3) {
    Store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 5) {
    Store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 6) {
    Store.dispatch('BftiResReportService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 9) {
    Store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 8) {
    Store.dispatch('TradeTariffService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 10) {
    Store.dispatch('ExportTrophyCipService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 15) {
    Store.dispatch('RjscService/mutateCommonObj', { hasDropdownLoaded: false })
  } else if (componentId === 1) {
    Store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
  }
}

export default toggleStatus
