<template>
  <card>
    <template v-slot:searchHeaderTitle>
      <h4 class="card-title">{{ $t('teaGardenConfig.scholarship_season_amount') }}</h4>
    </template>
    <template v-slot:searchBody>
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <b-row>
            <!-- season year -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Session" vid="year" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="year">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.year') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        plain
                        v-model="formData.year"
                        :options="yearList"
                        id="year"
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
            <!-- trust type -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Trust Type" vid="trust_type" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="trust_type">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.trust_type') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                        :disabled="$route.query.id"
                        plain
                        v-model="formData.trust_type"
                        :options="getTrustType"
                        id="trust_type"
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
            <!-- class amount distribution start here-->
            <div>
            <div v-if="formData.trust_type !== 0">
                <h6 class="card-title" style="width: 100%"> {{ $t('teaGardenConfig.scholarship_amount_distribution') }}</h6>
            </div>
            <b-table-simple style="width: 50%" bordered v-if="formData.trust_type !== 0">
                <b-tr>
                    <b-th class="text-center"> {{ $t('teaGardenConfig.class') }} </b-th>
                    <b-th class="text-center" v-if="formData.trust_type === 1"> {{ $t('teaGardenConfig.amount') }}</b-th>
                    <b-th class="text-center" v-if="formData.trust_type === 2"> {{ $t('teaGardenConfig.amount_gpa5') }}</b-th>
                    <b-th class="text-center" v-if="formData.trust_type === 2"> {{ $t('teaGardenConfig.amount_below_gpa5') }}</b-th>
                </b-tr>
                <template v-if="formData.details.length">
                        <template v-for="(item, index) in formData.details">
                          <b-tr :key="index">
                              <b-td class="text-center p-0 pt-4">{{ getClassName(item.class_id) }}</b-td>
                              <b-td style="padding: 0px 5px;
">
                              <ValidationProvider name="Amount" :vid="'amount.'+index" rules="required">
                                  <b-form-group
                                      class="mb-0"
                                      :label-for="'amount.'+index"
                                      slot-scope="{ valid, errors }"
                                      >
                                      <b-form-input
                                        type="number"
                                          :id="'amount.'+index"
                                          v-model="item.amount"
                                          min="0"
                                          :placeholder="$t('teaGardenConfig.amount')"
                                          :state="errors[0] ? false : (valid ? true : null)">
                                        </b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                              </b-td>
                              <b-td v-if="formData.trust_type === 2" style="padding: 0px 5px;
">
                              <ValidationProvider name="Below GPA-5 Amount" :vid="'below_gpa5_amount.'+index" rules="required">
                                  <b-form-group
                                      class="mb-0"
                                      :label-for="'below_gpa5_amount.'+index"
                                      slot-scope="{ valid, errors }"
                                      >
                                      <b-form-input
                                        type="number"
                                          :id="'below_gpa5_amount.'+index"
                                          min="0"
                                          v-model="item.below_gpa5_amount"
                                          :placeholder="$t('teaGardenConfig.amount')"
                                          :state="errors[0] ? false : (valid ? true : null)">
                                        </b-form-input>
                                      <div class="invalid-feedback">
                                      {{ errors[0] }}
                                      </div>
                                  </b-form-group>
                              </ValidationProvider>
                              </b-td>
                          </b-tr>
                        </template>
                </template>
                <template v-else>
                  <b-tr>
                    <b-td colspan="1" class="text-center">{{ $t('globalTrans.noDataFound') }}</b-td>
                  </b-tr>
                </template>
            </b-table-simple>
            </div>
            <!-- class amount distribution end here-->
            <!-- remarks en -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Remarks (En)" vid="remarks_en">
                <b-form-group
                  label-for="remarks_en">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.remarks') }} {{ $t('globalTrans.en') }}
                  </template>
                  <b-form-textarea
                    id="remarks_en"
                    v-model="formData.remarks_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <!-- remarks bn  -->
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Remarks (Bn)" vid="remarks_bn">
                <b-form-group
                  label-for="remarks_bn">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.remarks') }} {{ $t('globalTrans.bn') }}
                  </template>
                  <b-form-textarea
                    id="remarks_bn"
                    v-model="formData.remarks_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row>
            <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <router-link :to="{ name: 'tea_garden_service.configuration.sch-season-amount' }" variant="light" size="sm" class="mr-2"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</router-link>
            </b-col>
          </b-row>
        </b-form>
    </b-overlay>
    </ValidationObserver>
    </template>
  </card>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { schSeasonAmountStore, schSeasonAmountUpdate, schSeasonAmountView } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
    components: {
        ValidationProvider,
        ValidationObserver
    },
  data () {
    return {
      valid: null,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      circularLoading: false,
      formData: {
        id: '',
        year: 0,
        trust_type: 0,
        remarks_en: '',
        remarks_bn: '',
        details: [
          {
            id: '',
            sch_session_main_id: 0,
            class_id: '',
            amount: '',
            below_gpa5_amount: ''
          }
        ]
      },
      loading: false
    }
  },
  created () {
    if (this.$route.query.id) {
      this.loading = true
      const tmp = this.getData(this.$route.query.id)
      this.formData = tmp
      if (!this.formData.details) {
        this.formData.details = [
          {
            id: '',
            sch_session_main_id: 0,
            class_id: '',
            amount: '',
            lease_below_gpa5_amountend_date: ''
          }
        ]
      }
    }
  },
  computed: {
    getTrustType: function () {
      return this.$store.state.TeaGardenService.commonObj.trustType
    },
    yearList: function () {
        return this.$store.state.TeaGardenService.commonObj.seasonYearList.map(item => {
            if (this.$i18n.locale === 'bn') {
              return { value: item, text: this.$n(item, { useGrouping: false }) }
            } else {
                return item
            }
        })
    }
  },
  methods: {
    async getData (id) {
        let result = null
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${schSeasonAmountView}/${id}`)
        this.formData = result.data
        this.loading = false
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      this.loading = true
       const loadingState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${schSeasonAmountUpdate}/${this.formData.id}`, this.formData)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, schSeasonAmountStore, this.formData)
      }
      loadingState.listReload = true
      this.loading = false
      if (result.exist) {
        this.$toast.error({
            title: this.$t('globalTrans.error'),
            message: this.$t('teaGardenConfig.existErrorMsg'),
            color: '#ee5253'
        })
        return false
      }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push({ name: 'tea_garden_service.configuration.sch-season-amount' })
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
     getTrustTypeWiseClass (id) {
      const tmpData = this.$store.state.TeaGardenService.commonObj.masterTrustTypeList.filter(item => item.trust_type === id && item.status === 1)
      this.formData.details = JSON.parse(JSON.stringify(tmpData))
      this.formData.details.map(item => {
        item.class_id = item.value
      })
    },
    getClassName (id) {
      const trustTypeInfo = this.$store.state.TeaGardenService.commonObj.masterTrustTypeList.find(item => item.value === id)
      if (trustTypeInfo && this.$i18n.locale === 'bn') {
          return trustTypeInfo.text_bn
      } else if (trustTypeInfo && this.$i18n.locale === 'en') {
          return trustTypeInfo.text_en
      }
    }
  },
  watch: {
    'formData.trust_type': function (newVal, oldValue) {
      if (newVal && newVal !== 0 && !this.$route.query.id) {
        this.getTrustTypeWiseClass(newVal)
      }
    }
  }
}

</script>
<style scoped>
  .p_heading{
    font-weight: bold;
  }
</style>
