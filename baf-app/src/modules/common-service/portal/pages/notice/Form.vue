<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
       <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.title_News')" vid="title" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="title">
              <template v-slot:label>
                {{ $t('moc_portal.title_News') }} <span class="text-danger">*</span>
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
        </b-col>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.title_News_bn')" vid="title_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="title_bn">
              <template v-slot:label>
                {{ $t('moc_portal.title_News_bn') }} <span class="text-danger">*</span>
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
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.description_News')" vid="description" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="description">
              <template v-slot:label>
                {{ $t('moc_portal.description_News') }} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
              rows="3"
              id="description_bn"
              v-model="form.description"
              :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.description_News_bn')" vid="description_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="description_bn">
              <template v-slot:label>
                {{ $t('moc_portal.description_News_bn') }} <span class="text-danger">*</span>
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
        </b-col>
        <b-col sm="12">
          <ValidationProvider name="Attachment" vid="attachment" :rules="id ? '' : 'required'" v-slot="{ errors }">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('docuement_management.attachment') }} <span class="text-danger">*</span>
                </template>
                <b-form-file
                    id="attachment"
                    v-model="form.file"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    placeholder="Choose a file or drop it here..."
                    drop-placeholder="Drop file here..."
                ></b-form-file>
                <div class="invalid-feedback">
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { noticeStoreApi, noticeUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        title: '',
        title_bn: '',
        description: '',
        description_bn: '',
        attachment: '',
        file: []
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDocument()
      this.form = tmp
      this.form.oldfile = tmp.attachment
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (event) {
      const input = event.target
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
        result = await RestApi.putData(commonServiceBaseUrl, `${noticeUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, noticeStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

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
    },
    getDocument () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
