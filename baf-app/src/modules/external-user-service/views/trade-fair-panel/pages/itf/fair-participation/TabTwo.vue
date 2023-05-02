<template>
    <b-row>
        <b-col md="12">
            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                    <b-overlay :show="unitLoad">
                        <!-- <b-row class="mb-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1"> {{ $t('tradeFairConfig.stall_information') }}</h6>
                            </div>
                        </b-row> -->
                        <div class="application-form-wrapper">
                            <div class="application-itmes fair-tab2-wrapper">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="12" :label="$t('externalTradeFair.choose_stall_category')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <b-table-simple class="mb-0" bordered hover small>
                                                                <thead>
                                                                    <!-- <tr>
                                                                        <b-th colspan="8" class="text-left p-2" style="background: #e3e3e3">{{ 'Choose stall category' }}</b-th>
                                                                    </tr> -->
                                                                    <tr class="text-white text-align-center">
                                                                        <th style="width:5%" class="text-center">
                                                                            <b-form-checkbox id="checkbox-1" name="checkbox-1" @change="selectAll($event)" :value=1
                                                                                :unchecked-value=0>
                                                                                <!-- {{ $t('tradeFairConfig.select_all') }} -->
                                                                            </b-form-checkbox>
                                                                        </th>
                                                                        <th style="width:20%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                                                                        <!-- <th style="width:10%">{{ $t('tradeFairConfig.measurement_unit') }}</th> -->
                                                                        <th style="width:15%">{{ $t('tradeFairConfig.stall_size') }}</th>
                                                                        <th style="width:15%">{{ $t('tradeFairConfig.stall_type') }}</th>
                                                                        <th style="width:15%">{{ $t('tradeFairConfig.booth_rent') + ' ' + $t('globalTrans.tk') }}</th>
                                                                        <th style="width:30%">{{ $t('globalTrans.description') }}</th>
                                                                    </tr>
                                                                </thead>
                                                                <b-tbody v-if="stalls?.length > 0">
                                                                    <b-tr v-for="(item, index) in stalls" :key="index">
                                                                        <b-td class="text-center">
                                                                            <b-form-checkbox :id="'checkbox-1'+index" v-model="item.is_active" :name="'checkbox-1'+index" :value=1
                                                                                :unchecked-value=0>
                                                                            </b-form-checkbox>
                                                                        </b-td>
                                                                        <b-td>{{ $n(index + 1) }}. {{ getStallCategoryName(item.stall_cat_id) }}</b-td>
                                                                        <!-- <b-td>{{ getMeasurementUnit(item.measurement_id) }}</b-td> -->
                                                                        <b-td>{{ $n(item.stall_size) + ' ' + getMeasurementUnit(item.measurement_id) }}</b-td>
                                                                        <b-td>{{ getStallType(item.stall_type) }}</b-td>
                                                                        <b-td>{{ $n(item.booth_rent) }}</b-td>
                                                                        <b-td class="text-left">{{ $i18n.locale == 'bn' ? item.description_bn : item.description_en }}</b-td>
                                                                    </b-tr>
                                                                </b-tbody>
                                                            </b-table-simple>
                                                        </b-col>
                                                        <b-col sm="12">
                                                            <div class="fair-note-wrapper mt-2">
                                                                <p>
                                                                    <span class="note-title">{{ $t('externalTradeFair.note') }}</span>
                                                                    <span class="font-weight-bold">{{ stall_note }}</span>
                                                                </p>
                                                            </div>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fair_participation_awarded_internation_certification_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="12">
                                                            <ValidationProvider name="Have You Exported" vid="participate_status" rules="required|min_value:1">
                                                                <b-form-group class="row" label-for="participate_status" label-cols-sm="5" slot-scope="{ valid, errors }">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.is_first_participate') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-radio-group class="text-left" v-model="objective.participate_status"
                                                                        :options="[{ value: 1, text: $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }, { value: 2, text: $i18n.locale == 'en' ? 'No' : 'না' }]"
                                                                        value-field="value" text-field="text"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-radio-group>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Participate with EPB" vid="participation_count" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="participation_count">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.participate_with_epb_count') }}
                                                                    </template>
                                                                    <b-form-input v-model="objective.participation_count"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Award (En)" vid="certificate_award_en" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="certificate_award_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.intel_certificate_award') + ' ' + $t('globalTrans.en')}}
                                                                    </template>
                                                                    <b-form-input v-model="objective.certificate_award_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Award (Bn)" vid="certificate_award_bn" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="certificate_award_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.intel_certificate_award') + ' ' + $t('globalTrans.bn')}}
                                                                    </template>
                                                                    <b-form-input v-model="objective.certificate_award_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="attachment" vid="attachment">
                                                                <b-form-group label-for="attachment">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="objective_attachment_file"
                                                                            :href="url + 'storage/' + objective_attachment_file">{{ $t('globalTrans.download')}} <i
                                                                                class="ri-download-cloud-fill"></i> </a>
                                                                    </template>
                                                                    <b-form-file id="attachment" v-model="objective_attachment" v-on:change="onFileChange"
                                                                        accept=".doc,.docx,.pdf" plain :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
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
                                                <div class="fair-note-wrapper mt-2">
                                                    <p>
                                                        <span class="note-title">{{ $t('externalTradeFair.note') }}</span>
                                                        {{ $t('externalTradeFair.tab_two_note') }}
                                                    </p>
                                                </div>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.participation_obj')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Generate Purchase Orders" vid="purchase_order" rules="max_value:9|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="purchase_order">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.purchase_order') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.purchase_order"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Being New Commercial relation" vid="commercial_relation" rules="max_value:9|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="commercial_relation">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.commercial_relation') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.commercial_relation"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Secure the existent commercial relations" vid="existent_comm_relation"
                                                                rules="max_value:9|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="existent_comm_relation">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.existent_comm_relation') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.existent_comm_relation"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Show new products" vid="new_products" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="new_products">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.new_products') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.new_products"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Know competition activities" vid="competition_activities" rules="max_value:9|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="competition_activities">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.competition_activities') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.competition_activities"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Get Information About The trends and innovations" vid="trends_and_innovations"
                                                                rules="max_value:9|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="trends_and_innovations">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.trends_and_innovations') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.trends_and_innovations"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Direct sales" vid="direct_sales" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="direct_sales">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.direct_sales') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.direct_sales"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Obtain a market impression" vid="market_impression" rules="max_value:9|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="market_impression">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.market_impression') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.market_impression"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Generate reliance on my clients" vid="reliance" rules="max_value:9|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="reliance">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.reliance') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.reliance"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Others" vid="others" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="others">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.others') }}
                                                                    </template>
                                                                    <b-form-input class="mb-0" v-model="objective.others"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
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
                                </b-row>
                            </div>
                        </div>
                        <b-row>
                            <!-- <b-col sm="12">
                                <b-table-simple bordered hover small>
                                    <thead>
                                        <tr>
                                        <b-th colspan="8" class="text-left p-2" style="background: #e3e3e3">{{ 'Choose stall category' }}</b-th>
                                        </tr>
                                        <tr class="bg-primary text-align-center">
                                            <th style="width:7%" class="text-center">
                                                <b-form-checkbox
                                                    id="checkbox-1"
                                                    name="checkbox-1"
                                                    @change="selectAll($event)"
                                                    :value=1
                                                    :unchecked-value=0
                                                >
                                                {{ $t('tradeFairConfig.select_all') }}
                                                </b-form-checkbox>
                                            </th>
                                            <th style="width:10%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                                            <th style="width:10%">{{ $t('tradeFairConfig.measurement_unit') }}</th>
                                            <th style="width:10%">{{ $t('tradeFairConfig.stall_size') }}</th>
                                            <th style="width:10%">{{ $t('tradeFairConfig.stall_type') }}</th>
                                            <th style="width:10%">{{ $t('tradeFairConfig.booth_rent') + ' ' + $t('globalTrans.tk') }}</th>
                                            <th style="width:10%">{{ $t('globalTrans.description') }}</th>
                                        </tr>
                                    </thead>
                                    <b-tbody v-if="stalls?.length > 0">
                                        <b-tr v-for="(item, index) in stalls" :key="index">
                                            <b-td class="text-center">
                                                <b-form-checkbox
                                                    :id="'checkbox-1'+index"
                                                    v-model="item.is_active"
                                                    :name="'checkbox-1'+index"
                                                    :value=1
                                                    :unchecked-value=0
                                                >
                                                </b-form-checkbox>
                                            </b-td>
                                            <b-td>{{ $n(index + 1) }}. {{ getStallCategoryName(item.stall_cat_id) }}</b-td>
                                            <b-td>{{ getMeasurementUnit(item.measurement_id) }}</b-td>
                                            <b-td>{{ $n(item.stall_size) + ' ' + getMeasurementUnit(item.measurement_id) }}</b-td>
                                            <b-td>{{ getStallType(item.stall_type) }}</b-td>
                                            <b-td>{{ $n(item.booth_rent) }}</b-td>
                                            <b-td class="text-left">{{ $i18n.locale == 'bn' ? item.description_bn : item.description_en }}</b-td>
                                        </b-tr>
                                    </b-tbody>
                                </b-table-simple>
                            </b-col> -->
                            <!-- <b-col xl="10" lg="10" sm="12" class="float-left text-right mt-3">
                                <b-col xl="12" lg="12" sm="12">
                                    <ValidationProvider name="Have You Exported" vid="participate_status" rules="required|min_value:1">
                                        <b-form-group
                                            class="row"
                                            label-for="participate_status"
                                            label-cols-sm="5"
                                            slot-scope="{ valid, errors }"
                                            >
                                            <template v-slot:label>
                                            {{ $t('externalTradeFair.is_first_participate') }} <span class="text-danger">*</span>
                                            </template>
                                            <b-form-radio-group
                                                class="text-left"
                                                v-model="objective.participate_status"
                                                :options="[{ value: 1, text: $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }, { value: 2, text: $i18n.locale == 'en' ? 'No' : 'না' }]"
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
                                <b-col xl="12" lg="12" sm="12">
                                    <ValidationProvider name="Participate with EPB" vid="participation_count" rules="" v-slot="{ errors }">
                                        <b-form-group
                                            label-cols-sm="5"
                                            label-for="participation_count"
                                        >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.participate_with_epb_count') }}
                                            </template>
                                            <b-form-input
                                                v-model="objective.participation_count"
                                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-input>
                                            <div class="invalid-feedback">
                                                {{ errors[0] }}
                                            </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                                <b-col xl="12" lg="12" sm="12">
                                    <ValidationProvider name="Award (En)" vid="certificate_award_en" rules="" v-slot="{ errors }">
                                        <b-form-group
                                            label-cols-sm="5"
                                            label-for="certificate_award_en"
                                        >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.intel_certificate_award') + ' ' + $t('globalTrans.en')}}
                                        </template>
                                        <b-form-input
                                            v-model="objective.certificate_award_en"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                                <b-col xl="12" lg="12" sm="12">
                                    <ValidationProvider name="Award (Bn)" vid="certificate_award_bn" rules="" v-slot="{ errors }">
                                        <b-form-group
                                            label-cols-sm="5"
                                            label-for="certificate_award_bn"
                                        >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.intel_certificate_award') + ' ' + $t('globalTrans.bn')}}
                                        </template>
                                        <b-form-input
                                            v-model="objective.certificate_award_bn"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                                <b-col xl="12" lg="12" sm="12">
                                    <ValidationProvider name="attachment" vid="attachment">
                                        <b-form-group
                                            label-for="attachment"
                                            label-cols-sm="5"
                                        >
                                            <template v-slot:label>
                                            {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="objective_attachment_file" :href="url + 'storage/' + objective_attachment_file">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                                            </template>
                                            <b-form-file id="attachment"
                                            v-model="objective_attachment"
                                            v-on:change="onFileChange"
                                            accept=".doc,.docx,.pdf"
                                            plain
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-file>
                                            <div class="invalid-feedback">
                                            {{ errors[0] }}
                                            </div>
                                            <div class="invalid-feedback d-block text-muted">
                                                {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                            </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                            </b-col> -->
                        </b-row>
                        <!-- <b-row class="mb-3 mt-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1"> {{ $t('externalTradeFair.participation_obj') }}</h6>
                            </div>
                        </b-row>
                        <b-row class="mb-3 mt-3">
                            <div>
                                <h6> {{ $t('externalTradeFair.tab_two_note') }}</h6>
                            </div>
                        </b-row>
                        <b-row>
                            <b-col sm="12" class="float-left text-right">
                                <b-row>
                                    <b-col sm="6">
                                        <ValidationProvider name="Generate Purchase Orders" vid="purchase_order" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="purchase_order"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.purchase_order') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.purchase_order"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Being New Commercial relation" vid="commercial_relation" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="commercial_relation"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.commercial_relation') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.commercial_relation"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
                                    <b-col sm="6">
                                        <ValidationProvider name="Secure the existent commercial relations" vid="existent_comm_relation" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="existent_comm_relation"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.existent_comm_relation') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.existent_comm_relation"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Show new products" vid="new_products" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="new_products"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.new_products') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.new_products"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
                                    <b-col sm="6">
                                        <ValidationProvider name="Know competition activities" vid="competition_activities" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="competition_activities"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.competition_activities') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.competition_activities"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Get Information About The trends and innovations" vid="trends_and_innovations" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="trends_and_innovations"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.trends_and_innovations') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.trends_and_innovations"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
                                    <b-col sm="6">
                                        <ValidationProvider name="Direct sales" vid="direct_sales" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="direct_sales"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.direct_sales') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.direct_sales"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Obtain a market impression" vid="market_impression" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="market_impression"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.market_impression') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.market_impression"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
                                    <b-col sm="6">
                                        <ValidationProvider name="Generate reliance on my clients" vid="reliance" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="reliance"
                                            >
                                            <template v-slot:label>
                                                {{ $t('externalTradeFair.reliance') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.reliance"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Others" vid="others" rules="max_value:9|min_value:1" v-slot="{ errors }">
                                            <b-form-group
                                                label-cols-sm="6"
                                                label-for="others"
                                            >
                                            <template v-slot:label>
                                                {{ $t('globalTrans.others') }}
                                                </template>
                                                <b-form-input
                                                    class="mb-0"
                                                    v-model="objective.others"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                </b-row>
                            </b-col>
                        </b-row> -->
                        <!-- <b-row>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Others (En)" vid="others_en" rules="" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="others_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.others') + ' ' + $t('globalTrans.en')}}
                                    </template>
                                    <b-form-input
                                        v-model="objective.others_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Others (Bn)" vid="others_bn" rules="" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="others_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.others') + ' ' + $t('globalTrans.bn')}}
                                    </template>
                                    <b-form-input
                                        v-model="objective.others_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row> -->
                    </b-overlay>
                </b-form>
            </ValidationObserver>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartStoreTwoApi } from '../../../api/routes'

export default {
    props: ['app_id', 'objective', 'stallList', 'fair_name_id', 'stall_ids'],
    data () {
        return {
            url: internationalTradeFairServiceBaseUrl,
            errors: [],
            valid: null,
            unitLoad: false,
            stalls: [],
            objective_attachment: [],
            objective_attachment_file: '',
            stallCategoryList: []
        }
    },
    created () {
        if (this.$route.query.id) {
            this.objective_attachment_file = this.objective.attachment
            this.stalls = this.stallList.map(el => {
                const Exist = this.stall_ids.find(item => item.stall_detail_id === el.id)
                return Object.assign({}, el, { is_active: typeof Exist !== 'undefined' ? 1 : 0 })
            })
        } else {
            this.stalls = [...this.stallList]
        }
        this.getStallCategoryList(this.fair_name_id)
    },
    watch: {
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
            }
        }
    },
    computed: {
        stall_note () {
            const textEn = 'Once selected, participation fees will not be refunded. Penalty may be imposed in case of intentional absense/negative activities in the fair.'
            const textBn = 'একবার নির্বাচিত হলে, অংশগ্রহণের ফি ফেরত দেওয়া হবে না। মেলায় ইচ্ছাকৃত অনুপস্থিতি/নেতিবাচক কার্যকলাপের ক্ষেত্রে জরিমানা আরোপ করা যেতে পারে।'
            return this.$i18n.locale === 'en' ? textEn : textBn
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        selectAll (e) {
            if (this.stalls.length > 0) {
                if (e) {
                    const newArr = this.stalls.map(el => {
                        return Object.assign({}, el, { is_active: 1 })
                    })
                    this.stalls = newArr
                } else {
                    const newArr2 = this.stalls.map(el => {
                        return Object.assign({}, el, { is_active: 0 })
                    })
                    this.stalls = newArr2
                }
            }
        },
        getStallCategoryList (id) {
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
        },
        getStallCategoryName (id) {
            const Obj = this.stallCategoryList.find(item => item.value === id)
            if (this.currentLocale === 'bn') {
                return Obj !== undefined ? Obj.text_bn : ''
            } else {
                return Obj !== undefined ? Obj.text_en : ''
            }
        },
        getMeasurementUnit (id) {
            const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === id)
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
        onFileChange (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                this.objective.attachment = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.objective.attachment = ''
            }
        },
        async submit () {
            var check = await this.$refs.form.validate()
            if (check) {
                if (!this.stalls.filter(el => el.is_active === 1).length) {
                    return this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: 'Add at least one stall category item!',
                        color: 'red'
                    })
                }
                this.unitLoad = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.objective.app_id = this.app_id
                this.objective.stalls = this.stalls
                const result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartStoreTwoApi, this.objective)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.unitLoad = false
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: this.$t('globalTrans.form_error_msg'),
                        color: '#ee5253'
                    })
                    this.$refs.form.setErrors(result.errors)
                }
            }
        }
    }
}
</script>
<style>
.application-itmes.fair-tab2-wrapper .table {
    border-collapse: separate;
    border-spacing: 0 10px;
    border: none;
}
.application-itmes.fair-tab2-wrapper .table thead tr {
    background: #15273B;
    border-radius: 3px;
    box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
}
.application-itmes.fair-tab2-wrapper .table tbody tr {
    box-shadow: rgb(0 0 0 / 12%) 0px 1px 3px, rgb(0 0 0 / 24%) 0px 1px 2px;
}
.application-itmes.fair-tab2-wrapper .table thead tr th,
.application-itmes.fair-tab2-wrapper .table tbody tr td {
    border: none;
}
</style>
