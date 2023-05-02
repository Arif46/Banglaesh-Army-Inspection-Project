<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper application-form-wrapper">
            <b-card title="Application Form for Registration of Tea Estate/Tea Garden/Small Tea Garden">
                <b-card-text>
                    <form-wizard shape="circle" title="" subtitle="" :start-index.sync="activeIndex">
                        <tab-content :title="$t('teaGardenConfig.garden_info')" icon="ri-file-cloud-line" :before-change="tabSubmitBasic" >
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Applicant info" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Applicant Name (En):" label-for="ApplicantNameEn">
                                                                <b-form-input id="ApplicantNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Applicant Name (Bn):" label-for="ApplicantNameBn">
                                                                <b-form-input id="ApplicantNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Designation (En):" label-for="DesignationEn">
                                                                <b-form-input id="DesignationEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Designation (Bn):" label-for="DesignationBn">
                                                                <b-form-input id="DesignationBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Garden Address" label-size="lg" label-class="font-weight-bold pt-0"
                                                    class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Tea Garden Name (En):" label-for="TeaGardenNameEn">
                                                                <b-form-input id="TeaGardenNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Tea Garden Name (Bn):" label-for="TeaGardenNameBn">
                                                                <b-form-input id="TeaGardenNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Area Type:" label-for="AreaType">
                                                                <b-form-select id="AreaType" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <!-- City Corporation Area Type -->
                                                        <b-col sm="6">
                                                            <b-form-group label="Division:" label-for="Division">
                                                                <b-form-select id="Division" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="District:" label-for="District">
                                                                <b-form-select id="District" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="City Corporation:" label-for="CityCorporation">
                                                                <b-form-select id="CityCorporation" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Ward:" label-for="Ward">
                                                                <b-form-select id="Ward" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Post Code:" label-for="PostCode">
                                                                <b-form-select id="PostCode" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (En):" label-for="AddressEn">
                                                                <b-form-textarea id="AddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (Bn):" label-for="AddressBn">
                                                                <b-form-textarea id="AddressBn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Does the Applicant have any other Tea Garden?" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-radio-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options">
                                                            </b-form-radio-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Name (En):" label-for="OtherGardenNameEn">
                                                                <b-form-input id="OtherGardenNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Name (Bn):" label-for="OtherGardenNameBn">
                                                                <b-form-input id="OtherGardenNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Area Type:" label-for="OtherAreaType">
                                                                <b-form-select id="OtherAreaType" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <!-- City Corporation Area Type -->
                                                        <b-col sm="6">
                                                            <b-form-group label="Division:" label-for="OtherGardenDivision">
                                                                <b-form-select id="OtherGardenDivision" v-model="selected" :options="options">
                                                                </b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="District:" label-for="OtherGardenDistrict">
                                                                <b-form-select id="OtherGardenDistrict" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="City Corporation:" label-for="OtherCityCorporation">
                                                                <b-form-select id="OtherCityCorporation" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Ward:" label-for="OtherWard">
                                                                <b-form-select id="OtherWard" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Post Code:" label-for="OtherPostCode">
                                                                <b-form-select id="OtherPostCode" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (En):" label-for="OtherAddressEn">
                                                                <b-form-textarea id="OtherAddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (Bn):" label-for="OtherAddressBn">
                                                                <b-form-textarea id="OtherAddressBn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-button class="add-more-btn" size="sm"><i class="ri-add-line"></i> Add More</b-button>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <table class="table table-sm table-bordered mt-3 mb-0">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Garden Name</th>
                                                                        <th>Division</th>
                                                                        <th>District</th>
                                                                        <th>City Corporation</th>
                                                                        <th class="text-center">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Zareen</td>
                                                                        <td>Sylhet</td>
                                                                        <td>Srimangal</td>
                                                                        <td>Balisera</td>
                                                                        <td class="text-center">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Chundeecherra</td>
                                                                        <td>Sylhet</td>
                                                                        <td>Maulvibazar</td>
                                                                        <td>Chadpur-Bagan</td>
                                                                        <td class="text-center">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Whether the applicant is capable of investing at 10 Lacs in the Tea Garden per year" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-radio-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options">
                                                            </b-form-radio-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Amount of Income Tax paid last year:" label-for="AmountIncomeTaxPaidLastYear">
                                                                <b-form-input id="AmountIncomeTaxPaidLastYear"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Bank Solvency Certificate:" label-for="BankSolvencyCertificate">
                                                                <b-form-file id="BankSolvencyCertificate"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <b-form-group label="Was the Application for Registration rejected before; If so, state reasons for such rejection:" label-for="ApplicationRegistrationRejectedBefore">
                                            <b-form-textarea id="ApplicationRegistrationRejectedBefore" rows="4" max-rows="4" placeholder="Enter something..."></b-form-textarea>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="12">
                                        <b-form-group label="Trade Licence/Professional licence No:" label-for="TradeLicenceProfessionallicenceNo">
                                            <b-form-input id="TradeLicenceProfessionallicenceNo"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="6">
                                        <b-form-group label="Chief Executive Name (En):" label-for="ChiefExecutiveNameEn">
                                            <b-form-input id="ChiefExecutiveNameEn"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="6">
                                        <b-form-group label="Chief Executive Name (Bn):" label-for="ChiefExecutiveNameBn">
                                            <b-form-input id="ChiefExecutiveNameBn"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="6">
                                        <b-form-group label="Mobile No:" label-for="MobileNo">
                                            <b-form-input id="MobileNo"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="6">
                                        <b-form-group label="E-mail:" label-for="MailingAddress">
                                            <b-form-input id="MailingAddress"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.identity_info')" icon="ri-contacts-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="6">
                                        <b-form-group label="Company Name (En):" label-for="CompanyNameEn">
                                            <b-form-input id="CompanyNameEn"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="6">
                                        <b-form-group label="Company Name (Bn):" label-for="CompanyNameBn">
                                            <b-form-input id="CompanyNameBn"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Identity of Proprietor" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-radio-group class="custom-control-inline-wrapper" style="margin-bottom: 10px;" size="lg" v-model="selected" :options="ownerType" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Owner’s Name (En):" label-for="GardenOwnerNameEn">
                                                                <b-form-input id="GardenOwnerNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Owner’s Name (Bn):" label-for="GardenOwnerNameBn">
                                                                <b-form-input id="GardenOwnerNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Owner Father’s Name (En):" label-for="OwnerFatherNameEn">
                                                                <b-form-input id="OwnerFatherNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Owner Father’s Name (Bn):" label-for="OwnerFatherNameBn">
                                                                <b-form-input id="OwnerFatherNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Owner Mother’s Name (En):" label-for="OwnerMotherNameEn">
                                                                <b-form-input id="OwnerFatherNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Owner Mother’s Name (Bn):" label-for="OwnerMotherNameBn">
                                                                <b-form-input id="OwnerMotherNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Permanent Address (En):" label-for="PermanentAddressEn">
                                                                <b-form-textarea id="PermanentAddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Permanent Address (Bn):" label-for="PermanentAddressBn">
                                                                <b-form-textarea id="PermanentAddressBn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Mobile No:" label-for="MobileNo1">
                                                                <b-form-input id="MobileNo1"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Owner’s Nationality:" label-for="GardenOwnerNationality">
                                                                <b-form-input id="GardenOwnerNationality"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <b-button class="add-more-btn" size="sm"><i class="ri-add-line"></i> Add More</b-button>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <table class="table table-sm table-bordered mt-3 mb-0">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Owner’s Name</th>
                                                                        <th>Father’s Name</th>
                                                                        <th>Mother’s Name</th>
                                                                        <th>Nationality</th>
                                                                        <th>Mobile No</th>
                                                                        <th class="text-center">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td>Md. Tawhiduzzaman</td>
                                                                        <td>Md. Moniruzzaman</td>
                                                                        <td>Mrs. Fatema</td>
                                                                        <td>Bangladeshi</td>
                                                                        <td>01717249225</td>
                                                                        <td class="text-center">
                                                                            <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <b-form-group label="Experience of the Owner/Share holder/Directors in Tea Production and Trade:"
                                            label-for="ExperienceOwnerTeaProductionTrade">
                                            <b-form-textarea id="ExperienceOwnerTeaProductionTrade" rows="6" max-rows="6" placeholder="Enter something..."></b-form-textarea>
                                        </b-form-group>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.landlease_info')" icon="ri-play-list-add-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="How the Ownership/Title acquired" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-radio-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="ownershipAcquired" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Year of Granting Lease:" label-for="YearGrantingLease">
                                                                <b-form-select id="YearGrantingLease" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Period of Lease (Years):" label-for="PeriodLease">
                                                                <b-form-select id="PeriodLease" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Particulars of Land (in Hectare)" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Total Grant Area:" label-for="TotalGrantArea">
                                                                <b-form-input id="TotalGrantArea"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Area Under Tea:" label-for="AreaUnderTea">
                                                                <b-form-input id="AreaUnderTea"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Total Suitable Land for Tea:" label-for="TotalSuitableLandTea">
                                                                <b-form-input id="TotalSuitableLandTea"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Total Unsuitable Land for Tea:" label-for="TotalUnsuitableLandTea">
                                                                <b-form-input id="TotalUnsuitableLandTea"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <b-form-group label="How and in whose favour garden land is recorded as per last settlement (B.S) records:" label-for="FavourGardenRecordedPerLastSettlementRecords">
                                            <b-form-textarea id="FavourGardenRecordedPerLastSettlementRecords" rows="6" max-rows="6" placeholder="Enter something..."></b-form-textarea>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Land Schedule" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="4">
                                                            <b-form-group label="Mouja:" label-for="Mouja">
                                                                <b-form-input id="Mouja"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Khotian No:" label-for="KhotianNo">
                                                                <b-form-input id="KhotianNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Dag No:" label-for="DagNo">
                                                                <b-form-input id="DagNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Garden Sketch Map:" label-for="GardenSketchMap">
                                                                <b-form-file id="GardenSketchMap"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Land Schedule Copy:" label-for="LandScheduleCopy">
                                                                <b-form-file id="LandScheduleCopy"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Khotian Attested Copy:" label-for="KhotianAttestedCopy">
                                                                <b-form-file id="KhotianAttestedCopy"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Registered Deed Attested Copy:" label-for="RegisteredDeedAttestedCopy">
                                                                <b-form-file id="RegisteredDeedAttestedCopy"></b-form-file>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Plantation and Production Start Year" label-size="lg" label-class="font-weight-bold pt-0"
                                                    class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="In which year plantation was started first:" label-for="YearPlantationtartedFirst">
                                                                <b-form-select id="YearPlantationtartedFirst" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="In which year production was started first:" label-for="YearProductionStartedFirst">
                                                                <b-form-select id="YearProductionStartedFirst" v-model="selected" :options="options"></b-form-select>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Last 3 Years of Production and Sale Price" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Average Production (Kg. /Per Hectare):"
                                                                label-for="AverageProduction">
                                                                <b-form-input type="number" id="AverageProduction"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Average Sale Price (Per Kg.):"
                                                                label-for="AverageSalePrice">
                                                                <b-form-input type="number" id="AverageSalePrice"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <b-form-group label="Name of the appointed Brokers for tea marketing:" label-for="NameAppointedBrokersTeaMarketing">
                                            <b-form-input id="NameAppointedBrokersTeaMarketing"></b-form-input>
                                        </b-form-group>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Wheather the garden possesses any factory?" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-form-radio-group class="custom-control-inline-wrapper" size="lg" v-model="selected" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Production Capacity:" label-for="ProductionCapacity">
                                                                <b-form-input type="number" id="ProductionCapacity"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Capacity of the Transformer:" label-for="CapacityTransformer">
                                                                <b-form-input type="number" id="CapacityTransformer"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Withiring capacity:" label-for="WithiringCapacity">
                                                                <b-form-input type="number" id="WithiringCapacity"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.other_info')" icon="ri-map-pin-2-fill">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Other Facilities" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="4">
                                                            <b-form-group label="Residence Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="School Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Hospital Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Mosque/Temple Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Club/Playground Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="Supply of Drinking Water Facilities:" v-slot="{ ariaDescribedby }">
                                                                <b-form-radio-group class="custom-control-inline-wrapper" v-model="selected" size="lg" :options="possessesFactory" :aria-describedby="ariaDescribedby" name="radio-options"></b-form-radio-group>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Manpower Information" label-size="lg" label-class="font-weight-bold pt-0"
                                                    class="mb-0">
                                                    <b-row>
                                                        <b-col sm="4">
                                                            <b-form-group label="No. of Officers:" label-for="OfficerNo">
                                                                <b-form-input type="number" id="OfficerNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="No. of Staffs:" label-for="StaffNo">
                                                                <b-form-input type="number" id="StaffNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="4">
                                                            <b-form-group label="No. of Workers:" label-for="WorkerNo">
                                                                <b-form-input type="number" id="WorkerNo"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <tab-content :title="$t('teaGardenConfig.witness_info')" icon="ri-list-settings-line">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="First Witness Info" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Witness Name (En):" label-for="FirstWitnessNameEn">
                                                                <b-form-input id="FirstWitnessNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Witness Name (Bn):" label-for="FirstWitnessNameBn">
                                                                <b-form-input id="FirstWitnessNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (En):" label-for="FirstWitnessAddressEn">
                                                                <b-form-textarea id="FirstWitnessAddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (Bn):" label-for="FirstWitnessAddressBn">
                                                                <b-form-textarea id="FirstWitnessAddressBn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" label="Second Witness Info" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <b-form-group label="Witness Name (En):" label-for="SecondWitnessNameEn">
                                                                <b-form-input id="SecondWitnessNameEn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Witness Name (Bn):" label-for="SecondWitnessNameBn">
                                                                <b-form-input id="SecondWitnessNameBn"></b-form-input>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (En):" label-for="SecondWitnessAddressEn">
                                                                <b-form-textarea id="SecondWitnessAddressEn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <b-form-group label="Address (Bn):" label-for="SecondWitnessAddressBn">
                                                                <b-form-textarea id="SecondWitnessAddressBn" placeholder="Enter something..."></b-form-textarea>
                                                            </b-form-group>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                                <b-row>
                                    <b-col sm="12">
                                        <b-form-checkbox id="agree" class="witness-agree-wrapper" size="lg" v-model="status" name="agree" value="accepted" unchecked-value="not_accepted"> I agree
                                        </b-form-checkbox>
                                        <p class="mb-5">To my knowledge of belief, the particulars stated supplied in this application are true and correct. I shall be bound to abide by all laws/orders and instructions issued by the Government of Bangladesh and the Bangladesh Tea Board relating to production and marketing of Tea.</p>
                                    </b-col>
                                </b-row>
                            </div>
                        </tab-content>
                        <template slot="footer" slot-scope="props">
                            <div class="wizard-footer-right">
                                <wizard-button class="btn btn-primary ml-1 mr-1" @click.native="props.prevTab(), step--" v-if="props.activeTabIndex > 0" style="background: #eee"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</wizard-button>
                                <wizard-button
                                    type="submit"
                                    style="background:#214162!important;border-color:#214162!important;"
                                    class="btn btn-info ml-1 mr-1"
                                    title="Create Draft and Save!"
                                    @click.native="props.nextTab(), draft = 1"
                                ><i class="ri-draft-line"></i> {{$t('globalTrans.save_draft')}}
                                </wizard-button>
                                <wizard-button
                                    type="submit"
                                    v-if="!props.isLastStep"
                                    @click.native="props.nextTab(), isNext = true"
                                    class="btn btn-success ml-1 mr-1"
                                    title="Draft and go to next!"
                                    :style="props.fillButtonStyle"
                                ><i class="ri-save-2-line"></i> {{ $t('globalTrans.draft_n_next') }}
                                </wizard-button>
                                <wizard-button
                                    v-else
                                    type="submit"
                                    style="background:#0ab970!important;border-color:#07b16a!important;"
                                    class="btn btn-success ml-1"
                                    title="Submit!"
                                    @click.native="finalSave(), app_status = 2"
                                ><i class="ri-send-plane-fill"></i> {{ $t('globalTrans.finalSave')}}
                                </wizard-button>
                            </div>
                        </template>
                    </form-wizard>
                </b-card-text>
            </b-card>
        </div>
    </div>
