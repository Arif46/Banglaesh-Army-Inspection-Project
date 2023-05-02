<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('demo.welcome_license_service_dashboard') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="regional_office"
            >
              <template v-slot:label>
                {{ $t('allocation_management.regional_office') }}
              </template>
                 <b-form-select
                  plain
                  v-model="search.office_id"
                  :options="regionalOfficeList"
                  id="organization"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Start date" vid="from_date" rules="''" v-slot="{ errors }">
              <b-form-group label-for="from_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_from') }}
                </template>
                <date-picker
                  id="from_date"
                  v-model="search.from_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="4" xl="4">
            <ValidationProvider name="End date" vid="to_date" rules="''" v-slot="{ errors }">
              <b-form-group label-for="to_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_to') }}
                </template>
                <date-picker
                  id="to_date"
                  v-model="search.to_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>

      <div class="p-3">
        <b-overlay :show="loader">
          <div class="row">
              <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                  <b-card bg-variant="primary" class="text-center">
                      <h4 class="text-light">{{$n(status.totalApp)}}</h4>
                    <b-card-text b-card-text class="text-light">{{$t('demo.total')}} {{$t('demo.application')}}</b-card-text>
                  </b-card>
              </b-col>
              <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                  <b-card bg-variant="primary" class="text-center">
                      <h4 class="text-light">{{$n(status.pending)}}</h4>
                    <b-card-text b-card-text class="text-light">{{$t('demo.pending')}} {{$t('demo.application')}}</b-card-text>
                  </b-card>
              </b-col>
              <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                  <b-card bg-variant="primary" class="text-center">
                      <h4 class="text-light">{{$n(status.approve)}}</h4>
                    <b-card-text b-card-text class="text-light">{{$t('demo.approved')}} {{$t('demo.application')}}</b-card-text>
                  </b-card>
              </b-col>
              <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                  <b-card bg-variant="primary" class="text-center">
                      <h4 class="text-light">{{$n(status.reject)}}</h4>
                    <b-card-text b-card-text class="text-light">{{$t('demo.rejected')}} {{$t('demo.application')}}</b-card-text>
                  </b-card>
              </b-col>
              <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                  <b-card bg-variant="primary" class="text-center">
                      <h4 class="text-light">{{$n(status.processing)}}</h4>
                    <b-card-text b-card-text class="text-light">{{$t('demo.processing')}} {{$t('demo.application')}}</b-card-text>
                  </b-card>
              </b-col>
          </div>
        </b-overlay>
      </div>
      <!-- search section end -->
    </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dasbhoard } from '../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
   mixins: [ModalBaseMasterList],
  data () {
    return {
      search: {
      office_id: 0,
      from_date: '',
      to_date: ''
      },
      loader: false,
      itemList: [],
      status: {},
      show: false
    }
  },
  created () {
    this.searchData()
  },
  computed: {
    regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.org_id === 7 && item.is_regional_office === 1))
    }
  },
  methods: {
    async searchData () {
      this.loadData = true
      this.loader = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, dasbhoard, params)
      if (result.success) {
          this.status = result.status
          this.itemList = result.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
      })
          this.loadData = false
          this.show = true
          this.loader = false
      } else {
          this.loadData = false
          this.loader = false
      }
    }
  }
}
</script>
<style>
  .mc-report-card {
    position: relative;
    margin-bottom: 10px;
    border-radius: var(--border-radius-md);
  }
  .icon-wrapper {
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translate(0, -50%);
    color: rgba(255, 255, 255, .3);
    font-size: 3.6rem;
  }
</style>
