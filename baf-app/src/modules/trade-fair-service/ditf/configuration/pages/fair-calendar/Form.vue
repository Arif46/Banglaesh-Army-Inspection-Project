<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Year" vid="year" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="year">
                <template v-slot:label>
                  {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="data.year"
                  :options="yearList"
                  id="year"
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
            <ValidationProvider name="Title (En)" vid="title_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_en">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_en"
                  v-model="data.title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="data.title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  plain
                  v-model="data.description_en"
                  id="description_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                </b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  plain
                  v-model="data.description_bn"
                  id="description_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                </b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Start Date" vid="start_date" rules="required">
              <b-form-group
                class="row"
                label-for="start_date"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('globalTrans.start_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="start_date"
                  v-model="data.start_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="{ static: true }"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="End Date" vid="end_date" rules="required">

              <b-form-group
                class="row"
                label-for="end_date"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="end_date"
                  v-model="data.end_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  :config="{ static: true }"
                >
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
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairCalendarStore, fairCalendarUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      data: {
        start_date: '',
        end_date: '',
        year: 0,
        description_en: '',
        description_bn: '',
        title_en: '',
        title_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditData()
      this.data = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.$n(item, { useGrouping: false }) }
        } else {
          return { value: item, text: item }
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
        result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${fairCalendarUpdate}/${this.id}`, this.data)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairCalendarStore, this.data)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
