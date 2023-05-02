<template>
    <card>
      <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('dealer.application_form') }}</h4>
          </template>
          <template v-slot:body>
            <div class="row">
              <div class="col-sm-12">
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
                            <div>
                              <div v-if="appDetail.doc_verified" class="text-right mt-2 mb-2">
                                <div class="tagTwo">
                                  {{ $t('dealer.document_verified') }}
                                </div>
                              </div>
                              <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                                <div class="" style="width:50%"><b>{{ $t('license_management.agreement_no') }}</b> : {{
                                  appDetail.agreement_no }}</div>
                                <div class="text-right" style="width:50%"><b>{{ $t('externalLrcpn.expire_date') }}</b> : {{
                                  appDetail.expire_date | dateFormat }}</div>
                              </div>
                              <div class="stepper-wrapper">
                                <div :class="item.value < appDetail.status ? `stepper-item completed` : `stepper-item`"
                                  v-for="(item, index) in stepList" :key="index">
                                  <div class="step-counter">
                                    <i v-if="item.value < appDetail.status" class="ri-check-fill"></i>
                                    <span v-else>{{ $n(index+1) }}</span>
                                  </div>
                                  <div class="step-name">{{ item.text }}</div>
                                </div>
                              </div>
                              <!-- Application view start -->
                              <div class="application-form-wrapper application-form-view-wrapper mt-5">
                                <div>
                                  <h5
                                    style="border-bottom: 2px solid #2f3542;width: 36%;margin: 3rem auto;padding-bottom: 5px;text-align: center;">Tree Disposal Application Show</h5>
                                </div>
                                <div class="application-itmes">
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Garden Information" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Registration No:">
                                            <p class="input-field">6543287657897</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Garden Name:">
                                            <p class="input-field">Malnichhera Tea Garden</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Owner Name:">
                                            <p class="input-field">Katell Henson</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Area Type:">
                                            <p class="input-field">Pauroshoba</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Division:">
                                            <p class="input-field">Sylhet</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="District:">
                                            <p class="input-field">Sylhet</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Upazila:">
                                            <p class="input-field">Amtali</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Municipality Name:">
                                            <p class="input-field">Malnichhera</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="12">
                                          <b-form-group label="Address:" label-for="AddressEn">
                                            <p class="input-field">Malnichhera, Sylhet, Bangladesh</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Tree Class of Forest Resources" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Shed Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Planted Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Natural Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Rubber</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Bamboo</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Description of Forest Resources" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Unit Quantity:">
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Shed Tree</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Plantation Year (if not natural tree):">
                                            <p class="input-field">21</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Trees:">
                                            <p class="input-field">76</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Average Diameter / Size:">
                                            <p class="input-field">24</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Quantity (Approx):">
                                            <p class="input-field">21</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Area/Location of Forest Resources" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <table class="table table-sm table-bordered section-tree-view-table">
                                            <thead>
                                              <tr>
                                                <th>Section</th>
                                                <th>Mouja (En)</th>
                                                <th>khotian</th>
                                                <th>Dag No</th>
                                                <th>Tree Name</th>
                                                <th>Number of Trees</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr>
                                                <td>90 B</td>
                                                <td>Joan Workman</td>
                                                <td>33</td>
                                                <td>33</td>
                                                <td class="p-0">
                                                  <table class="table table-sm m-0">
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">ts sdf sdf df</td>
                                                    </tr>
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">ts sdf sdf df</td>
                                                    </tr>
                                                  </table>
                                                </td>
                                                <td class="p-0">
                                                  <table class="table table-sm m-0">
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">3</td>
                                                    </tr>
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">3</td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="5" class="text-right">
                                                  <b>Sub Total</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="5" class="text-right">
                                                  <b>Grand Total</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="6" class="text-right pe-5">
                                                  <b>(Two)</b>
                                                </td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Purpose of Tree Felling" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Tea Cultivation Extension</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Planted Rubber</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Diseased Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Others</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="How many types of trees will be cut?" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Total Cutable Trees:">
                                            <p class="input-field">64</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Re-plantable Trees:">
                                            <p class="input-field">6</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Very Old Trees:">
                                            <p class="input-field">14</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Rubber Trees:">
                                            <p class="input-field">18</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Diseased Trees:">
                                            <p class="input-field">74</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Other Trees:">
                                            <p class="input-field">31</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Tea Board's Memorial Number" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Memorial Number:">
                                            <p class="input-field">66234</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Date:">
                                            <p class="input-field">2022-10-31</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Tree Class of Forest Resources" label-size="md" label-class="font-weight-bold pt-0"
                                      class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Planted Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Others</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Description of Forest Resources" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Unit Quantity:">
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Cubic Feet</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Plantation Year (if not natural tree):">
                                            <p class="input-field">21</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Number of Trees:">
                                            <p class="input-field">76</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Average Diameter / Size:">
                                            <p class="input-field">24</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Quantity (Approx):">
                                            <p class="input-field">21</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Area/Location of Forest Resources" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <table class="table table-sm table-bordered section-tree-view-table">
                                            <thead>
                                              <tr>
                                                <th>Section</th>
                                                <th>Mouja (En)</th>
                                                <th>khotian</th>
                                                <th>Dag No</th>
                                                <th>Tree Name</th>
                                                <th>Number of Trees</th>
                                                <th>Approved Tree</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr>
                                                <td>90 B</td>
                                                <td>Joan Workman</td>
                                                <td>33</td>
                                                <td>33</td>
                                                <td class="p-0">
                                                  <table class="table table-sm m-0">
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">ts sdf sdf df</td>
                                                    </tr>
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">ts sdf sdf df</td>
                                                    </tr>
                                                  </table>
                                                </td>
                                                <td class="p-0">
                                                  <table class="table table-sm m-0">
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">3</td>
                                                    </tr>
                                                    <tr>
                                                      <td style="border: none;border-bottom: 1px solid #dee2e6;">3</td>
                                                    </tr>
                                                  </table>
                                                </td>
                                                <td>0</td>
                                              </tr>
                                              <tr>
                                                <td colspan="5" class="text-right">
                                                  <b>Sub Total</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="5" class="text-right">
                                                  <b>Grand Total</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                                <td class="text-center">
                                                  <b>6</b>
                                                </td>
                                              </tr>
                                              <tr>
                                                <td colspan="7" class="text-right pe-5">
                                                  <b>(Two)</b>
                                                </td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Purpose of Tree Felling" label-size="md" label-class="font-weight-bold pt-0"
                                      class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group>
                                            <p class="input-field">
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Re-Plantation</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Very Old Tree</b-badge>
                                              <b-badge variant="primary" class="rounded mb-1 mr-1">Diseased Tree</b-badge>
                                            </p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Does the Garden have a development plan? If so, please mention that the plan was approved in which LTC Committee meeting. Also mention the detail of the plantation program" label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Fiscal Year:">
                                            <p class="input-field">2015-2016</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Amplification / Replacement Planting (Hectares):">
                                            <p class="input-field">26</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Re-plantation / Block Infilling (Hectares):">
                                            <p class="input-field">14</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Rubber (Hectares):">
                                            <p class="input-field">18</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Afforestation (Hectares):">
                                            <p class="input-field">74</p>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Other Plants (Hectares):">
                                            <p class="input-field">31</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </b-col>
                          <b-col md="12" class="text-right">
                            <b-button variant="primary " class="btn-sm" @click="back()">{{ $t('globalTrans.back') }}</b-button>
                          </b-col>
                        </b-row>
                      </div>
                    </b-overlay>
                  </b-tab>
                  <b-tab :title="$t('license_management.forward_history')">
                    <div v-if="forwarLoad || loading" class="col-md-12">
                      <forward-loading></forward-loading>
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(forward, index) in appDetail.forwards" :key="index">
                          <b-card>
                            <b-card-title>
                              <h5 style="font-size:17px">{{ getCardTitle(forward) }}</h5>
                            </b-card-title>
                            <b-card-sub-title style="font-size:14px">
                              <span class="badge badge-success">{{ $t('license_management.sender') }}</span> : {{
                              getUserName(forward.sender_id) }} <i class=" ml-3 ri-arrow-right-line"></i>
                              <span class="badge badge-primary ml-3">{{ $t('license_management.receiver') }}</span> : {{
                              getUserName(forward.receiver_id) }}
                            </b-card-sub-title>
                            <b-card-text class="mt-3">
                              <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? forward.note_bn : forward.note_en
                                }}</span>
                            </b-card-text>
                            <div v-if="forward.attachment" class="text-right">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl + forward.attachment"><button
                                  style="padding: 2px 10px;" class="btn btn-success btn-sm"><i class="ri-download-2-line"></i> {{
                                  $t('globalTrans.download') }}</button></a>
                            </div>
                          </b-card>
                        </div>
                      </div>
                    </div>
                  </b-tab>
                  <!-- <b-tab :title="$t('license_management.approve_reject_history')"><p>I'm the second tab</p></b-tab> -->
                  <b-tab v-if="appDetail.inspection" :title="$t('license_management.inspection')">
                    <div v-if="loading">
                      <RecommendationLoading />
                    </div>
                    <div v-else>
                      <b-card>
                        <b-card-body>
                          <b-overlay>
                            <b-row>
                              <b-col md="10" offset-md="1">
                                <div class="text-center mb-4 mt-2">
                                  <h5 class="card-title" style="border-bottom: 2px solid gray;font-weight: 600">{{
                                    $t('license_management.inspection') }}</h5>
                                </div>
                                <div>
                                  <table class="table table-striped table-hover table-bordered">
                                    <tbody>
                                      <tr>
                                        <td width="20%">
                                          <b>{{ $t('license_management.attachment') }}</b>
                                        </td>
                                        <td class="text-left"><a target="_blank"
                                            :href="licenseRegistrationServiceBaseUrl + appDetail.inspection.attachment"><button
                                              style="padding: 2px 10px;" class="btn btn-success btn-sm ml-1"><i
                                                class="ri-download-2-line"></i> {{ $t('globalTrans.download') }}</button></a></td>
                                      </tr>
                                      <tr>
                                        <td width="5%">
                                          <b>{{ $t('globalTrans.note') }} : </b>
                                        </td>
                                        <td class="text-left">{{ $i18n.locale === 'bn' ? appDetail.inspection.note_bn :
                                          appDetail.inspection.note_en }}</td>
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
                  <b-tab v-if="appDetail.agreement_no" :title="$t('license_management.agreement')">
                    <div v-if="loading">
                      <RecommendationLoading />
                    </div>
                    <div v-else>
                      <b-card>
                        <b-card-body>
                          <b-overlay>
                            <b-row>
                              <b-col md="10" offset-md="1">
                                <div class="text-center mb-4 mt-2">
                                  <h5 class="card-title" style="border-bottom: 2px solid gray;font-weight: 600">{{
                                    $t('license_management.agreement') }}</h5>
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
                                        <td class="text-left">{{ appDetail.expire_date | dateFormat }}</td>
                                      </tr>
                                      <tr>
                                        <td width="50%">
                                          {{ $t('license_management.attachment') }}
                                        </td>
                                        <td class="text-left"><a target="_blank"
                                            :href="licenseRegistrationServiceBaseUrl + appDetail.agreement_attachment"><button
                                              style="padding: 2px 10px;" class="btn btn-success btn-sm ml-1"><i
                                                class="ri-download-2-line"></i> {{ $t('globalTrans.download') }}</button></a></td>
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
                  <b-tab v-if="appDetail.reviews && appDetail.reviews.length" :title="$t('license_management.review')">
                    <div v-if="loading" class="col-md-12">
                      <forward-loading></forward-loading>
                    </div>
                    <div v-else class="row">
                      <div class="col-md-10 offset-md-1">
                        <div v-for="(review, index) in appDetail.reviews" :key="index">
                          <b-card class="mt-2">
                            <span :class="review.action_type === 2 ? `badge badge-danger` : `badge badge-warning`">{{
                              getStatusName(review.action_type) }}</span>
                            <b-card-text class="mt-3">
                              <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? review.note_bn : review.note_en
                                }}</span>
                            </b-card-text>
                          </b-card>
                        </div>
                      </div>
                    </div>
                  </b-tab>
                </b-tabs>
              </div>
            </div>
          </template>
      </body-card>
    </card>
