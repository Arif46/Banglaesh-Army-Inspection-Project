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
                                {{$t('component_settings.label')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="inputFields.label"
                            :placeholder="$t('component_settings.label')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
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
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="header value en" vid="header_value">
                        <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="header_value"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.header_text')}}
                            </template>
                            <b-form-input
                            id="header_value"
                            v-model="inputFields.header_value"
                            :placeholder="$t('component_settings.header_text')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="header value bn" vid="header_value_bn">
                        <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="header_value_bn"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.header_value_bn')}}
                            </template>
                            <b-form-input
                            id="header_value_bn"
                            v-model="inputFields.header_value_bn"
                            :placeholder="$t('component_settings.header_value_bn')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="color"
                    >
                        <template v-slot:label>
                            {{$t('component_settings.color')}}
                        </template>

                        <b-form-input
                        id="color"
                        v-model="inputFields.color"
                        type="color"
                        ></b-form-input>
                    </b-form-group>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="align type" vid="align_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="align_type"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.align_type')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="inputFields.align_type"
                            id="align_type"
                            :options="alignTypeList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-select>
                                <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="required_status"
                    >
                        <template v-slot:label>
                            {{$t('component_settings.border')}}
                        </template>

                        <b-form-checkbox
                            class="mt-2"
                            id="required_status"
                            v-model="inputFields.isBorder"
                        >
                        </b-form-checkbox>
                    </b-form-group>
                </b-col>
                <b-col lg="12" sm="12" md="12" class="text-right">
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
                label: '',
                isRequired: false,
                is_show: false,
                field_name: '',
                header_value: '',
                header_value_bn: '',
                field_type: 'h1',
                color: '111',
                isBorder: false,
                align_type: 'text-left'
            },
            inputOptionList: [
                { item: 'h1', text_en: 'H1', text_bn: 'এইচ ওয়ান' },
                { item: 'h2', text_en: 'H2', text_bn: 'এইচ টু' },
                { item: 'h3', text_en: 'H3', text_bn: 'এইচ থ্রিরি' },
                { item: 'h4', text_en: 'H4', text_bn: 'এইচ ফোর' },
                { item: 'h5', text_en: 'H5', text_bn: 'এইচ ফাইব' },
                { item: 'h6', text_en: 'H6', text_bn: 'এইচ সিক্স' }
            ],
            alignList: [
                { item: 'text-left', text_en: 'Left', text_bn: 'বামে' },
                { item: 'text-center', text_en: 'Center', text_bn: 'মাঝে' },
                { item: 'text-right', text_en: 'Right', text_bn: 'ডানে' }
            ],
            formTitle: ''
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
        }
    },
    computed: {
        inputTypeList: function () {
            return this.inputOptionList.map(item => {
                return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        },
        alignTypeList: function () {
            return this.alignList.map(item => {
                return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
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
            this.$emit('addHeader', tmp, 'modal-9')
        }
    }
}
</script>
