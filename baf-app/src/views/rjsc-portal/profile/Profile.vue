<template>
    <div>
        <Header></Header>
        <Layout/>
        <Footer></Footer>
    </div>
</template>
<script>
import Header from '../common/Header.vue'
import Footer from '../common/Footer.vue'
import Layout from '../profile/Layout.vue'
export default {
    name: 'Profile',
    components: {
        Header,
        Footer,
        Layout
    }
}
</script>
<style>
</style>
