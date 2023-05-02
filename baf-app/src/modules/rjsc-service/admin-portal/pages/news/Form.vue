<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="News Title (En)" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="2"
                label-for="title_en">
              <template v-slot:label>
                {{ $t('globalTrans.title') }} <span class="text-danger">*</span>
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
            <ValidationProvider name="News Title (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                class="row"
                label-cols-sm="2"
                label-for="title_bn">
                <template v-slot:label>
                {{ $t('globalTrans.title_bn') }} <span class="text-danger">*</span>
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Thumbnail" vid="image" rules="required" v-slot="{ errors }">
                <b-form-group
                  class="row"
                  label-cols-sm="2"
                  label-for="image"
                >
                <template v-slot:label>
                  {{ $t('globalTrans.image') }}<span class="text-danger">*</span>
                </template>
                <b-input-group>
                  <b-form-file
                   validate="size:10"
                    id="image"
                    v-model="form.image"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here"
                    drop-placeholder="Drop file here..."
                  ></b-form-file>
                 <b-input-group-append v-if="form.image && id">
                    <a target="_blank" :href="rjscServiceBaseUrl + 'storage/' + form.image" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                  </b-input-group-append>
                </b-input-group>
                <div class="d-block invalid-feedback">
                  <!-- {{ errors[0] }} -->
                  {{ fileValidationMsz ? fileValidationMsz : $t('rjscAdminPortal.image_status') }}
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
import { newsStore, newsUpdate } from '../../api/routes'
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
        description_en: '',
        description_bn: '',
        image: ''
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
      const input = event.target
      const file = input.files[0]
      if (file.size > 1024 * 2048) {
        e.preventDefault()
        this.fileValidationMsz = 'Maximum file size must be 2MB'
      }
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.image = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.image = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${newsUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, newsStore, this.form)
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
