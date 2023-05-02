<template>
    <div class="application-itmes">
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.ownership_acquired_type')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Ownership acquired Type" vid="ownership_acquired_type" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors, ariaDescribedby }"
                                                      label-for="ownership_acquired_type">
                                                        <b-form-radio-group
                                                          class="custom-control-inline-wrapper mb-0"
                                                          id="ownership_acquired_type"
                                                          size="lg"
                                                          v-model="formData.ownership_acquired_type"
                                                          :options="ownershipAcquiredTypeList"
                                                          :aria-describedby="ariaDescribedby"
                                                          name="ownership_acquired_type"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        >
                                                        </b-form-radio-group>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Year of Granting Lease" vid="year_of_granting_lease" rules="required" v-slot="{ errors }">
                                                <b-form-group label-for="year_of_granting_lease">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenPanel.year_of_granting_lease') }}<span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                      plain
                                                      id="year_of_granting_lease"
                                                      v-model="formData.year_of_granting_lease"
                                                      :options="yearList"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  >
                                                    <template v-slot:first>
                                                      <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                    </template>
                                                  </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Period of Lease (Years)" vid="period_of_lease" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="period_of_lease">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.period_of_lease') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="period_of_lease"
                                                          v-model="formData.period_of_lease"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.particular_of_land')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Total Grant Area" vid="total_grant_area" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="total_grant_area">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_grant_area') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="total_grant_area"
                                                          v-model="formData.total_grant_area"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Area Under Tea" vid="area_under_tea" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="area_under_tea">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.area_under_tea') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="area_under_tea"
                                                          v-model="formData.area_under_tea"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Total Suitable Land for Tea" vid="total_suitable_land" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="total_suitable_land">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_suitable_land') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="total_suitable_land"
                                                          v-model="formData.total_suitable_land"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Total Unsuitable Land for Tea" vid="total_unsuitable_land" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="total_unsuitable_land">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_unsuitable_land') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="total_unsuitable_land"
                                                          v-model="formData.total_unsuitable_land"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Favour Garden Land (En)" vid="favour_garden_land_en" rules="required" v-slot="{ errors }">
                                <b-form-group label-for="favour_garden_land_en">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.favour_garden_land') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="favour_garden_land_en"
                                      rows="6"
                                      v-model="formData.favour_garden_land_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    >
                                        <template v-slot:first>
                                            <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <ValidationProvider name="Favour Garden Land (Bn)" vid="favour_garden_land_bn" rules="required" v-slot="{ errors }">
                                <b-form-group label-for="favour_garden_land_bn">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.favour_garden_land') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                      id="favour_garden_land_bn"
                                      rows="6"
                                      v-model="formData.favour_garden_land_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :disabled="isRenew"
                                    >
                                        <template v-slot:first>
                                            <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                    </b-form-textarea>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.land_schedule_owner')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mouja (En)" vid="mouja_en" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="mouja_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.mouja') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          id="mouja_en"
                                                          v-model="formData.mouja_en"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mouja (Bn)" vid="mouja_bn" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="mouja_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.mouja') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          id="mouja_bn"
                                                          v-model="formData.mouja_bn"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Khotian No" vid="khotian" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="khotian">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.khotian') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="khotian"
                                                          v-model="formData.khotian_no"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Dag No" vid="dag_no" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="dag_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.dag_no') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          v-model="formData.dag_no"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Garden Sketch Map" vid="garden_sketch_map" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="garden_sketch_map">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.garden_sketch_map') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-file
                                                          id="garden_sketch_map"
                                                          v-model="formData.garden_sketch_map"
                                                          @change="onChange($event, 'garden_sketch_map')"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                                <template class="pb-3" v-if="isFile(formData.garden_sketch_map)">
                                                    <a :href="teaGardenServiceBaseUrl + (isImage(formData.garden_sketch_map) ? 'storage/' : '') +formData.garden_sketch_map" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                                </template>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Land Schedule Copy" vid="land_schedule_copy" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="land_schedule_copy">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.land_schedule_copy') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-file
                                                          id="land_schedule_copy"
                                                          v-model="formData.land_schedule_copy"
                                                          @change="onChange($event, 'land_schedule_copy')"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                                <template class="pb-3" v-if="isFile(formData.land_schedule_copy)">
                                                    <a :href="teaGardenServiceBaseUrl + (isImage(formData.land_schedule_copy) ? 'storage/' : '') +formData.land_schedule_copy" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                                </template>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Khotian Attested Copy" vid="khotian_attested_copy" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="khotian_attested_copy">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.khotian_attested_copy') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-file
                                                          id="khotian_attested_copy"
                                                          v-model="formData.khotian_attested_copy"
                                                          @change="onChange($event, 'khotian_attested_copy')"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                                <template class="pb-3" v-if="isFile(formData.khotian_attested_copy)">
                                                    <a :href="teaGardenServiceBaseUrl + (isImage(formData.khotian_attested_copy) ? 'storage/' : '') +formData.khotian_attested_copy" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                                </template>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Registered Deed Attested Copy" vid="registered_deed_attested_copy" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="registered_deed_attested_copy">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.registered_deed_attested_copy') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-file
                                                          id="registered_deed_attested_copy"
                                                          v-model="formData.registered_deed_attested_copy"
                                                          @change="onChange($event, 'registered_deed_attested_copy')"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                                <template class="pb-3" v-if="isFile(formData.registered_deed_attested_copy)">
                                                    <a :href="teaGardenServiceBaseUrl + (isImage(formData.registered_deed_attested_copy) ? 'storage/' : '') +formData.registered_deed_attested_copy" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                                                </template>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.plantation_product_start_year')" label-size="lg" label-class="font-weight-bold pt-0"
                                        class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Year Plantation" vid="year_plantation" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="year_plantation">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.year_plantation') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                          plain
                                                          id="year_plantation"
                                                          v-model="formData.year_plantation"
                                                          :options="yearList"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-select>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Year Production" vid="year_production" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="year_production">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.year_production') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                          plain
                                                          id="year_production"
                                                          v-model="formData.year_production"
                                                          :options="yearList"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :disabled="isRenew"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-select>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.last_three_year_production')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Average Production (Kg. /Per Hectare)" vid="average_production" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="average_production">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.average_production') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="average_production"
                                                          v-model="formData.average_production"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Average Sale Price (Per Kg.)" vid="average_sale_price" rules="required" v-slot="{ errors }">
                                                    <b-form-group label-for="average_sale_price">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.average_sale_price') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="average_sale_price"
                                                          v-model="formData.average_sale_price"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                            <template v-slot:first>
                                                                <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                                                            </template>
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Appointed Broker Name (En)" vid="appointed_broker_name_en" rules="required" v-slot="{ errors }">
                                <b-form-group label-for="appointed_broker_name_en">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.appointed_broker_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="appointed_broker_name_en"
                                      v-model="formData.appointed_broker_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    </b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Appointed Broker Name (Bn)" vid="appointed_broker_name_bn" rules="required" v-slot="{ errors }">
                                <b-form-group label-for="appointed_broker_name_bn">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.appointed_broker_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="appointed_broker_name_bn"
                                      v-model="formData.appointed_broker_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    </b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.does_garden_possesses_factory')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Garden possesses any factory?" vid="does_garden_possesses_factory" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors, ariaDescribedby }"
                                                      label-for="does_garden_possesses_factory">
                                                        <b-form-radio-group class="custom-control-inline-wrapper mb-0" size="lg" v-model="formData.does_garden_possesses_factory"
                                                                            :options="yesNoList" :aria-describedby="ariaDescribedby" name="radio-options1">
                                                        </b-form-radio-group>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <template v-if="formData.does_garden_possesses_factory === 1">
                                            <b-col sm="4">
                                                <ValidationProvider name="Production Capacity" vid="production_capacity" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="production_capacity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.production_capacity') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="production_capacity"
                                                          v-model="formData.production_capacity"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4">
                                                <ValidationProvider name="Capacity of the Transformer" vid="transformer_capacity" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="transformer_capacity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.transformer_capacity') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="transformer_capacity"
                                                          class="custom-control-inline-wrapper"
                                                          v-model="formData.transformer_capacity"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                        >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4">
                                                <ValidationProvider name="Withering Capacity capacity" vid="withering_capacity" rules="required">
                                                    <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="withering_capacity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.withering_capacity') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number"
                                                          id="withering_capacity"
                                                          v-model="formData.withering_capacity"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            </template>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                    </b-row>
                </b-overlay>
            </b-form>
        </ValidationObserver>
    </div>
