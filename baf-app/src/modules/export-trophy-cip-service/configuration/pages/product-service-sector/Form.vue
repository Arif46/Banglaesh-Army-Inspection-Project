<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xl="12" lg="12" sm="12">
          <ValidationProvider name="Assign For" vid="assign_array" rules="required|min:1">
            <b-form-group
                label-for="assign_array"
                slot-scope="{ valid, errors }"
                label-cols-sm="4"
                label-class="text-right mr-4 p-0"
              >
              <template v-slot:label>
                {{ $t('exportTrophyConfig.assign_for') }} <span class="text-danger">*</span>
              </template>
                <b-form-checkbox-group
                  class="text-left"
                  :disabled="!id ? false : true"
                  v-model="form.assign_array"
                  :options="assignTypeList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-checkbox-group>
                <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xl="12" lg="12" sm="12">
          <ValidationProvider name="Type" vid="type" rules="required|min:1">
            <b-form-group
                label-for="type"
                slot-scope="{ valid, errors }"
                label-cols-sm="4"
                label-class="text-right mr-4 p-0"
              >
              <template v-slot:label>
                {{ $t('globalTrans.type') }} <span class="text-danger">*</span>
              </template>
                <b-form-radio-group
                  class="text-left"
                  v-model="form.type"
                  :options="productServiceTypeList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row class="mt-2">
        <b-col lg="6" md="6" sm="12">
          <ValidationProvider :name="(form.type === 1 ? 'Product Sector Name' : 'Service Sector Name') + ' (En)'" vid="sector_name_en" rules="required">
            <b-form-group
              label-for="sector_name_en"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ (form.type === 1 ? $t('exportTrophyConfig.product_sector_name') : $t('exportTrophyConfig.service_sector_name')) + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
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
        <b-col lg="6" md="6" sm="12">
          <ValidationProvider :name="(form.type === 1 ? 'Product Sector Name' : 'Service Sector Name') + ' (Bn)'" vid="sector_name_bn" rules="required">
            <b-form-group
              label-for="sector_name_bn"
              slot-scope="{ valid, errors }"
            >
              <template v-slot:label>
                {{ (form.type === 1 ? $t('exportTrophyConfig.product_sector_name') : $t('exportTrophyConfig.service_sector_name')) + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
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
      <b-row>
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Description (En)" vid="description_en">
            <b-form-group
              label-for="description_en"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
            {{$t('globalTrans.description_en')}}
            </template>
              <b-form-textarea
                id="description_en"
                v-model="form.description_en"
                :state="errors[0] ? false : (valid ? true : null)"
                rows="4"
                ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col xl="6" lg="6" sm="12">
          <ValidationProvider name="Description (Bn)" vid="description_bn">
            <b-form-group
              label-for="description_bn"
              slot-scope="{ valid, errors }"
              v-bind:star-size="90"
            >
            <template v-slot:label>
            {{$t('globalTrans.description_bn')}}
            </template>
              <b-form-textarea
                id="descriptionbn"
                v-model="form.description_bn"
                :state="errors[0] ? false : (valid ? true : null)"
                rows="4"
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
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { masterSectorStoreApi, masterSectorUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        assign_array: [],
        type: 1,
        sector_name_en: '',
        sector_name_bn: '',
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getSector()
      this.form = tmp
      this.form.assign_for = tmp.assign_for
      this.form.assign_array = []
      this.form.assign_array.push(tmp.assign_for)
    }
  },
  computed: {
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${masterSectorUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, masterSectorStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('ExportTrophyCipService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        if (result.code === 422) {
          const errObj = {
            sector_name_en: ['The sector name en has already been taken.']
          }
          this.$refs.form.setErrors(errObj)
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    },
    getSector () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
