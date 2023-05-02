<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
              <b-form-group
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
            <ValidationProvider name="Parent Menu" vid="parent_id" v-slot="{ errors }">
              <b-form-group
                label-for="name_bn">
                <template v-slot:label>
                  {{ $t('rjscAdminPortal.parent_menu') }}
                </template>
                <b-form-select
                  id="name_bn"
                  v-model="form.parent_id"
                  :options="menuList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <ValidationProvider name="Page Type" vid="page_type" v-slot="{ errors }">
              <b-form-group
                label-for="page_type">
                <template v-slot:label>
                  {{ $t('rjscAdminPortal.page_type') }}
                </template>
                <b-form-select
                  id="page_type"
                  v-model="form.page_type"
                  :options="pageTypeList"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <ValidationProvider name="Url" vid="url" v-slot="{ errors }" v-if="form.page_type === 1">
              <b-form-group
                label-for="url">
                <template v-slot:label>
                  {{ $t('sideBar.menu') }} {{ $t('globalTrans.url') }}
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
            <ValidationProvider name="Sorting Order" vid="sorting_order" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="sorting_order">
                <template v-slot:label>
                  {{ $t('globalTrans.sorting_order') }} <span class="text-danger">*</span>
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
import { menuStore, menuUpdate } from '../../api/routes'
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
        parent_id: null,
        page_type: 1,
        sorting_order: '',
        url: null
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
    menuList: function () {
      return this.$store.state.RjscService.commonObj.menuList
    },
    locale: function () {
      return this.$i18n.locale
    },
    pageTypeList: function () {
      return this.$store.state.RjscService.commonObj.pageTypeList.map(el => {
        if (this.locale === 'bn') {
          return Object.assign({}, el, { value: el.value, text: el.text_bn })
        } else {
          return Object.assign({}, el, { value: el.value, text: el.text_en })
        }
      })
    },
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
        result = await RestApi.putData(rjscServiceBaseUrl, `${menuUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, menuStore, this.form)
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
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
