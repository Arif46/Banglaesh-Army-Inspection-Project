<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form id="form" @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Year" vid="year" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="year">
                <template v-slot:label>
                  {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="year"
                  :options="yearList"
                  v-model="formData.year"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Title" vid="fair_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="fair_id">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fair_id"
                  :options="dhakaFairList"
                  v-model="formData.fair_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Circular type" vid="circular_type" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="circular_type">
                <template v-slot:label>
                  {{ $t('ditfTradeFairManages.circular_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="circular_type"
                  :options="circularTypeList"
                  v-model="formData.circular_type"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <p style="border-bottom: 2px solid #ddd;"> {{ $t('ditfTradeFairManages.circular_info') }} </p>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Circular Memo No" vid="circular_memo_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="circular_memo_no">
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.circular_memo_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="circular_memo_no"
                  v-model="formData.circular_memo_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (En)" vid="title_en" rules="required|max:255" v-slot="{ errors }">
              <b-form-group
                label-for="Title">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_en"
                  v-model="formData.title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required|max:255" v-slot="{ errors }">
              <b-form-group
                label-for="Title">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="formData.title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="formData.description_en"
                  rows="3"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="formData.description_bn"
                  rows="3"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Submition Deadline" vid="deadline" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('tradeFairInfoManagement.submission_deadline') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="deadline"
                  class="form-control"
                  v-model="formData.deadline"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                  :config="{ static: true }"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="id">
            <p style="border-bottom: 2px solid #ddd; margin-bottom: 10px;"> {{ $t('ditfTradeFairManages.old_attachment_info') }} </p>
          </b-col>
          <div v-if="id">
          <b-table-simple v-if="formData.docs_details.length" bordered hover small>
            <b-thead>
                <b-tr class="bg-primary">
                    <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th>{{ $t('globalTrans.document_name') }}</b-th>
                    <b-th style="width:15%" class="text-center">{{ $t('globalTrans.attachment') }}</b-th>
                    <b-th style="width:15%" class="text-center">{{ $t('ditfTradeFairManages.remove') }}</b-th>
                </b-tr>
            </b-thead>
            <b-tbody>
                <b-tr v-for="(item, index) in formData.docs_details" :key="index">
                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                    <b-td>{{ $i18n.locale === 'en' ? item.doc_name_en : item.doc_name_bn }}</b-td>
                    <b-td class="text-center">
                        <a target="_blank" v-if="item.attachment" :href="internationalTradeFairServiceBaseUrl + 'storage/' + item.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                    </b-td>
                    <b-td align="center">
                      <b-button @click="remove(index)" size="sm" class="action-btn btn-danger mr-1" :title="$t('globalTrans.reject')"><i class="ri-close-line"></i></b-button>
                    </b-td>
                </b-tr>
            </b-tbody>
          </b-table-simple>
          </div>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <p style="border-bottom: 2px solid #ddd; margin-bottom: 10px;"> {{ $t('ditfTradeFairManages.attachment_info') }} </p>
            <div v-for="(item, index) in docs" :key="index" class="p-2 mb-2" style="border: 1px solid #ddd">
              <b-row>
                <b-col md="10">
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider :name="$t('globalTrans.document_name', 'en') + ' ' + '(En)'" :vid="'docs.'+index+'.doc_name_en'" :rules="!id ? 'required': ''" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="6"
                          label-for="doc_name_en">
                          <template v-slot:label>
                            {{ $t('globalTrans.document_name') }} {{ $t('globalTrans.en') }} <span class="text-danger" v-if="!id">*</span>
                          </template>
                          <b-form-input
                            class="mb-0"
                            :name="'docs['+index+'][doc_name_en]'"
                            v-model="item.doc_name_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider :name="$t('globalTrans.document_name', 'en') + ' ' + '(Bn)'" :vid="'docs.'+index+'.doc_name_bn'" :rules="!id ? 'required': ''" v-slot="{ errors }">
                        <b-form-group
                          label-cols-sm="6"
                          label-for="doc_name_bn">
                          <template v-slot:label>
                            {{ $t('globalTrans.document_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger" v-if="!id">*</span>
                          </template>
                          <b-form-input
                            class="mb-0"
                            :name="'docs['+index+'][doc_name_bn]'"
                            v-model="item.doc_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xl="12" lg="12" sm="12">
                        <ValidationProvider :name="$t('globalTrans.attachment', 'en')" :vid="'docs.'+index+'.attachment'" :rules="!id ? 'required': ''"
                            v-slot="{ errors }"
                        >
                            <b-form-group class="row mb-0"
                                label-cols-sm="3"
                                label-for="attachment">
                                <template v-slot:label>
                                    {{ $t('globalTrans.attachment')}} <span class="text-danger" v-if="!id">*</span>
                                </template>
                                <b-form-file
                                    plain
                                    :name="'docs['+index+'][attachment]'"
                                    v-model="item.attachment_input"
                                    accept=".jpg,.jpeg,.pdf"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                  </b-row>
                </b-col>
                <b-col md="2" xl="2" lg="2" sm="12">
                  <div class="text-center">
                    <b-button v-if="index !== 0" @click="deleteDocument(index)" size="sm" class="action-btn btn-danger mr-1" :title="$t('globalTrans.reject')"><i class="ri-close-line"></i></b-button>
                    <b-button :title="$t('globalTrans.add')" v-if="docs.length-1 === index" @click="addDocument()" class="btn-sm btn btn-success"><i class="ri-add-line m-0"></i></b-button>
                  </div>
                </b-col>
              </b-row>
            </div>
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
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { prepareCircularStore, prepareCircularUpdate, getStallinfo } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      dhakaFairList: [],
      docs: [
        {
          doc_name_en: '',
          doc_name_bn: '',
          attachment: '',
          attachment_input: []
        }
      ],
      formData: {
        year: 0,
        circular_type: 0,
        fair_id: 0,
        circular_memo_no: '',
        title_en: '',
        title_bn: '',
        description_en: '',
        description_bn: '',
        deadline: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFairPartiCircular()
      this.formData = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    circularTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  watch: {
    'formData.year': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.dhakaFairList = this.dhakaFair()
      }
    },
    'formData.fair_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getStallInfo()
      }
    },
    'formData.circular_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getStallInfo()
      }
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
    remove (index) {
      this.formData.docs_details.splice(index, 1)
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    dhakaFair () {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === this.formData.year).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getStallType (id) {
      const stallObj = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === id)
      if (stallObj !== undefined) {
        return this.currentLocale === 'bn' ? stallObj.text_bn : stallObj.text_en
      }
    },
    getSubsidyCatName (id) {
      const subsidyCatObj = this.$store.state.TradeFairService.commonObj.subsidyCategoryList.find(item => item.value === id)
      if (subsidyCatObj !== undefined) {
        return this.currentLocale === 'bn' ? subsidyCatObj.text_bn : subsidyCatObj.text_en
      }
    },
    getFairSector (sector) {
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getStallInfo (fairId) {
      const param = Object.assign({ year: this.formData.year, fair_id: this.formData.fair_id, circular_type: this.formData.circular_type })
      RestApi.getData(internationalTradeFairServiceBaseUrl, getStallinfo, param).then(response => {
        if (response.success) {
          this.partiCircular = response.partiCircular
          this.formData.fair_circular_id = response.partiCircular.id
          this.partiCir = [{
            value: response.partiCircular.id,
            text: this.currentLocale === 'bn' ? response.partiCircular.subject_bn : response.partiCircular.subject_en
          }]
        } else {
          this.partiCir = []
          this.partiCircular.calendar_info = []
        }
        this.loading = false
      })
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const config = { headers: { 'content-type': 'multipart/form-data' } }
      var formData = new FormData(document.getElementById('form'))

      formData.append('circular_id', this.id)
      formData.append('year', this.formData.year)
      formData.append('circular_type', this.formData.circular_type)
      formData.append('fair_id', this.formData.fair_id)
      formData.append('circular_memo_no', this.formData.circular_memo_no)
      formData.append('title_en', this.formData.title_en)
      formData.append('title_bn', this.formData.title_bn)
      formData.append('description_en', this.formData.description_en)
      formData.append('description_bn', this.formData.description_bn)
      formData.append('deadline', this.formData.deadline)
      if (this.id) {
        formData.append('old_attachment', JSON.stringify(this.formData.docs_details))
      }

      if (this.id) {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, `${prepareCircularUpdate}/${this.id}`, formData, config)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, prepareCircularStore, formData, config)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.loading = false
        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.loading = false
      }
    },
    getFairPartiCircular () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
<style scoped>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
</style>
