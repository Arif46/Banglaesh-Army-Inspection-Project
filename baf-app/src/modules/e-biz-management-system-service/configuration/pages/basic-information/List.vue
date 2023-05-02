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
        <h4 class="card-title">{{ $t('eBizConfig.basic_information') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <template>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"
                enctype="multipart/form-data">
                <b-row>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Address (En)" vid="address" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="address">
                        <template v-slot:label>
                          {{ $t('eBizConfig.address') }} {{$t('globalTrans.en')}}
                        </template>
                        <b-form-input id="address" v-model="form.address"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Address (Bn)" vid="address_bn" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="address_bn">
                        <template v-slot:label>
                          {{ $t('eBizConfig.address') }} {{$t('globalTrans.bn')}}
                        </template>
                        <b-form-input id="address_bn"
                           v-model="form.address_bn"
                           :state="errors[0] ? false : (valid ? true : null)
                         "></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Phone" vid="phone" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="phone">
                        <template v-slot:label>
                          {{ $t('eBizConfig.phone') }}
                        </template>
                        <b-form-input id="phone" v-model="form.phone"
                          :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="8" md="8" sm="12">
                    <ValidationProvider name="Website" vid="website" rules=""
                      v-slot="{ errors }">
                      <b-form-group label-cols-sm="4" label-for="website">
                        <template v-slot:label>
                          {{ $t('eBizConfig.website') }}
                        </template>
                        <b-form-input id="website" v-model="form.website"
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
import { basicInformationsList, basicInformationsStore, basicInformationsUpdate } from '../../api/routes'
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
        address: '',
        address_bn: '',
        phone: '',
        website: '',
        facebook: '',
        youtube: '',
        email: '',
        linkedIn: ''
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
        result = await RestApi.putData(eBizServiceBaseUrl, `${basicInformationsUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, basicInformationsStore, this.form)
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
      const result = await RestApi.getData(eBizServiceBaseUrl, basicInformationsList, params)
      if (result.success) {
        const listData = result.data
        if (listData !== null) {
          this.id = listData.id
          this.form.address = listData.address
          this.form.address_bn = listData.address_bn
          this.form.phone = listData.phone
          this.form.website = listData.website
          this.form.facebook = listData.facebook
          this.form.youtube = listData.youtube
          this.form.email = listData.email
          this.form.linkedIn = listData.linkedIn
        }
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
