<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="name_en">
            <template v-slot:label>
              {{ $t('globalTrans.name_en') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="name_en"
              v-model="form.name_en"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="name_bn">
            <template v-slot:label>
              {{ $t('globalTrans.name_bn') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="name_bn"
              v-model="form.name_bn"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Address (En)" vid="address_en" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="name_en">
            <template v-slot:label>
              {{ $t('globalTrans.address_en') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="address_en"
              v-model="form.address_en"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="address_bn">
            <template v-slot:label>
              {{ $t('globalTrans.address_bn') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="address_bn"
              v-model="form.address_bn"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Telephone" vid="telephone" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="telephone">
            <template v-slot:label>
              {{ $t('globalTrans.telephone') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="telephone"
              v-model="form.telephone"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Fax" vid="fax" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="fax">
            <template v-slot:label>
              {{ $t('globalTrans.fax') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="fax"
              v-model="form.fax"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Email" vid="email" rules="required" v-slot="{ errors }">
          <b-form-group
            label-cols-lg="4"
            label-for="email">
            <template v-slot:label>
              {{ $t('globalTrans.email') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="email"
              v-model="form.email"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Division" vid="divisions" rules="required|min_value:1">
          <b-form-group
            label-for="divisions"
            label-cols-lg="4"
            slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
            {{$t('globalTrans.division')}} <span class="text-danger">*</span>
          </template>
            <v-select name="divisions"
              multiple
              v-model="form.divisions"
              label="text"
              :reduce="item => item.value"
              :options= divisionList
              :placeholder="$t('globalTrans.select')"
            />
          <div class="invalid-feedback">
            {{ errors[0] }}
          </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="District" vid="districts" rules="required|min_value:1">
          <b-form-group
            label-for="districts"
            label-cols-lg="4"
            slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
            {{$t('globalTrans.district')}} <span class="text-danger">*</span>
          </template>
            <v-select name="districts"
              multiple
              v-model="form.districts"
              label="text"
              :reduce="item => item.value"
              :options= districtList
              :placeholder="$t('globalTrans.select')"
            />
          <div class="invalid-feedback">
            {{ errors[0] }}
          </div>
          </b-form-group>
        </ValidationProvider>
              <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_type_id"
                  label-cols-lg="4"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_type')}} <span class="text-danger">*</span>
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
              <ValidationProvider name="Office Name" vid="office_id" rules="required|min_value:1">
                <b-form-group
                  label-for="office_id"
                  label-cols-lg="4"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.office_name')}} <span class="text-danger">*</span>
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
import { contactStore, contactUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        name_en: '',
        name_bn: '',
        address_en: '',
        address_bn: '',
        telephone: '',
        fax: '',
        email: '',
        divisions: '',
        districts: '',
        office_type_id: 0,
        office_id: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMenu()
      this.form = tmp
    }
  },
  computed: {
    divisionList: function () {
      const divisions = this.$store.state.RjscService.commonObj.divisionList.map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
      return divisions
    },
    districtList: function () {
      return this.$store.state.RjscService.commonObj.districtList.map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    officeTypeList (id) {
      return this.$store.state.RjscService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === this.$rjscOrgId)
    }
  },
  watch: {
    'form.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
      } else {
        this.officeList = []
      }
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${contactUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, contactStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('RjscService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getMenu () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      tmpData.divisions = JSON.parse(tmpData.divisions)
      tmpData.districts = JSON.parse(tmpData.districts)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getOfficeList (officeTypeId) {
      return this.$store.state.RjscService.commonObj.officeList.filter(office => office.office_type_id === officeTypeId)
    }
  }
}
</script>
