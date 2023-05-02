<template>
  <b-row>
     <b-col lg="12" sm="12">
         <b-overlay :show="loader">
              <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="fiscal_year_id"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.fiscal_year') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="fiscal_year_id"
                            :options="fiscalYearList"
                            v-model="data.fiscal_year_id"
                            @input="getFiscalYear(data.fiscal_year_id)"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Fair Name" vid="fair_name_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="fair_name_id"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.fair_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="fair_name_id"
                            :options="fairNameList"
                            v-model="data.fair_name_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                </b-form>
              </ValidationObserver>
              <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(addItem)" @reset.prevent="reset" autocomplete="off">
                  <b-row class="p-4">
                    <b-col style="background-color: var(--gray-ddd);" lg="6" class="offset-lg-3 p-2">
                      <template>
                        <h6 style="" class="text-sm-center">{{ $t('tradeFairConfig.stall_info_details') }}</h6>
                      </template>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Cat Name" vid="stall_cat_id" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="stall_cat_id"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.stall_cat_name') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="stall_cat_id"
                            v-model="detailsFormData.stall_cat_id"
                            :options="stallCategoryList"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Size" vid="stall_size" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="stall_size"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.stall_size') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="stall_size"
                            v-model="detailsFormData.stall_size"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                       <ValidationProvider name="Measurement Unit Name" vid="measurement_id" rules="required" v-slot="{ errors }">
                         <b-form-group
                           label-cols-sm="5"
                           label-for="measurement_id"
                          >
                           <template v-slot:label>
                             {{ $t('tradeFairConfig.measurement_unit') }} <span class="text-danger">*</span>
                           </template>
                           <b-form-select
                            plain
                            id="measurement_id"
                            v-model="detailsFormData.measurement_id"
                            :options="measurementUnitList"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                           <div class="invalid-feedback">
                             {{ errors[0] }}
                           </div>
                         </b-form-group>
                       </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Type" vid="stall_type" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="stall_type"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.stall_type') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="stall_type"
                            :options="stallTypeList"
                            v-model="detailsFormData.stall_type"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Booth Rent" vid="booth_rent" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="booth_rent"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.booth_rent') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="booth_rent"
                            v-model="detailsFormData.booth_rent"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6"></b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Description (En)" vid="description_en" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="description_en"
                        >
                          <template v-slot:label>
                            {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-textarea
                            id="description_en"
                            v-model="detailsFormData.description_en"
                            rows="3"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-textarea>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Description (Bn)" vid="description_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="description_bn"
                        >
                          <template v-slot:label>
                            {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-textarea
                            id="description_bn"
                            v-model="detailsFormData.description_bn"
                            rows="3"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-textarea>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col>
                        <div class="text-right mb-2">
                            <b-button type="button" v-if="editIndex !== ''" variant="danger" class="mr-1 btn-sm" @click="cancelItem()">{{ $t('globalTrans.cancel') }}</b-button>
                            <b-button type="submit" class="btn-sm" variant="success">{{ editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
                        </div>
                    </b-col>
                  </b-row>
                </b-form>
              </ValidationObserver>
              <br/>
            <!-- List  -->
            <b-table-simple bordered>
              <thead>
                <tr class="bg-primary">
                  <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.stall_size') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.measurement_unit_name') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.stall_type') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.booth_rent') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.description') }}</th>
                  <th style="width:10%">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                  <b-tr v-for="(item, index) in data.details" :key="index">
                      <b-td>
                          {{ $n(index + 1) }}
                      </b-td>
                      <b-td>
                        {{ getStallCategory(item.stall_cat_id) }}
                      </b-td>
                      <b-td>
                        {{ $n(item.stall_size) }}
                      </b-td>
                      <b-td>
                       {{ getMeasurementUnit(item.measurement_id) }}
                     </b-td>
                      <b-td>
                        {{ getStallType(item.stall_type) }}
                      </b-td>
                      <b-td>
                        {{ $n(item.booth_rent) }}
                      </b-td>
                      <b-td>
                        {{ currentLocale == 'bn' ? item.description_bn : item.description_en }}
                      </b-td>
                      <b-td>
                        <span class="d-flex text-center">
                          <b-button @click="editItem(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                          <b-button type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button>
                        </span>
                      </b-td>
                  </b-tr>
                  <b-tr v-if="data.details.length <= 0">
                      <td colspan="8" class="text-center">
                          <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                      </td>
                  </b-tr>
              </b-tbody>
            </b-table-simple>
            <b-row class="text-right">
              <b-col>
                <!-- <b-button type="button" @click="saveUpdate" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button> -->
                <b-button type="button" @click="saveUpdate()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
                <b-button type="button" @click="finalSave()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.finalSave') }}</b-button>
                <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
        </b-overlay>
    </b-col>
  </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { stallInformationStore, stallInformationUpdate, stallInformationShow, getStallCatByFairApi } from '../../api/routes'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      loader: false,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      editIndex: '',
      flag_status: 1,
      stall_cat_id: 0,
      data: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        details: []
      },
      detailsFormData: {
        stall_cat_id: 0,
        measurement_id: 0,
        stall_size: '',
        stall_type: 0,
        booth_rent: '',
        description_en: '',
        description_bn: ''
      },
      fairNameList: [],
      stallCategoryList: [],
      locationIndex: ''
    }
  },
  created () {
    if (this.id) {
      this.getStallInfo()
      // this.data = tmp
    }
  },
  watch: {
    'data.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList(newVal)
      }
    },
    'data.fair_name_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getStallCategoryList(newVal)
      }
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    stallTypeList () {
      return this.$store.state.TradeFairService.commonObj.stallTypeList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    measurementUnitList () {
      return this.$store.state.TradeFairService.commonObj.measurementUnitList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    }
  },
  methods: {
    getFiscalYear (id) {
      const fiscalyear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      this.minDate = fiscalyear.start_date
      this.maxDate = fiscalyear.end_date
    },
    getStallCategory (id) {
      const dataStallCategory = this.stallCategoryList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallCategory !== undefined ? dataStallCategory.text_bn : ''
      } else {
        return dataStallCategory !== undefined ? dataStallCategory.text_en : ''
      }
    },
    getMeasurementUnit (id) {
      const dataMeasurementUnit = this.$store.state.TradeFairService.commonObj.measurementUnitList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_bn : ''
      } else {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_en : ''
      }
    },
    getStallCategoryList (id) {
      this.loader = true
      RestApi.getData(internationalTradeFairServiceBaseUrl, getStallCatByFairApi, { fair_name_id: id }).then(response => {
        this.loader = false
        if (response.success) {
          this.stallCategoryList = response.data.map(el => {
            return Object.assign({}, el, { text: this.$i18n.locale === 'en' ? el.text_en : el.text_bn })
          })
        } else {
          this.stallCategoryList = []
        }
      })
    },
    getFairNameList (Id) {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === Id)
    },
    getStallType (id) {
      const dataStallType = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    cancelItem () {
        this.detailsFormData = {}
        this.editIndex = ''
        this.$refs.form1.reset()
    },
    editItem (item, index) {
        this.detailsFormData = Object.assign({}, item)
        this.editIndex = index
    },
    deleteItem (index) {
        this.data.details.splice(index, 1)
    },
    async addItem () {
      let result = []
      if (this.editIndex !== '') {
          const editList = [...this.data.details]
          editList.splice(parseInt(this.editIndex), 1)
          result = [...editList]
      } else {
          result = this.data.details
      }
      const stallCategoryNameId = this.detailsFormData.stall_cat_id
      const MeasurementUnitId = this.detailsFormData.measurement_id
      const stallType = this.detailsFormData.stall_type
      const newData = result.find(item => item.stall_cat_id === stallCategoryNameId && item.stall_type === stallType && item.measurement_id === MeasurementUnitId)
      if (typeof newData === 'undefined') {
          if (this.editIndex !== '') {
              // this.data.details[parseInt(this.editIndex)] = this.detailsFormData
              this.data.details[parseInt(this.editIndex)].stall_cat_id = this.detailsFormData.stall_cat_id
              this.data.details[parseInt(this.editIndex)].measurement_id = this.detailsFormData.measurement_id
              this.data.details[parseInt(this.editIndex)].stall_size = this.detailsFormData.stall_size
              this.data.details[parseInt(this.editIndex)].stall_type = this.detailsFormData.stall_type
              this.data.details[parseInt(this.editIndex)].booth_rent = this.detailsFormData.booth_rent
              this.data.details[parseInt(this.editIndex)].description_en = this.detailsFormData.description_en
              this.data.details[parseInt(this.editIndex)].description_bn = this.detailsFormData.description_bn
          } else {
             this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
          }
          this.detailsFormData = {
            stall_cat_id: this.detailsFormData.stall_cat_id,
            measurement_id: this.detailsFormData.measurement_id,
            stall_size: this.detailsFormData.stall_size,
            stall_type: 0,
            booth_rent: '',
            description_en: '',
            description_bn: ''
          }
          this.editIndex = ''
      } else {
          this.$toast.error({
              title: '!',
              message: 'Item already added',
              color: '#ee5253'
          })
      }
      // reset form
      this.$nextTick(() => {
          this.$refs.form1.reset()
      })
    },
    finalSave () {
      this.$swal({
        title: this.$t('globalTrans.final_save_msg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.flag_status = 2
          this.saveUpdate()
        }
      })
    },
    async saveUpdate () {
      var check = await this.$refs.form.validate()
      if (check) {
        if (!this.data.details.length) {
          return this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: 'Add at least one item!',
            color: 'red'
          })
        }
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        this.loader = true
        this.data.flag = this.flag_status
        const loadingState = { loading: false, listReload: false }
        if (this.id) {
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${stallInformationUpdate}/${this.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, stallInformationStore, this.data)
        }
        this.loader = false
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        if (result.success) {
          this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-form')
          } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    },
    async getStallInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallInformationShow + '/' + this.id)
      const tmpData = resultData.data
      const detailsData = tmpData.details.map(item => {
        return {
          stall_cat_id: item.stall_cat_id, measurement_id: item.measurement_id, stall_size: item.stall_size, stall_type: item.stall_type, booth_rent: item.booth_rent, description_en: item.description_en, description_bn: item.description_bn
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    }
  }
}
</script>
