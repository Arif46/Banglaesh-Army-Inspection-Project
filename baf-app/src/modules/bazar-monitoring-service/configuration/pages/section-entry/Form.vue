<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12">
            <ValidationProvider name="Law" vid="law_id" rules="required|min_value:1">
              <b-form-group
                label-for="law_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('bazarMonitoring.law_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.law_id"
                :options="lawEntryList"
                id="law_id"
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
            <ValidationProvider name="Section Number" vid="section_number" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="section_number">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.section_number') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type='number'
                  id="section_number"
                  v-model="form.section_number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12">
            <ValidationProvider name="Section Name (En)" vid="section_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="section_name_en">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.section_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="section_name_en"
                  v-model="form.section_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12">
            <ValidationProvider name="Section Name (Bn)" vid="section_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="section_name_bn">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.section_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="section_name_bn"
                  v-model="form.section_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="description_en"
                    rows="3"
                    v-model="form.description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="description_bn"
                    rows="3"
                    v-model="form.description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
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
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { sectionEntryStore, sectionEntryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        law_id: 0,
        section_name_en: '',
        section_name_bn: '',
        section_number: '',
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getSection()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    lawEntryList () {
      return this.$store.state.BazarMonitoringService.commonObj.lawEntryList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${sectionEntryUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, sectionEntryStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getSection () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
