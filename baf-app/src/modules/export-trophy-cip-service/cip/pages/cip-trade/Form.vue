<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="6">
            <ValidationProvider name="Circular" vid="circular_id" rules="required|min_value:1">
              <b-form-group
                label-for="circular_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('cip.circular')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.circular_id"
                :options="circularList"
                id="circular_id"
                @change="getCircularYear(form.circular_id)"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value="0">{{ circularLoading ? 'Loading...' : $t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Year" vid="year">
              <b-form-group
                label-for="year"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                v-model="form.year_text"
                readOnly
                id="year"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="CIP Sector" vid="cip_sector_id" rules="required|min_value:1">
              <b-form-group
                label-for="cip_sector_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyConfig.cip_sector')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.cip_sector_id"
                :options="cipSectorList"
                id="cip_sector_id"
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
          <b-col sm="6">
            <ValidationProvider name="Attachment" vid="attachment" v-slot="{ errors }" :rules="!id ? 'required': ''">
                <b-form-group
                    class="mb-0"
                    label-for="attachment"
                >
                    <template v-slot:label>
                        {{$t('globalTrans.attachment')}} <span class="text-danger" v-if="!id">*</span>
                        <span v-if="id && form.attachment_old">
                          <a target="_blank" :href="baseUrl + 'download-attachment?file=' + form.attachment_old" title="attachment" class="mr-3"> <i class="ri-download-cloud-fill"></i></a>
                        </span>
                    </template>
                    <b-form-file
                      v-on:change="commonFileUpload"
                      accept="application/pdf,application/doc,application/docx,application/csv"
                      v-model="form.attachment_input"
                      plain
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name_en">
                <template v-slot:label>
                  {{ $t('globalTrans.name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="name_en"
                  v-model="form.name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="name_bn"
                  v-model="form.name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Father Name (En)" vid="father_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="father_name_en">
                <template v-slot:label>
                  {{ $t('globalTrans.father_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="father_name_en"
                  v-model="form.father_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Father Name (Bn)" vid="father_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="father_name_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.father_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="father_name_bn"
                  v-model="form.father_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Email" vid="email" rules="required|email" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-for="email"
              >
              <template v-slot:label>
                {{ $t('globalTrans.email') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email"
                  type="email"
                  v-model="form.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Website" vid="website" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="website">
                <template v-slot:label>
                  {{ $t('cip.web') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="website"
                  v-model="form.website"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Phone No" vid="phone" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="phone">
                <template v-slot:label>
                  {{ $t('globalTrans.phone_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="phone"
                  v-model="form.phone"
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
            <ValidationProvider name="Fax" vid="fax" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="fax">
                <template v-slot:label>
                  {{ $t('cip.fax') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="fax"
                  v-model="form.fax"
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
            <ValidationProvider name="Mobile" vid="mobile" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="mobile">
                <template v-slot:label>
                  {{ $t('globalTrans.mobile') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="mobile"
                  v-model="form.mobile"
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
            <ValidationProvider name="FBCCI Designation (En)" vid="fbcci_designation_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="fbcci_designation_en">
                <template v-slot:label>
                  {{ $t('cip.fbcci_designation_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="fbcci_designation_en"
                  v-model="form.fbcci_designation_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="FBCCI Designation (Bn)" vid="fbcci_designation_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="fbcci_designation_bn">
                <template v-slot:label>
                  {{ $t('cip.fbcci_designation_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="fbcci_designation_bn"
                  v-model="form.fbcci_designation_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Referred Association (En)" vid="referred_association_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="referred_association_en">
                <template v-slot:label>
                  {{ $t('cip.referred_association_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="referred_association_en"
                  v-model="form.referred_association_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Referred Association (Bn)" vid="referred_association_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="referred_association_bn">
                <template v-slot:label>
                  {{ $t('cip.referred_association_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="referred_association_bn"
                  v-model="form.referred_association_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Tin No" vid="tin_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name_en">
                <template v-slot:label>
                  {{ $t('externalUser.tin_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="tin_no"
                  v-model="form.tin_no"
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
            <ValidationProvider name="Bin No" vid="bin_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="bin_no">
                <template v-slot:label>
                  {{ $t('externalUser.bin_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="bin_no"
                  v-model="form.bin_no"
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
            <ValidationProvider name="Present Address (En)" vid="address_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('globalTrans.present_address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="address_en"
                  v-model="form.address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Present Address (Bn)" vid="present_address" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="present_address">
                <template v-slot:label>
                  {{ $t('globalTrans.present_address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="present_address"
                  v-model="form.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Organization address (En)" vid="org_address_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="org_address_en">
                <template v-slot:label>
                  {{ $t('cip.org_address') }}{{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="org_address_en"
                  v-model="form.org_address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Organization address (Bn)" vid="org_address_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="org_address_bn">
                <template v-slot:label>
                  {{ $t('cip.org_address') }}{{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="org_address_bn"
                  v-model="form.org_address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Bangladesh Bank Comment" vid="bb_comment">
              <b-form-group
                label-for="bb_comment">
                <template v-slot:label>
                  {{ $t('cip.bb_comment') }}
                </template>
                <b-form-textarea
                  id="bb_comment"
                  v-model="form.bb_comment"
                ></b-form-textarea>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="NBR Comment" vid="nbr_comment">
              <b-form-group
                label-for="nbr_comment">
                <template v-slot:label>
                  {{ $t('cip.nbr_comment') }}
                </template>
                <b-form-textarea
                  id="nbr_comment"
                  v-model="form.nbr_comment"
                ></b-form-textarea>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Ministry of Home Affairs (S B) Comment" vid="moha_sb_comment">
              <b-form-group
                label-for="moha_sb_comment">
                <template v-slot:label>
                  {{ $t('cip.moha_sb_comment') }}
                </template>
                <b-form-textarea
                  id="moha_sb_comment"
                  v-model="form.moha_sb_comment"
                ></b-form-textarea>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Ministry of Home Affairs (NSI) Comment" vid="moha_nsi_comment">
              <b-form-group
                label-for="moha_nsi_comment">
                <template v-slot:label>
                  {{ $t('cip.moha_nsi_comment') }}
                </template>
                <b-form-textarea
                  id="moha_nsi_comment"
                  v-model="form.moha_nsi_comment"
                ></b-form-textarea>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
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
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipTradeStoreApi, cipTradeUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      baseUrl: exportTrophyCIPServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        cip_sector_id: 0,
        circular_id: 0,
        name_en: '',
        name_bn: '',
        fbcci_designation_en: '',
        fbcci_designation_bn: '',
        referred_association_en: '',
        referred_association_bn: '',
        address_en: '',
        address_bn: '',
        year: '',
        year_text: '',
        tin_no: '',
        bin_no: '',
        attachment_input: [],
        attachment: '',
        attachment_old: '',
        father_name_en: '',
        father_name_bn: '',
        email: '',
        website: '',
        phone: '',
        fax: '',
        mobile: '',
        org_address_en: '',
        org_address_bn: '',
        bb_comment: '',
        nbr_comment: '',
        moha_sb_comment: '',
        moha_nsi_comment: ''
      },
      circularList: [],
      isFileLarge: false
    }
  },
  created () {
    this.getCircularList()
    if (this.id) {
      const tmp = this.getCipTrade()
      tmp.attachment_old = tmp.attachment
      tmp.attachment_input = []
      tmp.attachment = ''
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    cipSectorList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.filter(item => item.cip_category === 2)
    }
  },
  methods: {
    commonFileUpload (e) {
      const bytesize = e.target.files[0].size
      const kbsize = bytesize / 1024
      if (kbsize > 2048) {
        this.form.attachment_input = []
        this.form.attachment = ''
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('externalUser.filesize'),
          color: '#ee5253'
        })
        return
      }
      const input = e.target
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

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${cipTradeUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, cipTradeStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
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
    getCipTrade () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      const finalData = Object.assign(tmpData, { year_text: this.$n(tmpData.year, { useGrouping: false }) })
      return JSON.parse(JSON.stringify(finalData))
    },
    async getCircularList () {
      this.circularLoading = true
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, 'circular/all-list')
      if (result.success) {
        this.circularList = result.data.map((obj) => {
          return Object.assign({}, obj, {
            text: this.$i18n.locale === 'en' ? obj.text_en : obj.text_bn
          })
        })
      } else {
        this.circularList = []
      }
      this.circularLoading = false
    },
    getCircularYear (id) {
      const circular = this.circularList.find(item => item.value === id)
      this.form.year = circular.year
      this.form.year_text = this.$n(circular.year, { useGrouping: false })
    }
  }
}
</script>
