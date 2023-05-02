<template>
  <div class="section-wrapper">
    <breadcumb />
    <div class="form-wrapper">
      <b-card>
      <template>
        <h4 class="card-title text-center bg-primary text-white">{{ $t('cip.cip_dashboard') }}</h4>
      </template>
        <b-row>
          <b-col sm="4" class="ml-1">
            <b-form-group
              label-for="year"
              label-cols-lg="3"
              class="mb-0 mt-3 ml-2"
            >
            <template v-slot:label>
              {{$t('globalTrans.year')}}
            </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="YearList"
                id="year"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button size="sm" variant="primary" class="mt-3" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </b-card>
    </div>
    <b-overlay :show="cusLoading">
      <b-card title="">
        <b-card-text>
          <b-row>
            <b-col sm="12" md="3">
              <div class="mc-report-card p-3 bg-primary text-light">
                <p>{{ $t('cip.total_applicants')}}</p>
                <h4>{{ $n(etDataCount.total_application, { useGrouping: false }) }}</h4>
                <div class="icon-wrapper">
                  <i class="ri-store-2-line"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="12" md="3">
              <div class="mc-report-card p-3 bg-warning text-light">
                <p>{{ $t('cip.primary_applicants')}}</p>
                <h4>{{ $n(etDataCount.primary_selected, { useGrouping: false }) }}</h4>
                <div class="icon-wrapper">
                  <i class="ri-file-damage-line"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="12" md="3">
              <div class="mc-report-card p-3 bg-success text-light">
                <p>{{ $t('cip.final_applicants')}}</p>
                <h4>{{ $n(etDataCount.final_selected, { useGrouping: false }) }}</h4>
                <div class="icon-wrapper">
                  <i class="ri-exchange-funds-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="12" md="3">
              <div class="mc-report-card p-3 bg-info text-light">
                <p>{{ $t('cip.pending_application')}}</p>
                <h4>{{ $n(etDataCount.pending_application, { useGrouping: false }) }}</h4>
                <div class="icon-wrapper">
                  <i class="ri-exchange-funds-fill"></i>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-card-text>
      </b-card>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { dashboardApi } from '../api/routes'
export default {
  data () {
    return {
      search: {
        year: 0
      },
      etDataCount: [],
      cusLoading: false
    }
  },
  created () {
    this.searchData()
  },
  computed: {
    YearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    }
  },
  methods: {
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async searchData () {
      this.cusLoading = true
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, dashboardApi, this.search)
      if (result.success) {
        this.etDataCount = result.data
        this.cusLoading = false
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
