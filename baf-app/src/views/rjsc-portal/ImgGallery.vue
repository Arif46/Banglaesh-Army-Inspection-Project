<template>
    <div class="mt-4">
        <h4 class="text-center pb-3">Photo Gallery</h4>
        <vueper-slides :arrows-outside="false" class="no-shadow" :visible-slides="5" slide-multiple :gap="3" :slide-ratio="1 / 6"
            :dragging-distance="200" :breakpoints="{ 800: { visibleSlides: 2, slideMultiple: 2 } }">
            <vueper-slide v-for="(slide, i) in slides" :key="i" :image="slide.image" />
        </vueper-slides>
    </div>
</template>
<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
export default {
    name: 'Gallery',
    components: { VueperSlides, VueperSlide },
    data: () => ({
        slides: [
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') }
        ]
    }),
    methods: {
        showImg (img) {
            alert('Hello')
        }
    }
}
</script>
