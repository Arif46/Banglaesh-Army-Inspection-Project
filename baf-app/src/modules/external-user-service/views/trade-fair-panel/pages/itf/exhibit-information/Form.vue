<template>
    <card>
        <template v-slot:searchHeaderTitle>
            <h4 class="card-title">{{ $t('externalTradeFair.exhibit_information') }} {{ $t('globalTrans.entry') }}</h4>
        </template>
        <template v-slot:searchHeaderAction>
          <router-link v-if="$route.query.id" href="javascript:" to="exhibit-information" class="btn-add">{{ $t('externalTradeFair.exhibit_information') }} {{ $t('globalTrans.list') }}</router-link>
          <router-link v-else href="javascript:" to="exhibition-circular-list" class="btn-add">{{ $t('externalTradeFair.circular_exhibition') }} {{ $t('globalTrans.list') }}</router-link>
        </template>
        <template v-slot:searchBody>
            <b-row>
              <b-col v-if="!isParticipated">
                <h5 class="text-center py-3 my-5" v-if="loader">{{$t('globalTrans.loading') + ' ' }}...</h5>
                <h5 class="m-auto text-center w-50 text-danger px-3 py-3 rounded my-5" v-else>
                  <span>{{$t('externalTradeFair.ceck_label')}}</span>
                </h5>
              </b-col>
              <b-col v-else lg="12" sm="12">
                  <b-overlay v-if="already_applied">
                    <h5 class="m-auto text-center w-50 text-danger px-3 py-3 rounded my-5">
                      <span>{{$t('externalTradeFair.already_applied') + ' ' }}...</span>
                    </h5>
                  </b-overlay>
                  <b-overlay v-else :show="loader">
                        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                          <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                            <b-row>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="fiscal_year_id"
                                  >
                                    <template v-slot:label>
                                      {{ $t('tradeFairConfig.fiscal_year') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                      disabled
                                      plain
                                      id="fiscal_year_id"
                                      :options="fiscalYearList"
                                      v-model="data.fiscal_year_id"
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
                                <ValidationProvider vid="circular_memo_no" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="circular_memo_no"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.circular_memo_no') }}
                                    </template>
                                    <b-form-input
                                      disabled
                                      id="circular_memo_no"
                                      v-model="circular_memo_no"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="subject"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.subject') }}
                                    </template>
                                    <b-form-input
                                      disabled
                                      id="subject"
                                      v-model="subject"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
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
                                  <h6 style="" class="text-sm-center">{{ $t('externalTradeFair.add_exhibition_info') }}</h6>
                                </template>
                              </b-col>
                            </b-row>
                            <b-row>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Description of Exhibition (En)" vid="exhibit_desc_en" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="exhibit_desc_en"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.description_exhibition') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="exhibit_desc_en"
                                      v-model="detailsFormData.exhibit_desc_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Description of Exhibition (Bn)" vid="exhibit_desc_bn" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="exhibit_desc_bn"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.description_exhibition') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="exhibit_desc_bn"
                                      v-model="detailsFormData.exhibit_desc_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="H.S Code No" vid="hs_code" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="hs_code"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.hs_code_no') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="hs_code"
                                      v-model="detailsFormData.hs_code"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Quantity" vid="quantity" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="quantity"
                                  >
                                    <template v-slot:label>
                                      {{ $t('globalTrans.quantity') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="quantity"
                                      v-model="detailsFormData.quantity"
                                      @input="totalValue()"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Unit Price in US$" vid="unit_price" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="unit_price"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.unit_price_us') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="unit_price"
                                      v-model="detailsFormData.unit_price"
                                      @input="totalValue()"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Total Value in US$" vid="total_price" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="total_price"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.total_value_us') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="total_price"
                                      v-model="detailsFormData.total_price"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Exporter Name (En)" vid="exporter_name_en" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="exporter_name_en"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.exporter') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="exporter_name_en"
                                      v-model="detailsFormData.exporter_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Exporter Name (Bn)" vid="exporter_name_bn" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-cols-sm="4"
                                    label-for="exporter_name_bn"
                                  >
                                    <template v-slot:label>
                                      {{ $t('externalTradeFair.exporter') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="exporter_name_bn"
                                      v-model="detailsFormData.exporter_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6"></b-col>
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
                            <th style="width:25%">{{ $t('externalTradeFair.description_exhibition') }}</th>
                            <th style="width:10%">{{ $t('externalTradeFair.hs_code_no') }}</th>
                            <th style="width:10%">{{ $t('globalTrans.quantity') }}</th>
                            <th style="width:10%">{{ $t('externalTradeFair.unit_price_us') }}</th>
                            <th style="width:10%">{{ $t('externalTradeFair.total_value_us') }}</th>
                            <th style="width:20%">{{ $t('externalTradeFair.exporter_name') }}</th>
                            <th style="width:8%">{{ $t('globalTrans.action') }}</th>
                          </tr>
                        </thead>
                        <b-tbody>
                            <b-tr v-for="(item, index) in data.details" :key="index">
                                <b-td>
                                    {{ $n(index + 1) }}
                                </b-td>
                                <b-td>
                                  {{ (currentLocale == 'bn' ? item.exhibit_desc_bn : item.exhibit_desc_en) }}
                                </b-td>
                                <b-td>
                                  {{ $n(item.hs_code) }}
                                </b-td>
                                <b-td>
                                  {{ $n(item.quantity) }}
                                </b-td>
                                <b-td>
                                  {{ $n(item.unit_price) }}
                                </b-td>
                                <b-td>
                                  {{ $n(item.total_price) }}
                                </b-td>
                                <b-td>
                                  {{ (currentLocale == 'bn' ? item.exporter_name_bn : item.exporter_name_en) }}
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
                        <b-row>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="Remark (En)" v-slot="{ errors }">
                              <b-form-group
                                label-cols-sm="4"
                                label-for="remarks_en"
                              >
                                <template v-slot:label>
                                  {{ $t('globalTrans.remark') }} {{ $t('globalTrans.en') }}
                                </template>
                                <b-form-input
                                  id="remarks_en"
                                  v-model="data.remarks_en"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                  {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="Remark (Bn)" vid="remarks_bn" v-slot="{ errors }">
                              <b-form-group
                                label-cols-sm="4"
                                label-for="remarks_bn"
                              >
                                <template v-slot:label>
                                  {{ $t('globalTrans.remark') }} {{ $t('globalTrans.bn') }}
                                </template>
                                <b-form-input
                                  id="remarks_bn"
                                  v-model="data.remarks_bn"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                  {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="attachment" v-slot="{ errors }">
                              <b-form-group
                                class="row"
                                label-cols-sm="4"
                                label-for="attachment"
                              >
                              <template v-slot:label>
                                {{ $t('globalTrans.attachment') }}
                              </template>
                              <b-input-group>
                                <b-form-file
                                  validate="size:10"
                                  id="attachment"
                                  v-model="attachment_input"
                                  @change="onChange"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  placeholder="Choose a file or drop it here"
                                  drop-placeholder="Drop file here..."
                                ></b-form-file>
                              </b-input-group>
                              <!-- <div v-if="data.logo">
                                <img :src="rjscServiceBaseUrl + 'storage/' + form.logo" style="width: 40px; height: 40px; border-radius: 50% !important;" class="center">
                              </div> -->
                              <div class="d-block invalid-feedback">
                                {{ fileValidationMsz }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <span v-if="data?.attachment">
                              <a target="_blank" :href="baseUrl + 'storage/' + data?.attachment" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                            </span>
                          </b-col>
                        </b-row>
                      <b-row class="text-right">
                        <b-col>
                          <b-button type="button" @click="saveUpdate(1)" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
                          <b-button type="button" @click="saveUpdate(2)" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.finalSave') }}</b-button>
                          <!-- <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button> -->
                          <router-link v-if="$route.query.id" class="btn-sm btn btn-danger" to="/trade-fair-panel/exhibit-information">{{ $t('globalTrans.cancel') }}</router-link>
                          <router-link v-else class="btn-sm btn btn-danger" to="/trade-fair-panel/exhibition-circular-list">{{ $t('globalTrans.cancel') }}</router-link>
                        </b-col>
                      </b-row>
                  </b-overlay>
              </b-col>
            </b-row>
        </template>
    </card>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { exhibitionInfoStore, exhibitionInfoUpdate, checkApplicationList, exhibitionInfoShow } from '../../../api/routes'

export default {
  name: 'Form',
  props: [],
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loader: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      fileValidationMsz: '',
      editIndex: '',
      subject: '',
      circular_memo_no: '',
      stall_cat_id: 0,
      isParticipated: false,
      already_applied: false,
      data: {
        exb_circular_id: this.$route.query.exb_circular_id,
        participation_id: 0,
        fiscal_year_id: 0,
        remarks_en: '',
        remarks_bn: '',
        flag: 0,
        attachment: '',
        details: []
      },
      circular: [],
      detailsFormData: {
        exporter_name_en: '',
        exporter_name_bn: '',
        exhibit_desc_en: '',
        exhibit_desc_bn: '',
        hs_code: '',
        quantity: '',
        unit_price: '',
        total_price: ''
      },
      attachment_input: [],
      fairNameList: [],
      stallCategoryList: [],
      locationIndex: ''
    }
  },
  created () {
    window.scrollTo(0, 0)
    if (this.$route.query.id) {
      this.getStallInfo()
      const tmp = this.getEditData()
      this.subject = this.$i18n.locale === 'en' ? tmp.subject_en : tmp.subject_bn
      this.circular_memo_no = tmp.circular_memo_no
      this.data.fiscal_year_id = tmp.fiscal_year_id
      this.data.attachment = tmp.attachment
    } else {
      if (this.$route.query.exb_circular_id) {
        this.getCheck()
      }
    }
  },
  mounted () {
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
    },
    currentLocale: function (newVal, oldVal) {
      if (this.search.fiscal_year_id) {
        this.fairNameList = this.getFairNameList()
      }
    }
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
      return this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.filter(el => el.status === 1)
    }
  },
  methods: {
    totalValue () {
      let totalPrice = 0
      const PC = this.detailsFormData.unit_price ? parseFloat(this.detailsFormData.unit_price) : 0
      const Qty = this.detailsFormData.quantity ? parseInt(this.detailsFormData.quantity) : 0
      totalPrice = PC * Qty
      this.detailsFormData = Object.assign({}, this.detailsFormData, { total_price: totalPrice })
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
      const dataMeasurementUnit = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_bn : ''
      } else {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_en : ''
      }
    },
    getFairNameList (Id) {
      return this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.filter(item => item.fiscal_year_id === Id)
    },
    getStallType (id) {
      const dataStallType = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    IdGenerateHelper (data) {
        const countryId = data.country_id
        const fiscalId = data.fiscal_year_id
        const appliedSectorId = data.applied_sector_id
        const tmpSector = this.$store.state.ExternalUserService.tradeFair.commonObj.fairSectorList.find(el => el.value === parseInt(appliedSectorId))
        const tmpFis = this.$store.state.CommonService.commonObj.fiscalYearList.find(el => el.value === parseInt(fiscalId))
        const tmpCountr = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === parseInt(countryId))
        this.data.sector_letter = tmpSector.text_en.substring(0, 3)
        this.data.country_letter = tmpCountr.text_en.substring(0, 3)
        this.data.fiscal_year = tmpFis.text_en
    },
    async getCheck () {
      this.loader = true
      const params = {
        exb_circular_id: this.$route.query.exb_circular_id
      }
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, checkApplicationList, params)
      this.loader = false
      if (result.success) {
        this.circular = result.circular
        this.subject = this.$i18n.locale === 'en' ? this.circular.subject_en : this.circular.subject_bn
        this.circular_memo_no = result.circular.circular_memo_no
        this.data.fiscal_year_id = this.circular.fiscal_year_id
        this.isParticipated = true
        this.already_applied = result.already_applied
        this.data.participation_id = result.data.id
        this.IdGenerateHelper(result.data)
      } else {
        this.isParticipated = false
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
      const hscodeId = this.detailsFormData.hs_code
      const newData = result.find(item => item.hs_code === hscodeId)
      if (typeof newData === 'undefined') {
        if (this.editIndex !== '') {
          this.data.details[parseInt(this.editIndex)].exporter_name_en = this.detailsFormData.exporter_name_en
          this.data.details[parseInt(this.editIndex)].exporter_name_bn = this.detailsFormData.exporter_name_bn
          this.data.details[parseInt(this.editIndex)].exhibit_desc_en = this.detailsFormData.exhibit_desc_en
          this.data.details[parseInt(this.editIndex)].exhibit_desc_bn = this.detailsFormData.exhibit_desc_bn
          this.data.details[parseInt(this.editIndex)].hs_code = this.detailsFormData.hs_code
          this.data.details[parseInt(this.editIndex)].quantity = this.detailsFormData.quantity
          this.data.details[parseInt(this.editIndex)].unit_price = this.detailsFormData.unit_price
          this.data.details[parseInt(this.editIndex)].total_price = this.detailsFormData.total_price
        } else {
          this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
        }
        this.detailsFormData = {
          exporter_name_en: '',
          exporter_name_bn: '',
          exhibit_desc_en: '',
          exhibit_desc_bn: '',
          hs_code: '',
          quantity: '',
          unit_price: '',
          total_price: ''
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
    onChange (e) {
      this.fileValidationMsz = ''
      const input = e.target
      const file = input.files[0]
      if (file.size > 1024 * 2048) {
        e.preventDefault()
        this.fileValidationMsz = 'Maximum file size must be 2MB'
      }
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.data.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.data.attachment = ''
      }
    },
    async saveUpdate (status = 0) {
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
        this.data.flag = status
        const loadingState = { loading: false, listReload: false }
        if (this.$route.query.id) {
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${exhibitionInfoUpdate}/${this.$route.query.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, exhibitionInfoStore, this.data)
        }
        this.loader = false
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        if (result.success) {
          this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$router.push({ path: '/trade-fair-panel/exhibit-information' })
          } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    },
    async getStallInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, exhibitionInfoShow + '/' + this.$route.query.id)
      const tmpData = resultData.data
      this.isParticipated = true
      const detailsData = tmpData.details.map(item => {
        return {
          exporter_name_en: item.exporter_name_en, exporter_name_bn: item.exporter_name_bn, exhibit_desc_en: item.exhibit_desc_en, exhibit_desc_bn: item.exhibit_desc_bn, hs_code: item.hs_code, quantity: item.quantity, unit_price: item.unit_price, total_price: item.total_price
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    },
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.query.id))
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
