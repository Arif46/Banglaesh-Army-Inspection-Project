<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <ValidationProvider name="Sector" vid="sector_id" rules="required|min_value:1">
          <b-form-group
            label-for="sector_id"
            label-cols-lg="4"
            slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
            {{$t('rjscAdminPortal.entity_sector')}} <span class="text-danger">*</span>
          </template>
          <b-form-select
            plain
            v-model="form.sector_id"
            :options="entitySectorList"
            id="sector_id"
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
        <ValidationProvider name="Name (Bn)" vid="name_bn" v-slot="{ errors }">
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
import { entitySubSectorStore, entitySubSectorUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        sector_id: 0,
        name_en: '',
        name_bn: ''
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
    entitySectorList: function () {
      return this.$store.state.RjscService.commonObj.entitySectorList
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
        result = await RestApi.putData(rjscServiceBaseUrl, `${entitySubSectorUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, entitySubSectorStore, this.form)
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
