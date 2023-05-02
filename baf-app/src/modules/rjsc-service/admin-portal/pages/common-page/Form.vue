<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment Name (En)" vid="attachment_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name_en">
                <template v-slot:label>
                  {{ $t('rjscAdminPortal.attachment_name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="attachment_name_en"
                  v-model="form.attachment_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment Name (Bn)" vid="attachment_name_bn" v-slot="{ errors }">
              <b-form-group
                label-for="attachment_name_bn">
                <template v-slot:label>
                  {{ $t('rjscAdminPortal.attachment_name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="attachment_name_bn"
                  v-model="form.attachment_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Menu" vid="menu_id" v-slot="{ errors }">
              <b-form-group
                label-for="menu_id">
                <template v-slot:label>
                  {{ $t('sideBar.menu') }}
                </template>
                <b-form-select
                  id="menu_id"
                  v-model="form.menu_id"
                  :options="menuList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>

          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment">
                <b-form-group
                  label-for="attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.attachment')}} <span class="text-danger">{{$t('rjscAdminPortal.only_pdf')}}</span>
                </template>
                <b-input-group>
                 <b-form-file
                    validate="size:10"
                    id="attachment"
                    accept="application/pdf"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here"
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                  <b-input-group-append v-if="form.attachment && attachmentShow">
                      <a target="_blank" :href="rjscServiceBaseUrl + form.attachment" style="padding: 2px 10px;" class="btn btn-primary btn-sm"><i class="ri-download-2-line"></i></a>
                  </b-input-group-append>
                  <b-button type="button" v-if="form.attachment && attachmentShow" variant="success" class="mr-2 btn-sm" style="padding: 2px 10px;" @click="deleteAttachment()"><i class="fa fa-trash" aria-hidden="true" title="Delete Attachment"></i></b-button>
              </b-input-group>
                <div class="d-block invalid-feedback">
                  <!-- {{ errors[0] }} -->
                  {{ fileValidationMsz }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Details (En)" vid="details_en" rules="required" v-slot="{ errors }">
              <b-form-group
                  label-for="details_en"
              >
              <template v-slot:label>
                  {{$t('globalTrans.details')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span><span class="text-danger">{{$t('rjscAdminPortal.allow_size')}}</span>
              </template>
              <vue-editor
                  id="details_en"
                  v-model="form.details_en"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></vue-editor>
              <div class="invalid-feedback d-block">
                  {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Details (Bn)" vid="details_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                  label-for="details_bn"
              >
              <template v-slot:label>
                  {{$t('globalTrans.details')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span><span class="text-danger"></span><span class="text-danger">{{$t('rjscAdminPortal.allow_size')}}</span>
              </template>
              <vue-editor
                  id="details_bn"
                  v-model="form.details_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></vue-editor>
              <div class="invalid-feedback d-block">
                  {{ errors[0] }}
              </div>
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
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { commonPageStore, commonPageUpdate, deleteAttachment } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      attachmentShow: false,
      rjscServiceBaseUrl: rjscServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        menu_id: '',
        attachment_name_en: '',
        attachment_name_bn: '',
        details_en: '',
        details_bn: '',
        attachment: null
      },
      fileValidationMsz: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMenu()
      this.form = tmp
    }
  },
  computed: {
    menuList: function () {
      return this.$store.state.RjscService.commonObj.menuList.filter(el => el.page_type === 2 && el.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (e) {
      this.fileValidationMsz = ''
      const input = e.target
      const fileType = e.target.value
      const file = input.files[0]

      var upld = fileType.split('.').pop()
      if (upld !== 'pdf') {
        this.fileValidationMsz = this.$t('rjscAdminPortal.only_pdf')
      } else if (file.size > 1024 * 2048) {
        e.preventDefault()
        this.fileValidationMsz = 'Maximum file size must be 2MB'
      }

      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = null
      }
      this.attachmentShow = false
    },
    async deleteAttachment () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const params = Object.assign({}, { attachment: this.form.attachment })
      result = await RestApi.putData(rjscServiceBaseUrl, `${deleteAttachment}/${this.id}`, params)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('RjscService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: result.message,
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$toast.success({
          title: 'Success',
          message: result.message,
          color: '#D6E09B'
        })
        this.$refs.form.setErrors(result.errors)
      }
      this.attachmentShow = false
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${commonPageUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, commonPageStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('RjscService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getMenu () {
      this.attachmentShow = true
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
