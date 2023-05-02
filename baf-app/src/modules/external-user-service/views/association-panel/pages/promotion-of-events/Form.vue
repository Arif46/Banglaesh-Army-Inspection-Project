<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <template>
            <div style="font-size:14px; background-color: #17a2b8;border-radius:5px" class="p-1">
                <h6 class="text-white text-left">
                    {{ $t('globalTrans.basic_information') }}
                </h6>
            </div>
          </template>
          <hr>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Advertisement Title (En)" vid="advertisement_title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="advertisement_title_en">
                <template v-slot:label>
                  {{ $t('eBizPromotional.promotion_of_events') }} {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="advertisement_title_en"
                  v-model="form.advertisement_title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Advertisement Title (Bn)" vid="advertisement_title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="advertisement_title_bn">
                <template v-slot:label>
                  {{ $t('eBizPromotional.promotion_of_events') }} {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="advertisement_title_bn"
                  v-model="form.advertisement_title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description En" vid="description_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_en"
              >
              <template v-slot:label>
                {{$t('globalTrans.description')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
              </template>
              <vue-editor
                v-model="form.description_en"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </vue-editor>
              <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description Bn" vid="description_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_bn"
              >
              <template v-slot:label>
                {{$t('globalTrans.description')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
              </template>
              <vue-editor
                v-model="form.description_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </vue-editor>
              <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Start Date" vid="start_date"  rules="required" v-slot="{ errors }">
              <b-form-group
                  label-for="start_date"
              >
                  <template v-slot:label>
                  {{ $t('globalTrans.start_date') }}<span class="text-danger">*</span>
                  </template>
                  <date-picker
                  id="start_date"
                  class="form-control"
                  v-model="form.start_date"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  >
                  </date-picker>
                  <div class="invalid-feedback d-block">
                      {{ errors[0] }}
                  </div>
              </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="End Date" vid="end_date" v-slot="{ errors }">
              <b-form-group
                  label-for="end_date"
              >
                  <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}
                  </template>
                  <date-picker
                  id="end_date"
                  class="form-control"
                  v-model="form.end_date"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  >
                  </date-picker>
                  <div class="invalid-feedback d-block">
                      {{ errors[0] }}
                  </div>
              </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Address En" vid="address_en" rules="required" v-slot="{ errors }">
            <b-form-group
                label-for="address_en">
                <template v-slot:label>
                    {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="address_en"
                    v-model="form.address_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
            </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Address Bn" vid="address_bn" rules="required" v-slot="{ errors }">
            <b-form-group
                label-for="address_bn">
                <template v-slot:label>
                    {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="address_bn"
                    v-model="form.address_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
            </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="URL" vid="url" v-slot="{ errors }">
              <b-form-group
                  label-for="url">
                  <template v-slot:label>
                      {{ $t('globalTrans.url') }}
                  </template>
                  <b-form-input
                      id="url"
                      v-model="form.url"
                      :state="errors[0] ? false : (valid ? true : null)"
                  >
                  </b-form-input>
                  <div class="invalid-feedback">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
                <ValidationProvider name="Expiry Date" vid="expiry_date" v-slot="{ errors }" rules="required">
                <b-form-group
                    label-for="expiry_date"
                >
                    <template v-slot:label>
                    {{ $t('globalTrans.expiry_title') }}<span class="text-danger">*</span>
                    </template>
                    <date-picker
                    id="expiry_date"
                    class="form-control"
                    v-model="form.expiry_date"
                    :class="errors[0] ? 'is-invalid' : ''"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select')"
                    >
                    </date-picker>
                    <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                    </div>
                </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Attachment" vid="attachment" :rules="attachmentReq">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment">
                  <template v-slot:label>
                      {{$t('associationPnl.main_image')}} {{ $t('associationPnl.image_type') }} <span class="text-danger">*</span>
                  </template>
                  <div class="d-flex">
                    <b-form-file accept=".jpeg,.jpg,.png" id="attachment" v-model="form.file"
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
           <!-- <b-col xs="6" sm="6" md="6" lg="6" xl="6">
              <ValidationProvider name="Attachment" vid="attachment1">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment1">
                  <template v-slot:label>
                      {{$t('associationPnl.first_image')}} {{ $t('associationPnl.image_type') }}
                  </template>
                  <div class="d-flex">
                    <b-form-file accept=".jpeg,.jpg,.png" id="attachment1" v-model="form.file1"
                      @change="onFileChange1" :state="errors[0] ? false : (valid ? true : null)"
                      :placeholder="form.attachmentx1 ? form.attachmentx1 : $t('globalTrans.attachment_placeholder')"
                      :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                  </div>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
              <ValidationProvider name="Attachment" vid="attachment2">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment2">
                  <template v-slot:label>
                      {{$t('associationPnl.second_image')}} {{ $t('associationPnl.image_type') }}
                  </template>
                  <div class="d-flex">
                    <b-form-file accept=".jpeg,.jpg,.png" id="attachment2" v-model="form.file2"
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
            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
              <ValidationProvider name="Attachment" vid="attachment3">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment3">
                  <template v-slot:label>
                      {{$t('associationPnl.third_image')}} {{ $t('associationPnl.image_type') }}
                  </template>
                  <div class="d-flex">
                    <b-form-file accept=".jpeg,.jpg,.png" id="attachment3" v-model="form.file3"
                      @change="onFileChange3" :state="errors[0] ? false : (valid ? true : null)"
                      :placeholder="form.attachmentx3 ? form.attachmentx3 : $t('globalTrans.attachment_placeholder')"
                      :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                  </div>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
              <ValidationProvider name="Attachment" vid="attachment4">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment4">
                  <template v-slot:label>
                      {{$t('associationPnl.fourth_image')}} {{ $t('associationPnl.image_type') }}
                  </template>
                  <div class="d-flex">
                    <b-form-file accept=".jpeg,.jpg,.png" id="attachment4" v-model="form.file4"
                      @change="onFileChange4" :state="errors[0] ? false : (valid ? true : null)"
                      :placeholder="form.attachmentx4 ? form.attachmentx4 : $t('globalTrans.attachment_placeholder')"
                      :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                  </div>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>-->
          </b-row>
        <b-row class="text-right">
          <b-col>
          <b-button type="submit" variant="warning" @click="formStatus(1)" class="mr-2 btn-sm">{{ draftBtnName }}</b-button>
              <b-button v-if="$store.state.ExternalUserService.eBizPanel.associationProfile" type="submit" variant="success" @click="formStatus(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { promotionEventAdvertisementStore, promotionEventAdvertisementUpdate } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  components: {
    VueEditor
  },
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.finalSave'),
      errors: [],
      isDisable: false,
      ItemShow: false,
      attachmentReq: 'required',
      draftBtnName: this.$t('globalTrans.draft'),
      form: {
          advertisement_title_en: '',
          advertisement_title_bn: '',
          description_en: '',
          description_bn: '',
          // price: '',
          // offer_price: '',
          url: '',
          expiry_date: '',
          start_date: '',
          end_date: '',
          address_en: '',
          address_bn: '',
          council_info_id: '',
          association_info_id: '',
          file: [],
          attachment_main: ''
            // file1: [],
            // attachment1: '',
            // file2: [],
            // attachment2: '',
            // file3: [],
            // attachment3: '',
            // file4: [],
            // attachment4: ''
      }
    }
  },
  created () {
    if (this.id) {
      this.attachmentReq = ''
      this.isDisable = true
      const tmp = this.getData()
      this.form = tmp
      if (tmp.expiry_date === '0000-00-00') {
         this.form.expiry_date = ''
      }
      if (tmp.start_date === '0000-00-00') {
         this.form.start_date = ''
      }
      if (tmp.end_date === '0000-00-00') {
         this.form.end_date = ''
      }
      this.form.attachmentx = tmp.attachment_main.split('/')[3]
      // this.form.attachmentx1 = tmp.attachment_one.split('/')[3]
      // this.form.attachmentx2 = tmp.attachment_two.split('/')[3]
      // this.form.attachmentx3 = tmp.attachment_three.split('/')[3]
      // this.form.attachmentx4 = tmp.attachment_four.split('/')[3]
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
  currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    }
  },
  methods: {
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
            this.form.attachment1 = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.attachment1 = ''
        }
    },
    onFileChange2 (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.attachment2 = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.attachment2 = ''
        }
    },
    onFileChange3 (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.attachment3 = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.attachment3 = ''
        }
    },
    onFileChange4 (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.form.attachment4 = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.form.attachment4 = ''
        }
    },
    async saveUpdate () {
      const isValid = await this.$refs.form.validate()
      if (isValid) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          if (this.$store.state.ExternalUserService.eBizPanel.associationProfile) {
            this.form.council_info_id = this.$store.state.ExternalUserService.eBizPanel.associationProfile.council_info_id
            this.form.association_info_id = this.$store.state.ExternalUserService.eBizPanel.associationProfile.association_info_id
          }
          if (this.id) {
            result = await RestApi.putData(eBizServiceBaseUrl, `${promotionEventAdvertisementUpdate}/${this.id}`, this.form)
          } else {
            result = await RestApi.postData(eBizServiceBaseUrl, promotionEventAdvertisementStore, this.form)
          }

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
            this.$bvModal.hide('modal-form')
          } else {
            this.$refs.form.setErrors(result.errors)
          }
       }
    },
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
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
