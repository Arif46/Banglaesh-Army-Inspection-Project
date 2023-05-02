<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('ditfConfig.stall_info') }} {{ $route.query.id? $t('globalTrans.modify') : $t('globalTrans.entry') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link to="stall-info-list" :class="'btn btn-primary text-light'">{{ $t('tradeFairConfig.stall_info_list') }}</router-link>
      </template>
      <template v-slot:searchBody>
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
                    <br/>
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
                        <ValidationProvider name="Stall Category" vid="stall_cat_det_id" rules="required|min_value:1" v-slot="{ errors }">
                          <b-form-group
                            label-cols-sm="4"
                            label-for="stall_cat"
                          >
                            <template v-slot:label>
                              {{$t('ditfConfig.stall_pavilion_restaurant')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                              plain
                              id="stall_cat_det_id"
                              :options="stallCategoryList"
                              v-model="detailsFormData.stall_cat_det_id"
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
                      <b-col>
                          <div class="text-right mb-2">
                              <b-button type="button" v-if="editIndex !== ''" variant="danger" class="mr-1 btn-sm" @click="cancelItem()">{{ $t('globalTrans.cancel') }}</b-button>
                              <b-button type="submit" class="btn-sm" variant="success">{{ editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
                          </div>
                      </b-col>
                    </b-row>
                  </b-form>
                </ValidationObserver>
                  <!-- List  -->
                  <!-- <b-table-simple bordered>
                      <thead>
                        <tr class="bg-primary">
                          <th style="width:5%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:20%">{{ $t('ditfConfig.stall_pavilion_restaurant') }}</th>
                          <th style="width:10%">{{ $t('globalTrans.action') }}</th>
                        </tr>
                      </thead>
                      <b-tbody>
                          <b-tr v-for="(item, index) in data.details" :key="index">
                              <b-td>
                                  {{ $n(index + 1) }}
                              </b-td>
                              <b-td>
                                {{ getStallCat(item.stall_cat_det_id) }}
                             </b-td>
                              <b-td>
                                <span class="d-flex text-center">
                                  <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="add(data.item)" class="action-btn add" :title="$t('globalTrans.add')"><i class="ri-plus-fill"></i></b-button>
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
                    </b-table-simple> -->
                  <b-row class="text-right">
                    <b-col>
                      <!-- <b-button type="button" @click="saveUpdate" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button> -->
                      <b-button type="button" @click="saveUpdate()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
                      <b-button type="button" @click="finalSave()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.finalSave') }}</b-button>
                      <!-- <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button> -->
                      <router-link to="stall-information" :class="'btn btn-danger text-light btn-sm'">{{ $t('globalTrans.cancel') }}</router-link>
                    </b-col>
                  </b-row>
              </b-overlay>
          </b-col>
        </b-row>
      </template>
      <!-- <pre>{{data.details}}</pre> -->
    </card>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { stallInfoStore, stallInfoUpdate, stallInfoShow } from '../../api/routes'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      loader: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      editIndex: '',
      fair_sector_id: 0,
      flag_status: 1,
      data: {
        year: 0,
        fair_id: 0,
        circular_type: 0,
        details: []
      },
      detailsFormData: {
        stall_cat_det_id: 0,
        stall_location_en: '',
        stall_location_bn: '',
        stall_no: ''
      },
      locationIndex: '',
      fairTitleList: [],
      stallCategoryList: []
    }
  },
  created () {
    this.data.year = new Date().getFullYear()
    if (this.$route.query.id) {
      this.getCategoryDetail()
      const tmp = this.getEditStallInfo()
      this.data.year = tmp.year
      this.data.fair_id = tmp.fair_id
      this.data.circular_type = tmp.circular_type
    }
  },
  watch: {
    'data.year': function (newVal) {
      this.fairTitleList = this.getFairTitle(newVal)
    },
    'data.circular_type': function (newVal) {
        this.stallCategoryList = this.getStallCategoryList(newVal)
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
    getStallCat (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.stallCategoryList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    getStallCategoryList (id) {
      return this.$store.state.TradeFairService.ditfCommonObj.stallCategoryList.filter(item => item.circular_type === parseInt(id) && item.fair_id === this.data.fair_id && item.year === this.data.year).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getFairTitle (year) {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === parseInt(year)).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.toString().replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.toString().replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
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
      const stallCatId = this.detailsFormData.stall_cat_det_id
      const stallNo = this.detailsFormData.stall_no
      const newData = result.find(item => item.stall_no === stallNo && item.stall_cat_det_id === stallCatId)
      if (typeof newData === 'undefined') {
            if (this.editIndex !== '') {
                // this.data.details[parseInt(this.editIndex)] = this.detailsFormData
                this.data.details[parseInt(this.editIndex)].stall_cat_det_id = this.detailsFormData.stall_cat_det_id
                this.data.details[parseInt(this.editIndex)].stall_no = this.detailsFormData.stall_no
                this.data.details[parseInt(this.editIndex)].stall_location_en = this.detailsFormData.stall_location_en
                this.data.details[parseInt(this.editIndex)].stall_location_bn = this.detailsFormData.stall_location_bn
            } else {
               this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
            }
            this.detailsFormData = {
              stall_cat_det_id: this.detailsFormData.stall_cat_det_id,
              stall_no: '',
              stall_location_en: '',
              stall_location_bn: ''
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
        if (this.$route.query.id) {
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${stallInfoUpdate}/${this.$route.query.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, stallInfoStore, this.data)
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
          // this.$bvModal.hide('modal-form')
          this.$router.push('/trade-fair-service/ditf/configuration/stall-information')
          } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    },
    async getCategoryDetail () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallInfoShow + '/' + this.$route.query.id)
      if (resultData.success) {
        this.data.details = resultData.data
      } else {
        this.data.details = []
      }
      this.loader = false
    },
    getEditStallInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.$route.query.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
