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
                          label-for="fiscal_year_id">
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
                          label-for="fair_name_id">
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
                  <b-row class="p-2">
                    <b-col style="background-color: var(--gray-ddd);" lg="4" class="offset-lg-4 p-2">
                      <template>
                        <h5 style="" class="text-center">{{ $t('tradeFairConfig.criteria_name_entry') }}</h5>
                      </template>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Criteria Name (En)" vid="criteria_name_en" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="criteria_name">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.criteria_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="criteria_name_en"
                            v-model="detailsFormData.criteria_name_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Criteria Name (Bn)" vid="criteria_name_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="criteria_name_bn">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.criteria_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="criteria_name_bn"
                            v-model="detailsFormData.criteria_name_bn"
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
                  <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                  <th style="width:10%">{{ $t('tradeFairConfig.criteria_name') }}</th>
                  <th style="width:10%">
                      <b-form-checkbox
                          id="checkbox-1"
                          name="checkbox-1"
                          @change="selectAll($event)"
                          :value=1
                          :unchecked-value=0
                      >
                      {{ $t('tradeFairConfig.select_all') }}
                      </b-form-checkbox>
                  </th>
                  <th style="width:10%">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                  <b-tr v-for="(item, index) in data.details" :key="index">
                      <b-td>
                          {{ $n(index + 1) }}
                      </b-td>
                      <b-td>
                        {{ currentLocale == 'bn' ? item.criteria_name_bn : item.criteria_name_en }}
                      </b-td>
                      <b-td>
                        <b-form-checkbox
                          :id="'checkbox-1'+index"
                          v-model="item.is_active"
                          :name="'checkbox-1'+index"
                          :value=1
                          :unchecked-value=0
                      >
                      </b-form-checkbox>
                      </b-td>
                      <b-td>
                        <span class="d-flex text-center">
                          <b-button @click="editItem(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                          <b-button type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button>
                        </span>
                      </b-td>
                  </b-tr>
                  <b-tr v-if="data.details.length <= 0">
                      <td colspan="4" class="text-center">
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
import { evaluationChecklistStore, evaluationChecklistUpdate, evaluationChecklistShow } from '../../api/routes'

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
      data: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        details: []
      },
      detailsFormData: {
        criteria_name_en: '',
        criteria_name_bn: '',
        is_active: 1
      },
      locationIndex: '',
      allSelected: false,
      fairNameList: []
    }
  },
  created () {
    if (this.id) {
      this.getChecklistInfo()
      // this.data = tmp
    }
  },
  mounted () {
    this.data = Object.assign({}, this.data, { fiscal_year_id: this.$store.state.currentFiscalYearId })
  },
  watch: {
    'data.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList(newVal)
      }
    }
  },
  computed: {
    // fairNameList () {
    //   return this.$store.state.TradeFairService.commonObj.fairNameList.map(el => {
    //     return { value: el.value, text: this.currentLocale === 'bn' ? el.text_bn : el.text_en }
    //   })
    // },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  methods: {
    getFiscalYear (id) {
      const fiscalyear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      this.minDate = fiscalyear.start_date
      this.maxDate = fiscalyear.end_date
    },
    getFairNameList (Id) {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === Id)
    },
    selectAll (e) {
      if (this.data.details.length > 0) {
        if (e) {
          const newArr = this.data.details.map(el => {
            return Object.assign({}, el, { is_active: 1 })
          })
          this.data.details = newArr
        } else {
          const newArr2 = this.data.details.map(el => {
            return Object.assign({}, el, { is_active: 0 })
          })
          this.data.details = newArr2
        }
      }
    },
    cancelItem () {
        this.detailsFormData = {}
        this.detailsFormData.is_active = 1
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
      const criteriaNameEn = this.detailsFormData.criteria_name_en
      const newData = result.find(item => item.criteria_name_en === criteriaNameEn)
      if (typeof newData === 'undefined') {
          if (this.editIndex !== '') {
              // this.data.details[parseInt(this.editIndex)] = this.detailsFormData
              this.data.details[parseInt(this.editIndex)].criteria_name_en = this.detailsFormData.criteria_name_en
              this.data.details[parseInt(this.editIndex)].criteria_name_bn = this.detailsFormData.criteria_name_bn
              this.data.details[parseInt(this.editIndex)].is_active = this.detailsFormData.is_active
          } else {
              this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
          }
          this.detailsFormData = {
            criteria_name_en: '',
            criteria_name_bn: '',
            is_active: 1
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
          result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${evaluationChecklistUpdate}/${this.id}`, this.data)
        } else {
          result = await RestApi.postData(internationalTradeFairServiceBaseUrl, evaluationChecklistStore, this.data)
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
    async getChecklistInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, evaluationChecklistShow + '/' + this.id)
      const tmpData = resultData.data
      const detailsData = tmpData.details.map(item => {
        return {
          criteria_name_en: item.criteria_name_en, criteria_name_bn: item.criteria_name_bn
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    }
  }
}
</script>
