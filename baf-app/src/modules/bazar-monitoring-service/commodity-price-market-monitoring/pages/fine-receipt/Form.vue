<template>
  <card>
    <!-- search section start -->
    <template v-slot:searchHeaderTitle>
      <h4 class="card-title">{{ $t('priceMonitoring.fine_receipt') }}</h4>
<!--      <p style="margin-top:-4px; font-size:16px;" class="text-right"><router-link class="btn-add" to="market-assign" :class="'text-light'"><b-badge pill variant="info">{{  $t('bazarMonitoring.market_assign') }} {{  $t('globalTrans.list') }}</b-badge></router-link></p>-->
    </template>
    <template v-slot:searchBody>
      <b-card>
      <b-tabs v-model="tabIndex" small card>
        <!--    Accused Person Information Tab     -->
        <b-tab :title="$t('priceMonitoring.accused_person_information')">
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(accusedPersonSaveUpdate)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="area_type_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.area_type_id"
                          :options="areaTypeList"
                          id="area_type_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
                    <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="division_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.division_id"
                          :options="divisionList"
                          id="division_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
                    <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="district_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.district_id"
                          :options="districtList"
                          id="district_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1">
                    <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="city_corporation_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.city_corporation_id"
                          :options="cityCorporationList"
                          id="city_corporation_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2 || formData.area_type_id === 3">
                    <ValidationProvider name="Upazila" vid="upazila_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="upazila_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.upazila_id"
                          :options="upazilaList"
                          id="upazila_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2">
                    <ValidationProvider name="Pauroshoba" vid="pauroshoba_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="pauroshoba_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.pouroshova')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.pauroshoba_id"
                          :options="pauroshobaList"
                          id="pauroshoba_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 3">
                    <ValidationProvider name="Union" vid="union_id" rules="">
                      <b-form-group
                        label-for="union_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.union')}}
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.union_id"
                          :options="unionList"
                          id="union_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
                    <ValidationProvider name="0" vid="ward_id" rules="">
                      <b-form-group
                        label-for="ward_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.ward')}}
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.ward_id"
                          :options="wardList"
                          id="ward_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id">
                    <ValidationProvider name="Market Name" vid="market_directory_id">
                      <b-form-group
                        label-for="market_directory_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.market_name')}}
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.market_directory_id"
                          :options="marketDirectoryList"
                          id="market_directory_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Case Number" vid="case_number" rules="required">
                      <b-form-group
                        label-for="case_number"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.case_number')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.case_number"
                          id="case_number"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person’s Name and Designation (En)" vid="accused_person_name_en" rules="required">
                      <b-form-group
                        label-for="accused_person_name_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_name_designation')}} {{$t('globalTrans.en')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.accused_person_name_en"
                          id="accused_person_name_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person’s Name and Designation (Bn)" vid="accused_person_name_bn" rules="required">
                      <b-form-group
                        label-for="accused_person_name_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_name_designation')}} {{$t('globalTrans.bn')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.accused_person_name_bn"
                          id="accused_person_name_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person's/Org.Name (En)" vid="accused_person_org_en" rules="required">
                      <b-form-group
                        label-for="accused_person_org_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_name_en')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.accused_person_org_en"
                          id="accused_person_org_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person's/Org.Name (Bn)" vid="accused_person_org_bn" rules="required">
                      <b-form-group
                        label-for="accused_person_org_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_name_bn')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.accused_person_org_bn"
                          id="accused_person_org_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person's/Org.Address (En)" vid="accused_person_address_en" rules="required">
                      <b-form-group
                        label-for="accused_person_address_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_address_eno')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-textarea
                          v-model="formData.accused_person_address_en"
                          id="accused_person_address_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-textarea>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Accused Person's/Org.Address (Bn)" vid="accused_person_address_bn" rules="required">
                      <b-form-group
                        label-for="accused_person_address_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.accused_person_address_bno')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-textarea
                          v-model="formData.accused_person_address_bn"
                          id="accused_person_address_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-textarea>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Mobile No" vid="mobile_no">
                      <b-form-group
                        label-for="mobile_no"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.mobile_no')}}
                        </template>
                        <b-form-input
                          type="tel"
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          v-model="formData.mobile_no"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Shop No" vid="shop_no">
                      <b-form-group
                        label-for="shop_no"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.shop_no')}}
                        </template>
                        <b-form-input
                          type="number"
                          v-model="formData.shop_no"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Date of Conviction" vid="date_of_conviction" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="date_of_conviction">
                        <template v-slot:label>
                          {{ $t('priceMonitoring.date_of_conviction') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="date_of_conviction"
                          v-model="formData.date_of_conviction"
                          class="form-control"
                          :placeholder="$t('globalTrans.select')"
                          :locale="currentLocale"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block" v-if="errors.length">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="warning" class="mr-2 btn-sm" @click="formData.status = 1" v-if="accusedPersonStatus !== 2">{{ $t('priceMonitoring.save_as_draft') }}</b-button>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm" @click="formData.status = 2">{{ $t('priceMonitoring.save_next') }}</b-button>
                    <router-link class="btn-sm btn btn-danger" to="fine-receipt">{{ $t('globalTrans.cancel') }}</router-link>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-tab>
        <!--    /Accused Person Information Tab     -->
        <!--    Fine Details Tab     -->
        <b-tab :title="$t('priceMonitoring.fine_details')">
          <ValidationObserver ref="form2" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(fineDetailsSaveUpdate)" @reset.prevent="reset" autocomplete="off" >
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="Law Name" vid="law_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="law_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.penalty_under_the_law')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.law_id"
                          :options="lawEntryList"
                          id="law_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="Section Name" vid="section_id" rules="">
                      <b-form-group
                        label-for="section_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.section_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="addMoreFormData.section_id"
                          :options="sectionList"
                          id="section_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="Section Number" vid="section_number" rules="">
                      <b-form-group
                        label-for="section_number"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.section_number')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          plain
                          v-model="addMoreFormData.section_number"
                          id="section_number"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Fine Amount" vid="fine_amount" rules="">
                      <b-form-group
                        label-for="fine_amount"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.fine_amount')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="addMoreFormData.fine_amount"
                          id="fine_amount"
                          :state="errors[0] ? false : (valid ? true : null)"
                          type="number"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-4">
                    <button @click="addItem" class="btn btn-sm btn-primary mr-2" type="button"
                    ><i class="fas fa-plus-circle m-0"></i> {{$t('bazarMonitoring.add')}}</button>
                  </b-col>
                </b-row>
                <b-table-simple striped bordered small class="mt-3">
                  <b-thead>
                    <tr>
                      <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                      <b-th class="text-center">{{ $t('bazarMonitoring.section_name') }}</b-th>
                      <b-th class="text-center">{{ $t('bazarMonitoring.section_number') }}</b-th>
                      <b-th class="text-center">{{ $t('priceMonitoring.fine_amount') }}</b-th>
                      <b-th class="text-center">{{ $t('globalTrans.action') }}</b-th>
                    </tr>
                  </b-thead>
                  <b-tbody>
                    <template v-if="formData.fine_details && formData.fine_details.sections && formData.fine_details.sections.length">
                      <b-tr v-for="(item, index) in formData.fine_details.sections" :key="index">
                        <b-td class="text-center">{{ index+1 }}</b-td>
                        <b-td class="text-center">{{ $i18n.locale === 'en' ? item.section_name_en : item.section_name_bn }}</b-td>
                        <b-td class="text-center">{{ $n(item.section_number, { useGrouping: false }) }}</b-td>
                        <b-td class="text-right">{{ $n(item.fine_amount) }}</b-td>
                        <b-td class="text-center">
                          <!-- <button @click="remove(index)"><i class="ri-delete-bin-line"></i>  <b-badge pill variant="danger">{{ $t('bazarMonitoring.remove') }}</b-badge></button> -->
                          <button @click="remove(index)" class="btn btn-sm btn-danger"><i class="ri-delete-bin-line"></i> </button>
                        </b-td>
                      </b-tr>
                    </template>
                    <template v-else>
                      <b-tr>
                        <b-td colspan="5" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                      </b-tr>
                    </template>
                  </b-tbody>
                  <b-tfoot>
                    <b-tr>
                      <b-th colspan="3" class="text-right">{{ $t('globalTrans.total') }}</b-th>
                      <b-th class="text-right">{{ formData.fine_details && formData.fine_details.sections ? getTotalFineAmount(formData.fine_details.sections) : 0 }}</b-th>
                      <b-th></b-th>
                    </b-tr>
                  </b-tfoot>
                </b-table-simple>
                <b-row v-if="activeRoleId !== 1 && $store.state.Auth.authUser.org_admin === 1">
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="officer Name" vid="user_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="user_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.fine_collector')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.user_id"
                          :options="userList"
                          id="user_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :disabled="activeRoleId !== 1"
                        >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{ userLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="designation_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.designation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.designation_id"
                          :options="designationList"
                          id="designation_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :disabled="activeRoleId !== 1"
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
                          v-model="formData.fine_details.office_id"
                          :options="officeList"
                          id="office_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :disabled="activeRoleId !== 1"
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
                  <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
                          v-model="formData.fine_details.office_type_id"
                          :options="officeTypeList"
                          id="office_type_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :disabled="activeRoleId !== 1"
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
                  </b-col> -->
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.org_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.org_id"
                          :options="OrgList"
                          id="org_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :disabled="activeRoleId !== 1"
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
                    <ValidationProvider name="Attachment" vid="attachment" rules="">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="attachment"
                      >
                        <template v-slot:label>
                          {{ $t('teaGardenPanel.attachment') }}
                        </template>
                        <b-form-file
                          id="attachment"
                          v-model="formData.fine_details.attachment"
                          @change="onChange"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :placeholder="$t('globalTrans.attachment_placeholder')"
                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                        ></b-form-file>
                        <div class="invalid-feedback">ca
                          {{ errors[0] }}
                        </div>
                        <small class="text-danger">{{ $t('priceMonitoring.attachment_note') }}</small>
                      </b-form-group>
                    </ValidationProvider>
                    <template class="pb-3" v-if="isFile(formData.fine_details.attachment)">
                      <a :href="bazarMonitoringServiceBaseUrl + (isImage(formData.fine_details.attachment) ? 'storage/' : '') +formData.fine_details.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                    </template>
                  </b-col>
                </b-row>
                <b-row v-else>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.org_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.org_id"
                          :options="OrgList"
                          id="org_id"
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
                  <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
                          v-model="formData.fine_details.office_type_id"
                          :options="officeTypeList"
                          id="office_type_id"
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
                  </b-col> -->
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
                          v-model="formData.fine_details.office_id"
                          :options="officeList"
                          id="office_id"
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
                    <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="designation_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.designation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.designation_id"
                          :options="designationList"
                          id="designation_id"
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
                    <ValidationProvider name="officer Name" vid="user_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="user_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('priceMonitoring.fine_collector')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.fine_details.user_id"
                          :options="userList"
                          id="user_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{ userLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Attachment" vid="attachment" rules="">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="attachment"
                      >
                        <template v-slot:label>
                          {{ $t('teaGardenPanel.attachment') }}
                        </template>
                        <b-form-file
                          id="attachment"
                          v-model="formData.fine_details.attachment"
                          @change="onChange"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :placeholder="$t('globalTrans.attachment_placeholder')"
                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                        ></b-form-file>
                        <div class="invalid-feedback">ca
                          {{ errors[0] }}
                        </div>
                        <small class="text-danger">{{ $t('priceMonitoring.attachment_note') }}</small>
                      </b-form-group>
                    </ValidationProvider>
                    <template class="pb-3" v-if="isFile(formData.fine_details.attachment)">
                      <a :href="bazarMonitoringServiceBaseUrl + (isImage(formData.fine_details.attachment) ? 'storage/' : '') +formData.fine_details.attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                    </template>
                  </b-col>
                </b-row>
                <b-row class="text-right" v-if="showFineDetailsButtons">
                  <b-col>
                    <b-button type="submit" variant="warning" class="mr-2 btn-sm" @click="formData.fine_details.status = 1" v-if="fineDetailsStatus !== 2">{{ $t('priceMonitoring.save_as_draft') }}</b-button>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm" @click="formData.fine_details.status = 2">{{ $t('globalTrans.submit') }}</b-button>
                    <router-link class="btn-sm btn btn-danger" to="fine-receipt">{{ $t('globalTrans.cancel') }}</router-link>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-tab>
        <!--    /Fine Details Tab     -->
      </b-tabs>
      </b-card>
    </template>
  </card>
</template>
<script>
import RestApi, { authServiceBaseUrl, bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import {
  accusedPersonInfoStore, accusedPersonInfoUpdate, accusedPersonInfoCaseNumber, fineDetailsStore, fineDetailsUpdate
} from '../../api/routes'
import { userListByDesignWise } from '../../../configuration/api/routes'
const today = new Date().toISOString().substr(0, 10)
export default {
  name: 'Form',
  props: ['item'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      circularLoading: false,
      formData: {
        id: '',
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        ward_id: 0,
        market_directory_id: 0,
        case_number: '',
        accused_person_name_en: '',
        accused_person_name_bn: '',
        accused_person_org_en: '',
        accused_person_org_bn: '',
        accused_person_address_en: '',
        accused_person_address_bn: '',
        shop_no: '',
        mobile_no: '',
        date_of_conviction: today,
        status: 1,
        fine_details: {
          id: '',
          accused_person_id: 0,
          law_id: 0,
          org_id: 0,
          // office_type_id: 0,
          office_id: 0,
          designation_id: 0,
          user_id: 0,
          status: 1,
          attachment: '',
          sections: []
        }
      },
      addMoreFormData: {
        section_id: 0,
        section_name_en: '',
        section_name_bn: '',
        section_number: '',
        fine_amount: ''
      },
      officeTypeList: [],
      officeList: [],
      designationList: [],
      userList: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      marketDirectoryList: [],
      sectionList: [],
      tabIndex: 0,
      userLoading: false,
      accusedPersonStatus: 1,
      fineDetailsStatus: 1,
      activeRoleId: this.$store.state.Auth.activeRoleId,
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl
    }
  },
  created () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.formData = Object.assign({}, this.formData, {
        area_type_id: this.addressCustomUser.area_type_id,
        city_corporation_id: this.addressCustomUser.city_corporation_id,
        pauroshoba_id: this.addressCustomUser.pauroshoba_id,
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_directory_id: this.addressCustomUser.market_id
      })
    }
    if (this.item && this.item.id) {
      if (this.item.fine_details && this.item.fine_details.sections && this.item.fine_details.sections.length) {
        this.item.fine_details.sections = this.item.fine_details.sections.map(item => {
          const section = this.$store.state.BazarMonitoringService.commonObj.sectionList.find(obj => obj.value === parseInt(item.section_id))
          const customItem = {
            section_name_en: section?.text_en,
            section_name_bn: section?.text_bn
          }
          return Object.assign({}, item, customItem)
        })
      }
      // this.formData = this.item
      if (!this.item.fine_details) {
        this.formData = Object.assign({}, this.formData, this.item, {
          fine_details: {
            id: '',
            accused_person_id: this.item.id,
            law_id: 0,
            org_id: 0,
            // office_type_id: 0,
            office_id: 0,
            designation_id: 0,
            user_id: 0,
            sections: []
          }
        })
      } else {
        this.formData = Object.assign({}, this.formData, this.item)
      }
      this.accusedPersonStatus = this.formData.status
      if (this.formData.fine_details) {
        this.fineDetailsStatus = this.formData.fine_details.status
      }
    } else {
      // this.getCaseNumber()
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1 && this.$store.state.Auth.authUser.org_admin === 1) {
      this.formData.fine_details = Object.assign({}, this.formData.fine_details, {
        org_id: this.loggedUserPrivilege.org_id,
        // office_type_id: this.loggedUserPrivilege.office_type_id,
        office_id: this.loggedUserPrivilege.office_id,
        designation_id: this.loggedUserPrivilege.designation_id,
        user_id: this.loggedUserPrivilege.user_id
      })
    }
    const loadingState = { loading: false, listReload: false }
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (this.$route.params.id) {
      this.saveUpdate()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    showFineDetailsButtons () {
      return (this.formData.id && this.formData.status === 2)
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
    },
    // cityCorporationList: function () {
    //   return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1)
    // },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    // marketDirectoryList () {
    //   return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1)
    // },
    inspectByList () {
      return this.$store.state.BazarMonitoringService.commonObj.inspectByList
    },
    componentOrgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    },
    lawEntryList () {
      return this.$store.state.BazarMonitoringService.commonObj.lawEntryList.filter(item => item.status === 1)
    },
    OrgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    }
  },

  watch: {
    'formData.division_id': function (newVal, oldVal) {
      // this.wardList = []
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'formData.district_id': function (newVal, oldVal) {
      // this.wardList = []
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.cityCorporationList = this.getCityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.cityCorporationList = []
      }
    },
    'formData.upazila_id': function (newVal, oldVal) {
      if (newVal) {
        this.marketDirectoryList = this.getMarketDirectoryList(newVal, 'upazila')
        this.pauroshobaList = this.getPauroshobaList(newVal)
      } else {
        this.marketDirectoryList = []
        this.pauroshobaList = []
      }
    },
    'formData.city_corporation_id': function (newVal, oldVal) {
      if (newVal) {
        this.marketDirectoryList = this.getMarketDirectoryList(newVal, 'city_corporation')
        this.wardList = this.getWardList(newVal, 'city_corporation')
      } else {
        if (!(this.formData.pauroshoba_id || this.formData.union_id)) {
          this.marketDirectoryList = []
          this.wardList = []
        }
      }
    },
    'formData.pauroshoba_id': function (newVal, oldVal) {
      if (newVal) {
        this.marketDirectoryList = this.getMarketDirectoryList(newVal, 'pauroshoba')
        this.wardList = this.getWardList(newVal, 'pauroshoba')
      } else {
        if (!(this.formData.city_corporation_id || this.formData.union_id)) {
          this.marketDirectoryList = []
          this.wardList = []
        }
      }
    },
    'formData.union_id': function (newVal, oldVal) {
      if (newVal) {
        this.marketDirectoryList = this.getMarketDirectoryList(newVal, 'union')
        this.wardList = this.getWardList(newVal, 'union')
      } else {
        if (!(this.formData.city_corporation_id || this.formData.pauroshoba_id)) {
          this.marketDirectoryList = []
          this.wardList = []
        }
      }
    },
    'formData.ward_id': function (newVal, oldVal) {
      if (newVal) {
        this.marketDirectoryList = this.getMarketDirectoryList(newVal, 'ward')
      } else {
        this.marketDirectoryList = []
      }
    },
    'formData.fine_details.law_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.sectionList = this.getSectionList(newVal)
      } else {
        this.sectionList = []
      }
    },
    'addMoreFormData.section_id': function (newVal, oldVal) {
      if (newVal) {
        const section = this.$store.state.BazarMonitoringService.commonObj.sectionList.find(obj => obj.value === parseInt(newVal))
        this.addMoreFormData = Object.assign({}, this.addMoreFormData, {
          section_name_en: section?.text_en,
          section_name_bn: section?.text_bn,
          section_number: section?.section_number
        })
      } else {
        this.addMoreFormData = Object.assign({}, this.addMoreFormData, {
          section_name_en: '',
          section_name_bn: '',
          section_number: ''
        })
      }
    },
    'formData.fine_details.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.officeTypeList = this.getOfficeTypeList(newVal)
        this.officeList = this.getOfficeList(newVal)
        this.designationList = this.getDesingationList(newVal)
      } else {
        // this.officeTypeList = []
        this.officeList = []
        this.designationList = []
      }
    },
    // 'formData.fine_details.office_type_id': function (newVal, oldVal) {
    //   if (newVal !== oldVal) {
    //     this.officeList = this.getOfficeList(newVal)
    //   } else {
    //     this.officeList = []
    //   }
    // },
    'formData.fine_details.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    },
    tabIndex: function (newVal) {
      if (newVal) {
        if (!this.formData.id || (this.formData.id && !this.formData.status)) {
          this.tabIndex = 0
          return this.$toast.error({
            title: 'Please save Accused Person Tab data',
            color: '#D6E09B'
          })
        }
      }
    }
  },
  methods: {
    async accusedPersonSaveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.formData.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${accusedPersonInfoUpdate}/${this.formData.id}`, this.formData)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, accusedPersonInfoStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        if (this.item !== undefined && this.item.id) {
          this.formData = Object.assign({}, this.formData, result.model)
        } else {
          const roleId = this.$store.state.Auth.activeRoleId
          this.formData = Object.assign({}, this.formData, result.model, {
            fine_details: {
              id: '',
              accused_person_id: result.model.id,
              law_id: 0,
              org_id: roleId !== 1 ? this.loggedUserPrivilege.org_id : 0,
              office_type_id: roleId !== 1 ? this.loggedUserPrivilege.office_type_id : 0,
              office_id: roleId !== 1 ? this.loggedUserPrivilege.office_id : 0,
              designation_id: roleId !== 1 ? this.loggedUserPrivilege.designation_id : 0,
              user_id: roleId !== 1 ? this.loggedUserPrivilege.user_id : 0,
              sections: []
            }
          })
          this.$refs.form2.reset()
        }
        // this.$bvModal.hide('modal-form')
        if (this.formData.status === 2) {
          this.accusedPersonStatus = 2
          this.tabIndex = 1
        }
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    async fineDetailsSaveUpdate () {
      if (!this.formData.fine_details.sections.length) {
        return this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: 'Please select section information',
          color: '#D6E09B'
        })
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.formData.fine_details.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${fineDetailsUpdate}/${this.formData.fine_details.id}`, this.formData.fine_details)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, fineDetailsStore, this.formData.fine_details)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.formData.fine_details.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        // this.formData = Object.assign({}, this.formData, { fine_details: result.model })
        this.formData.fine_details = Object.assign({}, this.formData.fine_details, result.model)

        // this.$bvModal.hide('modal-form')
        if (this.formData.fine_details.status === 2) {
          this.fineDetailsStatus = 2
          this.$router.push('fine-receipt')
        }
      } else {
        this.$refs.form2.setErrors(result.errors)
      }
    },
    async getCaseNumber () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, accusedPersonInfoCaseNumber)
      if (result.success) {
        this.formData.case_number = result.data
      } else {
        this.formData.case_number = ''
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getCityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getWardList (id, searchItem = 'city_corporation') {
      const wardList = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      if (searchItem === 'pauroshoba') {
        return wardList.filter(item => item.pauroshoba_id === id)
      } else if (searchItem === 'union') {
        return wardList.filter(item => item.union_id === id)
      } else {
        return wardList.filter(item => item.city_corporation_id === id)
      }
    },
    getMarketDirectoryList (id, searchCriteria = 'pauroshoba') {
      const marketDirectoryList = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1)
      if (searchCriteria === 'upazila') {
        return marketDirectoryList.filter(item => item.upazila_id === id)
      } else if (searchCriteria === 'city_corporation') {
        return marketDirectoryList.filter(item => item.city_corporation_id === id)
      } else if (searchCriteria === 'union') {
        return marketDirectoryList.filter(item => item.union_id === id)
      } else if (searchCriteria === 'ward') {
        return marketDirectoryList.filter(item => item.ward_id === id)
      } else {
        return marketDirectoryList.filter(item => item.pauroshoba_id === id)
      }
    },
    getSectionList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.sectionList.filter(item => item.status === 1 && item.law_id === id)
    },
    async addItem () {
      if (this.addMoreFormData.section_id && this.addMoreFormData.section_number && this.addMoreFormData.fine_amount) {
        // const section = this.$store.state.BazarMonitoringService.commonObj.sectionList.find(obj => obj.value === this.addMoreFormData.section_id)
        // const obj = {
        //   section_name_en: section?.text_en,
        //   section_name_bn: section?.text_bn
        // }
        const objExist = this.formData.fine_details.sections.find(obj => obj.section_id === this.addMoreFormData.section_id)
        if (typeof objExist === 'undefined') {
          this.addMoreFormData = Object.assign({}, this.addMoreFormData, {
            fine_amount: parseInt(this.addMoreFormData.fine_amount)
          })
          this.formData.fine_details.sections.push(this.addMoreFormData)
        } else {
          // this.$toast.error({
          //   title: 'Data has already been added',
          //   color: '#D6E09B'
          // })
          objExist.fine_amount += this.addMoreFormData.fine_amount ? parseInt(this.addMoreFormData.fine_amount) : 0
        }
      } else {
        return this.$toast.error({
          title: 'Please fill up all the fields',
          color: '#D6E09B'
        })
      }
      this.addMoreFormData = {
        section_id: 0,
        section_name_en: '',
        section_name_bn: '',
        section_number: '',
        fine_amount: ''
      }
      this.$refs.form2.reset()
    },
    remove (key) {
      this.formData.fine_details.sections.splice(key, 1)
    },
    getTotalFineAmount (sections) {
      let total = 0
      sections.forEach(item => {
        total += item.fine_amount
      })
      return this.$n(total)
    },
    getOfficeTypeList (orgId) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getOfficeList (OfficeTypeID) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === OfficeTypeID)
    },
    getDesingationList (officeId) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === officeId)
    },
    getUserList (degId) {
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          const userData = response.data.filter(user => user.designation_id === degId)
          this.userList = userData.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.userLoading = false
        }
      })
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.formData.fine_details.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.formData.fine_details.attachment = ''
      }
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    },
    isFile (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg|docs|doc|pdf|csv|xsl|xslx|ppt|pptx)$/.test(path)
    }
  }
}
</script>
