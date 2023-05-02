<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
            <b-col md="6" sm="12">
              <ValidationProvider name="Business Type" vid="business_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="business_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('rjscConfig.business_type')}}  <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.business_type_id"
                  :options="businessTypeList"
                  id="business_type_id"
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
            <b-col md="6" sm="12">
              <ValidationProvider name="Entity Type" vid="entity_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="entity_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('rjscAdminPortal.entity_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.entity_type_id"
                  :options="entityTypeList"
                  id="entity_type_id"
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
            <b-col sm="6">
              <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
                <b-form-group
                label-for="amount">
                <template v-slot:label>
                  {{ $t('globalTrans.amount') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="amount"
                  v-model="form.amount"
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
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { nameClearnessStore, nameClearnessUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      userLoading: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        business_type_id: 0,
        entity_type_id: 0,
        amount: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getListData()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    businessTypeList () {
      return this.$store.state.RjscService.commonObj.businessTypeList.filter(item => item.status === 1)
    },
    entityTypeList () {
      return this.$store.state.RjscService.commonObj.entityTypeList.filter(item => item.status === 1)
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
        this.designationList = this.getDesignationList(this.$rjscOrgId) // 15 = rjsc org_id
      } else {
        this.officeList = []
        this.designationList = []
      }
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${nameClearnessUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, nameClearnessStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getListData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getOfficeList (officeTypeId) {
      return this.$store.state.RjscService.commonObj.officeList.filter(office => office.office_type_id === officeTypeId)
    }
  }
}
</script>
