<template>
    <div class="portal-wrapper">
        <Header></Header>
        <LayoutVue/>
        <Footer></Footer>
    </div>
</template>
<script>
import Header from './common/Header.vue'
import Footer from './common/Footer.vue'
import LayoutVue from './Layout.vue'
    export default {
        components: {
            Header,
            Footer,
            LayoutVue
        }
    }
</script>
