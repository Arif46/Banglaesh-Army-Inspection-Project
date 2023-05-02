<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Component Name" vid="component_id" rules="required|min_value:1">
                <b-form-group
                  label-for="component_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('menu.component')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.component_id"
                  :options="componentList"
                  id="component_id"
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
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.org_id"
                  :options="orgList"
                  id="org_id"
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
            <ValidationProvider name="Designation" vid="designation_id" rules="required">
                <b-form-group
                  label-for="designation_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.designation')}} <span class="text-danger">*</span>
                </template>
                <b-form-checkbox-group
                  class="text-left"
                  v-model="form.designation_id"
                  :options="designationList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-checkbox-group>
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { componentDesignationStore, componentDesignationUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item', 'itemKeys'],
  data () {
    return {
      valid: null,
      saveBtnName: this.item.status ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        component_id: 0,
        designation_id: []
      },
      orgList: [],
      designationList: []
    }
  },
  created () {
    if (this.item.status) {
      this.form = JSON.parse(JSON.stringify(this.item))
    }
  },
  computed: {
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'form.component_id': function (newVal, oldVal) {
      if (newVal && newVal !== oldVal) {
        this.orgList = this.getOrgListByDesignation(newVal)
      } else {
        this.orgList = []
      }
    },
    'form.org_id': function (newVal, oldVal) {
      if (newVal && newVal !== oldVal) {
        this.designationList = this.getDesignationList(newVal)
      } else {
        this.designationList = []
      }
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.item.status) {
        result = await RestApi.putData(commonServiceBaseUrl, `${componentDesignationUpdate}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, componentDesignationStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.info({
          title: 'Warning',
          message: result.message,
          color: '#bd2130'
        })
        return
      }

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.item ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getDesignationList (orgId) {
      const designationList = this.$store.state.CommonService.commonObj.designationList
      if (designationList !== undefined) {
        return designationList.filter(item => item.status === 1 && item.org_id === orgId).map(itemObj => {
          if (this.$i18n.locale === 'bn') {
            return { value: itemObj.value, text: itemObj.text_bn }
          } else {
            return { value: itemObj.value, text: itemObj.text }
          }
        })
      }
    },
    getOrgListByDesignation (componentId) {
      const orgComponentList = this.$store.state.CommonService.commonObj.orgComponentList
      if (orgComponentList !== undefined) {
        return orgComponentList.filter(item => item.component_id === componentId).map(itemObj => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(orgItem => orgItem.value === itemObj.org_id)
          if (this.$i18n.locale === 'bn') {
            return { value: orgObj.value, text: orgObj.text_bn }
          } else {
            return { value: orgObj.value, text: orgObj.text_en }
          }
        })
      }
    }
  }
}

</script>
