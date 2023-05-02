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
                    <ValidationProvider name="label_bn" vid="label_bn" rules="required">
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
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="Grids" vid="grids">
                        <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="grids"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ 'Select Field' }} <span class="text-danger">*</span>
                        </template>
                        <b-form-checkbox-group
                            class="text-dark"
                            v-model="inputFields.fields"
                            :options="inputListGrid"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-checkbox-group>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
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
                fields: [],
                field_type: 'addMore_button',
                addMore_options: []
            },
            inputListGrid: []
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
        }
        if (this.formData) {
            this.formData.forEach(i => {
                if (i.field_type !== 'addMore_button' && i.field_type !== 'h1' && i.field_type !== 'h2' && i.field_type !== 'h3' && i.field_type !== 'h4' && i.field_type !== 'h5' && i.field_type !== 'h6' && i.field_type !== 'paragraph' && i.field_type !== 'empty') {
                    this.inputListGrid.push({
                        text: this.$i18n.locale === 'en' ? i.label : i.label_bn, value: i.id
                    })
                }
            })
        }
    },
    watch: {
        'inputFields.label': function (newVal) {
            this.inputFields.field_name = this.wordsToSnake(newVal)
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        saveSettings: function () {
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addAddMore', tmp, 'modal-10')
        }
    }
}
</script>
