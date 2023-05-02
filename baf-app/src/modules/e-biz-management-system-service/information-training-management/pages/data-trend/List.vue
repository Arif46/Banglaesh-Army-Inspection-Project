<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
      </template>
      <template v-slot:searchBody>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('informationTraining.data_trend') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <template>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"
                enctype="multipart/form-data">
                <b-row>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Agro Link" vid="agro_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="agro_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.agro_link') }}
                        </template>
                        <b-form-input id="agro_link" v-model="form.agro_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Fishery Link" vid="fishery_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="fishery_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.fishery_link') }}
                        </template>
                        <b-form-input id="fishery_link" v-model="form.fishery_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Medicine Link" vid="medicine_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="medicine_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.medicine_link') }}
                        </template>
                        <b-form-input id="medicine_link" v-model="form.medicine_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Light Engineering Link" vid="light_engineering_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="light_engineering_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.light_engineering_link') }}
                        </template>
                        <b-form-input id="light_engineering_link" v-model="form.light_engineering_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Leather Link" vid="leather_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="leather_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.leather_link') }}
                        </template>
                        <b-form-input id="leather_link" v-model="form.leather_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Ict Link" vid="ict_link" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="ict_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.ict_link') }}
                        </template>
                        <b-form-input id="ict_link" v-model="form.ict_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Plastic Link" vid="plastic_link" rules="" v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="plastic_link">
                        <template v-slot:label>
                          {{ $t('informationTraining.plastic_link') }}
                        </template>
                        <b-form-input id="plastic_link" v-model="form.plastic_link"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>

                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.update') }}</b-button>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </template>
     </template>
    </body-card>
  </div>
</template>

<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { informationDataTrendsList, informationDataTrendsStore, informationDataTrendsUpdate } from '../../api/routes'
export default {
  name: 'Form',
  components: {
  },
  data () {
    return {
      valid: null,
      id: 0,
      Update: '',
      errors: [],
      form: {
        agro_link: '',
        fishery_link: '',
        medicine_link: '',
        light_engineering_link: '',
        leather_link: '',
        ict_link: '',
        plastic_link: ''
      }
    }
  },
  created () {
    this.loadData()
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
        result = await RestApi.putData(eBizServiceBaseUrl, `${informationDataTrendsUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, informationDataTrendsStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, informationDataTrendsList, params)
      if (result.success) {
        const listData = result.data
        if (listData !== null) {
          this.id = listData.id
          this.form.agro_link = listData.agro_link
          this.form.fishery_link = listData.fishery_link
          this.form.medicine_link = listData.medicine_link
          this.form.light_engineering_link = listData.light_engineering_link
          this.form.leather_link = listData.leather_link
          this.form.ict_link = listData.ict_link
          this.form.plastic_link = listData.plastic_link
        }
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
