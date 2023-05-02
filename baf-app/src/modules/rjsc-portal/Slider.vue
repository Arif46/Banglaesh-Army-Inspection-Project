<template>
    <div>
        <vueper-slides :arrows-outside="false" class="no-shadow" :visible-slides="1" slide-multiple :gap="3"
            :dragging-distance="200" :autoplay="true"
            :breakpoints="{ 800: { visibleSlides: 2, slideMultiple: 2 } }">
            <vueper-slide v-for="(slide, i) in slides" :key="i" :image="slide.image" />
        </vueper-slides>
    </div>
</template>
<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
export default {
    name: 'Slider',
    components: { VueperSlides, VueperSlide },
    data: () => ({
        slides: [
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') },
            { image: require('../../assets/images/rjsc-portal/cover.png') }
        ]
    })
}
</script>
