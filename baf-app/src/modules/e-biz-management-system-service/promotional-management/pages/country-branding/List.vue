<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizPromotional.country_branding') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="application_id"
            >
              <template v-slot:label>
                 {{ $t('globalTrans.application_id') }}
              </template>
              <b-form-input
                  id="application_id"
                  v-model="search.application_id"
              ></b-form-input>
            </b-form-group>
          </b-col>
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.from_date') }}
                </template>
                <date-picker
                  id="from_date"
                  class="form-control"
                  v-model="search.from_date"
                  :placeholder="$t('globalTrans.select')"
                >
                </date-picker>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="date"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.to_date') }}
                </template>
                <date-picker
                  id="to_date"
                  class="form-control"
                  v-model="search.to_date"
                  :placeholder="$t('globalTrans.select')"
                >
                </date-picker>
              </b-form-group>
          </b-col>
         <b-col xs="12" sm="12" md="4">
           </b-col>
          <b-col md="9">
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
        <h4 class="card-title">{{ $t('eBizPromotional.country_branding') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(expiry_date)="data">
                    <span v-if="data.item.expiry_date > '0000-00-00' ">
                    {{ data.item.expiry_date | dateFormat }}
                  </span>
                  </template>
                  <template v-slot:cell(application_id)="data">
                    {{ data.item.application_id }}
                  </template>
                  <template v-slot:cell(council_info_id)="data">
                    {{ getCouncilName(data.item.council_info_id) }}
                  </template>
                  <template v-slot:cell(association_info_id)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.approved_status == 0">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.approved_status == 1">{{$t('globalTrans.approved')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button :variant="data.item.approved_status === 0 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.approved_status === 0 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="approveStatus(data.item,1)">
                      <i :class="data.item.approved_status === 1  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i></b-button>
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
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { cbPromotionalList, cbPromotionalApprove } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
      search: {
        application_id: '',
        from_date: 0,
        to_date: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '13%' } },
        { labels: 'eBizConfig.council_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '13%' } },
        { labels: 'eBizProposal.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '13%' } },
        { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '13%' } },
        { labels: 'globalTrans.expiry_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '13%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '13%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '14%' } }
      ],
      items: [],
      viewitemId: 0,
      itemList: [],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      }
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
          { key: 'council_info_id' },
          { key: 'association_info_id' },
          { key: 'advertisement_title_bn' },
          { key: 'expiry_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'application_id' },
          { key: 'council_info_id' },
          { key: 'association_info_id' },
          { key: 'advertisement_title_en' },
          { key: 'expiry_date' },
          { key: 'status' },
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
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('eBizPromotional.country_branding') + ' ' + this.$t('globalTrans.view') : this.$t('eBizPromotional.country_branding') + ' ' + this.$t('globalTrans.modify')
    },
    formTitle () {
      return this.$t('eBizPromotional.country_branding') + ' ' + this.$t('globalTrans.approve')
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
        this.items = item
    },
    editProposal (item) {
       this.items = item
    },
    approveStatus (item, type) {
      window.vm.$swal({
        title: window.vm.$t('globalTrans.statusChangeMsg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.approve(item, type)
        }
      })
    },
    async approve (item, type) {
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        let result = null
        result = await RestApi.postData(eBizServiceBaseUrl, cbPromotionalApprove, item)
        if (result.success) {
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
            this.$toast.success({
              title: window.vm.$t('globalTrans.success'),
              message: window.vm.$t('globalTrans.update_msg'),
              color: '#D6E09B'
            })
            this.loadData()
          } else {
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
            this.$refs.form.setErrors(result.errors)
          }
    },
    getFiscalYear (id) {
      const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
      }
    },
    getCouncilName (councilNameId) {
      const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
      if (cateObj !== undefined) {
          if (this.$i18n.locale === 'bn') {
              return cateObj.text_bn
          } else {
              return cateObj.text_en
          }
      }
    },
    getAssociationName (associationId) {
      const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
      if (cateObj !== undefined) {
          if (this.$i18n.locale === 'bn') {
              return cateObj.text_bn
          } else {
              return cateObj.text_en
          }
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, cbPromotionalList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index, select: 0 })
        })
        this.itemList = listData
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
