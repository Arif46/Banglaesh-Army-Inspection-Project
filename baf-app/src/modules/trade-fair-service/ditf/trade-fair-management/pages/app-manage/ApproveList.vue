<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('ditfAppTradeFairManages.ditf_approve_app') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form id="form" @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off">
              <b-row>
                <b-col sm="4">
                  <ValidationProvider name="Year" vid="year" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="year">
                      <template v-slot:label>
                        {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        id="year"
                        :options="yearList"
                        v-model="search.year"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col sm="4">
                  <ValidationProvider name="Title" vid="fair_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="fair_id">
                      <template v-slot:label>
                        {{ $t('globalTrans.title') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        id="fair_id"
                        :options="dhakaFairList"
                        v-model="search.fair_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col sm="4">
                  <ValidationProvider name="Circular type" vid="circular_type" rules="" v-slot="{ errors }">
                    <b-form-group
                      label-for="circular_type">
                      <template v-slot:label>
                        {{ $t('ditfTradeFairManages.circular_type') }}
                      </template>
                      <b-form-select
                        plain
                        id="circular_type"
                        :options="circularTypeList"
                        v-model="search.circular_type"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col sm="4">
                  <b-button type="submit" size="sm" variant="primary"><i class="ri-search-line"></i> {{ $t('globalTrans.search') }}</b-button>
                </b-col>
              </b-row>
            </b-form>
          </b-overlay>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('ditfAppTradeFairManages.ditf_approve_app') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(phone_no)="data">
                    {{ EngBangNum(data.item.phone_no.toString()) }}
                  </template>
                  <template v-slot:cell(year)="data">
                    {{ $n(data.item.year, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status === 1">
                      {{$t('globalTrans.pending')}}
                    </span>
                    <span class="badge badge-info" v-if="data.item.status === 2">
                      {{ $t('globalTrans.approve') }}
                    </span>
                    <span class="badge badge-danger" v-if="data.item.status === 3">
                      {{ $t('globalTrans.reject') }}
                    </span>
                    <span class="badge badge-warning" v-if="data.item.status === 4">
                      {{ $t('globalTrans.return') }}
                    </span>
                    <span class="badge badge-warning" v-if="data.item.status === 5">
                      {{ $t('globalTrans.resubmit') }}
                    </span>
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
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { approveAppsList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      valid: '',
      sortBy: '',
      search: {
        year: 0,
        fair_id: 0,
        circular_type: 0,
        limit: 20
      },
      dhakaFairList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'ditfTradeFairManages.circular_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'ditfAppTradeFairManages.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
        { labels: 'ditfAppTradeFairManages.org_address', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.contact_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.search.year = new Date().getFullYear()
    this.loadData()
  },
  watch: {
    'search.year': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.dhakaFairList = this.dhakaFair()
      }
    },
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    selectedItem: function () {
      if (this.selectedItem.length === this.listData.length) {
        this.selectAll = true
      }
      if (this.selectedItem.length < this.listData.length) {
        this.selectAll = false
      }
    }
  },
  computed: {
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
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
          { key: 'year' },
          { key: 'circular_type_bn' },
          { key: 'comp_name_bn' },
          { key: 'org_address' },
          { key: 'phone_no' },
          { key: 'status' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'year' },
          { key: 'circular_type_en' },
          { key: 'comp_name_en' },
          { key: 'org_address' },
          { key: 'phone_no' },
          { key: 'status' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    circularTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    dhakaFair () {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === this.search.year).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, approveAppsList, params)
      if (result.success) {
        this.selectedItem = []
        const listData = result.data.data.map((item, index) => {
          const circularTypeObj = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(tmp => tmp.value === item.circular_type)
          const circularTypeData = {
            circular_type_bn: circularTypeObj !== undefined ? circularTypeObj.text_bn : '',
            circular_type_en: circularTypeObj !== undefined ? circularTypeObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index }, circularTypeData)
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
