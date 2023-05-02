<template>
  <main role="main" class="rjsc-body">
    <div class="section-wrapper portal-section-wrapper mb-0">
      <div class="portal-wrapper">
      <Header></Header>
      </div>
      <div>
        <b-container>
          <b-row class="py-4" style="background-color: rgb(245 245 245);">
            <b-col sm="12" md="9" lg="9" xl="9">
              <router-view></router-view>
            </b-col>
            <b-col sm="12" md="3" lg="3" xl="3">
              <Sidebar />
            </b-col>
          </b-row>
        </b-container>
      </div>
      <Footer />
    </div>
  </main>
</template>
<script>
import Header from '@/components/rjsc-portal/Header.vue'
import Sidebar from '@/components/rjsc-portal/Sidebar.vue'
import Footer from '@/components/rjsc-portal/Footer.vue'
import rjscPortalServiceMixin from '@/mixins/rjsc-portal-service'
    export default {
      name: 'RjscPortalLayout',
      mixins: [rjscPortalServiceMixin],
      components: {
        Header,
        Sidebar,
        Footer
      }
    }
</script>
<style>
.rjsc-body{
  background-color: #E6E7E8;
  background: url('../assets/images/rjsc-portal/white_carbon.png');
  background-attachment: fixed;
}
</style>
