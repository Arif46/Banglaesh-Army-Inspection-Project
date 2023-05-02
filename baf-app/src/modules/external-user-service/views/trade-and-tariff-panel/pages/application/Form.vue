<template>
  <div style="font-size:14px; background-color: #17a2b8;border-radius:5px" class="p-1">
      <h6 class="text-white text-left">
          {{ $t('globalTrans.application') }}
      </h6>
    <body-card>
    <b-overlay :show="loading">
      <b-col v-if="commonProfile" md="12">
      <hr>
        <h5>
            <center><b>{{ $t('globalTrans.basic_information') }}</b></center>
        </h5>
      <hr>
      <table class="table table-sm table-borderless" style="background-color:#eeeeee;border: 5px solid; font-size:15px">
        <tr>
            <th width="15%">{{$t('globalTrans.applicant_name')}}</th>
            <td width="35%">: {{ currentLocale === 'bn' ? authUser.name_bn : authUser.name }}</td>
            <th width="15%">{{$t('globalTrans.email')}}</th>
            <td width="35%">: {{ authUser.email }}</td>
        </tr>
        <tr>
            <th>{{$t('globalTrans.mobile')}}</th>
            <td>: {{currentLocale == 'bn'? authUser.mobile.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d]) : authUser.mobile}}</td>
            <th>{{ $t('globalTrans.nid') }}</th>
            <td>: {{ $n(profile.nid_no, { useGrouping: false }) }}</td>
        </tr>
        <tr>
            <th>{{$t('globalTrans.father_name')}}</th>
            <td>: {{ currentLocale === 'bn' ? profile.father_name_bn : profile.father_name_en }}</td>
            <th>{{$t('globalTrans.mother_name')}}</th>
            <td>: {{ currentLocale === 'bn' ? profile.mother_name_bn : profile.mother_name_en }}</td>
        </tr>
        <tr>
            <th>{{$t('globalTrans.gender')}}</th>
            <td>: {{ profile.gender ? getGenderName(profile.gender) : '' }}</td>
            <th>{{$t('globalTrans.dob')}}</th>
            <td>: {{ profile.dob | dateFormat }}</td>
        </tr>
        <tr>
            <th>{{$t('externalUser.birth_place')}}</th>
            <td>: {{ currentLocale === 'bn' ? profile.birth_place_bn : profile.birth_place_en }}</td>
            <th>{{$t('globalTrans.nationality')}}</th>
            <td>: {{ currentLocale === 'bn' ? profile.nationality_bn : profile.nationality_en }}</td>
        </tr>
        <tr>
            <th>{{$t('globalTrans.occupation')}}</th>
            <td colspan="3">: {{ currentLocale === 'bn' ? profile.occupation_bn : profile.occupation_en }}</td>
        </tr>
    </table>
