import toggleStatus from '@/utils/toggle-status'
import toggleMixedStatus from '@/utils/toggle-mixed-status'

export default {
    data () {
        return {
          pagination: {
            currentPage: 1,
            totalRows: 0,
            perPage: 20,
            slOffset: 1
          },
          editItemId: 0,
          detailItemId: 0
        }
    },
    computed: {
      loading () {
        return this.$store.state.commonObj.loading
      },
      listReload () {
        return this.$store.state.commonObj.listReload
      },
      loadingState () {
        if (this.listReload) {
          return true
        } else if (this.loading) {
            return true
        } else {
          return false
        }
      },
      listData () {
        return this.$store.state.list
      },
      checkBn () {
        return (this.$i18n.locale === 'bn') ? 1 : 0
      }
    },
    watch: {
      listReload: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.loadData()
        }
      }
    },
    // mounted () {
    //   core.index()
    // },
    methods: {
      resetId () {
        this.editItemId = 0
      },
      edit (item) {
        this.editItemId = item.id
      },
      details (item) {
        this.items = item
        this.detailItemId = item.id
      },
      paginationData (data, limit) {
        this.pagination.perPage = limit
        this.pagination.currentPage = data.current_page
        this.pagination.totalRows = data.total
        this.pagination.slOffset = parseInt(this.pagination.perPage) * this.pagination.currentPage - parseInt(this.pagination.perPage) + 1
      },
      changeStatus (componentId, baseUrl, uri, item, destination = null, dropdownName = null) {
        toggleStatus(componentId, baseUrl, uri, item, destination, dropdownName)
      },
      swalMixedStatus (baseUrl, uri, item, swalMsg = null, hideModal = null) {
        toggleMixedStatus(baseUrl, uri, item, swalMsg, hideModal)
      }
    },
    beforeDestroy () {
      this.$store.dispatch('resetList', [])
    }
}
