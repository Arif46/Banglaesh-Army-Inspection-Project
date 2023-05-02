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
                              <div v-if="application.application.status === 6" class="text-right mt-2 mb-2">
                                <div class="tagTwo">
                                  {{ $t('dealer.document_verified') }}
                                </div>
                              </div>
                              <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                                <div class="" style="width:50%"><b>{{ $t('teaGardenService.application_id') }}</b> : {{
                                  application.application.app_id }}</div>
                                <div class="text-right" style="width:50%"><b>{{ $t('externalLrcpn.expire_date') }}</b> : {{
                                  application.application.expired_date | dateFormat }}</div>
                              </div>
                              <div class="stepper-wrapper">
                                <div :class="item.value <= application.application.status ? `stepper-item completed` : `stepper-item`"
                                  v-for="(item, index) in stepList" :key="index">
                                  <div class="step-counter">
                                    <i v-if="item.value <= application.application.status" class="ri-check-fill"></i>
                                    <span v-else>{{ $n(index+1) }}</span>
                                  </div>
                                  <div class="step-name">{{ item.text }}</div>
                                </div>
                              </div>
                              <!-- Application view start -->
                              <div class="application-form-wrapper application-form-view-wrapper mt-5">
                              <div>
                                  <h5 style="border-bottom: 2px solid #2f3542;width: 40%;margin: 3rem auto;padding-bottom: 5px;text-align: center;">{{ $t('teaGardenPanel.tea_factory_service') }} {{ $t('globalTrans.details') }}</h5>
                              </div>
                              <div class="application-itmes">
                                <!-- general info  -->
                                <div class="group-form-card" v-if="application.factory_info">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.general_info')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.factory_type')} :`">
                                                    <p class="input-field">{{ getFactoryTypeName(application.factory_type_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.manufacturing_method')} :`">
                                                    <p class="input-field">{{ getMadeTypeNames(application.manufacturing_methods) }}</p>
                                                </b-form-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </div>
                                <!-- garden info  -->
                                <div class="group-form-card" v-if="application.factory_type_id === 1">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.garden_info')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.garden_name')} :`">
                                                    <p class="input-field">{{ getGardenName(application.garden_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                              <b-form-group :label="`${$t('teaGardenPanel.owner_name')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.garden_info.owner_name_en : application.garden_info.owner_name_bn }}</p>
                                              </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.email')} :`">
                                                    <p class="input-field">{{ application.garden_info.email }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.mobile')} :`">
                                                    <p class="input-field">{{ application.garden_info.mobile ? EngBangNum(application.garden_info.mobile) : '' }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.division')} :`">
                                                    <p class="input-field">{{ getDivisionName(application.garden_info.division_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.district')} :`">
                                                    <p class="input-field">{{ getDistrictName(application.garden_info.district_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.garden_info.city_corporation_id && application.garden_info.city_corporation_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.city_corporation')} :`">
                                                    <p class="input-field">{{ getCityCorporationName(application.garden_info.city_corporation_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.garden_info.upazila_id && application.garden_info.upazila_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.upazila')} :`">
                                                    <p class="input-field">{{ getUpzillaName(application.garden_info.upazila_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.garden_info.pauroshoba_id && application.garden_info.pauroshoba_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.municipality_name')} :`">
                                                    <p class="input-field">{{ getPauroshobaName(application.garden_info.pauroshoba_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.garden_info.union_id && application.garden_info.union_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.union')} :`">
                                                    <p class="input-field">{{ getUnionName(application.garden_info.union_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.address')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.garden_info.garden_address_en : application.garden_info.garden_address_bn }}</p>
                                                </b-form-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </div>
                                <!-- applicant info  -->
                                <div class="group-form-card" v-if="application.factory_type_id === 2 || application.factory_type_id === 3">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_label')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.applicant_name')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.applicant_name_en : application.applicant_name_bn }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.email')} :`">
                                                    <p class="input-field">{{ application.applicant_email }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.mobile')} :`">
                                                    <p class="input-field">{{ application.applicant_mobile ? EngBangNum(application.applicant_mobile) : '' }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenService.nid')} :`">
                                                    <p class="input-field">{{ application.applicant_nid ? EngBangNum(application.applicant_nid) : '' }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.applicant_type')} :`">
                                                    <p class="input-field">{{ application.applicant_type ? getApplicantTypeName(application.applicant_type) : '' }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.division')} :`">
                                                    <p class="input-field">{{ getDivisionName(application.division_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.district')} :`">
                                                    <p class="input-field">{{ getDistrictName(application.district_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.city_corporation_id && application.city_corporation_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.city_corporation')} :`">
                                                    <p class="input-field">{{ getCityCorporationName(application.city_corporation_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.upazila_id && application.upazila_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.upazila')} :`">
                                                    <p class="input-field">{{ getUpzillaName(application.upazila_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.paurashoba_id && application.paurashoba_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.municipality_name')} :`">
                                                    <p class="input-field">{{ getPauroshobaName(application.paurashoba_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.union_id && application.union_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.union')} :`">
                                                    <p class="input-field">{{ getUnionName(application.union_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.address')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.address_en : application.address_bn }}</p>
                                                </b-form-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </div>
                                <!-- factory info  -->
                                <div class="group-form-card" v-if="application.factory_info">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.factory_info_label')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.division')} :`">
                                                    <p class="input-field">{{ getDivisionName(application.factory_info.division_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenConfig.district')} :`">
                                                    <p class="input-field">{{ getDistrictName(application.factory_info.district_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.factory_info.city_corporation_id && application.factory_info.city_corporation_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.city_corporation')} :`">
                                                    <p class="input-field">{{ getCityCorporationName(application.factory_info.city_corporation_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.factory_info.upazila_id && application.factory_info.upazila_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.upazila')} :`">
                                                    <p class="input-field">{{ getUpzillaName(application.factory_info.upazila_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.factory_info.paurashoba_id && application.factory_info.paurashoba_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.municipality_name')} :`">
                                                    <p class="input-field">{{ getPauroshobaName(application.factory_info.paurashoba_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6" v-if="application.factory_info.union_id && application.factory_info.union_id !== 0">
                                                <b-form-group :label="`${$t('teaGardenConfig.union')} :`">
                                                    <p class="input-field">{{ getUnionName(application.factory_info.union_id) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.address')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.factory_info.address_en : application.factory_info.address_bn }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.total_land_factory_established')} :`">
                                                    <p class="input-field">{{ $n(application.factory_info.total_land_factory_established) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.production_capacity')} :`">
                                                    <p class="input-field">{{ $n(application.factory_info.production_capacity) }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.source_of_funding')} :`">
                                                    <p class="input-field">{{ currentLocale === 'en' ? application.factory_info.source_of_funding_en : application.factory_info.source_of_funding_bn }}</p>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="`${$t('teaGardenPanel.processed_area')} :`">
                                                    <p class="input-field">{{ application.factory_info.processed_area ? getFactoryProcessedArea(application.factory_info.processed_area) : ''  }}</p>
                                                </b-form-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </div>
                                <!-- machineries info  -->
                                <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.machineries_info_label')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="12">
                                              <table class="table table-sm table-bordered section-tree-view-table">
                                                  <thead>
                                                      <tr>
                                                          <th>{{ $t('teaGardenPanel.machine_name') }}</th>
                                                          <th>{{ $t('teaGardenPanel.capacity_kg_per_hour') }}</th>
                                                          <th>{{ $t('teaGardenPanel.capacity_kg_per_year') }}</th>
                                                      </tr>
                                                  </thead>
                                                  <tbody>
                                                      <slot v-for="(item, index) in application.machineries_info">
                                                        <tr :key="index">
                                                          <td>{{ currentLocale === 'en' ? item.machine_name_en : item.machine_name_bn }}</td>
                                                          <td>{{ $n(item.capacity_per_hour) }}</td>
                                                          <td>{{ $n(item.capacity_per_year) }}</td>
                                                        </tr>
                                                      </slot>
                                                  </tbody>
                                                  <tfoot v-if="Object.keys(application.machineries_info).length === 0">
                                                      <tr>
                                                          <td colspan="5" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                                                        </tr>
                                                  </tfoot>
                                              </table>
                                        </b-col>
                                        </b-row>
                                    </b-form-group>
                                </div>
                            </div>
                            </div>
                          </b-col>
                          <b-row>
                                <b-col md="6">
                                  <div>
                                    <h6 class="mb-3 tag">{{ $t('dealer.important_document') }}</h6>
                                  </div>
                                  <div>
                                    <ul v-if="application.attachment_file">
                                      <!-- machineries_file  -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.machineries_file') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.machineries_file">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.machineries_file) ? 'storage/' : '') + application.attachment_file.machineries_file"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- agreement_deed  -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.agreement_deed') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.agreement_deed">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.agreement_deed) ? 'storage/' : '') + application.attachment_file.agreement_deed"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- nationality_certificate -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.nationality_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.nationality_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.nationality_certificate) ? 'storage/' : '') + application.attachment_file.nationality_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- article_of_association -->
                                      <li v-if="application.applicant_type === 2">
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.article_of_association') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.article_of_association">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.article_of_association) ? 'storage/' : '') + application.attachment_file.article_of_association"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- memorandum_of_association -->
                                      <li v-if="application.applicant_type === 2">
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.memorandum_of_association') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.memorandum_of_association">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.memorandum_of_association) ? 'storage/' : '') + application.attachment_file.memorandum_of_association"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- partnership_deed -->
                                      <li v-if="application.applicant_type === 3">
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.partnership_deed') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.partnership_deed">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.partnership_deed) ? 'storage/' : '') + application.attachment_file.partnership_deed"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- cooperative_society_registration -->
                                      <li v-if="application.applicant_type === 4">
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.cooperative_society_registration') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.cooperative_society_registration">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.cooperative_society_registration) ? 'storage/' : '') + application.attachment_file.cooperative_society_registration"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- bank_solvency_certificate -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.bank_solvency_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.bank_solvency_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.bank_solvency_certificate) ? 'storage/' : '') + application.attachment_file.bank_solvency_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- land_deed -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.land_deed') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.land_deed">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.land_deed) ? 'storage/' : '') + application.attachment_file.land_deed"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- lease_deed -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.lease_deed') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.lease_deed">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.lease_deed) ? 'storage/' : '') + application.attachment_file.lease_deed"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- environmental_certificate -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.environmental_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.environmental_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.environmental_certificate) ? 'storage/' : '') + application.attachment_file.environmental_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <!-- tin_certificate -->
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ $t('teaGardenPanel.tin_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="application.attachment_file.tin_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(application.attachment_file.tin_certificate) ? 'storage/' : '') + application.attachment_file.tin_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                         <!-- others files -->
                                        <slot v-if="application.add_more_files">
                                        <li v-for="(item,index) in application.add_more_files" :key="index">
                                        <div class="d-flex justify-content-between">
                                          <span>* {{ currentLocale === 'en' ? item.file_name_en : item.file_name_bn }}</span>
                                          <div class="list-btn">
                                            <div v-if="item.file">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="teaGardenServiceBaseUrl + (isImage(item.file) ? 'storage/' : '') + item.file"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                    </slot>
                                    </ul>
                                  </div>
                                </b-col>
                          </b-row>
                          <b-col md="12" class="text-right">
                            <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
                          </b-col>
                        </b-row>
                      </div>
                    </b-overlay>
                  </b-tab>
                  <b-tab :title="$t('teaGardenPanel.forward_history')" v-if ="$store.state.Auth.authUser.user_type === 1">
                    <div v-if="forwarLoad || loading" class="col-md-12">
                      <forward-loading></forward-loading>
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(forward, index) in application.application.forwards" :key="index">
                          <b-card>
                            <b-card-title>
                              <h5 style="font-size:17px">{{ getCardTitle(forward.status) }}</h5>
                            </b-card-title>
                            <b-card-sub-title style="font-size:14px">
                              <b-row>
                                <b-col md="5">
                                  <span class="badge badge-success">{{ $t('license_management.sender') }}</span> : {{
                                  getUserName(forward.sender_id) }} <i class=" ml-3 ri-arrow-right-line"></i>
                                </b-col>
                                <b-col>
                                  <p class="mb-2"><span class="badge badge-primary">{{ $t('license_management.receiver') }}</span> : {{
                                  getUserName(forward.receiver_id) }}</p>
                                  <p class="mb-2"><strong>{{ $t('globalTrans.designation') }} : </strong>
                                  {{ getDesignationName(forward.designation_id) }}</p>
                                  <p><strong>{{ $t('globalTrans.office') }} : </strong>
                                  {{ getOfficeName(forward.office_id) }}</p>
                                </b-col>
                              </b-row>
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
                  <b-tab :title="$t('teaGardenPanel.recommendation_history')" v-if ="$store.state.Auth.authUser.user_type === 1">
                    <div v-if="forwarLoad || loading" class="col-md-12">
                      <recommendation-loading></recommendation-loading>
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(recommendation, index) in application.application.recommendations" :key="index">
                          <b-card v-if="recommendation.status !== 1">
                            <b-card-title>
                              <h5 style="font-size:17px">{{ getCardTitleRecommendation(recommendation.status) }}</h5>
                            </b-card-title>
                            <b-card-text class="mt-3">
                              <p class="mb-2"><span class="badge badge-success">{{ $t('teaGardenPanel.by') }}</span> : {{
                                  getUserName(recommendation.user_id) }}</p>
                              <p class="mb-2"><strong>{{ $t('globalTrans.designation') }} : </strong>
                              {{ getDesignationName(recommendation.designation_id) }}</p>
                              <p class="mb-2"><strong>{{ $t('globalTrans.office') }} : </strong>
                                {{ getOfficeName(recommendation.office_id) }}</p>
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
                </b-tabs>
              </b-col>
            </b-row>
          </template>
      </body-card>
    </card>
</template>
<script>
import RestApi, { authServiceBaseUrl, teaGardenServiceBaseUrl } from '@/config/api_config'
import { factoryInfoDetailsApi, TeaFactoryViewPdf } from '../../api/routes'
import ForwardLoading from './../loading/ForwardLoading.vue'
import RecommendationLoading from './../loading/RecommendationLoading.vue'
import Loading from './../loading/Details.vue'
// import ExportPdf from './export-pdf'
import { mapGetters } from 'vuex'
export default {
  name: 'Details',
  components: {
    Loading,
    ForwardLoading,
    RecommendationLoading
  },
  data () {
    return {
      forwarLoad: false,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      application: {
        reviews: [],
        application: {
          forwards: [],
          recommendations: []
        }
      },
      users: []
    }
  },
  created () {
     this.getAppDetail()
  },
  computed: {
    ...mapGetters({
       authUser: 'Auth/authUser'
    }),
    appId () {
      return this.$route.params.id
    },
    stepList () {
      const tfaStepList = [
        { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Recommendation' : 'সুপারিশ', text_en: 'Recommendation', text_bn: 'সুপারিশ' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Recommended' : 'প্রস্তাবিত', text_en: 'Recommended', text_bn: 'প্রস্তাবিত' },
        { value: 6, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 7, text: this.$i18n.locale === 'en' ? 'Rejected' : 'প্রত্যাখ্যাত', text_en: 'Rejected', text_bn: 'প্রত্যাখ্যাত' }
      ]
      if (this.application.application.status === 7) {
        return tfaStepList.filter(item => item.value !== 6)
      } else {
        return tfaStepList.filter(item => item.value !== 7)
      }
    },
    forwardStatusList () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Reject' : 'বাতিল', text_en: 'Reject', text_bn: 'বাতিল' }
      ]
      return list
    },
    recommendStatusList () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Recommended' : 'প্রস্তাবিত', text_en: 'Recommended', text_bn: 'প্রস্তাবিত' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Reject' : 'বাতিল', text_en: 'Reject', text_bn: 'বাতিল' }
      ]
      return list
    },
    currentLocale () {
        return this.$i18n.locale
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    getCardTitle (status) {
      const tfaStepList = this.forwardStatusList.find(item => item.value === parseInt(status))
      if (typeof tfaStepList !== 'undefined') {
        return this.$i18n.locale === 'bn' ? tfaStepList.text_bn : tfaStepList.text_en
      } else {
        return ''
      }
    },
    getCardTitleRecommendation (status) {
      const tfaStepList = this.recommendStatusList.find(item => item.value === parseInt(status))
      if (typeof tfaStepList !== 'undefined') {
        return this.$i18n.locale === 'bn' ? tfaStepList.text_bn : tfaStepList.text_en
      } else {
        return ''
      }
    },
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, factoryInfoDetailsApi, { app_id: this.$route.params.id })
        if (result.success) {
          this.application = result.data
          if (this.application.application.forwards.length) {
            this.getForwardedUsers(result.data.application.forwards)
          }
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    getOrgName (id) {
        const org = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === id)
        if (org && this.$i18n.locale === 'bn') {
            return org.text_bn
        } else if (org && this.$i18n.locale === 'en') {
            return org.text_en
        }
    },
    async pdfExport () {
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 5, app_id: this.appId })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, TeaFactoryViewPdf, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDivisionName  (id) {
    const division = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
        if (division && this.$i18n.locale === 'bn') {
            return division.text_bn
        } else if (division && this.$i18n.locale === 'en') {
            return division.text_en
        }
    },
    getDistrictName (id) {
    const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
        if (district && this.$i18n.locale === 'bn') {
            return district.text_bn
        } else if (district && this.$i18n.locale === 'en') {
            return district.text_en
        }
    },
    getCityCorporationName (id) {
    const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
        if (cityCorporation && this.$i18n.locale === 'bn') {
            return cityCorporation.text_bn
        } else if (cityCorporation && this.$i18n.locale === 'en') {
            return cityCorporation.text_en
        }
    },
    getUpzillaName (id) {
    const upzilla = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
        if (upzilla && this.$i18n.locale === 'bn') {
            return upzilla.text_bn
        } else if (upzilla && this.$i18n.locale === 'en') {
            return upzilla.text_en
        }
    },
    getPauroshobaName (id) {
    const municipality = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
        if (municipality && this.$i18n.locale === 'bn') {
            return municipality.text_bn
        } else if (municipality && this.$i18n.locale === 'en') {
            return municipality.text_en
        }
    },
    getUnionName (id) {
    const union = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
        if (union && this.$i18n.locale === 'bn') {
            return union.text_bn
        } else if (union && this.$i18n.locale === 'en') {
            return union.text_en
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
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    },
    getDesignationName (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
    },
    getFactoryTypeName (id) {
      var factoryType
      if (this.authUser.user_type === 1) {
            factoryType = this.$store.state.TeaGardenService.commonObj.masterFactoryTypeList.find(item => item.value === id)
        } else {
             factoryType = this.$store.state.ExternalUserService.teaGarden.commonObj.masterFactoryTypeList.find(item => item.value === id)
        }
        if (factoryType && this.$i18n.locale === 'bn') {
            return factoryType.text_bn
        } else if (factoryType && this.$i18n.locale === 'en') {
            return factoryType.text_en
        }
    },
    getApplicantTypeName (id) {
      var applicantType
      if (this.authUser.user_type === 1) {
          applicantType = this.$store.state.TeaGardenService.commonObj.factoryApplicationApplicantType.find(item => item.value === id)
        } else {
          applicantType = this.$store.state.ExternalUserService.teaGarden.commonObj.factoryApplicationApplicantType.find(item => item.value === id)
        }
        if (applicantType && this.$i18n.locale === 'bn') {
            return applicantType.text_bn
        } else if (applicantType && this.$i18n.locale === 'en') {
            return applicantType.text_en
        }
    },
    getGardenName (id) {
      var gardenInfo
      if (this.authUser.user_type === 1) {
         gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
        } else {
          gardenInfo = this.$store.state.ExternalUserService.teaGarden.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
        }
        if (gardenInfo && this.$i18n.locale === 'bn') {
            return gardenInfo.text_bn
        } else if (gardenInfo && this.$i18n.locale === 'en') {
            return gardenInfo.text_en
        }
    },
    getMadeTypeNames (data) {
      var madeTeaTypes = []
      if (this.authUser.user_type === 1) {
        if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            madeTeaTypes.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            madeTeaTypes.push(item.text_en)
          }
          })
      }
      } else {
        if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.ExternalUserService.teaGarden.commonObj.masterMadeTeaTypeList.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            madeTeaTypes.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            madeTeaTypes.push(item.text_en)
          }
          })
       }
      }
      return madeTeaTypes.toString()
    },
    getFactoryProcessedArea (data) {
      var proposedNames = []
        if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            proposedNames.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            proposedNames.push(item.text_en)
          }
          })
      }
      return proposedNames.toString()
    },
    getApplicantNameAddress () {
       var address = ''
       if (this.application.garden_id) {
        if (this.$i18n.locale === 'en') {
        address = address + this.application.garden_info.owner_name_en + '\n'
        } else {
          address = address + this.application.garden_info.owner_name_bn + '\n'
        }
        if (this.$i18n.locale === 'en') {
          address = address + this.application.garden_info.garden_address_en + ','
        } else {
          address = address + this.application.garden_info.garden_address_bn + ','
        }
        if (this.application.garden_info.pauroshoba_id) {
          address = address + this.getPauroshobaName(this.application.garden_info.pauroshoba_id) + ','
        }
        if (this.application.garden_info.city_corporation_id) {
          address = address + this.getCityCorporationName(this.application.garden_info.city_corporation_id) + ','
        }
        if (this.application.garden_info.upazila_id) {
          address = address + this.getUpzillaName(this.application.garden_info.upazila_id) + ','
        }
        address = address + this.getDistrictName(this.application.garden_info.district_id) + ','
        address = address + this.getDivisionName(this.application.garden_info.division_id)
       } else {
          if (this.$i18n.locale === 'en') {
          address = address + this.application.applicant_name_en + '\n'
          } else {
            address = address + this.application.applicant_name_bn + '\n'
          }
          if (this.$i18n.locale === 'en') {
            address = address + this.application.address_en + ','
          } else {
            address = address + this.application.address_bn + ','
          }
          if (this.application.paurashoba_id) {
            address = address + this.getPauroshobaName(this.application.paurashoba_id) + ','
          }
          if (this.application.city_corporation_id) {
            address = address + this.getCityCorporationName(this.application.city_corporation_id) + ','
          }
          if (this.application.upazila_id) {
            address = address + this.getUpzillaName(this.application.upazila_id) + ','
          }
          address = address + this.getDistrictName(this.application.district_id) + ','
          address = address + this.getDivisionName(this.application.division_id)
       }
       return address
    },
    getFactoryAddress () {
       var address = ''
        if (this.application.factory_info.paurashoba_id) {
          address = address + this.getPauroshobaName(this.application.factory_info.paurashoba_id) + ','
        }
        if (this.application.factory_info.city_corporation_id) {
          address = address + this.getCityCorporationName(this.application.factory_info.city_corporation_id) + ','
        }
        if (this.application.factory_info.upazila_id) {
          address = address + this.getUpzillaName(this.application.factory_info.upazila_id) + ','
        }
        address = address + this.getDistrictName(this.application.factory_info.district_id) + ','
        address = address + this.getDivisionName(this.application.factory_info.division_id)
       return address
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

    @media (max-width: 768px) {
        font-size: 12px;
    }
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
