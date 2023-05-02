<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('globalTrans.organization') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
              <b-form-group
                label-for="ministry_id"
              >
              <template v-slot:label>
                {{$t('moc_portal.ministry_name')}}
              </template>
              <b-form-select
                plain
                v-model="search.ministry_id"
                :options="ministryNameList"
                id="ministry_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="ex_org_name"
            >
              <template v-slot:label>
                {{ $t('globalTrans.org_name') }}
              </template>
              <b-form-input
                  id="ex_org_name"
                  type="text"
                  v-model="search.ex_org_name"
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
        <h4 class="card-title">{{ $t('globalTrans.organization') + ' ' + $t('globalTrans.list')}}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="commonServiceBaseUrl" />
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
import { orgEntryListApi, orgEntryToggleApi } from '../../api/routes'
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
      commonServiceBaseUrl: commonServiceBaseUrl,
      sortBy: '',
      search: {
        ex_org_name: '',
        ministry_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'moc_portal.ministry_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
        { labels: 'globalTrans.org_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
        { labels: 'moc_portal.logo', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 6, thStyle: { width: '9%' } }
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
          { key: 'ministry_name_bn' },
          { key: 'ex_org_name_bn' },
          { key: 'logo' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'ministry_name' },
          { key: 'ex_org_name' },
          { key: 'logo' },
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
      return (this.editItemId === 0) ? this.$t('globalTrans.organization') + ' ' + this.$t('globalTrans.entry') : this.$t('globalTrans.organization') + ' ' + this.$t('globalTrans.modify')
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
        this.changeStatus(1, commonServiceBaseUrl, orgEntryToggleApi, item)
      }
    },
    edit (item) {
      this.editItemId = item.id
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, orgEntryListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const tmpMinistry = this.$store.state.CommonService.commonObj.ministryNameList.find(el => el.value === item.ministry_id)
          const tmpObj = {
            serial: index,
            ministry_name: tmpMinistry !== 'undefined' ? tmpMinistry.text_en : '',
            ministry_name_bn: tmpMinistry !== 'undefined' ? tmpMinistry.text_bn : ''
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
