<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template>
            <b-overlay :show="loader">
              <div>
                <div class="application-form-wrapper application-form-view-wrapper" style="padding: 0 2rem;">
                  <div>
                    <h5 style="border-bottom: 2px solid #2f3542;width: 62%;margin: 2rem auto;padding-bottom: 5px;text-align: center;font-weight: 600">{{ $t('externalTradeFair.company_info') }}</h5>
                  </div>
                  <div class="application-itmes" v-if="detailsData">
                    <b-row>
                      <b-col sm="12">
                        <div class="jumbotron" style="padding: 1rem">
                          <p><b class="text-alt">{{ $t('tradeFairProposalManagement.circular') }} :</b> <span class="lead">{{ circular_name }}</span>
                          </p>
                        </div>
                      </b-col>
                    </b-row>
                    <div v-if="detailsData">
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.company_basic_info')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.fair_name')} :`">
                                <p class="input-field">{{ fair_name }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.participation_id')} :`">
                                <p class="input-field">{{ detailsData.app_auto_id }}
                                </p>
                              </b-form-group>
                            </b-col>
                          </b-row>
                          <b-row>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.name') + ' [' + $t('externalTradeFair.company_name') + ']'} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.name_en : detailsData.name_bn }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.address')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.address_en : detailsData.address_bn }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.factory_address')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.factory_address_en :
                                detailsData.factory_address_bn }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.web_page')} :`">
                                <p class="input-field">{{ detailsData.web_page_url }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.phone_no') + ' [' + $t('globalTrans.office') + ']'} :`">
                                <p class="input-field">{{ $n(0) + $n(detailsData.phone_no, { useGrouping: false }) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.email')} :`">
                                <p class="input-field">{{ detailsData.email }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.type_of_company')} :`">
                                <p class="input-field">{{ getCompanyTypeName(detailsData.company_type) }}</p>
                              </b-form-group>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.exporter_business_entity_info')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="6" v-if="detailsData.company_type === 4">
                              <b-form-group :label="`${$t('externalTradeFair.other_comp_type')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.other_comp_type_en :
                                detailsData.other_comp_type_bn }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.nature_of_company')} :`">
                                <p class="input-field">{{ getCompanyNatureName(detailsData.company_nature) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6" v-if="detailsData.company_nature === 5">
                              <b-form-group :label="`${$t('externalTradeFair.other_comp_nature')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.other_comp_nature_en :
                                detailsData.other_comp_nature_bn }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.establishment_year')} :`">
                                <p class="input-field">{{ $n(detailsData.establishment_year, { useGrouping: false }) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.erc_no')} :`">
                                <p class="input-field">{{ $n(detailsData.erc_no) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalUser.tin_no')} :`">
                                <p class="input-field">{{ $n(detailsData.tin_no) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalUser.bin_no')} :`">
                                <p class="input-field">{{ $n(detailsData.bin_no) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.products_to_displayed')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.display_product_en :
                                detailsData.display_product_bn }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.production_capacity')} :`">
                                <p class="input-field">{{ $n(detailsData.production_capacity) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.no_of_employess')} :`">
                                <p class="input-field">{{ $n(detailsData.employee_number) }}
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.main_markets')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.main_market_en : detailsData.main_market_bn }}
                                </p>
                              </b-form-group>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.export_performance_last')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="12">
                              <b-form-group :label="`${$t('externalTradeFair.is_exported')} :`">
                                <p class="input-field">
                                  <span v-if="detailsData.is_exported === 1">
                                    {{ $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }}
                                  </span>
                                  <span v-if="detailsData.is_exported === 2">
                                    {{ $i18n.locale == 'en' ? 'No' : 'না' }}
                                  </span>
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="12">
                              <b-table-simple v-if="detailsData.is_exported === 1" bordered small>
                                <thead>
                                  <!-- <tr>
                                                        <b-th colspan="4" class="text-white text-center p-2 bg-dark">{{ $t('externalTradeFair.export_performance_last')
                                                          }}</b-th>
                                                      </tr> -->
                                  <tr class="text-align-center">
                                    <th style="width:15%;padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.sl_no') }}</th>
                                    <th style="width:25%;padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.year') }}</th>
                                    <th style="width:25%;padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('externalTradeFair.usd_dollar') }}
                                    </th>
                                    <th style="width:35%;padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('tradeFairConfig.measurement_unit')
                                    }}</th>
                                  </tr>
                                </thead>
                                <b-tbody v-if="detailsData?.prev_exports?.length > 0">
                                  <b-tr v-for="(item, index) in detailsData.prev_exports" :key="index">
                                    <b-td>{{ $n(index + 1) }}</b-td>
                                    <b-td>{{ $n(item.year, { useGrouping: false }) }}</b-td>
                                    <b-td>{{ $n(item.usd_dollar, { minimumFractionDigits: 2 }) }}</b-td>
                                    <b-td>{{ getMeasurementUnitName(item.measurement_id) }}</b-td>
                                  </b-tr>
                                </b-tbody>
                              </b-table-simple>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                    </div>
                    <div v-if="detailsData.objective">
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('tradeFairConfig.stall_information')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="12">
                              <b-table-simple bordered small>
                                <thead>
                                  <tr class="text-align-center">
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.sl_no') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('tradeFairConfig.stall_size') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('tradeFairConfig.stall_type') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('tradeFairConfig.booth_rent') + ' ' + $t('globalTrans.tk') }}</th>
                                    <th style="width:15%;padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.description') }}</th>
                                  </tr>
                                </thead>
                                <b-tbody v-if="stalls?.length > 0">
                                  <b-tr v-for="(item, index) in stalls.filter(item => item.is_active === 1)" :key="index">
                                    <b-td>{{ $n(index + 1) }}</b-td>
                                    <b-td>{{ getStallCategoryName(item.stall_cat_id) }}</b-td>
                                    <b-td>{{ $n(item.stall_size) + ' ' + getMeasurementUnitName(item.measurement_id) }}</b-td>
                                    <b-td>{{ getStallType(item.stall_type) }}</b-td>
                                    <b-td>{{ $n(item.booth_rent) }}</b-td>
                                    <b-td class="text-left">{{ $i18n.locale == 'bn' ? item.description_bn : item.description_en }}</b-td>
                                  </b-tr>
                                </b-tbody>
                              </b-table-simple>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fair_participation_awarded_internation_certification_info')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.is_first_participate')} :`">
                                <p class="input-field">
                                  <span v-if="detailsData?.objective?.participate_status === 1">
                                    {{ $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }}
                                  </span>
                                  <span v-if="detailsData?.objective?.participate_status === 2">
                                    {{ $i18n.locale == 'en' ? 'No' : 'না' }}
                                  </span>
                                </p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.participate_with_epb_count')} :`">
                                <p class="input-field">{{ $n(detailsData.objective?.participation_count) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.intel_certificate_award')} :`">
                                <p class="input-field">{{ $i18n.locale === 'en' ? detailsData.objective.certificate_award_en : detailsData.objective.certificate_award_bn }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.attachment')} :`">
                                <p class="input-field">
                                  <a target="_blank" v-if="detailsData.objective.attachment"
                                    :href="baseUrl + 'storage/' + detailsData.objective.attachment">{{ $t('globalTrans.download')}} <i
                                      class="ri-download-cloud-fill"></i> </a>
                                </p>
                              </b-form-group>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                      <div class="fair-note-wrapper" style="border: 2px solid #444;padding: 3px 10px;margin-bottom: 1rem;">
                        <p>
                          <b class="note-title">{{ $t('externalTradeFair.note') }}</b>
                          {{ $t('externalTradeFair.tab_two_note') }}
                        </p>
                      </div>
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3"
                          :label="$t('externalTradeFair.participation_obj')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.purchase_order')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.purchase_order) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.commercial_relation')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.commercial_relation) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.existent_comm_relation')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.existent_comm_relation) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.new_products')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.new_products) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.competition_activities')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.competition_activities) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.trends_and_innovations')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.trends_and_innovations) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.direct_sales')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.direct_sales) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.market_impression')} :`">
                                <p class="input-field">{{ $t('externalTradeFair.market_impression') }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('externalTradeFair.reliance')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.reliance) }}</p>
                              </b-form-group>
                            </b-col>
                            <b-col sm="6">
                              <b-form-group :label="`${$t('globalTrans.others')} :`">
                                <p class="input-field">{{ $n(detailsData.objective.others) }}</p>
                              </b-form-group>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                    </div>
                    <div v-if="detailsData.representatives">
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.representative_data')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="12">
                              <b-table-simple bordered small>
                                <thead>
                                  <tr class="text-align-center">
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.sl_no') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.name') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.designation') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('globalTrans.nationality') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('externalUser.passport_no') }}</th>
                                    <th style="padding: 0.5rem 0.7rem;font-size: 1.1rem;">{{ $t('externalTradeFair.country_travelled') }}</th>
                                  </tr>
                                </thead>
                                <b-tbody v-if="detailsData?.representatives?.length > 0">
                                  <b-tr v-for="(item, index) in detailsData.representatives" :key="index">
                                    <b-td>{{ $n(index + 1) }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.repres_name_en : item.repres_name_bn }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.designation_en : item.designation_bn }}</b-td>
                                    <b-td>{{ $i18n.locale === 'en' ? item.nationality_en : item.nationality_bn }}</b-td>
                                    <b-td>{{ item.passport_no }}</b-td>
                                    <b-td>
                                      <span v-for="(itm, indx) in JSON.parse(item.travelled_country)" :key="indx">
                                        <span>{{ countryName(itm) }}</span><span v-if="indx+1 < JSON.parse(item.travelled_country).length">{{ ', '
                                        }}</span>
                                      </span>
                                    </b-td>
                                  </b-tr>
                                </b-tbody>
                              </b-table-simple>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                    </div>
                    <div v-if="detailsData.attachment_tab">
                      <div class="group-form-card">
                        <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.docs_to_be_attached')" label-size="md"
                          label-class="font-weight-bold pt-0" class="form-view-item">
                          <b-row>
                            <b-col sm="6">
                              <ul>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(1) }}. {{ $t('externalTradeFair.trade_license') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.trade_license"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.trade_license">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(2) }}. {{ $t('externalTradeFair.incorporation_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.incorporation_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.incorporation_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(3) }}. {{ $t('externalTradeFair.export_regi_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.export_regi_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.export_regi_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(4) }}. {{ $t('externalTradeFair.tax_return_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.tax_return_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.tax_return_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(5) }}. {{ $t('externalTradeFair.vat_regi_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.vat_regi_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.vat_regi_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(6) }}. {{ $t('externalTradeFair.epb_regi_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.epb_regi_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.epb_regi_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(7) }}. {{ $t('externalTradeFair.prc_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.prc_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.prc_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(8) }}. {{ $t('externalTradeFair.passport') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.passport"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.passport">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(9) }}. {{ $t('externalTradeFair.representative_photographs') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.representative_photographs"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.representative_photographs">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(10) }}. {{ $t('externalTradeFair.previous_visa') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.previous_visa"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.previous_visa">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(11) }}. {{ $t('externalTradeFair.product_image') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.product_image"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.product_image">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <!-- <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(12) }}. {{ $t('externalTradeFair.product_description') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <a target="_blank" v-if="detailsData.attachment_tab.product_description"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.product_description">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li> -->
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(12) }}. {{ $t('externalTradeFair.award_certificate') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.award_certificate"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.award_certificate">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                                <li>
                                  <div class="d-flex justify-content-between">
                                    <span style="font-size: 1.06rem;">{{ $n(13) }}. {{ $t('externalTradeFair.representative_signature') }}</span>
                                    <div class="list-btn">
                                      <div>
                                        <!-- <i class="ri-check-line yes-btn"></i> -->
                                        <a target="_blank" v-if="detailsData.attachment_tab.representative_signature"
                                          :href="baseUrl + 'storage/' + detailsData.attachment_tab.representative_signature">
                                          <i class="ri-download-cloud-fill download-btn" :title="$t('globalTrans.download')"></i>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                </li>
                              </ul>
                            </b-col>
                          </b-row>
                        </b-form-group>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartListDetailsApi, fairInfoByCircularApi, fairPartPdfDetailsApi } from '../../../api/routes'
// import ListReportHead from '@/components/custom/ListReportHead.vue'
export default {
    name: 'Details',
    props: ['id'],
    components: {
      // ListReportHead
    },
    data () {
      return {
        baseUrl: internationalTradeFairServiceBaseUrl,
        loader: false,
        detailsData: [],
        stallCategoryList: [],
        circular: {},
        stallList: [],
        stalls: [],
        circular_name: '',
        fair_name: ''
      }
    },
    created () {
      if (this.id) {
        this.getParticipationInfo()
      }
    },
    methods: {
      getCompanyTypeName (id) {
        const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
        if (typeof companyType !== 'undefined') {
          return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
        } else {
          return ''
        }
      },
      getCompanyNatureName (id) {
        const companyNature = this.$store.state.TradeFairService.commonObj.companyNatureList.find(obj => obj.value === parseInt(id))
        if (typeof companyNature !== 'undefined') {
          return this.$i18n.locale === 'en' ? companyNature.text_en : companyNature.text_bn
        } else {
          return ''
        }
      },
      getMeasurementUnitName (Id) {
        const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
          return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
        }
        return ''
      },
      countryName (Id) {
        const Obj = this.$store.state.CommonService.commonObj.countryList.find(item => item.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
        } else {
          return ''
        }
      },
      nationalityName (Id) {
        const Obj = this.$store.state.CommonService.commonObj.countryList.find(item => item.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
          return this.$i18n.locale === 'bn' ? Obj.nationality_bn : Obj.nationality
        } else {
          return ''
        }
      },
      async getParticipationInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairPartListDetailsApi, { app_id: this.id })
        if (resultData.success) {
          this.detailsData = resultData.data
          this.getStallByCircularIdInfo(this.detailsData.fair_circular_id)
          this.getStallCategoryList(this.detailsData.fair_circular.fair_name_id)
          this.loader = false
        } else {
          this.detailsData = []
          this.loader = false
        }
      },
      async getStallByCircularIdInfo (circularId) {
        this.loader = true
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairInfoByCircularApi, { circular_id: circularId })
        if (result.success) {
          const fData = result.data
          if (fData) {
            this.circular = fData.circular
            this.stallList = fData.stallList
            this.stalls = this.stallList.map(el => {
              const Exist = this.detailsData.stalls.find(item => item.stall_detail_id === el.id)
              return Object.assign({}, el, { is_active: typeof Exist !== 'undefined' ? 1 : 0 })
            })
            const fairName = this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.find(item => item.value === parseInt(this.circular.fair_name_id))
            if (typeof fairName !== 'undefined') {
              this.fair_name = this.$i18n.locale === 'en' ? fairName.text_en : fairName.text_bn
            } else {
              this.fair_name = ''
            }
            this.circular_name = this.$i18n.locale === 'bn' ? this.circular.subject_bn : this.circular.subject_en
          }
        }
        this.loader = false
      },
      getStallCategoryList (id) {
        this.loader = true
        const apis = '/itf-configuration/stall-information/stall-cat-by-fair'
        RestApi.getData(internationalTradeFairServiceBaseUrl, apis, { fair_name_id: id }).then(response => {
          if (response.success) {
            this.stallCategoryList = response.data.map(el => {
              return Object.assign({}, el, { text: this.$i18n.locale === 'en' ? el.text_en : el.text_bn })
            })
          } else {
            this.stallCategoryList = []
          }
        })
        this.loader = false
      },
      getStallCategoryName (id) {
        const Obj = this.stallCategoryList.find(item => item.value === id)
        if (this.currentLocale === 'bn') {
          return Obj !== undefined ? Obj.text_bn : ''
        } else {
          return Obj !== undefined ? Obj.text_en : ''
        }
      },
      getStallType (id) {
        const dataStallType = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === parseInt(id))
        if (typeof dataStallType !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataStallType.text_en : dataStallType.text_bn
        } else {
          return ''
        }
      },
      async pdfExport () {
        this.loader = true
        const params = Object.assign({ local: this.$i18n.locale, org_id: 2, id: this.id, app_id: this.id })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, fairPartPdfDetailsApi, params)
        var blob = new Blob([result], {
          type: 'application/pdf'
        })
        var url = window.URL.createObjectURL(blob)
        window.open(url).print()
        this.loader = false
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      }
    }
}
</script>
<style>
.download-btn {
  color: green;
  border: 1px solid gray;
  margin-left: 5px;
  font-size: 18px;
  padding: 1px 3px;
}

.yes-btn {
  color: green;
  border: 1px solid gray;
  margin-left: 5px;
  font-size: 18px;
  font-weight: 700;
  padding: 1px 3px;
}
</style>
