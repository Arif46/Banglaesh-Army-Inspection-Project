<template>
    <ValidationObserver ref="inputAdd"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveSettings)" @reset.prevent="reset">
            <b-row>
                <b-col lg="6" sm="12" md="6">
                    <ValidationProvider name="label En" vid="label" rules="required">
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
                <b-col lg="6" sm="12" md="6">
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
                <b-col lg="6" sm="12" md="6">
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
                <b-col lg="6" sm="12" md="6">
                    <ValidationProvider name="Placeholder En" vid="placeholder">
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
                <b-col lg="6" sm="12" md="6">
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
                            id="placeholder"
                            v-model="inputFields.placeholder_bn"
                            :placeholder="$t('component_settings.placeholder_bn')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="12" md="6">
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
                <b-col lg="6" sm="12" md="6">
                    <ValidationProvider name="min_length" vid="min_length">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="min_length"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.min_length')}}
                            </template>
                            <b-form-input
                            id="min_length"
                            v-model="inputFields.min_length"
                            :placeholder="$t('component_settings.min_length_input')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="12" md="6">
                    <ValidationProvider name="max_length" vid="max_length">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="max_length"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.max_length')}}
                            </template>
                            <b-form-input
                            id="max_length"
                            v-model="inputFields.max_length"
                            :placeholder="$t('component_settings.max_length_input')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="12" md="4">
                    <ValidationProvider name="required_status" vid="required_status">
                        <b-form-group
                            class="row"
                            label-cols-sm="6"
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
                <b-col lg="4" sm="12" md="4">
                    <ValidationProvider name="is_show" vid="is_show">
                        <b-form-group
                            class="row"
                            label-cols-sm="6"
                            label-for="is_show"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.is_show')}}
                            </template>
                            <b-form-checkbox
                                class="mt-2"
                                id="is_show"
                                v-model="inputFields.is_show"
                            > <span v-if="inputFields.is_show">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                            </b-form-checkbox>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="12" md="4">
                    <ValidationProvider name="Mathematical" vid="is_math">
                        <b-form-group
                            class="row"
                            label-cols-sm="6"
                            label-for="is_math"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.mathematical')}}
                            </template>
                            <b-form-checkbox
                                class="mt-2"
                                id="is_math"
                                v-model="inputFields.is_math"
                            > <span v-if="inputFields.is_math">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                            </b-form-checkbox>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="12" md="6">
                    <ValidationProvider name="Language Type" vid="lang_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
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
                <b-col v-if="inputFields.is_math" lg="12" sm="12" md="12">
                    <hr>
                    <b-row v-for="(item, index) in inputFields.m_fields" :key="index">
                        <b-col v-if="index === 0" lg="3" sm="3" md="3">
                            <ValidationProvider name="Input One" :vid="`input_one`+index" rules="required">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="12"
                                    :label-for="`input_one`+index"
                                    slot-scope="{ valid, errors }"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.input_one')}}
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="item.input_one"
                                        :id="`input_one`+index"
                                        :options="numberField"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                            <b-form-select-option value="" >{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="3" sm="3" md="3">
                             <ValidationProvider name="Input Two" :vid="`operator`" rules="required">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="12"
                                    label-for="operator"
                                    slot-scope="{ valid, errors }"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.operator')}}
                                    </template>
                                     <b-form-select
                                        plain
                                        v-model="item.operator"
                                        id="operator"
                                        :options="operatorList"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                            <b-form-select-option value="" >{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="3" sm="3" md="3">
                            <ValidationProvider name="Input Two" :vid="`input_two`" rules="required">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="12"
                                    label-for="input_two"
                                    slot-scope="{ valid, errors }"
                                >
                                    <template v-slot:label>
                                        {{$t('component_settings.input_two')}}
                                    </template>
                                   <b-form-select
                                        plain
                                        v-model="item.input_two"
                                        id="input_two"
                                        :options="numberField"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                            <b-form-select-option value="" >{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-select>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col md="2" sm="2" lg="2">
                            <br>
                            <b-button v-if="index === 0" @click="addNew()" class="mt-3" type="button" variant="primary">+</b-button>
                            <b-button v-if="index !== 0" @click="remove(index)" class="mt-3" type="button" variant="danger">x</b-button>
                        </b-col>
                    </b-row>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <b-button type="submit" variant="primary" size="sm">{{ 'Save'}}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </ValidationObserver>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { wordsToSnake } from '@/utils/fliter'
export default {
    props: ['editData', 'formData'],
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
                label_bn: '',
                field_name: '',
                value: '',
                help_text: '',
                field_type: 'text',
                placeholder: '',
                placeholder_bn: '',
                min_length: '',
                max_length: '',
                is_math: false,
                m_fields: [
                    {
                        input_one: '',
                        operator: '',
                        input_two: ''
                    }
                ],
                lang_type: 'en'
            },
            inputOptionList: [
                { item: 'text', text_en: 'Text', text_bn: 'টেক্সট' },
                { item: 'email', text_en: 'Email', text_bn: 'ইমেইল' },
                { item: 'number', text_en: 'Number', text_bn: 'নম্বর' }
            ],
            formTitle: '',
            edit: false
        }
    },
    created () {
        if (this.editData) {
            this.edit = true
            this.inputFields = this.editData
        }
    },
    computed: {
        inputTypeList: function () {
            return this.inputOptionList.map(item => {
                return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        },
        languageTypeList: function () {
            return this.$store.state.LicenseRegistrationService.commonObj.languageTypeList.filter(item => {
                return Object.assign(item, { value: item.value, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        },
        operatorList: function () {
            return this.$store.state.LicenseRegistrationService.commonObj.operatorList
        },
        numberField () {
            return this.formData.map(item => {
                if (item.field_type === 'number') {
                    return { text: item.label, value: item.field_name }
                }
            })
        }
    },
    watch: {
        'inputFields.label': function (newVal) {
            if (this.edit === false) {
                this.inputFields.field_name = this.wordsToSnake(newVal)
            } else {
                const oldfield = this.inputFields.field_name
                this.inputFields.field_name = oldfield
            }
            this.formTitle = newVal
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        saveSettings: function () {
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addInput', tmp, 'modal-1')
        },
        addNew () {
            const tmp = {
                input_one: '',
                operator: '',
                input_two: ''
            }
            this.inputFields.m_fields.push(tmp)
        },
        remove (index) {
            this.inputFields.m_fields.splice(index, 1)
        }
    }
}
</script>
