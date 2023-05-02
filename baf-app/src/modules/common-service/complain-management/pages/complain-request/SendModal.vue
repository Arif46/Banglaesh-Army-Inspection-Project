<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
       <b-col sm="12">
          <ValidationProvider name="Complain title" vid="com_title">
            <b-form-group
              class="row"
              label-for="com_title"
            >
                <template v-slot:label>
                  {{$t('complain_management.complain_title')}}<span class="text-danger">*</span>
              </template>
              <b-form-input
                readonly
                id="com_title"
                v-model="complainRequestList.com_title"
                ></b-form-input>
            </b-form-group>
          </ValidationProvider>
        </b-col>
         <b-col sm="12">
          <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
            <b-form-group
              label-for="designation_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('organogram.designation')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="complainReport.designation_id"
              :options="designationList"
              id="designation_id"
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
          <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
            <b-form-group
              label-for="designation_id"
              slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
              {{$t('globalTrans.send_to')}} <span class="text-danger">*</span>
            </template>
            <b-form-select
              plain
              v-model="complainReport.designation_id"
              :options="designationList"
              id="designation_id"
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
          <ValidationProvider :name="$t('complain_management.approve_note') +' '+ $t('globalTrans.bn')" vid="approve_note_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="approve_note_bn">
              <template v-slot:label>
                {{ $t('complain_management.note') }} {{ $t('globalTrans.en')}} <span class="text-danger">*</span>
              </template>
             <b-form-textarea
                rows="3"
                id="approve_note_bn"
                v-model="complainReport.approve_note_bn"
                :state="errors[0] ? false : (valid ? true : null)"
             ></b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
         <b-col sm="12">
          <ValidationProvider :name="$t('complain_management.approve_note') +' '+ $t('globalTrans.bn')" vid="approve_note_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="approve_note_bn">
              <template v-slot:label>
                {{ $t('complain_management.note') }} {{ $t('globalTrans.bn')}} <span class="text-danger">*</span>
              </template>
             <b-form-textarea
                rows="3"
                id="approve_note_bn"
                v-model="complainReport.approve_note_bn"
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
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-send')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { complainApproveSubmit } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      complainReport: {
        complain_id: this.id,
        com_title: '',
        designation_id: 0,
        approve_note_bn: ''
      },
      complainDesignationList: [],
      userList: [],
      user: [],
      complainRequestList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDocument()
      this.complainReport = tmp
      this.complainReport.oldfile = tmp.attachment
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
      designationList (orgId) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === orgId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: false }

      const config = {
        headers: { 'content-type': 'multipart/form-data' }
      }

      var formData = new FormData()
      Object.keys(this.complainReport).map(key => {
        formData.append(key, this.complainReport[key])
      })
      result = await RestApi.postData(commonServiceBaseUrl, complainApproveSubmit, formData, config)
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-1')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    },
    getDocument () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
