<template>
  <card>
    <template v-slot:searchHeaderTitle>
      <h4 class="card-title">{{ $t('teaGardenBtriService.service_test') }}</h4>
    </template>
    <template v-slot:searchBody>
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <b-row>
            <!-- service -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="year">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.service_name') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        @change="changeSampleDetails"
                        :disabled="$route.params.id > 0 ? true : false"
                        plain
                        v-model="application.service_id"
                        :options="serviceList"
                        id="service_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- valley -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Valley Name" vid="valley_id" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="valley_name">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.valley_name') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        @change="valleyChange"
                        :disabled="isGardenAdmin"
                        plain
                        v-model="application.valley_id"
                        :options="valleyList"
                        id="valley_name"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- garden -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="garden_id">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.garden_name') }} <span class="text-danger">*</span>
                  </template>
                  <v-select
                    id="garden_id"
                    :disabled="isGardenAdmin"
                    plain
                    v-model="application.garden_id"
                    :options="getGardenList"
                    :reduce="op => op.value"
                    label="text"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select')"
                    >
                    </v-select>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- test type -->
            <!-- only for soil warim insect test  -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="application.service_id === 7">
              <ValidationProvider name="Test Category" vid="test_category" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="year">
                  <template v-slot:label>
                    {{ $t('teaGardenBtriService.test_category') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        :disabled="isGardenAdmin === false ? false : true"
                        plain
                        v-model="application.test_category"
                        :options="soilTestType"
                        id="test_category"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- test type -->
            <!-- only for tea sample test test  -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="application.service_id === 16">
              <ValidationProvider name="Test Type" vid="tea_sample_test_type_id" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="year">
                  <template v-slot:label>
                    {{ $t('teaGardenBtriService.tea_sample_test_type') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        plain
                        v-model="application.tea_sample_test_type_id"
                        :options="teaSampleTestTypeList"
                        id="tea_sample_test_type_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- common service add more  -->
            <!-- for 2 services  -->
            <template v-if="application.service_id !== 0 && (application.service_id === 5 || application.service_id === 7)">
            <b-col sm="12">
                <div class="group-form-card">
                    <b-card>
                        <b-form-group label-cols-lg="12" :label="$t('teaGardenBtriService.sample_information')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                          <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                        <b-row>
                                          <!-- section  -->
                                            <b-col sm="4">
                                              <ValidationProvider name="Section No" vid="section_id">
                                                <b-form-group
                                                  label-for="year">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenConfig.section') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                        plain
                                                        v-model="addMoreApplicationDetails.section_id"
                                                        :options="gardenSectionDetail"
                                                        id="section_id_add_more"
                                                        >
                                                        <template v-slot:first>
                                                            <b-form-select-option :value="'null'">{{$t('globalTrans.select')}}</b-form-select-option>
                                                        </template>
                                                    </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <!-- row 1 -->
                                            <b-row>
                                            <!-- sample  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample" vid="sample">
                                                    <b-form-group label-for="sample">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          disabled
                                                          v-model="addMoreApplicationDetails.sections_info[0].sample"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- sample no  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample No" vid="sample_no">
                                                    <b-form-group label-for="sample_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample_no') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          disabled
                                                          type="number" min="1"
                                                          v-model="addMoreApplicationDetails.sections_info[0].sample_no"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- depth  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Depth/Height" vid="depth">
                                                    <b-form-group label-for="depth">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.depth') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="addMoreApplicationDetails.sections_info[0].depth"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- packets  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Packets" vid="packets">
                                                    <b-form-group label-for="packets">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.packets') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number" min="1" v-model="addMoreApplicationDetails.sections_info[0].packets"
                                                         >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            </b-row>
                                            <!-- row 2 -->
                                            <b-row>
                                            <!-- sample  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample" vid="sample">
                                                    <b-form-group label-for="sample">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          disabled
                                                          v-model="addMoreApplicationDetails.sections_info[1].sample"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- sample no  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample No" vid="sample_no">
                                                    <b-form-group label-for="sample_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample_no') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number" min="1"
                                                          disabled
                                                          v-model="addMoreApplicationDetails.sections_info[1].sample_no"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- depth  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Depth/Height" vid="depth">
                                                    <b-form-group label-for="depth">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.depth') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="addMoreApplicationDetails.sections_info[1].depth"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- packets  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Packets" vid="packets">
                                                    <b-form-group label-for="packets">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.packets') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number" min="1" v-model="addMoreApplicationDetails.sections_info[1].packets"
                                                         >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            </b-row>
                                            <!-- row 3 -->
                                            <b-row>
                                            <!-- sample  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample" vid="sample">
                                                    <b-form-group label-for="sample">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          disabled
                                                          v-model="addMoreApplicationDetails.sections_info[2].sample"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- sample no  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Sample No" vid="sample_no">
                                                    <b-form-group label-for="sample_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample_no') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number" min="1"
                                                          disabled
                                                          v-model="addMoreApplicationDetails.sections_info[2].sample_no"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- depth  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Depth/Height" vid="depth">
                                                    <b-form-group label-for="depth">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.depth') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          v-model="addMoreApplicationDetails.sections_info[2].depth"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- packets  -->
                                            <b-col sm="3">
                                                <ValidationProvider name="Packets" vid="packets">
                                                    <b-form-group label-for="packets">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.packets') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number" min="1" v-model="addMoreApplicationDetails.sections_info[2].packets"
                                                         >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            </b-row>
                                            <b-col sm="12" class="text-right">
                                                <b-button @click="addMoreItemSectionDetails" class="add-more-btn" size="sm"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_more_machineries') }}</b-button>
                                            </b-col>
                                        </b-row>
                                </b-card>
                            </div>
                           </b-col>
                           <b-col sm="12">
                                    <table class="table table-sm table-bordered section-tree-view-table">
                                        <thead>
                                            <tr>
                                                <th>{{ $t('globalTrans.sl_no') }}</th>
                                                <th>{{ $t('teaGardenConfig.section') }}</th>
                                                <th>{{ $t('teaGardenBtriService.sample') }}</th>
                                                <th>{{ $t('teaGardenBtriService.sample_no') }}</th>
                                                <th>{{ $t('teaGardenBtriService.depth') }}</th>
                                                <th>{{ $t('teaGardenBtriService.packets') }}</th>
                                                <th>{{ $t('globalTrans.action') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <slot v-for="(item, index) in application.details">
                                              <tr  v-for="(section, sectionIndex) in item.sections_info" :key="index+'-'+sectionIndex">
                                                <td row class="text-center" rowspan="3" v-if="sectionIndex === 0"> {{ $n(index + 1) }}</td>
                                                <td class="text-center" rowspan="3" v-if="sectionIndex === 0"><span v-if="item.section_id">{{ getSectionName(item.section_id) }}</span></td>
                                                <td class="text-center">{{ section.sample }}</td>
                                                <td>
                                                    <ValidationProvider name="Sample No" :vid="'sample_no' + '_' + index + 'section' + sectionIndex" :rules="{ required: true,min_value: 1}">
                                                        <b-form-group
                                                        class="mb-0"
                                                        slot-scope="{ valid, errors }">
                                                        <b-form-input
                                                            :id="`sample_no-${index}`"
                                                            class="text-right"
                                                            type="number"
                                                            min="1"
                                                            v-model="section.sample_no"
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="error invalid-feedback" role="alert">
                                                            {{ errors[0] }}
                                                        </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </td>
                                                <td>
                                                    <ValidationProvider name="Depth" :vid="'depth' + '_' + index + 'section' + sectionIndex" :rules="{ required: true}">
                                                        <b-form-group
                                                        class="mb-0"
                                                        slot-scope="{ valid, errors }">
                                                        <b-form-input
                                                            :id="`depth-${index}`"
                                                            class="text-right"
                                                            min="1"
                                                            v-model="section.depth"
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="error invalid-feedback" role="alert">
                                                            {{ errors[0] }}
                                                        </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </td>
                                                <td>
                                                    <ValidationProvider name="Packets" :vid="'packets' + '_' + index + 'section' + sectionIndex" :rules="{ required: true, min_value: 1 }">
                                                        <b-form-group
                                                        class="mb-0"
                                                        slot-scope="{ valid, errors }">
                                                        <b-form-input
                                                            :id="`packets-${index}`"
                                                            class="text-right"
                                                            type="number"
                                                            min="1"
                                                            v-model="section.packets"
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="error invalid-feedback" role="alert">
                                                            {{ errors[0] }}
                                                        </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </td>
                                                <td rowspan="3" v-if="sectionIndex === 0" class="text-center">
                                                    <a @click="addMoreDetailsItemRemove(index)" href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                </td>
                                              </tr>
                                            </slot>
                                            <tr>
                                                <td colspan="5" class="text-right"><b>{{ $t('teaGardenBtriService.totalPackets') }}</b></td>
                                                <td colspan="2" class="text-center"><b>{{ totalPackets }}</b></td>
                                            </tr>
                                        </tbody>
                                        <tfoot v-if="Object.keys(application.details).length === 0">
                                            <tr>
                                                <td colspan="7" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                                              </tr>
                                        </tfoot>
                                    </table>
                            </b-col>
                        </b-form-group>
                    </b-card>
                </div>
            </b-col>
            </template>
            <!-- for 10 services -->
            <template v-if="application.service_id !== 0 && application.service_id !== 5 && application.service_id !== 7 && application.service_id >= 5 && application.service_id <= 16">
            <b-col sm="12">
                <div class="group-form-card">
                    <b-card>
                        <b-form-group label-cols-lg="12" :label="$t('teaGardenBtriService.sample_information')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                          <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                        <b-row>
                                            <b-col sm="4" v-if="application.service_id === 9">
                                              <ValidationProvider name="Organic Fertilizer Type" vid="fertilizer_type">
                                                <b-form-group
                                                  label-for="fertilizer_type">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenBtriService.fertilizer_type') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                        plain
                                                        v-model="addMoreApplicationDetails.fertilizer_type"
                                                        :options="organicFertilizerTypes"
                                                        id="fertilizer_type"
                                                        >
                                                        <template v-slot:first>
                                                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                                        </template>
                                                    </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4" v-if="application.service_id === 8">
                                              <ValidationProvider name="Fertilizer Name" vid="fertilizer_id">
                                                <b-form-group
                                                  label-for="fertilizer_id">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenBtriService.fertilizer_name') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                        plain
                                                        v-model="addMoreApplicationDetails.fertilizer_id"
                                                        :options="fertilizerList"
                                                        id="fertilizer_id"
                                                        >
                                                        <template v-slot:first>
                                                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                                        </template>
                                                    </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4" v-if="application.service_id === 6">
                                              <ValidationProvider name="Section No" vid="section_id">
                                                <b-form-group
                                                  label-for="year">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenConfig.section') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                        plain
                                                        v-model="addMoreApplicationDetails.section_id"
                                                        :options="gardenSectionDetail"
                                                        id="section_id_add"
                                                        >
                                                        <template v-slot:first>
                                                            <b-form-select-option :value="'null'">{{$t('globalTrans.select')}}</b-form-select-option>
                                                        </template>
                                                    </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4" v-if="application.service_id === 15 || application.service_id === 16">
                                              <ValidationProvider name="Made Tea Grade Name" vid="made_tea_grade_id">
                                                <b-form-group
                                                  label-for="year">
                                                  <template v-slot:label>
                                                    {{ $t('teaGardenConfig.made_tea_grade') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-select
                                                        plain
                                                        v-model="addMoreApplicationDetails.made_tea_grade_id"
                                                        :options="madeTeaGradeList"
                                                        id="made_tea_grade_id"
                                                        >
                                                        <template v-slot:first>
                                                            <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                                        </template>
                                                    </b-form-select>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4">
                                                <ValidationProvider name="Sample No" vid="sample_no">
                                                    <b-form-group label-for="sample_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.sample_no') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                          type="number" min="1"
                                                          v-model="addMoreApplicationDetails.sample_no"
                                                          >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="4">
                                                <ValidationProvider name="Packets" vid="packets">
                                                    <b-form-group label-for="packets">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenBtriService.packets') }}<span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number"
                                                         min="1" v-model="addMoreApplicationDetails.packets"
                                                         >
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                          {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="12" class="text-right">
                                                <b-button @click="addMoreItemDetails" class="add-more-btn" size="sm"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_more_machineries') }}</b-button>
                                            </b-col>
                                        </b-row>
                                </b-card>
                            </div>
                           </b-col>
                           <b-col sm="12">
                                    <table class="table table-sm table-bordered section-tree-view-table">
                                        <thead>
                                            <tr>
                                                <th>{{ $t('globalTrans.sl_no') }}</th>
                                                <th v-if="application.service_id === 9">{{ $t('teaGardenBtriService.fertilizer_type') }}</th>
                                                <th v-if="application.service_id === 8">{{ $t('teaGardenConfig.fertilizer_name') }}</th>
                                                <th v-if="application.service_id === 6">{{ $t('teaGardenConfig.section') }}</th>
                                                <th v-if="application.service_id === 15 || application.service_id === 16">{{ $t('teaGardenConfig.made_tea_grade') }}</th>
                                                <th>{{ $t('teaGardenBtriService.sample_no') }}</th>
                                                <th>{{ $t('teaGardenBtriService.packets') }}</th>
                                                <th>{{ $t('globalTrans.action') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <slot v-for="(item, index) in application.details">
                                              <tr :key="index">
                                                <td class="text-center"> {{ $n(index + 1) }}</td>
                                                <td v-if="application.service_id === 9"><span v-if="item.fertilizer_type">{{ getFertilizerTypeName(item.fertilizer_type) }}</span></td>
                                                <td v-if="application.service_id === 8"><span v-if="item.fertilizer_id">{{ getFertilizerName(item.fertilizer_id) }}</span></td>
                                                <td v-if="application.service_id === 6"><span v-if="item.section_id">{{ getSectionName(item.section_id) }}</span></td>
                                                <td v-if="application.service_id === 15 || application.service_id === 16"><span v-if="item.made_tea_grade_id">{{ getMadeTeaGradeName(item.made_tea_grade_id) }}</span></td>
                                                <td>
                                                    <ValidationProvider name="Sample No" :vid="'sample_no' + '_' + index" :rules="{ required: true,min_value: 1}">
                                                        <b-form-group
                                                        class="mb-0"
                                                        slot-scope="{ valid, errors }">
                                                        <b-form-input
                                                            :id="`sample_no-${index}`"
                                                            class="text-right"
                                                            type="number"
                                                            min="1"
                                                            v-model="item.sample_no"
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="error invalid-feedback" role="alert">
                                                            {{ errors[0] }}
                                                        </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </td>
                                                <td>
                                                    <ValidationProvider name="Packets" :vid="'packets' + '_' + index" :rules="{ required: true, min_value: 1 }">
                                                        <b-form-group
                                                        class="mb-0"
                                                        slot-scope="{ valid, errors }">
                                                        <b-form-input
                                                            :id="`packets-${index}`"
                                                            class="text-right"
                                                            type="number"
                                                            min="1"
                                                            v-model="item.packets"
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                        ></b-form-input>
                                                        <div class="error invalid-feedback" role="alert">
                                                            {{ errors[0] }}
                                                        </div>
                                                        </b-form-group>
                                                    </ValidationProvider>
                                                </td>
                                                <td class="text-center">
                                                    <a @click="addMoreDetailsItemRemove(index)" href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                </td>
                                              </tr>
                                            </slot>
                                            <tr>
                                                <td v-if="application.service_id === 6 || application.service_id === 8 || application.service_id === 9 || application.service_id === 15 || application.service_id === 16" colspan="3" class="text-right"><b>{{ $t('teaGardenBtriService.totalPackets') }}</b></td>
                                                <td v-else colspan="2" class="text-right"><b>{{ $t('teaGardenBtriService.totalPackets') }}</b></td>
                                                <td colspan="2" class="text-center"><b>{{ totalPackets }}</b></td>
                                            </tr>
                                        </tbody>
                                        <tfoot v-if="Object.keys(application.details).length === 0">
                                            <tr>
                                                <td colspan="5" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                                              </tr>
                                        </tfoot>
                                    </table>
                            </b-col>
                        </b-form-group>
                    </b-card>
                </div>
            </b-col>
            </template>
            <!-- Purpose en -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Purpose (En)" vid="purpose_en">
                <b-form-group
                  label-for="purpose_en">
                  <template v-slot:label>
                    {{ $t('teaGardenBtriService.purpose') }} {{ $t('globalTrans.en') }}
                  </template>
                  <b-form-textarea
                    id="purpose_en"
                    v-model="application.purpose_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- purpose bn  -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Purpose (Bn)" vid="purpose_bn">
                <b-form-group
                  label-for="purpose_bn">
                  <template v-slot:label>
                    {{ $t('teaGardenBtriService.purpose') }} {{ $t('globalTrans.bn') }}
                  </template>
                  <b-form-textarea
                    id="purpose_bn"
                    v-model="application.purpose_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row v-if="application.return_remarks">
            <b-col>
              <div>
                <b-alert show dismissible variant="danger">
                  <strong>{{ $t('teaGardenBtriService.return_remarks_note') }}</strong>: {{ application.return_remarks }}
                </b-alert>
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col class="text-right">
              <!-- for payment  -->
              <wizard-button v-if="isPayment"
                  type="submit"
                  class="btn btn-success ml-1 mr-1"
                  title="Submit & Paymnet"
              ><i class="ri-save-2-line"></i> {{$t('teaGardenBtriService.submit_n_payment')}}
              </wizard-button>
              <!-- for normal submit without payment  -->
              <wizard-button v-else
                  type="submit"
                  class="btn btn-success ml-1 mr-1"
                  title="Submit"
              ><i class="ri-save-2-line"></i> {{$t('globalTrans.submit')}}
              </wizard-button>
              <!-- cancel button  -->
              <wizard-button
                    type="button"
                    class="btn btn-danger ml-1 mr-1"
                    title="Cancel"
                >
                    <router-link :to="{ name: 'tea_garden_service.btri.test_services' }" class="text-white"><i class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}</router-link>
                </wizard-button>
            </b-col>
          </b-row>
        </b-form>
    </b-overlay>
    </ValidationObserver>
    </template>
  </card>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { applicationStore, applicationUpdate, applicationDetails } from '../../api/routes'
import teaGardenService from '@/mixins/tea-garden-service'
import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
export default {
  mixins: [teaGardenService],
  name: 'Form',
  props: ['item'],
    components: {
        ValidationProvider,
        ValidationObserver,
        WizardButton
    },
  data () {
    return {
      valid: null,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      application: {
        service_id: 0,
        valley_id: 0,
        garden_id: '',
        test_category: 1,
        tea_sample_test_type_id: 1,
        details: [],
        total_packets: 0,
        total_samples: 0
      },
      getGardenList: [],
      addMoreApplicationDetails: {
        ser_app_id: 0,
        sample_no: null,
        packets: 1,
        fertilizer_type: 0,
        fertilizer_id: 0,
        made_tea_grade_id: 0,
        section_id: null,
        sections_info: [
            { ser_app_details_id: 0, sample: 'A', sample_no: '1001', depth: '0-23', packets: '1' },
            { ser_app_details_id: 0, sample: 'B', sample_no: '1002', depth: '23-46', packets: '1' },
            { ser_app_details_id: 0, sample: 'C', sample_no: '1003', depth: '46-92', packets: '1' }
          ]
      },
      isGardenAdmin: false,
      loading: false,
      isPayment: true
    }
  },
  created () {
    this.getGardenListValleyWise()
    if (this.$route.params.id) {
      this.loading = true
      const tmp = this.getData(this.$route.params.id)
      this.application = tmp
    }
    if (this.isGardenAdminCheckGardenId()) {
      this.application.garden_id = this.isGardenAdminCheckGardenId()
      this.isGardenAdmin = true
    }
  },
  computed: {
    currentLocale () {
        return this.$i18n.locale
    },
    serviceList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => JSON.parse(item.service_type).includes(2))
    },
    gardenSectionDetail: function () {
        return this.$store.state.TeaGardenService.commonObj.masterSectionList.filter(item => (item.garden_id === this.application.garden_id))
    },
    valleyList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterValleyList
    },
    madeTeaGradeList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterMadeTeaGradeList
    },
    fertilizerList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterFertilizerList.filter(item => (item.status === 1))
    },
    teaSampleTestTypeList: function () {
      return this.$store.state.TeaGardenService.commonObj.teaSmapleTestType
    },
    organicFertilizerTypes: function () {
      return this.$store.state.TeaGardenService.commonObj.organicFertilizerTypes
    },
    soilTestType: function () {
      return this.$store.state.TeaGardenService.commonObj.soilTestType
    },
    totalPackets () {
      var total = 0
      if (this.application.service_id !== 0) {
        if (this.application.service_id === 5 || this.application.service_id === 7) {
        this.application.details.forEach(section => {
          section.sections_info.forEach(item => {
              total += Number(item.packets)
          })
      })
      } else {
        this.application.details.forEach(section => {
          total += Number(section.packets)
        })
      }
      }
      return total
    },
    totalSamples () {
      var total = 0
      if (this.application.service_id !== 0) {
        if (this.application.service_id === 5 || this.application.service_id === 7) {
        this.application.details.forEach(section => {
          section.sections_info.forEach(item => {
              total += 1
          })
      })
      } else {
        this.application.details.forEach(section => {
          total += 1
        })
      }
      }
      return total
    }
  },
  methods: {
    async getData (id) {
        let result = null
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${applicationDetails}/${id}`)
        this.application = result.data
        this.loading = false
    },
    async saveUpdate () {
      // checking details data can't empty
      if (Object.keys(this.application.details).length === 0) {
          this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('teaGardenBtriService.add_sample'),
          color: '#ee5253'
      })
        return false
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      this.loading = true
       const loadingState = { loading: false, listReload: false }
       this.application.total_packets = this.totalPackets
       this.application.total_samples = this.totalSamples
       this.application.isPayment = this.isPayment
      if (this.$route.params.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${applicationUpdate}/${this.application.id}`, this.application)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, applicationStore, this.application)
      }
      loadingState.listReload = true
      this.loading = false
      if (result.exist) {
        this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: this.$t('teaGardenConfig.existErrorMsg'),
            color: '#ee5253'
        })
        return false
      }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        if (result.isPayment) {
          this.$router.push({ name: 'tea_garden_service.btri.payment', params: { id: result.data.id } })
        } else {
          this.$router.push({ name: 'tea_garden_service.btri.test_services' })
        }
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getGardenInfo (id) {
      const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
      if (gardenInfo) {
        this.application.valley_id = gardenInfo.valley_id
      }
    },
    valleyChange (e) {
      this.application.garden_id = ''
      this.getGardenListValleyWise(e)
    },
    getSectionName (id) {
        const sectionName = this.gardenSectionDetail.find(item => item.value === id)
        if (sectionName && this.$i18n.locale === 'bn') {
            return sectionName.text_bn
        } else if (sectionName && this.$i18n.locale === 'en') {
            return sectionName.text_en
        }
    },
    addMoreDetailsItemRemove (index) {
        this.application.details.splice(index, 1)
    },
    addMoreItemDetails () {
        if (this.addMoreApplicationDetails.sample_no === null || this.addMoreApplicationDetails.packets === null || (this.application.service_id === 9 && this.addMoreApplicationDetails.fertilizer_type === null) || (this.application.service_id === 6 && this.addMoreApplicationDetails.section_id === 0)) {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('globalTrans.form_error_msg'),
                color: '#ee5253'
            })
            return false
        }
        this.application.details.push(this.addMoreApplicationDetails)
        this.addMoreApplicationDetails = {
          ser_app_id: 0,
          sample_no: null,
          packets: 1,
          fertilizer_type: 0,
          fertilizer_id: 0,
          made_tea_grade_id: 0,
          section_id: null,
          sections_info: [
            { ser_app_details_id: 0, sample: 'A', sample_no: '1001', depth: '0-23', packets: '1' },
            { ser_app_details_id: 0, sample: 'B', sample_no: '1002', depth: '23-46', packets: '1' },
            { ser_app_details_id: 0, sample: 'C', sample_no: '1003', depth: '46-92', packets: '1' }
          ]
        }
    },
    addMoreItemSectionDetails () {
        if (this.addMoreApplicationDetails.section_id === null) {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('globalTrans.form_error_msg'),
                color: '#ee5253'
            })
            return false
        }
        this.application.details.push(this.addMoreApplicationDetails)
        this.addMoreApplicationDetails = {
          ser_app_id: 0,
          sample_no: null,
          packets: 1,
          fertilizer_type: 0,
          fertilizer_id: 0,
          made_tea_grade_id: 0,
          section_id: null,
          sections_info: [
            { ser_app_details_id: 0, sample: 'A', sample_no: '1001', depth: '0-23', packets: '1' },
            { ser_app_details_id: 0, sample: 'B', sample_no: '1002', depth: '23-46', packets: '1' },
            { ser_app_details_id: 0, sample: 'C', sample_no: '1003', depth: '46-92', packets: '1' }
          ]
        }
    },
    getFertilizerTypeName (id) {
      const fertilizerType = this.$store.state.TeaGardenService.commonObj.organicFertilizerTypes.find(item => item.value === id)
      if (fertilizerType && this.$i18n.locale === 'bn') {
          return fertilizerType.text_bn
      } else if (fertilizerType && this.$i18n.locale === 'en') {
          return fertilizerType.text_en
      }
    },
    getFertilizerName (id) {
      const fertilizer = this.$store.state.TeaGardenService.commonObj.masterFertilizerList.find(item => item.value === id)
      if (fertilizer && this.$i18n.locale === 'bn') {
          return fertilizer.text_bn
      } else if (fertilizer && this.$i18n.locale === 'en') {
          return fertilizer.text_en
      }
    },
    getMadeTeaGradeName (id) {
      const grade = this.$store.state.TeaGardenService.commonObj.masterMadeTeaGradeList.find(item => item.value === id)
      if (grade && this.$i18n.locale === 'bn') {
          return grade.text_bn
      } else if (grade && this.$i18n.locale === 'en') {
          return grade.text_en
      }
    },
    changeSampleDetails () {
      this.application.details = []
    },
    getGardenListValleyWise (valleyId = null) {
      if (valleyId) {
        this.getGardenList = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => (item.status === 1) && (item.valley_id === valleyId))
      } else {
        this.getGardenList = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => (item.status === 1))
      }
    }
  },
  watch: {
    'application.garden_id': function (newVal, oldValue) {
      if (newVal && newVal !== 0) {
        this.getGardenInfo(newVal)
      }
    },
    'application.service_id': function (newVal, oldValue) {
      if (newVal === 12 || newVal === 13 || newVal === 14) {
        this.isPayment = false
      } else {
        this.isPayment = true
      }
    },
    'application.test_category': function (newVal, oldValue) {
      if (newVal === 2) {
        this.isPayment = false
      } else if (newVal === 1) {
        this.isPayment = true
      }
    },
    currentLocale: function () {
        if (this.application.valley_id) {
          this.getGardenListValleyWise(this.application.valley_id)
        } else {
          this.getGardenListValleyWise()
        }
    }
  }
}

</script>
<style scoped>
  .p_heading{
    font-weight: bold;
  }
</style>
