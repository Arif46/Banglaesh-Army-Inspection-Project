<template>
    <div class="application-itmes">
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_info')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Name (En)" vid="applicant_name_en" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="applicant_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.applicant_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.applicant_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Name (Bn)" vid="applicant_name_bn" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="applicant_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.applicant_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.applicant_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Designation (En)" vid="designation_en" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="designation_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.applicant_designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.designation_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Designation (Bn)" vid="designation_bn" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="designation_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.applicant_designation') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.designation_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenConfig.garden_address')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Tea Garden Name (En)" vid="tea_garden_name_en" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="tea_garden_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.tea_garden_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.tea_garden_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Tea Garden Name (Bn)" vid="tea_garden_name_bn" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="tea_garden_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.tea_garden_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formData.tea_garden_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                        <Address :key="address.area_type_id" :data.sync="address" :addressType="'address'" :param="fieldObj" @address-data="receiveAddress" title="Garden Address"/>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_have_garden')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Have other tea garden?" vid="have_other_tea_garden" rules="required">
                                                  <b-form-group slot-scope="{ valid, errors, ariaDescribedby }" label-for="have_other_tea_garden">
                                                    <b-form-radio-group
                                                      class="custom-control-inline-wrapper mb-0"
                                                      size="lg"
                                                      v-model="formData.have_other_tea_garden"
                                                      :options="yesNoList"
                                                      :aria-describedby="ariaDescribedby"
                                                      name="radio-options1"
                                                      :disabled="isRenew"
                                                    >
                                                    </b-form-radio-group>
                                                    <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                    </div>
                                                  </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                        <div v-if="formData.have_other_tea_garden === 1">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Tea Garden Name (En)" vid="tea_garden_name_en" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="tea_garden_name_en"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.tea_garden_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.tea_garden_name_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Tea Garden Name (Bn)" vid="tea_garden_name_bn" rules="">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="tea_garden_name_bn"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.tea_garden_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="formDataAddMore.tea_garden_name_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                        <Address :data="formDataAddMore.address" :addressType="'address'" :param="fieldObj2" @address-data="receiveAddMoreAddress" title="Address" ref="addMoreAddress"/>
                                        <b-row>
                                            <b-col sm="12">
                                                <b-button type="button" class="add-more-btn" size="sm" @click="addData" :disabled="isRenew"><i class="ri-add-line"></i> {{ $t('globalTrans.add_more') }}</b-button>
                                            </b-col>
                                            <b-col sm="12">
                                                <b-table-simple resonsive bordered class="mt-3 mb-0">
                                                    <b-thead>
                                                        <b-tr>
                                                            <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                                            <b-th>{{ $t('teaGardenConfig.tea_garden_name') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.area_type') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.division') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.district') }}</b-th>
                                                            <b-th>{{ $t('globalTrans.action') }}</b-th>
                                                        </b-tr>
                                                    </b-thead>
                                                    <b-tbody>
                                                        <template v-if="formData.others.length">
                                                            <b-tr v-for="(item, index) in formData.others" :key="index">
                                                                <b-td>{{ $n(index + 1) }}</b-td>
                                                                <b-td>{{ currentLocale === 'en' ? item.tea_garden_name_en : item.tea_garden_name_bn }}</b-td>
                                                                <b-td>{{ getAreaTypeName(item.area_type_id) }}</b-td>
                                                                <b-td>{{ getDivisionName(item.division_id) }}</b-td>
                                                                <b-td>{{ getDistrictName(item.district_id) }}</b-td>
                                                                <b-td class="text-center">
                                                                    <a v-if="isRenew" class="text-danger btn-disabled" title="Delete" disabled><i class="ri-delete-bin-6-line"></i></a>
                                                                    <a v-else href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line" @click="deleteItem(index)"></i></a>
                                                                </b-td>
                                                            </b-tr>
                                                        </template>
                                                        <template v-else>
                                                            <b-tr>
                                                                <b-td colspan="6" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                                                            </b-tr>
                                                        </template>
                                                    </b-tbody>
                                                </b-table-simple>
                                            </b-col>
                                        </b-row>
                                        </div>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_capable_of_investing')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Has Investing Capacity" vid="has_investing_capability" rules="required">
                                                  <b-form-group
                                                      slot-scope="{ valid, errors, ariaDescribedby }"
                                                      label-for="has_investing_capability"
                                                  >
                                                    <b-form-radio-group
                                                      class="custom-control-inline-wrapper mb-0"
                                                      v-model="formData.has_investing_capability"
                                                      size="lg"
                                                      :options="yesNoList"
                                                      :aria-describedby="ariaDescribedby"
                                                      name="radio-options"
                                                      :disabled="isRenew"
                                                    >
                                                    </b-form-radio-group>
                                                    <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                    </div>
                                                  </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                        <b-row v-if="formData.has_investing_capability === 1">
                                            <b-col sm="6">
                                                <ValidationProvider name="Amount of Income Tax" vid="income_tax_amount" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="income_tax_amount"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.income_tax_amount') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            step="0.01"
                                                          v-model="formData.income_tax_amount"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                            :disabled="isRenew"
                                                        ></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Bank Solvency Certificate" vid="bank_solvency_certificate" :rules="isRenew ? null : 'required'">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="bank_solvency_certificate"
                                                    >
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.bank_solvency_certificate') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-file
                                                          id="bank_solvency_certificate"
                                                          v-model="formData.bank_solvency_certificate"
                                                          @change="onChange"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                          :disabled="isRenew"
                                                        ></b-form-file>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                                <template class="pb-3" v-if="isFile(formData.bank_solvency_certificate)">
                                                    <a :href="teaGardenServiceBaseUrl + (isImage(formData.bank_solvency_certificate) ? 'storage/' : '') +formData.bank_solvency_certificate" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                                </template>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Method of Rejection (En)" vid="reason_of_rejection_en" rules="">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-cols-sm="12"
                                  label-for="reason_of_rejection_en"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.reason_of_rejection') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="reason_of_rejection_en"
                                      v-model="formData.reason_of_rejection_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Method of Rejection (Bn)" vid="reason_of_rejection_bn" rules="">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-cols-sm="12"
                                  label-for="reason_of_rejection_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.reason_of_rejection') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="reason_of_rejection_bn"
                                      v-model="formData.reason_of_rejection_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Trade Licence/Professional licence No" vid="trade_license_no" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="trade_license_no"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.trade_license_no') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-model="formData.trade_license_no"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Chief Executive Name (En)" vid="chief_executive_name_en" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="chief_executive_name_en"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.chief_executive_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-model="formData.chief_executive_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Chief Executive Name (Bn)" vid="chief_executive_name_bn" rules="required">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="chief_executive_name_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.chief_executive_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      v-model="formData.chief_executive_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Mobile No" vid="mobile" rules="required|min:11|max:11">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="mobile"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.mobile') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      type="tel"
                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                      v-model="formData.mobile"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="E-mail" vid="email" rules="required|email">
                                <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="email"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.email') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="email"
                                      v-model="formData.email"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                    </b-row>
                </b-overlay>
            </b-form>
        </ValidationObserver>
    </div>
