<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <ValidationProvider name="Question (En)" vid="title_en" rules="required" v-slot="{ errors }">
          <b-form-group
            label-for="title_en">
            <template v-slot:label>
              {{ $t('rjscAdminPortal.question') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="title_en"
              v-model="form.title_en"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Question (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
          <b-form-group
            label-for="title_bn">
            <template v-slot:label>
              {{ $t('rjscAdminPortal.question') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="title_bn"
              v-model="form.title_bn"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Deatils (En)" vid="details_en" rules="required" v-slot="{ errors }">
          <b-form-group
              label-for="details_en"
          >
          <template v-slot:label>
              {{$t('globalTrans.details')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
          </template>
          <vue-editor
              id="details_en"
              v-model="form.details_en"
              :state="errors[0] ? false : (valid ? true : null)"
          ></vue-editor>
          <div class="invalid-feedback d-block">
              {{ errors[0] }}
          </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Deatils (Bn)" vid="details_bn" rules="required" v-slot="{ errors }">
            <b-form-group
                label-for="details_bn"
            >
            <template v-slot:label>
                {{$t('globalTrans.details')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
            </template>
            <vue-editor
                id="details_bn"
                v-model="form.details_bn"
                :state="errors[0] ? false : (valid ? true : null)"
            ></vue-editor>
            <div class="invalid-feedback d-block">
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
import { faqStore, faqUpdate } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      detailsItemId: '',
      form: {
        title_en: '',
        title_bn: '',
        details_en: '',
        details_bn: ''
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
        result = await RestApi.putData(rjscServiceBaseUrl, `${faqUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, faqStore, this.form)
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
