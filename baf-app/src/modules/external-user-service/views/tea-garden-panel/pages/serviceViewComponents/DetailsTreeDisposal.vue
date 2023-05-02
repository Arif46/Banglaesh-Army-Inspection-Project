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
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Does the Applicant have any other Tea Garden?"
                                      label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <table class="table table-sm table-bordered">
                                            <thead>
                                              <tr>
                                                <th>Garden Name</th>
                                                <th>Division</th>
                                                <th>District</th>
                                                <th>City Corporation</th>
                                                <th>Address</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr>
                                                <td>Zareen</td>
                                                <td>Sylhet</td>
                                                <td>Srimangal</td>
                                                <td>Balisera</td>
                                                <td>Malnichhera, Sylhet, Bangladesh</td>
                                              </tr>
                                              <tr>
                                                <td>Chundeecherra</td>
                                                <td>Sylhet</td>
                                                <td>Maulvibazar</td>
                                                <td>Chadpur-Bagan</td>
                                                <td>Malnichhera, Sylhet, Bangladesh</td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3"
                                      label="Whether the applicant is capable of investing at 10 Lacs in the Tea Garden per year"
                                      label-size="md" label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <b-form-group label="Amount of Income Tax paid last year:"
                                            label-for="AmountIncomeTaxPaidLastYear">
                                            <p class="input-field">3,42,210 Tk</p>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <b-row>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group label="Was the Application for Registration rejected before:"
                                          label-for="ApplicationRegistrationRejectedBefore" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">Lorem ipsum dolor sit amet consectetur molestiae.</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group label="Trade Licence/Professional licence No:"
                                          label-for="TradeLicenceProfessionallicenceNo" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">5235485562325</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group label="Mobile No:" label-for="MobileNo" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">01717249225</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                    <b-col sm="6">
                                      <div class="group-form-card">
                                        <b-form-group label="E-mail:" label-for="MailingAddress" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">tawhid.w3@gmail.com</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                  </b-row>
                                  <div class="group-form-card mt-2">
                                    <b-form-group label-cols-lg="3" label="Identity of Proprietor" label-size="md"
                                      label-class="font-weight-bold py-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <div class="table-responsive">
                                            <table class="table table-sm table-bordered mt-2">
                                              <thead>
                                                <tr>
                                                  <th>Company Name</th>
                                                  <th>Owner’s Name</th>
                                                  <th>Father’s Name</th>
                                                  <th>Mother’s Name</th>
                                                  <th>Nationality</th>
                                                  <th>Mobile No</th>
                                                  <th>Permanent Address</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr>
                                                  <td>Syntech Solution Ltd.</td>
                                                  <td>Md. Tawhiduzzaman</td>
                                                  <td>Md. Moniruzzaman</td>
                                                  <td>Mrs. Fatema</td>
                                                  <td>Bangladeshi</td>
                                                  <td>01717249225</td>
                                                  <td>Malnichhera, Sylhet, Bangladesh</td>
                                                </tr>
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
                                          label="Experience of the Owner/Share holder/Directors in Tea Production and Trade:"
                                          label-for="ExperienceOwnerTeaProductionTrade" class="form-view-item">
                                          <div class="form-group">
                                            <p class="input-field">Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia quos
                                              pariatur
                                              reprehenderit eaque maiores esse quidem illo veniam in laborum totam perferendis, aliquam
                                              est
                                              numquam
                                              nam at fugit quam similique, distinctio aperiam alias rem soluta! Veniam quisquam corporis
                                              tenetur ab
                                              suscipit inventore, tempora optio ipsa reprehenderit asperiores nam tempore dolores
                                              voluptatibus
                                              laboriosam explicabo? Reiciendis maiores labore aliquid similique fuga placeat.</p>
                                          </div>
                                        </b-form-group>
                                      </div>
                                    </b-col>
                                  </b-row>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="How the Ownership/Title acquired" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Year of Granting Lease:" label-for="YearGrantingLease">
                                            <div class="form-group">
                                              <p class="input-field">2022-2023</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Period of Lease (Years):" label-for="PeriodLease">
                                            <div class="form-group">
                                              <p class="input-field">3</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Particulars of Land (in Hectare)" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="12">
                                          <table class="table table-sm table-bordered mb-2">
                                            <thead>
                                              <tr>
                                                <th>Total Grant Area</th>
                                                <th>Area Under Tea</th>
                                                <th>Total Suitable Land for Tea</th>
                                                <th>Total Unsuitable Land for Tea</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr>
                                                <td>213</td>
                                                <td>342</td>
                                                <td>12</td>
                                                <td>232</td>
                                              </tr>
                                              <tr>
                                                <td>213</td>
                                                <td>342</td>
                                                <td>12</td>
                                                <td>232</td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mb-4">
                                    <b-form-group
                                      label="How and in whose favour garden land is recorded as per last settlement (B.S) records:"
                                      label-for="FavourGardenRecordedPerLastSettlementRecords" class="form-view-item">
                                      <div class="form-group">
                                        <p class="input-field">Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia quos
                                          pariatur
                                          reprehenderit
                                          eaque maiores esse quidem illo veniam in laborum totam perferendis, aliquam est numquam nam at
                                          fugit
                                          quam
                                          similique, distinctio aperiam alias rem soluta! Veniam quisquam corporis tenetur ab suscipit
                                          inventore,
                                          tempora
                                          optio ipsa reprehenderit asperiores nam tempore dolores voluptatibus laboriosam explicabo?
                                          Reiciendis
                                          maiores
                                          labore aliquid similique fuga placeat.</p>
                                      </div>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Land Schedule" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group label="Mouja:" label-for="Mouja">
                                            <div class="form-group">
                                              <p class="input-field">Eu cupidatat magnam</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Khotian No:" label-for="KhotianNo">
                                            <div class="form-group">
                                              <p class="input-field">546776</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Dag No:" label-for="DagNo">
                                            <div class="form-group">
                                              <p class="input-field">224</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Plantation and Production Start Year" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="In which year plantation was started first:"
                                            label-for="YearPlantationtartedFirst">
                                            <div class="form-group">
                                              <p class="input-field">2016</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="In which year production was started first:"
                                            label-for="YearProductionStartedFirst">
                                            <div class="form-group">
                                              <p class="input-field">2006</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Last 3 Years of Production and Sale Price" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Average Production (Kg. /Per Hectare):" label-for="AverageProduction">
                                            <div class="form-group">
                                              <p class="input-field">160</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Average Sale Price (Per Kg.):" label-for="AverageSalePrice">
                                            <div class="form-group">
                                              <p class="input-field">150</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mb-4">
                                    <b-form-group label="Name of the appointed Brokers for tea marketing:"
                                      label-for="NameAppointedBrokersTeaMarketing" class="form-view-item">
                                      <div class="form-group">
                                        <p class="input-field">Torikul Islam</p>
                                      </div>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Wheather the garden possesses any factory?" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group label="Production Capacity:" label-for="ProductionCapacity">
                                            <div class="form-group">
                                              <p class="input-field">8654</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Capacity of the Transformer:" label-for="CapacityTransformer">
                                            <div class="form-group">
                                              <p class="input-field">3221</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Withiring capacity:" label-for="WithiringCapacity">
                                            <div class="form-group">
                                              <p class="input-field">8654</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Other Facilities" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item mb-0">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group label="Residence Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="School Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Hospital Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Mosque/Temple Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Club/Playground Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="Supply of Drinking Water Facilities:">
                                            <div class="form-group">
                                              <p class="input-field">Yes</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card">
                                    <b-form-group label-cols-lg="3" label="Manpower Information" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="4">
                                          <b-form-group label="No. of Officers:" label-for="OfficerNo">
                                            <div class="form-group">
                                              <p class="input-field">56</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="No. of Staffs:" label-for="StaffNo">
                                            <div class="form-group">
                                              <p class="input-field">144</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="4">
                                          <b-form-group label="No. of Workers:" label-for="WorkerNo">
                                            <div class="form-group">
                                              <p class="input-field">1245</p>
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
                                    <b-form-group label-cols-lg="3" label="First Witness Info" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Witness Name:">
                                            <div class="form-group">
                                              <p class="input-field">Md. Tawhiduzzaman</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Address :">
                                            <div class="form-group">
                                              <p class="input-field">16/4 Pallabi, Mirpur-12, Dhaka-1216</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                      </b-row>
                                    </b-form-group>
                                  </div>
                                  <div class="group-form-card mt-4">
                                    <b-form-group label-cols-lg="3" label="Second Witness Info" label-size="md"
                                      label-class="font-weight-bold pt-0" class="form-view-item">
                                      <b-row>
                                        <b-col sm="6">
                                          <b-form-group label="Witness Name:">
                                            <div class="form-group">
                                              <p class="input-field">Md. Tawhiduzzaman</p>
                                            </div>
                                          </b-form-group>
                                        </b-col>
                                        <b-col sm="6">
                                          <b-form-group label="Address :">
                                            <div class="form-group">
                                              <p class="input-field">16/4 Pallabi, Mirpur-12, Dhaka-1216</p>
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
                                          <span>{{ $n(1) }}. {{ $t('dealer.applicant_image') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.applicant_image">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.applicant_image"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
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
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.trade_license"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(2) }}. {{ $t('dealer.bank_solvency') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.bank_solvency">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.bank_solvency"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(3) }}. {{ $t('dealer.nid') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.nid">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.nid"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(4) }}. {{ $t('dealer.tin') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.tin">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+appDetail.details.tin"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
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
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.vat_certificate"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(5) }}. {{ $t('dealer.shop_document') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.shop_document">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.shop_document"><i
                                                  style="font-weight:bold" class="ri-download-line download-btn"></i></a>
                                            </div>
                                            <i v-else class="ri-close-line no-btn" style="font-weight: 700"></i>
                                          </div>
                                        </div>
                                      </li>
                                      <li>
                                        <div class="d-flex justify-content-between">
                                          <span>{{ $n(7) }}. {{ $t('dealer.citizen_certificate') }}</span>
                                          <div class="list-btn">
                                            <div v-if="appDetail.details.citizen_certificate">
                                              <i class="ri-check-line yes-btn" style="font-weight: 700"></i>
                                              <a target="_blank"
                                                :href="licenseRegistrationServiceBaseUrl+appDetail.details.citizen_certificate"><i
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
                      <InspectionLoading />
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
                      <InspectionLoading />
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
import InspectionLoading from './loading/InspectionLoading.vue'
import ForwardLoading from './loading/ForwardLoading.vue'
import Loading from './loading/Details.vue'
// import { tcbApplicationShow } from '../api/routes'
import Pdf from './pdf'
export default {
  name: 'Details',
  components: {
    Loading,
    ForwardLoading,
    InspectionLoading
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
