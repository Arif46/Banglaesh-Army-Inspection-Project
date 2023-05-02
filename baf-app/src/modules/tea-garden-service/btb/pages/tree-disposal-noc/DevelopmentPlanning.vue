<template>
    <b-row>
      <b-col md="12">
          <ValidationObserver ref="development_planning"  v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                  <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.development_planning_level')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="fiscal_year_id"
                                                        >
                                                    <template v-slot:label>
                                                        {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-select
                                                        plain
                                                        v-model="application.fiscal_year_id"
                                                        :options="fiscalYearList"
                                                        id="fiscal_year_id"
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
                                            <b-col sm="6">
                                                <ValidationProvider name="Amplification / Replacement Planting (Hectares)" vid="expansion_planting" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="expansion_planting"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.expansion_planting') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.expansion_planting"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Re-plantation / Block Infilling (Hectares)" vid="re_plantation" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="re_plantation"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.re_plantation') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.re_plantation"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Rubber (Hectares)" vid="rubber" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="rubber"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.rubber') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.rubber"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Afforestation (Hectares)" vid="afforestation" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="afforestation"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.afforestation') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.afforestation"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Other Plants (Hectares)" vid="other_plants" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="other_plants"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.other_plants') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.other_plants"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                    </b-row>
                  </b-overlay>
              </b-form>
          </ValidationObserver>
      </b-col>
  </b-row>
  </template>
  <script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { treeDisposalAppCuttingDevelopmentStoreApi } from '../../api/routes'
  import { mapGetters } from 'vuex'
  import { helpers } from '@/utils/helper-functions'
  export default {
      props: ['app_id', 'garden_id_set', 'developmentPlanningData', 'draft', 'isShow', 'baseUrl'],
      name: 'DevelopmentPlanning',
      data () {
        return {
              ItemShow: false,
              teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
              fieldObj: {
                  xl: 6,
                  lg: 6,
                  md: 6,
                  sm: 12,
                  labelCols: 5,
                  noAddress: false
              },
              application: {
                id: 0,
                app_id: 0,
                tree_cutting_id: 0,
                fiscal_year_id: 0,
                expansion_planting: null,
                re_plantation: null,
                rubber: null,
                afforestation: null,
                other_plants: null
            },
              valid: null,
              loading: false
          }
      },
      created () {
          this.application = this.developmentPlanningData
      },
      computed: {
          ...mapGetters({
              authUser: 'Auth/authUser'
          }),
          currentLocale () {
              return this.$i18n.locale
          },
          fiscalYearList () {
            return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
          }
      },
      methods: {
        async submit () {
            var check = await this.$refs.development_planning.validate()
            if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                this.application.draft = this.draft
                const result = await RestApi.postData(teaGardenServiceBaseUrl, treeDisposalAppCuttingDevelopmentStoreApi, this.application)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.loading = false
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: this.$t('globalTrans.form_error_msg'),
                        color: '#ee5253'
                    })
                }
            }
        },
        isNumber (evt) {
          helpers.isNumber(evt)
        }
      }
  }
  </script>
