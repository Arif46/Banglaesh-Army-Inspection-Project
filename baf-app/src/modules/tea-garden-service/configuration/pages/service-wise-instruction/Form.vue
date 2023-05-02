<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="service name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="serviceWiseInstruction.service_id"
                :options="portalServiceNameList"
                id="service_id"
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
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Instruction (En)" vid="instruction_en">
              <b-form-group
                label-for="instruction_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.instruction') }} {{ $t('globalTrans.en') }} <span class="text-danger"> * </span>
                </template>
<!--                <b-form-textarea-->
<!--                  id="instruction_en"-->
<!--                  v-model="serviceWiseInstruction.instruction_en"-->
<!--                  :state="errors[0] ? false : (valid ? true : null)"-->
<!--                ></b-form-textarea>-->
                <vue-editor
                  id="instruction_en"
                  v-model="serviceWiseInstruction.instruction_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></vue-editor>
                <div class="invalid-feedback d-block" v-if="customErrors.instruction_bn.length">
                  {{ customErrors.instruction_en[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Instruction (Bn)" vid="instruction_bn">
              <b-form-group
                label-for="instruction_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.instruction') }} {{ $t('globalTrans.bn') }} <span class="text-danger"> * </span>
                </template>
<!--                <b-form-textarea-->
<!--                  id="instruction_bn"-->
<!--                  v-model="serviceWiseInstruction.instruction_bn"-->
<!--                  :state="errors[0] ? false : (valid ? true : null)"-->
<!--                ></b-form-textarea>-->
                <vue-editor
                  id="instruction_bn"
                  v-model="serviceWiseInstruction.instruction_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></vue-editor>
                <div class="invalid-feedback d-block" v-if="customErrors.instruction_bn.length">
                  {{ customErrors.instruction_bn[0] }}
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
import { serviceWiseInstructionStoreApi, serviceWiseInstructionUpdateApi } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  props: ['id'],
  components: { VueEditor },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      serviceWiseInstruction: {
        service_id: 0,
        instruction_en: '',
        instruction_bn: ''
      },
      customErrors: {
        instruction_en: [],
        instruction_bn: []
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getserviceWiseInstruction()
      this.serviceWiseInstruction = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    portalServiceNameList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${serviceWiseInstructionUpdateApi}/${this.id}`, this.serviceWiseInstruction)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, serviceWiseInstructionStoreApi, this.serviceWiseInstruction)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.customErrors = Object.assign({}, this.customErrors, result.errors)
      }
    },
    getserviceWiseInstruction () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
