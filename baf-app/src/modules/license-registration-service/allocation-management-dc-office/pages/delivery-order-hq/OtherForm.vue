<template>
 <div class="inner-section">
       <body-card>
       <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.other_district') }}  {{  id > 0 ? $t('globalTrans.edit') : $t('globalTrans.add') }}</h4>
      </template>
          <b-container fluid>
              <b-row>
                <b-col sm="12" class="mt-3">
                  <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                    <b-overlay :show="loader">
                        <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                            <b-row>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="District" vid="other_district" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="other_district"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="selectedDistrict"
                                    :options="districtList"
                                    id="other_district"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            </b-row>
                          <!-- =============End Main========= -->
                    <template>
                          <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                              <h5 class="text-white text-left">
                                  {{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.details') }}
                              </h5>
                          </div>
                    </template>
                      <hr>
                      <!-- =================Add More Start===================== -->
                                <!-- Allotment Items -->
                       <div class="table-wrapper table-responsive">
                          <div>
                            <div class="row">
                              <div class="col text-center" v-if="selectedDistrictName">
                                <h5>{{ $t('globalTrans.district') }}: {{selectedDistrictName}} </h5>
                               <!-- <p>No. of Beneficiary: 60000</p>-->
                              </div>
                            </div>
                          </div>
                        <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{$t('allocation_dc_office.item')}}</div></th>
                                        <th scope="col" class="text-center"><div>{{$t('allocation_dc_office.allocated_qty')}} ({{$t('allocation_dc_office.unit')}})</div></th>
                                        <th scope="col" class="text-center"><div>{{$t('allocation_dc_office.delivered_qty')}} ({{$t('allocation_dc_office.unit')}})</div></th>
                                        <th scope="col" class="text-center"><div>{{$t('allocation_dc_office.remaining')}} ({{$t('allocation_dc_office.unit')}})</div></th>
                                        <th scope="col" class="text-center"><div>{{$t('allocation_dc_office.delivery_qty')}} ({{$t('allocation_dc_office.unit')}})</div></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="filterItem.length > 0">
                                        <tr v-for="(item, index) in filterItem" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td class="text-center">{{getItemCategoryName(item.item_id)}}</td>
                                            <td>
                                             {{item.allocated_qty}}
                                            </td>
                                            <td>
                                              {{item.delivered}}
                                             </td>
                                            <td>
                                              {{item.remaining}}
                                            </td>
                                            <td>
                                             <ValidationProvider name="Delivery Qty" :vid="`delivery_${index}`" :rules="`required|min_value:0|max_value:`+item.remaining" v-slot="{ errors }">
                                               <b-form-group
                                                 :label-for="`delivery_${index}`">
                                                 <b-form-input
                                                   :id="`delivery_${index}`"
                                                   v-model="filterItem[index].delivery_qty"
                                                   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                   :state="errors[0] ? false : (valid ? true : null)"
                                                 ></b-form-input>
                                                 <div class="invalid-feedback">
                                                   {{ errors[0] }}
                                                 </div>
                                               </b-form-group>
                                             </ValidationProvider>
                                            </td>
                                        </tr>
                                    </template>
                                    <template v-else>
                                        <tr>
                                            <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                        </div>
                      </b-form>
                   </b-overlay>
                  </ValidationObserver>
                    <br>
                <b-row class="text-right mb-3">
                    <b-col>
                        <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                        <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-other-form')">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
            </b-col>
              </b-row>
          </b-container>
     </body-card>
  </div>
</template>
<script>
import { districtOther } from '../../api/routes'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'

export default {
  name: 'Form',
  props: ['id', 'deliveryOrderItems', 'otherDistrictList', 'formDatas'],
  data () {
    return {
      valid: null,
      showPermission: false,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      selectedDistrict: 0,
      selectedDistrictName: '',
      loader: false,
      itemList: [],
      newItem: [],
      districtList: [],
      allItem: [],
      filterItem: []
    }
  },
  created () {
    this.loadData()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    currentLocale () {
      return this.$i18n.locale
    }
   /* districtList () {
    let data = this.$store.state.CommonService.commonObj.districtList
       .filter(item => item.status === 1)
      if (this.deliveryOrderItems.tableData) {
        this.deliveryOrderItems.tableData.forEach((element, index) => {
          data = data.filter(person => person.value !== element.district_id)
        })
      }
      return data
    } */
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === this.allotmentOrderData.item_category_id)
      }
    },
    selectedDistrict: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const t = this.allItem.filter(item => item.district_id === newVal)
        this.filterItem = this.dataForamtter(t[0].data)
      }
    }
  },
  methods: {
    loadData () {
      this.loader = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, districtOther, this.formDatas)
        .then((response) => {
          this.loader = false
          if (response.success) {
            this.allItem = response.data
            const data = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1)
            const info = []
            data.forEach((element2, index2) => {
              response.data.forEach((element, index) => {
                let per = true
                this.deliveryOrderItems.tableData.forEach((element3, index3) => {
                  if (element.district_id === element3.district_id) {
                    per = false
                  }
                })
                if (element.district_id === element2.value && per) {
                  info.push(element2)
                }
              })
            })
           this.districtList = info
          } else {
            this.$toast.info({
              title: 'Info',
              message: response.message,
              color: '#7fbbd2'
            })
          }
        })
    },
    cancel () {
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/delivery-order-hq' })
    },
    dataForamtter (data) {
      const ta = []
      data.map((element, index) => {
       ta.push({
          item_id: element.item_category_id,
          allocated_qty: element.allocated_qty,
          delivered: element.delivered_qty,
          remaining: parseInt(element.allocated_qty) - parseInt(element.delivered_qty),
          delivery_qty: 0
        })
      })
     return ta
    },
    async saveData () {
       const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
        const child = []
        this.filterItem.map((item, index) => {
          child.push({
            allocated_qty: item.remaining,
            item: item.item_id
          })
          child.push({
            delivery_qty: item.delivery_qty,
            item: item.item_id
          })
        })
        const data = {
          district_name_en: this.getDistrictName(this.selectedDistrict, 'en'),
          district_name_bn: this.getDistrictName(this.selectedDistrict, 'bn'),
          district_id: this.selectedDistrict,
          is_other: true,
          no_of_benificiary: 0,
          child: child
        }
      this.selectedDistrictName = ''
      this.$bvModal.hide('modal-other-form')
      this.$emit('others', data)
      }
    },
    totalCalculation (item, data) {
      let ta = 0
      let td = 0
      data.map((element, index) => {
        element.child.map((element2, index2) => {
          if (element2.item === item && element2.allocated_qty) {
            ta = ta + parseInt(element2.allocated_qty)
          }
          if (element2.item === item && element2.delivery_qty) {
            td = td + parseInt(element2.delivery_qty)
          }
        })
      })
      return {
        item_id: item,
        allocated_qty: ta,
        delivered: td,
        remaining: parseInt(ta) - parseInt(td),
        delivery_qty: 0
      }
    },
    getItemCategoryName (itemCategoryId, lang = this.$i18n.locale) {
      const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
      if (cateObj !== undefined) {
        if (lang === 'bn') {
          return cateObj.text_bn
        } else {
          return cateObj.text_en
        }
      }
    },
    getDistrictName (itemCategoryId, lang = this.$i18n.locale) {
      const cateObj = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
      if (cateObj !== undefined) {
        if (lang === 'bn') {
          return cateObj.text_bn
        } else {
          return cateObj.text_en
        }
      }
    }
  }
}
</script>
<style scoped>
  .tableFixHead          { overflow: auto; height: 500px; }
  .tableFixHead thead th { position: sticky; top: 0; z-index: 1;background-color: #77a0cb;}
</style>
