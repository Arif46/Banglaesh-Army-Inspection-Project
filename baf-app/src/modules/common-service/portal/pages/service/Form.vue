<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xl="12" lg="12" sm="12">
          <ValidationProvider name="Service Type" vid="service_type" rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-for="service_type"
                  slot-scope="{ valid, errors }"
                  >
                  <b-form-radio-group
                      v-model="service.service_type_id"
                      :options="serviceTypeList"
                      value-field="value"
                      text-field="text"
                      :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-radio-group>
                  <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
          </ValidationProvider>
        </b-col>
        <!-- for IDSDP -->
      </b-row>
      <b-row v-if="service.service_type_id === 1">
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Component" vid="component_id" rules="required|min_value:1">
            <b-form-group
              label-for="component_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('menu.component')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="service.component_id"
              :options="componentList"
              id="component_id"
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
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
            <b-form-group
              label-for="org_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
            </template>
            <div style="border: 1px solid gray; padding: 4px;border-radius:3px">
                <b-form-checkbox-group v-if="orgList.length"
                  class="text-dark"
                  v-model="service.org_id"
                  :options="orgList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-checkbox-group>
                <p class="m-0 p-0" v-else>--- Please Select Component ---</p>
            </div>
            <div class="invalid-feedback d-block">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
        <!-- for API -->
      <b-row>
        <b-col v-if="service.service_type_id !== 1" xl="6" lg="6" sm="12">
          <ValidationProvider name="Ministry Name" vid="ministry_id" rules="required|min_value:1">
            <b-form-group
              label-for="ministry_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('moc_portal.ministry_name')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="service.ministry_id"
              :options="ministryNameList"
              id="ministry_id"
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
        <b-col v-if="service.service_type_id === 2">
          <div class="row">
            <div class="col-md-8">
              <ValidationProvider name="Api Manager" vid="api_manager" :rules="id ? '' : 'required'">
                <b-form-group
                  label-for="api_manager"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('moc_portal.api_manager')}} <span v-if="!id" class="text-danger">*</span>
                </template>
                <b-form-file id="api_manager"
                plain
                v-on:change="onFileChangeApi"
                v-model="api_manager"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-4">
              <a v-if="service.api_manager_file && id" :href="baseUrl + 'download-attachment?file=' + service.api_manager_file" class="btn btn-sm btn-success"><i class="fa fa-download" aria-hidden="true"></i>{{ $t('moc_portal.download') }}</a>
            </div>
          </div>
        </b-col>
        <b-col v-if="service.service_type_id !== 1" xl="6" lg="6" sm="12">
          <ValidationProvider name="Organization" vid="ex_org_id" rules="required|min_value:1">
            <b-form-group
              label-for="ex_org_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="service.ex_org_id"
              :options="exOrgList"
              id="ex_org_id"
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
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Service Category" vid="service_category" rules="required|min_value:1">
            <b-form-group
              label-for="service_category"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('moc_portal.service_category')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="service.service_category_id"
              :options="portalServiceCategoryList"
              id="service_category"
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
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Customer Type" vid="customer_type_id" rules="required|min:1">
            <b-form-group
                label-for="customer_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('moc_portal.service_customer_type_list') }} <span class="text-danger">*</span>
              </template>
                <b-form-checkbox-group
                  v-model="service.customer_type_id"
                  :options="portalCustomerTypeList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-checkbox-group>
                <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row>
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Service Name (En)" vid="service_name" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="service_name">
              <template v-slot:label>
                {{ $t('moc_portal.service_name_en') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="service_name"
                v-model="service.name"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Service Name (Bn)" vid="service_name_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="service_name_bn">
              <template v-slot:label>
                {{ $t('moc_portal.service_name_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="service_name_bn"
                v-model="service.name_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
        <b-row>
          <b-col xl="12" lg="12" sm="12">
            <ValidationProvider name="Service Description (En)" vid="description" rules="required">
              <b-form-group
                label-for="description"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
              {{$t('moc_portal.description')}} <span class="text-danger">*</span>
              </template>
                <vue-editor
                    id="description"
                    v-model="service.description"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </vue-editor>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xl="12" lg="12" sm="12">
            <ValidationProvider name="Service Description (Bn)" vid="description_bn" rules="required">
              <b-form-group
                label-for="description_bn"
                slot-scope="{ valid, errors }"
                v-bind:star-size="90"
              >
              <template v-slot:label>
              {{$t('moc_portal.description_bn')}} <span class="text-danger">*</span>
              </template>
                <vue-editor
                    id="description_bn"
                    v-model="service.description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </vue-editor>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row>
          <b-col xl="6" lg="6" sm="12">
            <ValidationProvider name="Working Days for Disposal" vid="days_of_disposal" :rules="{required: false, regex: /^\d*\.?\d*$/}">
              <b-form-group
                label-for="days_of_disposal"
                slot-scope="{ valid, errors }"
                v-bind:star-size="90"
              >
              <template v-slot:label>
              {{$t('moc_portal.days_of_disposal')}}
              </template>
                <b-form-input
                  id="namebn"
                  v-model="service.days_of_disposal"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xl="6" lg="6" sm="12">
            <ValidationProvider name="Target Customer" vid="target_customer" rules="numeric">
              <b-form-group
                label-for="target_customer"
                slot-scope="{ valid, errors }"
                v-bind:star-size="90"
              >
              <template v-slot:label>
              {{$t('moc_portal.target_customer')}}
              </template>
                <b-form-input
                  id="namebn"
                  v-model="service.target_customer"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col v-if="service.service_type_id === 3 || service.service_type_id === 1" xl="12" lg="12" sm="12">
            <ValidationProvider name="Service Url" vid="service_url" rules="required">
              <b-form-group
                label-for="service_url"
                slot-scope="{ valid, errors }"
                v-bind:star-size="90"
              >
              <template v-slot:label>
              {{$t('moc_portal.service_url')}} <span class="text-danger">*</span>
              </template>
                <b-form-input
                  id="namebn"
                  v-model="service.service_url"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
      </b-row>
      <!-- Attachment Name -->
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark font-weight-bold">{{$t('moc_portal.service_attachment_list')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row" v-for="(attachemnt, index) in attachment" :key="index">
            <div class="col-md-5">
              <ValidationProvider name="Name (En)" :vid="`name_`+index" rules="">
                <b-form-group
                  :label-for="`name_`+index"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{$t('moc_portal.attachment_name')}}
                </template>
                  <b-form-input
                    :id="`name_`+index"
                    v-model="attachemnt.name"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-5">
              <ValidationProvider name="Name (Bn)" :vid="`name_bn_`+index" rules="">
                <b-form-group
                  :label-for="`name_bn_`+index"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{$t('moc_portal.attachment_name_bn')}}
                </template>
                  <b-form-input
                    :id="`name_bn_`+index"
                    v-model="attachemnt.name_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-2">
              <div class="w-100 h-100 d-grid">
                <b-button v-if="index === 0" type="button" class="m-auto" @click="addAttachment" variant="primary"><i class="ri-add-line p-0 m-0"></i></b-button>
                <b-button v-if="index !== 0" type="button" class="m-auto" @click="removeAttachment(index)" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Fees  -->
      <div class="row">
          <div class="col-md-3">
            <p class="text-dark font-weight-bold">{{$t('moc_portal.service_fees_list')}}</p>
          </div>
          <div class="col-md-9">
            <div class="row" v-for="(fee, index) in fees" :key="index">
              <div class="col-md-5">
                <ValidationProvider name="Fees Name (En)" :vid="`name` + index" rules="">
                  <b-form-group
                    :label-for="`name` + index"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('moc_portal.fees_name')}}
                  </template>
                    <b-form-input
                      :id="`name` + index"
                      v-model="fee.name"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </div>
              <div class="col-md-5">
                <ValidationProvider name="Fees Name (Bn)" :vid="`name_bn` + index" rules="">
                  <b-form-group
                    :label-for="`name_bn` + index"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('moc_portal.fees_name_bn')}}
                  </template>
                    <b-form-input
                      :id="`name_bn` + index"
                      v-model="fee.name_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </div>
              <div class="col-md-5">
                <ValidationProvider name="Amount" :vid="`amount` + index" :rules="{required: false, regex: /^\d*\.?\d*$/}">
                  <b-form-group
                    :label-for="`amount` + index"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('globalTrans.amount')}}
                  </template>
                    <b-form-input
                      :id="`amount` + index"
                      v-model="fee.amount"
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </div>
              <div class="col-md-1">
                <div class="d-grid w-100 h-100">
                  <b-button type="button" v-if="index === 0" @click="addFee" class="m-auto" variant="primary"><i class="ri-add-line p-0 m-0"></i></b-button>
                  <b-button type="button" v-if="index !== 0" @click="removeFee(index)" class="m-auto" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                </div>
              </div>
            </div>
          </div>
      </div>
      <!-- file attachment  -->
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark">{{$t('moc_portal.form_attachment')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row">
            <div class="col-md-5">
              <ValidationProvider name="Form Attachment" vid="form_attachment" >
                <b-form-group
                  label-for="form_attachment"
                  slot-scope="{ valid, errors }"
                >
                <b-form-file id="form_attachment"
                v-on:change="onFileChangeAtt"
                v-model="form_attachment"
                plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-5">
              <a v-if="service.form_attachment_file && id" :href="baseUrl + 'download-attachment?file=' + service.form_attachment_file" class="btn btn-sm btn-success"><i class="fa fa-download" aria-hidden="true"></i>{{ $t('moc_portal.download') }}</a>
            </div>
          </div>
        </div>
      </div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark">{{$t('moc_portal.service_process')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row">
            <div class="col-md-5">
              <ValidationProvider name="Service Process" vid="process" >
                <b-form-group
                  label-for="process"
                  slot-scope="{ valid, errors }"
                >
                <b-form-file id="process"
                accept="image/*"
                v-on:change="onFileChangePro"
                v-model="process"
                plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-5">
              <img v-if="service.process_file && id" width="100%" height="80px" :src="baseUrl + 'download-attachment?file=storage/' + service.process_file"/>
            </div>
            <!-- <div class="col-md-5">
              <a v-if="service.process_file && id" :href="baseUrl + 'download-attachment?file=' + service.process_file" class="btn btn-sm btn-success"><i class="fa fa-download" aria-hidden="true"></i>{{ $t('moc_portal.download') }}</a>
            </div> -->
          </div>
        </div>
      </div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark">{{$t('moc_portal.service_image')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row">
            <b-col lg="5" md="5" sm="12">
                <ValidationProvider name="Service Image" vid="service_image" rules="">
                  <b-form-group
                    slot-scope="{ valid, errors }"
                  >
                    <b-form-file
                      id="service_image"
                      v-model="service_image"
                      v-on:change="handlePhoto"
                      accept="image/*"
                      plain
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
            </b-col>
            <div class="col-md-5">
              <img v-if="service.image_file && id" width="100%" height="80px" :src="baseUrl + 'download-attachment?file=storage/' + service.image_file"/>
            </div>
          </div>
        </div>
      </div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark">{{$t('moc_portal.service_operating_procedure')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row">
            <div class="col-md-5">
              <ValidationProvider name="Service Standard Operating Procedure" vid="operating_procedure" >
                <b-form-group
                  label-for="operating_procedure"
                  slot-scope="{ valid, errors }"
                >
                <b-form-file id="operating_procedure"
                v-on:change="onFileChangeOperat"
                v-model="operating_procedure"
                plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-5">
              <a v-if="service.operating_procedure_file && id" :href="baseUrl + 'download-attachment?file=' + service.operating_procedure_file" class="btn btn-sm btn-success"><i class="fa fa-download" aria-hidden="true"></i>{{ $t('moc_portal.download') }}</a>
            </div>
          </div>
        </div>
      </div>
      <div class="row mt-3">
        <div class="col-md-3">
          <p class="text-dark">{{$t('moc_portal.policy_attachment')}}</p>
        </div>
        <div class="col-md-9">
          <div class="row">
            <div class="col-md-5">
              <ValidationProvider name="Form Attachment" vid="policy_attachment" >
                <b-form-group
                  label-for="policy_attachment"
                  slot-scope="{ valid, errors }"
                >
                <b-form-file id="policy_attachment"
                v-on:change="onFileChangePolicy"
                v-model="policy_attachment"
                plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </div>
            <div class="col-md-5">
              <a v-if="service.policy_attachment_file && id" :href="baseUrl + 'download-attachment?file=' + service.policy_attachment_file" class="btn btn-sm btn-success"><i class="fa fa-download" aria-hidden="true"></i>{{ $t('moc_portal.download') }}</a>
            </div>
          </div>
        </div>
      </div>
      <!-- end file attachment -->
      <!-- Permissions -->
      <div class="row">
        <b-col class="col-md-12 my-3">
          <h5>
            {{ $t('moc_portal.permissions') }}: <hr class="p-0 m-0">
          </h5>
        </b-col>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_apply_btn"
            >
            <template v-slot:label>
            {{$t('moc_portal.apply_button')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_apply_btn"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_attachment_form"
            >
            <template v-slot:label>
            {{$t('moc_portal.form_attachment')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_attachment_form"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_service_applied"
            >
            <template v-slot:label>
            {{$t('moc_portal.service_applied')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_service_applied"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_service_time"
            >
            <template v-slot:label>
            {{$t('moc_portal.service_time')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_service_time"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_target_customer"
            >
            <template v-slot:label>
            {{$t('moc_portal.target_customer')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_target_customer"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_fees"
            >
            <template v-slot:label>
            {{$t('moc_portal.service_fees_list')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_fees"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_service_process"
            >
            <template v-slot:label>
            {{$t('moc_portal.service_process')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_service_process"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_rating"
            >
            <template v-slot:label>
            {{$t('moc_portal.rating')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_rating"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
        <div class="col-md-6">
          <b-form-group
              class="row mb-2"
              label-cols-sm="6"
              label-for="pr_policy"
            >
            <template v-slot:label>
            {{$t('moc_portal.policy_attachment')}}
            </template>
              <b-form-radio-group
                v-model="service.permission.pr_policy"
                :options="getAnswerList"
              ></b-form-radio-group>
          </b-form-group>
        </div>
      </div>
      <b-row class="text-right">
        <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { serviceStoreApi, serviceUpdateApi } from '../../api/routes'
import { VueEditor } from 'vue2-editor'

export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      baseUrl: commonServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      answerList: [{ text_en: 'Yes', text_bn: 'হ্যাঁ', value: 1 }, { text_en: 'No', text_bn: 'না', value: 0 }],
      service: {
        service_type_id: 1,
        component_id: 0,
        org_id: [],
        service_category_id: 0,
        customer_type_id: [],
        name: '',
        name_bn: '',
        description: '',
        description_bn: '',
        days_of_disposal: '',
        target_customer: '',
        process: '',
        image: null,
        form_attachment: '',
        policy_attachment: '',
        operating_procedure: '',
        permission: {
          pr_apply_btn: 0,
          pr_attachment_form: 0,
          pr_service_applied: 0,
          pr_service_time: 0,
          pr_target_customer: 0,
          pr_fees: 0,
          pr_service_process: 0,
          pr_rating: 0,
          pr_policy: 0
        },
        ministry_id: 0,
        ex_org_id: 0,
        api_manager: '',
        service_url: ''
      },
      attachment: [
          {
            name: '',
            name_bn: ''
          }
      ],
      fees: [
        {
          name: '',
          name_bn: ''
        }
      ],
      api_manager: [],
      service_image: [],
      operating_procedure: [],
      process: [],
      form_attachment: [],
      policy_attachment: [],
      orgList: [],
      exOrgList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getServiceData()
      this.service = tmp
      this.service.process_file = tmp.process
      this.service.image_file = tmp.image
      this.service.form_attachment_file = tmp.form_attachment
      this.service.policy_attachment_file = tmp.policy_attachment
      this.service.operating_procedure_file = tmp.operating_procedure
      this.service.api_manager_file = tmp.api_manager
      this.service.process = null
      this.service.image = null
      this.service.form_attachment = null
      this.service.policy_attachment = null
      this.service.operating_procedure = null
      this.service.api_manager = null

      if (tmp.attachment.length > 0) {
        this.attachment = tmp.attachment
      }
      if (tmp.fees.length > 0) {
        this.fees = tmp.fees
      }
      const customerType = tmp.customers.map(item => {
        return item.id
      })
      this.service.customer_type_id = customerType
      if (this.service.service_type_id === 1) {
        const orgList = tmp.org_list.map(item => {
          return item.id
        })
        this.service.org_id = orgList
      }
    }
  },
  computed: {
    getAnswerList () {
      return this.answerList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.filter(item => item.status === 1)
    },
    ministryNameList () {
      return this.$store.state.CommonService.commonObj.ministryNameList.filter(el => el.status === 1)
    },
    portalServiceCategoryList () {
      return this.$store.state.CommonService.commonObj.portalServiceCategoryList.filter(item => item.status === 1)
    },
    portalCustomerTypeList () {
      return this.$store.state.CommonService.commonObj.portalCustomerTypeList.filter(el => el.status === 1)
    },
    serviceTypeList () {
      return this.$store.state.CommonService.commonObj.portalServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'service.service_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
          this.service.ex_org_id = 0
          this.service.service_url = ''
          this.service.component_id = 0
          this.service.ministry_id = 0
          this.service.api_manager = ''
        }
      }
    },
    'service.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.org_id = []
        }
        this.orgList = this.getOrgList(newVal)
      }
    },
    'service.ministry_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (!this.id) {
          this.service.ex_org_id = 0
        }
        this.exOrgList = this.getExOrgList(newVal)
      }
    }
  },
  methods: {
    addAttachment () {
      const tmpAtt = {
        name: '',
        name_bn: ''
      }
      this.attachment.push(tmpAtt)
    },
    removeAttachment (index) {
      this.attachment.splice(index, 1)
    },
    addFee () {
      const tmpFee = {
        name: '',
        name_bn: '',
        amount: ''
      }
      this.fees.push(tmpFee)
    },
    removeFee (index) {
      this.fees.splice(index, 1)
    },
    getExOrgList (Id) {
      return this.$store.state.CommonService.commonObj.exOrgList.filter(item => item.ministry_id === parseInt(Id) && item.status === 1)
    },
    getOrgList (compId) {
      const orgComponentList = this.$store.state.CommonService.commonObj.orgComponentList.filter(comp => comp.component_id === compId)
      return orgComponentList.map(item => {
        if (typeof item !== 'undefined') {
          const org = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === item.org_id)
          return (this.$i18n.locale === 'bn') ? Object.assign({}, org, { text: org.abbreviation_bn }) : Object.assign({}, org, { text: org.abbreviation })
        }
      })
    },
    onFileChangeApi (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.api_manager = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.api_manager = ''
      }
    },
    onFileChangeOperat (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.operating_procedure = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.operating_procedure = ''
      }
    },
    onFileChangePro (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.process = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.process = ''
      }
    },
    onFileChangePolicy (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.policy_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.policy_attachment = ''
      }
    },
    onFileChangeAtt (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.form_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.form_attachment = ''
      }
    },
    handlePhoto (e) {
      const input = e.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.service.image = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.service.image = null
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.service.attachment = this.attachment
      this.service.fees = this.fees
      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${serviceUpdateApi}/${this.id}`, this.service)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, serviceStoreApi, this.service)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('mutateCommonProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getServiceData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
