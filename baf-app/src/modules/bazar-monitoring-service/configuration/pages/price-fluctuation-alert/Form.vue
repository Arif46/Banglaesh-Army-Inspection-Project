<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12">
            <ValidationProvider name="Price Category" vid="price_category_id" rules="required|min_value:1">
              <b-form-group
                label-for="price_category_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('bazarMonitoring.Price_category_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.price_category_id"
                :options="priceCategoryList"
                id="price_category_id"
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
          <b-col xs="12" sm="12">
            <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1">
              <b-form-group
                label-for="commodity_group_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('bazarMonitoring.commodity_group_name')}} <span class="text-danger">*</span>
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
          <b-col sm="12">
            <ValidationProvider name="Alert Percentage" vid="alert_percentage" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="alert_percentage">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.alert_percentage') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type='number'
                  id="alert_percentage"
                  v-model="form.alert_percentage"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Note (En)" vid="note_en" v-slot="{ errors }">
              <b-form-group
                label-for="note_en">
                <template v-slot:label>
                  {{ $t('globalTrans.note') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="note_en"
                    rows="3"
                    v-model="form.note_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Note (Bn)" vid="note_bn" v-slot="{ errors }">
              <b-form-group
                label-for="note_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.note') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="note_bn"
                    rows="3"
                    v-model="form.note_bn"
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
import { priceFluctuationAlertStore, priceFluctuationAlertUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        price_category_id: 0,
        commodity_group_id: 0,
        note_en: '',
        note_bn: ''
      }
      // commodityGroupList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getPriceCategory()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    commodityGroupList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    }
  },
  // watch: {
  //   'form.price_category_id': function (newVal, oldVal) {
  //     if (newVal !== oldVal) {
  //       this.commodityGroupList = this.getCommodityGroup()
  //     }
  //   }
  // },
  methods: {
    // getCommodityGroup () {
    //   return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1 && item.price_category_id === this.form.price_category_id).map(itemObj => {
    //     if (this.$i18n.locale === 'bn') {
    //       return { value: itemObj.value, text: itemObj.text_bn }
    //     } else {
    //       return { value: itemObj.value, text: itemObj.text_en }
    //     }
    //   })
    // },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${priceFluctuationAlertUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, priceFluctuationAlertStore, this.form)
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
    getPriceCategory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
