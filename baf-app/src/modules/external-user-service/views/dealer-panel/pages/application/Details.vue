<template>
  <div>
    <b-tabs content-class="mt-3" class="custom-tabs">
      <b-tab :title="$t('license_management.application')" active>
        <div>
          <div class="text-right">
              <b-button variant="primary" @click="pdfExport" class="btn btn-sm mb-2">
                  <i class="ri-printer-line"></i> {{  $t('globalTrans.print') }}
              </b-button>
          </div>
          <div style="border: 1px solid gray;font-family: Poppins, sans-serif;font-size: 12px">
            <b-row style="margin: 20px">
              <b-col md="12" class="">
                <div v-if="appDetail.doc_verified" class="text-right mt-2 mb-2">
                  <div class="tagTwo">
                    {{ $t('dealer.document_verified') }}
                  </div>
                </div>
                <div class="text-center" style="border-bottom: 2px solid gray;font-weight: 600">
                  <h5 class="card-title">{{ $t('dealer.application_form') }}</h5>
                </div>
                <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                  <!-- <div class="" style="width:50%"><b>{{ $t('license_management.agreement_no') }}</b> : {{ (appDetail.agreement_no ? $n(appDetail.agreement_no, { useGrouping: false }) : '') }}</div> -->
                  <!-- <div class="text-right" style="width:50%"><b>{{ $t('externalLrcpn.expire_date') }}</b> : {{ appDetail.expire_date | dateFormat }}</div> -->
                </div>
                <div class="stepper-wrapper">
                  <div :class="item.value <= appDetail.status ? `stepper-item completed` : `stepper-item`" v-for="(item, index) in stepList" :key="index">
                    <div class="step-counter">
                      <i v-if="item.value < appDetail.status || appDetail.agreement_no" class="ri-check-fill"></i>
                        <span v-else>{{ $n(index+1) }}</span>
                    </div>
                    <div class="step-name">{{ item.text }}</div>
                  </div>
                </div>
                <div class="mt-4">
                  <p>{{ $t('dealer.chairman') }}</p>
                  <p>{{ $t('dealer.tcb') }}</p>
                  <p>{{ $t('dealer.tcb_address') }}</p>
                  <p style="font-weight: 600;margin-top: 10px;margin-bottom: 10px;">{{ $t('dealer.subject') }}</p>
                  <span>{{ $t('dealer.sir') }}</span>
                  <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    {{ $t('dealer.application_text_one') }}
                  </p>
                </div>
                <div class="table-wrapper table-responsive mt-2">
                  <table class="table table-striped table-hover table-bordered">
                    <tbody>
                      <tr>
                        <td width="21%" style="font-weight:600">
                          {{ $t('dealer.applicant_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.applicant_name_bn : appDetail.details.applicant_name }}</td>
                        <td width="20%" style="font-weight:600">
                          {{ $t('dealer.father_spouse_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.father_spouse_name_bn : appDetail.details.father_spouse_name }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.company_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name }}</td>
                        <td style="font-weight:600">
                          {{ $t('dealer.dob') }} :
                        </td>
                        <td>{{ appDetail.details.dob | dateFormat }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.nid_no') }} :
                        </td>
                        <td>{{ $n(appDetail.details.nid_no, { useGrouping: false }) }}</td>
                        <td style="font-weight:600">
                          {{ $t('dealer.marital_status') }} :
                        </td>
                        <td>{{ getMeritalStatus(appDetail.details.marital_status) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.spouse_nid_no') }} :
                        </td>
                        <td>{{ appDetail.details.spouse_nid_no ? $n(appDetail.details.spouse_nid_no, { useGrouping: false }) : '' }}</td>
                        <td style="font-weight:600">
                          {{ $t('dealer.father_nid_no') }} :
                        </td>
                        <td>{{ appDetail.details.father_nid_no ? $n(appDetail.details.father_nid_no, { useGrouping: false }) : '' }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.email') }} :
                        </td>
                        <td>{{ appDetail.details.email }}</td>
                        <td style="font-weight:600">
                          {{ $t('dealer.tin_no') }} :
                        </td>
                        <td>{{ $n(appDetail.details.tin_no, { useGrouping: false } ) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.mobile') }} :
                        </td>
                        <td class="text-left" colspan="3">{{ appDetail.details.mobile | mobileNumber }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div>
                  <h6 class="mb-3 tag">{{ $t('dealer.dealer_condition_msg') }} <span class="ml-3">:</span> <span class="ml-3"> {{ appDetail.details.other_family_license ? $t('globalTrans.yes') : $t('globalTrans.no') }}</span></h6>
                </div>
                <div v-if="appDetail.details.other_family_license" class="table-wrapper table-responsive">
                  <table class="table table-striped table-hover table-bordered">
                    <tbody>
                      <tr>
                        <td width="20%" style="font-weight:600">
                          {{ $t('dealer.dealer_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.other_dealer_name_bn : appDetail.details.other_dealer_name }}</td>
                        <td width="20%" style="font-weight:600">
                          {{ $t('dealer.company_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.other_company_name_bn : appDetail.details.other_company_name }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.division') }} :
                        </td>
                        <td>{{ getDivisionName(appDetail.details.other_company_division_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.district') }} :
                        </td>
                        <td>{{ getDistrictName(appDetail.details.other_company_district_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.upazila') }} :
                        </td>
                        <td colspan="3">{{ getUpazillaName(appDetail.details.other_company_upazilla_id) }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div>
                  <h6 class="mb-3 tag">{{ $t('dealer.company_details') }}</h6>
                </div>
                <div class="table-wrapper table-responsive">
                  <table class="table table-striped table-hover table-bordered">
                    <tbody>
                      <tr>
                        <!-- <td width="20%" style="font-weight:600">
                          {{ $t('allocation_management.dealer_type') }} :
                        </td> -->
                        <!-- <td>{{ getDealerType(appDetail.dealer_type) }}</td> -->
                        <td width="20%" style="font-weight:600">
                          {{ $t('dealer.company_name') }} :
                        </td>
                        <td>{{ $i18n.locale ==  'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.office') }} :
                        </td>
                        <td>{{ getOfficeName(appDetail.office_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('orgProfile.city_corporation') }} :
                        </td>
                        <td>{{ getCityCorName(appDetail.details.company_city_corporation_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.division') }} :
                        </td>
                        <td>{{ getDivisionName(appDetail.details.company_division_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.district') }} :
                        </td>
                        <td>{{ getDistrictName(appDetail.details.company_district_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.upazila') }} :
                        </td>
                        <td>{{ getUpazillaName(appDetail.details.company_upazilla_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.union') }} :
                        </td>
                        <td>{{ getUnionName(appDetail.details.company_union_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.ward') }} :
                        </td>
                        <td>{{ getWardName(appDetail.details.company_ward_id) }}</td>
                      </tr>
                      <!-- <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.office') }} :
                        </td>
                        <td colspan="3">{{ getOfficeName(appDetail.office_id) }}</td>
                      </tr> -->
                    </tbody>
                  </table>
                </div>
                <div>
                  <h6 class="mb-3 tag">{{ $t('dealer.permanent_address') }}</h6>
                </div>
                <div class="table-wrapper table-responsive">
                  <table class="table table-striped table-hover table-bordered">
                    <tbody>
                      <tr>
                        <td width="20%" style="font-weight:600">
                          {{ $t('orgProfile.city_corporation') }} :
                        </td>
                        <td width="30%">{{ getCityCorName(appDetail.details.company_city_corporation_id) }}</td>
                        <td width="20%" style="font-weight:600">
                          {{ $t('globalTrans.division') }} :
                        </td>
                        <td width="25%">{{ getDivisionName(appDetail.details.division_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.district') }} :
                        </td>
                        <td>{{ getDistrictName(appDetail.details.district_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.upazila') }} :
                        </td>
                        <td>{{ getUpazillaName(appDetail.details.upazilla_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.union') }} :
                        </td>
                        <td>{{ getUnionName(appDetail.details.union_id) }}</td>
                        <td style="font-weight:600">
                          {{ $t('globalTrans.ward') }} :
                        </td>
                        <td>{{ getWardName(appDetail.details.company_ward_id) }}</td>
                      </tr>
                      <tr>
                        <td style="font-weight:600">
                          {{ $t('dealer.village') }} :
                        </td>
                        <td class="text-left" colspan="4">{{ $i18n.locale == 'bn' ? appDetail.details.village_bn : appDetail.details.village }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <p>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  {{ $t('dealer.application_text_two') }}
                </p>
                <b-row>
                  <b-col md="8">
                  </b-col>
                  <b-col md="12" class="mt-5">
                    <div>
                      <h6 class="mb-3 tag">{{ $t('dealer.important_document') }}</h6>
                    </div>
                  </b-col>
                  <b-col md="7">
                    <div>
                      <ul>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(1) }}. {{ $t('dealer.applicant_image') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.applicant_image">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.applicant_image"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(2) }}. {{ $t('dealer.trade_license') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.trade_license">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.trade_license"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(3) }}. {{ $t('dealer.bank_solvency') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.bank_solvency">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.bank_solvency"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(4) }}. {{ $t('dealer.nid') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.nid">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.nid"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(5) }}. {{ $t('dealer.tin') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.tin">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.tin"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(6) }}. {{ $t('dealer.vat_certificate') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.vat_certificate">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.vat_certificate"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(7) }}. {{ $t('dealer.shop_document') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.shop_document">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.shop_document"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                        <li>
                          <div class="d-flex justify-content-between">
                            <span>{{ $n(8) }}. {{ $t('dealer.citizen_certificate') }}</span>
                            <div class="list-btn">
                              <div v-if="appDetail.details.citizen_certificate">
                                <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.citizen_certificate"><i style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                              </div>
                              <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                            </div>
                          </div>
                        </li>
                      </ul>
                    </div>
                  </b-col>
                </b-row>
              </b-col>
            </b-row>
          </div>
        </div>
      </b-tab>
      <b-tab v-if="appDetail.reviews.length" :title="$t('dealer.notes')">
        <div class="row">
          <div class="col-md-10 offset-md-1">
            <div v-for="(review, index) in appDetail.reviews" :key="index">
              <b-card class="mt-2">
                <span :class="review.action_type === 2 ? `badge badge-danger` : `badge badge-warning`">{{ getStatusName(review.action_type) }}</span>
                <b-card-text class="mt-3">
                  <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? review.note_bn : review.note_en }}</span>
                </b-card-text>
              </b-card>
            </div>
          </div>
        </div>
      </b-tab>
      <b-tab v-if="appDetail.review_status" :title="$t('dealer.feedback')">
        <div class="row">
          <div class="col-md-10 offset-md-1">
            <b-card class="mt-2">
              <p class="badge badge-success">{{ $t('license_management.review') }}</p>
              <b-card-text class="mt-3">
                <b-form-rating v-model="appDetail.feedback.rating" readonly variant="warning" class="mb-2"></b-form-rating>
                <div class="mt-2">
                  <b>{{ $t('globalTrans.note') }}</b> : <span>{{ appDetail.feedback.comment }}</span>
                </div>
              </b-card-text>
            </b-card>
            <b-card class="mt-2">
              <p class="badge badge-warning">{{ $t('dealer.feedback') }}</p>
              <b-card-text class="mt-3">
                <div class="mt-2">
                  <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? appDetail.feedback.feedback_bn : appDetail.feedback.feedback }}</span>
                </div>
              </b-card-text>
            </b-card>
          </div>
        </div>
      </b-tab>
      <b-tab v-if="appDetail.agreement_no" :title="$t('license_management.agreement')">
        <div>
          <b-card>
            <b-card-body>
              <b-overlay>
                  <b-row>
                    <b-col md="10" offset-md="1">
                      <div class="text-center mb-4 mt-2">
                        <h5 class="card-title" style="border-bottom: 2px solid gray;font-weight: 600">{{ $t('license_management.agreement') }}</h5>
                      </div>
                      <div>
                        <table class="table table-striped table-hover table-bordered">
                          <tbody>
                            <tr>
                              <td width="50%">
                                {{ $t('globalTrans.application_id') }}
                              </td>
                              <td class="text-left">{{ $n(appDetail.application_id, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                              <td width="50%">
                                {{ $t('license_management.agreement_no') }}
                              </td>
                              <td class="text-left">{{ $n(appDetail.agreement_no, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                              <td width="50%">
                                {{ $t('license_management.agreement_date') }}
                              </td>
                              <td class="text-left">{{ appDetail.agreement_date | dateFormat }}</td>
                            </tr>
                            <tr>
                              <td width="50%">
                                {{ $t('license_management.agreement_expire_date') }}
                              </td>
                              <td class="text-left">{{ appDetail.expire_date | dateFormat  }}</td>
                            </tr>
                            <tr>
                              <td width="50%">
                                {{ $t('license_management.attachment') }}
                              </td>
                              <td class="text-left" v-if="appDetail.agreement_attachment"><a target="_blank" :href="licenseRegistrationServiceBaseUrl + appDetail.agreement_attachment"><button style="padding: 2px 10px;" class="btn btn-success btn-sm ml-1"><i class="ri-download-2-line"></i> {{ $t('globalTrans.download') }}</button></a></td>
                              <td class="text-left" v-else><button style="padding: 2px 10px;" class="btn btn-success btn-sm ml-1">{{ $t('dealer.attachment_status') }}</button></td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </b-col>
                  </b-row>
              </b-overlay>
            </b-card-body>
          </b-card>
        </div>
      </b-tab>
    </b-tabs>
  </div>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Pdf from './pdf'
export default {
  name: 'Details',
  props: ['appDetail', 'applications'],
  components: {
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
    }
  },
  created () {
  },
  computed: {
    stepList () {
      const tcbStepList = this.$store.state.ExternalUserService.dealerPanel.commonObj.tcbStepList.filter(item => item.value !== 5).map(item => {
        return this.$i18n.locale === 'bn' ? { value: item.value, text: item.text_bn } : { value: item.value, text: item.text_en }
      })
      return tcbStepList
    }
  },
  methods: {
    getStatusName (status) {
      return status === 2 ? this.$t('dealer.reject') + ' ' + this.$t('globalTrans.note') : this.$t('dealer.resubmit') + ' ' + this.$t('globalTrans.note')
    },
    getDealerType (id) {
      const type = this.$store.state.ExternalUserService.dealerPanel.commonObj.sellerTypeList.find(item => item.value === parseInt(id))
      if (typeof type !== 'undefined') {
        return this.$i18n.locale === 'bn' ? type.text_bn : type.text_en
      } else {
        return ''
      }
    },
    getMeritalStatus (id) {
      const maritalStatus = this.$store.state.ExternalUserService.dealerPanel.commonObj.maritalStatusList.find(item => item.value === parseInt(id))
      if (typeof maritalStatus !== 'undefined') {
        return this.$i18n.locale === 'bn' ? maritalStatus.text_bn : maritalStatus.text_en
      } else {
        return ''
      }
    },
    getCityCorName (id) {
      const data = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getPouroName (id) {
      const data = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getWardName (id) {
      const data = this.$store.state.CommonService.commonObj.wardList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getDivisionName (id) {
      const data = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getUpazillaName (id) {
      const data = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getDistrictName (id) {
      const data = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getUnionName (id) {
      const data = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getOfficeName (id) {
      const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    pdfExport () {
        const reportTitle = this.$t('li_step.expiration_passed_report')
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.appDetail)
    }
  }
}
</script>
<style scoped lang="scss">
</style>
