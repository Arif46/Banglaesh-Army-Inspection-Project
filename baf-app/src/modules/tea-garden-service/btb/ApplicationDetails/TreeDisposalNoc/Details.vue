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
                                  <h5
                                    style="border-bottom: 2px solid #2f3542;width: 60%;margin: 3rem auto;padding-bottom: 5px;text-align: center;">{{ $t('teaGardenService.disposal_application_label') }}</h5>
                                </div>
                                <div class="application-itmes">
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="`${$t('teaGardenConfig.garden_info')}:`" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenConfig.registration_no')}:`">
                                            <p class="input-field">
                                              <span v-if="(application.garden_info && application.garden_info.registration_no_en)">{{ application.garden_info.registration_no_en }}</span>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenConfig.garden_name')}:`">
                                            <p class="input-field">
                                              <span v-if="application.garden_info && $i18n.locale ==='en'">{{ application.garden_info.tea_garden_name_en }}</span>
                                              <span v-if="application.garden_info && $i18n.locale ==='bn'">{{ application.garden_info.tea_garden_name_bn }}</span>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenConfig.owner_name')}:`">
                                            <p class="input-field">
                                              <span v-if="application.garden_info && $i18n.locale ==='en'">{{ application.garden_info.owner_name_en }}</span>
                                              <span v-if="application.garden_info && $i18n.locale ==='bn'">{{ application.garden_info.owner_name_bn }}</span>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenConfig.division')}:`">
                                            <p class="input-field">{{ getDivisionName(application.garden_info.division_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenConfig.district')}:`">
                                            <p class="input-field">{{ getDistrictName(application.garden_info.district_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="application.garden_info.upazila_id">
                                          <b-form-group :label="`${$t('teaGardenConfig.upazila')}:`">
                                            <p class="input-field">{{ getUpzillaName(application.garden_info.upazila_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="application.garden_info.city_corporation_id">
                                          <b-form-group :label="`${$t('teaGardenConfig.city_corporation')}:`">
                                            <p class="input-field">{{ getCityCorporationName(application.garden_info.city_corporation_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6" v-if="application.garden_info.pauroshoba_id">
                                          <b-form-group :label="`${$t('teaGardenConfig.city_corporation')}:`">
                                            <p class="input-field">{{ getPauroshobaName(application.garden_info.pauroshoba_id) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="12">
                                          <b-form-group :label="`${$t('teaGardenConfig.garden_address')}:`" label-for="AddressEn">
                                            <p class="input-field">
                                              <span v-if="application.garden_info && $i18n.locale ==='en'">{{ application.garden_info.garden_address_en }}</span>
                                              <span v-if="application.garden_info && $i18n.locale ==='bn'">{{ application.garden_info.garden_address_bn }}</span>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.tree_class_of_forest_resources')}`" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1" v-for="(item, index) in application.tree_class_of_forest_resources" :key="index">{{ getForestResourceName(item) }}</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.description_of_forest_resource')}:`" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.unit_quantity')}:`">
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">{{ getUnitName(application.unit_quantity) }}</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.plantation_year')}:`">
                                            <p class="input-field">{{ EngBangNum(application.number_of_trees.toString()) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.number_of_trees')}:`">
                                            <p class="input-field">{{ $n(application.number_of_trees) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.size')}:`">
                                            <p class="input-field">{{ $n(application.size.toString()) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.quantity_approx')}:`">
                                            <p class="input-field">{{ $n(application.quantity_approx) }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.forest_resource_section_area')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <table class="table table-sm table-bordered section-tree-view-table">
                                            <thead>
                                                  <tr>
                                                    <th>
                                                        {{ $t('teaGardenService.section_name') }}
                                                    </th>
                                                    <th class="text-left">{{ $t('teaGardenService.mouja') }}</th>
                                                    <th>{{ $t('teaGardenService.khotian') }}</th>
                                                    <th>{{ $t('teaGardenService.dag_no') }}</th>
                                                    <th style="width:32%;text-align:center">{{ $t('teaGardenService.tree_name') }}</th>
                                                    <th>{{ $t('teaGardenService.number_of_trees') }}</th>
                                                    <th>{{ $t('teaGardenService.approved_tree') }}</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <slot v-for="(sectionItem, prevSectionIndex) in application.tree_cutting_locations">
                                                <tr :key="prevSectionIndex + 'prev'">
                                                    <td>{{ getSectionName(sectionItem.section_id) }}</td>
                                                    <td class="text-left">
                                                        <span v-if="$i18n.locale === 'en'">{{ sectionItem.mouja_en }}</span>
                                                        <span v-else>{{ sectionItem.mouja_bn }}</span>
                                                    </td>
                                                    <td><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                                                    <td><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                                                    <td class="p-0">
                                                        <table class="table table-sm section-tree-view-table m-0">
                                                            <tr v-for="(treeItem, prevTreeIndex1) in sectionItem.cutting_trees" :key="prevTreeIndex1 + prevSectionIndex + 'prev' + 1">
                                                                <td>{{ getTreeName(treeItem.tree_id) }}</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="p-0">
                                                        <table class="table table-sm section-tree-view-table m-0">
                                                            <tr v-for="(treeItem, prevTreeIndex2) in sectionItem.cutting_trees" :key="prevTreeIndex2 + prevSectionIndex + 'prev'">
                                                                <td>{{ $n(treeItem.number_of_tree) }}</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="p-0">
                                                        <table class="table table-sm section-tree-view-table m-0">
                                                            <tr v-for="(treeItem, prevTreeIndex3) in sectionItem.cutting_trees" :key="prevTreeIndex3 + prevSectionIndex + 'prevA'">
                                                                <td>{{ $n(treeItem.approved_tree) }}</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr :key="prevSectionIndex + 'prev' + 1">
                                                    <td colspan="5" class="text-right">
                                                        <b>{{ $t('teaGardenService.sub_total') }}</b>
                                                    </td>
                                                    <td class="text-center">
                                                        <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { number_of_tree } ) => sum + Number(number_of_tree) , 0)) }}</b>
                                                    </td>
                                                    <td class="text-center">
                                                        <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { approved_tree } ) => sum + Number(approved_tree) , 0)) }}</b>
                                                    </td>
                                                </tr>
                                                </slot>
                                                <tr>
                                                    <td colspan="5" class="text-right">
                                                        <b>{{ $t('teaGardenService.grand_total') }}</b>
                                                    </td>
                                                    <td class="text-center">
                                                        <b>{{ $n(totalNumberOfTrees) }}</b>
                                                    </td>
                                                    <td class="text-center">
                                                        <b>{{ $n(totalNumberOfApprovedTrees) }}</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" class="text-right pe-5">
                                                        <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfTrees)) }}</b>
                                                    </td>
                                                    <td class="text-right pe-5">
                                                        <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfApprovedTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfApprovedTrees)) }}</b>
                                                    </td>
                                                </tr>
                                            </tbody>
                                          </table>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.purpose_of_tree_felling')}:`" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1" v-for="(item, index) in application.cutting_purpose.purpose_of_tree_felling" :key="index">{{ getTreeFellingPurposeName(item) }}</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.cutable_tree_section')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.total_cutable_trees')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.total_cutable_trees) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.number_of_re_plantable_tree')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.number_of_re_plantable_tree) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.number_of_very_old_trees')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.number_of_very_old_trees) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.number_of_rubber_tree')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.number_of_rubber_tree) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.number_of_disease_tree')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.number_of_disease_tree) }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.number_of_other_trees')">
                                            <p class="input-field">{{ $n(application.cutting_purpose.number_of_other_trees) }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.tea_board_memorial_label')" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="$t('teaGardenService.memorial_number')">
                                            <p class="input-field">{{ application.application.registration_no }}</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('globalTrans.date')}:`">
                                            <p class="input-field">{{ EngBangNum(application.application.issue_date) }}</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.development_planning_level')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('globalTrans.fiscal_year')}:`">
                                            <p class="input-field"><span v-if="application.development_planing && application.development_planing.fiscal_year_id">{{ getFiscalYearName(application.development_planing.fiscal_year_id) }}</span></p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.expansion_planting')}:`">
                                            <p class="input-field"><span v-if="application.development_planing">{{ $n(application.development_planing.expansion_planting) }}</span></p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.re_plantation')}:`">
                                            <p class="input-field"><span v-if="application.development_planing">{{ $n(application.development_planing.re_plantation) }}</span></p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.rubber')}:`">
                                            <p class="input-field"><span v-if="application.development_planing">{{ $n(application.development_planing.rubber) }}</span></p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.afforestation')}:`">
                                            <p class="input-field"><span v-if="application.development_planing">{{ $n(application.development_planing.afforestation) }} </span></p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group :label="`${$t('teaGardenService.other_plants')}:`">
                                            <p class="input-field"><span v-if="application.development_planing">{{ $n(application.development_planing.other_plants) }}</span></p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <!-- for previous permission history  -->
                                  <div v-if="previousDataLoad">
                                    <Loading />
                                  </div>
                                  <b-overlay v-else>
                                  <slot v-if="previousPermissionData.application && previousPermissionData.application.status === 6">
                                    <div class="group-form-card">
                                    <b-form-group label-cols-lg="12" style="text-align: center;font-size: 20px;" :label="`${$t('teaGardenService.previous_tree_disposal_history')}`" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                    </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.tree_class_of_forest_resources')}`" label-size="md"
                                        label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="12">
                                            <b-form-group>
                                              <p class="input-field">
                                                <b-badge variant="primary" class="rounded mb-1 mr-1" v-for="(item, index) in previousPermissionData.tree_class_of_forest_resources" :key="index">{{ getForestResourceName(item) }}</b-badge>
                                              </p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.description_of_forest_resource')}:`" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.unit_quantity')}:`">
                                              <p class="input-field">
                                                <b-badge variant="primary" class="rounded mb-1 mr-1">{{ getUnitName(previousPermissionData.unit_quantity) }}</b-badge>
                                              </p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                        <b-row>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.plantation_year')}:`">
                                              <p class="input-field">{{previousPermissionData.number_of_trees ? EngBangNum(previousPermissionData.number_of_trees.toString()) : '' }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.number_of_trees')}:`">
                                              <p class="input-field">{{ $n(previousPermissionData.number_of_trees) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.size')}:`">
                                              <p class="input-field">{{ previousPermissionData.size ? $n(previousPermissionData.size.toString()) : '' }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.quantity_approx')}:`">
                                              <p class="input-field">{{ $n(previousPermissionData.quantity_approx) }}</p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="$t('teaGardenService.forest_resource_section_area')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="12">
                                            <table class="table table-sm table-bordered section-tree-view-table">
                                              <thead>
                                                  <tr>
                                                      <th>
                                                          {{ $t('teaGardenService.section_name') }}
                                                      </th>
                                                      <th class="text-left">{{ $t('teaGardenService.mouja') }}</th>
                                                      <th>{{ $t('teaGardenService.khotian') }}</th>
                                                      <th>{{ $t('teaGardenService.dag_no') }}</th>
                                                      <th style="width:32%;text-align:center">{{ $t('teaGardenService.tree_name') }}</th>
                                                      <th>{{ $t('teaGardenService.number_of_trees') }}</th>
                                                      <th>{{ $t('teaGardenService.approved_tree') }}</th>
                                                  </tr>
                                              </thead>
                                              <tbody>
                                                  <slot v-for="(sectionItem, prevSectionIndex) in previousPermissionData.tree_cutting_locations">
                                                  <tr :key="prevSectionIndex + 'prevs'">
                                                      <td>{{ getSectionName(sectionItem.section_id) }}</td>
                                                      <td class="text-left">
                                                          <span v-if="$i18n.locale === 'en'">{{ sectionItem.mouja_en }}</span>
                                                          <span v-else>{{ sectionItem.mouja_bn }}</span>
                                                      </td>
                                                      <td><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                                                      <td><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                                                      <td class="p-0">
                                                          <table class="table table-sm section-tree-view-table m-0">
                                                              <tr v-for="(treeItem, prevTreeIndex1) in sectionItem.cutting_trees" :key="prevTreeIndex1 + prevSectionIndex + 'prevs' + 1">
                                                                  <td>{{ getTreeName(treeItem.tree_id) }}</td>
                                                              </tr>
                                                          </table>
                                                      </td>
                                                      <td class="p-0">
                                                          <table class="table table-sm section-tree-view-table m-0">
                                                              <tr v-for="(treeItem, prevTreeIndex2) in sectionItem.cutting_trees" :key="prevTreeIndex2 + prevSectionIndex + 'prevs'">
                                                                  <td>{{ $n(treeItem.number_of_tree) }}</td>
                                                              </tr>
                                                          </table>
                                                      </td>
                                                      <td class="p-0">
                                                          <table class="table table-sm section-tree-view-table m-0">
                                                              <tr v-for="(treeItem, prevTreeIndex3) in sectionItem.cutting_trees" :key="prevTreeIndex3 + prevSectionIndex + 'prevA'">
                                                                  <td>{{ $n(treeItem.approved_tree) }}</td>
                                                              </tr>
                                                          </table>
                                                      </td>
                                                  </tr>
                                                  <tr :key="prevSectionIndex + 'prevs' + 1">
                                                      <td colspan="5" class="text-right">
                                                          <b>{{ $t('teaGardenService.sub_total') }}</b>
                                                      </td>
                                                      <td class="text-center">
                                                          <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { number_of_tree } ) => sum + Number(number_of_tree) , 0)) }}</b>
                                                      </td>
                                                      <td class="text-center">
                                                          <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { approved_tree } ) => sum + Number(approved_tree) , 0)) }}</b>
                                                      </td>
                                                  </tr>
                                                  </slot>
                                                  <tr>
                                                      <td colspan="5" class="text-right">
                                                          <b>{{ $t('teaGardenService.grand_total') }}</b>
                                                      </td>
                                                      <td class="text-center">
                                                          <b>{{ $n(totalNumberOfTreesPrevious) }}</b>
                                                      </td>
                                                      <td class="text-center">
                                                          <b>{{ $n(totalNumberOfApprovedTreesPrevious) }}</b>
                                                      </td>
                                                  </tr>
                                                  <tr>
                                                      <td colspan="6" class="text-right pe-5">
                                                          <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfTrees)) }}</b>
                                                      </td>
                                                      <td class="text-right pe-5">
                                                          <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfApprovedTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfApprovedTrees)) }}</b>
                                                      </td>
                                                  </tr>
                                              </tbody>
                                            </table>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="`${$t('teaGardenService.purpose_of_tree_felling')}:`" label-size="md"
                                        label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="12">
                                            <b-form-group>
                                              <p class="input-field">
                                                <b-badge variant="primary" class="rounded mb-1 mr-1" v-for="(item, index) in previousPermissionData.cutting_purpose.purpose_of_tree_felling" :key="index">{{ getTreeFellingPurposeName(item) }}</b-badge>
                                              </p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="$t('teaGardenService.cutable_tree_section')" label-size="md"
                                        label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.total_cutable_trees')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.total_cutable_trees) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.number_of_re_plantable_tree')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.number_of_re_plantable_tree) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.number_of_very_old_trees')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.number_of_very_old_trees) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.number_of_rubber_tree')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.number_of_rubber_tree) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.number_of_disease_tree')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.number_of_disease_tree) }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.number_of_other_trees')">
                                              <p class="input-field">{{ $n(previousPermissionData.cutting_purpose.number_of_other_trees) }}</p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="$t('teaGardenService.tea_board_memorial_label')" label-size="md"
                                        label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="6">
                                            <b-form-group :label="$t('teaGardenService.memorial_number')">
                                              <p class="input-field">{{ previousPermissionData.application.registration_no }}</p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('globalTrans.date')}:`">
                                              <p class="input-field">{{ EngBangNum(previousPermissionData.application.issue_date) }}</p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                    <div class="group-form-card">
                                      <b-form-group label-cols-lg="3" :label="$t('teaGardenService.development_planning_level')" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                        <b-row>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('globalTrans.fiscal_year')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing && previousPermissionData.development_planing.fiscal_year_id">{{ getFiscalYearName(previousPermissionData.development_planing.fiscal_year_id) }}</span></p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.expansion_planting')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing">{{ $n(previousPermissionData.development_planing.expansion_planting) }}</span></p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.re_plantation')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing">{{ $n(previousPermissionData.development_planing.re_plantation) }}</span></p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.rubber')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing">{{ $n(previousPermissionData.development_planing.rubber) }}</span></p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.afforestation')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing">{{ $n(previousPermissionData.development_planing.afforestation) }} </span></p>
                                            </b-form-group>
                                          </b-col>
                                          <b-col sm="6">
                                            <b-form-group :label="`${$t('teaGardenService.other_plants')}:`">
                                              <p class="input-field"><span v-if="previousPermissionData.development_planing">{{ $n(previousPermissionData.development_planing.other_plants) }}</span></p>
                                            </b-form-group>
                                          </b-col>
                                        </b-row>
                                      </b-form-group>
                                    </div>
                                  </slot>
                                  </b-overlay>
                                </div>
                              </div>
                          </b-col>
                          <b-col md="12" class="text-left">
                            <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
                          </b-col>
                        </b-row>
                      </div>
                    </b-overlay>
                  </b-tab>
                  <b-tab :title="$t('teaGardenPanel.forward_history')" v-if="$store.state.Auth.authUser.user_type === 1">
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
                  <b-tab :title="$t('teaGardenPanel.recommendation_history')" v-if="$store.state.Auth.authUser.user_type === 1">
                    <div v-if="forwarLoad || loading" class="col-md-12">
                        <forward-loading></forward-loading>
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
import { treeDisposalAppDetailsApi, treeDisposalPreviousPermissionDetailsApi, TreeDisposalViewPdf } from '../../api/routes'
import ForwardLoading from './../loading/ForwardLoading.vue'
import Loading from './../loading/Details.vue'
// import ExportPdf from './export-pdf'
export default {
  name: 'Details',
  components: {
    Loading,
    ForwardLoading
  },
  data () {
    return {
      forwarLoad: false,
      previousDataLoad: false,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      application: {
        reviews: [],
        application: {
          forwards: [],
          recommendations: []
        }
      },
      previousPermissionData: {
        tree_class_of_forest_resources: [],
        unit_quantity: null,
        plantation_year: null,
        number_of_trees: null,
        size: null,
        quantity_approx: null,
        tree_cutting_locations: [],
        development_planing: {
            id: 0,
            tree_cutting_id: 0,
            fiscal_year_id: 0,
            expansion_planting: null,
            re_plantation: null,
            rubber: null,
            afforestation: null,
            other_plants: null
        },
        cutting_purpose: {
            id: 0,
            tree_cutting_id: 1,
            purpose_of_tree_felling: [],
            total_cutable_trees: null,
            number_of_re_plantable_tree: null,
            number_of_very_old_trees: null,
            number_of_rubber_tree: null,
            number_of_disease_tree: null,
            number_of_other_trees: null
        },
        application: {
            registration_no: '',
            issue_date: '',
            status: ''
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
    loading () {
      return this.$store.state.commonObj.loading
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
    totalNumberOfTrees () {
      var total = 0
      this.application.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.number_of_tree)
          })
      })
      return total
    },
    totalNumberOfApprovedTrees () {
      var total = 0
      this.application.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.approved_tree)
          })
      })
      return total
    },
    totalNumberOfTreesPrevious () {
      var total = 0
      this.previousPermissionData.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.number_of_tree)
          })
      })
      return total
    },
    totalNumberOfApprovedTreesPrevious () {
      var total = 0
      this.previousPermissionData.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.approved_tree)
          })
      })
      return total
    },
    gardenSectionDetail: function () {
      return this.$store.state.TeaGardenService.commonObj.masterSectionList
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
    getDesignationName (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
    },
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalAppDetailsApi, { app_id: this.$route.params.id })
        if (result.success) {
          this.getPreviousPermissionData(result.data.garden_id)
          this.application = result.data
          if (this.application.application.forwards.length) {
            this.getForwardedUsers(result.data.application.forwards)
          }
          this.$store.dispatch('mutateCommonProperties', { loading: false })
        } else {
          this.$store.dispatch('mutateCommonProperties', { loading: false })
        }
    },
    async getPreviousPermissionData (gardenId) {
        this.previousDataLoad = true
        const paramsData = {
          garden_id: gardenId,
          id: this.$route.params.id
        }
        const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalPreviousPermissionDetailsApi, paramsData)
        if (result.success) {
            const data = result.data
            if (data) {
                this.previousPermissionData = data
            }
        }
        this.previousDataLoad = false
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    // convert to word start
    empty (str) {
        return (!str || str.length === 0)
    },
    toWord (number, words) {
        var nLength = number.length
        var wordsString = ''

        if (nLength <= 9) {
            const nArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
            const receivedNArray = []
            for (let i = 0; i < nLength; i++) {
            receivedNArray[i] = parseInt(number.substr(i, 1))
            }
            for (let i = 9 - nLength, j = 0; i < 9; i++, j++) {
            nArray[i] = receivedNArray[j]
            }
            for (let i = 0, j = 1; i < 9; i++, j++) {
            if (i === 0 || i === 2 || i === 4 || i === 7) {
                if (nArray[i] === 1) {
                nArray[j] = 10 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 2) {
                nArray[j] = 20 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 3) {
                nArray[j] = 30 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 4) {
                nArray[j] = 40 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 5) {
                nArray[j] = 50 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 6) {
                nArray[j] = 60 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 7) {
                nArray[j] = 70 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 8) {
                nArray[j] = 80 + parseInt(nArray[j])
                nArray[i] = 0
                } else if (nArray[i] === 9) {
                nArray[j] = 90 + parseInt(nArray[j])
                nArray[i] = 0
                }
            }
            }

            let value = ''
            for (let i = 0; i < 9; i++) {
            value = parseInt(nArray[i])
            if (value !== 0) {
                wordsString += words[value] + ''
            }
            if ((i === 1 && value !== 0) || (i === 0 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
                wordsString += ' কোটি '
            }
            if ((i === 3 && value !== 0) || (i === 2 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
                wordsString += ' লাখ '
            }
            if ((i === 5 && value !== 0) || (i === 4 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
                wordsString += ' হাজার '
            } else if (i === 6 && value !== 0) {
                wordsString += 'শ '
            }
            }

            wordsString = wordsString.split('  ').join(' ')
        }
        return wordsString
    },
    convertNumberToEnglishWords (number) {
        if ((number < 0) || (number > 999999999)) {
            alert('Number is out of range')
            return
        }
        const numberArray = number.toString().split('.')
        const numberWithoutFloatingPart = numberArray[0] ? parseInt(numberArray[0]) : 0
        const numberWithFloatingPart = numberArray[1]
        let stringBeforeFloatingPart = ''
        if (numberWithoutFloatingPart) {
            stringBeforeFloatingPart = this.convertNumber(numberWithoutFloatingPart)
        }
        let numberWords = stringBeforeFloatingPart
        if (numberWithFloatingPart) {
            if (stringBeforeFloatingPart) {
            numberWords += stringBeforeFloatingPart + ' Point ' + this.convertNumber(parseInt(numberWithFloatingPart))
            } else {
            numberWords += 'Point ' + this.convertNumber(parseInt(numberWithFloatingPart))
            }
        }
        return numberWords
    },
    convertNumber (number) {
        const Kt = Math.floor(number / 10000000) /* Koti */
        number -= Kt * 10000000
        const Gn = Math.floor(number / 100000) /* lakh  */
        number -= Gn * 100000
        const kn = Math.floor(number / 1000) /* Thousands (kilo) */
        number -= kn * 1000
        const Hn = Math.floor(number / 100) /* Hundreds (hecto) */
        number -= Hn * 100
        const Dn = Math.floor(number / 10) /* Tens (deca) */
        const n = number % 10 /* Ones */

        let res = ''

        if (Kt) {
            res += this.convertNumber(Kt) + ' Koti '
        }
        if (Gn) {
            res += this.convertNumber(Gn) + ' Lakh'
        }

        if (kn) {
            res += (this.empty(res) ? '' : ' ') +
            this.convertNumber(kn) + ' Thousand'
        }

        if (Hn) {
            res += (this.empty(res) ? '' : ' ') +
            this.convertNumber(Hn) + ' Hundred'
        }

        const ones = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
            'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve', 'Thirteen',
            'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eightteen',
            'Nineteen']
        const tens = ['', '', 'Twenty', 'Thirty', 'Fourty', 'Fifty', 'Sixty',
            'Seventy', 'Eigthy', 'Ninety']

        if (Dn || n) {
            if (!this.empty(res)) {
            res += ' and '
            }

            if (Dn < 2) {
            res += ones[Dn * 10 + n]
            } else {
            res += tens[Dn]

            if (n) {
                res += '-' + ones[n]
            }
            }
        }

        if (this.empty(res)) {
            res = 'zero'
        }

        return res
    },
    convertNumberToBanglaWords (amount) {
        const Words = ['', 'এক', 'দুই', 'তিন', 'চার', 'পাঁচ', 'ছয়', 'সাত', 'আট', 'নয়', 'দশ',
            'এগার', 'বার', 'তের', 'চৌদ্দ', 'পনের', 'ষোল', 'সতের', 'আঠার', 'ঊনিশ', 'বিশ',
            'একুশ', 'বাইশ', 'তেইশ', 'চব্বিশ', 'পঁচিশ', 'ছাব্বিশ', 'সাতাশ', 'আঠাশ', 'ঊনত্রিশ', 'ত্রিশ',
            'একত্রিশ', 'বত্রিশ', 'তেত্রিশ', 'চৌত্রিশ', 'পঁয়ত্রিশ', 'ছত্রিশ', 'সাঁইত্রিশ', 'আটত্রিশ', 'ঊনচল্লিশ', 'চল্লিশ',
            'একচল্লিশ', 'বিয়াল্লিশ', 'তেতাল্লিশ', 'চুয়াল্লিশ', 'পঁয়তাল্লিশ', 'ছেচল্লিশ', 'সাতচল্লিশ', 'আটচল্লিশ', 'ঊনপঞ্চাশ', 'পঞ্চাশ',
            'একান্ন', 'বায়ান্ন', 'তিপ্পান্ন', 'চুয়ান্ন', 'পঞ্চান্ন', 'ছাপ্পান্ন', 'সাতান্ন', 'আটান্ন', 'ঊনষাট', 'ষাট',
            'একষট্টি', 'বাষট্টি', 'তেষট্টি', 'চৌষট্টি', 'পঁয়ষট্টি', 'ছেষট্টি', 'সাতষট্টি', 'আটষট্টি', 'ঊনসত্তর', 'সত্তর',
            'একাতর', 'বাহাত্তর', 'তিয়াত্তর', 'চুয়াত্তর', 'পঁচাত্তর', 'ছিয়াত্তর', 'সাতাত্তর', 'আটাত্তর', 'ঊনআশি', 'আশি',
            'একাশি', 'বিরাশি', 'তিরাশি', 'চুরাশি', 'পঁচাশি', 'ছিয়াশি', 'সাতাশি', 'আটাশি', 'ঊননব্বই', 'নব্বই',
            'একানব্বই', 'বিরানব্বই', 'তিরানব্বই', 'চুরানব্বই', 'পঁচানব্বই', 'ছিয়ানব্বই', 'সাতানব্বই', 'আটানব্বই', 'নিরানব্বই']

        amount = amount.toString()
        const atemp = amount.split('.')
        let beforeWord = ''
        let afterWord = ''
        const beforeNumber = atemp[0]
        if (beforeNumber !== '0') {
            beforeWord = this.toWord(beforeNumber, Words)
        }
        if (atemp.length === 2) {
            const afterNumber = atemp[1]
            afterWord = this.toWord(afterNumber, Words)
            if (beforeWord !== '') {
            beforeWord += ' দশমিক ' + afterWord
            } else {
            beforeWord += 'দশমিক ' + afterWord
            }
        }
        return beforeWord
    },
    // convert to word end
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
      const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, TreeDisposalViewPdf, params)
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
    getFiscalYearName (id) {
      const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
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
    getUnitName (id) {
      const unit = this.$store.state.TeaGardenService.commonObj.unitQuantity.find(item => item.value === id)
        if (unit && this.$i18n.locale === 'bn') {
            return unit.text_bn
        } else if (unit && this.$i18n.locale === 'en') {
            return unit.text_en
        }
    },
    getTreeFellingPurposeName (id) {
      const purpose = this.$store.state.TeaGardenService.commonObj.purposeTreeFelling.find(item => item.value === id)
        if (purpose && this.$i18n.locale === 'bn') {
            return purpose.text_bn
        } else if (purpose && this.$i18n.locale === 'en') {
            return purpose.text_en
        }
    },
    getForestResourceName (id) {
      const purpose = this.$store.state.TeaGardenService.commonObj.forestResource.find(item => item.value === id)
        if (purpose && this.$i18n.locale === 'bn') {
            return purpose.text_bn
        } else if (purpose && this.$i18n.locale === 'en') {
            return purpose.text_en
        }
    },
    getTreeName (id) {
        const treeName = this.$store.state.TeaGardenService.commonObj.masterTreeList.find(item => item.value === id)
        if (treeName && this.$i18n.locale === 'bn') {
            return treeName.text_bn
        } else if (treeName && this.$i18n.locale === 'en') {
            return treeName.text_en
        }
    },
    getSectionName (id) {
        const obj = this.gardenSectionDetail.find(item => item.value === id)
        if (obj && this.$i18n.locale === 'bn') {
            return obj.text_bn
        } else if (obj && this.$i18n.locale === 'en') {
            return obj.text_en
        }
    },
    getTreeClassResource (data) {
      var treeClassResoruce = []
      if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.TeaGardenService.commonObj.forestResource.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            treeClassResoruce.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            treeClassResoruce.push(item.text_en)
          }
          })
      }
      return treeClassResoruce.toString()
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
