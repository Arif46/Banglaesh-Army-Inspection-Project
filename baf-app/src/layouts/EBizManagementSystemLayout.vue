<template>
  <div class="main-wrapper" :class="{ closeSidebar: closeSidebar}">
    <div class="sidebar-section sidebarHide desktop-hidden d-none d-md-block">
      <Sidebar :layout="'designer'" name="bazar_monitoring"></Sidebar>
    </div>
    <div class="main-content-section containerFullWidth">
      <div class="section-wrapper">
        <Header :layout="'designer'"></Header>
        <div class="main-content-wrapper">
          <router-view></router-view>
        </div>
      </div>
      <Footer></Footer>
    </div>
  </div>
</template>
<script>
import Sidebar from '../components/Sidebar.vue'
import Header from '../components/Header.vue'
import Footer from '../components/Footer.vue'
import { EventBus } from '@/EventBusLayout'
import eBizManagementSystemMixin from '@/mixins/e-biz-management-system-service'
import commonServiceMixin from '@/mixins/common-service'
import { mapActions } from 'vuex'

export default {
  name: 'MainLayout',
  mixins: [eBizManagementSystemMixin, commonServiceMixin],
  data () {
    return {
      closeSidebar: false,
      mixinComponentId: 4
    }
  },
  created () {
    EventBus.$on('toggleNav', this.checkSidebarToggleValue)
  },
  components: {
    Sidebar,
    Header,
    Footer
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.localizeEBizManagementSystem({ value: newVal })
        // Common service Dropdown language Call function
        this.localizeCommonDropdownCommonService({ value: newVal })
      }
    }
  },
  methods: {
    checkSidebarToggleValue (param) {
      this.closeSidebar = param
    },
    ...mapActions({
      localizeEBizManagementSystem: 'EBizManagementSystemService/localizeDropdown',
      // Common service Dropdown language Call function
      localizeCommonDropdownCommonService: 'CommonService/localizeDropdown'
    })
  }
}
</script>
