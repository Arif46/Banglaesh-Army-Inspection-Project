<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
        <b-col xs="12" sm="12" md="6">
          <ValidationProvider name="Council Info" vid="council_info_id" rules="required|min:1">
              <b-form-group
                label-for="council_info_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('eBizConfig.council_name')}}
              </template>
              <b-form-select
                plain
                v-model="form.council_info_id"
                :options="councilInfo"
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
        <b-col xs="12" sm="12" md="6">
        </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Association Name (En)" vid="association_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="association_name_en">
                <template v-slot:label>
                  {{ $t('eBizConfig.association_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="association_name_en"
                  v-model="form.association_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Association Name (Bn)" vid="association_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="association_name_bn">
                <template v-slot:label>
                  {{ $t('eBizConfig.association_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="association_name_bn"
                  v-model="form.association_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="description_en"
                    rows="3"
                    v-model="form.description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="description_bn"
                    rows="3"
                    v-model="form.description_bn"
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
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { associationInfoStore, associationInfoUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        council_info_id: 0,
        association_name_en: '',
        association_name_bn: '',
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    componentOrgList () {
        return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    },
    councilInfo () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${associationInfoUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, associationInfoStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getEditEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
