<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Title (En)" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="title_en">
              <template v-slot:label>
                {{ $t('rjscAdminPortal.title_en') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="title_en"
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
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="title_bn">
                <template v-slot:label>
                {{ $t('rjscAdminPortal.title_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                id="title_bn"
                v-model="form.title_bn"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Attachment" vid="attachment" rules="required" v-slot="{ errors }">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="attachment"
                >
                <template v-slot:label>
                  {{ $t('committee.attachment') }}<span class="text-danger">*</span><span style="font-size:12px" class="text-danger">{{ $t('rjscAdminPortal.attachement_status') }}</span>
                </template>
                <b-input-group>
                  <b-form-file
                   validate="size:10"
                    id="attachment"
                    v-model="form.attachment"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here"
                    drop-placeholder="Drop file here..."
                  ></b-form-file>
                 <b-input-group-append v-if="form.attachment">
                    <a target="_blank" :href="rjscServiceBaseUrl+form.attachment" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                  </b-input-group-append>
                </b-input-group>
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
import { lawEntryStore, lawEntryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      rjscServiceBaseUrl: rjscServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        title_en: '',
        title_bn: '',
        attachment: ''
      },
      fileValidationMsz: '',
      value: ''
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
      const input = event.target
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
        result = await RestApi.putData(rjscServiceBaseUrl, `${lawEntryUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, lawEntryStore, this.form)
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
          this.$toast.error({
            title: 'Error',
            message: result.errors.attachment[0],
            color: '#FF0000'
          })
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
