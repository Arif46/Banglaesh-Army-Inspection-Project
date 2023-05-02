<template>
  <b-container fluid v-if="hidden">
    <body-card>
      <template v-slot:body>
        <b-overlay :show="unitLoadDetails">
          <button @click="printDiv()" class="btn btn-success btn-sm mb-2"><i class="ri-printer-line mr-0"></i>
            {{ $t('globalTrans.print') }}
          </button>
          <div style="background-color: green;margin-bottom: 5px;float:right" v-if=" transferData.all_service_data.doc_verified === 1">
            <h6 class="text-white mr-0 p-2"> {{ $t('li_step.docu_verify') }} </h6>
          </div>
          <div class="row p-4 mt-3" id="printArea">
            <div class="col-md-12">
              <div id="serviceInfo">
                <b-row>
                  <b-col lg="12" sm="12">
                    <div class="stepper-wrapper">
                      <div :class="getStepOrder(stepData.step_id) >= item.order ? `stepper-item completed` : `stepper-item`" v-for="(item,index) in stepList" :key="index">
                        <div class="step-counter">
                          <i v-if="((getStepOrder(stepData.step_id) > item.order) || (transferData.all_service_data.issue_date))" class="ri-check-fill"></i>
                          <span v-else>{{ index+1 }}</span>
                        </div>
                        <div class="step-name">{{ item.text }}</div>
                      </div>
                    </div>
                  <!-- <b-button @click="backStep()" variant="primary" class="mr-1" style="float: right;">{{ $t('globalTrans.back') }}</b-button> -->
                  </b-col>
                </b-row>
                <template>
                  <div style="background-color: #005B5B;margin-bottom: 5px">
                    <h5 style="padding: 5px;color: #fff;"> {{ $t('externalLrcpn.service_information') }} </h5>
                  </div>
                </template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-table-simple striped bordered small class="mt-1">
                      <b-tr>
                        <b-th>{{$t('user_role.organization')}}</b-th>
                        <b-td> {{ getMainStoreData('orgList', gridSearch.org_id) }} </b-td>
                        <b-th>{{$t('org_pro.service_namel')}}</b-th>
                        <b-td> {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', gridSearch.service_id) }} </b-td>
                      </b-tr>
                    </b-table-simple>
                  </b-col>
                </b-row>
                <template>
                    <div style="background-color: #005B5B;margin-bottom: 5px">
                      <h5 style="padding: 5px;color: #fff;"> {{ $t('externalLrcpn.office_information') }} </h5>
                    </div>
                </template>
                  <b-row>
                      <b-col lg="12" sm="12">
                          <b-table-simple striped bordered small class="mt-1" v-if="!officeCategoryShow">
                            <b-tr>
                              <b-th>{{$t('org_pro.area_type')}}</b-th>
                              <b-td> {{ singleAreaType(officeData.area_type_id) }} </b-td>
                              <b-th>{{$t('globalTrans.division')}}</b-th>
                              <b-td> {{ singleDivision(officeData.division_id) }} </b-td>
                              <b-th>{{$t('globalTrans.district')}}</b-th>
                              <b-td> {{ singleDistrict(officeData.district_id) }} </b-td>
                            </b-tr>
                            <b-tr>
                                <b-th v-show="PauroshobaItemShow || UnionItemShow">{{$t('org_pro_upazilla.upazilla')}}</b-th>
                                <b-td v-show="PauroshobaItemShow || UnionItemShow"> {{ singleUpazilla(officeData.upazilla_id) }} </b-td>
                                <b-th v-show="CityCorpItemShow">{{$t('org_pro.city_corporation')}}</b-th>
                                <b-td v-show="CityCorpItemShow"> {{ singleCityCorporation(officeData.city_corporation_id) }} </b-td>
                                <b-th v-show="officeItemSHow">{{$t('elearning_config.office_type')}}</b-th>
                                <b-td v-show="officeItemSHow"> {{ singleOfficeType(officeData.office_type_id) }} </b-td>
                                <b-th v-show="officeItemSHow">{{$t('globalTrans.office')}}</b-th>
                                <b-td v-show="officeItemSHow"> {{ singleOffice(officeData.office_id) }} </b-td>
                            </b-tr>
                          </b-table-simple>
                          <b-table-simple striped bordered small class="mt-1" v-if="officeCategoryShow">
                            <b-tr>
                              <b-th> {{$t('externalLrcpn.office_cat')}}</b-th>
                              <b-td> {{ getOfficeCategory(officeData.office_cat_id) }} </b-td>
                              <b-th> {{$t('globalTrans.division')}}</b-th>
                              <b-td> {{ singleDivision(officeData.division_id) }} </b-td>
                              <b-th> {{$t('globalTrans.district')}}</b-th>
                              <b-td> {{ singleDistrict(officeData.district_id) }} </b-td>
                            </b-tr>
                            <b-tr>
                              <b-th> {{$t('org_pro_upazilla.upazilla')}}</b-th>
                              <b-td> {{ singleUpazilla(officeData.upazilla_id) }} </b-td>
                              <b-th> {{$t('globalTrans.office')}}</b-th>
                              <b-td> {{ singleOffice(officeData.office_id) }} </b-td>
                              <b-th></b-th>
                              <b-td></b-td>
                            </b-tr>
                          </b-table-simple>
                      </b-col>
                  </b-row>
              </div>
              <template v-if="oldView">
                <div style="background-color: #005B5B;margin-bottom: 5px">
                  <h5 class="text-white ml-2"> {{ $t('externalLrcpn.prev_license_information') }} </h5>
                </div>
              </template>
              <b-row v-if="oldView">
                  <b-col lg="12" sm="12">
                      <b-table-simple striped bordered small class="mt-1">
                        <b-tr>
                          <b-th>{{$t('li_step.license_no')}}</b-th>
                          <b-td>{{ pDatas.old_application[0].generate_id }}</b-td>
                          <b-th>{{$t('externalLrcpn.book_no')}}</b-th>
                          <b-td>{{ pDatas.old_application[0].book_no }}</b-td>
                        </b-tr>
                        <b-tr>
                          <b-th>{{$t('externalLrcpn.issue_date')}}</b-th>
                          <b-td> {{ pDatas.old_application[0].issue_date }} </b-td>
                          <b-th>{{$t('externalLrcpn.expire_date')}}</b-th>
                          <b-td> {{ pDatas.old_application[0].expire_date }} </b-td>
                        </b-tr>
                      </b-table-simple>
                  </b-col>
              </b-row>
              <b-row>
                <b-col md="12" lg="12" sm="12" :show="unitLoadDetails">
                  <b-card no-body>
                    <b-tabs v-model="tabIndex">
                      <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                        <template v-slot:title>
                          <span>{{ local === 'bn' ? item.tab_title_bn : item.tab_title }}</span>
                        </template>
                        <template :id="index">
                          <b-row>
                          </b-row>
                          <b-row id="nothiArea">
                            <b-col md="12" lg="12" sm="12">
                              <grid-layout :layout.sync="layout"
                                :col-num="colNum"
                                :row-height="15"
                                :is-draggable="false"
                                :is-resizable="false"
                                :vertical-compact="false"
                                :prevent-collision="true"
                                :use-css-transforms="true"
                                :key="layoutKey"
                              >
                                <grid-item style="height: auto !important" v-for="(item, dindex) in layout"
                                  :x="item.x"
                                  :y="item.y"
                                  :w="item.w"
                                  :h="item.h"
                                  :i="item.i"
                                  :dataType="item.dataType"
                                  :key="dindex"
                                >
                                  <Input :tmpData="formIData" :index="dindex" v-if="item.dataType === 'InputField'" />
                                  <Dropdown :data="formIData[dindex]" :drpChangeData="getChildDropdown(dindex)" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                  <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                  <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                  <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                  <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                  <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                  <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                  <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                  <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                                  <template v-if="item.dataType === 'RelationalField'">
                                    <b-row>
                                      <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                      <RelationalDetails :tmpData="relationDataAll[item.i]"/>
                                    </b-row>
                                  </template>
                                  <template v-if="item.dataType === 'Add More'">
                                      <AddMoreDetails :tmpData="getAddMoreData(item)" :colData="getLayoutItemColumnsData(item)" :key="addDetail" class="mt-3"/>
                                  </template>
                                </grid-item>
                              </grid-layout>
                            </b-col>
                          </b-row>
                        </template>
                      </b-tab>
                      <b-tab :title="$t('budget.forwardComments')" v-if="forwardComment">
                        <div class="row">
                          <b-col lg="12" sm="12">
                              <b-overlay :show="forwarLoad">
                                <div style="background-color: #005B5B;margin-bottom: 5px">
                                  <h5 class="text-white ml-2"> {{  $t('budget.forwardComments') }} </h5>
                                </div>
                                <b-table-simple striped bordered small class="mt-2">
                                    <b-tr>
                                        <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th>{{ $t('li_step.sender_from') }}</b-th>
                                        <b-th>{{ $t('li_step.send_to') }}</b-th>
                                        <b-th>{{ $t('budget.comment') }}</b-th>
                                        <b-th>{{ $t('globalTrans.date_time') }}</b-th>
                                    </b-tr>
                                    <b-tr v-for="(forward,index) in forwardList" :key="index">
                                        <b-td>{{ $n(index+1) }}</b-td>
                                        <b-td>{{ getUserName(forward.sender_id) }}</b-td>
                                        <b-td>{{ getUserName(forward.receiver_id) }}</b-td>
                                        <b-td>{{ $i18n.locale === 'bn' ? forward.note_bn : forward.note_en }}</b-td>
                                        <b-td>{{ forward.created_at | dateFormatTime }}</b-td>
                                    </b-tr>
                                </b-table-simple>
                              </b-overlay>
                          </b-col>
                        </div>
                      </b-tab>
                      <b-tab :title="$t('li_step.approve_reject_note')" v-if="rejectapprove">
                        <div class="row">
                            <b-col lg="12" sm="12">
                              <b-overlay :show="forwarLoad">
                                <div style="background-color: #005B5B;margin-bottom: 5px">
                                  <h5 class="text-white ml-2"> {{ $t('li_step.approve_reject_note') }} </h5>
                                </div>
                                <b-table-simple striped bordered small class="mt-2">
                                  <b-tr>
                                      <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                      <b-th>{{ $t('dynamic_form.note') }}</b-th>
                                      <b-th>{{ $t('li_step.note_type') }}</b-th>
                                      <b-th>{{ $t('globalTrans.attachment') }}</b-th>
                                  </b-tr>
                                  <b-tr v-for="(reject, index) in transferData.all_service_data.app_rejects " :key="index">
                                      <b-td>{{ $n(index+1) }}</b-td>
                                      <b-td>{{ reject.note }}</b-td>
                                      <b-td>{{ reject.status === 1 ? $t('budget.approve') : $t('budget.reject') }}</b-td>
                                      <b-td>
                                          <a target="_blank" class="btn btn-sm btn-success" v-if="reject.attachment" :href="lrcpanBaseUrl + 'uploads/lrcpn/' + reject.attachment"><i style="margin: 15px 1px 15px !important; font-size: 12px" class="ri-download-line"></i></a>
                                      </b-td>
                                  </b-tr>
                                </b-table-simple>
                              </b-overlay>
                            </b-col>
                        </div>
                      </b-tab>
                      <b-tab :title="$t('li_step.payment_receipt')" v-if="paymentRecipt">
                        <div class="row">
                            <b-col lg="12" sm="12">
                                <div style="background-color: #005B5B;margin-bottom: 5px">
                                  <h5 class="text-white ml-2"> {{ $t('li_step.payment_receipt') }} </h5>
                                </div>
                                <b-tabs content-class="mt-3">
                                  <span v-for="(item, index) in history" :key="index">
                                    <b-tab :title="index" v-if="item[0].paid_type === 1">
                                      <Receipt :receipt="item" :transaction_no="index" />
                                    </b-tab>
                                    <b-tab :title="index" v-if="item[0].paid_type === 2 || item[0].paid_type === 3">
                                      <ReceiptOffline :receipt="item" :transaction_no="index" />
                                    </b-tab>
                                  </span>
                              </b-tabs>
                            </b-col>
                        </div>
                      </b-tab>
                      <div v-if="getActionForm">
                        <b-tab v-for="(item, index) in actionForms" :key="index" :active="index === 0" @click="getActionData(item)">
                          <template v-slot:title>
                            <span>{{ local === 'bn' ? item.form_title_bn : item.form_title }}</span>
                          </template>
                          <template>
                            <b-overlay :show="unitLoad" class="mt-4">
                              <div class="row">
                                <ActionDetails :ActionData="ActionData" v-if="actionLoad" :key="appKey"/>
                              </div>
                            </b-overlay>
                          </template>
                        </b-tab>
                      </div>
                      <b-tab :title="$t('li_step.lab_report')" v-if="gridSearch.org_id === 2" @click="getreportData()">
                        <div class="row">
                          <b-col lg="12" sm="12">
                              <b-overlay :show="labreportLoad">
                                <div style="background-color: #005B5B;margin-bottom: 5px">
                                  <h5 class="text-white ml-2"> {{  $t('li_step.lab_report') }} </h5>
                                </div>
                                <b-table-simple striped bordered small class="mt-2">
                                    <b-tr>
                                        <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th>{{ $t('li_step.lab_name') }}</b-th>
                                        <b-th>{{ $t('li_step.report_by') }}</b-th>
                                        <b-th>{{ $t('li_step.ingredient_name') }}</b-th>
                                        <b-th>{{ $t('li_step.report') }}</b-th>
                                    </b-tr>
                                    <b-tr v-for="(report,index) in reportList" :key="index">
                                        <b-td>{{ $n(index+1) }}</b-td>
                                        <b-td>{{ getLabName(report.lab_id) }}</b-td>
                                        <b-td>{{ getUserName(report.officer_id) }}</b-td>
                                        <b-td>{{ getIngredientName(report.ingrident_id) }}</b-td>
                                        <b-td>
                                          <span v-if="report.attachment === ''" class="text-danger">
                                            {{ $t('li_step.report_pending') }}
                                          </span>
                                          <span v-else>
                                            <button type="button" class="btn btn-sm btn-success">
                                              <a target="_blank" :href="lrcpanBaseUrl + 'uploads/lrcpn/' + report.attachment"><i style="margin: 15px 1px 15px !important; font-size: 12px" class="ri-download-line"></i></a>
                                            </button>
                                          </span>
                                        </b-td>
                                    </b-tr>
                                </b-table-simple>
                              </b-overlay>
                          </b-col>
                        </div>
                      </b-tab>
                      <b-tab :title="$t('boro_import.import_seed_amount')" v-if="addmore_update">
                        <div class="row">
                          <b-col lg="12" sm="12">
                            <div style="background-color: #005B5B;margin-bottom: 5px">
                              <h5 class="text-white ml-2"> {{  $t('boro_import.import_seed_amount') }} </h5>
                            </div>
                            <b-table-simple striped bordered small class="mt-2">
                                <b-tr>
                                    <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                    <b-th>{{ $t('boro_import.variety_name') }}</b-th>
                                    <b-th>{{ $t('boro_import.meeting_date') }}</b-th>
                                    <b-th>{{ $t('boro_import.meeting_number') }}</b-th>
                                    <b-th> {{ $t('boro_import.af_1') }}</b-th>
                                    <b-th> {{ $t('boro_import.a_line') }}</b-th>
                                    <b-th> {{ $t('boro_import.r_line') }}</b-th>
                                    <b-th> {{ $t('boro_import.seed_produce') }}</b-th>
                                    <b-th> {{ $t('boro_import.abadi_jomi') }}</b-th>
                                </b-tr>
                                <b-tr v-for="(item, index) in addmore_updateData" :key="index">
                                  <b-td>
                                    {{ $n(index + 1) }}
                                  </b-td>
                                  <b-td v-for="(ditem, dindex) in item" :key="dindex">
                                    {{ ditem }}
                                  </b-td>
                                </b-tr>
                            </b-table-simple>
                          </b-col>
                        </div>
                      </b-tab>
                    </b-tabs>
                  </b-card>
                </b-col>
              </b-row>
            </div>
            <div class="col-md-8">
              <span v-for="(btn, index) in JSON.parse(actionsList.actions)" :key="index">
                <span v-if="btn === 1 || btn === 2 || btn === 3 || btn === 4 || btn === 6 || btn === 7 || btn === 9 || btn === 10 || btn === 11 || btn === 12 || btn === 13 || btn === 14 || btn === 15 || btn === 16 || btn === 21">
                  <!-- License Forward btn =3 -->
                  <span v-if="checkSendAvailable(transferData.all_service_data, transferData.all_service_data.service_id)">
                    <router-link v-if="btn === 3 && transferData.all_service_data.status !== 8" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                  </span>
                  <!-- License Verify btn = 6 -->
                  <button style='margin-left: 4px' type="button" v-if="btn === 6  && transferData.all_service_data.doc_verified !== 1" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm" @click="commonStatusChange(transferData.all_service_data, 6)"><i :class="getBtn(btn).icon"></i></button>
                  <!-- License Approve btn = 4 -->
                  <router-link v-if="btn === 4 && transferData.all_service_data.status !== 1 && transferData.all_service_data.status !== 2" :to="{ name: getBtn(btn).url, params: { stepChange, fromdetails }}" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon" @click="SetStep(transferData.all_service_data, 1)"></i></router-link>
                  <!-- License Reject btn = 7 -->
                  <router-link v-if="btn === 7 && transferData.all_service_data.status !== 2 && transferData.all_service_data.status !== 1" :to="{ name: getBtn(btn).url, params: { stepChange, fromdetails }}" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon" @click="SetStep(transferData.all_service_data, 2)"></i></router-link>
                  <!-- License Cancel btn = 9 -->
                  <template v-if="transferData.all_service_data.status !== 4">
                    <button style='margin-left: 4px' type="button" v-if="btn === 9" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm" @click="commonStatusChange(transferData.all_service_data, 9)"><i :class="getBtn(btn).icon"></i></button>
                  </template>
                  <!-- License Withdraw btn = 10 -->
                  <template v-if="transferData.all_service_data.status !== 5">
                    <button style='margin-left: 4px' type="button" v-if="btn === 10" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm" @click="commonStatusChange(transferData.all_service_data, 10)"><i :class="getBtn(btn).icon"></i></button>
                  </template>
                  <!-- License Issue btn = 12 -->
                  <template>
                    <button style='margin-left: 4px' type="button" v-if="btn === 12 && transferData.all_service_data.expire_date === null" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm" @click="commonStatusChange(transferData.all_service_data, 12)"><i :class="getBtn(btn).icon"></i></button>
                  </template>
                  <!-- License Approve and Issue -->
                  <router-link v-if="btn === 14 && transferData.all_service_data.status !== 1" :to="{ name: getBtn(btn).url, params: { pDatas, stepID } }" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"></i></router-link>
                  <!-- Send To Nothi btn = 21 -->
                  <template>
                    <button style='margin-left: 4px' type="button" v-if="btn === 21 && $store.state.Auth.authUser.ssoLogin" :title="getBtn(btn).text" :class="`btn btn-sm ml-1 `+ getBtn(btn).color" size="sm" @click="commonStatusChange(transferData.all_service_data, 21)"><i :class="getBtn(btn).icon"></i></button>
                  </template>
                </span>
              </span>
            </div>
            <div class="col-md-4 text-right">
              <button v-if="transferData.all_service_data.doc_verified !== 1 && transferData.all_service_data.status !== 7&& transferData.all_service_data.status !== 1" @click="resubmit()" class="btn btn-primary btn-sm mt-3 mr-2">{{ $t('li_step.resubmit') }}</button>
              <button @click="backStep()" class="btn btn-success btn-sm mt-3">{{ $t('globalTrans.back') }}</button>
            </div>
          </div>
        </b-overlay>
      </template>
    </body-card>
  </b-container>
</template>
<script>
import Vue from 'vue'
import VueHtmlToPaper from 'vue-html-to-paper'
import Input from '@/components/license/user/dissableField/input-field'
import Dropdown from '@/components/license/user/dissableField/dropdown-field-admin'
import Checkbox from '@/components/license/user/dissableField/checkbox-field'
import Attachment from '@/components/license/user/dissableField/attachment-field'
import Radio from '@/components/license/user/dissableField/radio-field'
import Textarea from '@/components/license/user/dissableField/textarea-field'
import Paragraph from '@/components/license/user/dissableField/paragraph-field'
import Date from '@/components/license/user/dissableField/date-field'
import Header from '@/components/license/user/dissableField/header-field'
import AddMoreDetails from '@/components/license/user/dissableField/addMoreDetails'
import PaymentCheckbox from '@/components/license/user/dissableField/payment-checkbox'
import RelationalCheckbox from '@/components/license/user/dissableField/relational-checkbox'
import RelationalDetails from '@/components/license/user/dissableField/relational-details'
import { GridLayout, GridItem } from 'vue-grid-layout'
import RestApi, { authServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { changeLogStore, licenseCancel, licenseWithdraw, licenseIssue, stepFormDetailsData, paymentReceipt, assignDataApi, reSubmitApi, licenseToNothi } from '../../api/routes'
import { isNotEmpty } from '@/utils/fliter'
import common from '@/mixins/common'
import ActionDetails from './ActionFormDetails'
import CommonLrcpn from '@/mixins/common-lrcpn'
import Receipt from './Receipt'
import ReceiptOffline from './ReceiptOffline'
const options = {
  specs: [
    'fullscreen=yes',
    'titlebar=yes',
    'scrollbars=no'
  ],
  styles: [
    'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
    'http://service.moa.gov.bd/step.css'
  ],
  autoClose: true
}
Vue.use(VueHtmlToPaper, options)
export default {
  mixins: [CommonLrcpn, common],
  props: ['transferData', 'stepData', 'nothiSend'],
  components: {
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    AddMoreDetails,
    ActionDetails,
    Receipt,
    ReceiptOffline,
    PaymentCheckbox,
    RelationalCheckbox,
    RelationalDetails
  },
  data () {
    return {
      hidden: true,
      stepChange: {
        application_id: [],
        step_id: 0,
        service_id: 0,
        org_id: 0,
        status: 1,
        appKey: 1
      },
      appKey: 1,
      relationDataAll: [],
      fromdetails: { type: 1 },
      save_status: 1,
      officeItemSHow: false,
      labreportLoad: false,
      ItemShow: false,
      inputFieldShow: false,
      ItemShowPer: false,
      CityCorpItemShow: false,
      CityCorpItemPerShow: false,
      PauroshobaItemShow: false,
      PauroshobaItemPerShow: false,
      UnionItemShow: false,
      UnionItemPerShow: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      gridSearch: {
        service_id: 0,
        org_id: 0
      },
      layout: [],
      layoutData: [],
      layoutEnData: [],
      layoutBnData: [],
      colNum: 12,
      tindex: 0,
      unitLoadDetails: false,
      unitLoad: false,
      forwarLoad: false,
      isFinal: false,
      stepList: [],
      formInputData: [],
      formInputEnData: [],
      formInputBnData: [],
      formIData: [],
      tabData: [],
      tabIndex: 0,
      componentKey: 0,
      formStatus: 0,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      serviceNamesList: [],
      step_id: '',
      totalTab: 0,
      formActions: {
        isDraft: false,
        isSubmit: false,
        isReset: false,
        isPayment: false,
        isCancel: false
      },
      service_name: '',
      sInfo: {},
      officeData: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: '0'
      },
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      officeList: [],
      forwardList: {},
      rejectList: {},
      users: [],
      stepID: '',
      layoutKey: 0,
      addDetail: 1,
      forwardComment: false,
      rejectapprove: false,
      paymentRecipt: false,
      actionsList: '',
      actionFormData: '',
      actionForms: [],
      actionFormView: false,
      formId: '',
      ActionData: {},
      actionLoad: false,
      pDatas: {},
      oldView: false,
      officeCategoryShow: false,
      officeCategoryList: [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Division' : 'বিভাগ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'District' : 'জেলা' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Upazila' : 'উপজেলা' }
      ],
      reportList: [],
      history: [],
      lrcpanBaseUrl: licenseRegistrationServiceBaseUrl,
      addmore_update: false,
      addmore_updateData: ''
    }
  },
  mounted () {
    if (this.nothiSend === 1) {
      this.$nextTick(function () {
        setTimeout(() => {
          this.nothiSendList(this.transferData.all_service_data, 21)
        }, 2000)
      })
    }
  },
  created () {
    if (this.transferData.all_service_data.old_application.length > 0) {
      this.oldView = true
    } else {
      this.oldView = false
    }
    if (this.transferData.applicationData[0].add_more_update !== '' && parseInt(this.stepData.service_id) === 22) {
      this.addmore_update = true
      this.addmore_updateData = JSON.parse(this.transferData.applicationData[0].add_more_update)
    } else {
      this.addmore_update = false
    }
    this.pDatas = this.transferData.all_service_data
    this.stepID = parseInt(this.stepData.step_id)
    this.gridSearch.org_id = parseInt(this.stepData.org_id)
    this.gridSearch.service_id = parseInt(this.stepData.service_id)
    this.stepList = this.getServiceStep(parseInt(this.stepData.service_id))
    this.step_id = parseInt(this.stepData.step_id)
    this.actionsList = this.actions(this.stepData.service_id)
    if (this.stepData) {
      this.actionFormData = this.getActionForm(this.stepData)
    }
    this.stepChange.application_id = this.stepData.application_id
    this.stepChange.org_id = parseInt(this.stepData.org_id)
    this.stepChange.service_id = parseInt(this.stepData.service_id)
    this.stepChange.step_id = parseInt(this.stepData.step_id)
  },
  watch: {
    'gridSearch.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    },
    'gridSearch.service_id': function (newVal, oldVal) {
        this.service_name = this.getServiceName(newVal)
        this.step_name = this.getGridStep(newVal).step_name
        this.loadFrom()
        this.paymentReipt()
    },
    tabIndex: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.updateLayout()
      }
    },
    'officeData.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
    },
    'officeData.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazilaList(newVal)
    },
    'officeData.office_type_id': function (newValue) {
      this.officeList = this.getOfficeList(newValue)
    },
    local: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.updateLayout()
        }
    }
  },
  computed: {
    local: function () {
        return this.$i18n.locale
    },
    officeTypeList: function () {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 0 && item.org_id === this.gridSearch.org_id).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.organizationProfileList.filter(item => item.status === 0)
    },
    areaTypeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'সিটি কর্পোরেশন' : 'City Corpoation' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'পৌরসভা' : 'Pauroshoba' },
        { value: 3, text: this.$i18n.locale === 'bn' ? 'উপজেলা' : 'Upazila' }
      ]
      return list
    },
    divisionList: function () {
      const divList = this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 0)
      return divList.map(item => {
        if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    menuInfoList () {
      const menuId = this.menuId
      return this.$store.state.LicenseRegistrationService.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    },
    step () {
      const stepId = this.stepData.step_id
      return this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === parseInt(stepId))
    },
    ingridentList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.activeIngredientList.filter(item => item.status === 1)
    },
    labList: function () {
       return this.$store.state.LicenseRegistrationService.commonObj.labList.filter(item => item.status === 1)
    }
  },
  methods: {
    checkSendAvailable (item, serviceId) {
      const actions = JSON.parse(this.actions(serviceId).actions)
      if (actions.includes(3) && actions.includes(6) && item.doc_verified === 1) {
        return true
      } else if (actions.includes(3) && actions.includes(4) && item.status === 1 && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(12) && item.generate_id !== null && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(14) && item.generate_id !== null && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(2) && actions.length < 3 && item.status !== 7) {
        return true
      } else {
        return false
      }
    },
    getLabName (labId) {
      const lab = this.labList.find(item => item.value === labId)
      if (this.$i18n.locale === 'en') {
        return lab.text_en
      } else {
        return lab.text_bn
      }
    },
    getIngredientName (ingredientId) {
      const ingredient = this.ingridentList.find(item => item.value === ingredientId)
      if (this.$i18n.locale === 'en') {
        return ingredient.text_en
      } else {
        return ingredient.text_bn
      }
    },
    componentsShow (data, id, value) {
      if (value === true) {
        const relData = {
          layout: [],
          formIData: []
        }
        let height = 0
        data.map(item => {
          if (this.$i18n.locale === 'en') {
            const layFind = this.layoutEnData.find(litem => litem.i === item && litem.tabIndex === this.tabIndex)
            height = height + layFind.h
            const inpFind = this.formInputEnData.find(litem => litem.id === item && litem.indexId === this.tabIndex)
            relData.layout.push(layFind)
            relData.formIData.push(inpFind)
          } else if (this.$i18n.locale === 'bn') {
            const layFind = this.layoutBnData.find(litem => litem.i === item && litem.tabIndex === this.tabIndex)
            height = height + layFind.h
            const inpFind = this.formInputBnData.find(litem => litem.id === item && litem.indexId === this.tabIndex)
            relData.layout.push(layFind)
            relData.formIData.push(inpFind)
          }
        })
        const layoutH = this.layout.find(item => item.i === id)
        layoutH.h = height
        this.relationDataAll[id] = relData
      } else {
        const layoutH = this.layout.find(item => item.i === id)
        layoutH.h = 2
        const relData = {
          layout: [],
          formIData: []
        }
        this.relationDataAll[id] = relData
      }
      this.layout.push()
    },
    getLayoutItemColumnsData (addMoreLayoutItem) {
      const cols = []
      cols.push({ text_en: 'SL', text_bn: 'ক্রমিক নং' })
      let fieldData = ''
      let listObj = {}
      if (this.$i18n.locale === 'en') {
        listObj = this.formInputEnData
      } else {
        listObj = this.formInputBnData
      }
      fieldData = listObj.find(item => item.id === addMoreLayoutItem.i)
      fieldData.fields.forEach(i => {
        const field = listObj.find(item => item.id === i)
        cols.push({ text_en: field.label, text_bn: field.label_bn })
      })
      return cols
    },
    getAddMoreData (addMoreLayoutItem) {
      const datas = []
      const addData = this.detailsData.filter(item => item.id === addMoreLayoutItem.i)
      addData.forEach(item => {
          const newFindData = Object.keys(item).reduce((obj, key) => {
            if (key !== 'id') {
              obj[key] = item[key]
            }
            return obj
          }, {})
          datas.push(newFindData)
      })
      return datas
    },
    async getreportData () {
      this.labreportLoad = true
      const applicationID = parseInt(this.stepData.application_id[0])
      await RestApi.getData(licenseRegistrationServiceBaseUrl, `${assignDataApi}/${applicationID}`).then(response => {
        if (response.success) {
          if (response.data.length > 0) {
            this.reportList = response.data[0].lab_details
          }
        }
        this.labreportLoad = false
      })
    },
    async paymentReipt () {
      this.unitLoad = true
      const params = {
      service_id: parseInt(this.gridSearch.service_id),
      application_id: parseInt(this.stepData.application_id[0])
      }
      await RestApi.getData(licenseRegistrationServiceBaseUrl, paymentReceipt, params).then(response => {
        if (isNotEmpty(response.data)) {
          this.paymentRecipt = true
          this.history = response.data
        } else {
          this.paymentRecipt = false
        }
      })
      this.unitLoad = false
    },
    getOfficeCategory (officeCategoryID) {
      const officeCategory = this.officeCategoryList.find(item => item.value === officeCategoryID)
      return officeCategory !== undefined ? officeCategory.text : ''
    },
    SetStep (item, status) {
      this.stepChange.application_id[0] = item.application_id
      this.stepChange.step_id = this.step.value
      this.stepChange.service_id = item.service_id
      this.stepChange.org_id = item.org_id
      this.stepChange.status = status
    },
    getActionForm (stepData) {
      const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(stepData.service_id))
      const stepOrder = this.getStepOrder(stepData.step_id)
      const OtherSteps = tmpStepList.filter(item => item.order === stepOrder || parseInt(item.order) < stepOrder)
      OtherSteps.forEach(step => {
        const findAcForm = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => item.service_id === stepData.service_id && item.step_id === step.step_id && item.org_id === stepData.org_id && item.form_type === 1)
        if (typeof findAcForm !== 'undefined') {
          this.actionForms.push(findAcForm)
        }
      })
      if (this.actionForms.length > 0) {
        this.actionFormView = true
      } else {
        this.actionFormView = false
      }
    },
    getActionData (formData) {
      this.formId = formData.form_id
      this.loadActionFrom(formData)
    },
    async loadActionFrom (formData) {
      this.unitLoad = true
      const params = {
      id: this.formId,
      service_id: parseInt(formData.service_id),
      step_id: parseInt(formData.step_id),
      applicationID: parseInt(this.stepData.application_id[0]),
      org_id: parseInt(this.stepData.org_id)
      }
      await RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormDetailsData, params).then(response => {
          if (isNotEmpty(response.data)) {
            this.actionLoad = true
            this.ActionData = response.data
          } else {
            this.actionLoad = false
          }
      })
      this.appKey = this.appKey + 1
      this.unitLoad = false
    },
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    printDiv () {
      this.$htmlToPaper('printArea')
    },
    isOdd (num) { return num % 2 },
    backStep () {
      this.$router.go(-1)
    },
    resubmit () {
      const subData = []
      this.formIData.forEach(item => {
        if (item.field_type === 'file') {
          const upData = {
            field_name: '',
            value: []
          }
          upData.field_name = item.field_name
          upData.value[0] = item.value
          upData.value[1] = item.is_commentable.yesNo
          upData.value[2] = item.is_commentable.comments
          subData.push(upData)
        }
      })
      const resubMitData = {
        stepChange: this.stepChange,
        tabName: this.tabData[this.tabIndex].tab_name,
        data: subData
      }
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, reSubmitApi, resubMitData).then(response => {
        if (response.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: 'Application Resubmit Successfully',
            color: '#D6E09B'
          })
          this.$router.go(-1)
        } else {
          this.$toast.error({
              title: 'Error',
              message: response.message
            })
          }
      })
      this.listLoading = true
    },
    getAreaTypeData (typeId) {
      this.officeItemSHow = true
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
    commonStatusChange (data, buttonID) {
      let msztitle = ''
      let Api = ''
      let message = ''
      if (buttonID === 6) {
        if (this.menuInfoList.is_forward === 1) {
          this.stepChange.is_forward = 1
        } else {
          this.stepChange.is_forward = 0
        }
        this.stepChange.step_id = this.getServiceWiseStep(data.service_id)
        this.stepChange.user_id = data.user_id
        msztitle = this.$t('globalTrans.verifyMsg')
        Api = changeLogStore
        message = 'Document Verified Successfully'
      }
      if (buttonID === 9) {
        this.stepChange.step_id = data.step_id
        msztitle = this.$t('globalTrans.cancelMsg')
        Api = licenseCancel
        message = 'License Cancel Successfully'
      }
      if (buttonID === 10) {
        this.stepChange.step_id = data.step_id
        this.stepChange.application_id = data.application_id
        msztitle = this.$t('globalTrans.withdrawMsg')
        Api = licenseWithdraw
        message = 'License Withdraw Successfully'
      }
      if (buttonID === 12) {
        this.stepChange.step_id = data.current_step
        this.stepChange.application_id[0] = data.application_id
        this.stepChange.old_application_id = data.old_application_id ? data.old_application_id : 0
        msztitle = this.$t('globalTrans.issueMsg')
        Api = licenseIssue
        message = 'License Issue Successfully'
      }
      if (buttonID === 21) {
        const servicehtml = document.getElementById('serviceInfo').innerHTML
        const applicationhtml = document.getElementById('nothiArea').innerHTML
        this.stepChange.step_id = data.step_id
        this.stepChange.application_id = data.application_id
        this.stepChange.servicehtml = servicehtml
        this.stepChange.applicationhtml = applicationhtml
        msztitle = this.$t('globalTrans.tranferToNothi')
        Api = licenseToNothi
        if (this.local === 'bn') {
          message = 'সফলভাবে নথিতে স্থানান্তর করা হয়েছে'
        } else {
          message = 'Transfered To Nothi Successfully'
        }
      }
      window.vm.$swal({
        title: msztitle,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.listLoading = true
          if (buttonID === 21) {
            this.stepChange.service_id = data.service_id
            this.stepChange.org_id = data.org_id
            RestApi.postData(licenseRegistrationServiceBaseUrl, Api, this.stepChange).then(res => {
              this.listLoading = false
              if (res.success === true) {
                this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
                this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: message,
                  color: '#D6E09B'
                })
                this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
              } else {
                this.$toast.error({
                  title: 'Error',
                  message: res.message
                })
              }
            })
          } else {
            RestApi.getData(licenseRegistrationServiceBaseUrl, Api, this.stepChange).then(res => {
              this.listLoading = false
              if (res.success === true) {
                this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
                this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: message,
                  color: '#D6E09B'
                })
                if (buttonID === 12) {
                  this.$router.go(-1)
                }
                this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
              } else {
                this.$toast.error({
                  title: 'Error',
                  message: res.message
                })
              }
            })
          }
        }
      })
    },
    async nothiSendList (data) {
      let message = ''
      if (this.local === 'bn') {
        message = 'সফলভাবে নথিতে স্থানান্তর করা হয়েছে'
      } else {
        message = 'Transfered To Nothi Successfully'
      }
      const servicehtml = document.getElementById('serviceInfo').innerHTML
      const applicationhtml = document.getElementById('nothiArea').innerHTML
      this.stepChange.step_id = data.step_id
      this.stepChange.application_id = data.application_id
      this.stepChange.servicehtml = servicehtml
      this.stepChange.applicationhtml = applicationhtml
      await RestApi.postData(licenseRegistrationServiceBaseUrl, licenseToNothi, this.stepChange).then(response => {
        if (response.success === true) {
          this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: message,
            color: '#D6E09B'
          })
          this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
        } else {
          this.$toast.error({
            title: 'Error',
            message: response.message
          })
        }
      })
      this.hidden = false
    },
    previewData (item, stepId) {
      this.pData = item
      this.stepID = stepId
      this.dtlsItemId = item.id
    },
    getServiceStep (sId) {
      const stepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === sId)
      const tmpList = stepList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.step_id, text: item.step_name_bn, order: item.order }
        } else {
          return { value: item.step_id, text: item.step_name, order: item.order }
        }
      })
      return tmpList.sort((a, b) => { return a.order - b.order })
    },
    loadFrom () {
        this.unitLoadDetails = true
        if (isNotEmpty(this.transferData)) {
          if (this.transferData.all_service_data.app_forwards.length > 0) {
            this.forwardComment = true
          } else {
            this.forwardComment = false
          }
          if (this.transferData.all_service_data.app_rejects.length > 0) {
            this.rejectapprove = true
          } else {
            this.rejectapprove = false
          }
          if (this.transferData.all_service_data.app_forwards !== undefined) {
            if (this.transferData.all_service_data.app_forwards.length > 0) {
              this.forwardList = this.transferData.all_service_data.app_forwards
              this.getForwardedUsers(this.forwardList)
            }
          }
          if (this.transferData.all_service_data.app_rejects === undefined) {
            if (this.transferData.all_service_data.app_rejects.length > 0) {
              this.rejectList = this.transferData.all_service_data.app_rejects
            }
          }
            this.getAreaTypeData(this.transferData.applicationInfo.area_type_id)
            this.officeData = this.transferData.applicationInfo
            this.formActions = JSON.parse(this.transferData.item.form_action)
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            this.transferData.item.tabs.forEach((item, tabIndex) => {
              const tabNo = item.tab_no
              const tabName = item.tab_name
              const tabTitle = item.tab_title
              const tabTitleBn = item.tab_title_bn
              const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle, tab_title_bn: tabTitleBn }
              this.tabData.push(data)
              item.viewlayouts.forEach((layItem) => {
                if (layItem.lang_type === 'en') {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.transferData.applicationData !== null) {
                    this.transferData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        this.BackButtonShow = true
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                Object.assign(dataJson, { value: [item[key]] })
                              } else if (dataJson.field_type === 'addMore_button') {
                                this.addMoreDetailsShow(JSON.parse(item[key]), dataJson.id)
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        } else {
                        this.butonShow = true
                        }
                    })
                  } else {
                    this.butonShow = true
                  }
                  this.layoutEnData.push(layJson)
                  this.formInputEnData.push(dataJson)
                  const addFind = this.layoutEnData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
                  if (addFind !== undefined) {
                    this.addMore = true
                    this.addIndex = addFind.tabIndex
                  }
                } else {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.transferData.applicationData !== null) {
                    this.transferData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        this.BackButtonShow = true
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                if (item[key] !== '') {
                                  const words = item[key].split(',')
                                  let optionVal = ''
                                  words.forEach(item => {
                                    const optionItem = dataJson.options.find(optionValue => optionValue.text === item)
                                    if (optionVal !== '') {
                                      optionVal = optionVal + ',' + optionItem.text_bn
                                    } else {
                                      optionVal = optionItem.text_bn
                                    }
                                  })
                                  Object.assign(dataJson, { value: optionVal })
                                }
                              } else if (dataJson.field_type === 'number') {
                                Object.assign(dataJson, { value: this.$n(item[key], { useGrouping: false }) })
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        } else {
                        this.butonShow = true
                        }
                    })
                  } else {
                    this.butonShow = true
                  }
                  this.layoutBnData.push(layJson)
                  this.formInputBnData.push(dataJson)
                  const addFind = this.layoutEnData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
                  if (addFind !== undefined) {
                    this.addMore = true
                    this.addIndex = addFind.tabIndex
                  }
                }
                this.tindex++
              })
            })
            this.totalTab = this.tabData.length - 1
          }
          this.unitLoadDetails = false
          this.updateLayout()
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
            if (response.success) {
              this.users = response.data
            } else {
              this.users = []
            }
            this.forwarLoad = false
        })
    },
    getUserName (userId) {
      const user = this.users.find(user => user.value === userId)
      return user !== undefined ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
    },
    reset () {
    },
    updateDropdown: function (updata, nindex) {
      this.componentKey += 1
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    addMoreDetailsShow (data, id) {
      data.forEach(item => {
        Object.assign(item, { id: id })
        this.detailsData.push(item)
      })
      this.addDetail = this.addDetail + 1
    },
    updateLayout: function (val) {
      this.layout = []
      this.formIData = []
      if (this.$i18n.locale === 'en') {
        this.layoutEnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputEnData[index]
          if (layData === true && item.is_show === false) {
            if (item.dataType === 'Add More') {
              item.h = this.getAddmoreheight(item.i)
            }
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      if (this.$i18n.locale === 'bn') {
        this.layoutBnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputBnData[index]
          if (layData === true && item.is_show === false) {
            if (item.dataType === 'Add More') {
              item.h = this.getAddmoreheight(item.i)
            }
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      this.layoutKey = this.layoutKey + 1
    },
    getAddmoreheight (i) {
      const addData = this.detailsData.filter(item => item.id === i)
      let lengthAdd = 2
      if (addData.length > 1) {
        lengthAdd = (addData.length + 1) * 2 + 2
      } else {
        lengthAdd = 8
      }
      return lengthAdd
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => (item.org_id === parseInt(orgId)))
    },
    getServiceName (sId) {
      const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === parseInt(sId))
      if (parseInt(service.office_category_check) === 1) {
        this.officeCategoryShow = true
      } else {
        this.officeCategoryShow = false
      }
      return service.text_en
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === parseInt(stId))
      return step.text_en
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    getDistrictList (divisionId = null) {
      let districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 0)
      if (divisionId) {
        districtList = districtList.filter(district => district.division_id === divisionId)
      }
      return districtList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.commonObjCommonConfig.cityCorporationList.filter(item => item.status === 0 && item.district_id === districtId)
        return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
        })
    },
    getUpazilaList (districtId = null) {
      let upazilaList = this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 0)
      if (districtId) {
         upazilaList = upazilaList.filter(upazila => upazila.district_id === districtId)
      }
      return upazilaList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 0)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
    },
    getStepOrder (stepId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => (item.service_id === parseInt(this.stepData.service_id) && item.step_id === parseInt(stepId)))
      if (typeof step === 'undefined') {
        return 0
      } else {
        return step.order
      }
    },
    singleAreaType (areaId) {
      const area = this.areaTypeList.find(item => parseInt(item.value) === areaId)
      if (area) {
        return area.text
      }
    },
    singleOfficeType (officeTypeId) {
      const officetype = this.$store.state.CommonService.commonObj.officeTypeList.find(item => item.value === officeTypeId)
      if (officetype) {
        if (this.$i18n.locale === 'bn') {
          return officetype.text_bn
        } else {
          return officetype.text_en
        }
      }
    },
    singleOffice (officeId) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeId)
      if (office) {
        if (this.$i18n.locale === 'bn') {
          return office.text_bn
        } else {
          return office.text_en
        }
      }
    },
    singleDivision (divisonId) {
      const divison = this.$store.state.CommonService.commonObj.divisionList.find(item => item.status === 0 && item.value === parseInt(divisonId))
      if (divison) {
        if (this.$i18n.locale === 'bn') {
          return divison.text_bn
        } else {
          return divison.text_en
        }
      }
    },
    singleDistrict (districtId) {
      const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.status === 0 && item.value === parseInt(districtId))
      if (district) {
        if (this.$i18n.locale === 'bn') {
          return district.text_bn
        } else {
          return district.text_en
        }
      }
    },
    singleUpazilla (upazilaId) {
      const upazila = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.status === 0 && item.value === parseInt(upazilaId))
      if (upazila) {
        if (this.$i18n.locale === 'bn') {
          return upazila.text_bn
        } else {
          return upazila.text_en
        }
      }
    },
    singleCityCorporation (cityCorporaId) {
      const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.status === 0 && item.value === parseInt(cityCorporaId))
      if (cityCorporation) {
        if (this.$i18n.locale === 'bn') {
          return cityCorporation.text_bn
        } else {
          return cityCorporation.text_en
        }
      }
    },
    actions (serviceId) {
      const stepId = parseInt(this.stepData.step_id)
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.filter(item => item.step_id === stepId && item.service_id === parseInt(serviceId))
      if (typeof actions === 'undefined') {
        return {}
      } else {
        const actionl = actions[0]
        return actionl
      }
    },
    getBtn (value) {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
    },
    getServiceWiseStep (serviceId) {
      const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
      const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.step.value))
      const order = tmpIndVStepList.order
      const orderCheck = tmpStepList.find(item => item.order === order + 1)
      if (typeof orderCheck !== 'undefined') {
        return orderCheck.step_id
      }
    }
  }
}
</script>
<style scoped>
  .vue-grid-item .resizing {
      opacity: 0.9;
  }
  .vue-grid-item .text {
      font-size: 24px;
      text-align: center;
      position: absolute;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      margin: auto;
      height: 100%;
      width: 100%;
  }
  .vue-grid-item .no-drag {
      height: 100%;
      width: 100%;
  }
  .vue-grid-item .minMax {
      font-size: 12px;
  }
  .fields {
    padding: 0.375rem 0.75rem;
  }
  .fields:hover {
    z-index: 1;
    color: #fff;
    background-color: #5a6268;
    border-radius: 0.25rem;
  }
  .dark_button .btn-secondary {
    color: #000 !important;
  }
  hr {
      border: none;
      border-top: 3px double #333;
      color: #333;
      overflow: visible;
      text-align: center;
      height: 5px;
  }
  hr:after {
      background: #fff;
      content: '';
      padding: 0 4px;
      position: relative;
      top: -13px;
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
</style>
