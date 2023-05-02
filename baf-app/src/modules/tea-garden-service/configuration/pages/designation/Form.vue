<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Designation Name (En)" vid="designation_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="designation_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.designation_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="designation_name_en"
                  v-model="designation.designation_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Designation Name(Bn)" vid="designation_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="designation_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.designation_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="designation_name_bn"
                  v-model="designation.designation_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Sorting" vid="sorting" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group label-for="sorting">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.sorting') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input id="sorting" v-model="designation.sorting"
                  :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
          <!-- <b-col xs="12" sm="12" md="6" lg="6" xl="6">
          <ValidationProvider name="Sorting" vid="sorting" rules="required|min_value:1" v-slot="{ errors }">
            <b-form-group label-for="sorting">
              <template v-slot:label>
                {{ $t('menu.sorting') }} <span class="text-danger">*</span>
              </template>
              <b-form-input id="sorting" v-model="form.sorting" :state="errors[0] ? false : (valid ? true : null)"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col> -->

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
import { designationStoreApi, designationUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      designation: {
        designation_name_en: '',
        designation_name_bn: '',
        sorting: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getdesignation()
      this.designation = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
          result = await RestApi.putData(teaGardenServiceBaseUrl, `${designationUpdateApi}/${this.id}`, this.designation)
      } else {
          result = await RestApi.postData(teaGardenServiceBaseUrl, designationStoreApi, this.designation)
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
    getdesignation () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
