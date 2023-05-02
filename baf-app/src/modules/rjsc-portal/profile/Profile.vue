<template>
    <div>
        <b-container>
            <b-row>
                <b-col>
                    <ProfileHead />
                </b-col>
            </b-row>
            <b-row>
                <b-col>
                    <TechnicalInfo />
                </b-col>
            </b-row>
            <b-row>
                <b-col>
                    <info-cards />
                </b-col>
            </b-row>
            <b-row>
                <b-col>
                    <ImgGallery />
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import ProfileHead from './components/ProfileHead.vue'
import InfoCards from './components/InfoCards.vue'
import ImgGallery from './components/ImgGallery.vue'
import TechnicalInfo from './components/TechnicalInfo.vue'
export default {
    name: 'Layout',
    components: {
        ProfileHead,
        InfoCards,
        ImgGallery,
        TechnicalInfo
    }
}
</script>
<style>

</style>
