<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <!-- garden name -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="garden_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.select_garden') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.garden_id"
                      :options="teaGardenGenInfoList"
                      id="garden_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- school name en-->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="School Name (En)" vid="school_name_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="school_name_en"
                  v-model="schoolInformation.school_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- school name bn -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Factory Name (Bn)" vid="school_name_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="school_name_bn"
                  v-model="schoolInformation.school_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- establishment year -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Establishment Year" vid="estabs_year" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="estabs_year">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.establishment_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  min="0"
                  id="estabs_year"
                  v-model="schoolInformation.estabs_year"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- head master name en -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Head Master's Name (En)" vid="h_master_name_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="h_master_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.head_master_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="h_master_name_en"
                  v-model="schoolInformation.h_master_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- head master name bn -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Head Master's Name (Bn)" vid="h_master_name_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="h_master_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.head_master_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="h_master_name_bn"
                  v-model="schoolInformation.h_master_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- mobile no -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Mobile No" vid="h_master_mobile" rules="required|min:11|max:11">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="h_master_mobile">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.mobile_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  min="0"
                  id="h_master_mobile"
                  v-model="schoolInformation.h_master_mobile"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- Email -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Email" vid="h_master_email">
              <b-form-group
                label-for="h_master_email">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.email') }}
                </template>
                <b-form-input
                  id="h_master_email"
                  v-model="schoolInformation.h_master_email"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- no of teachers -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="No Of Teacher" vid="num_of_teacher" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="num_of_teacher">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.num_of_teacher') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  min="0"
                  id="num_of_teacher"
                  v-model="schoolInformation.num_of_teacher"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- no of teachers -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="No Of Latrine" vid="num_of_latrine" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="num_of_latrine">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.num_of_latrine') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  min="0"
                  id="num_of_latrine"
                  v-model="schoolInformation.num_of_latrine"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- school type  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="School Type" vid="school_type" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_type">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_type') }}<span class="text-danger">*</span>
                </template>
                 <b-form-checkbox-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.school_type"
                       :options="schoolType">
                  </b-form-checkbox-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- school category -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="School Category" vid="school_category" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_category">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_category') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.school_category"
                      :options="schoolCategory"
                      id="school_category"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- school status  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="School Status" vid="school_status" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_status">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_status') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.school_status"
                       :options="schoolStatus">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- school location  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="School Location" vid="school_location" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_location">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_location') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.school_location"
                       :options="schoolLocation">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- is office room  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Is Office Room" vid="is_office_room" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="is_office_room">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.is_office_room') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.is_office_room"
                       :options="manualList">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- have_playground  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Have Play Ground" vid="have_playground" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="have_playground">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.have_playground') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.have_playground"
                       :options="manualList">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- have_flag_pillar  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Have Flag Hoisting Pillar" vid="have_flag_pillar" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="have_flag_pillar">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.have_flag_pillar') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="schoolInformation.have_flag_pillar"
                       :options="manualList">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- area section start here -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="area_type_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.area_type_id"
                      id="area_type_id"
                      :options="getAreaTypeList"
                      @change="getAreaTypeData(schoolInformation.area_type_id)"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="ItemShow">
            <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="division_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.division_id"
                      id="division_id"
                      :options="divisionList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="ItemShow">
            <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="district_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.district_id"
                      id="district_id"
                      :options="districtList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="PauroshobaItemShow || UnionItemShow">
            <ValidationProvider name="District" vid="upazila_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="upazila_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.upazila') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.upazila_id"
                      id="upazila_id"
                      :options="upazilaList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="UnionItemShow">
            <ValidationProvider name="Union" vid="union_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="union_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.union') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.union_id"
                      id="union_id"
                      :options="unionList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="CityCorpItemShow">
            <ValidationProvider name="City Corporation" vid="city_corporation_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="city_corporation_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.city_corporation') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.city_corporation_id"
                      id="city_corporation_id"
                      :options="cityCorporationList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="PauroshobaItemShow">
            <ValidationProvider name="Municipality" vid="pauroshoba_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="pauroshoba_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.municipality_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="schoolInformation.pauroshoba_id"
                      id="pauroshoba_id"
                      :options="municipalityList"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- area section end  -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (En)" vid="address_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_en"
                  v-model="schoolInformation.address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="address_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_bn"
                  v-model="schoolInformation.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="schoolInformation.description_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="schoolInformation.description_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { schoolInformaitonStore, schoolInformaitonUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      ItemShow: false,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      schoolInformation: {
        have_playground: false,
        have_flag_pillar: false,
        is_office_room: false,
        school_category: 0,
        garden_id: '0',
        school_type: [],
        area_type_id: '0',
        city_corporation_id: '0',
        pauroshoba_id: '0',
        ward_id: '0',
        country_id: 1,
        division_id: '0',
        district_id: '0',
        upazila_id: '0',
        union_id: '0',
        address_en: '',
        address_bn: ''
      },
      regionalStatus: false,
      regionalOfficeList: [],
      officeTypeList: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      cityCorporationList: [],
      municipalityList: [],
      wardList: [],
      officeList: [],
      manualList: [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
      ]
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getTeaCompany()
      this.schoolInformation = tmp
      if (this.schoolInformation.area_type_id === 1) {
          this.ItemShow = true
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
      } else if (this.schoolInformation.area_type_id === 2) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
      } else if (this.schoolInformation.area_type_id === 3) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
      }

      // parse school type
      this.schoolInformation.school_type = JSON.parse(this.schoolInformation.school_type)
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    madeTeaType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList.filter(item => item.status === 1)
    },
    factoryType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterFactoryTypeList.filter(item => item.status === 1)
    },
    teaGardenGenInfoList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
    },
    schoolType: function () {
      return this.$store.state.TeaGardenService.commonObj.trustType
    },
    schoolStatus: function () {
      return this.$store.state.TeaGardenService.commonObj.schoolStatus
    },
    schoolCategory: function () {
      return this.$store.state.TeaGardenService.commonObj.schoolCategory
    },
    schoolLocation: function () {
      return this.$store.state.TeaGardenService.commonObj.schoolLocation
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    getAreaTypeList: function () {
      const objectData = this.$store.state.commonObj.areaTypeList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    }
  },
  methods: {
    getAreaTypeData (typeId) {
      this.ItemShow = true
      if (typeId === 1) {
        this.CityCorpItemShow = true
        this.PauroshobaItemShow = false
        this.UnionItemShow = false
      } else if (typeId === 2) {
        this.CityCorpItemShow = false
        this.PauroshobaItemShow = true
        this.UnionItemShow = false
      } else if (typeId === 3) {
        this.CityCorpItemShow = false
        this.PauroshobaItemShow = false
        this.UnionItemShow = true
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${schoolInformaitonUpdate}/${this.id}`, this.schoolInformation)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, schoolInformaitonStore, this.schoolInformation)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getTeaCompany () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
       return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    },
    getPauroshobaList (upazillaId = null) {
      const objectData = this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.upazila_id === upazillaId)
          return objectData.map((obj, key) => {
              if (this.$i18n.locale === 'bn') {
                  return { value: obj.value, text: obj.text_bn }
              } else {
                  return { value: obj.value, text: obj.text_en }
              }
          })
    },
    getWardListByCityCorportaion (cityCorpId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.city_corporation_id === cityCorpId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByPauroshoba (pauroshobaId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.pauroshoba_id === pauroshobaId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByUnion (unionId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.union_id === unionId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    }
  },
  watch: {
    'schoolInformation.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'schoolInformation.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'schoolInformation.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'schoolInformation.city_corporation_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
    },
    'schoolInformation.pauroshoba_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByPauroshoba(newVal)
    },
    'schoolInformation.union_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByUnion(newVal)
    }
  }
}
</script>
