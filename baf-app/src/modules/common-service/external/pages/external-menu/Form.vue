<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="12">
            <ValidationProvider name="External Panel" vid="external_panel_id" rules="required|min_value:1">
              <b-form-group
                label-for="external_panel_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('external.external_panel')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.external_panel_id"
                :options="externalPanelList"
                id="external_panel_id"
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
          <b-col sm="6">
            <ValidationProvider name="Name (En)" vid="name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="name">
                <template v-slot:label>
                  {{ $t('globalTrans.name') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="name"
                  v-model="form.name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Module Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
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
          </b-col>
          <b-col sm="১২">
            <ValidationProvider name="Url" vid="url" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="url">
                <template v-slot:label>
                  {{ $t('globalTrans.url') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="url"
                  v-model="form.url"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Icon" vid="icon" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="icon">
                <template v-slot:label>
                  {{ $t('external.icon') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="icon"
                  v-model="form.icon"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Sorting Order" vid="sorting_order" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="sorting_order">
                <template v-slot:label>
                  {{ $t('menu.sorting_order') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="sorting_order"
                  v-model="form.sorting_order"
                  :state="errors[0] ? false : (valid ? true : null)"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                ></b-form-input>
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { externalMenuStore, externalMenuUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        external_panel_id: 0,
        name: '',
        name_bn: '',
        url: '',
        icon: '',
        sorting_order: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getExternalMenu()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    externalPanelList () {
      return this.$store.state.CommonService.commonObj.externalPanelList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${externalMenuUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, externalMenuStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

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
    getExternalMenu () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
