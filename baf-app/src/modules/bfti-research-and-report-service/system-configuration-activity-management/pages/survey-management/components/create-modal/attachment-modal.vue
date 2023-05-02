<template>
    <ValidationObserver ref="inputAdd"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveSettings)" @reset.prevent="reset">
            <b-row>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="label" vid="label" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="label"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.label_en')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="inputFields.label"
                            :placeholder="$t('component_settings.label_input_en')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="label bn" vid="label_bn" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="label"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.label_bn')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label_bn"
                            v-model="inputFields.label_bn"
                            :placeholder="$t('component_settings.label_input_bn')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="help_text" vid="help_text">
                        <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="help_text"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.help_text')}}
                            </template>
                            <b-form-input
                            id="help_text"
                            v-model="inputFields.help_text"
                            :placeholder="$t('component_settings.help_text_input')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="placeholder" vid="placeholder">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="placeholder"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.placeholder_en')}}
                            </template>
                            <b-form-input
                            id="placeholder"
                            v-model="inputFields.placeholder"
                            :placeholder="$t('component_settings.placeholder_en')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="Field Type" vid="field_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="field_type"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.field_type')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="inputFields.field_type"
                            id="field_type"
                            :options="inputTypeList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-select>
                                <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6" v-if="inputFields.field_type === 'image'">
                    <ValidationProvider name="Upload Type" vid="upload_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="upload_type"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.upload_type')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="inputFields.upload_type"
                            id="upload_type"
                            :options="uploadTypeList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-select>
                                <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6" v-if="inputFields.upload_type === 'static'">
                    <div style="width:300px,height:300px">
                        <croppa v-model="croppa"
                            :width="140"
                            :height="80"
                            canvas-color="transparent"
                            @move="imageChanged()"
                            @new-image-drawn="imageChanged()"
                            accept=".jpeg,.jpg,.png">
                        </croppa>
                    </div>
                </b-col>
                <b-col>
                    <ValidationProvider name="required_status" vid="required_status">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="required_status"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.required_status')}}
                            </template>
                            <b-form-checkbox
                                class="mt-2"
                                id="required_status"
                                v-model="inputFields.isRequired"
                            > <span v-if="inputFields.isRequired">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                            </b-form-checkbox>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <!-- <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="allow_multiple" vid="allow_multiple">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="allow_multiple"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.allow_multiple')}}
                            </template>
                            <b-form-checkbox
                                class="mt-2"
                                id="allow_multiple"
                                v-model="inputFields.allow_multiple"
                                value="1"
                                unchecked-value="0"
                            >
                            </b-form-checkbox>
                        </b-form-group>
                    </ValidationProvider>
                </b-col> -->
                <b-col lg="12" sm="12" md="12" v-if="inputFields.field_type === 'file'">
                    <ValidationProvider name="Upload Type" vid="is_commentable">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="is_commentable"
                            slot-scope="{ errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.is_commentable')}}
                            </template>
                            <b-form-checkbox
                                id="is_commentable"
                                v-model="inputFields.is_commentable.allow_comment"
                                value="1"
                                unchecked-value="0"
                            >
                            </b-form-checkbox>
                                <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="2" sm="2" md="2">
                    <!-- <b-button type="submit" variant="primary" v-if="update">{{ 'Update'}}</b-button> -->
                    <b-button type="submit" variant="primary">{{ 'Save'}}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </ValidationObserver>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { wordsToSnake } from '@/utils/fliter'
import Croppa from 'vue-croppa'
export default {
    props: ['editData'],
    components: {
        ValidationObserver,
        ValidationProvider,
        croppa: Croppa.component
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            inputFields: {
                id: 1,
                isRequired: false,
                is_show: false,
                label: '',
                field_name: '',
                value: [],
                help_text: '',
                field_type: 'image',
                upload_type: '',
                placeholder: '',
                allow_multiple: '',
                is_commentable: {
                    allow_comment: '',
                    yesNo: '0',
                    comments: ''
                }
            },
            croppa: {},
            inputOptionList: [
                { item: 'image', text_en: 'Image', text_bn: 'ছবি' },
                { item: 'file', text_en: 'File', text_bn: 'ফাইল' }
            ],
            uploadTypes: [
                { value: 'static', text_en: 'Static', text_bn: 'স্ট্যাটিক' },
                { value: 'dynamic', text_en: 'Dynamic', text_bn: 'ডাইনামিক' }
            ],
            formTitle: ''
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
            this.inputFields.is_commentable = {
                allow_comment: '',
                yesNo: '0',
                comments: ''
            }
        }
    },
    computed: {
        inputTypeList: function () {
            return this.inputOptionList.map(item => {
                return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        },
        uploadTypeList: function () {
            return this.uploadTypes.map(item => {
                if (this.$i18n.locale === 'bn') {
                    return Object.assign(item, { text: item.text_bn, value: item.value })
                } else {
                    return Object.assign(item, { text: item.text_en, value: item.value })
                }
            })
        }
    },
    watch: {
        'inputFields.label': function (newVal) {
            this.inputFields.field_name = this.wordsToSnake(newVal)
            this.formTitle = newVal
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        saveSettings: function () {
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addAttcahment', tmp, 'modal-4')
        },
        imageChanged: function () {
            this.inputFields.value = this.croppa.generateDataUrl()
        }
    }
}
</script>
