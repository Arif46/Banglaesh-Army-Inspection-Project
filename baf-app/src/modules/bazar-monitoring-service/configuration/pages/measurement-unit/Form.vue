<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12">
            <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1">
              <b-form-group
                label-for="commodity_group_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('bazarMonitoring.commodity_group')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.commodity_group_id"
                :options="commodityGroupList"
                id="commodity_group_id"
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
            <ValidationProvider name="Commodity Name" vid="commodity_name_id" rules="required|min_value:1">
              <b-form-group
                label-for="commodity_name_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('bazarMonitoring.commodity_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.commodity_name_id"
                :options="commodityNameList"
                id="commodity_name_id"
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
            <ValidationProvider name="Measurement Unit (En)" vid="unit_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="unit_name_en">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.measurement_unit') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="unit_name_en"
                  v-model="form.unit_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Measurement Unit (Bn)" vid="unit_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="unit_name_bn">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.measurement_unit') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="unit_name_bn"
                  v-model="form.unit_name_bn"
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
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { measurementUnitStore, measurementUnitUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      commodityNameList: [],
      form: {
        commodity_group_id: 0,
        commodity_name_id: 0,
        unit_name_en: '',
        unit_name_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMeasurementUnit()
      this.form = tmp
    }
  },
  watch: {
    'form.commodity_group_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.commodityNameList = this.getCommodityNameList(newVal)
      } else {
        this.commodityNameList = []
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    commodityGroupList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    }
  },
  methods: {
    getCommodityNameList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${measurementUnitUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, measurementUnitStore, this.form)
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
    getMeasurementUnit () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
