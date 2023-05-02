<template>
    <div class="program-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>{{$t('eBizDashboard.program_management')}}</h5>
                    <div class="d-flex">
                        <div class="form">
                            <b-form-select
                             v-model="search.fiscal_year_id"
                             :options="fiscalYearList"
                              size="sm">
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('eBizDashboard.filter_by_fiscal_year')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                        </div>
                        <div class="form ml-2">
                            <b-form-select
                            v-model="search.association_info_id" :options="associationInfoList"
                             size="sm">
                             <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('eBizDashboard.filter_by_association')}}</b-form-select-option>
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
                        <div class="icon">
                            <i class="ri-apps-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{$t('globalTrans.total')}} {{$t('eBizDashboard.program')}}</p>
                            <h2>{{$n(data.total)}}</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-shield-check-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{$t('eBizDashboard.approve_program')}}</p>
                            <h2>{{$n(data.approved)}}</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-file-copy-2-fill"></i>
                        </div>
                        <div class="content">
                           <p>{{$t('globalTrans.total')}} {{$t('eBizDashboard.agreement')}}</p>
                            <h2>{{$n(data.agreement)}}</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-timer-2-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{$t('eBizDashboard.pending_program')}}</p>
                            <h2>{{$n(data.pending)}}</h2>
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
import { programList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
   mixins: [ModalBaseMasterList],
  data () {
    return {
      search: {
      fiscal_year_id: 0,
      association_info_id: 0
      },
      loader: false,
      itemList: [],
      data: {},
      show: false
    }
  },
  created () {
    this.searchData()
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
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
      return this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    async searchData () {
      this.loadData = true
      this.loader = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(eBizServiceBaseUrl, programList, params)
      if (result.success) {
          this.data = result.data
        //   this.itemList = result.data.map((item, index) => {
        //         return Object.assign({}, item, { serial: index })
        //   })
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
.program-wrapper-db .card .card-header {
    background: transparent;
}

.program-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(31, 31, 31, 0.913);
    text-align: center;
    padding: 1rem;
    width: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
    border-radius: 10px;
}

.program-wrapper-db .card .info-card-wrapper .info-item .icon {
    color: #fff;
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
}
.program-wrapper-db .card .info-card-wrapper .info-item .icon i{
    font-size: 20px;
}
.program-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon {
    background: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon {
    background: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon {
    background: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon{
    background: linear-gradient(95deg, #DE1A0D 0%, #DE580D 100%);
}
.program-wrapper-db .card .info-card-wrapper:nth-child(1) {
    border-right: 1px solid #953BFE;
}

.program-wrapper-db .card .info-card-wrapper:nth-child(2) {
    border-right: 1px solid #1DCD6E;
}

.program-wrapper-db .card .info-card-wrapper:nth-child(3) {
    border-right: 1px solid #00B4E2;
}
.program-wrapper-db .card .info-card-wrapper .info-item .content {
    margin-top: .5rem;
}

.program-wrapper-db .card .info-card-wrapper .info-item .content i {
    font-size: 20px;
}
</style>
