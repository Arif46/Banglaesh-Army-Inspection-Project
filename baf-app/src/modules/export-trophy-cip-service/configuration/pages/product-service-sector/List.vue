<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophyConfig.product_and_service_sector') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="4" md="3" lg="3" xl="3">
              <b-form-group
                label-for="assign_for"
              >
              <template v-slot:label>
                {{$t('exportTrophyConfig.assign_for')}}
              </template>
              <b-form-select
                plain
                v-model="search.assign_for"
                :options="assignTypeList"
                id="assign_for"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="4" md="3" lg="3" xl="3">
              <b-form-group
                label-for="type"
              >
              <template v-slot:label>
                {{$t('globalTrans.type')}}
              </template>
              <b-form-select
                plain
                v-model="search.type"
                :options="productServiceTypeList"
                id="type"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Product Service Sector" vid="sector_name">
                <b-form-group
                  label-for="sector_name"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('exportTrophyConfig.product_or_service_sector_name')}}
                </template>
                <v-select name="sector_name"
                  v-model="search.sector_name"
                  label="text"
                  :reduce="item => item.text"
                  :options= productServiceSectorList
                  :placeholder="$t('globalTrans.select')"
                  :state="errors[0] ? false : (valid ? true : null)"
                />
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="2" lg="2" xl="2">
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
        <h4 class="card-title">{{ $t('exportTrophyConfig.product_and_service_sector') + ' ' + $t('globalTrans.list')}}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import Form from './Form.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { masterSectorListApi, masterSectorToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        sector_name: '',
        assign_for: 0,
        type: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'exportTrophyConfig.assign_for', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'globalTrans.type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'exportTrophyConfig.product_or_service_sector_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 6, thStyle: { width: '15%' } }
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
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    productServiceSectorList () {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(item => item.status === 1 && item.type === this.search.type && item.assign_for === this.search.assign_for)
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
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
          { key: 'assign_for_bn' },
          { key: 'type_name_bn' },
          { key: 'sector_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'assign_for_en' },
          { key: 'type_name' },
          { key: 'sector_name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    ministryNameList () {
      return this.$store.state.CommonService.commonObj.ministryNameList.filter(el => el.status === 1)
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('exportTrophyConfig.product_and_service_sector') + ' ' + this.$t('globalTrans.entry') : this.$t('exportTrophyConfig.product_and_service_sector') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(9, exportTrophyCIPServiceBaseUrl, masterSectorToggleApi, item)
      }
    },
    edit (item) {
      this.editItemId = item.id
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, masterSectorListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const tmpAssign = this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.find(el => el.value === item.assign_for)
          const tmpType = this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.find(el => el.value === item.type)
          const tmpObj = {
            serial: index,
            assign_for_en: tmpAssign !== 'undefined' ? tmpAssign.text_en : '',
            assign_for_bn: tmpAssign !== 'undefined' ? tmpAssign.text_bn : '',
            type_name: tmpType !== 'undefined' ? tmpType.text_en : '',
            type_name_bn: tmpType !== 'undefined' ? tmpType.text_bn : ''
          }
          return Object.assign({}, item, tmpObj)
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
