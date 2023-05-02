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
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="value" vid="value">
                        <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="value"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.value')}}
                            </template>
                            <b-form-input
                            id="value"
                            v-model="inputFields.value"
                            @input="changeQRCode"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="qr_code" vid="qr_code">
                        <b-form-group
                        class="row"
                        label-cols-sm="3"
                        label-for="qr_code"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.qr_code')}}
                            </template>
                            <vue-qrcode value="qr_code" :quality='0.92' :type='qr_type' :color='qr_color'/>
                            <vue-qrcode value="https://www.1stg.me" />
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12" class="text-right">
                    <b-button type="submit" variant="primary">{{ 'Save'}}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </ValidationObserver>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { wordsToSnake } from '@/utils/fliter'
import VueQrcode from 'vue-qrcode'
export default {
    props: ['editData', 'formData'],
    components: {
        ValidationObserver,
        ValidationProvider,
        VueQrcode
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            qr_code: '',
            qr_type: 'image/png',
            qr_color: {
                dark: 'string',
                light: 'string'
            },
            inputFields: {
                id: 1,
                isRequired: false,
                is_show: false,
                value: '',
                label: '',
                field_name: '',
                field_type: 'qr_code',
                help_text: ''
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
        },
        'inputFields.value': function (newVal) {
            this.qr_code = this.inputFields.value
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        saveSettings: function () {
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addQRCode', tmp, 'modal-11')
        },
        changeQRCode () {
            this.qr_code = this.inputFields.value
        }
    }
}
</script>
