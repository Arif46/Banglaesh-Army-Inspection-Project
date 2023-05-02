<template>
    <b-col md="12" sm="12" lg="12" class="text-center">
        <div v-if="data.field_type === 'image'">
            <span v-if="data.upload_type === 'static'">
                <img :src="data.value" style="max-width: 100%;">
            </span>
            <div class="custom-wrap1" v-if="data.upload_type === 'dynamic'">
                <div v-if="getFile(data.value)" class="custom-data1">
                    <!-- <img :src="bftiBaseUrl + 'uploads/bfti/' + uploadedfile" style="max-width: 200px;max-height: 200px;min-width: 200px;min-height: 200px;" alt="Not Found"> -->
                    <a style="font-weight: bold;" target="_blank" :href="bftiBaseUrl + 'uploads/bfti/' + uploadedfile">Link</a>
                </div>
            </div>
        </div>
        <div class="custom-wrap1" v-if="data.field_type === 'file'">
            <div class="custom-label1" v-if="!reportView">{{ $i18n.locale === 'bn' ? data.label_bn : data.label }} : </div>
            <div class="custom-data1">
                <div  v-if="getFile(data.value)">
                    <a style="font-weight: bold;" target="_blank" :href="bftiBaseUrl + 'uploads/bfti/' + uploadedfile">Link</a>
                </div>
                <p class="text-bold" style="font-weight: 600;" v-else>  : ..................</p>
            </div>
        </div>
    </b-col>
</template>
<script>
import { bftiResReportServiceBaseUrl } from '@/config/api_config'
export default {
    props: ['data', 'reportView'],
    data () {
        return {
            uploadedfile: '',
            valueOptions: [
                { value: '1', text: 'Valid' },
                { value: '2', text: 'Invalid' }
            ],
            bftiBaseUrl: bftiResReportServiceBaseUrl
        }
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    methods: {
        getFile (value) {
            if (value !== '') {
                const fileData = JSON.parse(value)
                if (fileData[0]) {
                    this.uploadedfile = fileData[0]
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }
}
</script>
<style scoped>
    .custom-style {
        border:1px solid #ddd !important;
    }
    .custom-wrap {
        display: flex;
    }
    .custom-wrap > div {
        font-size: 14px;
    }
    .custom-wrap > div.custom-label {
        margin-right:10px;
    }
</style>
