<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization Type" vid="organization_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="organization_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('configuration.organization_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.organization_type_id"
                :options="organizationType"
                id="organization_type_id"
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
            <ValidationProvider name="Organization Sub Type (En)" vid="organization_sub_type_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="organization_sub_type_en">
                <template v-slot:label>
                  {{ $t('configuration.organization_sub_type') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="organization_sub_type_en"
                  v-model="form.organization_sub_type_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization Sub Type (Bn)" vid="organization_sub_type_bn" v-slot="{ errors }">
              <b-form-group
                label-for="organization_sub_type_bn">
                <template v-slot:label>
                  {{ $t('configuration.organization_sub_type') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="organization_sub_type_bn"
                  v-model="form.organization_sub_type_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
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
import { orgSubTypeNameStoreApi, orgSubTypeNameUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        organization_type_id: 0,
        organization_type_en: '',
        organization_sub_type_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getLawEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    organizationType () {
        return this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${orgSubTypeNameUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, orgSubTypeNameStoreApi, this.form)
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
