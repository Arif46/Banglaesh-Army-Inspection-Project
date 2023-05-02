<template>
  <div class="inner-section">
      <card>
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_information_entry') }}</h4>
        </template>
        <template v-slot:searchHeaderAction>
        </template>
      <b-container fluid>
      <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
                <b-row>
                <b-col md="12" sm="12" style="margin-top:20px;">
                    <b-row>
                        <b-col>
                            <div style="font-size:15px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                <h6 class="text-white text-left">
                                    {{ $t('manage_information.dealer_info') }}
                                </h6>
                            </div>
                        <hr>
                        </b-col>
                    </b-row>
                  </b-col>
                  <!-- <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                      <ValidationProvider name="Age" vid="age" v-slot="{ errors }">
                          <b-form-group
                              label-cols-sm="5"
                              style="margin-left:12px;"
                              label-for="age">
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.age') }}<span class="text-danger">*</span>
                              </template>
                              <b-form-input
                              id="age"
                              disabled
                              v-model="age"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col> -->
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                    <ValidationProvider name="Name Of Head Of Family (Bn)" vid="beneficiary_name_bn" rules="required" v-slot="{ errors }">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="beneficiary_name_bn">
                            <template v-slot:label>
                               {{ $t('tcbconfiguration.name_of_head_of_family_bn') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="beneficiary_name_bn"
                            v-model="details.beneficiary_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                    <ValidationProvider name="Name Of Head Of Family (En)" vid="beneficiary_name" rules="required" v-slot="{ errors }">
                        <b-form-group
                            label-cols-sm="5"
                            label-for="beneficiary_name">
                            <template v-slot:label>
                              {{ $t('tcbconfiguration.name_of_head_of_family') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            id="beneficiary_name"
                            v-model="details.beneficiary_name"
                            oninput="this.value = this.value.replace(/[`~!@#$%^&*()_|+\-=?;:',.<>\{\}\[\]\\\/]/gi, '')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row>
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                    <ValidationProvider name="Father Name Bn" vid="father_name_bn" v-slot="{ errors }">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="father_name_bn">
                            <template v-slot:label>
                              {{ $t('tcbconfiguration.father_name_bn') }}
                            </template>
                            <b-form-input
                            id="father_name_bn"
                            v-model="details.father_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                    <ValidationProvider name="Father Name" vid="father_name" v-slot="{ errors }">
                        <b-form-group
                            label-cols-sm="5"
                            label-for="father_name">
                            <template v-slot:label>
                              {{ $t('tcbconfiguration.father_name') }}
                            </template>
                            <b-form-input
                            id="father_name"
                            v-model="details.father_name"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row>
                <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                      <ValidationProvider name="Mother Name Bn" vid="mother_name_bn" v-slot="{ errors }">
                          <b-form-group
                              label-cols-sm="5"
                              style="margin-left:12px;"
                              label-for="mother_name_bn">
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.mother_name_bn') }}
                              </template>
                              <b-form-input
                              id="mother_name_bn"
                              v-model="details.mother_name_bn"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                      <ValidationProvider name="Mother Name" vid="mother_name" v-slot="{ errors }">
                          <b-form-group
                              label-cols-sm="5"
                              label-for="mother_name">
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.mother_name') }}
                              </template>
                              <b-form-input
                              id="mother_name"
                              v-model="details.mother_name"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                      <b-row>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                              <ValidationProvider name="NID" vid="nid" rules="required|min:10|max:17" v-slot="{ errors }">
                                  <b-form-group
                                      label-cols-sm="5"
                                      style="margin-left:12px;"
                                      label-for="nid">
                                      <template v-slot:label>
                                        {{ $t('tcbconfiguration.nid') }}<span class="text-danger">*</span>
                                      </template>
                                      <b-form-input
                                      id="nid"
                                      v-model="details.nid"
                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                            </b-col>
                        <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                          <ValidationProvider name="Date of birth" vid="date_of_birth" rules="required">
                          <b-form-group
                            label-cols-sm="5"
                            label-for="date_of_birth"
                            slot-scope="{ valid, errors }"
                          >
                            <template v-slot:label>
                              {{ $t('globalTrans.dob') }}<span class="text-danger">*</span>
                            </template>
                              <date-picker
                                id="price_collection_date"
                                maxDate= "15.12.2017"
                                v-model="price_collection_date"
                                class="form-control"
                                :state="errors[0] ? false : (valid ? true : null)"
                                :placeholder="$t('globalTrans.select')"
                                :locale="currentLocale"
                              >
                              </date-picker>
                              <div class="invalid-feedback d-block" v-if="errors.length">
                                {{ errors[0] }}
                              </div>
                          </b-form-group>
                          </ValidationProvider>
                        </b-col>
                          </b-row>
                          <b-row>
                          <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                            <ValidationProvider name="Age" vid="age" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    style="margin-left:12px;"
                                    label-for="age">
                                    <template v-slot:label>
                                      {{ $t('tcbconfiguration.age') }} <span class="text-danger"></span>
                                    </template>
                                    <b-form-input
                                    id="age"
                                    disabled
                                    v-model="age"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                            <ValidationProvider name="Card No." vid="card_no" rules="required|min:1|max:15" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="card_no">
                                    <template v-slot:label>
                                      {{ $t('tcbconfiguration.card_no') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                    id="card_no"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    v-model="card"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                        <!-- <b-row>
                          <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                              <ValidationProvider name="Name of head of family bn" vid="name_of_head_of_family_bn" v-slot="{ errors }">
                                  <b-form-group
                                      label-cols-sm="5"
                                      style="margin-left:12px;"
                                      label-for="name_of_head_of_family_bn">
                                      <template v-slot:label>
                                        {{ $t('tcbconfiguration.name_of_head_of_family_bn') }}
                                      </template>
                                      <b-form-input
                                      id="card_no"
                                      v-model="details.name_of_head_of_family_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                              <ValidationProvider name="Name of head of family" vid="name_of_head_of_family" v-slot="{ errors }">
                                  <b-form-group
                                      label-cols-sm="5"
                                      label-for="name_of_head_of_family">
                                      <template v-slot:label>
                                        {{ $t('tcbconfiguration.name_of_head_of_family') }}
                                      </template>
                                      <b-form-input
                                      id="name_of_head_of_family"
                                      v-model="details.name_of_head_of_family"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                            </b-col>
                        </b-row> -->
                        <b-row>
                          <b-col lg="12" sm="12" md="12">
                          <ValidationProvider name="Is allowance recepient" vid="is_allowance_recipient">
                            <b-form-group
                              class="row"
                              label-cols-sm="5"
                              style="margin-left:12px;"
                              label-for="is_allowance_recipient"
                              slot-scope="{ valid, errors }"
                            >
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.is_allowance_recipient') }}
                              </template>
                              <b-form-checkbox
                                id="Internal"
                                v-model="is_allowance_recipient"
                                :state="errors[0] ? false : (valid ? true : null)"
                                style="transform: translateY(7px);"
                                >{{ $i18n.locale === 'en' ? 'yes' : 'হ্যাঁ' }}</b-form-checkbox>
                                <div class="invalid-feedback">
                                  {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                          </b-col>
                        </b-row>
                          <b-row>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                              <ValidationProvider name="Member in family" vid="member_in_family" :rules="details.member_in_family === 0 ? `` : `min:1|max:2`" v-slot="{ errors }">
                                  <b-form-group
                                      label-cols-sm="5"
                                      style="margin-left:12px;"
                                      label-for="member_in_family">
                                      <template v-slot:label>
                                        {{ $t('tcbconfiguration.member_in_family') }}
                                      </template>
                                      <b-form-input
                                      id="member_in_family"
                                      v-model="details.member_in_family"
                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                              <ValidationProvider name="family net monthly income" :rules="details.family_net_monthly_income === 0 ? `` : `max:5`" vid="family_net_monthly_income" v-slot="{ errors }">
                                  <b-form-group
                                      label-cols-sm="5"
                                      label-for="family_net_monthly_income">
                                      <template v-slot:label>
                                        {{ $t('tcbconfiguration.family_net_monthly_income') }}
                                      </template>
                                      <b-form-input
                                      id="family_net_monthly_income"
                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                      v-model="details.family_net_monthly_income"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                            </b-col>
                          </b-row>
                          <b-row>
                        <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                          <ValidationProvider name="family net monthly expense" :rules="details.family_net_monthly_expense === 0 ? `` : `max:5`" vid="family_net_monthly_expense" v-slot="{ errors }">
                              <b-form-group
                                  label-cols-sm="5"
                                  style="margin-left:12px;"
                                  label-for="family_net_monthly_expense">
                                  <template v-slot:label>
                                    {{ $t('tcbconfiguration.family_net_monthly_expense') }}
                                  </template>
                                  <b-form-input
                                  id="family_net_monthly_expense"
                                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                  v-model="details.family_net_monthly_expense"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                          <ValidationProvider name="Mobile" vid="mobile" rules="required|min:11|max:11" v-slot="{ errors }">
                            <b-form-group
                              label-cols-sm="5"
                              label-for="mobile">
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.mobile') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="mobile"
                                v-model="details.mobile"
                                :state="errors[0] ? false : (valid ? true : null)"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                    </b-row>
                      <b-row>
                        <!-- <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                          <ValidationProvider name="Photo" vid="photo" v-slot="{ errors }">
                              <b-form-group
                                  label-cols-sm="5"
                                  label-for="photo">
                                  <template v-slot:label>
                                    {{ $t('userManagement.photo') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                  id="photo"
                                  v-model="details.photo"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                        </b-col> -->
                        <b-col lg="6" md="6" sm="12">
                            <ValidationProvider name="Occupation" vid='occupation' v-slot="{ errors }" rules="required|min_value:1">
                                <b-form-group
                                    label-cols-sm="5"
                                    style="margin-left:12px;"
                                    label-for="occupation"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.occupation') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="occupation"
                                        :options="occupationList"
                                        id="occupation"
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
                        <b-col lg="6" md="6" sm="12">
                            <ValidationProvider name="Gender" vid='gender' rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="gender"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.gender') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="gender"
                                        :options="genderList"
                                        id="gender"
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
                      </b-row>
                      <b-row>
                      <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                        <ValidationProvider name="Benificiary Photo" vid="applicant_image" :rules="lentH > 0 ? `` : `required`">
                          <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="applicant_image"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                              {{ $t('userManagement.photo') }}<span class="text-danger">*</span>
                            </template>
                            <b-input-group>
                              <b-form-file
                                name="applicant_image"
                                accept=".pdf,.jpeg,.jpg"
                                v-model="details.applicant_image"
                                @change="onChange($event)"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-file>
                                <b-input-group-append v-if="details.applicant_image_url">
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+details.applicant_image_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                              </b-input-group-append>
                            </b-input-group>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                        <div v-if="photo" style="margin-bottom:150px;">
                        <img class="img-thumbnail" style="height: 130px;position: absolute;margin-top: -6px;margin-left: 218px;" :src="baseUrl + 'download-attachment?file=storage/' + photo" alt="Profile Image">
                        </div>
                      </b-col>
                      </b-row>
                <b-row else>
                  <b-col md="12" sm="12" style="margin-top:20px;">
                    <b-row>
                        <b-col>
                            <div style="font-size:15px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                <h6 class="text-white text-left">
                                    {{ $t('globalTrans.present_address') }}
                                </h6>
                            </div>
                        <hr>
                        </b-col>
                    </b-row>
                  </b-col>
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3">
                    <ValidationProvider name="Area Type" vid="pre_area_type_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="pre_area_type_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pre_area_type_id"
                            :options="preareaTypeList"
                            id="pre_area_type_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3" v-if="pre_area_type_id > 0">
                    <ValidationProvider name="Division" vid="pre_division_id" rules="required|min_value:1">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="pre_division_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pre_division_id"
                            :options="predivisionList"
                            id="pre_division_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="pre_area_type_id > 0">
                    <ValidationProvider name="District" vid="pre_district_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="pre_district_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pre_district_id"
                            :options="predistrictList"
                            id="pre_district_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="pre_area_type_id === 1">
                    <ValidationProvider name="City Corporation" vid="pre_city_corporation_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            label-for="pre_city_corporation_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pre_city_corporation_id"
                            :options="precityCorporationList"
                            id="pre_city_corporation_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="pre_area_type_id === 2 || pre_area_type_id === 3">
                    <ValidationProvider name="Upazila" vid="pre_upazila_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="pre_upazila_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pre_upazila_id"
                            :options="preupazilaList"
                            id="pre_upazila_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                    <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                        <ValidationProvider name="address bn" vid="address_bn" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                style="margin-left:12px;"
                                label-for="address_bn">
                                <template v-slot:label>
                                    {{ $t('tcbconfiguration.address_bn') }}
                                </template>
                                <b-form-textarea
                                id="address_bn"
                                v-model="details.pre_address_bn"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-textarea>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                        <ValidationProvider name="address" vid="address" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="address">
                                <template v-slot:label>
                                    {{ $t('tcbconfiguration.address_en') }}
                                </template>
                                <b-form-textarea
                                id="address"
                                v-model="details.pre_address_en"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-textarea>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                  </b-row>
                <b-row>
                  <b-col md="12" sm="12" style="margin-top:20px;">
                    <b-row>
                        <b-col>
                            <div style="font-size:15px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                <h6 class="text-white text-left">
                                    {{ $t('globalTrans.permanent_address') }}
                                </h6>
                            </div>
                        <hr>
                        </b-col>
                    </b-row>
                  </b-col>
                  <b-col lg="6" sm="12">
                    <ValidationProvider name="Address Status" vid="is_same" v-slot="{ errors }">
                        <b-form-group
                            class="row mb-0"
                            label-cols-sm="5"
                            label-for="is_same"
                        >
                        <b-form-checkbox
                            v-model="isSameAsPermanent"
                            value="1"
                            @change="isSameAsPermanentFunc($event)"
                            unchecked-value="0"
                            :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <span class="text-black">{{ $t('tcbconfiguration.is_same') }}</span>
                        </b-form-checkbox>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row>
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3">
                    <ValidationProvider name="Area Type" vid="per_area_type_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="per_area_type_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="per_area_type_id"
                            :options="perareaTypeList"
                            id="per_area_type_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3" v-if="per_area_type_id > 0">
                    <ValidationProvider name="Division" vid="per_division_id" rules="required|min_value:1">
                        <b-form-group
                          label-cols-sm="5"
                          label-for="per_division_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="per_division_id"
                            :options="perdivisionList"
                            id="per_division_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="per_area_type_id > 0">
                    <ValidationProvider name="District" vid="per_district_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="per_district_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="per_district_id"
                            :options="perdistrictList"
                            id="per_district_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="per_area_type_id === 1">
                    <ValidationProvider name="City Corporation" vid="per_city_corporation_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            label-for="per_city_corporation_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="per_city_corporation_id"
                            :options="percityCorporationList"
                            id="per_city_corporation_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="per_area_type_id === 2 || per_area_type_id === 3">
                    <ValidationProvider name="Upazila" vid="per_upazila_id" rules="required|min_value:1">
                        <b-form-group
                            label-cols-sm="5"
                            style="margin-left:12px;"
                            label-for="per_upazila_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="per_upazila_id"
                            :options="perupazilaList"
                            id="per_upazila_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                      <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                        <ValidationProvider name="address bn" vid="address_bn" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                style="margin-left:12px;"
                                label-for="address_bn">
                                <template v-slot:label>
                                    {{ $t('tcbconfiguration.address_bn') }}
                                </template>
                                <b-form-textarea
                                id="address_bn"
                                v-model="details.per_address_bn"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-textarea>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                        <ValidationProvider name="address" vid="address" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="address">
                                <template v-slot:label>
                                    {{ $t('tcbconfiguration.address_en') }}
                                </template>
                                <b-form-textarea
                                id="address"
                                v-model="details.per_address_en"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-textarea>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                </b-row>
                <b-row>
                    <!-- -----------------Add More Start------------------- -->
                    <!-- -----------------Add More End--------------------- -->
                </b-row>
                <b-row class="text-right mb-3">
                    <b-col>
                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                        <router-link :to="{ path: '/license-registration-service/configuration/tcb-configuration/beneficiary-information-entry'}" class="btn btn-danger btn-sm">
                            {{ $t('globalTrans.cancel') }}
                        </router-link>
                    </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
      </b-row>
  </b-container>
  </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { beneficiaryInformationEntryStore, beneficiaryInformationEntryUpdate, beneficiartEntryshow } from '../../../api/routes'

export default {
  components: {
  },
name: 'Form',
props: ['id'],
data () {
  return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      lentH: 0,
      loading: false,
      is_allowance_recipient: null,
      photo: '',
      baseUrl: licenseRegistrationServiceBaseUrl,
      price_collection_date: '',
      isSameAsPermanent: 0,
      beneficiary: {
          area_type_id: 0,
          city_corporation_id: 0,
          regional_office_id: 0,
          pauroshoba_id: 0,
          division_id: 0,
          district_id: 0,
          upazila_id: 0,
          union_id: 0,
          beficiary_details: []
      },
      age: null,
      gender: 0,
      card: '',
      occupation: 0,
      details: {
          id: 0,
          age: null,
          beneficiary_count: '',
          beneficiary_name: '',
          beneficiary_name_bn: '',
          card_no: '',
          dob: '',
          family_net_monthly_expense: null,
          family_net_monthly_income: null,
          father_name: '',
          father_name_bn: '',
          is_allowance_recipient: null,
          member_in_family: '',
          mobile: '',
          mother_name: '',
          mother_name_bn: '',
          name_of_head_of_family: '',
          name_of_head_of_family_bn: '',
          nid: '',
          occupation: 0,
          occupation_bn: '',
          address: '',
          address_bn: '',
          gender: 0,
          pre_area_type_id: 0,
          pre_city_corporation_id: 0,
          pre_pauroshoba_id: 0,
          pre_division_id: 0,
          pre_district_id: 0,
          pre_upazila_id: 0,
          pre_union_id: 0,
          pre_ward_id: 0,
          per_area_type_id: 0,
          per_city_corporation_id: 0,
          per_pauroshoba_id: 0,
          per_division_id: 0,
          per_district_id: 0,
          per_upazila_id: 0,
          per_union_id: 0,
          per_ward_id: 0,
          applicant_image: []
      },
      pre_area_type_id: 0,
      pre_city_corporation_id: 0,
      pre_pauroshoba_id: 0,
      pre_division_id: 0,
      pre_district_id: 0,
      pre_upazila_id: 0,
      pre_union_id: 0,
      pre_ward_id: 0,
      per_area_type_id: 0,
      per_city_corporation_id: 0,
      per_pauroshoba_id: 0,
      per_division_id: 0,
      per_district_id: 0,
      per_upazila_id: 0,
      per_union_id: 0,
      per_ward_id: 0,
      detailsTwo: {},
      predistrictList: [],
      preupazilaList: [],
      preunionList: [],
      prewardList: [],
      prepauroshobaList: [],
      precityCorporationList: [],
      perdistrictList: [],
      perupazilaList: [],
      perunionList: [],
      perwardList: [],
      perpauroshobaList: [],
      percityCorporationList: [],
      is_disable: false
  }
},
created () {
    if (this.$route.query.id) {
        this.price_collection_date = new Date(this.$route.query.item.dob)
        this.details = this.$route.query.item
        this.age = this.details.age
        this.gender = this.details.gender
        this.photo = this.details.photo
        if (this.details.is_allowance_recipient === 1) {
        this.is_allowance_recipient = true
        }
        if (this.photo == null) {
        this.lentH = 0
        } else {
          this.lentH = this.photo.length
        }
        this.occupation = this.details.occupation
        this.per_area_type_id = this.details.per_area_type_id
        this.per_city_corporation_id = this.details.per_city_corporation_id
        this.per_pauroshoba_id = this.details.per_pauroshoba_id
        this.per_division_id = this.details.per_division_id
        this.per_district_id = this.details.per_district_id
        this.per_upazila_id = this.details.per_upazila_id
        this.per_union_id = this.details.per_union_id
        this.per_ward_id = this.details.per_ward_id
        this.pre_area_type_id = this.details.pre_area_type_id
        this.pre_city_corporation_id = this.details.pre_city_corporation_id
        this.pre_pauroshoba_id = this.details.pre_pauroshoba_id
        this.pre_division_id = this.details.pre_division_id
        this.pre_district_id = this.details.pre_district_id
        this.pre_upazila_id = this.details.pre_upazila_id
        this.pre_union_id = this.details.pre_union_id
        this.pre_ward_id = this.details.pre_ward_id
        this.card = this.details.card_no
        this.saveBtnName = this.$t('globalTrans.update')
    }
},
computed: {
  currentLocale () {
      return this.$i18n.locale
  },
  perareaTypeList: function () {
      const list = this.$store.state.commonObj.typeList
      return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
          } else {
              return { value: obj.id, text: obj.name }
          }
      })
  },
  preareaTypeList: function () {
      const list = this.$store.state.commonObj.typeList
      return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
          } else {
              return { value: obj.id, text: obj.name }
          }
      })
  },
  genderList: function () {
        return this.$store.state.commonObj.genderList.map(el => {
            return Object.assign({ value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
  },
  occupationList: function () {
    var occupation = [
      {
        value: 1,
        text_en: 'Housewife',
        text_bn: 'গৃহিণী',
        text: 'Housewife'
      },
      {
        value: 2,
        text_en: 'Employee',
        text_bn: 'চাকুরিজীবী',
        text: 'Employee'
      },
      {
        value: 3,
        text_en: 'Day Laborer',
        text_bn: 'দিনমজুর',
        text: 'Day Laborer'
      },
      {
        value: 4,
        text_en: 'Farmer',
        text_bn: 'কৃষক',
        text: 'Farmer'
      }
    ]
    return occupation.map(el => {
      return Object.assign({ value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
    })
  },
  perdivisionList: function () {
    return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
  },
  predivisionList: function () {
    return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
  }
},
watch: {
  // 'details.beneficiary_name_bn': function (newVal, oldVal) {
  //     const error = {
  //       success: false,
  //       errors: {
  //       beneficiary_name_bn: [
  //           'The beneficiary name bn field is required.'
  //       ]
  //     }
  //     }
  //     this.$refs.form.setErrors(error.errors)
  //     const fruits = ['Banana', 'Orange', 'Apple', 'Mango']

  //     fruits.splice(2, 0, 'Lemon', 'Kiwi')
  // },
  'details.member_in_family': function (newVal, oldVal) {
    if (this.details.member_in_family.length > 2) {
        this.$toast.error({
          title: this.$t('globalTrans.success'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে দুটি সংখ্যার বেশি নয় এমন একটি মান লিখুন৷।' : 'please enter a value not greater than two digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.details.member_in_family = this.details.member_in_family.slice(0, 2)
    })
    }
  },
    'details.family_net_monthly_income': function (newVal, oldVal) {
    if (this.details.family_net_monthly_income.length > 5) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পাঁচ অঙ্কের বেশি নয়।' : 'please enter a value not greater than five digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.details.family_net_monthly_income = this.details.family_net_monthly_income.slice(0, 5)
    })
    }
  },
  'details.family_net_monthly_expense': function (newVal, oldVal) {
    if (this.details.family_net_monthly_expense.length > 5) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পাঁচ অঙ্কের বেশি নয়।' : 'please enter a value not greater than five digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.details.family_net_monthly_expense = this.details.family_net_monthly_expense.slice(0, 5)
    })
    }
  },
  'details.mobile': function (newVal, oldVal) {
    if (this.details.mobile.length > 15) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পনের অঙ্কের বেশি নয়।' : 'please enter a value not greater than fifteen digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.details.mobile = this.details.mobile.slice(0, 15)
    })
    }
  },
  'details.nid': function (newVal, oldVal) {
    if (this.details.nid.length > 17) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা সতের অঙ্কের বেশি নয়।' : 'please enter a value not greater than seventeen digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.details.nid = this.details.nid.slice(0, 17)
    })
    }
  },
  card: function (newVal, oldVal) {
    if (this.card.length > 15) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পনের অঙ্কের বেশি নয়।' : 'please enter a value not greater than fifteen digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.card = this.card.slice(0, 15)
    })
    }
  },
  pre_division_id: function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.predistrictList = this.getDistrictList(newVal)
      if (oldVal) {
        this.pre_district_id = 0
      }
    } else {
      this.predistrictList = []
    }
  },
  price_collection_date: function (newVal, oldVal) {
    if (newVal !== oldVal) {
    if (this.price_collection_date != null) {
  var birthdate = new Date(this.price_collection_date).getTime()
  var now = new Date().getTime()
  if (birthdate > now) {
          this.$toast.error({
          title: this.$t('globalTrans.success'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে এমন একটি তারিখ নির্বাচন করুন যা আজকের তারিখের চেয়ে বেশি নয়।' : 'please enter a date not greater than todays date',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.price_collection_date = 'can not use that value'
    })
  }
  }
      }
  // now find the difference between now and the birthdate
  var n = (now - birthdate) / 86400000
  this.age = n
  if (n > 365) {
    this.age = n / 365
    var year = Math.floor(this.age)
    this.age = year + ' year' + (year > 1 ? 's ' : ' ')
    n = (n - (year * 365))
  } else {
    this.age = '0 year '
  }
  if (n > 30) {
    var month = n / 30
    month = Math.floor(month)
    this.age = this.age + month + ' month' + (month > 1 ? 's ' : ' ')
    n = n - (month * 30)
  } else {
    this.age = this.age + '0 month '
  }
  if (n < 30) {
      this.age = this.age + Math.floor(n) + ' day' + (n > 1 ? 's' : '')
  }
  // if (n > 30) {
  //   this.age = n / 30
  //   n = n - 30
  // }
  // if (n < 30) {
  //   this.age = n
  // }

  // if (n < 604800) { // less than a week
  //   var day = Math.floor(n / 86400)
  //   this.age = day + ' day' + (day > 1 ? 's' : '')
  // } else if (n < 2629743) { // less than a month
  //   var week = Math.floor(n / 604800)
  //   this.age = week + ' week' + (week > 1 ? 's' : '')
  // } else if (n < 63113852) { // less than 24 months
  //   var month = Math.floor(n / 2629743)
  //   this.age = month + ' month' + (month > 1 ? 's' : '')
  // } else {
  //   var year = Math.floor(n / 31556926)
  //   this.age = year + ' year' + (year > 1 ? 's' : '')
  //   month = Math.floor((n - (n / 31556926)) / 2629743)
  //   month = month % 12
  //   this.age = this.age + month + ' month' + (month > 1 ? 's' : '')
  // }
  },
  pre_district_id: function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.preupazilaList = this.getUpazilaList(newVal)
      this.precityCorporationList = this.getcityCorporationList(newVal)
      if (oldVal) {
        this.pre_upazila_id = 0
      }
    } else {
      this.preupazilaList = []
      this.precityCorporationList = []
    }
  },
  pre_upazila_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.preunionList = this.getUnionList(newVal)
          this.prepauroshobaList = this.getPauroshobaList(newVal)
          if (oldVal) {
            this.pre_union_id = 0
            this.pre_pauroshoba_id = 0
          }
      } else {
         this.preunionList = []
         this.prepauroshobaList = []
      }
  },
  pre_city_corporation_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.prewardList = this.getWardList(newVal)
        if (oldVal) {
          this.pre_ward_id = 0
        }
      } else {
         this.prewardList = []
      }
  },
  pre_pauroshoba_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.prewardList = this.getPauroshobaWardList(newVal)
        if (oldVal) {
          this.pre_ward_id = 0
        }
      } else {
         this.prewardList = []
      }
  },
  pre_union_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.prewardList = this.getUnionWardList(newVal)
          if (oldVal) {
            this.pre_ward_id = 0
          }
      } else {
         this.prewardList = []
      }
  },
  per_division_id: function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.perdistrictList = this.getDistrictList(newVal)
      if (oldVal) {
        this.per_district_id = 0
      }
    } else {
      this.perdistrictList = []
    }
  },
  per_district_id: function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.perupazilaList = this.getUpazilaList(newVal)
      this.percityCorporationList = this.getcityCorporationList(newVal)
      if (oldVal) {
        this.per_upazila_id = 0
      }
    } else {
      this.perupazilaList = []
      this.percityCorporationList = []
    }
  },
  per_upazila_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.perunionList = this.getUnionList(newVal)
          this.perpauroshobaList = this.getPauroshobaList(newVal)
          if (oldVal) {
            this.per_union_id = 0
            this.per_pauroshoba_id = 0
          }
      } else {
         this.perunionList = []
         this.perpauroshobaList = []
      }
  },
  per_city_corporation_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.perwardList = this.getWardList(newVal)
        if (oldVal) {
          this.details.per_ward_id = 0
        }
      } else {
         this.perwardList = []
      }
  },
  per_pauroshoba_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.perwardList = this.getPauroshobaWardList(newVal)
        if (oldVal) {
          this.details.per_ward_id = 0
        }
      } else {
         this.perwardList = []
      }
  },
  per_union_id: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.perwardList = this.getUnionWardList(newVal)
          if (oldVal) {
            this.details.per_ward_id = 0
          }
      } else {
         this.perwardList = []
      }
  }
},
methods: {
  dataReturn () {
    const obj = {
      beneficiary_name_bn: [
          'The beneficiary name bn field is required.'
      ],
      nid: [
          'The nid has already been taken.'
      ],
      card_no: [
          'The card no has already been taken.'
      ]
  }
      this.$refs.form.setErrors(obj)
      const fruits = ['Banana', 'Orange', 'Apple', 'Mango']

      fruits.splice(2, 0, 'Lemon', 'Kiwi')
  },
  isSameAsPermanentFunc (ev) {
    if (this.isSameAsPermanent === '1') {
          var preArea = this.pre_area_type_id
          this.per_area_type_id = preArea
          var preCity = this.pre_city_corporation_id
          this.per_city_corporation_id = preCity
          var prePau = this.pre_pauroshoba_id
          this.per_pauroshoba_id = prePau
          var preDiv = this.pre_division_id
          this.per_division_id = preDiv
          var preDis = this.pre_district_id
          this.per_district_id = preDis
          var preUpa = this.pre_upazila_id
          this.per_upazila_id = preUpa
          var preUnion = this.pre_union_id
          this.per_union_id = preUnion
          var preWard = this.pre_ward_id
          this.per_ward_id = preWard
          this.details.per_address_bn = this.details.pre_address_bn
          this.details.per_address_en = this.details.pre_address_en
    } else {
          this.per_area_type_id = 0
          this.per_city_corporation_id = 0
          this.per_pauroshoba_id = 0
          this.per_division_id = 0
          this.per_district_id = 0
          this.per_upazila_id = 0
          this.per_union_id = 0
          this.per_ward_id = 0
          this.details.per_address_bn = ''
          this.details.per_address_en = ''
    }
  },
  onChange (e) {
    const selectedFile = e.target.files[0]
    const reader = new FileReader()
    reader.onload = (event) => {
      this.details[e.target.name] = event.target.result
    }
    reader.readAsDataURL(selectedFile)
  },
  onChangeTwo (e) {
    alert('hello')
  },
  async getbeneficiary () {
    this.loading = true
    this.is_disable = true
    const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `${beneficiartEntryshow}/${this.$route.query.id}`)
    if (result.success) {
      this.beneficiary = result.data
    }
     this.loading = false
  },
  async addItem () {
    if (this.details.ward_id > 0) {
      const wardName = this.$store.state.CommonService.commonObj.wardList.filter(item => item.value === this.details.ward_id)
      var obj = {
          ward_id: this.details.ward_id,
          ward_name: wardName[0]?.text_en,
          ward_name_bn: wardName[0]?.text_bn,
          beneficiary_count: parseInt(this.details.beneficiary_count)
      }
      if (this.details.key === undefined) {
          const extItem = this.details.pre_beficiary_details.find(eItm => eItm.ward_id === this.details.ward_id)
        if (extItem === undefined) {
          this.is_disable = true
          this.details.pre_beficiary_details.push(obj)
        } else {
          extItem.beneficiary_count += parseInt(this.details.beneficiary_count)
        }
      } else {
          this.details.pre_beficiary_details[this.details.key].ward_id = this.details.ward_id
          this.details.pre_beficiary_details[this.details.key].ward_name = wardName !== undefined ? wardName.text_en : ''
          this.details.pre_beficiary_details[this.details.key].ward_name_bn = wardName !== undefined ? wardName.text_bn : ''
          this.details.pre_beficiary_details[this.details.key].beneficiary_count = this.details.beneficiary_count
      }
       this.details = {
          ward_name: '',
          ward_name_bn: '',
          ward_id: 0,
          beneficiary_count: ''
      }
       this.$refs.form.reset()
    }
  },
  removeItem (item) {
    this.details.pre_beficiary_details.splice(item, 1)
  },
  async saveUpdate () {
    this.loading = true
    this.$store.dispatch('mutateCommonProperties', { loading: true })
    let result = null
    const loadingState = { loading: false, listReload: false }
    this.details.age = this.age
    this.details.gender = this.gender
    this.details.occupation = this.occupation
    this.details.is_allowance_recipient = this.is_allowance_recipient === true ? 1 : 0
    this.details.dob = this.price_collection_date
    this.details.per_area_type_id = this.per_area_type_id
    this.details.per_city_corporation_id = this.per_city_corporation_id
    this.details.per_pauroshoba_id = this.per_pauroshoba_id
    this.details.per_division_id = this.per_division_id
    this.details.per_district_id = this.per_district_id
    this.details.per_upazila_id = this.per_upazila_id
    this.details.per_union_id = this.per_union_id
    this.details.per_ward_id = this.per_ward_id
    this.details.pre_area_type_id = this.pre_area_type_id
    this.details.pre_city_corporation_id = this.pre_city_corporation_id
    this.details.pre_pauroshoba_id = this.pre_pauroshoba_id
    this.details.pre_division_id = this.pre_division_id
    this.details.pre_district_id = this.pre_district_id
    this.details.pre_upazila_id = this.pre_upazila_id
    this.details.pre_union_id = this.pre_union_id
    this.details.pre_ward_id = this.pre_ward_id
    this.details.card_no = this.card

    var formData = new FormData()
    Object.keys(this.details).map(key => {
      formData.append(key, this.details[key])
    })
    if (this.$route.query.id) {
      result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${beneficiaryInformationEntryUpdate}/${this.$route.query.id}`, this.details)
    } else {
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, beneficiaryInformationEntryStore, formData)
    }
    loadingState.listReload = true
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (result.success) {
      this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
      this.$toast.success({
        title: this.$t('globalTrans.success'),
        message: this.$i18n.locale === 'bn' ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
        color: '#D6E09B'
      })
      this.$router.push({ path: '/license-registration-service/configuration/tcb-configuration/beneficiary-information-entry' })
    } else {
      this.$refs.form.setErrors(result.errors)
    }
    this.loading = false
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
  getWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
  },
  getPauroshobaWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.municipality_id === id)
  },
  getUnionWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.union_id === id)
  },
  getPauroshobaList (id) {
     return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
  },
  getcityCorporationList (id) {
    return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
  },
  wardName (wardId) {
    const wardObj = this.$store.state.CommonService.commonObj.wardList.find(item => item.value === wardId)
      if (wardObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return wardObj.text_bn
        } else {
          return wardObj.text_en
        }
      }
    }
}
}
</script>
<style>
.font-bn label {
  font-size: 1rem!important;
}
.toast-message {
  color: white;
}
.toast-title {
  color: white;
}
</style>
