<template>
  <div class="application-itmes">
    <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
      <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
        <b-overlay :show="loading">
          <b-row>
            <b-col sm="12">
              <div class="group-form-card">
                <b-card>
                  <!-- Education Information -->
                  <b-form-group label-cols-lg="3" :label="$t('teaGardenPduService.educational_info')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                    <b-row>
                      <b-col sm="6">
                        <ValidationProvider name="Qualification" vid="qualification" v-slot="{ errors }">
                          <b-form-group label-for="qualification">
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.qualification') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                              plain
                              v-model="formDataEducational.qualification"
                              :options="qualificationList"
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
                    </b-row>
                    <b-row v-if="formDataEducational.qualification === 5">
                      <b-col sm="6">
                        <ValidationProvider name="Other Qualification (En)" vid="other_qualification_en" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="other_qualification_en"
                          >
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.other_qualification') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEducational.other_qualification_en"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Other Qualification (Bn)" vid="other_qualification_bn" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="other_qualification_bn"
                          >
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.other_qualification') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEducational.other_qualification_bn"
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
                        <ValidationProvider name="Year" vid="passing_year" v-slot="{ errors }">
                          <b-form-group label-for="passing_year">
                            <template v-slot:label>
                              {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                              plain
                              v-model="formDataEducational.passing_year"
                              :options="yearList"
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
                      <b-col sm="6">
                        <ValidationProvider name="Result" vid="result" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="result"
                          >
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.result') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEducational.result"
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
                        <ValidationProvider name="Main Subject (En)" vid="main_subject_en" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="main_subject_en"
                          >
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.main_subject') }} {{ $t('globalTrans.en') }}
                            </template>
                            <b-form-input
                              v-model="formDataEducational.main_subject_en"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Main Subject (En)" vid="main_subject_bn" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="main_subject_bn"
                          >
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.main_subject') }} {{ $t('globalTrans.bn') }}
                            </template>
                            <b-form-input
                              v-model="formDataEducational.main_subject_bn"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Certificate Attachment" vid="certificate_attachment" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="certificate_attachment">
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.certificate_attachment') }}
                            </template>
                            <b-form-file
                              id="certificate_attachment"
                              v-model="formDataEducational.certificate_attachment"
                              @change="onChange($event, 'certificate_attachment')"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :placeholder="$t('globalTrans.attachment_placeholder')"
                              :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                              ref="certificate_attachment"
                            ></b-form-file>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                        <template class="pb-3" v-if="isFile(formDataEducational.certificate_attachment)">
                          <a :href="teaGardenServiceBaseUrl + (isImage(formDataEducational.certificate_attachment) ? 'storage/' : '') +formDataEducational.certificate_attachment" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                        </template>
                      </b-col>
                      <b-col sm="12">
                        <b-button type="button" class="add-more-btn" size="sm" @click="addEducationalItem()"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_info') }}</b-button>
                      </b-col>
                      <b-col sm="12">
                        <b-table-simple resonsive bordered class="mt-3 mb-0">
                          <b-thead>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th>{{ $t('teaGardenPduService.qualification') }}</b-th>
                              <b-th>{{ $t('globalTrans.year') }}</b-th>
                              <b-th>{{ $t('teaGardenPduService.result') }}</b-th>
                              <b-th>{{ $t('teaGardenPduService.main_subject') }}</b-th>
                              <b-th>{{ $t('globalTrans.action') }}</b-th>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <template v-if="formData.educational_infos.length">
                              <b-tr v-for="(item, index) in formData.educational_infos" :key="index">
                                <b-td>{{ $n(index + 1) }}</b-td>
                                <b-td>{{ getQualification(item) }}</b-td>
                                <b-td>{{ $n(item.passing_year, { useGrouping: false }) }}</b-td>
                                <b-td>{{ item.result }}</b-td>
                                <b-td>{{ currentLocale === 'en' ? item.main_subject_en : item.main_subject_bn }}</b-td>
                                <b-td class="text-center">
                                  <a href="javascript:" class="text-danger" :title="$t('globalTrans.delete')" @click="deleteEducationalItem(index)"><i class="ri-delete-bin-6-line"></i></a>
                                </b-td>
                              </b-tr>
                            </template>
                            <template v-else>
                              <b-tr>
                                <b-td colspan="6" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                              </b-tr>
                            </template>
                          </b-tbody>
                        </b-table-simple>
                      </b-col>
                    </b-row>
                  </b-form-group>
                  <!-- /Education Information -->

                  <!-- Employment Information -->
                  <b-form-group label-cols-lg="3" :label="$t('teaGardenPduService.employment_info')" label-size="lg" label-class="font-weight-bold pt-0" class="mt-3 mb-0">
                    <b-row>
                      <b-col sm="6">
                        <ValidationProvider name="Company Name (En)" vid="company_name_en" v-slot="{ errors }">
                          <b-form-group label-for="company_name_en">
                            <template v-slot:label>
                              {{ $t('dealer.company_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEmployment.company_name_en"
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
                        <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" v-slot="{ errors }">
                          <b-form-group label-for="company_name_bn">
                            <template v-slot:label>
                              {{ $t('dealer.company_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEmployment.company_name_bn"
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
                    <b-row>
                      <b-col sm="6">
                        <ValidationProvider name="Designation (En)" vid="designation_en" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="designation_en"
                          >
                            <template v-slot:label>
                              {{ $t('globalTrans.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEmployment.designation_en"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Designation (Bn)" vid="designation_bn" rules="">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="designation_bn"
                          >
                            <template v-slot:label>
                              {{ $t('globalTrans.designation') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formDataEmployment.designation_bn"
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
                        <ValidationProvider name="Start Date" vid="start_date" rules="">
                          <b-form-group
                            class="row"
                            label-for="start_date"
                            slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                  {{ $t('globalTrans.start_date') }}  <span class="text-danger">*</span>
                              </template>
                              <date-picker
                                id="start_date"
                                v-model="formDataEmployment.start_date"
                                class="form-control"
                                :placeholder="$t('globalTrans.select_date')"
                                :state="errors[0] ? false : (valid ? true : null)"
                                :class="errors[0] ? 'is-invalid' : ''"
                                :locale="currentLocale"
                              >
                              </date-picker>
                              <div class="invalid-feedback d-block">
                                  {{ errors[0] }}
                              </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="End Date" vid="end_date" rules="">
                          <b-form-group
                            class="row"
                            label-for="end_date"
                            slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                  {{ $t('globalTrans.end_date') }}  <span class="text-danger">*</span>
                              </template>
                              <date-picker
                              v-if="formDataEmployment.is_current === 0"
                                id="end_date"
                                v-model="formDataEmployment.end_date"
                                class="form-control"
                                :placeholder="$t('globalTrans.select_date')"
                                :state="errors[0] ? false : (valid ? true : null)"
                                :class="errors[0] ? 'is-invalid' : ''"
                                :locale="currentLocale"
                              >
                              </date-picker>
                              <b-form-input
                                v-else
                                id="end_date"
                                v-model="formDataEmployment.end_date"
                                class="form-control"
                                :placeholder="$t('teaGardenPduService.continuing')"
                                :state="errors[0] ? false : (valid ? true : null)"
                                :class="errors[0] ? 'is-invalid' : ''"
                                disabled
                              >
                              </b-form-input>
                              <div class="invalid-feedback d-block">
                                  {{ errors[0] }}
                              </div>
                              <b-form-checkbox
                                id="is_current"
                                class="mt-3"
                                v-model.number="formDataEmployment.is_current"
                                name="is_current"
                                value="1"
                                unchecked-value="0"
                              >
                                  {{ $t('teaGardenPduService.is_current') }}
                              </b-form-checkbox>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                    </b-row>
                    <b-row>
                      <b-col sm="12">
                        <b-button type="button" class="add-more-btn" size="sm" @click="addEmploymentItem()"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_info') }}</b-button>
                      </b-col>
                      <b-col sm="12">
                        <b-table-simple resonsive bordered class="mt-3 mb-0">
                          <b-thead>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th>{{ $t('dealer.company_name') }}</b-th>
                              <b-th>{{ $t('globalTrans.designation') }}</b-th>
                              <b-th>{{ $t('globalTrans.start_date') }}</b-th>
                              <b-th>{{ $t('globalTrans.end_date') }}</b-th>
                              <b-th>{{ $t('globalTrans.action') }}</b-th>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <template v-if="formData.employment_infos.length">
                              <b-tr v-for="(item, index) in formData.employment_infos" :key="index">
                                <b-td>{{ $n(index + 1) }}</b-td>
                                <b-td>{{ currentLocale === 'en' ? item.company_name_en : item.company_name_bn }}</b-td>
                                <b-td>{{ currentLocale === 'en' ? item.designation_en : item.designation_bn }}</b-td>
                                <b-td>{{ item.start_date | dateFormat }}</b-td>
                                <b-td>
                                  <template v-if="!item.is_current">{{ item.end_date | dateFormat }}</template>
                                  <template v-else>{{ $t('teaGardenPduService.continuing') }}</template>
                                </b-td>
                                <b-td class="text-center">
                                  <a href="javascript:" class="text-danger" :title="$t('globalTrans.delete')" @click="deleteEmploymentItem(index)"><i class="ri-delete-bin-6-line"></i></a>
                                </b-td>
                              </b-tr>
                            </template>
                            <template v-else>
                              <b-tr>
                                <b-td colspan="6" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                              </b-tr>
                            </template>
                          </b-tbody>
                        </b-table-simple>
                      </b-col>
                    </b-row>
                  </b-form-group>
                  <!-- /Employment Information -->

                  <!-- Other Information -->
                  <b-form-group label-cols-lg="3" :label="$t('globalTrans.other_information')" label-size="lg" label-class="font-weight-bold pt-0" class="mt-3 mb-0">
                    <b-row>
                      <b-col sm="6">
                        <ValidationProvider name="Expense Type" vid="expense_type" v-slot="{ valid, errors }">
                          <b-form-group label-for="expense_type">
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.expense_type') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-radio-group
                              :options="expenseTypeList"
                              v-model="formData.expense_type"
                              :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </b-form-radio-group>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                    </b-row>
                    <b-row v-if="formData.expense_type && formData.expense_type < 3">
                      <b-col sm="6">
                        <ValidationProvider name="Company Name (En)" vid="company_name_en" v-slot="{ valid, errors }" rules="required">
                          <b-form-group label-for="company_name_en">
                            <template v-slot:label>
                              {{ $t('dealer.company_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formData.company_name_en"
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
                        <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" v-slot="{ valid, errors }" rules="required">
                          <b-form-group label-for="company_name_bn">
                            <template v-slot:label>
                              {{ $t('dealer.company_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              v-model="formData.company_name_bn"
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
                        <ValidationProvider name="Company Address (En)" vid="company_name_en" v-slot="{ valid, errors }" rules="required">
                          <b-form-group label-for="company_address_en">
                            <template v-slot:label>
                              {{ $t('teaGardenConfig.company_address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-textarea
                              v-model="formData.company_address_en"
                              :state="errors[0] ? false : (valid ? true : null)"
                              rows="4"
                              style="height: auto"
                            >
                            </b-form-textarea>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Company Address (Bn)" vid="company_address_bn" v-slot="{ valid, errors }" rules="required">
                          <b-form-group label-for="company_address_bn">
                            <template v-slot:label>
                              {{ $t('teaGardenConfig.company_address') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-textarea
                              v-model="formData.company_address_bn"
                              :state="errors[0] ? false : (valid ? true : null)"
                              rows="4"
                              style="height: auto"
                            >
                            </b-form-textarea>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col sm="6">
                        <ValidationProvider name="Sponsor NOC" vid="sponsor_noc" rules="required">
                          <b-form-group
                            slot-scope="{ valid, errors }"
                            label-for="sponsor_noc">
                            <template v-slot:label>
                              {{ $t('teaGardenPduService.sponsor_noc') }}
                            </template>
                            <b-form-file
                              id="sponsor_noc"
                              v-model="formData.sponsor_noc"
                              @change="onChange($event, 'sponsor_noc')"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :placeholder="$t('globalTrans.attachment_placeholder')"
                              :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                            ></b-form-file>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                        <template class="pb-3" v-if="isFile(formData.sponsor_noc)">
                          <a :href="teaGardenServiceBaseUrl + (isImage(formData.sponsor_noc) ? 'storage/' : '') +formData.sponsor_noc" target="_blank" class="btn btn-sm btn-success" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                        </template>
                      </b-col>
                    </b-row>
                  </b-form-group>
                  <!-- /Other Information -->
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
  import { otherInfoStoreApi, otherInfoUpdateApi } from '../../api/routes'
  import { helpers } from '@/utils/helper-functions'

  export default {
    props: ['tabFormData', 'status', 'isUpdate'],
    data () {
      return {
        valid: null,
        formData: this.tabFormData,
        formDataEducational: {
          qualification: 0,
          other_qualification_en: '',
          other_qualification_bn: '',
          passing_year: 0,
          result: '',
          main_subject_en: '',
          main_subject_bn: '',
          certificate_attachment: null
        },
        formDataEmployment: {
          company_name_en: '',
          company_name_bn: '',
          designation_en: '',
          designation_bn: '',
          start_date: '',
          end_date: '',
          is_current: 0
        },
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        isUpdateRequest: this.isUpdate
      }
    },
    created () {
    },
    mounted () {
      this.formData = this.tabFormData
      // if (this.formData.educational_infos.length) {
      //   this.isUpdateRequest = true
      // }
    },
    computed: {
      loading: function () {
        return this.$store.state.commonObj.loading
      },
      currentLocale () {
        return this.$i18n.locale
      },
      qualificationList () {
        return [
          { text: this.currentLocale === 'en' ? 'SSC' : 'এসএসসি', value: 1, text_en: 'SSC', text_bn: 'এসএসসি' },
          { text: this.currentLocale === 'en' ? 'HSC' : 'এইচএসসি', value: 2, text_en: 'HSC', text_bn: 'এইচএসসি' },
          { text: this.currentLocale === 'en' ? 'Degree' : 'ডিগ্রী', value: 3, text_en: 'Degree', text_bn: 'ডিগ্রী' },
          { text: this.currentLocale === 'en' ? 'Masters' : 'মাস্টার্স', value: 4, text_en: 'Masters', text_bn: 'মাস্টার্স' },
          { text: this.currentLocale === 'en' ? 'Other' : 'অন্যান্য', value: 5, text_en: 'Other', text_bn: 'অন্যান্য' }
        ]
      },
      yearList () {
        return helpers.getYearList({ yearSpan: 70 })
      },
      expenseTypeList () {
        return [
          { value: 1, text: this.currentLocale === 'en' ? 'Employer' : 'নিয়োগকর্তা', text_en: 'Employer', text_bn: 'নিয়োগকর্তা' },
          { value: 2, text: this.currentLocale === 'en' ? 'Other Sponsor' : 'অন্যান্য স্পনসর', text_en: 'Other Sponsor', text_bn: 'অন্যান্য স্পনসর' },
          { value: 3, text: this.currentLocale === 'en' ? 'Self' : 'স্ব', text_en: 'Self', text_bn: 'স্ব' }
        ]
      }
    },
    watch: {
    },
    methods: {
      async submit () {
        if (!this.formData.educational_infos.length) {
          return this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: 'Please add educational info',
            color: '#ee5253'
          })
        }
        var isValidated = await this.$refs.form.validate()
        if (isValidated) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          const loadingState = { loading: false, listReload: false }
          let result
          const data = Object.assign({}, this.formData, { status: this.status })
          if (this.isUpdateRequest) {
            result = await RestApi.putData(teaGardenServiceBaseUrl, otherInfoUpdateApi + '/' + this.formData.id, data)
          } else {
            result = await RestApi.postData(teaGardenServiceBaseUrl, otherInfoStoreApi, data)
          }
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            this.$toast.success({
              title: 'Success',
              message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.isUpdateRequest = true
            // this.formData = result.model
            return result
          } else {
            this.$refs.form.setErrors(result.errors)
            this.$toast.error({
              title: this.$t('globalTrans.error'),
              message: this.$t('globalTrans.form_error_msg'),
              color: '#ee5253'
            })
          }
        }
      },
      addEducationalItem () {
        if (this.formDataEducational.qualification && this.formDataEducational.passing_year && this.formDataEducational.result) {
          const objExist = this.formData.educational_infos.find(item => (item.qualification === this.formDataEducational.qualification) && (item.passing_year === this.formDataEducational.passing_year))
          if (objExist !== undefined) {
            return this.$toast.error({
              title: 'Error',
              message: 'This educational info already exists',
              color: '#ee5253'
            })
          }
          this.formData.educational_infos.push(this.formDataEducational)
          this.formDataEducational = Object.assign({}, {
            qualification: 0,
            other_qualification_en: '',
            other_qualification_bn: '',
            passing_year: 0,
            result: '',
            main_subject_en: '',
            main_subject_bn: '',
            certificate_attachment: null
          })
          this.$refs.certificate_attachment.reset()
        } else {
          this.$toast.error({
            title: 'Error',
            message: 'Please fill educational information correctly',
            color: '#ee5253'
          })
        }
      },
      deleteEducationalItem (index) {
        this.formData.educational_infos.splice(index, 1)
      },
      addEmploymentItem () {
        if (this.formDataEmployment.company_name_en && this.formDataEmployment.company_name_bn && this.formDataEmployment.designation_en && this.formDataEmployment.designation_bn && this.formDataEmployment.start_date && (this.formDataEmployment.end_date || this.formDataEmployment.is_current)) {
          const objExist = this.formData.employment_infos.find(item => ((item.company_name_en === this.formDataEmployment.company_name_en) || (item.company_name_bn === this.formDataEmployment.company_name_bn)) && ((item.designation_en === this.formDataEmployment.designation_en) || (item.designation_bn === this.formDataEmployment.designation_bn)) && (item.start_date === this.formDataEmployment.start_date))
          if (objExist !== undefined) {
            return this.$toast.error({
              title: 'Error',
              message: 'This employment info already exists',
              color: '#ee5253'
            })
          }
          this.formData.employment_infos.push(this.formDataEmployment)
          this.formDataEmployment = Object.assign({}, {
            company_name_en: '',
            company_name_bn: '',
            designation_en: '',
            designation_bn: '',
            start_date: '',
            end_date: '',
            is_current: 0
          })
        } else {
          this.$toast.error({
            title: 'Error',
            message: 'Please fill employment information correctly',
            color: '#ee5253'
          })
        }
      },
      deleteEmploymentItem (index) {
        this.formData.employment_infos.splice(index, 1)
      },
      onChange (event, property) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            if (property === 'certificate_attachment') {
              this.formDataEducational[property] = e.target.result
            } else {
              this.formData[property] = e.target.result
            }
          }
          reader.readAsDataURL(input.files[0])
        } else {
          if (property === 'certificate_attachment') {
            this.formDataEducational[property] = ''
          } else {
            this.formData[property] = ''
          }
        }
      },
      isImage (path) {
        return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
      },
      isFile (path) {
        return /\.(jpg|jpeg|png|webp|avif|gif|svg|docs|doc|pdf|csv|xsl|xslx|ppt|pptx)$/.test(path)
      },
      getQualification (item) {
        let qualificationEn = ''
        let qualificationBn = ''
        if (item.qualification < 5) {
          const obj = this.qualificationList.find(qlfObj => qlfObj.value === item.qualification)
          qualificationEn = obj?.text_en
          qualificationBn = obj?.text_bn
        } else {
          qualificationEn = item.other_qualification_en
          qualificationBn = item.other_qualification_bn
        }

        return this.currentLocale === 'en' ? qualificationEn : qualificationBn
      }
    }
  }
</script>

<style>
  /*.font-bn .custom-control-label {*/
  /*  font-size: 0.8rem !important;*/
  /*}*/
</style>
