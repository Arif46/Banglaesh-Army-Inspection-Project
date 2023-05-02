<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
            <b-form-group
              label-for="org_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('organogram.org')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.org_id"
              :options="orgList"
              id="org_id"
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
        <b-col sm="12">
          <ValidationProvider name="Document Category" vid="category" rules="required|min_value:1">
            <b-form-group
              label-for="category"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{ $t('docuement_management.category') }} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="form.category_id"
              :options="documentCategoryList"
              id="designation_id"
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
        <b-col sm="12">
          <ValidationProvider name="Document title (En)" vid="doc_title" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="document_title_en">
              <template v-slot:label>
                {{ $t('docuement_management.document_title_en') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="document_title_en"
                v-model="form.doc_title"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider name="Document Title (Bn)" vid="doc_title_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="doc_title_bn">
              <template v-slot:label>
                {{ $t('docuement_management.document_title_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="doc_title_bn"
                v-model="form.doc_title_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
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
import { documentStore, documentUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        doc_title: '',
        doc_title_bn: '',
        org_id: 0,
        category_id: 0,
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
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    documentCategoryList () {
      return this.$store.state.CommonService.commonObj.documentCategoryList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    getDesignationList (orgId) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === orgId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
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
        result = await RestApi.putData(commonServiceBaseUrl, `${documentUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, documentStore, this.form)
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
