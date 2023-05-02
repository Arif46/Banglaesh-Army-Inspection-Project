<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <!-- garden name -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
              <b-form-group slot-scope="{ valid, errors }" label-for="garden_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.select_garden') }} <span class="text-danger">*</span>
                </template>
                <b-form-select plain v-model="pluckingTarget.garden_id" :options="teaGardenGenInfoList"
                  id="garden_id" :state="errors[0] ? false : (valid ? true : null)">
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Target" vid="target" rules="required" v-slot="{ errors }">
              <b-form-group label-for="target">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.target') }} {{ $t('teaGardenConfig.kg') }} <span class="text-danger">*</span>
                </template>
                <b-form-input id="target" type="number" v-model="pluckingTarget.target"
                  :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Target Date" vid="target_date" rules="required">
              <b-form-group class="row" label-for="target_date" slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.target_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker id="target_date" v-model="pluckingTarget.target_date" class="form-control"
                  :placeholder="$t('globalTrans.select_date')" :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''">
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{
            $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { pluckingTargetStoreApi, pluckingTargetUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      pluckingTarget: {
        id: '',
        garden_id: 0,
        target: '',
        target_date: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getPluckingTarget()
      this.pluckingTarget = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    teaGardenGenInfoList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${pluckingTargetUpdateApi}/${this.id}`, this.pluckingTarget)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, pluckingTargetStoreApi, this.pluckingTarget)
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
      }
    },
    getPluckingTarget () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
