<template>
    <ValidationObserver ref="inputAdd"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveSettings)" @reset.prevent="reset">
            <b-row>
                  <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="Label" vid="label" rules="required">
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
                <b-col md=12 sm =12 lg=12>
                    <ValidationProvider name="Text" vid="text" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="text"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.para_text')}}
                            </template>
                            <vue-editor
                            id="text"
                            v-model="inputFields.value"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></vue-editor>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col md=12 sm =12 lg=12>
                    <ValidationProvider name="Text bn" vid="text_bn" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="text_bn"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.para_text_bn')}}
                            </template>
                            <vue-editor
                            id="text"
                            v-model="inputFields.value_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></vue-editor>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="align type" vid="align_type" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="3"
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
                <b-col lg="12" sm="12" md="12" class="text-right ">
                    <b-button type="submit" variant="primary">{{ 'Save'}}</b-button>
                </b-col>
            </b-row>
        </b-form>
    </ValidationObserver>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { wordsToSnake } from '@/utils/fliter'
import { VueEditor } from 'vue2-editor'

export default {
    props: ['editData'],
    components: {
        ValidationObserver,
        ValidationProvider,
        VueEditor
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
            inputFields: {
                id: 1,
                isRequired: false,
                is_show: false,
                value: '',
                value_bn: '',
                label: '',
                field_name: '',
                field_type: 'paragraph',
                align_type: 'text-left'
            },
            formTitle: '',
            alignList: [
                { item: 'text-left', text_en: 'Left', text_bn: 'বামে' },
                { item: 'text-center', text_en: 'Center', text_bn: 'মাঝে' },
                { item: 'text-right', text_en: 'Right', text_bn: 'ডানে' }
            ],
            customToolbar: [
                ['bold', 'italic', 'underline', 'strike'],
                [{ header: [1, 2, 3, 4, 5, 6, false] }],
                ['image', 'code-block']
            ]
        }
    },
    created () {
        if (this.editData) {
            this.inputFields = this.editData
        }
    },
    computed: {
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
            this.$emit('addParagraph', tmp, 'modal-8')
        },
        onReady (editor) {
          // Insert the toolbar before the editable area.
          editor.ui.getEditableElement().parentElement.insertBefore(
              editor.ui.view.toolbar.element,
              editor.ui.getEditableElement()
          )
        }
    }
}
</script>
