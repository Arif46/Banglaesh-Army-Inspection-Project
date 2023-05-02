<template>
    <div class="my-4">
        <div class="section_title mb-3">
            <h4 class="text-center">{{ $t('rjsc_portal.gallery') }}</h4>
        </div>
        <lightbox css="h-200 h-lg-250" cells="3" :items="images"></lightbox>
    </div>
</template>
<script>
export default {
    data () {
        return {
            images: [
                'https://placeimg.com/640/480/tech?t=1672896723837',
                'https://placeimg.com/640/480/tech?t=1672896691435',
                'https://placeimg.com/640/480/tech?t=1672896723834',
                'https://placeimg.com/640/480/tech?t=1672896723833',
                'https://placeimg.com/640/480/tech?t=1672896723838'
            ]
        }
    }
}
</script>
