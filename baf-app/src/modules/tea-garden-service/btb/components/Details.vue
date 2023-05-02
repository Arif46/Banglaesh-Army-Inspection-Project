<template>
    <card>
      <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('dealer.application_form') }}</h4>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col sm="12">
                <b-tabs content-class="mt-0" fill>
                  <!--  Tab of Application Start  -->
                  <b-tab :title="$t('license_management.application')" active>
                    <div v-if="loading">
                      <Loading />
                    </div>
                    <b-overlay v-else>
                      <div class="p-3">
                        <b-row>
                          <b-col sm="12">
                            <div class="text-right">
                              <b-button variant="primary" @click="pdfExport" class="btn btn-sm mb-2">
                                <i class="ri-printer-line"></i> {{ $t('globalTrans.print') }}
                              </b-button>
                            </div>
                            <div>
                              <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                                <div class="" style="width:50%"><b>{{ $t('externalUser.issue_date') }}</b> : {{
                                  appDetail.application.issue_date | dateFormat }}</div>
                                <div class="text-right" style="width:50%"><b>{{ $t('externalLrcpn.expire_date') }}</b> : {{
                                  appDetail.application.expired_date | dateFormat }}</div>
                              </div>
                              <div class="stepper-wrapper">
                                <div :class="item.value <= appDetail.application.status ? `stepper-item completed` : `stepper-item`"
                                  v-for="(item, index) in stepList" :key="index">
                                  <div class="step-counter">
                                    <i v-if="item.value <= appDetail.application.status" class="ri-check-fill"></i>
                                    <span v-else>{{ $n(index+1) }}</span>
                                  </div>
                                  <div class="step-name">{{ item.text }}</div>
                                </div>
                              </div>
                              <!-- Application view start -->
                              <div class="application-form-wrapper application-form-view-wrapper mt-5">
                                <div>
                                  <h5
                                    style="border-bottom: 2px solid #2f3542;width: 65%;margin: 3rem auto;padding-bottom: 5px;text-align: center;">{{ $t('teaGardenPanel.small_tea_garden_registration') }}</h5>
                                </div>
                                <div class="application-itmes">
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_info')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.applicant_name')" label-for="ApplicantNameEn">
                                            <p class="input-field">{{ currentLocale === 'en' ? appDetail.applicant_name_en : appDetail.applicant_name_bn }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.designation')" label-for="DesignationEn">
                                            <p class="input-field">{{ currentLocale === 'en' ? appDetail.designation_en : appDetail.designation_bn }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenConfig.garden_address')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenConfig.tea_garden_name')" label-for="TeaGardenNameEn">
                                            <p class="input-field">{{ currentLocale === 'en' ? appDetail.tea_garden_name_en : appDetail.tea_garden_name_bn }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.area_type')" label-for="AreaType">
                                            <p class="input-field">{{ getAreaTypeName(appDetail.area_type_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <!-- City Corporation Area Type -->
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.division')" label-for="Division">
                                            <p class="input-field">{{ getDivisionName(appDetail.division_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.district')" label-for="District">
                                            <p class="input-field">{{ getDistrictName(appDetail.district_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="appDetail.area_type_id === 1">
                                          <b-form-group :label="$t('globalTrans.city_corporation')" label-for="CityCorporation">
                                            <p class="input-field">{{ getCityCorName(appDetail.city_corporation_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="appDetail.area_type_id === 2 || appDetail.area_type_id === 3">
                                          <b-form-group :label="$t('globalTrans.upazila')" label-for="Upazila">
                                            <p class="input-field">{{ getUpazillaName(appDetail.upazila_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="appDetail.area_type_id === 2">
                                          <b-form-group :label="$t('globalTrans.pouroshova')" label-for="puroshova">
                                            <p class="input-field">{{ getPouroName(appDetail.pauroshoba_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="appDetail.area_type_id === 3">
                                          <b-form-group :label="$t('globalTrans.union')" label-for="Union">
                                            <p class="input-field">{{ getUnionName(appDetail.union_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.ward')" label-for="Ward">
                                            <p class="input-field">{{ getWardName(appDetail.ward_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('bazarMonitoring.post_code')" label-for="PostCode">
                                            <p class="input-field">{{ appDetail.post_code ? $n(appDetail.post_code) : '' }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.address')" label-for="AddressEn">
                                            <p class="input-field">{{ currentLocale === 'en' ? appDetail.address_en : appDetail.address_bn }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_have_garden')"
                                      label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group label-for="AddressEn">
                                            <p class="input-field">{{ getYesNoValue(appDetail.have_other_tea_garden) }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row v-if="appDetail.have_other_tea_garden === 1">
                                        <b-col sm="12">
                                          <div class="table-responsive">
                                            <table class="table table-sm table-bordered">
                                              <thead>
                                                <tr>
                                                  <th>{{ $t('teaGardenConfig.tea_garden_name') }}</th>
                                                  <th>{{ $t('globalTrans.area_type') }}</th>
                                                  <th>{{ $t('globalTrans.division') }}</th>
                                                  <th>{{ $t('globalTrans.district') }}</th>
                                                  <th>{{ $t('globalTrans.address') }}</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr v-for="(item, index) in appDetail.others" :key="index">
                                                <td>{{ currentLocale === 'en' ? item.tea_garden_name_en : item.tea_garden_name_bn }}</td>
                                                <td>{{ getAreaTypeName(item.area_type_id) }}</td>
                                                <td>{{ getDivisionName(item.division_id) }}</td>
                                                <td>{{ getDistrictName(item.district_id) }}</td>
                                                  <td>{{ currentLocale === 'en' ? item.address_en : item.address_bn }}</td>
                                                </tr>
                                              </tbody>
                                            </table>
                                          </div>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3"
                                      :label="$t('teaGardenPanel.applicant_capable_of_investing')"
                                      label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">{{ getYesNoValue(appDetail.has_investing_capability) }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row v-if="appDetail.has_investing_capability === 1">
                                        <b-col sm="12">
                                          <b-form-group :label="$t('teaGardenPanel.income_tax_amount')"
                                            label-for="AmountIncomeTaxPaidLastYear">
                                            <p class="input-field">{{ $n(appDetail.income_tax_amount) }} {{ $t('globalTrans.tk') }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <b-row>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group :label="$t('teaGardenPanel.reason_of_rejection')"
                                          label-for="ApplicationRegistrationRejectedBefore" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">{{ currentLocale === 'en' ? appDetail.reason_of_rejection_en : appDetail.reason_of_rejection_bn }}</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group :label="$t('teaGardenPanel.trade_license_no')"
                                          label-for="TradeLicenceProfessionallicenceNo" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">{{ $n(appDetail.trade_license_no) }}</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group :label="$t('globalTrans.mobile')" label-for="MobileNo" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">{{ appDetail.mobile | mobileNumber }}</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group :label="$t('globalTrans.email')" label-for="MailingAddress" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">{{ appDetail.email }}</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                  </b-row>
                                  <div class="group-form-card mt-2">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.identity_of_proprietor')" label-size="md"
                                      label-class="font-weight-bold py-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <div class="group-form-card">
                                            <b-form-group :label="$t('dealer.company_name')" label-for="MailingAddress" class="form-view-item">
                                              <div class="form-group">
                                                <p class="input-field">{{ currentLocale === 'en' ? appDetail.proprietor_identity.company_name_en : appDetail.proprietor_identity.company_name_bn }}</p>
                                              </div>
                                            </b-form-group>
                                          </div>
                                        </b-col>
                                      </b-row>
                                      <b-row>
                                        <b-col sm="12">
                                          <div class="table-responsive">
                                            <table class="table table-sm table-bordered mt-2">
                                              <thead>
                                                <tr>
                                                  <th>{{ $t('teaGardenPanel.owner_name') }}</th>
                                                  <th>{{ $t('globalTrans.father_name') }}</th>
                                                  <th>{{ $t('globalTrans.mother_name') }}</th>
                                                  <th>{{ $t('globalTrans.nationality') }}</th>
                                                  <th>{{ $t('globalTrans.mobile') }}</th>
                                                  <th>{{ $t('globalTrans.permanent_address') }}</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <template v-if="appDetail.proprietor_identity.owners.length">
                                                  <tr v-for="(item, index) in appDetail.proprietor_identity.owners" :key="index">
                                                    <td>{{ currentLocale === 'en' ? item.garden_owner_name_en : item.garden_owner_name_bn }}</td>
                                                    <td>{{ currentLocale === 'en' ? item.garden_owner_father_name_en : item.garden_owner_father_name_bn }}</td>
                                                    <td>{{ currentLocale === 'en' ? item.garden_owner_mother_name_en : item.garden_owner_mother_name_bn }}</td>
                                                    <td>{{ getNationalityName(item.garden_owner_nationality) }}</td>
                                                    <td>{{ item.mobile | mobileNumber }}</td>
                                                    <td>{{ currentLocale === 'en' ? item.permanent_address_en : item.permanent_address_bn }}</td>
                                                  </tr>
                                                </template>
                                                <template v-else>
                                                  <tr>
                                                    <td colspan="6" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                                  </tr>
                                                </template>
                                              </tbody>
                                            </table>
                                          </div>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <b-row>
                                    <b-col sm="12">
                                      <div class="group-form-card">
                                        <b-form-group
                                          :label="$t('teaGardenPanel.experience')"
                                          label-for="ExperienceOwnerTeaProductionTrade" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">
                                              {{ currentLocale === 'en' ? appDetail.proprietor_identity.experience_en : appDetail.proprietor_identity.experience_bn  }}
                                            </p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                  </b-row>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.ownership_acquired_type')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.year_of_granting_lease')" label-for="YearGrantingLease">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.year_of_granting_lease, { useGrouping: false }) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.period_of_lease')" label-for="PeriodLease">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.period_of_lease, { useGrouping: false }) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.particular_of_land')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.total_grant_area')" label-for="TotalGrantArea">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.total_grant_area) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.area_under_tea')" label-for="AreaUnderTea">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.area_under_tea) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.total_suitable_land')" label-for="TotalSuitableArea">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.total_suitable_land) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.total_unsuitable_land')" label-for="TotalUnSuitableArea">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.total_unsuitable_land) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mb-4">
                                    <b-form-group
                                      :label="$t('teaGardenPanel.favour_garden_land')"
                                      label-for="FavourGardenRecordedPerLastSettlementRecords" class="form-view-item">
                                      <div class="form-group">
                                        <p class="input-field">{{ currentLocale === 'en' ? appDetail.land_ownership_info.favour_garden_land_en  : appDetail.land_ownership_info.favour_garden_land_bn }}</p>
                                      </div>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.land_schedule_owner')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.mouja')" label-for="Mouja">
                                            <div class="form-group">
                                              <p class="input-field">{{ appDetail.land_ownership_info.mouja }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.khotian')" label-for="KhotianNo">
                                            <div class="form-group">
                                              <p class="input-field">
                                                {{ $n(appDetail.land_ownership_info.khotian_no, { useGrouping: false }) }}
                                              </p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.dag_no')" label-for="DagNo">
                                            <div class="form-group">
                                              <p class="input-field">
                                                {{ $n(appDetail.land_ownership_info.dag_no, { useGrouping: false }) }}
                                              </p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.plantation_product_start_year')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.year_plantation')"
                                            label-for="YearPlantationtartedFirst">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.year_plantation, { useGrouping: false }) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.year_production')"
                                            label-for="YearProductionStartedFirst">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.year_production, { useGrouping: false }) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.last_three_year_production')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.average_production')" label-for="AverageProduction">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.average_production) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.average_sale_price')" label-for="AverageSalePrice">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.average_sale_price) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mb-4">
                                    <b-form-group :label="$t('teaGardenPanel.appointed_broker_name')"
                                      label-for="NameAppointedBrokersTeaMarketing" class="form-view-item">
                                      <div class="form-group">
                                        <p class="input-field">{{ currentLocale === 'en' ? appDetail.land_ownership_info.appointed_broker_name_en : appDetail.land_ownership_info.appointed_broker_name_bn }}</p>
                                      </div>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.does_garden_possesses_factory')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group label-for="yesNo">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.land_ownership_info.does_garden_possesses_factory) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row v-if="appDetail.land_ownership_info.does_garden_possesses_factory === 1">
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.production_capacity')" label-for="ProductionCapacity">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.production_capacity) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.transformer_capacity')" label-for="CapacityTransformer">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.transformer_capacity) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.withering_capacity')" label-for="WithiringCapacity">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.land_ownership_info.withering_capacity) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.other_facilities')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item mb-0">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.residence_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_residence_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.school_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_school_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.hospital_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_hospital_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.mosque_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_mosque_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.club_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_club_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.drinking_water_facilities')">
                                            <div class="form-group">
                                              <p class="input-field">{{ getYesNoValue(appDetail.other_info.has_drinking_water_facilities) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.manpower_information')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.no_of_officers')" label-for="OfficerNo">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.other_info.no_of_officers) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.no_of_stuffs')" label-for="StaffNo">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.other_info.no_of_stuffs) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group :label="$t('teaGardenPanel.no_of_workers')" label-for="WorkerNo">
                                            <div class="form-group">
                                              <p class="input-field">{{ $n(appDetail.other_info.no_of_workers) }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <!-- <div>
                                                      <p class="mb-5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To my knowledge of belief, the particulars stated supplied in this application are true and correct. I shall be bound to abide by all laws/orders and instructions issued by the Government of Bangladesh and the Bangladesh Tea Board relating to production and marketing of Tea.</p>
                                                    </div>
                                                    <div class="group-form-card">
                                                      <b-row>
                                                        <b-col sm="4">
                                                          <b-form-group label="Place:" class="form-view-item">
                                                            <div class="form-group">
                                                              <p class="input-field" style="padding: 12px 8px;"></p>
                                                            </div>
                                                          </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                          <div class="form-view-item">
                                                            <p class="seal-wrapper">Seal</p>
                                                          </div>
                                                        </b-col>
                                                        <b-col sm="4">
                                                          <b-form-group label="Signature of the applicant:" class="form-view-item">
                                                            <div class="form-group">
                                                              <p class="input-field" style="padding: 20px 8px;"></p>
                                                            </div>
                                                          </b-form-group>
                                                        </b-col>
                                                      </b-row>
                                                    </div> -->
                                  <div class="group-form-card mt-4">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.first_witness_info')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.witness_name')">
                                            <div class="form-group">
                                              <p class="input-field">{{ currentLocale === 'en' ?  appDetail.witness_info.first_witness_name_en : appDetail.witness_info.first_witness_name_bn }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('globalTrans.address')">
                                            <div class="form-group">
                                              <p class="input-field">{{ currentLocale === 'en' ?  appDetail.witness_info.first_witness_address_en : appDetail.witness_info.first_witness_address_bn }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mt-4">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.second_witness_info')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenPanel.witness_name')">
                                            <div class="form-group">
                                              <p class="input-field">{{ currentLocale === 'en' ?  appDetail.witness_info.second_witness_name_en : appDetail.witness_info.second_witness_name_bn }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Address :">
                                            <div class="form-group">
                                              <p class="input-field">{{ currentLocale === 'en' ?  appDetail.witness_info.second_witness_address_en : appDetail.witness_info.second_witness_address_bn }}</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                </div>
                              </div>
                              <b-row>
                                <b-col md="6">
                                  <div>
                                    <h6 class="mb-3 tag">{{ $t('dealer.important_document') }}</h6>
                                  </div>
                                  <div>
                                    <ul>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(1) }}. {{ $t('teaGardenPanel.bank_solvency_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.bank_solvency_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(appDetail.bank_solvency_certificate) ? 'storage/' : '') + appDetail.bank_solvency_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(2) }}. {{ $t('teaGardenPanel.garden_sketch_map') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.land_ownership_info.garden_sketch_map">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(appDetail.land_ownership_info.garden_sketch_map) ? 'storage/' : '') + appDetail.land_ownership_info.garden_sketch_map"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(3) }}. {{ $t('teaGardenPanel.land_schedule_copy') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.land_ownership_info.land_schedule_copy">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(appDetail.land_ownership_info.land_schedule_copy) ? 'storage/' : '') +appDetail.land_ownership_info.land_schedule_copy"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(4) }}. {{ $t('teaGardenPanel.khotian_attested_copy') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.land_ownership_info.khotian_attested_copy">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank" :href="teaGardenServiceBaseUrl + (isImage(appDetail.land_ownership_info.khotian_attested_copy) ? 'storage/' : '') +appDetail.land_ownership_info.khotian_attested_copy"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(5) }}. {{ $t('teaGardenPanel.registered_deed_attested_copy') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.land_ownership_info.registered_deed_attested_copy">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank" :href="teaGardenServiceBaseUrl + (isImage(appDetail.land_ownership_info.registered_deed_attested_copy) ? 'storage/' : '') +appDetail.land_ownership_info.registered_deed_attested_copy"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                    </ul>
                                  </div>
                                </b-col>
                              </b-row>
                            </div>
                          </b-col>
                          <b-col md="12" class="text-right">
                            <b-button variant="primary " class="btn-sm" @click="back()">{{ $t('globalTrans.back') }}</b-button>
                          </b-col>
                        </b-row>
                      </div>
                    </b-overlay>
                  </b-tab>
                  <!--  Tab of Application End  -->

                  <!--  Tab of Forward Start  -->
                  <b-tab :title="$t('license_management.forward_history')" v-if="appDetail.application.forwards.length">
                    <div v-if="forwarLoad || loading" class="col-md-12">
                      <forward-loading></forward-loading>
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(forward, index) in appDetail.application.forwards" :key="index">
                          <b-card>
                            <b-card-title>
                              <h5 style="font-size:17px">{{ getCardTitle(forward.status) }}</h5>
                            </b-card-title>
                            <b-card-sub-title style="font-size:14px">
                              <span class="badge badge-success">{{ $t('license_management.sender') }}</span> : {{
                              getUserName(forward.sender_id) }} <i class=" ml-3 ri-arrow-right-line"></i>
                              <span class="badge badge-primary ml-3">{{ $t('license_management.receiver') }}</span> : {{
                              getUserName(forward.receiver_id) }}
                            </b-card-sub-title>
                            <b-card-text class="mt-3">
                              <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? forward.remarks : forward.remarks
                                }}</span>
                            </b-card-text>
                          </b-card>
                        </div>
                      </div>
                    </div>
                  </b-tab>
                  <!--  Tab of Forward End  -->

                  <!--  Tab of Recommendation Start  -->
                  <b-tab v-if="appDetail.application.recommendations.length" :title="$t('teaGardenPanel.recommendation_history')">
                    <div v-if="loading">
                      <RecommendationLoading />
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(recommendation, index) in appDetail.application.recommendations" :key="index">
                          <b-card v-if="recommendation.status !== 1">
                            <b-card-title>
                              <h5 style="font-size:17px">{{ getCardTitleRecommendation(recommendation.status) }}</h5>
                            </b-card-title>
                            <b-card-text class="mt-3">
                              <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? recommendation.remarks : recommendation.remarks
                                }}</span>
                            </b-card-text>
                            <div v-if="recommendation.attachment" class="text-right">
                              <a target="_blank" :href="teaGardenServiceBaseUrl + (isImage(recommendation.attachment) ? 'storage/' : '') + recommendation.attachment"><button
                                style="padding: 2px 10px;" class="btn btn-success btn-sm"><i class="ri-download-2-line"></i> {{
                                $t('globalTrans.download') }}</button></a>
                            </div>
                          </b-card>
                        </div>
                      </div>
                    </div>
                  </b-tab>
                  <!--  Tab of Recommendation End  -->
                </b-tabs>
              </b-col>
            </b-row>
          </template>
      </body-card>
    </card>
</template>
<script>
import RestApi, { authServiceBaseUrl, licenseRegistrationServiceBaseUrl, teaGardenServiceBaseUrl } from '@/config/api_config'
import RecommendationLoading from './loading/RecommendationLoading.vue'
import ForwardLoading from './loading/ForwardLoading.vue'
import Loading from './loading/Details.vue'
// import { tcbApplicationShow } from '../api/routes'
import Pdf from './tea-garden-application-pdf'
export default {
  name: 'Details',
  components: {
    Loading,
    ForwardLoading,
    RecommendationLoading
  },
  data () {
    return {
      // loading: false,
      forwarLoad: false,
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      appDetail: {
        id: 0,
        applicant_name_en: '',
        applicant_name_bn: '',
        designation_en: '',
        designation_bn: '',
        tea_garden_name_en: '',
        tea_garden_name_bn: '',
        area_type_id: 0,
        division_id: 0,
        district_id: 0,
        city_corporation_id: 0,
        upazila_id: 0,
        pauroshoba_id: 0,
        union_id: 0,
        ward_id: 0,
        post_code: '',
        address_en: '',
        address_bn: '',
        have_other_tea_garden: 1,
        has_investing_capability: 1,
        income_tax_amount: '',
        bank_solvency_certificate: '',
        reason_of_rejection_en: '',
        reason_of_rejection_bn: '',
        trade_license_no: '',
        chief_executive_name_en: '',
        chief_executive_name_bn: '',
        mobile: '',
        email: '',
        others: [],
        proprietor_identity: {
          id: 0,
          garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
          company_name_en: '',
          company_name_bn: '',
          proprietor_type: 1,
          experience: '',
          status: 2,
          owners: []
        },
        land_ownership_info: {
          id: 0,
          garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
          ownership_acquired_type: 1,
          year_of_granting_lease: '',
          period_of_lease: '',
          total_grant_area: '',
          area_under_tea: '',
          total_suitable_land: '',
          total_unsuitable_land: '',
          favour_garden_land_en: '',
          favour_garden_land_bn: '',
          mouja: '',
          khotian_no: '',
          dag_no: '',
          garden_sketch_map: '',
          land_schedule_copy: '',
          khotian_attested_copy: '',
          registered_deed_attested_copy: '',
          year_plantation: '',
          year_production: '',
          average_production: '',
          average_sale_price: '',
          appointed_broker_name_en: '',
          appointed_broker_name_bn: '',
          does_garden_possesses_factory: 1,
          production_capacity: '',
          transformer_capacity: '',
          withering_capacity: '',
          status: 2
        },
        other_info: {
          id: 0,
          garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
          has_residence_facilities: 1,
          has_school_facilities: 1,
          has_hospital_facilities: 1,
          has_mosque_facilities: 1,
          has_club_facilities: 1,
          has_drinking_water_facilities: 1,
          no_of_officers: '',
          no_of_stuffs: '',
          no_of_workers: '',
          status: 2
        },
        witness_info: {
          id: 0,
          garden_info_id: this.$route.query.id ? this.$route.query.id : 0,
          first_witness_name_en: '',
          first_witness_name_bn: '',
          first_witness_address_en: '',
          first_witness_address_bn: '',
          second_witness_name_en: '',
          second_witness_name_bn: '',
          second_witness_address_en: '',
          second_witness_address_bn: '',
          are_agree: false,
          status: 2
        },
        application: {
          id: 0,
          issue_date: '',
          expired_date: '',
          status: 2,
          recommendations: [],
          forwards: []
        }
      },
      users: []
    }
  },
  created () {
    this.getAppDetail()
  },
  computed: {
    appId () {
      return this.$route.params.id
    },
    stepList () {
      // const tcbStepList = this.$store.state.LicenseRegistrationService.commonObj.tcbStepList.filter(item => item.value !== 5).map(item => {
      //   return this.$i18n.locale === 'bn' ? { value: item.value, text: item.text_bn } : { value: item.value, text: item.text_en }
      // })
      const tcbStepList = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Draft' : 'খসড়া', text_en: 'Draft', text_bn: 'খসড়া' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'খসড়া', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Recommendation' : 'সুপারিশ', text_en: 'Recommendation', text_bn: 'সুপারিশ' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Recommended' : 'প্রস্তাবিত', text_en: 'Recommended', text_bn: 'প্রস্তাবিত' },
        { value: 6, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' }
      ]
      return tcbStepList
    },
    currentLocale () {
      return this.$i18n.locale
    },
    nationalityList () {
      return [
        { text: this.currentLocale === 'en' ? 'Bangladeshi' : 'বাংলাদেশী', value: 1, text_en: 'Bangladeshi', text_bn: 'বাংলাদেশী' },
        { text: this.currentLocale === 'en' ? 'Others' : 'অন্যান্য', value: 2, text_en: 'Others', text_bn: 'অন্যান্য' }
      ]
    },
    yesNoList () {
      return [
        { text: this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ', value: 1, text_en: 'Yes', text_bn: 'হ্যাঁ' },
        { text: this.currentLocale === 'en' ? 'No' : 'না', value: 2, text_en: 'No', text_bn: 'না' }
      ]
    },
    loading () {
      return this.$store.state.commonObj.loading
    },
    forwardStatusList () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'খসড়া', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Reject' : 'বাতিল', text_en: 'Reject', text_bn: 'বাতিল' }
      ]
      return list
    },
    recommendStatusList () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'খসড়া', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Recommended' : 'প্রস্তাবিত', text_en: 'Recommended', text_bn: 'প্রস্তাবিত' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Reject' : 'বাতিল', text_en: 'Reject', text_bn: 'বাতিল' }
      ]
      return list
    }
  },
  methods: {
    getStatusName (status) {
      return status === 2 ? this.$t('dealer.reject') + ' ' + this.$t('globalTrans.note') : this.$t('dealer.resubmit') + ' ' + this.$t('globalTrans.note')
    },
    getMeritalStatus (id) {
      const maritalStatus = this.$store.state.LicenseRegistrationService.commonObj.maritalStatusList.find(item => item.value === parseInt(id))
      if (typeof maritalStatus !== 'undefined') {
        return this.$i18n.locale === 'bn' ? maritalStatus.text_bn : maritalStatus.text_en
      } else {
        return ''
      }
    },
    getCardTitle (status) {
      const tgServiceStep = this.forwardStatusList.find(item => item.value === parseInt(status))
      if (typeof tgServiceStep !== 'undefined') {
        return this.$i18n.locale === 'bn' ? tgServiceStep.text_bn : tgServiceStep.text_en
      } else {
        return ''
      }
    },
    getCardTitleRecommendation (status) {
      const tgServiceStep = this.recommendStatusList.find(item => item.value === parseInt(status))
      if (typeof tgServiceStep !== 'undefined') {
        return this.$i18n.locale === 'bn' ? tgServiceStep.text_bn : tgServiceStep.text_en
      } else {
        return ''
      }
    },
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
        // this.loading = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, 'tea-garden-panel/tea-garden-application/garden-info/show/' + this.appId)
        if (result.success) {
          this.appDetail = result.data
          if (this.appDetail.application.forwards && this.appDetail.application.forwards.length) {
            await this.getForwardedUsers(this.appDetail.application.forwards)
          }
        }
        // this.loading = false
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getAreaTypeName (id) {
      const obj = this.$store.state.commonObj.areaTypeList.find(item => item.value === parseInt(id))
      return this.$i18n.locale === 'bn' ? obj?.text_bn : obj?.text_en
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
    getUserName (userId) {
      const user = this.users.find(user => parseInt(user.value) === parseInt(userId))
      return typeof user !== 'undefined' ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
    },
    async getForwardedUsers (forwards) {
      this.forwarLoad = true
      var userIds = []
      forwards.map((item, key) => {
        userIds.push(item.sender_id)
        userIds.push(item.receiver_id)
      })
      const params = Object.assign({}, { user_ids: userIds })
      await RestApi.getData(authServiceBaseUrl, '/user-detail-by-user-ids', params).then(response => {
          if (response.length) {
            this.users = response
          } else {
            this.users = []
          }
          this.forwarLoad = false
      })
    },
    getDealerType (id) {
      const type = this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList.find(item => item.value === parseInt(id))
      if (typeof type !== 'undefined') {
        return this.$i18n.locale === 'bn' ? type.text_bn : type.text_en
      } else {
        return ''
      }
    },
    pdfExport () {
        const reportTitle = this.$t('teaGardenPanel.small_tea_garden_registration')
        Pdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this)
    },
    getNationalityName (id) {
      const obj = this.nationalityList.find(item => item.value === id)
      return obj?.text
    },
    getYesNoValue (id) {
      const obj = this.yesNoList.find(item => item.value === id)
      return obj?.text
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    }
  }
}
</script>
<style scoped>
  .tag {
    font-weight: 600;
    border-left: 4px solid #1c4261;
    padding-left: 6px;
  }
  .download-btn {
    color: green;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 2px 4px;
  }
  .yes-btn {
    color: green;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 1px 3px;
  }
  .no-btn {
    color: red;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 1px 3px;
    margin-right: 33px !important;
  }
  .tag {
    font-weight: 600;
    border-left: 4px solid #1c4261;
    padding-left: 6px;
  }
  .download-btn {
    color: green;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 2px 4px;
  }
  .yes-btn {
    color: green;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 1px 3px;
  }
  .no-btn {
    color: red;
    border: 1px solid gray;
    margin-left: 5px;
    font-size: 18px;
    padding: 1px 3px;
    margin-right: 33px !important;
  }

.stepper-wrapper {
    margin-top: auto;
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    }
    .stepper-item {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      flex: 1;
    }

    @media (max-width: 768px) {
        font-size: 12px;
    }
    .stepper-item::before {
    position: absolute;
    content: "";
    border-bottom: 2px solid #ccc;
    width: 100%;
    top: 20px;
    left: -50%;
    z-index: 2;
    }

    .stepper-item::after {
    position: absolute;
    content: "";
    border-bottom: 2px solid #ccc;
    width: 100%;
    top: 20px;
    left: 50%;
    z-index: 2;
    }

    .stepper-item .step-counter {
    position: relative;
    z-index: 5;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #ccc;
    margin-bottom: 6px;
    color: white;
    }

    .stepper-item.active {
    font-weight: bold;
    }

    .stepper-item.completed .step-counter {
    background-color: #4bb543;
    color:white;
    }

    .stepper-item.completed::after {
    position: absolute;
    content: "";
    border-bottom: 2px solid #4bb543;
    width: 100%;
    top: 20px;
    left: 50%;
    z-index: 3;
    }

    .stepper-item:first-child::before {
    content: none;
    }
    .stepper-item:last-child::after {
    content: none;
    }
    .step-name {
        color: black;
        font-weight: bold;
        font-size: 11px;
    }
.tagTwo {
  position: relative;
  display: inline-block;
  border-radius: 6px;
  clip-path: polygon(20px 0px, 100% 0px, 100% 100%, 0% 100%, 0% 20px);
  background: hsl(250deg, 100%, 40%);
  padding: 5px 25px;
  font-weight: 600;
  font-size: 12px;
  color: #FFF;
  transition: clip-path 500ms;
}
.tagTwo:after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 20px;
  height: 20px;
  background: hsl(252deg, 100%, 60%);
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1);
  border-radius: 0 0 6px 0;
  transition: transform 500ms;
}
</style>
