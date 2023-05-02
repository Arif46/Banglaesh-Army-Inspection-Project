<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading || loadUser">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="User" vid="user_id" rules="required|min_value:1">
              <b-form-group
                label-for="user_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.user')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.user_id"
                :options="userList"
                id="user_id"
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
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="office_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('tcbconfiguration.office_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.office_type_id"
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
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
              <b-form-group
                label-for="office_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('tcbconfiguration.office')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.office_id"
                :options="officeList"
                id="office_id"
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
          <b-col>
            <b-row v-for="(item, index) in form.warehouseList" :key="index">
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <b-form-group label-for="warehouse_id">
                  <template v-slot:label>
                    {{ $t('tcbconfiguration.warehouse') }}
                  </template>
                  <b-form-select
                    plain
                    id="warehouse_id"
                    :options="warehouseList"
                    v-model="item.warehouse_id"
                  >
                    <template v-slot:first>
                      <b-form-select-option value=''>{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col xs="12" sm="12" md="2" lg="2" xl="2">
                <b-button v-if="index===0" variant="success" class="btn-sm mt-4" @click="addWarehouse()"><i class="ri-add-fill"></i></b-button>
                <b-button v-else variant="danger" class="btn-sm mt-4" @click="removeWarehouse(index)"><i class="ri-close-line"></i></b-button>
              </b-col>
            </b-row>
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
import RestApi, { authServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { userWarehouseStore, userWarehouseUpdate, tcbUserList } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      userList: [],
      officeTypeList: [],
      officeList: [],
      warehouseList: [],
      loadUser: false,
      form: {
        user_id: 0,
        org_id: 7,
        office_type_id: 0,
        office_id: 0,
        warehouseList: [
          {
            warehouse_id: ''
          }
        ]
      }
    }
  },
  created () {
    this.officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === 7)
    if (this.id) {
      const tmp = this.getOfficeEntry()
      this.form = tmp
    }
    this.getTcbUserList()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === newVal)
      }
    },
    'form.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.warehouseList = this.getWareHouseList(newVal)
      }
    }
  },
  methods: {
    addWarehouse () {
      this.form.warehouseList.push({ warehouse_id: 0 })
    },
    removeWarehouse (index) {
      this.form.warehouseList.splice(index, 1)
    },
    getWareHouseList (officeId) {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.office_id === parseInt(officeId))
    },
    async getTcbUserList () {
      this.loadUser = true
      const result = await RestApi.getData(authServiceBaseUrl, tcbUserList, { org_id: 7 })
      this.loadUser = false
      this.userList = result.data.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.id, text: item.text_bn }
        } else {
          return { value: item.id, text: item.text_en }
        }
      })
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${userWarehouseUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, userWarehouseStore, this.form)
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
    },
    getOfficeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      const finalData = JSON.parse(JSON.stringify(tmpData))
      finalData.office_type_id = this.getOfficeTypeId(finalData.office_id)
      return finalData
    },
    getOfficeTypeId (officeId) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(officeId))
      if (typeof office !== 'undefined') {
        return office.office_type_id
      } else {
        return 0
      }
    }
  }
}
</script>
