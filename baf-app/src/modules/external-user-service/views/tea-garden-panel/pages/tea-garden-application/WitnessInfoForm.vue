<template>
    <div class="application-itmes">
      <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
          <b-overlay :show="loading">
            <b-row>
                <b-col sm="12">
                    <div class="group-form-card">
                        <b-card>
                            <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.first_witness_info')" label-size="lg"
                                label-class="font-weight-bold pt-0" class="mb-0">
                                <b-row>
                                    <b-col sm="6">
                                        <ValidationProvider name="Witness Name (En)" vid="first_witness_name_en" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="first_witness_name_en"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.witness_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="first_witness_name_en"
                                                v-model="formData.first_witness_name_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Witness Name (Bn)" vid="first_witness_name_bn" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="first_witness_name_bn"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.witness_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="first_witness_name_bn"
                                                v-model="formData.first_witness_name_bn"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Address (En)" vid="first_witness_address_en" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="first_witness_address_en"
                                          >
                                            <template v-slot:label>
                                              {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="first_witness_address_en"
                                                v-model="formData.first_witness_address_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Address (Bn)" vid="first_witness_address_bn" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="first_witness_address_bn"
                                          >
                                            <template v-slot:label>
                                              {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="first_witness_address_bn"
                                                v-model="formData.first_witness_address_bn"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
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
                <b-col sm="12">
                    <div class="group-form-card">
                        <b-card>
                            <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.second_witness_info')" label-size="lg"
                                label-class="font-weight-bold pt-0" class="mb-0">
                                <b-row>
                                    <b-col sm="6">
                                        <ValidationProvider name="Witness Name (En)" vid="second_witness_name_en" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="second_witness_name_en"
                                          >
                                            <template v-slot:label>
                                              {{ $t('teaGardenPanel.witness_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="second_witness_name_en"
                                                v-model="formData.second_witness_name_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                      <ValidationProvider name="Witness Name (En)" vid="second_witness_name_bn" rules="required">
                                        <b-form-group
                                            slot-scope="{ valid, errors }"
                                            label-for="second_witness_name_bn"
                                        >
                                          <template v-slot:label>
                                            {{ $t('teaGardenPanel.witness_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                          </template>
                                          <b-form-input
                                              id="second_witness_name_bn"
                                              v-model="formData.second_witness_name_bn"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                              :disabled="isRenew"
                                          >
                                          </b-form-input>
                                          <div class="invalid-feedback">
                                            {{ errors[0] }}
                                          </div>
                                        </b-form-group>
                                      </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Address (En)" vid="second_witness_address_en" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="second_witness_address_en"
                                          >
                                            <template v-slot:label>
                                              {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="second_witness_address_en"
                                                v-model="formData.second_witness_address_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
                                            <div class="invalid-feedback">
                                              {{ errors[0] }}
                                            </div>
                                          </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col sm="6">
                                        <ValidationProvider name="Address (En)" vid="second_witness_address_bn" rules="required">
                                          <b-form-group
                                              slot-scope="{ valid, errors }"
                                              label-for="second_witness_address_bn"
                                          >
                                            <template v-slot:label>
                                              {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="second_witness_address_bn"
                                                v-model="formData.second_witness_address_bn"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                :disabled="isRenew"
                                            >
                                            </b-form-input>
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
            <b-row>
                <b-col sm="12">
                    <b-form-checkbox
                      id="agree"
                      class="witness-agree-wrapper"
                      size="lg"
                      v-model="formData.are_agree"
                      name="are_agree"
                      :disabled="isRenew"
                    ><b>{{ $t('teaGardenPanel.agree') }}</b></b-form-checkbox>
                    <p class="mb-5">{{ $t('teaGardenPanel.agree_statement') }}</p>
                </b-col>
            </b-row>
          </b-overlay>
        </b-form>
      </ValidationObserver>
    </div>
</template>

<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { witnessInfoStoreApi, witnessInfoUpdateApi } from '../../api/routes'

export default {
  props: ['tabFormData', 'status', 'isRenew'],
  data () {
    return {
      valid: null,
      formData: this.tabFormData,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl
    }
  },
  created () {
  },
  mounted () {
    this.formData = this.tabFormData
    if (this.tabFormData.are_agree === 1) {
      this.formData.are_agree = true
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  watch: {
  },
  methods: {
    async submit () {
      var check = await this.$refs.form.validate()
      if (check) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const loadingState = { loading: false, listReload: false }
        let result
        const data = Object.assign({}, this.formData, { status: this.status })
        if (this.formData.id) {
          result = await RestApi.putData(teaGardenServiceBaseUrl, witnessInfoUpdateApi + '/' + this.formData.id, data)
        } else {
          result = await RestApi.postData(teaGardenServiceBaseUrl, witnessInfoStoreApi, data)
        }
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        if (result.success) {
          this.$toast.success({
            title: 'Success',
            message: this.formData.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
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
    }
  }
}
</script>
