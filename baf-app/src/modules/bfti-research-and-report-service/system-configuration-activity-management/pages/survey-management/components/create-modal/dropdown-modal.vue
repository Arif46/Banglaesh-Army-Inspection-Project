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
                            :disabled="true"
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
                    <ValidationProvider name="Component" vid="component_id" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="component_id"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.component')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="dropdownFields.component_id"
                            id="field_type"
                            :options="componentListDropdown"
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
                            label-cols-sm="12"
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
            <hr>
            <b-row>
                <b-col lg="10" sm="10" md="10" v-if="customDropdownStatus">
                    <ValidationProvider name="Dropdown Item" vid="dropdown_item">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="dropdown_item"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.option')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="dropdown_item.name"
                            :placeholder="$t('dropdown_settings.option_input_en')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                    <ValidationProvider name="Dropdown Item Bn" vid="dropdown_item_bn">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
                            label-for="dropdown_item_bn"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.option_bn')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="label"
                            v-model="dropdown_item.name_bn"
                            :placeholder="$t('dropdown_settings.option_input_bn')"
                            ></b-form-input>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="2" sm="2" md="2" v-if="customDropdownStatus">
                    <b-button @click="addDropOption" variant="primary" class="btn btn-primary btn-xs"><i class="ri-add-line"></i></b-button>
                </b-col>
            </b-row>
            <b-row>
                <b-col>
                    <table class="table" v-if="dropdownFields.component_id === '0'">
                        <tr v-for="(item, index) in dropdownFields.dropdown_options" :key="index">
                            <td style="padding:0px;">
                                <ValidationProvider name="Dropdown Item" vid="dropdown_item">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="dropdown_item"
                                    >
                                        <template v-slot:label>
                                            {{$t('dropdown_settings.option')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            id="label"
                                            v-model="item.name"
                                            :placeholder="$t('dropdown_settings.option_input_en')"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                                <ValidationProvider name="Dropdown Item Bn" vid="dropdown_item_bn">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="dropdown_item_bn"
                                    >
                                        <template v-slot:label>
                                            {{$t('dropdown_settings.option_bn')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            id="label"
                                            v-model="item.name_bn"
                                            :placeholder="$t('dropdown_settings.option_input_bn')"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </td>
                            <td class="text-right" style="padding:0px;">
                                <button @click="deleteItem(index)" class="btn btn-danger btn-xs" size="sm"><i class="ri-close-line"></i></button>
                            </td>
                        </tr>
                    </table>
                </b-col>
            </b-row>
            <b-row v-if="commonDropdownStatus">
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="Dropdown Item" vid="dropdown_name" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="dropdown_name"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.dropdown_name')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="dropdownFields.dropdown_name"
                            id="field_type"
                            :options="drpList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                                <template v-slot:first>
                                    <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="has_parent" vid="has_parent">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="has_parent"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.has_parent')}}
                            </template>
                            <b-form-checkbox
                            id="has_parent"
                            v-model="dropdownFields.has_parent"
                            value="1"
                            unchecked-value=""
                            >
                            </b-form-checkbox>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="Parent Dropdown Item" vid="parent_state">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="parent_state"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('dropdown_settings.parent_dropdown')}}
                            </template>
                            <b-form-select
                            plain
                            v-model="dropdownFields.parent_state"
                            id="field_type"
                            :options="drpList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                                <template v-slot:first>
                                    <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
            </b-row>
            <div class="row">
                <b-col lg="10" md="10" sm="10"></b-col>
                <b-col lg="2" sm="2" md="2" class="float-right">
                    <!-- <b-button type="submit" variant="primary" v-if="tabUpdate">{{ 'Update'}}</b-button> -->
                    <b-button type="submit" variant="primary">{{ 'Save'}}</b-button>
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
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            inputFields: {
                id: 1,
                isRequired: false,
                is_show: false,
                label: '',
                field_name: '',
                value: '',
                help_text: '',
                field_type: 'dropdown',
                placeholder: '',
                min_length: '',
                max_length: '',
                dropdownData: ''
            },
            dropdownFields: {
                component_id: '0',
                dropdown_name: 0,
                dropdown_options: [],
                has_parent: '',
                parent_state: '',
                selected_item: 0
            },
            dropdown_item: {
                name: '',
                name_bn: ''
            },
            customDropdownStatus: true,
            commonDropdownStatus: false,
            licenseStatus: false,
            inputOptionList: [
                { item: 'dropdown', text_en: 'Dropdown', text_bn: 'Dropdown' }
            ],
            componentListDropdown: [
                { value: '0', text: 'Custom Dropdown' }
            ],
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
        inputTypeList: function () {
            return this.inputOptionList.map(item => {
                return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
            })
        }
    },
    watch: {
        'inputFields.label': function (newVal) {
            const snakeValue = this.wordsToSnake(newVal)
            this.inputFields.field_name = snakeValue
            this.formTitle = newVal
        },
        'dropdownFields.component_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                if (newVal === '0') {
                    this.dropdownFields.dropdown_options = []
                    this.customDropdownStatus = true
                    this.commonDropdownStatus = false
                    this.licenseStatus = false
                }
            }
        },
        'dropdownFields.dropdown_name': function (newVal) {
            const curStore = this.curStore
            const drpDList = curStore[newVal]
            this.dropdownFields.dropdown_options = drpDList
        }
    },
    methods: {
        wordsToSnake (val) {
            return wordsToSnake(val)
        },
        addDropOption () {
            const drpOption = JSON.parse(JSON.stringify(this.dropdown_item))
            this.dropdownFields.dropdown_options.push(drpOption)
            this.dropdown_item.name = ''
            this.dropdown_item.name_bn = ''
        },
        saveSettings: function () {
            this.inputFields.dropdownData = this.dropdownFields
            const tmp = JSON.parse(JSON.stringify(this.inputFields))
            this.$emit('addDropdown', tmp, 'modal-2')
        },
        deleteItem (index) {
            this.dropdownFields.dropdown_options.splice(index, 1)
        }
    }
}
</script>