</template>

<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { gardenInfoStoreApi, gardenInfoUpdateApi } from '../../api/routes'
import Address from '@/components/Address.vue'
export default {
    props: ['tabFormData', 'status', 'parentId', 'isRenew'],
    components: { Address },
    data () {
        return {
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            fieldObj: {
                xl: 6,
                lg: 6,
                md: 6,
                sm: 12,
                labelCols: 12,
                noCountry: true,
                noAddress: false,
                isPaurashavaNullable: true,
                isUnionNullable: true,
                hasPostCode: true,
                isPostCodeNullable: true,
                noMargin: true
            },
            fieldObj2: {
              xl: 6,
              lg: 6,
              md: 6,
              sm: 12,
              labelCols: 12,
              noCountry: true,
              noAddress: false,
              isAreaTypeNullable: true,
              isDivisionNullable: true,
              isDistrictNullable: true,
              isCityCorporationNullable: true,
              isUpazilaNullable: true,
              isPaurashavaNullable: true,
              isUnionNullable: true,
              hasPostCode: true,
              isPostCodeNullable: true,
              noMargin: true
            },
            valid: null,
            formData: {},
            address: {
              area_type_id: 0,
              division_id: 0,
              district_id: 0,
              city_corporation_id: 0,
              paurashava_id: 0,
              upazila_id: 0,
              union_id: 0,
              ward_id: 0,
              address_details_en: '',
              address_details_bn: ''
            },
            formDataAddMore: {
                tea_garden_name_en: '',
                tea_garden_name_bn: '',
                address: {
                    area_type_id: 0,
                    division_id: 0,
                    district_id: 0,
                    city_corporation_id: 0,
                    paurashava_id: 0,
                    upazila_id: 0,
                    union_id: 0,
                    ward_id: 0,
                    address_details_en: '',
                    address_details_bn: ''
                }
            }
        }
    },
    created () {
    },
    mounted () {
        this.formData = this.tabFormData
        this.address = {
            area_type_id: this.formData.area_type_id,
            division_id: this.formData.division_id,
            district_id: this.formData.district_id,
            city_corporation_id: this.formData.city_corporation_id,
            paurashava_id: this.formData.pauroshoba_id,
            upazila_id: this.formData.upazila_id,
            union_id: this.formData.union_id,
            ward_id: this.formData.ward_id,
            post_code: this.formData.post_code,
            address_details_en: this.formData.address_en,
            address_details_bn: this.formData.address_bn
        }
    },
    computed: {
        loading: function () {
            return this.$store.state.commonObj.loading
        },
        currentLocale () {
            return this.$i18n.locale
        },
        yesNoList () {
            return [
                { text: this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ', value: 1, text_en: 'Yes', text_bn: 'হ্যাঁ' },
                { text: this.currentLocale === 'en' ? 'No' : 'না', value: 2, text_en: 'No', text_bn: 'না' }
            ]
        }
    },
    watch: {
    },
    methods: {
        async submit () {
            var check = await this.$refs.form.validate()
            if (check) {
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                let result
                const data = Object.assign({}, this.formData, { status: this.status, parent_id: this.parentId })
                if (this.formData.id) {
                  result = await RestApi.putData(teaGardenServiceBaseUrl, gardenInfoUpdateApi + '/' + this.formData.id, data)
                } else {
                  result = await RestApi.postData(teaGardenServiceBaseUrl, gardenInfoStoreApi, data)
                }
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$refs.form.setErrors(result.errors)
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: this.$t('globalTrans.form_error_msg'),
                        color: '#ee5253'
                    })
                }
            }
        },
        receiveAddress (address) {
            this.address = address
            this.formData = Object.assign({}, this.formData, {
              area_type_id: this.address.area_type_id,
              division_id: this.address.division_id,
              district_id: this.address.district_id,
              city_corporation_id: this.address.city_corporation_id,
              pauroshoba_id: this.address.paurashava_id,
              upazila_id: this.address.upazila_id,
              union_id: this.address.union_id,
              ward_id: this.address.ward_id,
              post_code: this.address.post_code,
              address_en: this.address.address_details_en,
              address_bn: this.address.address_details_bn
            })
        },
        receiveAddMoreAddress (address) {
            this.formDataAddMore.address = address
        },
        onChange (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.formData.bank_solvency_certificate = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.formData.bank_solvency_certificate = ''
            }
        },
        addData () {
          if (this.formDataAddMore.tea_garden_name_en && this.formDataAddMore.tea_garden_name_bn && this.formDataAddMore.address.area_type_id && this.formDataAddMore.address.division_id && this.formDataAddMore.address.district_id) {
              let objExist
              if (this.formDataAddMore.address.area_type_id === 1) {
                  objExist = this.formData.others.find(item => ((item.tea_garden_name_en.trim() === this.formDataAddMore.tea_garden_name_en.trim()) || (item.tea_garden_name_bn.trim() === this.formDataAddMore.tea_garden_name_bn.trim())) && item.area_type_id === parseInt(this.formDataAddMore.address.area_type_id) && item.division_id === parseInt(this.formDataAddMore.address.division_id) && item.district_id === parseInt(this.formDataAddMore.address.district_id) && item.city_corporation_id === parseInt(this.formDataAddMore.address.city_corporation_id))
              } else if (this.formDataAddMore.address.area_type_id === 2) {
                  objExist = this.formData.others.find(item => ((item.tea_garden_name_en.trim() === this.formDataAddMore.tea_garden_name_en.trim()) || (item.tea_garden_name_bn.trim() === this.formDataAddMore.tea_garden_name_bn.trim())) && item.area_type_id === parseInt(this.formDataAddMore.address.area_type_id) && item.division_id === parseInt(this.formDataAddMore.address.division_id) && item.district_id === parseInt(this.formDataAddMore.address.district_id) && item.upazila_id === parseInt(this.formDataAddMore.address.upazila_id) && item.pauroshoba_id === parseInt(this.formDataAddMore.address.paurashava_id))
              } else {
                  objExist = this.formData.others.find(item => (item.tea_garden_name_en.trim() === this.formDataAddMore.tea_garden_name_en.trim() || item.tea_garden_name_bn.trim() === this.formDataAddMore.tea_garden_name_bn.trim()) && item.area_type_id === parseInt(this.formDataAddMore.address.area_type_id) && item.division_id === parseInt(this.formDataAddMore.address.division_id) && item.district_id === parseInt(this.formDataAddMore.address.district_id) && item.upazila_id === parseInt(this.formDataAddMore.address.upazila_id) && item.union_id === parseInt(this.formDataAddMore.address.union_id))
              }
              if (objExist !== undefined) {
                  return this.$toast.error({
                      title: 'Error',
                      message: 'This address info already exists',
                      color: '#ee5253'
                  })
              }
            const obj = {
                tea_garden_name_en: this.formDataAddMore.tea_garden_name_en.trim(),
                tea_garden_name_bn: this.formDataAddMore.tea_garden_name_bn.trim(),
                area_type_id: this.formDataAddMore.address.area_type_id,
                division_id: this.formDataAddMore.address.division_id,
                district_id: this.formDataAddMore.address.district_id,
                city_corporation_id: this.formDataAddMore.address.city_corporation_id,
                upazila_id: this.formDataAddMore.address.upazila_id,
                pauroshoba_id: this.formDataAddMore.address.paurashava_id,
                union_id: this.formDataAddMore.address.union_id,
                ward_id: this.formDataAddMore.address.ward_id,
                post_code: this.formDataAddMore.address.post_code,
                address_en: this.formDataAddMore.address.address_details_en,
                address_bn: this.formDataAddMore.address.address_details_bn
            }
            this.formData.others.push(obj)
            this.$refs.addMoreAddress.resetAll()
            this.formDataAddMore = Object.assign({}, {
              tea_garden_name_en: '',
              tea_garden_name_bn: '',
              address: {
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                ward_id: 0,
                address_details_en: '',
                address_details_bn: ''
              }
            })
          } else {
              this.$toast.error({
                  title: 'Error',
                  message: 'Please fill address information correctly',
                  color: '#ee5253'
              })
          }
        },
        deleteItem (index) {
            this.formData.others.splice(index, 1)
        },
        getAreaTypeName (id) {
            const obj = this.$store.state.commonObj.areaTypeList.find(item => item.value === parseInt(id))
            return obj?.text
        },
        getDivisionName (id) {
            const obj = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === parseInt(id))
            return obj?.text
        },
        getDistrictName (id) {
            const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === parseInt(id))
            return obj?.text
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
