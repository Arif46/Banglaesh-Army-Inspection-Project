<template>
  <main role="main" :class="activeFont">
    <div class="section-wrapper portal-section-wrapper mb-0">
      <Header></Header>
      <router-view></router-view>
      <Footer></Footer>
    </div>
  </main>
</template>
<script>
import Header from '@/modules/portal/components/Header'
import Footer from '@/modules/portal/components/Footer'
import commonServicePortalMixin from '@/mixins/portal/dropdown-common-portal'

export default {
  name: 'AuthLayout',
  mixins: [commonServicePortalMixin],
  components: { Header, Footer },
  created () {},
  methods: {},
  mounted () {},
  data () {
    return {}
  },
  computed: {
    activeFont: function () {
      return this.$i18n.locale === 'en' ? 'font-en' : 'font-bn'
    },
    loading () {
      return this.$store.state.Portal.loading
    }
  }
}
</script>
<style scoped>
    .section-wrapper{
        overflow-x: hidden;
    }
</style>
