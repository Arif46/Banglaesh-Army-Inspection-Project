<template>
    <ValidationObserver ref="inputAdd"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveSettings)" @reset.prevent="reset">
            <b-row>
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="required_status" vid="required_status">
                        <b-form-group
                            class="row"
                            label-cols-sm="2"
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
                            :placeholder="$t('component_settings.label_en')"
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
                            label-for="label_bn"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.label_bn')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label_bn"
                            v-model="inputFields.label_bn"
                            :placeholder="$t('component_settings.label_bn')"
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
                    <ValidationProvider name="Placeholder bn" vid="placeholder_bn">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="placeholder_bn"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.placeholder_bn')}}
                            </template>
                            <b-form-input
                            id="placeholder_bn"
                            v-model="inputFields.placeholder_bn"
                            :placeholder="$t('component_settings.placeholder_bn')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="Language Type" vid="lang_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="lang_type"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.lang_type')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="inputFields.lang_type"
                            id="lang_type"
                            :options="languageTypeList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-select>
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
export default {
    props: ['editData'],
    components: {
        ValidationObserver,
        ValidationProvider
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
                field_type: 'text_area',
                value: '',
                help_text: '',
                placeholder: '',
                lang_type: 'en',
                placeholder_bn: ''
            },
            formTitle: ''
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
        }
    },
    watch: {
        'inputFields.label': function (newVal) {
            this.inputFields.field_name = this.wordsToSnake(newVal)
            this.formTitle = newVal
        }
    },
    computed: {
        languageTypeList: function () {
            return this.$store.state.LicenseRegistrationService.commonObj.languageTypeList.filter(item => {
                return Object.assign(item, { value: item.value, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        saveSettings: function () {
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addTextArea', tmp, 'modal-6')
        }
    }
}
</script>