</b-col>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <b-row class="p-1">
              <hr>
                <h5>
                    <center><b>{{ $t('globalTrans.other_information') }}</b></center>
                </h5>
              <hr>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Application Type Id" vid="application_type_id" rules="required|min_value:1">
                  <b-form-group
                    class="row"
                    label-for="application_type_id"
                    slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                      {{ $t('globalTrans.application_type')}} <span class="text-danger">*</span>
                      </template>
                    <b-form-select
                      plain
                      v-model="form.application_type_id"
                      :options="applicationTypeList"
                      id="application_type_id"
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
              <b-col xs="12" sm="12" md="6">
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Company Name (En)" vid="company_name_en" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="company_name_en">
                    <template v-slot:label>
                      {{ $t('externalTradeTraiff.company_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      id="company_name_en"
                      v-model="form.company_name_en"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="company_name_bn">
                    <template v-slot:label>
                      {{ $t('externalTradeTraiff.company_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      id="company_name_bn"
                      v-model="form.company_name_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Company Address (En)" vid="company_address_en" rules="required">
                  <b-form-group
                    label-for="company_address_en"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.address_en')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                      v-model="form.company_address_en"
                      id="company_address_en"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Company Address (Bn)" vid="company_address_bn" rules="required">
                  <b-form-group
                    label-for="company_address_bn"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.address_en')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                      v-model="form.company_address_bn"
                      id="company_address_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="6" sm="6" md="6">
                <ValidationProvider name="Bin No" vid="bin_no" rules="required" v-slot="{ errors }">
                <b-form-group
                    label-for="bin_no">
                    <template v-slot:label>
                        {{ $t('externalTradeTraiff.bin_no') }}<span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        type="number"
                        id="bin_no"
                        v-model="form.bin_no"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-input>
                    <div class="invalid-feedback">
                    {{ errors[0] }}
                    </div>
                </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                <ValidationProvider name="Attachment" vid="bin_attachment" rules="required">
                  <b-form-group slot-scope="{ valid, errors }" label-for="bin_attachment" >
                    <template v-slot:label>
                        {{$t('externalTradeTraiff.bin_attachment')}}<span class="text-danger">*</span>
                    </template>
                    <div class="d-flex">
                      <b-form-file accept=".pdf, .docx, .doc" id="bin_attachment" v-model="form.file1"
                        @change="onFileChange1" :state="errors[0] ? false : (valid ? true : null)"
                        :placeholder="form.attachmentx1 ? form.attachmentx1 : $t('globalTrans.attachment_placeholder')"
                        :drop-placeholder="$t('externalTradeTraiff.attachment_drop_placeholder')"></b-form-file>
                    </div>
                    <div class="invalid-feedback d-block">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="6" sm="6" md="6">
                <ValidationProvider name="License No" vid="license_no" rules="required" v-slot="{ errors }">
                <b-form-group
                    label-for="license_no">
                    <template v-slot:label>
                        {{ $t('externalTradeTraiff.license_no') }}<span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        type="number"
                        id="license_no"
                        v-model="form.license_no"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-input>
                    <div class="invalid-feedback">
                    {{ errors[0] }}
                    </div>
                </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                  <ValidationProvider name="Attachment" vid="license_attachment" rules="required">
                    <b-form-group slot-scope="{ valid, errors }" label-for="license_attachment">
                      <template v-slot:label>
                          {{$t('externalTradeTraiff.license_attachment')}}<span class="text-danger">*</span>
                      </template>
                      <div class="d-flex">
                        <b-form-file accept=".pdf, .docx, .doc" id="license_attachment" v-model="form.file2"
                          @change="onFileChange2" :state="errors[0] ? false : (valid ? true : null)"
                          :placeholder="form.attachmentx2 ? form.attachmentx2 : $t('globalTrans.attachment_placeholder')"
                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                      </div>
                      <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Description (En)" vid="description_en" rules="required">
                  <b-form-group
                    label-for="description_en"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.description')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                      v-model="form.description_en"
                      id="description_en"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Description (Bn)" vid="description_bn" rules="required">
                  <b-form-group
                    label-for="description_bn"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.description')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                      v-model="form.description_bn"
                      id="description_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
                <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                  <ValidationProvider name="Attachment" vid="attachment" :rules="attachmentReq">
                    <b-form-group slot-scope="{ valid, errors }" label-for="attachment">
                      <template v-slot:label>
                          {{$t('externalTradeTraiff.main_attachment')}} <span class="text-danger">*</span>
                      </template>
                      <div class="d-flex">
                        <b-form-file accept=".pdf, .docx, .doc" id="attachment" v-model="form.file"
                          @change="onFileChange" :state="errors[0] ? false : (valid ? true : null)"
                          :placeholder="form.attachmentx ? form.attachmentx : $t('globalTrans.attachment_placeholder')"
                          :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                      </div>
                      <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            <b-row>
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
                                                      <a target="_blank" style = "margin-left: 8px;" v-if="item.file" :href="tradeTariffServiceBaseUrl  + item.file" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
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
            <b-row class="text-right">
              <b-col>
              <b-button type="submit" variant="warning" @click="formStatus(1)" class="mr-2 btn-sm">{{ draftBtnName }}</b-button>
                  <b-button type="submit" variant="success" @click="formStatus(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                  <b-button variant="danger" class="btn-sm" to="/trade-and-tariff-panel/application">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
      </ValidationObserver>
      </b-overlay>
    </body-card>
  </div>
</template>
<script>
import RestApi, { tradeTariffServiceBaseUrl } from '@/config/api_config'
import { externalApplicationStore, externalApplicationList } from '../../api/routes'
import { mapGetters } from 'vuex'
import AddressHelper from '../../../../../../utils/area-type-address'

export default {
  name: 'Form',
  components: {
  },
  props: ['id'],
  data () {
    return {
      AddressHelper: AddressHelper,
      tradeTariffServiceBaseUrl: tradeTariffServiceBaseUrl,
      valid: null,
      saveBtnName: this.$t('globalTrans.finalSave'),
      errors: [],
      isDisable: false,
      ItemShow: false,
      attachmentReq: 'required',
      draftBtnName: this.$t('globalTrans.draft'),
      form: {
          application_type_id: 0,
          company_address_en: '',
          company_address_bn: '',
          company_name_en: '',
          company_name_bn: '',
          description_en: '',
          description_bn: '',
          bin_no: '',
          license_no: '',
          file: [],
          attachment_main: '',
          file1: [],
          bin_attachment: '',
          file2: [],
          license_attachment: '',
          add_more_files: [
                { file_name_en: null, file_name_bn: null, file: null }
            ]
      },
      add_more_files: [
            { file_name_en: null, file_name_bn: null, file: null }
        ]
    }
  },
  created () {
    if (this.authUser && this.commonProfile) {
        this.profile = this.commonProfile
    } else {
      this.$router.push('/external-user/profile-update')
    }
    if (this.$route.params.id) {
      this.getData()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    applicationTypeList: function () {
      return this.$store.state.ExternalUserService.tradeTariff.commonObj.applicationTypeList.filter(item => item.status === 1)
    },
    ...mapGetters({
      authUser: 'Auth/authUser',
      commonProfile: 'Auth/commonProfile'
    })
  },
  watch: {
  currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    }
  },
  methods: {
    getGenderName (val) {
      const Obj = this.$store.state.commonObj.genderList.find(el => el.value === val)
      return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
    },
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
    },
    formStatus (status) {
        this.form.draft_status = status
    },
    onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.attachment_main = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.attachment_main = ''
        }
    },
    onFileChange1 (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.bin_attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.bin_attachment = ''
        }
    },
    onFileChange2 (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.license_attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.license_attachment = ''
        }
    },
    async saveUpdate () {
      const isValid = await this.$refs.form.validate()
      if (isValid) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          this.form.add_more_files = this.add_more_files
          result = await RestApi.postData(tradeTariffServiceBaseUrl, externalApplicationStore, this.form)
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)

          if (result.success) {
           this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
            this.form.description_en = ''
            this.form.description_bn = ''
            this.form.attachment = ''
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.$router.push('/trade-and-tariff-panel/application')
          } else {
            this.$refs.form.setErrors(result.errors)
          }
       }
    },
    async getData () {
      const result = await RestApi.getData(tradeTariffServiceBaseUrl, externalApplicationList)
      if (result.success) {
          this.form = result.data.data.find(item => item.id === this.$route.params.id)
      } else {
          return []
      }
    }
  }
}
</script>
<style>
.ql-image{
    visibility: hidden !important;
}
.ql-video{
    visibility: hidden !important;
}
</style>
