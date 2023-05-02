<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="commodity_group_id">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.commodity_group') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="commodity_group_id"
                  :options="commodityGroupList"
                  v-model="commodityGroup.commodity_group_id"
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
        </b-row>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Commodity Name (En)" vid="commodity_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="category_name_en">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.commodity_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="commodity_name_en"
                  v-model="commodityGroup.commodity_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Commodity Name (Bn)" vid="commodity_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="commodity_name_bn">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.commodity_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="commodity_name_bn"
                  v-model="commodityGroup.commodity_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
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
                  {{ $t('bazarMonitoring.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="commodityGroup.description_en"
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
                  {{ $t('bazarMonitoring.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="commodityGroup.description_bn"
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
import { commodityNameStore, commodityNameUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      commodityGroup: {
        commodity_name_en: '',
        commodity_name_bn: '',
        description_en: '',
        description_bn: '',
        commodity_group_id: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCommodityGroup()
     this.commodityGroup = Object.assign({}, this.commodityGroup, tmp)
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
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${commodityNameUpdate}/${this.id}`, this.commodityGroup)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, commodityNameStore, this.commodityGroup)
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
    getCommodityGroup () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