</template>

<script>
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { landOwnershipInfoStoreApi, landOwnershipInfoUpdateApi } from '../../api/routes'
    import { helpers } from '@/utils/helper-functions'

    export default {
        props: ['tabFormData', 'status', 'isRenew', 'parentId'],
        data () {
            return {
                valid: null,
                formData: this.tabFormData,
                teaGardenServiceBaseUrl: teaGardenServiceBaseUrl
            }
        },
        created () {
        },
        mounted () {
            this.formData = this.tabFormData
        },
        computed: {
            loading: function () {
                return this.$store.state.commonObj.loading
            },
            currentLocale () {
                return this.$i18n.locale
            },
            ownershipAcquiredTypeList () {
                return [
                    { text: this.currentLocale === 'en' ? 'By purchase' : 'ক্রয় দ্বারা', value: 1, text_en: 'By purchase', text_bn: 'ক্রয় দ্বারা' },
                    { text: this.currentLocale === 'en' ? 'By Settlement' : 'মীমাংসা দ্বারা', value: 2, text_en: 'By Settlement', text_bn: 'মীমাংসা দ্বারা' },
                    { text: this.currentLocale === 'en' ? 'By Lease' : 'ইজারা দ্বারা', value: 3, text_en: 'By Lease', text_bn: 'ইজারা দ্বারা' },
                    { text: this.currentLocale === 'en' ? 'By Purchase & Lease' : 'ক্রয় এবং ইজারা দ্বারা', value: 4, text_en: 'By Purchase & Lease', text_bn: 'ক্রয় এবং ইজারা দ্বারা' },
                    { text: this.currentLocale === 'en' ? 'By Settlement & Lease' : 'মীমাংসা এবং লিজ দ্বারা', value: 5, text_en: 'By Settlement & Lease', text_bn: 'মীমাংসা এবং লিজ দ্বারা' }
                ]
            },
            yesNoList () {
                return [
                    { text: this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ', value: 1, text_en: 'Yes', text_bn: 'হ্যাঁ' },
                    { text: this.currentLocale === 'en' ? 'No' : 'না', value: 2, text_en: 'No', text_bn: 'না' }
                ]
            },
            yearList () {
              return helpers.getYearList()
            }
        },
        watch: {
        },
        methods: {
            async submit () {
                var check = await this.$refs.form.validate()
                if (check) {
                    this.loading = true
                    this.$store.dispatch('mutateCommonProperties', { loading: true })
                    const loadingState = { loading: false, listReload: false }
                    let result
                    const data = Object.assign({}, this.formData, { status: this.status, parent_id: this.parentId })
                    if (this.formData.id) {
                        result = await RestApi.putData(teaGardenServiceBaseUrl, landOwnershipInfoUpdateApi + '/' + this.formData.id, data)
                    } else {
                        result = await RestApi.postData(teaGardenServiceBaseUrl, landOwnershipInfoStoreApi, data)
                    }
                    loadingState.listReload = true
                    this.$store.dispatch('mutateCommonProperties', loadingState)
                    this.loading = false
                    if (result.success) {
                        this.$toast.success({
                            title: 'Success',
                            message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                            color: '#D6E09B'
                        })
                        return result
                    } else {
                        this.$toast.error({
                            title: this.$t('globalTrans.error'),
                            message: this.$t('globalTrans.form_error_msg'),
                            color: '#ee5253'
                        })
                    }
                }
            },
            onChange (event, property) {
                const input = event.target
                if (input.files && input.files[0]) {
                    const reader = new FileReader()
                    reader.onload = (e) => {
                        this.formData[property] = e.target.result
                    }
                    reader.readAsDataURL(input.files[0])
                } else {
                    this.formData[property] = ''
                }
            },
            isImage (path) {
                return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
            },
            isFile (path) {
                return /\.(jpg|jpeg|png|webp|avif|gif|svg|docs|doc|pdf|csv|xsl|xslx|ppt|pptx)$/.test(path)
            }
        }
    }
</script>
