<template>
    <div>
        <Header />
        <b-container>
            <b-row class="py-4">
                <b-col sm="12" md="8">
                    <div class="page-title">
                        <h4>Entities List</h4>
                    </div>
                </b-col>
                <b-col sm="12" md="4">
                    <News class="mb-4"></News>
                    <Notice />
                </b-col>
            </b-row>
        </b-container>
        <Footer />
    </div>
</template>
<script>
import Header from '../common/Header.vue'
import Footer from '../common/Footer.vue'
import Notice from './Notice.vue'
import News from './News.vue'
export default {
    name: 'EntitiesList',
    components: {
        Header,
        Footer,
        Notice,
        News
    }
}
</script>
