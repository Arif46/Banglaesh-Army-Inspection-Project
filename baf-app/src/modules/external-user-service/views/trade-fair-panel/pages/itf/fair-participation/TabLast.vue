<template>
    <b-row>
        <b-col md="12">
            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                    <b-overlay :show="unitLoad">
                        <!-- <b-row class="mb-3 mt-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1"> {{ $t('externalTradeFair.docs_to_be_attached') }}</h6>
                            </div>
                        </b-row> -->
                        <div class="application-form-wrapper">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.docs_to_be_attached')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.trade_license', 'en')" vid="trade_license"
                                                                :rules="`${($route.query.id && tmp_attach?.trade_license) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="trade_license">
                                                                    <template v-slot:label>
                                                                        {{ $n(1) + '. ' + $t('externalTradeFair.trade_license')}} <span v-if="!$route.query.id || !tmp_attach?.trade_license"
                                                                            class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.trade_license">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.trade_license"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.trade_license"
                                                                        v-on:change="onFileChange($event, 1)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.incorporation_certificate', 'en')" vid="incorporation_certificate"
                                                                rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="incorporation_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(2) + '. ' + $t('externalTradeFair.incorporation_certificate')}}
                                                                        <span v-if="tmp_attach?.incorporation_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.incorporation_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.incorporation_certificate"
                                                                        v-on:change="onFileChange($event, 2)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.export_regi_certificate', 'en')" vid="export_regi_certificate"
                                                                rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="export_regi_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(3) + '. ' + $t('externalTradeFair.export_regi_certificate')}}
                                                                        <span v-if="tmp_attach?.export_regi_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.export_regi_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.export_regi_certificate"
                                                                        v-on:change="onFileChange($event, 3)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.tax_return_certificate', 'en')" vid="tax_return_certificate"
                                                                rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="tax_return_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(4) + '. ' + $t('externalTradeFair.tax_return_certificate')}}
                                                                        <span v-if="tmp_attach?.tax_return_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.tax_return_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.tax_return_certificate"
                                                                        v-on:change="onFileChange($event, 4)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.vat_regi_certificate', 'en')" vid="vat_regi_certificate" rules=""
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="vat_regi_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(5) + '. ' + $t('externalTradeFair.vat_regi_certificate')}}
                                                                        <span v-if="tmp_attach?.vat_regi_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.vat_regi_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.vat_regi_certificate"
                                                                        v-on:change="onFileChange($event, 5)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.epb_regi_certificate', 'en')" vid="epb_regi_certificate" rules=""
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="epb_regi_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(6) + '. ' + $t('externalTradeFair.epb_regi_certificate')}}
                                                                        <span v-if="tmp_attach?.epb_regi_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.epb_regi_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.epb_regi_certificate"
                                                                        v-on:change="onFileChange($event, 6)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.prc_certificate', 'en')" vid="prc_certificate" rules=""
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="prc_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(7) + '. ' + $t('externalTradeFair.prc_certificate')}}
                                                                        <span v-if="tmp_attach?.prc_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.prc_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.prc_certificate"
                                                                        v-on:change="onFileChange($event, 7)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.passport', 'en')" vid="passport"
                                                                :rules="`${($route.query.id && tmp_attach?.passport) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="passport">
                                                                    <template v-slot:label>
                                                                        {{ $n(8) + '. ' + $t('externalTradeFair.passport')}} <span v-if="!$route.query.id || !tmp_attach?.passport"
                                                                            class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.passport">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.passport" title="Download Attachment"
                                                                                class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.passport" v-on:change="onFileChange($event, 8)"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $t('externalTradeFair.max_file') }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.representative_photographs', 'en')"
                                                                vid="representative_photographs"
                                                                :rules="`${($route.query.id && tmp_attach?.representative_photographs) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="representative_photographs">
                                                                    <template v-slot:label>
                                                                        {{ $n(9) + '. ' + $t('externalTradeFair.representative_photographs')}} <span
                                                                            v-if="!$route.query.id || !tmp_attach?.representative_photographs" class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.representative_photographs">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.representative_photographs"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.representative_photographs"
                                                                        v-on:change="onFileChange($event, 9)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.previous_visa', 'en')" vid="previous_visa" rules=""
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="previous_visa">
                                                                    <template v-slot:label>
                                                                        {{ $n(10) + '. ' + $t('externalTradeFair.previous_visa')}}
                                                                        <span v-if="tmp_attach?.previous_visa">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.previous_visa"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.previous_visa"
                                                                        v-on:change="onFileChange($event, 10)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.product_image', 'en')" vid="product_image"
                                                                :rules="`${($route.query.id && tmp_attach?.product_image) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="product_image">
                                                                    <template v-slot:label>
                                                                        {{ $n(11) + '. ' + $t('externalTradeFair.product_image')}} <span v-if="!$route.query.id || !tmp_attach?.product_image"
                                                                            class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.product_image">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.product_image"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.product_image"
                                                                        v-on:change="onFileChange($event, 11)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <!-- <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.product_description', 'en')" vid="product_description"
                                                                :rules="`${($route.query.id && tmp_attach?.product_description) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="product_description">
                                                                    <template v-slot:label>
                                                                        {{ $n(12) + '. ' + $t('externalTradeFair.product_description')}} <span
                                                                            v-if="!$route.query.id || !tmp_attach?.product_description" class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.product_description">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.product_description"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.product_description"
                                                                        v-on:change="onFileChange($event, 12)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col> -->
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.award_certificate', 'en')" vid="award_certificate" rules=""
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="award_certificate">
                                                                    <template v-slot:label>
                                                                        {{ $n(12) + '. ' + $t('externalTradeFair.award_certificate')}}
                                                                        <span v-if="tmp_attach?.award_certificate">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.award_certificate"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".doc,.docx,.pdf" v-model="attach.award_certificate"
                                                                        v-on:change="onFileChange($event, 13)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider :name="$t('externalTradeFair.representative_signature', 'en')" vid="representative_signature"
                                                                :rules="`${($route.query.id && tmp_attach?.representative_signature) ? '' : 'required'}`" v-slot="{ errors }">
                                                                <b-form-group label-for="representative_signature">
                                                                    <template v-slot:label>
                                                                        {{ $n(13) + '. ' + $t('externalTradeFair.representative_signature')}} <span
                                                                            v-if="!$route.query.id || !tmp_attach?.representative_signature" class="text-danger">*</span>
                                                                        <span v-if="tmp_attach?.representative_signature">
                                                                            <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.representative_signature"
                                                                                title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i
                                                                                    class="ri-download-cloud-fill"></i></a>
                                                                        </span>
                                                                    </template>
                                                                    <b-form-file plain accept=".png,.jpeg,.jpg" v-model="attach.representative_signature"
                                                                        v-on:change="onFileChange($event, 14)" :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    <div class="invalid-feedback d-block text-muted">
                                                                        {{ $i18n.locale == 'en' ? '[Maximum file size is 500 KB and file format is PNG/JPEG/JPG]' : '[সর্বোচ্চ ফাইল সাইজ 500 KB এবং ফাইল ফরমেট PNG/JPEG/JPG]' }}
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
                        <!-- <b-row>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.trade_license', 'en')"
                                    vid="trade_license"
                                    :rules="`${($route.query.id && tmp_attach?.trade_license) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="trade_license">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.trade_license')}} <span v-if="!$route.query.id || !tmp_attach?.trade_license" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.trade_license">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.trade_license" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.trade_license"
                                            v-on:change="onFileChange($event, 1)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.incorporation_certificate', 'en')"
                                    vid="incorporation_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="incorporation_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.incorporation_certificate')}}
                                            <span v-if="tmp_attach?.incorporation_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.incorporation_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.incorporation_certificate"
                                            v-on:change="onFileChange($event, 2)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.export_regi_certificate', 'en')"
                                    vid="export_regi_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="export_regi_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.export_regi_certificate')}}
                                            <span v-if="tmp_attach?.export_regi_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.export_regi_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.export_regi_certificate"
                                            v-on:change="onFileChange($event, 3)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.tax_return_certificate', 'en')"
                                    vid="tax_return_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="tax_return_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.tax_return_certificate')}}
                                            <span v-if="tmp_attach?.tax_return_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.tax_return_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.tax_return_certificate"
                                            v-on:change="onFileChange($event, 4)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.vat_regi_certificate', 'en')"
                                    vid="vat_regi_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="vat_regi_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.vat_regi_certificate')}}
                                            <span v-if="tmp_attach?.vat_regi_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.vat_regi_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.vat_regi_certificate"
                                            v-on:change="onFileChange($event, 5)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.epb_regi_certificate', 'en')"
                                    vid="epb_regi_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="epb_regi_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.epb_regi_certificate')}}
                                            <span v-if="tmp_attach?.epb_regi_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.epb_regi_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.epb_regi_certificate"
                                            v-on:change="onFileChange($event, 6)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.prc_certificate', 'en')"
                                    vid="prc_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="prc_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.prc_certificate')}}
                                            <span v-if="tmp_attach?.prc_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.prc_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.prc_certificate"
                                            v-on:change="onFileChange($event, 7)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.passport', 'en')"
                                    vid="passport"
                                    :rules="`${($route.query.id && tmp_attach?.passport) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="passport">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.passport')}} <span v-if="!$route.query.id || !tmp_attach?.passport" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.passport">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.passport" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.passport"
                                            v-on:change="onFileChange($event, 8)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $t('externalTradeFair.max_file') }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.representative_photographs', 'en')"
                                    vid="representative_photographs"
                                    :rules="`${($route.query.id && tmp_attach?.representative_photographs) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="representative_photographs">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.representative_photographs')}} <span v-if="!$route.query.id || !tmp_attach?.representative_photographs" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.representative_photographs">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.representative_photographs" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.representative_photographs"
                                            v-on:change="onFileChange($event, 9)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.previous_visa', 'en')"
                                    vid="previous_visa"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="previous_visa">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.previous_visa')}}
                                            <span v-if="tmp_attach?.previous_visa">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.previous_visa" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.previous_visa"
                                            v-on:change="onFileChange($event, 10)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.product_image', 'en')"
                                    vid="product_image"
                                    :rules="`${($route.query.id && tmp_attach?.product_image) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="product_image">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.product_image')}} <span v-if="!$route.query.id || !tmp_attach?.product_image" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.product_image">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.product_image" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.product_image"
                                            v-on:change="onFileChange($event, 11)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.product_description', 'en')"
                                    vid="product_description"
                                    :rules="`${($route.query.id && tmp_attach?.product_description) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="product_description">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.product_description')}} <span v-if="!$route.query.id || !tmp_attach?.product_description" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.product_description">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.product_description" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.product_description"
                                            v-on:change="onFileChange($event, 12)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 5 MB and file format is DOC/DOCX/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 5 MB এবং ফাইল ফরমেট DOC/DOCX/PDF]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.award_certificate', 'en')"
                                    vid="award_certificate"
                                    rules=""
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="award_certificate">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.award_certificate')}}
                                            <span v-if="tmp_attach?.award_certificate">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.award_certificate" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".doc,.docx,.pdf"
                                            v-model="attach.award_certificate"
                                            v-on:change="onFileChange($event, 13)"
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
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider
                                    :name="$t('externalTradeFair.representative_signature', 'en')"
                                    vid="representative_signature"
                                    :rules="`${($route.query.id && tmp_attach?.representative_signature) ? '' : 'required'}`"
                                    v-slot="{ errors }"
                                >
                                    <b-form-group class="row" label-cols-sm="12" label-for="representative_signature">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.representative_signature')}} <span v-if="!$route.query.id || !tmp_attach?.representative_signature" class="text-danger">*</span>
                                            <span v-if="tmp_attach?.representative_signature">
                                                <a target="_blank" :href="baseUrl + 'storage/' + tmp_attach?.representative_signature" title="Download Attachment" class="ml-2">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                        <b-form-file
                                            plain
                                            accept=".png,.jpeg,.jpg"
                                            v-model="attach.representative_signature"
                                            v-on:change="onFileChange($event, 14)"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 500 KB and file format is PNG/JPEG/JPG]' : '[সর্বোচ্চ ফাইল সাইজ 500 KB এবং ফাইল ফরমেট PNG/JPEG/JPG]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row> -->
                        <!-- <b-row class="mt-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1"> {{ $t('externalTradeFair.declaration') }}</h6>
                            </div>
                        </b-row> -->
                        <b-row>
                            <b-col sm="12">
                                <div class="fair-note-wrapper">
                                    <p>
                                        <span class="note-title">{{ $t('externalTradeFair.note') }}</span>
                                        <span>{{ evaluation_note }}</span>
                                    </p>
                                </div>
                            </b-col>
                            <b-col sm="12">
                                <ValidationProvider name="Licence Issue" vid="licence_issue" rules="required|min_value:1">
                                    <b-form-group
                                        class="row mb-4"
                                        label-cols-sm="12"
                                        label-for="licence_issue"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <b-form-checkbox
                                            id="licence_issue"
                                            v-model="attachments.license_issue"
                                            name="checkbox-1"
                                            value="1"
                                            unchecked-value="2"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template>
                                            <p style="margin-top: 2px;font-weight: 600;">{{ $t('externalTradeFair.declaration_detail') }}</p>
                                        </template>
                                        </b-form-checkbox>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col sm="12">
                                <div class="fair-note-wrapper">
                                    <p v-for="(item, index) in note" :key="index">
                                        <span v-if="index === 0" class="note-title">{{ $t('externalTradeFair.note') }}</span>
                                        <span v-if="index === 0 || index === 5"><strong> {{ item.text }}</strong></span>
                                        <span v-else>{{ item.text }}</span>
                                    </p>
                                </div>
                            </b-col>
                        </b-row>
                    </b-overlay>
                </b-form>
            </ValidationObserver>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartStoreLastApi } from '../../../api/routes'

