<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.cip_trade_rejected_list') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col lg="3" md="3" sm="3">
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
          <b-col lg="3" md="3" sm="3">
            <b-form-group
              label-for="cip_sector_id"
            >
            <template v-slot:label>
              {{ $t('exportTrophyConfig.cip_sector') }}
            </template>
            <b-form-select
              plain
              v-model="search.cip_sector_id"
              :options="cipSectorList"
              id="cip_sector_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col lg="3" md="3" sm="3">
            <b-form-group
              label-for="name_en"
            >
              <template v-slot:label>
                {{ $t('globalTrans.name') }}
              </template>
              <b-form-input
                  id="name_en"
                  type="text"
                  v-model="search.name_en"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col lg="3" md="3" sm="3">
            <b-button size="sm" class="mt-20" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('cip.cip_trade_rejected_list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + 1) }}
                </template>
                <template v-slot:cell(id)="data">
                  <b-checkbox v-model="data.item.is_selected" true-value="1" false-value="0" />
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="detaislData(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                </template>
              </b-table>
              <b-pagination
                class="mt-20"
                v-model="pagination.currentPage"
                :perPage="search.limit"
                :total-rows="pagination.totalRows"
                @input="searchData"
              />
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="detailsItemId"  :item="item"/>
    </b-modal>
  </div>
</template>
<script>
import Details from '../cip-trade-rejected/Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipTradeRejctApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: { Details },
  data () {
    return {
      applications: [],
      status: 0,
      productServiceSectorList: [],
      search: {
        year: 0,
        cip_sector_id: 0,
        name_en: '',
        limit: 20
      },
      detailsItemId: '',
      item: ''
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    yearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    },
    columns () {
      const labels = [
        { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
        { label: this.$t('globalTrans.name'), class: 'text-center' },
        { label: this.$t('exportTrophyConfig.cip_sector'), class: 'text-center' },
        { label: this.$t('globalTrans.designation'), class: 'text-center' },
        { label: this.$t('globalTrans.action'), class: 'text-center' }
      ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'name_bn' },
          { key: 'sector_bn' },
          { key: 'fbcci_designation_en' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'name_en' },
          { key: 'sector_en' },
          { key: 'fbcci_designation_bn' },
          { key: 'action' }
        ]
      }

      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    cipSectorList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.filter(item => item.cip_category === 2)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    detaislData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, cipTradeRejctApi, params)
       if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const cipSectorObj = this.cipSectorList.find(tmp => tmp.value === item.cip_sector_id)
          const yearObj = this.$store.state.commonObj.yearList.find(tmp => tmp.value === item.year)

          const cipSectorData = {
            sector_bn: cipSectorObj !== undefined ? cipSectorObj.text_bn : '',
            sector_en: cipSectorObj !== undefined ? cipSectorObj.text_en : ''
          }

          const yearData = {
            year_bn: yearObj !== undefined ? yearObj.text_bn : '',
            year_en: yearObj !== undefined ? yearObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index + 1 }, cipSectorData, yearData)
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
