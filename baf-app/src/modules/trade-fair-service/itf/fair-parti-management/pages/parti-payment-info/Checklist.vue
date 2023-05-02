<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <table width="100%">
            <thead>
              <tr>
                <th class="text-center"> {{ $t('globalTrans.sl_no') }} </th>
                <th> {{ $t('approvedParticipation.criteria') + ' ' + $t('globalTrans.name') }} </th>
                <th class="text-center"> {{ $t('approvedParticipation.evaluation') }} </th>
              </tr>
            </thead>
            <tbody>
              <td hidden>{{ $i=1 }}</td>
              <tr v-for="(item, index) in formData.criteriaList" :key="index">
                <slot v-if="item.is_active === 1">
                  <td class="text-center">
                    {{ $n(index + 1, { useGrouping: false }) }}
                  </td>
                  <td>
                    {{ currentLocale === 'bn' ? item.criteria_name_bn : item.criteria_name_en }}
                  </td>
                  <td class="text-center">
                    <ValidationProvider name="Criteria" :vid="criteria" :rules="required|min_value:1">
                      <b-form-group
                        label-for="'criteria' + index"
                        slot-scope="{ errors }"
                      >
                        <b-form-radio-group class="custom-control-inline-wrapper mb-0"
                          :id="'criteria' + index"
                          :name="'criteria' + index"
                          size="lg"
                          v-model="item.status"
                          :options="yesNoList"
                          :aria-describedby="'ariaDescribedby' + index"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-radio-group>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </td>
                </slot>
              </tr>
            </tbody>
          </table>
        </b-col>
      </b-row>
      <b-row class="text-right mt-2">
        <b-col>
          <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-checklist')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { itfFairPariPaymentInfoEvaluate, itfFairPariPaymentInfoCriteria } from '../../api/routes'
export default {
  name: 'Form',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      formData: {
        id: this.items.id,
        criteriaList: [],
        user_id: this.$store.state.Auth.authUser.user_id
      }
    }
  },
  created () {
    this.getCriteriaList(this.items.fair_circular.fair_name_id)
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yesNoList () {
      return [
        { text: this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ', value: 1, text_en: 'Yes', text_bn: 'হ্যাঁ' },
        { text: this.currentLocale === 'en' ? 'No' : 'না', value: 2, text_en: 'No', text_bn: 'না' }
      ]
    }
  },
  methods: {
    getCriteriaList (circularId) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      RestApi.getData(internationalTradeFairServiceBaseUrl, `${itfFairPariPaymentInfoCriteria}/${circularId}`).then(response => {
        if (response.success) {
          this.formData.criteriaList = response.data.details.map(el => {
            return Object.assign(el, { status: 2 })
          })
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
      })
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(internationalTradeFairServiceBaseUrl, itfFairPariPaymentInfoEvaluate, this.formData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$t('tradeFairProposalManagement.reject_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-checklist')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
<style scoped>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
</style>
