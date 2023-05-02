<template>
  <div class="inner-section">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <card>
            <template v-slot:searchHeaderTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.general_information') }}</h4>
            </template>
            <template v-slot:searchHeaderAction>
              <router-link class="btn-add" to="/bfti-research-and-report-service/research-plan-preparation/prepare-eoi"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
            </template>
            <template v-slot:searchBody>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Title (En)" vid="title" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="title">
                      <template v-slot:label>
                        {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="title"
                        v-model="form.title"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Title (Bn)" vid="title_bn" rules="" v-slot="{ errors }">
                    <b-form-group
                      label-for="title_bn">
                      <template v-slot:label>
                        {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="title_bn"
                        v-model="form.title_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Organization/Ministry/Division (En)" vid="organization_ministry_division" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="organization_ministry_division">
                      <template v-slot:label>
                        {{ $t('research_plan_management.organization_ministry_division') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="organization_ministry_division"
                        v-model="form.organization_ministry_division"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Organization/Ministry/Division (Bn)" vid="organization_ministry_division_bn" v-slot="{ errors }">
                    <b-form-group
                      label-for="organization_ministry_division_bn">
                      <template v-slot:label>
                        {{ $t('research_plan_management.organization_ministry_division') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                        id="organization_ministry_division_bn"
                        v-model="form.organization_ministry_division_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Agency (En)" vid="agency" rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="agency">
                      <template v-slot:label>
                          {{ $t('research_plan_management.agency') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="agency"
                          v-model="form.agency"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Agency (Bn)" vid="agency_bn" v-slot="{ errors }">
                        <b-form-group
                        label-for="agency_bn">
                        <template v-slot:label>
                            {{ $t('research_plan_management.agency') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-input
                            id="agency_bn"
                            v-model="form.agency_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Name of Procuring Entity (En)" vid="name_of_procuring_entity" rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="name_of_procuring_entity">
                      <template v-slot:label>
                          {{ $t('research_plan_management.name_of_procuring_entity') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="name_of_procuring_entity"
                          v-model="form.name_of_procuring_entity"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Name of Procuring Entity (Bn)" vid="name_of_procuring_entity_bn" v-slot="{ errors }">
                        <b-form-group
                        label-for="name_of_procuring_entity_bn">
                        <template v-slot:label>
                            {{ $t('research_plan_management.name_of_procuring_entity') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-input
                            id="name_of_procuring_entity_bn"
                            v-model="form.name_of_procuring_entity_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Division" vid="division_id">
                      <b-form-group
                          label-for="division_id"
                          slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('research_plan_management.procuring_entity')}} {{$t('globalTrans.division')}}
                      </template>
                      <b-form-select
                          plain
                          v-model="form.division_id"
                          :options="divisionList"
                          id="division_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                      >
                          <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="District" vid="district_id">
                      <b-form-group
                          label-for="district_id"
                          slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('research_plan_management.procuring_entity')}}  {{$t('globalTrans.district')}}
                      </template>
                      <b-form-select
                          plain
                          v-model="form.district_id"
                          :options="districtList"
                          id="district_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                      >
                          <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Expression of Interest for (En)" vid="expression_of_interest_for " rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="expression_of_interest_for ">
                      <template v-slot:label>
                          {{ $t('research_plan_management.expression_of_interest_for') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="expression_of_interest_for "
                          v-model="form.expression_of_interest_for"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Expression of Interest for (Bn)" vid="expression_of_interest_for_bn" v-slot="{ errors }">
                        <b-form-group
                        label-for="expression_of_interest_for_bn">
                        <template v-slot:label>
                            {{ $t('research_plan_management.expression_of_interest_for') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-input
                            id="expression_of_interest_for_bn"
                            v-model="form.expression_of_interest_for_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="EOI Reference No" vid="eoi_reference_no " rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="eoi_reference_no ">
                      <template v-slot:label>
                          {{ $t('research_plan_management.eoi_reference_no') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="eoi_reference_no "
                          v-model="form.eoi_reference_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="EOI Date" vid="eio_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="date"
                    >
                      <template v-slot:label>
                        {{ $t('globalTrans.date') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                          id="eio_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          v-model="form.eio_date"
                          :class="errors[0] ? 'is-invalid' : ''"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.key_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Procurement Method (En)" vid="procurement_method " rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="procurement_method ">
                      <template v-slot:label>
                          {{ $t('research_plan_management.procurement_method') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="procurement_method"
                          v-model="form.procurement_method"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Procurement  Method (Bn)" vid="procurement_method_bn"  v-slot="{ errors }">
                      <b-form-group
                      label-for="procurement_method_bn">
                      <template v-slot:label>
                          {{ $t('research_plan_management.procurement_method') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                          id="procurement_method_bn"
                          v-model="form.procurement_method_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.funding_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Budget and Source of Fund (En)" vid="budget_and_source_of_fund " rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="budget_and_source_of_fund ">
                      <template v-slot:label>
                          {{ $t('research_plan_management.budget_and_source_of_fund') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="budget_and_source_of_fund"
                          v-model="form.budget_and_source_of_fund"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Budget and Source of Fund (Bn)" vid="budget_and_source_of_fund_bn" v-slot="{ errors }">
                      <b-form-group
                      label-for="budget_and_source_of_fund_bn">
                      <template v-slot:label>
                          {{ $t('research_plan_management.budget_and_source_of_fund') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                          id="budget_and_source_of_fund_bn"
                          v-model="form.budget_and_source_of_fund_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Development Partners (if Applicable) (En)" vid="development_partners_if_applicable" rules="required" v-slot="{ errors }">
                    <b-form-group
                    label-for="development_partners_if_applicable">
                    <template v-slot:label>
                        {{ $t('research_plan_management.development_partners_if_applicable') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="development_partners_if_applicable"
                        v-model="form.development_partners_if_applicable"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Development Partners (if Applicable) (Bn)" vid="budget_and_source_of_fund_bn" rules="" v-slot="{ errors }">
                      <b-form-group
                      label-for="budget_and_source_of_fund_bn">
                      <template v-slot:label>
                          {{ $t('research_plan_management.development_partners_if_applicable') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                          id="budget_and_source_of_fund_bn"
                          v-model="form.development_partners_if_applicable_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('research_plan_management.particular_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Project/Program Code (En)" vid="program_code" rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="program_code">
                      <template v-slot:label>
                          {{ $t('research_plan_management.program_code') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="program_code"
                          v-model="form.program_code"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Project/Program Name (En)" vid="program_name" rules="required" v-slot="{ errors }">
                        <b-form-group
                        label-for="program_name">
                        <template v-slot:label>
                            {{ $t('research_plan_management.program_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            id="program_name"
                            v-model="form.program_name"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Project/Program Name (Bn)" vid="program_name_bn" rules="" v-slot="{ errors }">
                        <b-form-group
                        label-for="program_name_bn">
                        <template v-slot:label>
                            {{ $t('research_plan_management.program_name') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-input
                            id="program_name_bn"
                            v-model="form.program_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="EOI Closing Date" vid="eoi_closing_date" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="date"
                      >
                        <template v-slot:label>
                          {{ $t('research_plan_management.EOI_closing_date') }}  <span class="text-danger">*</span>
                        </template>
                        <date-picker
                            id="date"
                            class="form-control"
                            v-model="form.eoi_closing_date"
                            :class="errors[0] ? 'is-invalid' : ''"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                          </date-picker>
                          <div class="invalid-feedback d-block">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Eio Closing Time" vid="eoi_closing_time" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="eoi_closing_time"
                    >
                      <template v-slot:label>
                        {{ $t('research_plan_management.EOI_closing_time') }}  <span class="text-danger">*</span>
                      </template>
                        <b-form-input
                        id="eoi_closing_time"
                        type="time"
                        v-model="form.eoi_closing_time"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                      </b-form-input>
                        <div class="invalid-feedback d-block">
                          {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('research_plan_management.procuring_entity_details_official_inviting_eio') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Name (En)" rules="required" :vid="'eoi_details.name'" v-slot="{ errors }">
                      <b-form-group
                      label-for="name">
                      <template v-slot:label>
                          {{ $t('globalTrans.name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="name"
                          v-model="form.eoi_details.name"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Name (Bn)" :vid="'eoi_details.name_bn'"  v-slot="{ errors }">
                      <b-form-group
                      label-for="name_bn">
                      <template v-slot:label>
                          {{ $t('globalTrans.name') }} {{ $t('globalTrans.bn') }}
                      </template>
                      <b-form-input
                          id="name_bn"
                          v-model="form.eoi_details.name_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Designation (En)" :vid="'eoi_details.designation'"  rules="required" v-slot="{ errors }">
                      <b-form-group
                      label-for="designation">
                      <template v-slot:label>
                          {{ $t('globalTrans.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="designation"
                          v-model="form.eoi_details.designation"
                          :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Designation (Bn)" :vid="'eoi_details.designation_bn'"  v-slot="{ errors }">
                        <b-form-group
                        label-for="designation_bn">
                        <template v-slot:label>
                            {{ $t('globalTrans.designation') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-input
                            id="designation_bn"
                            v-model="form.eoi_details.designation_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Address" :vid="'eoi_details.address'" rules="required" v-slot="{ errors }">
                        <b-form-group
                        label-for="address">
                        <template v-slot:label>
                            {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                        </template>
                        <b-form-textarea
                            id="address"
                            v-model="form.eoi_details.address"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                    <ValidationProvider name="Address" :vid="'eoi_details.address_bn'" rules="" v-slot="{ errors }">
                        <b-form-group
                        label-for="address_bn">
                        <template v-slot:label>
                            {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-textarea
                            id="address_bn"
                            v-model="form.eoi_details.address_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col lg="4" md="4" sm="4" xs="4">
                  <ValidationProvider name="Contact No" :vid="'eoi_details.contact_no'" rules="required|min:11|max:11" v-slot="{ errors }">
                    <b-form-group
                      label="Contact No"
                      label-for="contact_no"
                    >
                    <template v-slot:label>
                      {{ $t('globalTrans.contact_no')}} <span class="text-danger">*</span>
                    </template>
                      <b-form-input
                        id="mobile"
                        v-model="form.eoi_details.contact_no"
                        type="tel"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" md="4" sm="4" xs="4">
                  <ValidationProvider name="Email" :vid="'eoi_details.email'" rules="email" v-slot="{ errors }">
                    <b-form-group
                      label="Email"
                      type="email"
                      label-for="email"
                    >
                    <template v-slot:label>
                      {{ $t('globalTrans.email')}} <span class="text-danger">*</span>
                    </template>
                      <b-form-input
                        id="email"
                        v-model="form.eoi_details.email"
                        type="email"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Attachment" vid="attachment" v-slot="{ errors }">
                  <b-form-group
                    label-for="attachment">
                    <template v-slot:label>
                      {{ $t('bfti.attachment') }}
                    </template>
                    <b-form-file
                      id="attachment"
                      v-model="form.attachment"
                      @change="onChange"
                      :state="errors[0] ? false : (valid ? true : null)"
                      placeholder="Choose a file or drop it here..."
                      drop-placeholder="Drop file here..."
                    ></b-form-file>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              <template class="pb-3" v-if="form.eoi_details.attachment">
                <a :href="bftiResReportServiceBaseUrl + form.eoi_details.attachment">{{ $t('bfti.attachment_down')}}</a> <br>
              </template>
              </b-col>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <router-link class="btn-sm btn btn-danger" to="/bfti-research-and-report-service/research-plan-preparation/prepare-eoi">{{ $t('globalTrans.cancel') }}</router-link>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { prepareEioStore, prepareEioUpdate, prepareEioShow } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      form: {
        title: '',
        title_bn: '',
        organization_ministry_division: '',
        organization_ministry_division_bn: '',
        agency_bn: '',
        agency: '',
        division_id: 0,
        district_id: 0,
        attachment: [],
        eoi_details: {
          name: '',
          name_bn: '',
          designation: '',
          address: '',
          address_bn: '',
          contact_no: '',
          email: ''
        }
      },
      districtList: []
    }
  },
  created () {
    if (this.$route.params.id) {
      this.loadData()
    }
  },
  watch: {
    'form.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    }
  },
  computed: {
    saveBtnName: function () {
      return this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save')
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    async loadData () {
      const loadingState = { loading: true, listReload: false }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, prepareEioShow + '/' + this.$route.params.id)
      if (result.success) {
        this.form = result.data
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.$route.params.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${prepareEioUpdate}/${this.$route.params.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, prepareEioStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$router.push('/bfti-research-and-report-service/research-plan-preparation/prepare-eoi')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
