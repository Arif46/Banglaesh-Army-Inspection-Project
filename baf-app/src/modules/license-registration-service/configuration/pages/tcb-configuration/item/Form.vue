<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.org_id"
                :options="orgProfileList"
                id="org_id"
                :state="errors[0] ? false : (valid ? true : null)"
                :disabled="true"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Item Category" vid="item_category_id" rules="required|min_value:1">
              <b-form-group
                label-for="item_category_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('tcbconfiguration.item_category')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.item_category_id"
                :options="itemCategoryList"
                id="item_category_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Item Name (En)" vid="item_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.item_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="item_name_en"
                  v-model="form.item_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Item Name (Bn)" vid="item_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading_bn">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.item_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="item_name_bn"
                  v-model="form.item_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Unit Actual Value" vid="unit_actual_value" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="unit_actual_value">
                <template v-slot:label>
                  {{ $t('tcbconfiguration.unit_actual_value') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="unit_actual_value"
                  type="number"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  v-model.number="form.unit_actual_value"
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { itemStore, itemUpdate } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 7,
        item_category_id: 0,
        item_name_en: '',
        item_name_bn: '',
        unit_actual_value: 1
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getItemEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${itemUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, itemStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