</template>
<script>
import RestApi, { authServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import RecommendationLoading from './loading/RecommendationLoading.vue'
import ForwardLoading from './loading/ForwardLoading.vue'
import Loading from './loading/Details.vue'
// import { tcbApplicationShow } from '../api/routes'
import Pdf from './pdf'
export default {
  name: 'Details',
  components: {
    Loading,
    ForwardLoading,
    RecommendationLoading
  },
  data () {
    return {
      loading: false,
      forwarLoad: false,
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      appDetail: {
        reviews: [],
        org_id: 0,
        region_id: 0,
        applicant_name: '',
        applicant_name_bn: '',
        fasp_name: '',
        fasp_name_bn: '',
        mobile: '',
        other_family_license: false,
        other_dealer_name: '',
        other_dealer_name_bn: '',
        other_company_name: '',
        other_company_name_bn: '',
        other_company_division_id: 0,
        other_company_district_id: 0,
        other_company_upazilla_id: 0,
        company_name: '',
        company_name_bn: '',
        company_division_id: 0,
        company_district_id: 0,
        company_upazilla_id: 0,
        office_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: 0,
        union_id: 0,
        village: '',
        village_bn: '',
        dob: '',
        nid_no: '',
        marital_status: 1,
        father_nid_no: '',
        spouse_nid_no: '',
        email: '',
        tin_no: '',
        applicant_image: [],
        trade_license: [],
        bank_solvency: [],
        nid: [],
        tin: [],
        shop_document: [],
        vat_certificate: [],
        citizen_certificate: []
      },
      users: []
    }
  },
  created () {
    this.appDetail = this.getAppDetail()
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
    getCardTitle (tcb) {
      const tcbStep = this.$store.state.LicenseRegistrationService.commonObj.tcbStepList.find(item => item.value === parseInt(tcb.step_id))
      if (typeof tcbStep !== 'undefined') {
        return this.$i18n.locale === 'bn' ? tcbStep.text_bn : tcbStep.text_en
      } else {
        return ''
      }
    },
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
        this.loading = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/license-management/application-list/show' + '/' + this.appId)
        if (result.success) {
          this.appDetail = result.data
          if (this.appDetail.forwards.length) {
            this.getForwardedUsers(result.data.forwards)
          }
        }
        this.loading = false
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
        const reportTitle = this.$t('li_step.expiration_passed_report')
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.appDetail)
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
