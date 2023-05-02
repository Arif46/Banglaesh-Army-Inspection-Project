<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="12">
            <ValidationProvider name="CIP Category" vid="cip_category" rules="required|min_value:1">
              <b-form-group
                label-for="cip_category"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyConfig.cip_category')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.cip_category"
                :options="cipCategoryList"
                id="cip_category"
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
            <ValidationProvider name="CIP Sector (En)" vid="sector_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="sector_name_en">
                <template v-slot:label>
                  {{ $t('exportTrophyConfig.cip_sector_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="sector_name_en"
                  v-model="form.sector_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="CIP Sector (Bn)" vid="sector_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="sector_name_bn">
                <template v-slot:label>
                  {{ $t('exportTrophyConfig.cip_sector_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="sector_name_bn"
                  v-model="form.sector_name_bn"
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
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipSectorStoreApi, cipSectorUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        cip_category: 0,
        sector_name_en: '',
        sector_name_bn: ''
      },
      cipCategories: [
        {
          value: 1,
          text: 'CIP Export',
          text_en: 'CIP Export',
          text_bn: 'সিআইপি রপ্তানি'
        },
        {
          value: 2,
          text: 'CIP Trade',
          text_en: 'CIP Trade',
          text_bn: 'সিআইপি ট্রেড'
        }
      ]
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCipSectorPanel()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    cipCategoryList: function () {
      return this.cipCategories.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${cipSectorUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, cipSectorStoreApi, this.form)
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
    getCipSectorPanel () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
