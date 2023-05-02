<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="area_of_interest_id" rules="required|min_value:1">
              <b-form-group
                label-for="area_of_interest_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('configuration.area_of_interest')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.area_of_interest_id"
                :options="areaOfInterest"
                id="area_of_interest_id"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name_en">
                <template v-slot:label>
                  {{ $t('configuration.name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="name_en"
                  v-model="form.name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Name (Bn)" vid="name_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="name_bn">
                <template v-slot:label>
                  {{ $t('configuration.name') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="name_bn"
                  v-model="form.name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Designation (en)" vid="designation" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="designation">
                <template v-slot:label>
                  {{ $t('configuration.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="designation"
                  v-model="form.designation"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Designation (Bn)" vid="designation_bn" v-slot="{ errors }">
              <b-form-group
                label-for="designation_bn">
                <template v-slot:label>
                  {{ $t('configuration.designation') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="designation_bn"
                  v-model="form.designation_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization (En)" vid="organization" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="organization">
                <template v-slot:label>
                  {{ $t('configuration.organization') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="organization"
                  v-model="form.organization"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization (Bn)" vid="organization_bn" v-slot="{ errors }">
              <b-form-group
                label-for="organization_bn">
                <template v-slot:label>
                  {{ $t('configuration.organization') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="organization_bn"
                  v-model="form.organization_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Contact No" vid="contact_no" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="contact_no">
                <template v-slot:label>
                  {{ $t('configuration.contact_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_no"
                  type="number"
                  v-model="form.contact_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Email" vid="email" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="email">
                <template v-slot:label>
                  {{ $t('configuration.email') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email"
                  v-model="form.email"
                  type="email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Area Of Specialization (En)" vid="area_of_specialization_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="area_of_specialization">
                <template v-slot:label>
                  {{ $t('configuration.area_of_specialization') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="area_of_specialization"
                    rows="3"
                    v-model="form.area_of_specialization_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Area Of Specialization (Bn)" vid="area_of_specialization_bn" v-slot="{ errors }">
              <b-form-group
                label-for="area_of_specialization">
                <template v-slot:label>
                  {{ $t('configuration.area_of_specialization') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="area_of_specialization"
                    rows="3"
                    v-model="form.area_of_specialization_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="General Expertise (En)" vid="general_expertise_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="general_expertise_en">
                <template v-slot:label>
                  {{ $t('configuration.general_expertise') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="general_expertise_en"
                    rows="3"
                    v-model="form.general_expertise_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="General Expertise (Bn)" vid="general_expertise_bn" v-slot="{ errors }">
              <b-form-group
                label-for="general_expertise_bn">
                <template v-slot:label>
                  {{ $t('configuration.general_expertise') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="general_expertise_bn"
                    rows="3"
                    v-model="form.general_expertise_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Image" vid="image"  :rules="id ? '' : 'required'" v-slot="{ errors }">
                <b-form-group
                  label-for="photo"
                >
                <template v-slot:label>
                  {{ $t('configuration.image')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-file
                    id="upload_image"
                    v-on:change="handlePhoto"
                    accept=".png,.jpeg,.jpg"
                    v-model="form.image"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
          <ValidationProvider name="Attachment" vid="attachment" :rules="id ? '' : 'required'" v-slot="{ errors }">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('configuration.curriculum_vitae') }} <span class="text-danger">*</span>
                </template>
                <b-form-file
                    id="attachment"
                    v-model="form.file"
                    @change="onChange"
                    accept=".pdf"
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
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { resourcePoolStoreApi, resourcePoolUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        area_of_interest_id: 0,
        name_en: '',
        name_bn: '',
        designation: '',
        designation_bn: '',
        organization: '',
        organization_bn: '',
        contact_no: '',
        email: '',
        area_of_specialization_en: '',
        area_of_specialization_bn: '',
        general_expertise_bn: '',
        general_expertise_en: '',
        image: [],
        curriculum: []
      },
      upload_image: [],
      upload_curriculum: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getLawEntry()
      this.form = tmp
      this.form.oldImage = tmp.image
      this.form.oldFile = tmp.curriculum_vitae
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    areaOfInterest () {
        return this.$store.state.BftiResearchAndReportService.commonObj.areaOfInterestList.filter(item => item.status === 1)
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
     handlePhoto (e) {
      const selectedPhoto = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.image = event.target.result
      }
      reader.readAsDataURL(selectedPhoto)
    },
    onFileChange (e) {
      this.image = e.target.files[0]
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${resourcePoolUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, resourcePoolStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
