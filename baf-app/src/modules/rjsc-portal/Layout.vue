<template>
    <div class="my-4">
        <b-container>
            <b-row>
                <b-col sm="12" md="8">
                    <b-row>
                        <b-col>
                            <Slider/>
                        </b-col>
                    </b-row>
                    <b-row class="mt-4">
                        <b-col cols="6" class="mb-4">
                            <Cards/>
                        </b-col>
                        <b-col cols="6">
                            <Cards/>
                        </b-col>
                        <b-col cols="6" class="mb-4">
                            <Cards/>
                        </b-col>
                        <b-col cols="6">
                            <Cards/>
                        </b-col>
                    </b-row>
                </b-col>
                <b-col sm="12" md="4">
                    <b-row>
                        <b-col>
                           <Notice/>
                        </b-col>
                    </b-row>
                    <b-row class="mt-4">
                        <b-col>
                            <News/>
                        </b-col>
                    </b-row>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import Slider from './Slider.vue'
import Cards from './components/Cards.vue'
import Notice from './components/Notice.vue'
import News from './components/News.vue'
    export default {
        name: 'Layout',
        components: {
    Slider,
    Cards,
    Notice,
    News
}
    }
</script>
