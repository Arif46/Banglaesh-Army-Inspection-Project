<template>
    <div class="inner-section">
      <card>
        <b-container fluid>
          <b-row>
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
              <b-overlay :show="loading">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                  <b-row>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                      <ValidationProvider name="Demand No" vid="demand_no" v-slot="{ errors }" rules="required">
                        <b-form-group
                          label-for="alert_percentage">
                          <template v-slot:label>
                          Indent No <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          id="demand_no"
                          v-model="formData.demand_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                          {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                      <ValidationProvider name="Item Name" vid="item_name" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="item_name">
                          <template v-slot:label>
                           Item <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="item_name"
                            v-model="formData.item_name"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                     <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                        <ValidationProvider name="Date" vid="date" rules="required" v-slot="{ errors }">
                          <b-form-group
                            label-for="date"
                          >
                            <template v-slot:label>
                              {{ $t('globalTrans.date') }}  <span class="text-danger">*</span>
                            </template>
                            <date-picker
                              id="date"
                              class="form-control"
                              v-model="formData.date"
                              :placeholder="$t('globalTrans.select')"
                              :config="config"
                            >
                            </date-picker>
                            <div class="invalid-feedback d-block">
                                {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                      <ValidationProvider name="NUmber Of Quantity" vid="quantity" v-slot="{ errors }">
                        <b-form-group
                          label-for="quantity">
                          <template v-slot:label>
                          Number Of Quantity
                          </template>
                          <b-form-input
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          id="quantity"
                          v-model="formData.quantity"
                          :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                          {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <div style="border-top:1px solid"></div>
                    <b-row>
                      <b-col xs="12" sm="12" md="6" lg="6" xl="6" class="mt-3">
                        <ValidationProvider name="Specification Description" vid="s_description">
                          <b-form-group
                            label-for="s_description">
                            <template v-slot:label>
                              Specification Description <span class="text-danger">*</span>
                            </template>
                            <b-form-textarea
                              id="s_description"
                              v-model="formDataAddMore.s_description"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-textarea>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="6" lg="6" xl="6" class="mt-3">
                        <ValidationProvider name="Specification Specified" vid="s_specified">
                          <b-form-group
                            label-for="s_specified">
                            <template v-slot:label>
                              Specification Specified <span class="text-danger" v-if="formDataAddMore.has_child !== 1">*</span>
                            </template>
                            <b-form-textarea
                              id="s_specified"
                              v-model="formDataAddMore.s_specified"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :disabled="formDataAddMore.has_child === 1"
                            ></b-form-textarea>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                    </b-row>
                    <b-row>
                       <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                        <ValidationProvider name="Has Child" vid="has_child">
                          <b-form-group
                            class
                            label-for="has_child"
                          >
                          <b-form-checkbox
                              id="checkbox-1"
                              v-model.number="formDataAddMore.has_child"
                              name="checkbox-1"
                              value="1"
                              unchecked-value="0"
                            >
                             Has Sub-Head
                            </b-form-checkbox>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                       <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                        <ValidationProvider name="Has Blank Row" vid="has_blank_row">
                          <b-form-group
                            class
                            label-for="has_blank_row"
                          >
                          <b-form-checkbox
                              id="checkbox-2"
                              v-model.number="formDataAddMore.has_blank_row"
                              name="checkbox-2"
                              value="1"
                              unchecked-value="0"
                            >
                             Has Any Head
                            </b-form-checkbox>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                       <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="formDataAddMore.has_blank_row === 1">
                        <ValidationProvider name="Bank Row Text" vid="blank_row_text">
                          <b-form-group
                            label-for="blank_row_text">
                            <template v-slot:label>
                              Head Name <span class="text-danger">*</span>
                            </template>
                            <b-form-textarea
                              id="s_description"
                              v-model="formDataAddMore.blank_row_text"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-textarea>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                    </b-row>
                    <!-- -----------------Add More  Child Section Start------------------- -->
                    <b-row v-if="formDataAddMore.has_child === 1">
                      <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                          <b-thead>
                            <tr>
                              <b-th class="text-center">SL NO</b-th>
                              <b-th class="text-center">Specification Description</b-th>
                              <b-th class="text-center">Specification Specified</b-th>
                              <b-th class="text-center">Action</b-th>
                            </tr>
                          </b-thead>
                          <b-tbody>
                            <template v-if="formDataAddMore.childs.length">
                                <b-tr v-for="(item, index) in formDataAddMore.childs" :key="index">
                                    <b-td class="text-center">{{ index+1 }}</b-td>
                                    <b-td>
                                      <ValidationProvider name="Specification Description" vid="s_description">
                                        <b-form-group
                                          label-for="s_description">
                                          <b-form-textarea
                                            id="s_description"
                                            v-model="item.s_description"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-textarea>
                                          <div class="invalid-feedback">
                                          {{ errors[0] }}
                                          </div>
                                        </b-form-group>
                                      </ValidationProvider>
                                    </b-td>
                                     <b-td>
                                      <ValidationProvider name="Specification Specified" vid="s_specified">
                                        <b-form-group
                                          label-for="s_specified">
                                          <b-form-textarea
                                            id="s_specified"
                                            v-model="item.s_specified"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-textarea>
                                          <div class="invalid-feedback">
                                          {{ errors[0] }}
                                          </div>
                                        </b-form-group>
                                      </ValidationProvider>
                                    </b-td>
                                    <td class="text-center">
                                      <b-button variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="removeChildSecoundItem(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                    </td>
                                </b-tr>
                            </template>
                            <template v-else>
                              <b-tr>
                                <b-td colspan="4" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                              </b-tr>
                            </template>
                          </b-tbody>
                          <b-tfoot>
                            <b-tr>
                                <b-td colspan="4" align="center">
                                  <b-button @click="addChildItem()" type="button" variant="success" class="mr-2 mb-2 btn-sm">
                                    + Add More Child
                                  </b-button>
                                </b-td>
                              </b-tr>
                          </b-tfoot>
                        </table>
                      </div>
                    </b-row>
                    <b-row>
                      <b-col xs="12" sm="12" md="2" lg="2" xl="2">
                        <b-button @click="addItem()" type="button" variant="success" class="mr-2 mb-2 btn-sm" style="font-size:12px">
                          + Add More
                        </b-button>
                      </b-col>
                    </b-row>
                    <!-- -----------------Add More Child End--------------------- -->
                    <!-- -----------------Add More parent Section Start------------------- -->
                    <b-card>
                      <b-row>
                        <div class="table-wrapper table-responsive">
                          <table class="table table-striped table-hover table-bordered">
                            <b-thead>
                              <tr>
                                <b-th class="text-center">SL NO</b-th>
                                <b-th class="text-center">Specification Description</b-th>
                                <b-th class="text-center">Specification Specified</b-th>
                                <b-th class="text-center">Action</b-th>
                              </tr>
                            </b-thead>
                            <b-tbody>
                              <template v-if="formData.specifications">
                                  <template v-for="(item, index) in formData.specifications">
                                    <b-tr :key="'p-' + index">
                                      <b-td class="text-center">{{ index+1 }}</b-td>
                                      <b-td class="text-left">{{ item.s_description }}</b-td>
                                      <b-td class="text-left">{{ item.s_specified }}</b-td>
                                      <td class="text-center">
                                        <b-button variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="removeItem(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                      </td>
                                    </b-tr>
                                    <template v-if="item.childs">
                                      <template v-for="(childItem, childIndex) in item.childs">
                                        <b-tr :key="'p-' + index+'-ch-'+ childIndex">
                                          <b-td v-if="childIndex === 0" class="text-center" :rowspan="item.childs.length"></b-td>
                                          <b-td class="text-left">{{ childIndex+1 }} ) {{ childItem.s_description }}</b-td>
                                          <b-td class="text-left">{{ childItem.s_specified }}</b-td>
                                          <td class="text-center">
                                            <b-button variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="removeChildItem(index, childIndex)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                          </td>
                                        </b-tr>
                                      </template>
                                    </template>
                                    <b-tr v-if="item.has_blank_row" :key="'p-black-row-' + index">
                                      <b-td colspan="4" class="text-center">{{ item.blank_row_text }}</b-td>
                                    </b-tr>
                                  </template>
                              </template>
                              <template v-else>
                                <b-tr>
                                  <b-td colspan="4" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                                </b-tr>
                              </template>
                            </b-tbody>
                          </table>
                        </div>
                      </b-row>
                    </b-card>
                    <!-- -----------------Add More Parent End--------------------- -->
                    <b-row class="text-right mb-3">
                      <b-col>
                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                      </b-col>
                  </b-row>
                </b-form>
              </b-overlay>
            </ValidationObserver>
          </b-row>
        </b-container>
      </card>
      <pre>{{ formData.specification_details }}</pre>
    </div>
</template>
<script>
import RestApi, { InspectionServiceBaseUrl } from '@/config/api_config'
import { specificationStore, specificationUpdate } from '../../api/routes'

export default {
  components: {
  },
  name: 'Form',
  props: ['id'],
  data () {
    return {
        valid: null,
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        loading: false,
        formData: {
          item_name: '',
          demand_no: '',
          date: '',
          quantity: '',
          specifications: []
        },
        formDataAddMore: {
          s_description: '',
          s_specified: '',
          has_child: 0,
          has_blank_row: 0,
          blank_row_text: '',
          childs: []
        },
        formDataChildAddMore: {
          s_description: '',
          s_specified: ''
        },
        config: { static: true }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getSpecificationEditInfo()
      this.formData = tmp
    }
  },
  mounted () {
  },
  computed: {
  },
  watch: {
    'formDataAddMore.has_child': function (newVal) {
      if (newVal) {
        this.formDataAddMore.s_specified = ''
        this.formDataAddMore.childs.push({
          s_description: '',
          s_specified: ''
        })
      }
    }
  },
  methods: {
    addChildItem () {
      if (this.formDataAddMore.childs.length > 0) {
        this.formDataAddMore.childs.push({
          s_description: '',
          s_specified: ''
        })
      }
    },
    async addItem () {
      if (this.formDataAddMore.s_description && ((!this.formDataAddMore.s_specified && this.formDataAddMore.has_child) || (this.formDataAddMore.s_specified && !this.formDataAddMore.has_child))) {
      const objExist = this.formData.specifications.find(detail => detail.s_description === this.formDataAddMore.s_description && detail.s_specified === this.formDataAddMore.s_specified)
        if (typeof objExist === 'undefined') {
          this.formData.specifications.push(this.formDataAddMore)
        } else {
          this.$toast.error({
            title: 'Data has already been added',
            color: '#D6E09B'
          })
        }
        this.formDataAddMore = {
          s_description: '',
          s_specified: '',
          has_child: 0,
          has_blank_row: 0,
          blank_row_text: '',
          childs: []
        }
        this.$refs.form.reset()
      }
    },
    removeItem (index) {
      this.formData.specifications.splice(index, 1)
    },
    removeChildSecoundItem (index) {
      this.formDataAddMore.childs.splice(index, 1)
    },
    updateParent (data) {
      this.center = data
    },
    getSpecificationEditInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(InspectionServiceBaseUrl, `${specificationUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(InspectionServiceBaseUrl, specificationStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
      this.loading = false
    },
    removeChildItem (index, childIndex) {
      this.formData.specifications[index].childs.splice(childIndex, 1)
    }
  }
}
</script>
