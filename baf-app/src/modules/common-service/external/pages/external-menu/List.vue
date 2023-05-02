<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('external.external_menu') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="6">
            <b-form-group
              label-for="external_panel_id"
            >
            <template v-slot:label>
              {{$t('external.external_panel')}}
            </template>
            <b-form-select
              plain
              v-model="search.external_panel_id"
              :options="externalPanelList"
              id="external_panel_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="6">
            <b-form-group
              label-for="name"
            >
              <template v-slot:label>
                {{ $t('globalTrans.name') }}
              </template>
              <b-form-input
                  id="name"
                  type="text"
                  v-model="search.name"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('external.external_menu') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :orderChange="orderChange"/>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { externalMenuList, externalMenuToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.external.external_panel, label_bn: i18n.messages.bn.external.external_panel, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.globalTrans.name, label_bn: i18n.messages.bn.globalTrans.name_bn, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.menu.sorting_order, label_bn: i18n.messages.bn.menu.sorting_order, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 6 }
]
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
        external_panel_id: 0,
        name: '',
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      orderChange: {
        checkList: this.$store.state.CommonService.commonObj.externalMenuList,
        type: 'Comp',
        colspan: 3,
        urlSave: 'external/change-menu/serial-order/ExternalMenu'
      }
    }
  },
  created () {
    this.labelData = this.labelList
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
    externalPanelList () {
      return this.$store.state.CommonService.commonObj.externalPanelList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'external_panel_bn' },
          { key: 'name_bn' },
          { key: 'sorting_order' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'external_panel_en' },
          { key: 'name' },
          { key: 'sorting_order' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('external.external_menu') + ' ' + this.$t('globalTrans.entry') : this.$t('external.external_menu') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, externalMenuToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, externalMenuList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const externalPanelObj = this.$store.state.CommonService.commonObj.externalPanelList.find(externalPanel => externalPanel.value === item.external_panel_id)
          const externalPanelData = {
            external_panel_bn: externalPanelObj !== undefined ? externalPanelObj.text_bn : '',
            external_panel_en: externalPanelObj !== undefined ? externalPanelObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index + 1 }, externalPanelData)
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
