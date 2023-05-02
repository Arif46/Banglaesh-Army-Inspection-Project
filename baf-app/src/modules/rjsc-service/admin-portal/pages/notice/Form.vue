<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Notice Title (En)" vid="notice_title" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="2"
                label-for="notice_title">
              <template v-slot:label>
                {{ $t('notification.notice_title') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="notice_title"
                v-model="form.title_en"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Notice Title (Bn)" vid="notice_title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="2"
                label-for="notice_title_bn">
                <template v-slot:label>
                {{ $t('notification.notice_title_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                id="notice_title_bn"
                v-model="form.title_bn"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
              <ValidationProvider name="Description (En)" vid="description_en" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="2"
                  label-for="description_en">
                  <template v-slot:label>
                    {{ $t('globalTrans.description_en') }}
                  </template>
                  <b-form-textarea
                    v-model="form.description_en"
                    id="description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                  </b-form-textarea>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
              <ValidationProvider name="Description (En)" vid="description_bn" rules="">
                <b-form-group
                class="row"
              label-cols-sm="2"
                  label-for="description_bn">
                  <template v-slot:label>
                    {{ $t('globalTrans.description_bn') }}
                  </template>
                  <b-form-textarea
                    v-model="form.description_bn"
                    id="description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                  </b-form-textarea>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.attachment')}}
                </template>
                 <b-form-file
                    validate="size:10"
                    id="attachment"
                    v-model="form.attachment"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here"
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="d-block invalid-feedback">
                  <!-- {{ errors[0] }} -->
                  {{ fileValidationMsz }}
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
import { noticeStore, noticeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        title_en: '',
        title_bn: '',
        description_en: '',
        description_bn: '',
        attachment: ''
      },
      fileValidationMsz: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getListData()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (e) {
      this.fileValidationMsz = ''
      const input = e.target
      const file = input.files[0]
      if (file.size > 1024 * 2048) {
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
        this.form.attachment = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${noticeUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, noticeStore, this.form)
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
    getListData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
