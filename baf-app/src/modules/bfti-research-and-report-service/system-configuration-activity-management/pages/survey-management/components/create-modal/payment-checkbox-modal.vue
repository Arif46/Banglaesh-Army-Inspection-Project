<template>
    <ValidationObserver ref="inputAdd"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveSettings)" @reset.prevent="reset">
            <b-row>
                <b-col lg="4" sm="4" md="4">
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
                <b-col lg="4" sm="4" md="4">
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
                <b-col lg="4" sm="4" md="4">
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
                <b-col lg="4" sm="4" md="4">
                    <ValidationProvider name="required_status" vid="required_status">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
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
            </b-row>
            <b-row v-for="(item, key) in dropdownFields.dropdown_options" :key="key">
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Type Name" vid="type_name">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="type_name"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.type_name_en')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.type_name"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Type Name" vid="type_name">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="type_name"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.type_name_bn')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.type_name_bn"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Amount" vid="amount">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="amount"
                        >
                            <template v-slot:label>
                                {{$t('globalTrans.amount')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.amount"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Renew Amount" vid="renew_amount">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="renew_amount"
                        >
                            <template v-slot:label>
                                {{$t('step_assign.renew_amount')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.renew_amount"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Expire Amount" vid="expire_amount">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="expire_amount"
                        >
                            <template v-slot:label>
                                {{$t('step_assign.expire_amount')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.expire_amount"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Vat" vid="vat">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="vat"
                        >
                            <template v-slot:label>
                                {{$t('globalTrans.vat')}} (%)
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.vat"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3">
                    <ValidationProvider name="Tax" vid="tax">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="tax"
                        >
                            <template v-slot:label>
                                {{$t('globalTrans.tax')}} (%)
                            </template>
                            <b-form-input
                            id="label"
                            v-model="item.tax"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3" md="3" class="text-right">
                    <br>
                    <b-button v-if="key === 0" @click="addDropOption" variant="primary" class="mt-2"><i class="ri-add-line"></i></b-button>
                    <b-button v-if="key !== 0" @click="deleteItem(key)" variant="danger" class="mt-2"><i class="ri-delete-bin-line"></i></b-button>
                </b-col>
            </b-row>
            <div class="row">
                <b-col lg="10" md="10" sm="10"></b-col>
                <b-col lg="2" sm="2" md="2" class="float-right">
                    <!-- <b-button type="submit" variant="primary" v-if="tabUpdate">{{ 'Update'}}</b-button> -->
                    <b-button type="submit" variant="primary">{{ saveBtnName }}</b-button>
                </b-col>
            </div>
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
            saveBtnName: this.editData.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            inputFields: {
                id: 1,
                isRequired: false,
                is_show: false,
                label: '',
                field_name: '',
                value: [],
                help_text: '',
                field_type: 'paymentCheckbox',
                placeholder: '',
                dropdownData: ''
            },
            dropdownFields: {
                dropdown_options: [
                    {
                        type_name: '',
                        type_name_bn: '',
                        amount: 0,
                        renew_amount: 0,
                        expire_amount: 0,
                        vat: 0,
                        tax: 0
                    }
                ],
                selected_item: []
            },
            formTitle: '',
            curStore: '',
            drpList: []
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
            this.dropdownFields = this.editData.dropdownData
        }
    },
    computed: {
    },
    watch: {
        'inputFields.label': function (newVal) {
            const snakeValue = this.wordsToSnake(newVal)
            this.inputFields.field_name = snakeValue + '_id'
            this.formTitle = newVal
        },
        'dropdownFields.component_id': function (newVal) {
            this.moduleview = false
            this.curStore = this.$store.state.CommonService.commonObj
            const storeData = this.curStore
            this.drpList = Object.entries(storeData).filter(([key, value]) => (key !== 'hasDropdownLoaded' && key !== 'activeIntactive' && key !== 'listReload' && key !== 'loading' && key !== 'perPage')).map((item, index) => {
                const textValue = item[0].split(/(?=[A-Z])/).join(' ')
                return { value: item[0], text: textValue }
            })
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        addDropOption () {
            const drpOption = {
                type_name: '',
                type_name_bn: '',
                amount: 0,
                renew_amount: 0,
                expire_amount: 0,
                vat: 0,
                tax: 0
            }
            this.dropdownFields.dropdown_options.push(drpOption)
        },
        saveSettings: function () {
            this.inputFields.dropdownData = this.dropdownFields
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addDropdown', tmp, 'modal-13')
        },
        deleteItem (index) {
            this.dropdownFields.dropdown_options.splice(index, 1)
        }
    }
}
</script>
