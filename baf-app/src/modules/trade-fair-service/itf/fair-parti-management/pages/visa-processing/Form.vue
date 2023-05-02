<template>
  <b-row>
    <b-col class="mb-3">
        <h5 class="text-center mb-3">{{ $i18n.locale == 'en' ? visa_data.fair_name_en : visa_data.fair_name_bn }}</h5>
        <!-- <div class="text-center mb-2">{{ $i18n.locale == 'en' ? visa_data.fiscal_year_en : visa_data.fiscal_year_bn }}</div> -->
        <h6 class="text-center font-weight-bold">{{ visa_data ? $t('tradeFairConfig.visa_related_info') : $t('tradeFairConfig.visa_related_attach') }}</h6>
    </b-col>
    <b-col v-if="visa_data?.visa_info" xs="12" sm="12" md="12" lg="12" xl="12">
        <visa-info :visa_detail="visa_data" :baseUrl="baseUrl" />
    </b-col>
    <b-col v-else xs="12" sm="12" md="12" lg="12" xl="12">
      <p class="text-center">{{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is PDF/JPEG/JPG]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট PDF/JPEG/JPG]' }}</p>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
          <b-form id="form" @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
            <div v-for="(visa, index) in docs" :key="index" class="p-2 mb-2" style="border: 1px solid #ddd">
              <b-row>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider :name="$t('globalTrans.document_name', 'en') + ' ' + '(En)'" :vid="'docs.'+index+'.doc_name_en'" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-cols-sm="6"
                        label-for="doc_name_en">
                        <template v-slot:label>
                          {{ $t('globalTrans.document_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          class="mb-0"
                          :name="'docs['+index+'][doc_name_en]'"
                          v-model="visa.doc_name_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider :name="$t('globalTrans.document_name', 'en') + ' ' + '(Bn)'" :vid="'docs.'+index+'.doc_name_bn'" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-cols-sm="6"
                        label-for="doc_name_bn">
                        <template v-slot:label>
                          {{ $t('globalTrans.document_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          class="mb-0"
                          :name="'docs['+index+'][doc_name_bn]'"
                          v-model="visa.doc_name_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xl="6" lg="6" sm="12">
                      <ValidationProvider :name="$t('globalTrans.attachment', 'en')" :vid="'docs.'+index+'.attachment'" rules="required"
                          v-slot="{ errors }"
                      >
                          <b-form-group class="row mb-0"
                              label-cols-sm="6"
                              label-for="attachment">
                              <template v-slot:label>
                                  {{ $t('globalTrans.attachment')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-file
                                  plain
                                  :name="'docs['+index+'][attachment]'"
                                  v-model="visa.attachment_input"
                                  accept=".jpg,.jpeg,.pdf"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-file>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col xl="6" lg="6" sm="12">
                    <div class="d-flex">
                      <b-button v-if="index !== 0" @click="deleteDocument(index)" size="sm" class="action-btn btn-danger mr-1" :title="$t('globalTrans.reject')"><i class="ri-close-line"></i></b-button>
                      <b-button :title="$t('globalTrans.add')" v-if="docs.length-1 === index" @click="addDocument()" class="btn-sm btn btn-success"><i class="ri-add-line m-0"></i></b-button>
                    </div>
                  </b-col>
              </b-row>
            </div>
            <b-row>
              <b-col sm="12">
                <ValidationProvider name="Comments" vid="comments" rules="">
                  <b-form-group
                    label-for="comments"
                    slot-scope="{ errors }"
                  >
                    <template v-slot:label>
                      {{ $t('globalTrans.comments') }}
                    </template>
                    <b-form-textarea
                        id="comments"
                        v-model="remarks"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
            <b-row class="text-right">
              <b-col class="mt-2 text-right">
                  <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                  <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-2')">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </b-overlay>
      </ValidationObserver>
    </b-col>
  </b-row>
</template>
<script>
import VisaInfo from './VisaInfo'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { visaDocsStoreApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    VisaInfo
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      baseUrl: internationalTradeFairServiceBaseUrl,
      visa_data: {},
      remarks: '',
      docs: [
        {
          doc_name_en: '',
          doc_name_bn: '',
          attachment: '',
          attachment_input: []
        }
      ]
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getStoreData()
      this.visa_data = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    deleteDocument (i) {
        this.docs = this.docs.filter((_, index) => index !== i)
    },
    addDocument () {
      this.docs.push({
        doc_name_en: '',
        doc_name_bn: '',
        attachment: '',
        attachment_input: []
      })
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const config = { headers: { 'content-type': 'multipart/form-data' } }
      var formData = new FormData(document.getElementById('form'))
      formData.append('participation_id', this.id)
      formData.append('author_remarks', this.remarks)

      if (this.id) {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, visaDocsStoreApi, formData, config)
      }
      if (result.success) {
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-2')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getStoreData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
