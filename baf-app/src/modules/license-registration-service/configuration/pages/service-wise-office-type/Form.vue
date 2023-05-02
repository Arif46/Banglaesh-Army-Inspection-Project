<template>
  <b-container fluid>
    <b-row>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
          <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <b-row>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="org_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="serviceOffice.org_id"
                    :options="orgProfileList"
                    id="org_id"
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
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="service_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="serviceOffice.service_id"
                    :options="serviceList"
                    id="service_id"
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
            <b-row>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="office_type_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('component_settings.office_types')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="detailsFormData.office_type_id"
                    :options="officeTypeList"
                    id="office_type_id"
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
              <b-col lg="2" sm="2" md="2" class="mt-3">
                <b-button type="button" @click="addTmp()" variant="primary" class="mr-2 btn-sm">{{ $t('globalTrans.add') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </b-overlay>
      </ValidationObserver>
      <ValidationObserver ref="form1"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(storeUpdate)" @reset.prevent="reset" enctype="multipart/form-data">
          <br>
          <b-row>
            <b-table-simple  bordered>
              <thead>
                <tr class="">
                  <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                  <th scope="col">{{ $t('component_settings.office_types') }}</th>
                  <th scope="col" >{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                <slot v-for="(item, index) in serviceOffice.details">
                  <b-tr>
                    <td>
                      {{ $n(index + 1) }}
                    </td>
                    <td>
                      {{ getofficeTypeName(item.office_type_id) }}
                    </td>
                    <td>
                      <b-button type="button" @click="remove(index)" class="btn btn- iq-bg-danger btn-sm text-center ml-1"><i class="ri-delete-bin-line m-0"></i></b-button>
                    </td>
                  </b-tr>
                </slot>
              </b-tbody>
            </b-table-simple>
          </b-row>
          <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { serviceofficeTypeStore, serviceofficeTypeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item', 'id', 'orgId'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      detailsFormData: {
        office_type_id: 0
      },
      serviceOffice: {
        org_id: 0,
        service_id: 0,
        details: []
      },
      serviceList: [],
      officeTypeList: []
    }
  },
  created () {
    if (this.id) {
      this.serviceOffice.org_id = this.orgId
      const tmp = this.getServiceOfficeData(this.item)
      this.serviceOffice.details = tmp
    }
  },
  watch: {
    'serviceOffice.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === newVal)
        this.officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === newVal)
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    getServiceOfficeData (data) {
      const detailData = []
      this.serviceOffice.service_id = this.id
      Object.entries(data).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          const officeItem = { office_type_id: value.office_type_id }
          detailData.push(officeItem)
        })
      })
      return detailData
    },
    addTmp () {
      const officeTypeId = this.detailsFormData.office_type_id
      const checkOffice = this.serviceOffice.details.find(item => item.office_type_id === officeTypeId)
      if (typeof checkOffice === 'undefined') {
        this.serviceOffice.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
        this.detailsFormData.office_type_id = 0
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      }
    },
    remove (key) {
      this.serviceOffice.details.splice(key, 1)
    },
    getofficeTypeName (officeType) {
      const tmpOffice = this.officeTypeList.find(office => office.value === officeType)
      return this.$i18n.locale === 'en' ? tmpOffice !== undefined ? tmpOffice.text_en : '' : tmpOffice !== undefined ? tmpOffice.text_bn : ''
    },
    async storeUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${serviceofficeTypeUpdate}/${this.id}`, this.serviceOffice)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, serviceofficeTypeStore, this.serviceOffice)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
