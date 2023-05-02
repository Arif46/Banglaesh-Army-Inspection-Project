<template>
  <div class="inner-section market-assign-form-wrapper">
    <card>
      <!-- formData section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('bazarMonitoring.market_assign') }}</h4>
      </template>
      <template v-slot:searchHeaderAction>
        <router-link class="btn-add" to="market-assign"><i class="ri-arrow-left-line"></i> {{  $t('bazarMonitoring.market_assign') }} {{  $t('globalTrans.list') }}</router-link>
      </template>
      <template v-slot:searchBody>
        <!-- <b-container fluid> -->
          <!-- <b-row> -->
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                <b-overlay :show="loading">
                    <b-form @submit.prevent="handleSubmit(createData)" @reset.prevent="reset" autocomplete="off">
                      <b-row>
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                                <b-form-group
                                  label-for="org_id"
                                  slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                  {{$t('globalTrans.org_name')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                  plain
                                  v-model="formData.org_id"
                                  :options="orgList"
                                  id="org_id"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  @input="userPrivilegeData()"
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
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                                <b-form-group
                                  label-for="office_type_id"
                                  slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                    {{$t('userManagement.office_type')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                  plain
                                  v-model="formData.office_type_id"
                                  :options="officeTypeList"
                                  id="office_type_id"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  @input="userPrivilegeData()"
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
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                              <b-form-group
                                  label-for="office_id"
                                  slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{$t('userManagement.office')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="formData.office_id"
                                :options="officeList"
                                id="office_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                @input="userPrivilegeData()"
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
                      <b-overlay :show="loadingdata">
                          <body-card>
                            <template v-slot:headerTitle>
                              <h4 class="card-title">{{ $t('bazarMonitoring.market_assign') }} {{ $t('globalTrans.entry')}} </h4>
                            </template>
                            <div class="table-responsive" style="min-height: 300px;margin-bottom: 0">
                              <table class="table">
                                <thead class="thead">
                                  <tr>
                                    <th class="text-center">{{$t('globalTrans.sl_no')}}</th>
                                    <th>{{$t('globalTrans.name') + ' & ' + $t('globalTrans.mobile')}}</th>
                                    <th>{{$t('bazarMonitoring.area_type')}}</th>
                                    <th>{{$t('globalTrans.division')}}</th>
                                    <th>{{$t('globalTrans.district')}}</th>
                                    <th>{{$t('globalTrans.city_corporation')}}</th>
                                    <th>{{$t('globalTrans.upazila')}}</th>
                                    <th>{{$t('globalTrans.pouroshova')}}</th>
                                    <th>{{$t('bazarMonitoring.market_name')}}</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <tr v-for="(detail,index) in formData.details" :key="index">
                                    <td class="text-center">{{$n(index+1)}}</td>
                                    <td>
                                      {{ ($i18n.locale === 'bn' ? detail.text_bn : detail.text_en) + '\n' + (($i18n.locale === 'bn') ? '০' : '0') + '' + ($n(detail.mobile, { useGrouping: false })) }}
                                      <small v-if="detailsErrors && detailsErrors['details.' + index + '.mobile']" class="text-danger">
                                        {{ detailsErrors['details.'+index+'.usename'] }}
                                      </small>
                                    </td>
                                    <td>
                                      <keep-alive>
                                        <ValidationProvider :vid="'detail' + index" name="Area Type" rules="required">
                                          <div class="aaa" slot-scope="{ valid, errors }">
                                            <v-select
                                            :id="'area_type_id' + index"
                                            v-model="detail.area_type_id"
                                            :reduce="op => op.value"
                                            multiple
                                            :options="detail.areaTypeList"
                                            label="text"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            >
                                            </v-select>
                                            <div class="error invalid-feedback" role="alert">
                                                {{ errors[0] }}
                                            </div>
                                            <small v-if="detailsErrors && detailsErrors['details.' + index + '.area_type_id']" class="text-danger">
                                            {{ detailsErrors['details.'+index+'.area_type_id'] }}
                                            </small>
                                          </div>
                                        </ValidationProvider>
                                      </keep-alive>
                                    </td>
                                    <td>
                                      <keep-alive>
                                        <ValidationProvider :vid="'detail' + index" name="Division">
                                          <div slot-scope="{ valid, errors }">
                                              <v-select
                                              :id="'division_id' + index"
                                              v-model="detail.division_id"
                                              :reduce="op => op.value"
                                              multiple
                                              :options="detail.divisionList"
                                              label="text"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              @input="getDistrictList(detail)"
                                              >
                                              </v-select>
                                              <div class="error invalid-feedback" role="alert">
                                                  {{ errors[0] }}
                                              </div>
                                              <small v-if="detailsErrors && detailsErrors['details.' + index + '.division_id']" class="text-danger">
                                              {{ detailsErrors['details.'+index+'.division_id'] }}
                                              </small>
                                          </div>
                                        </ValidationProvider>
                                      </keep-alive>
                                    </td>
                                    <td>
                                      <keep-alive>
                                        <ValidationProvider :vid="'detail' + index" name="District">
                                          <div slot-scope="{ valid, errors }">
                                            <v-select
                                            :id="'district_id' + index"
                                            v-model="detail.district_id"
                                            :reduce="op => op.value"
                                            multiple
                                            :options="detail.districtList"
                                            label="text"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            @input="getDistrictAndCityCorporation(detail)"
                                            >
                                            </v-select>
                                            <div class="error invalid-feedback" role="alert">
                                            {{ errors[0] }}
                                            </div>
                                            <small v-if="detailsErrors && detailsErrors['details.' + index + '.district_id']" class="text-danger">
                                            {{ detailsErrors['details.'+index+'.district_id'] }}
                                            </small>
                                          </div>
                                        </ValidationProvider>
                                      </keep-alive>
                                    </td>
                                    <td>
                                      <keep-alive>
                                        <ValidationProvider :vid="'detail' + index" name="City Corporation">
                                          <div slot-scope="{ valid, errors }">
                                            <v-select
                                            :id="'cityCorporationList' + index"
                                            v-model="detail.city_corporation_id"
                                            :reduce="op => op.value"
                                            multiple
                                            :options="detail.cityCorporationList"
                                            label="text"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            @input="getMarketListCityPauroshova(detail)"
                                            >
                                            </v-select>
                                            <div class="error invalid-feedback" role="alert">
                                            {{ errors[0] }}
                                            </div>
                                            <small v-if="detailsErrors && detailsErrors['details.' + index + '.city_corporation_id']" class="text-danger">
                                            {{ detailsErrors['details.'+index+'.city_corporation_id'] }}
                                            </small>
                                          </div>
                                        </ValidationProvider>
                                      </keep-alive>
                                    </td>
                                    <td>
                                    <keep-alive>
                                      <ValidationProvider :vid="'detail' + index" name="upazilaList">
                                        <div slot-scope="{ valid, errors }">
                                          <v-select
                                          :id="'upazilaList' + index"
                                          v-model="detail.upazila_id"
                                          :reduce="op => op.value"
                                          multiple
                                          :options="detail.upazilaList"
                                          label="text"
                                          :state="errors[0] ? false : (valid ? true : null)"
                                          @input="getMarketListCityPauroshova(detail)"
                                          >
                                          </v-select>
                                          <div class="error invalid-feedback" role="alert">
                                          {{ errors[0] }}
                                          </div>
                                          <small v-if="detailsErrors && detailsErrors['details.' + index + '.district_id']" class="text-danger">
                                          {{ detailsErrors['details.'+index+'.district_id'] }}
                                          </small>
                                        </div>
                                      </ValidationProvider>
                                    </keep-alive>
                                    </td>
                                    <td>
                                        <keep-alive>
                                          <ValidationProvider :vid="'detail' + index" name="Pauroshoba List">
                                            <div slot-scope="{ valid, errors }">
                                              <v-select
                                              :id="'pauroshobaList' + index"
                                              v-model="detail.pauroshoba_id"
                                              :reduce="op => op.value"
                                              multiple
                                              :options="detail.pauroshobaList"
                                              label="text"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              @input="getMarketListCityPauroshova(detail)"
                                              >
                                              </v-select>
                                              <div class="error invalid-feedback" role="alert">
                                              {{ errors[0] }}
                                              </div>
                                              <small v-if="detailsErrors && detailsErrors['details.' + index + '.pauroshoba_id']" class="text-danger">
                                              {{ detailsErrors['details.'+index+'.pauroshoba_id'] }}
                                              </small>
                                            </div>
                                          </ValidationProvider>
                                        </keep-alive>
                                    </td>
                                    <td>
                                      <keep-alive>
                                        <ValidationProvider :vid="'detail' + index" name="Market List">
                                          <div slot-scope="{ valid, errors }">
                                            <v-select
                                            :id="'market' + index"
                                            v-model="detail.market_id"
                                            :reduce="op => op.value"
                                            multiple
                                            :options="detail.marketList"
                                            label="text"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            >
                                            </v-select>
                                            <div class="error invalid-feedback" role="alert">
                                            {{ errors[0] }}
                                            </div>
                                            <small v-if="detailsErrors && detailsErrors['details.' + index + '.district_id']" class="text-danger">
                                            {{ detailsErrors['details.'+index+'.district_id'] }}
                                            </small>
                                          </div>
                                        </ValidationProvider>
                                      </keep-alive>
                                    </td>
                                  </tr>
                                </tbody>
                                <template v-if="formData.details.length === 0">
                                  <tr>
                                    <th colspan="10" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                                  </tr>
                                </template>
                              </table>
                            </div>
                          </body-card>
                      </b-overlay>
                      <b-row class="text-right">
                      <b-col>
                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                      </b-col>
                      </b-row>
                    </b-form>
                </b-overlay>
            </ValidationObserver>
          <!-- </b-row> -->
        <!-- </b-container> -->
      </template>
   </card>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { marketAssignStore, AllUserList, marketAssignUserList } from '../../api/routes'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
        valid: null,
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        loading: false,
        formData: {
            org_id: 0,
            office_type_id: 0,
            office_id: 0,
            details: []
        },
        officeTypeList: [],
        officeList: [],
        userList: [],
        districtList: [],
        userLoading: false,
        loadingdata: false,
        detailsErrors: []
    }
  },
  created () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.formData = Object.assign({}, this.formData, {
        org_id: this.loggedUserPrivilege.org_id,
        office_type_id: this.loggedUserPrivilege.office_type_id,
        office_id: this.loggedUserPrivilege.office_id
      })
      this.userPrivilegeData()
    }
  },
  mounted () {
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
        return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
      })
    }
  },
  watch: {
    'formData.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.formData.office_type_id = 0
        this.officeTypeList = this.getOfficeTypeList(newVal)
        if (oldVal) {
            this.formData.office_type_id = 0
        }
      } else {
        this.officeTypeList = []
      }
    },
    'formData.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.formData.office_id = 0
        this.officeList = this.getOfficeList(newVal)
        if (oldVal) {
           this.formData.office_id = 0
        }
      } else {
        this.officeList = []
      }
    }
  },
  methods: {
    getDistrictAndCityCorporation (detail) {
      this.getCityCorporationList(detail)
      this.getUpazilaList(detail)
    },
    getMarketListCityPauroshova (detail) {
      this.getMarketList(detail)
      this.getPauroshobaList(detail)
    },
    getPauroshobaList (detail) {
      const pauroshobaList = []
      if (detail.upazila_id) {
        if (detail.upazila_id.length > 0) {
          detail.upazila_id.forEach((item, key) => {
            const pouroshovas = this.$store.state.CommonService.commonObj.municipalityList.filter(item1 => item1.upazila_id === item)
            pouroshovas.forEach((item1, key) => {
              pauroshobaList.push(item1)
            })
          })
          detail.pauroshobaList = pauroshobaList
        }
      }
      return pauroshobaList
    },
    getCityCorporationList (detail) {
      const cityCorporationList = []
        if (detail.district_id) {
          if (detail.district_id.length > 0) {
            detail.district_id.forEach((item, key) => {
            const cityCorporations = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item1 => item1.district_id === item)
              cityCorporations.forEach((item1, key) => {
                cityCorporationList.push(item1)
              })
            })
            detail.cityCorporationList = cityCorporationList
          }
        }
        return cityCorporationList
    },
    getUpazilaList (detail) {
    const upazilaList = []
    if (detail.district_id) {
      if (detail.district_id.length > 0) {
        detail.district_id.forEach((item, key) => {
          const upazilas = this.$store.state.CommonService.commonObj.upazilaList.filter(item1 => item1.district_id === item)
          upazilas.forEach((item1, key) => {
            upazilaList.push(item1)
          })
        })
      }
    }
    detail.upazilaList = upazilaList
    return upazilaList
    },
    getMarketList (detail) {
      const marketList = []
      if (detail.district_id) {
        if (detail.district_id.length > 0) {
          detail.district_id.forEach((item, key) => {
            const marketLists = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item1 => item1.district_id === item)
            marketLists.forEach((item1, key) => {
              marketList.push(item1)
            })
          })
          detail.marketList = marketList
        }
      }
      return marketList
    },
    getDistrictList (detail) {
      const districtList = []
      if (detail.division_id) {
        if (detail.division_id.length > 0) {
          detail.division_id.forEach((item, key) => {
            const districts = this.$store.state.CommonService.commonObj.districtList.filter(item1 => item1.division_id === item)
            districts.forEach((item1, key) => {
              districtList.push(item1)
            })
          })
          detail.districtList = districtList
        }
      }
      return districtList
    },
    async userPrivilegeData () {
      if (this.formData.org_id && this.formData.office_type_id && this.formData.office_id) {
        this.loadingdata = true
        const searchData = {
          office_type_id: this.formData.office_type_id,
          office_id: this.formData.office_id,
          org_id: this.formData.org_id
        }
        const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketAssignUserList, searchData)
          if (result.success) {
              this.userList = result.data
          } else {
              this.userList = []
          }
        this.loadData()
      }
    },
    async loadData () {
      if (this.formData.org_id && this.formData.office_type_id && this.formData.office_id) {
        const searchData = {
          office_type_id: this.formData.office_type_id,
          office_id: this.formData.office_id,
          org_id: this.formData.org_id,
          user_type: 1
        }
        const result = await RestApi.getData(authServiceBaseUrl, AllUserList, searchData)
        if (result.success) {
          const datas = result.data.map(item => {
            const desigObj = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === parseInt(item.designation_id))
            const isThere = this.userList.find(userList => userList.user_id === parseInt(item.id))
            const desigData = {
              user_id: item.id,
              designation_id: item.designation_id,
              areaTypeList: this.areaTypeList,
              divisionList: this.divisionList,
              area_type_id: typeof isThere !== 'undefined' ? isThere.area_type_id : [],
              division_id: typeof isThere !== 'undefined' ? isThere.division_id : [],
              district_id: typeof isThere !== 'undefined' ? isThere.district_id : [],
              city_corporation_id: typeof isThere !== 'undefined' ? isThere.city_corporation_id : [],
              upazila_id: typeof isThere !== 'undefined' ? isThere.upazila_id : [],
              pauroshoba_id: typeof isThere !== 'undefined' ? isThere.pauroshoba_id : [],
              market_id: typeof isThere !== 'undefined' ? isThere.market_id : []
            }
            desigData.districtList = this.getDistrictList(desigData)
            desigData.cityCorporationList = this.getCityCorporationList(desigData)
            desigData.upazilaList = this.getUpazilaList(desigData)
            desigData.pauroshobaList = this.getPauroshobaList(desigData)
            desigData.marketList = this.getMarketList(desigData)
            if (typeof desigObj !== 'undefined') {
              desigData.designation_name = desigObj.text_en
              desigData.designation_name_bn = desigObj.text_bn
            } else {
              desigData.designation_name = ''
              desigData.designation_name_bn = ''
            }
            return Object.assign({}, item, desigData)
          })
          this.formData.details = datas
        } else {
          this.formData.details = []
        }
        this.loadingdata = false
      }
    },
    getMarketAssigData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async createData () {
        this.loading = true
        let result = null
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, marketAssignStore, this.formData)
        if (result.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$router.push({ path: '/bazar-monitoring-service/configuration/market-assign' })
        } else {
          this.detailsErrors = result.errors
        }
        this.loading = false
    },
    getOfficeTypeList (orgId) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === OfficeTypeID)
    }
  }
}
</script>

<style scoped>
  .main {
    padding: 45px 50px;
  }
  .flex {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }
</style>
