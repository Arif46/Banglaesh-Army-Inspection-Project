<template>
    <div class="policy-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>{{ $t('policyAdvocacy.policy_advocacy_management') }}</h5>
                    <div class="d-flex">
                        <div class="form">
                            <b-form-select
                             v-model="search.fiscal_year_id"
                             :options="fiscalYearList"
                              size="sm">
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('eBizProgram.filter_by_fiscal_year')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                        </div>
                        <div class="form ml-2">
                            <b-form-select
                            v-model="search.association_info_id" :options="associationInfoList"
                             size="sm">
                             <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('eBizProgram.filter_by_association')}}</b-form-select-option>
                            </template>
                             </b-form-select>
                        </div>
                    </div>
                </div>
            </template>
            <b-overlay :show="loader">
                <b-row>
                    <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                        <div class="info-item">
                            <p>{{ $t('policyAdvocacy.total_application') }}</p>
                            <div class="content">
                                <h2>{{$n(data.total_application)}}</h2>
                                <i class="ri-file-copy-2-fill"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                        <div class="info-item">
                            <p>{{ $t('policyAdvocacy.total_feedback') }}</p>
                            <div class="content">
                                <h2>{{$n(data.total_feedback)}}</h2>
                                <i class="ri-feedback-fill"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                        <div class="info-item">
                            <p>{{ $t('policyAdvocacy.total_approved') }}</p>
                            <div class="content">
                                <h2>{{$n(data.total_approved)}}</h2>
                                <i class="ri-shield-check-fill"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="info-card-wrapper">
                        <div class="info-item">
                            <p>{{ $t('policyAdvocacy.total_workshop') }}</p>
                            <div class="content">
                                <h2>{{$n(data.total_workshop)}}</h2>
                                <i class="ri-stack-fill"></i>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-overlay>
        </b-card>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { policyAdvocacyDashCount, uidRoute } from '../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
   mixins: [ModalBaseMasterList],
  data () {
    return {
      search: {
      fiscal_year_id: 0,
      form_date: '',
      to_date: '',
      association_info_id: 0
      },
      loader: false,
      itemList: [],
      cid: 0,
      lock: false,
      data: {},
      show: false
    }
  },
  created () {
    this.lock = false
    const uid = this.$store.state.Auth.authUser.user_id
    if (this.$store.state.Auth.activeRoleId > 1 && uid > 1) {
        this.userDetails(uid)
    }
    this.searchData()
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const fiscalYear = this.fiscalYearList.find(item => item.value === newVal)
        this.search.form_date = fiscalYear.start_date
        this.search.to_date = fiscalYear.end_date
        this.searchData()
      }
    },
    'search.association_info_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.searchData()
      }
    }
  },
  computed: {
   fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    associationInfoList () {
        if (this.lock === true) {
            return this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).filter(item => item.council_info_id === this.cid)
        } else {
            return this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1)
        }
    }
  },
  methods: {
    async userDetails (uid) {
    let result = null
    const params = Object.assign({}, { uid: uid })
    result = await RestApi.getData(eBizServiceBaseUrl, uidRoute, params)
        if (result.success) {
            if (result.counId > 0) {
                this.cid = result.counId
                this.lock = true
            } else {
                this.lock = false
            }
        } else {
            this.lock = false
        }
    },
    async searchData () {
      this.loadData = true
      this.loader = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(eBizServiceBaseUrl, policyAdvocacyDashCount, params)
      if (result.success) {
          this.data = result.data
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
.policy-wrapper-db .card .card-header {
    background: transparent;
}

.policy-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(255, 255, 255, 0.913);
    padding: 1rem;
    width: 100%;
    border-radius: 10px;
}

.policy-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item {
    background: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}

.policy-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item {
    background: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}
.policy-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item {
    background: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}
.policy-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item {
    background: #DE330D;
    background: linear-gradient(95deg, #fc4692 0%, #3f45fb 100%);
}
.policy-wrapper-db .card .info-card-wrapper .info-item .content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.policy-wrapper-db .card .info-card-wrapper .info-item .content i {
    font-size: 20px;
}
</style>
