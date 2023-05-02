<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <b-overlay :show="load">
          <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form  @submit.prevent="handleSubmit(register)" @reset.prevent="reset" enctype="multipart/form-data">
              <ValidationProvider :name="$t('moc_portal.title_News')" vid="title" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="title"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{ $t('globalTrans.title')}} {{ $t('globalTrans.en')}}<span class="text-danger">*</span>
                  </template>
                <b-form-input
                    id="title"
                    v-model="form.title"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              <ValidationProvider :name="$t('moc_portal.title_News_bn')" vid="title_bn" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="title_bn"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                    {{ $t('globalTrans.title')}} {{ $t('globalTrans.bn')}}<span class="text-danger">*</span>
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
              <ValidationProvider :name="$t('moc_portal.description_News')" vid="description" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="description"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                    {{ $t('globalTrans.description')}} {{ $t('globalTrans.en')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-textarea
                    rows="3"
                    id="description"
                    v-model="form.description"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              <ValidationProvider :name="$t('moc_portal.description_News_bn')" vid="description_bn" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="description_bn"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                    {{ $t('globalTrans.description')}} {{ $t('globalTrans.bn')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-textarea
                    rows="3"
                    id="description_bn"
                    v-model="form.description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              <ValidationProvider :name="$t('moc_portal.helpline')" vid="helpline" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="helpline"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{ $t('moc_portal.helpline')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="helpline"
                  v-model="form.helpline"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
              <ValidationProvider name="Logo">
                <b-form-group
                  class="row"
                  label-cols-sm="3"
                  label-for="photo"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{ $t('orgProfile.logo')}}
                  </template>
                  <b-form-file
                  id="upload_logo"
                  v-on:change="handlePhoto"
                  accept="image/*"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              <div class="row">
                <div class="col-sm-3"></div>
                <div class="col text-right">
                  <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                  &nbsp;
                  <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                </div>
              </div>
            </b-form>
          </ValidationObserver>
        </b-overlay>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { headerStoreApi, headerUpdateApi } from '../../api/routes'

export default {
  props: ['id'],
  created () {
    if (this.id) {
      const tmp = this.getOrgrofileData()
      // Object.freeze(tmp)
      this.form = tmp
      this.form.pre_logo = tmp.logo
      this.form.logo = null
    }
  },
  mounted () {
  },
  data () {
    return {
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      form: {
        id: null,
        title: '',
        title_bn: '',
        description: '',
        description_bn: '',
        logo: '',
        helpline: ''
      },
      upload_logo: '',
      load: false
    }
  },
  computed: {},
  methods: {
     handlePhoto (e) {
      const selectedPhoto = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.logo = event.target.result
      }
      reader.readAsDataURL(selectedPhoto)
    },
    getOrgrofileData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async register () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: true }
      this.load = true
      if (this.form.id) {
        // formData.append('_method', 'PUT')
        result = await RestApi.putData(commonServiceBaseUrl, `${headerUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, headerStoreApi, this.form)
      }
      this.load = false
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
