<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophy.profile_scrutiny_evaluation') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="3">
              <b-form-group
                label-for="year"
              >
              <template v-slot:label>
                {{$t('globalTrans.year')}}
              </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="yearList"
                id="year"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="type"
            >
              <template v-slot:label>
                {{$t('globalTrans.type')}}
              </template>
              <b-form-select
                plain
                v-model="search.sector_type"
                :options="productServiceTypeList"
                id="type"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="product_service_sector_id"
              >
              <template v-slot:label>
                {{$t('exportTrophy.product_service_sector')}}
              </template>
              <v-select name="production_season_id"
                v-model="search.product_service_sector_id"
                label="text"
                :reduce="item => item.value"
                :options= productServiceSectorList
                :placeholder="$t('globalTrans.select')"
              />
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button class="mt-20" size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('exportTrophy.profile_scrutiny_evaluation') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction v-if="headerActionShow">
        <b-overlay :show="loading">
          <a href="javascript:" class="btn-add mr-2" v-b-modal.modal-meeting-resolution> {{ $t('cip.meeting_resolution') }}</a>
          <a v-if="!showSendBtn" href="javascript:" class="btn-add" v-b-modal.modal-remark> {{ $t('cip.sorting_send') }}</a>
        </b-overlay>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(total_application) = "data">
                  {{ $n(data.item.total_application, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="showApplicant(data.item.product_service_sector_id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                </template>
              </b-table>
              <b-pagination
                class="mt-20"
                v-model="pagination.currentPage"
                :per-page="pagination.perPage"
                :total-rows="pagination.totalRows"
                @input="searchData"
              />
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-meeting-resolution" size="lg" :title="$t('cip.prev_meeting_resolution')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <MeetingResolution :circular_id="circularId" :key="circularId"/>
    </b-modal>
    <b-modal id="modal-remark" size="md" :title="$t('globalTrans.remark')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Remark :circular_id="circularId" :current_status="5" :status="6" :menu_name_id="2" :key="circularId"/>
    </b-modal>
  </div>
</template>
<script>
import Remark from '../Remark.vue'
import MeetingResolution from '../MeetingResolution.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { scrutinyEvaluationApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Remark, MeetingResolution
  },
  data () {
    return {
      headerActionShow: false,
      loading: false,
      meetingResolutionShow: false,
      previousRemark: null,
      showSendBtn: false,
      circularId: 0,
      overallApplication: 0,
      search: {
        year: 0,
        sector_type: 0,
        product_service_sector_id: '',
        limit: 20
      },
      labelData: [],
      productServiceSectorList: [],
      status: 0,
      noteTitle: '',
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.sector_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.search.product_service_sector_id = ''
        this.productServiceSectorList = this.getProductServiceSectorList(newVal)
      }
    },
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.productServiceLocaleChange()
      }
    }
  },
  computed: {
    yearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    },
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('exportTrophyConfig.product_or_service_sector_name'), class: 'text-center' },
          { label: this.$t('globalTrans.total_application'), class: 'text-center' },
          { label: this.$t('globalTrans.action'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'product_service_name_bn' },
          { key: 'total_application' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'product_service_name_en' },
          { key: 'total_application' },
          { key: 'action' }
        ]
      }

      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    showApplicant (productServiceId) {
      this.$router.push({
        path: `/export-trophy-cip-service/cip/profile-scrutiny-evaluation-applicants?id=${productServiceId}`
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, scrutinyEvaluationApi, params)
      if (result.success) {
        this.headerActionShow = true
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
        // send button show when meeting resolution added
        if (this.overallApplication === result.total_app) {
          this.showSendBtn = true
        } else {
          this.showSendBtn = false
        }
        this.circularId = result.data.data[0].circular_id
      } else {
        this.headerActionShow = false
        this.$store.dispatch('setList', [])
        this.paginationData([])
        this.showSendBtn = false
        this.circularId = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      let total = 0
      const productServiceList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const dataList = data.map((item, index) => {
        total = total + item.total_application
        const productService = productServiceList.find(tmp => tmp.value === item.product_service_sector_id)

        const productServiceData = {
          serial: index,
          product_service_name_en: productService.text_en,
          product_service_name_bn: productService.text_bn
        }
        this.circularId = item.circular_id
        return Object.assign({}, item, productServiceData)
      })
      this.overallApplication = total
      return dataList
    },
    getProductServiceSectorList (sectorType) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(sector => sector.type === sectorType && sector.assign_for === 1)
    },
    productServiceLocaleChange () {
      this.productServiceSectorList = this.productServiceSectorList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    }
  }
}
</script>
