<template>
    <div class="proposal-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>{{$t('eBizDashboard.proposal_management')}}</h5>
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
            <b-row no-gutters>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-file-user-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{ $t('eBizDashboard.total_circular') }}</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-file-list-2-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{ $t('eBizDashboard.total_proposal') }}</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-checkbox-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{ $t('eBizDashboard.approved_proposal') }}</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-time-fill"></i>
                        </div>
                        <div class="content">
                            <p>{{ $t('eBizDashboard.pending_proposal') }}</p>
                            <h4>045</h4>
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
<style scoped>
.proposal-wrapper-db .card .card-header {
    background: transparent;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(23, 23, 23, 0.913);
    padding: 1rem;
    width: 100%;
    display: flex;
    align-items: center;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item .icon {
    width: 35px;
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item .icon i {
    color: #fff;
    font-size: 20px;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon i {
    color: #6E3BFE;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon i {
    color: #09AB73;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon i {
    color: #0073E2;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon i {
    color: #DE1A0D;
}
.proposal-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon {
    background: #e0d4ff;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon {
    background: #c1fde8;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon {
    background: #b5dcff;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon {
    background: #fcd9d7;
}
.proposal-wrapper-db .card .info-card-wrapper .info-item .content {
    margin-left: .5rem;
}
</style>
