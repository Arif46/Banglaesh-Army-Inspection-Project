<template>
    <b-col md="12" sm="12" lg="12" class="text-center" v-if="data.field_type === 'image'">
        <span v-if="getFile(data) && data.upload_type === 'static'">
            <img :src="imgData" style="max-width: 100%;">
        </span>
        <span v-else>
            <div style="width:200px,height:200px;border:1px solid gray">
                <croppa v-model="croppa"
                    :width="200"
                    :height="200"
                    :file-size-limit="2097152"
                    :placeholder="data.label"
                    :placeholder-font-size="14"
                    @move="imageChanged(data)"
                    @new-image-drawn="imageChanged(data)"
                    @file-size-exceed="fileSizeValidation(data)"
                    canvas-color="transparent"
                    accept=".jpeg,.jpg,.png">
                </croppa>
            </div>
        </span>
    </b-col>
    <b-col md="12" sm="12" lg="12" v-else>
        <b-row>
            <b-col md="12" sm="12" lg="12">
                <b-form-group
                    label-cols-sm="6"
                    :label-for="data.field_name"
                >
                    <template v-slot:label>
                        {{ local === 'bn' ? data.label_bn : data.label }} <span class="text-danger" v-if="data.isRequired === true">*</span><span v-if="data.help_text !== ''" class="ml-2" style="border:1px solid #66cc99;border-radius:50%;cursor:pointer" data-toggle="tooltip" data-placement="top" :title="data.help_text">?</span>
                    </template>
                    <b-form-file
                        :placeholder="data.placeholder"
                        :id="data.field_name"
                        v-on:change="onFileChange"
                        v-model="data.value"
                    ></b-form-file>
                </b-form-group>
            </b-col>
            <b-col md="6" sm="6" lg="6" v-if="data.field_type === 'file' && parseInt(data.is_commentable.allow_comment) === 1">
                <b-form-group
                label-cols-sm="2"
                :label-for="data.is_commentable.yesNo"
                >
                <b-form-radio-group
                :id="data.is_commentable.yesNo"
                v-model="data.is_commentable.yesNo"
                :options="valueOptions"
                ></b-form-radio-group>
                </b-form-group>
            </b-col>
            <b-col md="6" sm="6" lg="6" class="text-center" v-if="data.field_type === 'file' && parseInt(data.is_commentable.allow_comment) === 1">
                <b-form-group>
                    <b-form-textarea
                    :id="data.is_commentable.comments"
                    v-model="data.is_commentable.comments"
                    :placeholder="local === 'bn' ? 'মন্তব্যে' : 'Comments'"
                    ></b-form-textarea>
                </b-form-group>
            </b-col>
        </b-row>
    </b-col>
</template>
<script>
import Croppa from 'vue-croppa'
export default {
    props: ['data'],
    components: {
        croppa: Croppa.component
    },
    data () {
        return {
            croppa: {},
            valueOptions: [
                { value: '1', text: 'Valid' },
                { value: '2', text: 'Invalid' }
            ],
            imgData: ''
        }
    },
    computed: {
        local: function () {
            return this.$i18n.locale
        }
    },
    watch: {
        data: {
            deep: true,
            handler (val) {
                this.data.value[1] = val.is_commentable.yesNo
                this.data.value[2] = val.is_commentable.comments
            }
        }
    },
    methods: {
        getFile (data) {
            if (data.value !== '') {
                this.imgData = data.value
                return true
            } else {
                return false
            }
        },
        imageChanged: function (item) {
            item.value[0] = this.croppa.generateDataUrl()
        },
        onFileChange (e) {
            this.getBase64(e.target.files[0]).then(res => {
                this.data.value[0] = res
            })
        },
        getBase64 (file) {
            return new Promise(function (resolve, reject) {
                const reader = new FileReader()
                let imgResult = ''
                reader.readAsDataURL(file)
                reader.onload = function () {
                    imgResult = reader.result
                }
                reader.onerror = function (error) {
                    reject(error)
                }
                reader.onloadend = function () {
                    resolve(imgResult)
                }
            })
        },
        fileSizeValidation: function (item) {
            this.$toast.error({
                title: 'Warning',
                message: 'File maximum size 2mb',
                color: '#D6E09B'
            })
        }
    }
}
</script>
