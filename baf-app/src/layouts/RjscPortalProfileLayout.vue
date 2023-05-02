<template>
    <main role="main">
        <div class="section-wrapper portal-section-wrapper mb-0">
            <div class="portal-wrapper">
                <Header></Header>
            </div>
            <div>
                <router-view />
            </div>
            <Footer />
        </div>
    </main>
</template>
<script>
import Header from '@/components/rjsc-portal/Header.vue'
import Footer from '@/components/rjsc-portal/Footer.vue'
import rjscPortalServiceMixin from '@/mixins/rjsc-portal-service'
export default {
    name: 'RjscPortalLayout',
    mixins: [rjscPortalServiceMixin],
    components: {
        Header,
        Footer
    }
}
</script>
