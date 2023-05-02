<template>
<b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
              <b-row>
         <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Publish for all/Selective " vid="org_id" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.publish')}} <span class="text-danger">*</span>
                </template>
                <b-form-radio-group
                  id="publish_status"
                  v-model="formData.publish_status"
                  :options="publishTypeList"
                  @change="orgShow()"
                  name="publish_status"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
         <b-col xs="12" sm="12" md="6" v-if="formData.publish_status === 2">
            <ValidationProvider name="Council Name" vid="council_info_id" rules="">
                  <b-form-group
                      label-for="council_info_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formData.council_info_id"
                      :options="councilInfoList"
                      id="council_info_id"
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

              </b-row>
            </b-form>
          </b-overlay>
        </ValidationObserver>
      <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('publish')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { circularNoticePublish, getCouncilIds } from '../../api/routes'
export default {
  name: 'Form',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.items.id ? this.$t('globalTrans.publish') : this.$t('globalTrans.save'),
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      errors: [],
      cirCouncilIds: [],
      formData: {
        id: 0,
        publish_status: 1,
        council_info_id: 0
      },
      publishTypeList: [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'সকলের জন্য' : 'Publish For All' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'নির্বাচন করুন' : 'Selected' }
      ]
    }
  },
  created () {
    if (this.items.id) {
      this.getCouncils(this.items.fiscal_year_id, this.items.source_of_fund)
      const tmp = this.getFeeEntry()
      // this.formData = tmp
      this.formData.id = tmp.id
      this.formData.council_info_id = 0
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => this.cirCouncilIds.indexOf(item.value) > -1)
    }
  },
  watch: {
  },
  methods: {
    orgShow () {
      if (this.formData.publish_status === 1) {

      }
      if (this.formData.publish_status === 2) {

      }
    },
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.formData.councilInfoIds = this.cirCouncilIds
      if (this.items.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${circularNoticePublish}/${this.items.id}`, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.items.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('publish')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    async getCouncils (fiscalYearId, fundId) {
        const params = {
          fiscal_year_id: fiscalYearId,
          source_of_fund: fundId
        }
      const loadingState = { loading: false, listReload: false }
      let result = null
      result = await RestApi.getData(eBizServiceBaseUrl, getCouncilIds, params)
      loadingState.listReload = true
      if (result.success) {
        this.cirCouncilIds = result.data
      }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.items.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
