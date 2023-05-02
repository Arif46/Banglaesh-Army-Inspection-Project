<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('stock_management.dealer_penalty') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
        <b-col xs="12" sm="12" md="3" lg="3" xl="3">
          <ValidationProvider name="Application Id" vid="application_id" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="application_id">
              <template v-slot:label>
                {{ $t('stock_management.application_id') }}
              </template>
              <b-form-input
                id="application_id"
                v-model="search.application_id"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="start_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.from_date') }}
              </template>
                <date-picker
                  id="start_date"
                  v-model="search.start_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="end_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.to_date') }}
              </template>
                <date-picker
                  id="end_date"
                  v-model="search.end_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col sm="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('stock_management.dealer_penalty_list') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
            <div class="row">
              <div class="col-md-4">
              </div>
            </div>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(select)="data">
                      <b-form-checkbox
                        v-model="data.item.select"
                        @change="checkApplication(data.item)"
                      >
                      </b-form-checkbox>
                  </template>
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.index + 1) }}
                  </template>
                  <template v-slot:cell(application_id)="data">
                    {{ $n(data.item.application_id, { useGrouping: false })  }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn active view ml-3" variant=" iq-bg-success mr-1" :title="$t('globalTrans.view')" :to="`/license-registration-service/license-management/application-show/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
                    <b-button v-if="data.item.user_status != 3" :title="$t('stock_management.suspend')" variant=" iq-bg-success border-info" class="btn btn-danger ml-2" size="sm" @click="suspend(data.item)"><i class="ri-forbid-line"></i></b-button>
                    <b-button v-if="data.item.user_status === 3"  title="Reactive" variant=" iq-bg-success border-info" class="btn btn-success ml-2" size="sm" @click="reactive(data.item)"><i class="ri-restart-line"></i></b-button>
                    <b-button :title="$t('stock_management.deduct')" variant="iq-bg-info" class="btn btn-danger ml-2" size="sm"><router-link :to="{ path: '/license-registration-service/dealer-management/manage-information/dealer-deduct',query: { item: { user_id: data.item.user_id, application_id: data.item.id }}}"><i class="ri-money-dollar-box-line"></i></router-link></b-button>
                    <b-button :title="$t('globalTrans.cancel')" v-if="data.item.user_status != 2" class="btn active view mx-2" @click="detailsshow(data.item)" v-b-modal.details> <i class="ri-close-circle-fill"></i>
                    </b-button>
                  </template>
                </b-table>
              </slot>
              <div class="pagination-wrapper mt-3" v-if="columns.filter(item => item.show === '1').length > 0">
                <b-pagination
                  v-model="pagination.currentPage"
                  :perPage="search.limit"
                  :total-rows="pagination.totalRows"
                  @input="searchData"
                />
               </div>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="details" size="lg" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="item" />
    </b-modal>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dealerPenaltyList, dealerPenaltySuspend, dealerPenaltyReactive } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Details from './Details.vue'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      applications: [],
      item: null,
      valid: null,
      search: {
       application_id: '',
       start_date: '',
       end_date: '',
       limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1 },
        { labels: 'stock_management.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9 }
      ],
      actions: {
        edit: false,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  mounted () {
  },
  watch: {
  },
  computed: {
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'application_id' },
          { key: 'company_name_bn' },
          { key: 'status_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'application_id' },
          { key: 'company_name' },
          { key: 'status_en' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    detailsshow (item) {
     this.item = item
    },
    suspend (item) {
      this.changeStatus(8, licenseRegistrationServiceBaseUrl, dealerPenaltySuspend, item)
    },
    reactive (item) {
      this.changeStatus(8, licenseRegistrationServiceBaseUrl, dealerPenaltyReactive, item)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, dealerPenaltyList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const indexa = index
          let statusen = 'active'
          let statusbn = 'সক্রিয়'
          if (item.user_status === 2) {
              statusen = 'cancelled'
              statusbn = 'বাতিল'
          }
          if (item.user_status === 3) {
              statusen = 'Suspended'
              statusbn = 'স্থগিত'
          }
          const officeObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
          return Object.assign({}, item, { org_name_en: officeObj.text_en, org_name_bn: officeObj.text_bn, status_en: statusen, status_bn: statusbn, index: indexa })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>

<style>
.btn-success {
  background-color: var(--success) !important;
  border-color: var(--success);
}
</style>
