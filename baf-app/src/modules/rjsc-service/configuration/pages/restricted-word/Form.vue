<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
            <b-col md="6" sm="12">
              <ValidationProvider name="Type" vid="type_id" rules="required|min_value:1">
                <b-form-group label-for="type_id" slot-scope="{ valid, errors }">
                  <template v-slot:label>
                    {{$t('globalTrans.type')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select plain v-model="form.type_id" :options="typeList" id="type_id"
                    :state="errors[0] ? false : (valid ? true : null)">
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
          <b-col md="6" sm="12"></b-col>
          <b-col sm="6">
            <ValidationProvider name="Restricted Word (En)" vid="word_en" rules="required" v-slot="{ errors }">
              <b-form-group
              label-for="word_en">
              <template v-slot:label>
                {{ $t('rjscConfig.restricted_word') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="word_en"
                v-model="form.word_en"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Restricted Word (Bn)" vid="word_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="word_bn">
                <template v-slot:label>
                  {{ $t('rjscConfig.restricted_word') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                id="word_bn"
                v-model="form.word_bn"
                :state="errors[0] ? false : (valid ? true : null)"
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
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { restrictedWordStore, restrictedWordUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  components: {
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        word_en: '',
        word_bn: '',
        type_id: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getListData()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    typeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Government' : 'সরকারি' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Non-government' : 'বেসরকারি' }
      ]
      return list
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${restrictedWordUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, restrictedWordStore, this.form)
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
    getListData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
