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
            <b-col lg="6" sm="6" md="6"></b-col>
            <b-col lg="6" sm="6" md="6">
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
            <b-col lg="6" sm="6" md="6">
              <ValidationProvider name="is_multiple" vid="is_multiple">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="is_multiple"
                >
                  <template v-slot:label>
                    {{$t('component_settings.multiple')}}
                  </template>
                  <b-form-checkbox
                    class="mt-2"
                    id="is_multiple"
                    v-model="inputFields.is_multiple"
                  > Yes
                  </b-form-checkbox>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="12" sm="12" md="12" class="text-right">
                <table class="table table-sm">
                    <tr v-for="(item, index) in inputFields.options" :key="index">
                        <td>
                            <ValidationProvider name="Checkbox Item" :vid="`checkbox_item`+index">
                                <b-form-group>
                                    <b-form-input
                                        :id="`checkbox_item`+index"
                                        v-model="item.text"
                                        :placeholder="$t('dropdown_settings.option_input_en')"
                                    ></b-form-input>
                                </b-form-group>
                            </ValidationProvider>
                            <ValidationProvider name="Checkbox Item" :vid="`checkbox_item`+index">
                                <b-form-group>
                                    <b-form-input
                                        :id="`checkbox_item`+index"
                                        v-model="item.text_bn"
                                        :placeholder="$t('dropdown_settings.option_input_bn')"
                                    ></b-form-input>
                                </b-form-group>
                            </ValidationProvider>
                        </td>
                        <td>
                            <button type="button" v-if="index === 0" @click="addItem()" class="btn btn-success">+</button>
                            <button type="button" v-if="index !== 0" @click="removeItem(index)" class="btn btn-danger">X</button>
                        </td>
                    </tr>
                </table>
            </b-col>
            <b-col lg="12" sm="12" md="12" class="text-right">
              <!-- <b-button type="submit" variant="primary" v-if="update">{{ 'Update'}}</b-button> -->
              <b-button  type="submit" variant="primary">{{ 'Save'}}</b-button>
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
            field_name: '',
            field_type: 'options',
            label: '',
            help_text: '',
            is_multiple: false,
            options: [
              {
                text: '',
                text_bn: ''
              }
            ]
          }
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
      methods: {
        wordsToSnake (val) {
          return wordsToSnake(val)
        },
        addItem: function () {
          const obj = {
            text: '',
            text_bn: ''
          }
          this.inputFields.options.push(obj)
        },
        removeItem (index) {
          this.inputFields.options.splice(index, 1)
        },
        saveSettings: function () {
          const tmpInput = this.inputFields.options.map(item => {
            return Object.assign(item, { value: item.text })
          })
          const data = Object.assign(this.inputFields, { options: tmpInput })
          const tmp = JSON.parse(JSON.stringify(data))
          this.$emit('addCheckbox', tmp, 'modal-3')
        }
      }
    }
</script>
