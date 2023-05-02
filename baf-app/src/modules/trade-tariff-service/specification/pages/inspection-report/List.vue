<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">Search</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
            <ValidationProvider name="Demand No" vid="demand_no" v-slot="{ errors }">
              <b-form-group
                label-for="alert_percentage">
                <template v-slot:label>
                Indent No
                </template>
                <b-form-input
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                id="demand_no"
                v-model="search.demand_no"
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
            <ValidationProvider name="Supplier Name" vid="supplier_name" v-slot="{ errors }">
              <b-form-group
                label-for="supplier_name">
                <template v-slot:label>
                Supplier Name
                </template>
                <b-form-input
                  id="supplier_name"
                  v-model="search.supplier_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="text-left mt-4">
            <b-button size="sm" variant="primary" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">Indent Offer Report</h4>
              </template>
              <template v-slot:headerAction>
              </template>
              <template v-slot:body>
                <b-overlay :show="loadingState">
                  <div style="border:2px solid;margin:10px;padding:10px">
                    <template>
                      <div class="text-black mb-4">
                        <ReportHeading />
                        <b-row class="mt-5">
                          <!-- <template>
                            <div class="table-wrapper table-responsive mt-4">
                              <h4>Demand No: {{ item.demand_no }}</h4>
                              <table class="table table-striped table-hover table-bordered">
                                <b-thead>
                                  <tr>
                                    <b-th class="text-center" width="7%">SL NO</b-th>
                                    <b-th class="text-center" width="15%">Demand No</b-th>
                                    <b-th class="text-center" width="15%">Supplier Name</b-th>
                                    <b-th class="text-center" width="20%">Fully Comply</b-th>
                                    <b-th class="text-center" width="20%">Partially Comply</b-th>
                                    <b-th class="text-center" width="20%">Reject</b-th>
                                  </tr>
                                </b-thead>
                                <b-tbody>
                                  <template v-if="datas.length">
                                    <template v-for="(item, index) in datas">
                                      <b-tr :key="index">
                                        <b-td class="text-center">{{ index+1 }}</b-td>
                                        <b-td class="text-center">{{ item.demand_no }}</b-td>
                                        <b-td class="text-center">{{ item.supplier_name }}</b-td>
                                        <b-td class="text-center">{{ item.total_fully_comply }}</b-td>
                                        <b-td class="text-center">{{ item.total_partially_comply }}</b-td>
                                        <b-td class="text-center">{{ item.total_reject }}</b-td>
                                      </b-tr>
                                    </template>
                                  </template>
                                  <template v-else>
                                    <b-tr>
                                      <b-td class="text-center text-danger" colspan="6">Data Not Found</b-td>
                                    </b-tr>
                                  </template>
                                </b-tbody>
                              </table>
                            </div>
                          </template> -->
                          <template v-if="datas.length">
                              <b-row v-for="(item, parentIndex) in datas" :key="parentIndex">
                                <b-col>
                                  <h6>Indent No : {{ item.demand_no }}</h6>
                                  <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                                    <b-thead>
                                      <b-tr>
                                        <b-th class="text-center" width="7%">SL NO</b-th>
                                        <b-th class="text-center" width="15%">Supplier Name</b-th>
                                        <b-th class="text-center" width="20%">Fully Comply</b-th>
                                        <b-th class="text-center" width="20%">Partially Comply</b-th>
                                        <b-th class="text-center" width="20%">Reject</b-th>
                                        <b-th class="text-center" width="20%">Result</b-th>
                                      </b-tr>
                                    </b-thead>
                                    <b-tbody>
                                        <b-tr v-for="(info, index) in item.demand_info" :key="index">
                                          <b-td class="text-center">{{ index+1 }}</b-td>
                                          <b-td class="text-center">{{ info.supplier_name }}</b-td>
                                          <b-td class="text-center">{{ info.total_fully_comply }}</b-td>
                                          <b-td class="text-center">{{ info.total_partially_comply }}</b-td>
                                          <b-td class="text-center">{{ info.total_reject }}</b-td>
                                          <b-td class="text-center">{{ getResultStatus(info.result_id) }}</b-td>
                                        </b-tr>
                                    </b-tbody>
                                  </b-table-simple>
                                </b-col>
                              </b-row>
                            </template>
                            <template v-else>
                              <div class="text-center">
                                  {{ $t('globalTrans.noDataFound') }}
                                </div>
                            </template>
                        </b-row>
                      </div>
                    </template>
                  </div>
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { InspectionServiceBaseUrl } from '@/config/api_config'
import { specificationReportApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ReportHeading from '../../components/ReportHeading.vue'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ReportHeading
  },
  data () {
    return {
      InspectionServiceBaseUrl: InspectionServiceBaseUrl,
      sortBy: '',
      search: {
        demand_no: '',
        supplier_name: ''
      },
      datas: [],
      showData: false,
      valid: {}
    }
  },
  created () {
  },
  mounted () {
  },
  computed: {
  },
  watch: {
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(InspectionServiceBaseUrl, specificationReportApi, params)
      if (result.success) {
        this.datas = result.data
      } else {
        this.datas = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getResultStatus (item) {
      if (item === 1) {
        return 'Accept'
      } else if (item === 2) {
        return 'Reject'
      } else {
        return ''
      }
    }
  }
}
</script>
