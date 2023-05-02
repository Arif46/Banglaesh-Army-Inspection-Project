<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="attachment_file"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.attachment_info_label')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Machineries List with Installation Date" vid="machineries_file" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="machineries_file">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.machineries_file') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                         <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          id="machineries_file"
                                                          v-model="application.machineries_file"
                                                          @change="onChange1($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.machineries_file && checkBase64(application.machineries_file) === false" :href="teaGardenServiceBaseUrl  + application.machineries_file" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Agreement Deed (Tk. 300 Stamp)" vid="agreement_deed" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="agreement_deed">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.agreement_deed') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          id="agreement_deed"
                                                          v-model="application.agreement_deed"
                                                          @change="onChange2($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.agreement_deed  && checkBase64(application.agreement_deed) === false" :href="teaGardenServiceBaseUrl  + application.agreement_deed" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Nationality Certificate of Applicant" vid="nationality_certificate" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="nationality_certificate">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.nationality_certificate') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          title="From Union Parishad, Pourosova, City Corporation"
                                                          id="nationality_certificate"
                                                          v-model="application.nationality_certificate"
                                                          @change="onChange3($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.nationality_certificate  && checkBase64(application.nationality_certificate) === false" :href="teaGardenServiceBaseUrl  + application.nationality_certificate" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6" v-if="allData.applicant_type === 2">
                                                <ValidationProvider name="Company Articles of Association" vid="article_of_association" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="article_of_association">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.article_of_association') }} <span class="text-danger">*</span>
                                                        </template>
                                                       <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="article_of_association"
                                                          v-model="application.article_of_association"
                                                          @change="onChange4($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.article_of_association && checkBase64(application.article_of_association) === false" :href="teaGardenServiceBaseUrl  + application.article_of_association" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                       </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6" v-if="allData.applicant_type === 2">
                                                <ValidationProvider name="Company Memorandum of Association" vid="memorandum_of_association" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="memorandum_of_association">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.memorandum_of_association') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="memorandum_of_association"
                                                          v-model="application.memorandum_of_association"
                                                          @change="onChange5($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.memorandum_of_association && checkBase64(application.memorandum_of_association) === false" :href="teaGardenServiceBaseUrl  + application.memorandum_of_association" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6" v-if="allData.applicant_type === 3">
                                                <ValidationProvider name="Machineries Partnership Deed Copy" vid="partnership_deed" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="partnership_deed">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.partnership_deed') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="partnership_deed"
                                                          v-model="application.partnership_deed"
                                                          @change="onChange6($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.partnership_deed && checkBase64(application.partnership_deed) === false" :href="teaGardenServiceBaseUrl  + application.partnership_deed" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6" v-if="allData.applicant_type === 4">
                                                <ValidationProvider name="Cooperative Society Registration Copy" vid="cooperative_society_registration" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="cooperative_society_registration">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.cooperative_society_registration') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="cooperative_society_registration"
                                                          v-model="application.cooperative_society_registration"
                                                          @change="onChange7($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.cooperative_society_registration && checkBase64(application.cooperative_society_registration) === false" :href="teaGardenServiceBaseUrl  + application.cooperative_society_registration" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Bank Solvency Certificate" vid="bank_solvency_certificate" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="bank_solvency_certificate">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.bank_solvency_certificate') }} <span class="text-danger">*</span>
                                                        </template>
                                                       <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          id="bank_solvency_certificate"
                                                          v-model="application.bank_solvency_certificate"
                                                          @change="onChange8($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.bank_solvency_certificate && checkBase64(application.bank_solvency_certificate) === false" :href="teaGardenServiceBaseUrl  + application.bank_solvency_certificate" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                       </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Land Deed" vid="land_deed" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="land_deed">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.land_deed') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="land_deed"
                                                          v-model="application.land_deed"
                                                          @change="onChange9($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.land_deed && checkBase64(application.land_deed) === false" :href="teaGardenServiceBaseUrl  + application.land_deed" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Lease Deed" vid="lease_deed" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="lease_deed">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.lease_deed') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          id="lease_deed"
                                                          v-model="application.lease_deed"
                                                          @change="onChange10($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.lease_deed && checkBase64(application.lease_deed) === false" :href="teaGardenServiceBaseUrl  + application.lease_deed" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Environmental Certificate" vid="environmental_certificate" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="land_deed">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.environmental_certificate') }} <span class="text-danger">*</span>
                                                        </template>
                                                       <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="environmental_certificate"
                                                          v-model="application.environmental_certificate"
                                                          @change="onChange11($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.environmental_certificate && checkBase64(application.environmental_certificate) === false" :href="teaGardenServiceBaseUrl  + application.environmental_certificate" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                       </div>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="TIN Certificate" vid="tin_certificate" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="tin_certificate">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.tin_certificate') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <div class="d-flex">
                                                        <b-form-file
                                                          accept=".pdf, .docx, .doc"
                                                          :disabled="isRenew"
                                                          id="tin_certificate"
                                                          v-model="application.tin_certificate"
                                                          @change="onChange12($event)"
                                                          :state="errors[0] ? false : (valid ? true : null)"
                                                          :placeholder="$t('globalTrans.attachment_placeholder')"
                                                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                        ></b-form-file>
                                                        <a target="_blank" style = "margin-left: 8px;" v-if="application.tin_certificate && checkBase64(application.tin_certificate) === false" :href="teaGardenServiceBaseUrl  + application.tin_certificate" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                        </div>
                                                        <div class="invalid-feedback d-block">
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
                        <!-- add more files  -->
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.add_more_file')" label-size="sm" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-col sm="12">
                                            <table class="table table-sm table-bordered section-tree-view-table">
                                                <thead>
                                                    <tr>
                                                        <th>{{ $t('teaGardenPanel.attachment_name') }} {{ $t('globalTrans.en') }}</th>
                                                        <th>{{ $t('teaGardenPanel.attachment_name') }} {{ $t('globalTrans.bn') }}</th>
                                                        <th>{{ $t('teaGardenPanel.attachment') }}</th>
                                                        <th>{{ $t('globalTrans.action') }}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <slot v-for="(item, index) in add_more_files">
                                                        <tr :key="index">
                                                        <td>
                                                            <b-form-group label-for="file_name_en">
                                                                <b-form-input v-model="item.file_name_en"></b-form-input>
                                                            </b-form-group>
                                                        </td>
                                                        <td>
                                                            <b-form-group label-for="file_name_bn">
                                                                <b-form-input v-model="item.file_name_bn"></b-form-input>
                                                            </b-form-group>
                                                        </td>
                                                        <td>
                                                            <b-form-group :label-for="'file' + index">
                                                               <div class="d-flex">
                                                                <b-form-file
                                                                accept=".pdf, .docx, .doc"
                                                                :id="'file' + index"
                                                                v-model="item.file"
                                                                @change="addMoreFileOnChange($event, index)"
                                                                :placeholder="$t('globalTrans.attachment_placeholder')"
                                                                :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                                                                ></b-form-file>
                                                                <a target="_blank" style = "margin-left: 8px;" v-if="item.file && checkBase64(item.file) === false" :href="teaGardenServiceBaseUrl  + item.file" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                                                               </div>
                                                            </b-form-group>
                                                        </td>
                                                        <td  class="text-center" style="width: 15%">
                                                            <b-button v-if="Object.keys(add_more_files).length >1" @click="addMoreItemRemove(index)" class="text-white btn-danger btn-sm mr-1" title="Delete"><i class="ri-delete-bin-6-line"></i></b-button>
                                                            <b-button  v-if="Object.keys(add_more_files).length === index + 1" @click="addMoreItem" class="btn-white btn-info" size="sm"><i class="ri-add-line"></i></b-button>
                                                        </td>
                                                        </tr>
                                                    </slot>
                                                </tbody>
                                            </table>
                                        </b-col>
                                    </b-form-group>
                                </b-card>
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { factoryInfoAttachmentInfoStoreApi } from '../../api/routes'
export default {
    props: ['app_id', 'attachmentInfoData', 'attachmentAddMoreData', 'allData', 'draft', 'isRenew'],
    data () {
      return {
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        application: {
            btb_tea_factory_reg_main_id: 0,
            app_id: 0,
            add_more_files: [
                { file_name_en: null, file_name_bn: null, file: null }
            ]
        },
        add_more_files: [
            { file_name_en: null, file_name_bn: null, file: null }
        ],
        valid: null,
        loading: false,
        editIndex: ''
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
        async submit () {
                var check = await this.$refs.attachment_file.validate()
                if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                this.application.add_more_files = this.add_more_files
                this.application.draft = this.draft
                const result = await RestApi.postData(teaGardenServiceBaseUrl, factoryInfoAttachmentInfoStoreApi, this.application)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.loading = false
                if (result.success) {
                    this.$toast.success({
                    title: 'Success',
                    message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$refs.attachment_file.setErrors(result.errors)
                    this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                    })
                }
                }
        },
        onChange1 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.machineries_file = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.machineries_file = ''
            }
        },
        onChange2 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.agreement_deed = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.agreement_deed = ''
            }
        },
        onChange3 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.nationality_certificate = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.nationality_certificate = ''
            }
        },
        onChange4 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.article_of_association = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.article_of_association = ''
            }
        },
        onChange5 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.memorandum_of_association = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.memorandum_of_association = ''
            }
        },
        onChange6 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.partnership_deed = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.partnership_deed = ''
            }
        },
        onChange7 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.cooperative_society_registration = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.cooperative_society_registration = ''
            }
        },
        onChange8 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.bank_solvency_certificate = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.bank_solvency_certificate = ''
            }
        },
        onChange9 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.land_deed = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.land_deed = ''
            }
        },
        onChange10 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.lease_deed = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.lease_deed = ''
            }
        },
        onChange11 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.environmental_certificate = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.environmental_certificate = ''
            }
        },
        onChange12 (event) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.application.tin_certificate = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.application.tin_certificate = ''
            }
        },
        checkBase64 (string) {
            var result = ''
            result = string.match('data:')
            if (result) {
                return true
            } else {
                return false
            }
        },
        //  for add more section
        addMoreItemRemove (index) {
            this.add_more_files.splice(index, 1)
        },
        addMoreItem () {
            this.add_more_files.push({ file_name_en: null, file: null })
        },
        addMoreFileOnChange (event, index) {
            const input = event.target
            if (input.files && input.files[0]) {
                const reader = new FileReader()
                reader.onload = (e) => {
                    this.add_more_files[index].file = e.target.result
                }
                reader.readAsDataURL(input.files[0])
            } else {
                this.add_more_files[index].file = ''
            }
        }
    },
    created () {
        this.application = this.attachmentInfoData
        this.add_more_files = this.attachmentAddMoreData
    }
}
</script>
