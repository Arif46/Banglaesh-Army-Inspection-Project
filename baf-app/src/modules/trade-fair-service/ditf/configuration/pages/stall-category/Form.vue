<template>
  <b-row>
     <b-col lg="12" sm="12">
         <b-overlay :show="loader">
              <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                  <b-row>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Year" vid="year" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-for="year"
                        >
                          <template v-slot:label>
                            {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="year"
                            :options="yearList"
                            v-model="data.year"
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
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Fair Name" vid="fair_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-for="fair_id"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.fair_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="fair_id"
                            :options="fairTitleList"
                            v-model="data.fair_id"
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
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Circular Type" vid="circular_type" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-for="circular_type"
                        >
                          <template v-slot:label>
                            {{$t('ditfConfig.circular') + ' ' + $t('ditfConfig.type')}} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="circular_type"
                            :options="circularTypeList"
                            v-model="data.circular_type"
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
                    <b-col style="background-color: #B6D0E2;" lg="6" class="offset-lg-3 p-2">
                      <template>
                        <h6 style="" class="text-sm-center">{{ $t('tradeFairConfig.stall_info_details') }}</h6>
                      </template>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Type" vid="stall_type" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="stall_type"
                        >
                          <template v-slot:label>
                            {{$t('ditfConfig.stall_pavilion_restaurant') + ' ' + $t('ditfConfig.type')}} <span class="text-danger">*</span>
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6"></b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Cat Name (En)" vid="cat_name_en" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="cat_name">
                          <template v-slot:label>
                            {{ $t('ditfConfig.stall_pavilion_restaurant') + ' ' + $t('ditfConfig.category') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="cat_name_en"
                            v-model="detailsFormData.cat_name_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Cat Name (Bn)" vid="cat_name_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="cat_name_bn">
                          <template v-slot:label>
                            {{ $t('ditfConfig.stall_pavilion_restaurant') + ' ' + $t('ditfConfig.category') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="cat_name_bn"
                            v-model="detailsFormData.cat_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Size (En)" vid="size_en" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="size_en">
                          <template v-slot:label>
                            {{ $t('ditfConfig.size') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="size_en"
                            v-model="detailsFormData.size_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Size (Bn)" vid="size_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="size_bn">
                          <template v-slot:label>
                            {{ $t('ditfConfig.size') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="size_en"
                            v-model="detailsFormData.size_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Price Type" vid="price_type" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="price_type"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.price_type') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="price_type"
                            :options="priceTypeList"
                            v-model="detailsFormData.price_type"
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
                      <ValidationProvider name="Floor Price" vid="floor_price" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="floor_price"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.fare_floor') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="floor_price"
                            v-model="detailsFormData.floor_price"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Stall Quantity" vid="stall_qty" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="stall_qty"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.stall_qty') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="stall_qty"
                            v-model="detailsFormData.stall_qty"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Processing Fee" vid="processing_fee" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="processing_fee"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.app_porcess_fee') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="processing_fee"
                            v-model="detailsFormData.processing_fee"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Security Perc" vid="security_perc" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="security_perc"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.security_perc') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="security_perc"
                            v-model="detailsFormData.security_perc"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <!-- <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Security Fee" vid="security_fee" :rules="{required: true, regex: /^\d*\.?\d*$/}" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="security_fee"
                        >
                          <template v-slot:label>
                            {{ $t('ditfConfig.security_money') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="security_fee"
                            disabled
                            v-model="detailsFormData.security_fee"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col> -->
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
                  <th style="width:5%">{{ $t('globalTrans.sl_no') }}</th>
                  <th style="width:8%">{{ $t('tradeFairConfig.stall_type') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                  <th style="width:7%">{{ $t('ditfConfig.size') }}</th>
                  <th style="width:10%">{{ $t('ditfConfig.app_porcess_fee') }}</th>
                  <th style="width:10%">{{ $t('ditfConfig.fare_floor') }}</th>
                  <th style="width:7%">{{ $t('ditfConfig.stall_qty') }}</th>
                  <th style="width:10%">{{ $t('ditfConfig.security_perc') }}</th>
                  <!-- <th style="width:10%">{{ $t('ditfConfig.security_money') }}</th> -->
                  <th style="width:10%">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                  <b-tr v-for="(item, index) in data.details" :key="index">
                      <b-td>
                          {{ $n(index + 1) }}
                      </b-td>
                      <b-td>
                        {{ getStallType(item.stall_type) }}
                     </b-td>
                      <b-td>
                        {{ currentLocale == 'bn' ? item.cat_name_bn : item.cat_name_en }}
                      </b-td>
                      <b-td>
                        {{ currentLocale == 'bn' ? item.size_bn : item.size_en }}
                      </b-td>
                      <!-- <b-td>
                        {{ getPriceType(item.price_type) }}
                      </b-td> -->
                      <b-td>
                        {{ $n(item.processing_fee) }}
                      </b-td>
                      <b-td>
                        {{ $n(item.floor_price) }} ( {{ getPriceType(item.price_type) }} )
                      </b-td>
                      <b-td>
                        {{ $n(item.stall_qty) }}
                      </b-td>
                      <b-td>
                        {{ $n(item.security_perc) }}
                      </b-td>
                      <!-- <b-td>
                        {{ $n(item.security_fee) }}
                      </b-td> -->
                      <b-td>
                        <span class="d-flex text-center">
                          <b-button @click="editItem(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                          <b-button type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button>
                        </span>
                      </b-td>
                  </b-tr>
                  <b-tr v-if="data.details.length <= 0">
                      <td colspan="12" class="text-center">
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
import { stallCategoryStore, stallCategoryUpdate, stallCategoryShow } from '../../api/routes'

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
        year: 0,
        fair_id: 0,
        circular_type: 0,
        details: []
      },
      detailsFormData: {
        stall_type: 0,
        cat_name_en: '',
        cat_name_bn: '',
        size_en: '',
        size_bn: '',
        price_type: 0,
        processing_fee: '',
        stall_qty: '',
        floor_price: '',
        security_perc: '',
        security_fee: ''
      },
      fairTitleList: [],
      locationIndex: ''
    }
  },
  created () {
    this.data.year = new Date().getFullYear()
    if (this.id) {
      this.getStallCatInfo()
    }
  },
  watch: {
    'data.year': function (newVal) {
      this.fairTitleList = this.getFairTitle(newVal)
    }
  },
  mounted () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    stallTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.stallTypeList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    priceTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.priceTypeList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    circularTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    }
  },
  methods: {
    getFairTitle (year) {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === parseInt(year)).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getStallType (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.stallTypeList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    getPriceType (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.priceTypeList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.toString().replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.toString().replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    // percentage () {
    //   const securityFee = (parseFloat(this.detailsFormData.processing_fee) * parseFloat(this.detailsFormData.security_perc)) / 100
    //   this.detailsFormData.security_fee = isNaN(securityFee) ? '' : securityFee
    // },
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
      const stallType = this.detailsFormData.stall_type
      const catNameEn = this.detailsFormData.cat_name_en
      const priceType = this.detailsFormData.price_type
      const newData = result.find(item => item.stall_type === stallType && item.cat_name_en === catNameEn && item.price_type === priceType)
      if (typeof newData === 'undefined') {
          if (this.editIndex !== '') {
              // this.data.details[parseInt(this.editIndex)] = this.detailsFormData
              this.data.details[parseInt(this.editIndex)].stall_type = this.detailsFormData.stall_type
              this.data.details[parseInt(this.editIndex)].cat_name_en = this.detailsFormData.cat_name_en
              this.data.details[parseInt(this.editIndex)].cat_name_bn = this.detailsFormData.cat_name_bn
              this.data.details[parseInt(this.editIndex)].size_en = this.detailsFormData.size_en
              this.data.details[parseInt(this.editIndex)].size_bn = this.detailsFormData.size_bn
              this.data.details[parseInt(this.editIndex)].price_type = this.detailsFormData.price_type
              this.data.details[parseInt(this.editIndex)].stall_qty = this.detailsFormData.stall_qty
              this.data.details[parseInt(this.editIndex)].processing_fee = this.detailsFormData.processing_fee
              this.data.details[parseInt(this.editIndex)].floor_price = this.detailsFormData.floor_price
              this.data.details[parseInt(this.editIndex)].security_perc = this.detailsFormData.security_perc
          } else {
             this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
          }
          this.detailsFormData = {
            stall_type: this.detailsFormData.stall_type,
            size_en: '',
            size_bn: '',
            price_type: 0,
            cat_name_en: '',
            cat_name_bn: '',
            processing_fee: '',
            stall_qty: '',
            floor_price: '',
            security_perc: ''
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
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${stallCategoryUpdate}/${this.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, stallCategoryStore, this.data)
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
    async getStallCatInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallCategoryShow + '/' + this.id)
      const tmpData = resultData.data
      const detailsData = tmpData.details.map(item => {
        return {
          stall_type: item.stall_type, cat_name_en: item.cat_name_en, cat_name_bn: item.cat_name_bn, size_en: item.size_en, size_bn: item.size_bn, price_type: item.price_type, floor_price: item.floor_price, stall_qty: item.stall_qty, processing_fee: item.processing_fee, security_perc: item.security_perc, security_fee: item.security_fee
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    }
  }
}
</script>
