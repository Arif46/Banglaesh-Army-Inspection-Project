<template>
    <b-row>
      <b-col md="12">
          <ValidationObserver ref="cutting_purpose"  v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                  <b-overlay :show="loading">
                        <b-row>
                            <b-col sm="12">
                                <div class="group-form-card">
                                    <b-card>
                                        <ValidationProvider name="Purpose of Tree Felling" vid="purpose_of_tree_felling" rules="required">
                                            <b-form-group
                                                slot-scope="{ valid, errors }"
                                                label-for="purpose_of_tree_felling"
                                                label-cols-lg="3"
                                                :label="$t('teaGardenService.purpose_of_tree_felling')" label-size="lg"
                                                label-class="font-weight-bold pt-0" class="mb-0">
                                                <b-row>
                                                    <b-col>
                                                        <b-form-checkbox-group
                                                            :state="errors[0] ? false : (valid ? true : null)"
                                                            class="custom-control-inline-wrapper" size="lg" v-model="application.purpose_of_tree_felling" :options="purposeTreeFelling" name="" stacked>
                                                        </b-form-checkbox-group>
                                                        <div class="invalid-feedback d-block">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-col>
                                                </b-row>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-card>
                                </div>
                            </b-col>
                            <b-col sm="12">
                                <div class="group-form-card">
                                    <b-card>
                                        <b-form-group label-cols-lg="3" :label="$t('teaGardenService.cutable_tree_section')" label-size="lg"
                                            label-class="font-weight-bold pt-0" class="mb-0">
                                            <b-row>
                                                <b-col sm="6">
                                                    <ValidationProvider name="Total Cutable Trees" vid="total_cutable_trees" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="total_cutable_trees"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.total_cutable_trees') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.total_cutable_trees"
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
                                                    <ValidationProvider name="Number of Re-plantable Trees" vid="number_of_re_plantable_tree" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_re_plantable_tree"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_re_plantable_tree') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.number_of_re_plantable_tree"
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
                                                    <ValidationProvider name="Number of Very Old Trees" vid="number_of_very_old_trees" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_very_old_trees"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_very_old_trees') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.number_of_very_old_trees"
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
                                                    <ValidationProvider name="Number of Rubber Trees" vid="number_of_rubber_tree" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_rubber_tree"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_rubber_tree') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.number_of_rubber_tree"
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
                                                    <ValidationProvider name="Number of Diseased Trees" vid="number_of_disease_tree" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_disease_tree"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_disease_tree') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.number_of_disease_tree"
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
                                                    <ValidationProvider name="Number of Other Trees" vid="number_of_other_trees" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_other_trees"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_other_trees') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.number_of_other_trees"
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
  import { treeDisposalAppCuttingPurposeStoreApi } from '../../api/routes'
  import { mapGetters } from 'vuex'
  import { helpers } from '@/utils/helper-functions'
  export default {
      props: ['app_id', 'garden_id_set', 'cuttingPurposeData', 'isShow', 'baseUrl'],
      name: 'CuttingPurpose',
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
                tree_cutting_id: null,
                purpose_of_tree_felling: [],
                total_cutable_trees: 0,
                number_of_re_plantable_tree: 0,
                number_of_very_old_trees: 0,
                number_of_rubber_tree: 0,
                number_of_disease_tree: 0,
                number_of_other_trees: 0
            },
            valid: null,
            loading: false
        }
      },
      created () {
        this.application = this.cuttingPurposeData
      },
      computed: {
          ...mapGetters({
              authUser: 'Auth/authUser'
          }),
          currentLocale () {
              return this.$i18n.locale
          },
          purposeTreeFelling () {
            return this.$store.state.TeaGardenService.commonObj.purposeTreeFelling
          }
      },
      methods: {
        async submit () {
            var check = await this.$refs.cutting_purpose.validate()
            if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                const result = await RestApi.postData(teaGardenServiceBaseUrl, treeDisposalAppCuttingPurposeStoreApi, this.application)
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
