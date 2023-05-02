<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.item') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="org_id">
              <template v-slot:label>
                {{ $t('globalTrans.organization') }}
              </template>
              <b-form-select
                plain
                id="org_id"
                :options="orgList"
                v-model="search.org_id"
                :disabled="true"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="item_category_id">
              <template v-slot:label>
                {{ $t('tcbconfiguration.item_category') }}
              </template>
              <b-form-select
                plain
                id="item_category_id"
                :options="itemCategoryList"
                v-model="search.item_category_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Item Name"
            >
              <template v-slot:label>
                {{ $t('tcbconfiguration.item') }}
              </template>
              <b-form-input
                  id="item_name_en"
                  type="text"
                  v-model="search.item_name_en"
              ></b-form-input>
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
        <h4 class="card-title">{{ $t('tcbconfiguration.item') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="licenseRegistrationServiceBaseUrl" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { itemList, itemToggle } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        item_category_id: 0,
        item_name_en: '',
        org_id: 7,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tcbconfiguration.item_category', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'tcbconfiguration.item', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
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
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'org_name_bn' },
          { key: 'item_category_bn' },
          { key: 'item_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'item_category_en' },
          { key: 'item_name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tcbconfiguration.item') + ' ' + this.$t('globalTrans.entry') : this.$t('bazarMonitoring.report_heading') + ' ' + this.$t('globalTrans.modify')
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(7, licenseRegistrationServiceBaseUrl, itemToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, itemList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(law => law.value === parseInt(item.org_id))
          const catObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(law => law.value === parseInt(item.item_category_id))
          const orgData = {}
            if (typeof orgObj !== 'undefined') {
                orgData.org_name = orgObj.text_en
                orgData.org_name_bn = orgObj.text_bn
            } else {
              orgData.org_name = ''
              orgData.org_name_bn = ''
            }
          const itemData = {}
            if (typeof catObj !== 'undefined') {
                itemData.item_category_en = catObj.text_en
                itemData.item_category_bn = catObj.text_bn
            } else {
              itemData.item_category_en = ''
              itemData.item_category_bn = ''
            }
          return Object.assign({}, item, { serial: index }, orgData, itemData)
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
