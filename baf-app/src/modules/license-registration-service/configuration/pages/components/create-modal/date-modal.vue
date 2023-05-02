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
                            label-for="label"
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
                    <ValidationProvider name="required_status" vid="required_status">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
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
                isRequired: false,
                is_show: false,
                label: '',
                label_bn: '',
                field_name: '',
                value: '',
                help_text: '',
                field_type: 'date'
            },
            inputOptionList: [
                { item: 'date', text_en: 'Date', text_bn: 'ডেট' },
                { item: 'age', text_en: 'Age', text_bn: 'বয়স' }
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
            this.$emit('addDate', tmp, 'modal-7')
        }
    }
}
</script>
