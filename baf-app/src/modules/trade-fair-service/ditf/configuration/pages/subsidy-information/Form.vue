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
                    <b-col style="background-color: var(--gray-eee);" lg="6" class="offset-lg-3 p-2">
                      <template>
                        <h6 style="font-weight: bold;" class="text-sm-center">{{ $t('tradeFairConfig.subsidy_info_details') }}</h6>
                      </template>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Fair Sector" vid="fair_sector_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="fair_sector_id"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.fair_sector') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="fair_sector_id"
                            v-model="detailsFormData.fair_sector_id"
                            :options="fairSectorList"
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
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Subsidy Category" vid="subsidy_cat_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="subsidy_cat_id"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.subsidy_category') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="subsidy_cat_id"
                            :options="subsidyCategoryList"
                            v-model="detailsFormData.subsidy_cat_id"
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
                      <ValidationProvider name="Measurement Unit" vid="measurement_id" rules="required|min_value:1" v-slot="{ errors }">
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
                            :options="measurementUnitList"
                            v-model="detailsFormData.measurement_id"
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
                      <ValidationProvider name="Range (En)" vid="range_en" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="range_en">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.range') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="range_en"
                            v-model="detailsFormData.range_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Range (Bn)" vid="range_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="range_bn">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.range') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="range_bn"
                            v-model="detailsFormData.range_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Export Range From" vid="export_range_from" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="export_range_from"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.export_range_from') }}<span class="text-danger">*</span>
                            <b-form-checkbox
                              :id="'checkbox-1'"
                              v-model="detailsFormData.range_status"
                              :name="'checkbox-1'"
                              :value=1
                              :unchecked-value=0
                          >
                          <span>{{ $i18n.locale === 'en' ? 'Above from' : 'এর উপরে' }}</span>
                          </b-form-checkbox>
                          </template>
                          <b-form-input
                            id="export_range_from"
                            v-model="detailsFormData.export_range_from"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col v-if="detailsFormData.range_status !== 1" xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Export Range To" vid="export_range_to" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="export_range_to"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.export_range_to') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="export_range_to"
                            v-model="detailsFormData.export_range_to"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Subsidy" vid="subsidy" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="subsidy"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.subsidy') }} {{'( % )'}} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="subsidy"
                            v-model="detailsFormData.subsidy"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
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
                  <th style="width:6%">{{ $t('globalTrans.sl_no') }}</th>
                  <!-- <th style="width:10%">{{ $t('tradeFairConfig.subsidy_type') }}</th> -->
                  <th style="width:18%">{{ $t('tradeFairConfig.fair_sector') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.subsidy_category') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.measurement_unit') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.range') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.export_range_from') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.export_range_to') }}</th>
                  <th style="width:12%">{{ $t('tradeFairConfig.subsidy') }} {{'( % )'}} </th>
                  <th style="width:8%">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                  <b-tr v-for="(item, index) in data.details" :key="index">
                      <b-td>
                        {{ $n(index + 1) }}
                      </b-td>
                      <!-- <b-td>
                        {{subsidy_type}}{{ item.subsidy_type }}
                      </b-td> -->
                      <b-td>
                        {{ getFairSectorName(item.fair_sector_id) }}
                      </b-td>
                      <b-td>
                        {{ getSubsidyCatName(item.subsidy_cat_id) }}
                      </b-td>
                      <b-td>
                        {{ getMeasurementUnitName(item.measurement_id) }}
                      </b-td>
                      <b-td>
                        {{ currentLocale == 'bn' ? item.range_bn : item.range_en }}
                      </b-td>
                      <b-td>
                        {{ $n(item.export_range_from) }}
                      </b-td>
                      <b-td>
                         {{ item.range_status == 1 ? ($i18n.locale === 'en' ? 'Above of ' +  $n(item.export_range_from) : $n(item.export_range_from) + ' এর উপরে') : $n(item.export_range_to) }}
                      </b-td>
                      <b-td>
                        {{ $n(item.subsidy) }}
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
import { subsidyInformationStore, subsidyInformationUpdate, subsidyInformationShow } from '../../api/routes'

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
      fair_sector_id: 0,
      flag_status: 1,
      data: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        details: []
      },
      detailsFormData: {
        range_status: 0,
        // subsidy_type: 0,
        fair_sector_id: 0,
        subsidy_cat_id: 0,
        measurement_id: 0,
        range_en: '',
        range_bn: '',
        export_range_from: '',
        export_range_to: '',
        subsidy: ''
      },
      locationIndex: '',
      fairNameList: [],
      fairSectorList: []
    }
  },
  created () {
    if (this.id) {
      this.getSubsidyInfo()
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
        this.fairSectorList = this.getFairSectorList(newVal)
      }
    },
    'detailsFormData.range_status': function (newVal, oldVal) {
      if (newVal) {
        this.detailsFormData.export_range_to = 0
      }
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  computed: {
    // typeOfFair () {
    //   return this.$store.state.TradeFairService.commonObj.fairNameList
    // },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    },
    measurementUnitList () {
      return this.$store.state.TradeFairService.commonObj.measurementUnitList.filter(el => el.status === 1).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    subsidyCategoryList () {
      return this.$store.state.TradeFairService.commonObj.subsidyCategoryList
    }

  },
  methods: {
    getFiscalYear (id) {
      const fiscalyear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      this.minDate = fiscalyear.start_date
      this.maxDate = fiscalyear.end_date
    },
    getFairSectorName (Id) {
      const obj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(Id))
      if (typeof obj !== 'undefined') {
        return this.$i18n.locale === 'en' ? obj.text_en : obj.text_bn
      } else {
        return ''
      }
    },
    getFairName (Id) {
      const obj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(Id))
      if (typeof obj !== 'undefined') {
        return this.$i18n.locale === 'en' ? obj.text_en : obj.text_bn
      } else {
        return ''
      }
    },
    getFairNameList (Id) {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === Id)
    },
    getSubsidyCatName (id) {
      const dataSubsidyCategory = this.$store.state.TradeFairService.commonObj.subsidyCategoryList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataSubsidyCategory !== undefined ? dataSubsidyCategory.text_bn : ''
      } else {
        return dataSubsidyCategory !== undefined ? dataSubsidyCategory.text_en : ''
      }
    },
    getMeasurementUnitName (id) {
      const dataMeasurement = this.$store.state.TradeFairService.commonObj.measurementUnitList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataMeasurement !== undefined ? dataMeasurement.text_bn : ''
      } else {
        return dataMeasurement !== undefined ? dataMeasurement.text_en : ''
      }
    },
    getFairSectorList (id) {
       const fairObj = this.$store.state.TradeFairService.commonObj.fairNameList.find(el => el.value === parseInt(id))
        if (typeof fairObj !== 'undefined') {
          return this.$store.state.TradeFairService.commonObj.fairSectorList.filter(item => item.status === 1 && (item.value === fairObj.fair_sector_id || item.text_en === 'Others'))
        } else {
          return []
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
      const subsidyCatId = this.detailsFormData.subsidy_cat_id
      const measurementUnit = this.detailsFormData.measurement_id
      const rangeStatus = this.detailsFormData.range_status
      const sectorId = this.detailsFormData.fair_sector_id
      if (rangeStatus === 1) {
        const rangeValidation = result.find(item => item.range_status === rangeStatus && item.measurement_id === measurementUnit && item.fair_sector_id === sectorId)
        if (typeof rangeValidation !== 'undefined') {
            this.$toast.error({
                title: '!',
                message: 'Item already added',
                color: '#ee5253'
            })
            return
        }
      }

      const newData = result.find(item => item.subsidy_cat_id === subsidyCatId && item.measurement_id === measurementUnit && item.fair_sector_id === sectorId)
      if (typeof newData === 'undefined') {
          if (this.editIndex !== '') {
              // this.data.details[parseInt(this.editIndex)] = this.detailsFormData
              this.data.details[parseInt(this.editIndex)].measurement_id = this.detailsFormData.measurement_id
              this.data.details[parseInt(this.editIndex)].fair_sector_id = this.detailsFormData.fair_sector_id
              this.data.details[parseInt(this.editIndex)].subsidy_cat_id = this.detailsFormData.subsidy_cat_id
              this.data.details[parseInt(this.editIndex)].range_en = this.detailsFormData.range_en
              this.data.details[parseInt(this.editIndex)].range_bn = this.detailsFormData.range_bn
              this.data.details[parseInt(this.editIndex)].export_range_from = this.detailsFormData.export_range_from
              this.data.details[parseInt(this.editIndex)].range_status = this.detailsFormData.range_status
              this.data.details[parseInt(this.editIndex)].export_range_to = this.detailsFormData.export_range_to
              this.data.details[parseInt(this.editIndex)].subsidy = this.detailsFormData.subsidy
          } else {
             this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
          }
          this.detailsFormData = {
            range_status: 0,
            measurement_id: this.detailsFormData.measurement_id,
            fair_sector_id: this.detailsFormData.fair_sector_id,
            subsidy_cat_id: this.detailsFormData.subsidy_cat_id,
            range_en: '',
            range_bn: '',
            export_range_from: '',
            export_range_to: '',
            subsidy: ''
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
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${subsidyInformationUpdate}/${this.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, subsidyInformationStore, this.data)
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
    async getSubsidyInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, subsidyInformationShow + '/' + this.id)
      const tmpData = resultData.data
      const detailsData = tmpData.details.map(item => {
        return {
          measurement_id: item.measurement_id, fair_sector_id: item.fair_sector_id, subsidy_cat_id: item.subsidy_cat_id, range_en: item.range_en, range_bn: item.range_bn, export_range_from: item.export_range_from, range_status: item.range_status, export_range_to: item.export_range_to, subsidy: item.subsidy
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    }
  }
}
</script>