</template>
<script>
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
export default {
    components: { FormWizard, TabContent, WizardButton },
    data () {
        return {
            activeIndex: 0,
            selected: [],
            options: [
                { text: 'Something 1', value: 'Something 1' },
                { text: 'Something 2', value: 'Something 2' },
                { text: 'Something 3', value: 'Something 3' },
                { text: 'Something 4', value: 'Something 4' },
                { text: 'Something 5', value: 'Something 5' },
                { text: 'Something 6', value: 'Something 6' }
            ],
            treeType: [
                { text: 'চা সেকশনের ছায়াবৃক্ষ', value: 'চা সেকশনের ছায়াবৃক্ষ' },
                { text: 'প্রাকৃতিক বন', value: 'প্রাকৃতিক বন' },
                { text: 'বাঁশ', value: 'বাঁশ' },
                { text: 'রোপিত গাছ/বানায়নকৃত জঙ্গল', value: 'রোপিত গাছ/বানায়নকৃত জঙ্গল' },
                { text: 'রাবার', value: 'রাবার' },
                { text: 'অন্যান্য', value: 'অন্যান্য' }
            ],
            purposeReason: [
                { text: 'চা আবাদ পরিবর্ধন', value: 'চা আবাদ পরিবর্ধন' },
                { text: 'পুনঃ চা আবাদ', value: 'পুনঃ চা আবাদ' },
                { text: 'অতি বয়স্ক গাছ/বৃক্ষ', value: 'অতি বয়স্ক গাছ/বৃক্ষ' },
                { text: 'আবাদকৃত রাবার', value: 'আবাদকৃত রাবার' },
                { text: 'রুগ্ন বৃক্ষ', value: 'রুগ্ন বৃক্ষ' },
                { text: 'অন্যান্য', value: 'অন্যান্য' }
            ],
            ownerType: [
                { text: 'Owner', value: 'Owner' },
                { text: 'Share holder', value: 'Share holder' },
                { text: 'Directors', value: 'Directors' }
            ],
            ownershipAcquired: [
                { text: 'By purchase', value: 'By purchase' },
                { text: 'By Settlement', value: 'By Settlement' },
                { text: 'By Lease', value: 'By Lease' },
                { text: 'By Purchase & Lease', value: 'By Purchase & Lease' },
                { text: 'By Settlement & Lease', value: 'By Settlement & Lease' }
            ],
            possessesFactory: [
                { text: 'Yes', value: 'Yes' },
                { text: 'No', value: 'No' }
            ]
        }
    }
}
</script>
