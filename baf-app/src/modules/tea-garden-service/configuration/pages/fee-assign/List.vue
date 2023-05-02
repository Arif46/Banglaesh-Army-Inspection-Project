<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.fee_assign') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
            label-for="service_id"
          >
            <template v-slot:label>
              {{ $t('teaGardenConfig.service_name') }}
            </template>
          <b-form-select
              plain
              v-model="search.service_id"
              :options="portalServiceNameList"
              id="service_id"
              >
          <template v-slot:first>
              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
          </template>
          </b-form-select>
          </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
            label-for="fee_type_id"
          >
            <template v-slot:label>
              {{ $t('teaGardenConfig.fee_type') }}
            </template>
          <b-form-select
              plain
              v-model="search.fee_type_id"
              :options="feeTypesList"
              id="fee_type_id"
              >
          <template v-slot:first>
              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
          </template>
          </b-form-select>
          </b-form-group>
          </b-col>
          <b-col sm="4">
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
      <h4 class="card-title">{{ $t('teaGardenConfig.fee_assign') }} {{ $t('globalTrans.list') }}</h4>
    </template>
      <template v-slot:headerAction>
      <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
    </template>
    <template v-slot:body>
      <b-overlay :show="loadingState">
        <select-column-check :labelData="labelData" :search="search" :columns="columns" />
        <b-row>
          <b-col md="12" class="table-responsive">
            <slot v-if ="columns.filter(item => item.show === '1').length > 0">
              <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                <template v-slot:cell(serial)="data">
                  {{ $n(data.item.serial + pagination.slOffset) }}
                </template>
                 <template v-slot:cell(validity_period)="data">
                  {{ $n(data.item.validity_period) }}
                </template>
                <template v-slot:cell(amount)="data">
                  <slot v-if="data.item.custom_amount">
                    {{ $n(1) }}) {{ $t('teaGardenConfig.fee_amount') }} {{ $n(data.item.amount) }}
                    <br>
                    {{ $n(2) }}) {{ $t('teaGardenConfig.custom_amount') }} {{ $n(data.item.custom_amount) }}
                  </slot>
                  <slot v-else>
                    {{ $n(data.item.amount) }}
                  </slot>
                </template>
                <template v-slot:cell(effective_from)="data">
                  {{ data.item.effective_from | dateFormat }}
                </template>
                <template v-slot:cell(status)="data">
                  <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                  <span class="badge badge-success" v-else-if="data.item.status == 2">{{$t('globalTrans.inactive')}}</span>
                  <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                </template>
                <template v-slot:cell(action)="data">
                  <b-button class="moc-action-btn moc-view-btn" v-b-modal.modal-form-details @click="details(data.item)" :title="$t('globalTrans.view')">
                    <i class="ri-eye-line"></i>
                  </b-button>
                  <b-button class="moc-action-btn moc-edit-btn" v-b-modal.modal-form @click="edit(data.item)" :title="$t('globalTrans.edit')">
                    <i class="ri-pencil-fill"></i>
                  </b-button>
                  <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" @click="remove(data.item)" title="active" v-b-modal.details>
                    <i :class="data.item.status === 2 ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
      <!-- search section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
    <Form :id="editItemId" :key="editItemId"/>
  </b-modal>
  <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
    <Details  :item="item" ref="details"/>
  </b-modal>
  </div>
</template>
<script>
  import Form from './Form.vue'
  import Details from './Details'
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { feeAssignListApi, feeAssignToggleApi } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Form, Details
    },
    data () {
      return {
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        item: '',
        search: {
            service_id: 0,
            fee_type_id: 0,
          limit: 20
        },
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
          { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
          { labels: 'teaGardenConfig.fee_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '13%' } },
          { labels: 'teaGardenConfig.fee_amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
          { labels: 'teaGardenConfig.effective_from', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '12%' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '7%' } },
          { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7, thStyle: { width: '12%' } }
        ],
        actions: {
          edit: true,
          toogle: true,
          details: true,
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
          { key: 'service_bn' },
          { key: 'type_bn' },
          { key: 'amount' },
          { key: 'effective_from' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'service_en' },
          { key: 'type_en' },
          { key: 'amount' },
          { key: 'effective_from' },
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
    formTitle () {
        return (this.editItemId === 0) ? this.$t('teaGardenConfig.fee_assign') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.fee_assign') + ' ' + this.$t('globalTrans.modify')
    },
    detailsTitle () {
        return this.$t('teaGardenConfig.fee_assign') + ' ' + this.$t('globalTrans.details')
    },
    portalServiceNameList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
    },
    feeTypesList: function () {
      return this.$store.state.TeaGardenService.commonObj.feeTypesList.filter(item => item.status === 1)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    edit (item) {
          this.editItemId = item.id
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, feeAssignListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.TeaGardenService.commonObj.feeTypesList.find(law => law.value === parseInt(item.fee_type_id))
          const serviceObj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(law => law.value === parseInt(item.service_id))
          const typeData = {}
            if (typeof orgObj !== 'undefined') {
                typeData.type_en = orgObj.text_en
                typeData.type_bn = orgObj.text_bn
            } else {
              typeData.type_en = ''
              typeData.type_bn = ''
            }
            const serviceData = {}
            if (typeof serviceObj !== 'undefined') {
              serviceData.service_en = serviceObj.text_en
              serviceData.service_bn = serviceObj.text_bn
            } else {
              serviceData.service_en = ''
              serviceData.service_bn = ''
            }
          return Object.assign({}, item, { serial: index }, serviceData, typeData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    remove (item) {
        this.changeStatus(3, teaGardenServiceBaseUrl, feeAssignToggleApi, item)
      },
      details (item) {
          this.item = item
          this.editItemId = item.id
      }
    }
  }
  </script>
