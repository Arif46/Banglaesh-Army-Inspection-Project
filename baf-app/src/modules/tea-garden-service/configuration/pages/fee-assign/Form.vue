<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="faeeType.service_id"
                :options="portalServiceNameList"
                id="service_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="fee Type" vid="fee_type_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="fee_type_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.fee_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="faeeType.fee_type_id"
                      :options="feeTypesList"
                      id="fee_type_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="amount">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.fee_amount') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="amount"
                  min="0"
                  type="number"
                  v-model="faeeType.amount"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <ValidationProvider name="Custom Amount" vid="custom_amount">
              <b-form-group
                label-for="custom_amount">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.custom_amount') }}
                </template>
                <b-form-input
                  id="custom_amount"
                  type="number"
                  min="0"
                  v-model="faeeType.custom_amount"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Effective From" vid="effective_from" rules="required">
              <b-form-group
                class="row"
                label-for="effective_from"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.effective_from') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="effective_from"
                  v-model="faeeType.effective_from"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="config"
                  :locale="currentLocale"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="faeeType.description_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="faeeType.description_bn"
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { feeAssignStoreApi, feeAssignUpdateApi } from '../../api/routes'
import { helpers } from '@/utils/helper-functions'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      config: { static: true },
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      faeeType: {
        service_id: 0,
        fee_type_id: 0,
        amount: '',
        effective_from: helpers.currentDate(),
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getfaeeType()
      this.faeeType = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    portalServiceNameList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
    },
    currentLocale () {
        return this.$i18n.locale
    },
    feeTypesList: function () {
      return this.$store.state.TeaGardenService.commonObj.feeTypesList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${feeAssignUpdateApi}/${this.id}`, this.faeeType)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, feeAssignStoreApi, this.faeeType)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getfaeeType () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
