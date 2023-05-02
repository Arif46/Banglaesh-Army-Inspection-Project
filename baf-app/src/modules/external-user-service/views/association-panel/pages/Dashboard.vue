<template>
  <!-- <div>
      <b-row>
          <b-col>
              <h4 text="text-center p-1 mt-2">{{ $t('bfti.welcome_bfti_panel_dashboard') }}</h4>
          </b-col>
      </b-row>
  </div> -->
  <div class="section-wrapper bfti-dashboard-wrapper">
    <breadcumb />
    <div class="form-wrapper">
      <div class="mb-4 bg-white">
        <h5 class="title">{{ $t('associationPnl.dahboard_title') }}</h5>
        <!-- <b-overlay :show="loading" class="px-3"> -->
        <div class="px-4 pb-2">
          <div class="col-md-4 pb-4">
            <b-form-select v-model="search.fiscal_year_id" :options="fiscalYearList" size="sm">
              <template v-slot:first>
                <b-form-select-option :value="0">{{$t('eBizProgram.filter_by_fiscal_year')}}</b-form-select-option>
              </template>
            </b-form-select>
          </div>
        <b-overlay :show="loader">
          <b-row>
            <b-col sm="4" offset-md="1">
              <div class="card-item card-item-alt" style="background: #9c4fe8;padding: 20px 10px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h2 class="count"> {{ $n(dashData.total_proposal) }}</h2>
                  <p>{{$t('associationPnl.total_submitted_proposal') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-file-copy-2-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="4" offset-md="1">
              <div class="card-item card-item-alt" style="background: #00c182;padding: 20px 10px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h2 class="count"> {{ $n(dashData.approved_proposal) }} </h2>
                  <p>{{$t('associationPnl.total_approved_proposal') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-shield-check-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="4" offset-md="1">
              <div class="card-item card-item-alt" style="background: #67b5e2;padding: 20px 10px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h2 class="count"> {{ $n(dashData.total_program) }}</h2>
                  <p>{{ $t('associationPnl.total_no_of_program') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-file-copy-2-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="4" offset-md="1">
              <div class="card-item card-item-alt" style="background: #F2351A;padding: 20px 10px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h2 class="count"> {{ $n(dashData.pending_program) }} </h2>
                  <p>{{$t('associationPnl.total_pending_program') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-close-circle-fill"></i>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-overlay>
        </div>
        <!-- </b-overlay> -->
      </div>
    </div>
  </div>
</template>
<script>

import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { documentInformationApi } from '../api/routes'

export default {
  data () {
    return {
      search: {
        fiscal_year_id: 0
      },
      dashData: {},
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile,
      show: false,
      loader: false
    }
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.searchData()
      }
    }
  },
  computed: {
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  created () {
    this.searchData()
  },
  methods: {
    async searchData () {
      this.loadData = true
      this.loader = true
      let result = null
      const params = {
        fiscal_year_id: this.search.fiscal_year_id,
        association_info_id: this.profile.association_info_id,
        council_info_id: this.profile.council_info_id
      }
      result = await RestApi.getData(eBizServiceBaseUrl, documentInformationApi, params)
      if (result.success) {
        this.dashData = result.data
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
.external-db-sec {
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #fff;
  background-clip: border-box;
  border: 1px solid rgba(0, 0, 0, 0.125);
  border-radius: 0.25rem;
}

.external-db-sec .info-card {
  padding: 12px;
  color: #fff;
  border-radius: 8px;
  background: #5725cf;
}

.external-db-sec .icd-1 {
  background: #5725cf;
}

.external-db-sec .icd-2 {
  background: #27c7a9;
}

.external-db-sec .icd-3 {
  background: #d34a34;
}

.external-db-sec .icd-4 {
  background: #67b5e2;
}

.external-db-sec .info-card .info-value {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.external-db-sec .info-card .info-value .icon i {
  font-size: 30px;
}

.bfti-title {
  color: #fff;
  padding: 5px 10px;
  border-radius: 5px;
  margin-bottom: 1rem;
  background: #214162;
}

.bfti-title p {
  font-size: 18px;
}
</style>
