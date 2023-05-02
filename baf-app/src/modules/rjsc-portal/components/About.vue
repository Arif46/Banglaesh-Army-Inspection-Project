<template>
    <div>
        <Header />
        <b-container>
            <b-row class="py-4">
                <b-col sm="12" md="8">
                    <div class="page-title">
                        <h4>About</h4>
                    </div>
                    <div class="about-details">
                        <p>Bangladesh Association of Software and Information Services (BASIS) is the national trade
                            body for Software & IT Enabled Service industry of Bangladesh. Established in 1998, the
                            association has been working with a vision of developing vibrant software & IT service
                            industry in the country. BASIS started its journey with only 18 charter members. Today the
                            membership stands more than eighteen hundred. Members of BASIS account for the lion share of
                            the total software & IT services revenue of the country. BASIS, through its regular programs
                            and activities, works on the following broad objectives: </p>
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
        name: 'About',
        components: {
            Header,
            Footer,
            Notice,
            News
        }
    }
</script>
<style>
    .page-title{
        width: 100%;
        padding: .5em 0;
        border-radius: .3em;
        text-align: center;
        color: var(--white);
        background-color: var(--rjsc-brand);
    }
    .about-details p{
        padding: .8em 0;
        text-align: justify;
    }
</style>
