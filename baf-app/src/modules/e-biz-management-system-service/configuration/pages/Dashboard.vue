<template>
    <div class="external-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>{{$t('eBizConfig.dashboard')}}</h5>
                    <div class="d-flex">
                         <div class="form ml-2">
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
                             :disabled="lock"
                             v-model="search.council_info_id"
                             :options="councilInfoList"
                              size="sm">
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{ $t('eBizProgram.filter_by_council') }}</b-form-select-option>
                            </template>
                            </b-form-select>
                        </div>
                        <div class="form ml-2">
                            <b-form-select
                            v-model="search.association_info_id" :options="associationList"
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
               <div class="row">
                   <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>{{ $n(dashData.total_proposal) }}</h2>
                        </div>
                        <div class="content">
                            <i class="ri-file-copy-2-fill"></i>
                            <p>{{ $t('eBizProposal.total_proposal') }}</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>{{$n(dashData.total_program)}}</h2>
                        </div>
                        <div class="content">
                            <i class="ri-apps-fill"></i>
                            <p>{{$t('eBizProgram.total_program')}}</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>{{$n(dashData.total_application)}}</h2>
                        </div>
                        <div class="content">
                            <i class="ri-checkbox-multiple-fill"></i>
                            <p>{{ $t('policyAdvocacy.total_policy')}}</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>{{$n(dashData.total_products)}}</h2>
                        </div>
                        <div class="content">
                            <i class="ri-timer-2-fill"></i>
                            <p>{{$t('eBizPromotional.total_promoted_product')}}</p>
                        </div>
                    </div>
                </b-col>
               </div>
            </b-overlay>
        </b-card>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { eBizDasboardRoute, uidRoute } from '../api/routes'
export default {
    data () {
        return {
            selected: null,
            search: {
              association_info_id: 0,
              fiscal_year_id: 0,
              council_info_id: 0,
              form_date: '',
              to_date: ''
            },
            lock: false,
            dashData: {},
            associationList: [],
            show: false,
            loader: false
        }
    },
     watch: {
      'search.council_info_id': function (newVal, oldVal) {
        if ((newVal !== oldVal)) {
            this.associationList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
            this.searchData()
          }
      },
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
    created () {
        this.lock = false
        const uid = this.$store.state.Auth.authUser.user_id
        if (this.$store.state.Auth.activeRoleId > 1 && uid > 1) {
            this.userDetails(uid)
        }
      this.searchData()
    },
    computed: {
        fiscalYearList () {
          return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
        },
        councilInfoList () {
          return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
        }
    },
    methods: {
        async userDetails (uid) {
        let result = null
        const params = Object.assign({}, { uid: uid })
        result = await RestApi.getData(eBizServiceBaseUrl, uidRoute, params)
        if (result.success) {
            if (result.counId > 0) {
                this.search.council_info_id = result.counId
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
        result = await RestApi.getData(eBizServiceBaseUrl, eBizDasboardRoute, params)
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
.external-wrapper-db .card .card-header{
    background: transparent;
}
.external-wrapper-db .card .info-card-wrapper .info-item{
    margin-top: 30px;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 10px;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item{
    border: 1px solid #6E3BFE;
    background: #F8F2FF;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item{
    border: 1px solid #09AB73;
    background: #D8FFF1;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item{
    border: 1px solid #0073E2;
    background: #DDEEFF;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item{
    border: 1px solid #DE330D;
    background: #FFEEE9;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #DE330D;
    background: linear-gradient(95deg, #DE1A0D 0%, #DE580D 100%);
}
.external-wrapper-db .card .info-card-wrapper .info-item .count-box{
    color: #fff;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10px;
}
.external-wrapper-db .card .info-card-wrapper .info-item .content{
    text-align: center;
    padding: .5rem .2rem;
}
.external-wrapper-db .card .info-card-wrapper .info-item .content i{
    font-size: 20px;
}
</style>
