<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
            <b-col sm="12">
                <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                    <b-form-group
                    label-for="org_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
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
        </b-row>
        <b-row>
            <b-col sm="12">
                <ValidationProvider name="Office Type" vid="office_type_id" rules="min_value:1">
                    <b-form-group
                    label-for="office_type_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('organogram.office_type') }}
                    </template>
                    <b-form-select
                    plain
                    v-model="form.office_type_id"
                    :options="officeTypeList"
                    id="office_type_id"
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
            <b-col sm="12">
                <ValidationProvider name="Office" vid="office_id" rules="min_value:1">
                    <b-form-group
                    label-for="office_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.office') }}
                    </template>
                    <b-form-select
                    plain
                    v-model="form.office_id"
                    :options="officeList"
                    id="office_id"
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
            <b-col sm="6">
                <ValidationProvider name="Heading (En)" vid="heading_en" rules="required">
                    <b-form-group
                        label-for="heading_en"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('teaGardenConfig.heading_en')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        plain
                        v-model="form.heading"
                        id="heading_en"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                    </b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col sm="6">
                <ValidationProvider name="Heading (Bn)" vid="heading_bn" rules="required">
                    <b-form-group
                        label-for="heading_bn"
                        slot-scope="{ valid, errors }"
                    >
                        <template v-slot:label>
                            {{$t('teaGardenConfig.heading_bn')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            plain
                            v-model="form.heading_bn"
                            id="heading_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col sm="6">
                <ValidationProvider name="Address (En)" vid="address_en"  rules="required">
                    <b-form-group
                        label-for="address_en"
                        slot-scope="{ errors }"
                    >
                    <template v-slot:label>
                        {{$t('teaGardenConfig.address_en')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                        id="address_en"
                        v-model="form.address"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col sm="6">
                <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required">
                    <b-form-group
                    label-for="address_bn"
                    slot-scope="{ errors }"
                    >
                    <template v-slot:label>
                        {{$t('teaGardenConfig.address_bn')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-textarea
                        id="address_bn"
                        v-model="form.address_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </b-form-textarea>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col sm="6">
                <ValidationProvider name="Left logo" vid="left_logo" :rules="id ? '' : 'required'">
                    <b-form-group
                        label-for="left_logo"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.left_logo')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-file
                        id="left_logo"
                        v-model="form.left_attachment"
                        @change="leftOnChange"
                        :state="errors[0] ? false : (valid ? true : null)"
                        placeholder="Choose a file or drop it here..."
                        drop-placeholder="Drop file here..."
                    ></b-form-file>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col sm="6">
                <ValidationProvider name="Right logo" vid="right_logo" :rules="id ? '' : 'required'">
                    <b-form-group
                        label-for="right_logo"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.right_logo')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-file
                        id="right_logo"
                        v-model="form.right_attachment"
                        @change="rightOnChange"
                        :state="errors[0] ? false : (valid ? true : null)"
                        placeholder="Choose a file or drop it here..."
                        drop-placeholder="Drop file here..."
                    ></b-form-file>
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { reportHeadingStoreApi, reportHeadingUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        office_type_id: 0,
        office_id: 0,
        heading: '',
        heading_bn: '',
        address: '',
        address_bn: '',
        left_logo: '',
        right_logo: '',
        left_attachment: [],
        right_attachment: []
      },
      officeTypeList: [],
      officeList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getHeadingReport()
      this.form = tmp
      this.form.left_logo_old = tmp.left_logo
      this.form.right_logo_old = tmp.right_logo
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    leftOnChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.left_logo = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.left_logo = ''
      }
    },
    rightOnChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.right_logo = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.right_logo = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${reportHeadingUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, reportHeadingStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.warning) {
        this.$toast.error({
          title: 'Warning',
          message: this.$t('teaGardenConfig.alradyMsg'),
          color: '#e77171'
        })
        return
      }

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getHeadingReport () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getOfficeList (id) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === id)
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
    },
    'form.office_type_id': function (newVal, oldVal) {
        this.officeList = this.getOfficeList(newVal)
    }
  }
}
</script>