export default {
    props: ['app_id', 'attachments', 'app_status', 'baseUrl'],
    data () {
        return {
            errors: [],
            valid: null,
            unitLoad: false,
            tmp_attach: {},
            attach: {
                trade_license: [],
                incorporation_certificate: [],
                export_regi_certificate: [],
                tax_return_certificate: [],
                vat_regi_certificate: [],
                epb_regi_certificate: [],
                prc_certificate: [],
                passport: [],
                representative_photographs: [],
                previous_visa: [],
                product_image: [],
                product_description: [],
                award_certificate: [],
                representative_signature: []
            }
        }
    },
    created () {
        if (this.$route.query.id) {
            this.tmp_attach = JSON.parse(JSON.stringify(this.attachments))
            // this.attach = JSON.parse(JSON.stringify(this.attachments))
        }
    },
    watch: {
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
            }
        }
    },
    computed: {
        evaluation_note () {
            const textEn = 'The companies/exporters/business entities will be evaluated by EPB in order to determine their participation.'
            const textBn = 'কোম্পানি/রপ্তানিকারক/ব্যবসায়িক সত্তা তাদের অংশগ্রহণ নির্ধারণের জন্য রপ্তানি উন্নয়ন ব্যুরো দ্বারা মূল্যায়ন করা হবে।'
            return this.$i18n.locale === 'en' ? textEn : textBn
        },
        note () {
            const arrayOfEn = [
                { text: 'a) Services offered by EPB' },
                { text: '* Constructed booth with basic furniture, fascia and utility services.' },
                { text: '* Communication and promotion services (Entry in fair catalogue and EPB brochure, etc.' },
                { text: '* Interpreter Service (if required)' },
                { text: '* Transportation of Exhibits (if applicable)' },
                { text: 'b) EPB encourages  business entities of all sectors from all over Bangladesh including villages to participate in the International Trade Fair abroad.' }
            ]
            const arrayOfBn = [
                { text: 'ক) রপ্তানি উন্নয়ন ব্যুরো দ্বারা দেওয়া পরিষেবা' },
                { text: '* মৌলিক আসবাবপত্র, ফ্যাসিয়া এবং ইউটিলিটি পরিষেবা সহ বুথ তৈরি করা হয়েছে।' },
                { text: '* যোগাযোগ এবং প্রচার পরিষেবা (ফেয়ার ক্যাটালগে এন্ট্রি এবং ইপিবি ব্রোশিওর, ইত্যাদি।' },
                { text: '* দোভাষী পরিষেবা (যদি প্রয়োজন হয়)' },
                { text: '* প্রদর্শনীর পরিবহন (যদি প্রযোজ্য হয়)' },
                { text: 'খ) রপ্তানি উন্নয়ন ব্যুরো বিদেশে আন্তর্জাতিক বাণিজ্য মেলায় অংশগ্রহণের জন্য গ্রামসহ সারা বাংলাদেশের সকল সেক্টরের ব্যবসা প্রতিষ্ঠানকে উৎসাহিত করে।' }
            ]
            return this.$i18n.locale === 'en' ? arrayOfEn : arrayOfBn
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        onFileChange (event, count) {
            const input = event.target
            if (input.files && input.files[0]) {
                // const reader = new FileReader()
                // reader.onload = (e) => {
                    // const base64File = e.target.result
                    const base64File = event.target.files[0]
                    if (count === 1) {
                        this.attach.trade_license = base64File
                    } else if (count === 2) {
                        this.attach.incorporation_certificate = base64File
                    } else if (count === 3) {
                        this.attach.export_regi_certificate = base64File
                    } else if (count === 4) {
                        this.attach.tax_return_certificate = base64File
                    } else if (count === 5) {
                        this.attach.vat_regi_certificate = base64File
                    } else if (count === 6) {
                        this.attach.epb_regi_certificate = base64File
                    } else if (count === 7) {
                        this.attach.prc_certificate = base64File
                    } else if (count === 8) {
                        this.attach.passport = base64File
                    } else if (count === 9) {
                        this.attach.representative_photographs = base64File
                    } else if (count === 10) {
                        this.attach.previous_visa = base64File
                    } else if (count === 11) {
                        this.attach.product_image = base64File
                    } else if (count === 12) {
                        // this.attach.product_description = base64File
                    } else if (count === 13) {
                        this.attach.award_certificate = base64File
                    } else if (count === 14) {
                        this.attach.representative_signature = base64File
                    }
                // }
                // reader.readAsDataURL(input.files[0])
            } else {
                if (count === 1) {
                    this.attach.trade_license = []
                } else if (count === 2) {
                    this.attach.incorporation_certificate = []
                } else if (count === 3) {
                    this.attach.export_regi_certificate = []
                } else if (count === 4) {
                    this.attach.tax_return_certificate = []
                } else if (count === 5) {
                    this.attach.vat_regi_certificate = []
                } else if (count === 6) {
                    this.attach.epb_regi_certificate = []
                } else if (count === 7) {
                    this.attach.prc_certificate = []
                } else if (count === 8) {
                    this.attach.passport = []
                } else if (count === 9) {
                    this.attach.representative_photographs = []
                } else if (count === 10) {
                    this.attach.previous_visa = []
                } else if (count === 11) {
                    this.attach.product_image = []
                } else if (count === 12) {
                    // this.attach.product_description = []
                } else if (count === 13) {
                    this.attach.award_certificate = []
                } else if (count === 14) {
                    this.attach.representative_signature = []
                }
            }
        },
        async submit () {
            var check = await this.$refs.form.validate()
            if (check) {
                this.unitLoad = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.attachments.app_id = this.app_id
                this.attachments.app_status = this.app_status
                if (this.$route.query.id) {
                    this.attachments.edit_mode = 1
                } else {
                    this.attachments.edit_mode = 0
                }

                const formData = new FormData()
                Object.keys(this.attachments).map(key => {
                    const keyExist = Object.keys(this.attach).some(ky => ky === key)
                    if (keyExist) {
                        formData.append(key, this.attach[key])
                    } else {
                        formData.append(key, this.attachments[key])
                    }
                })

                const result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartStoreLastApi, formData)
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
