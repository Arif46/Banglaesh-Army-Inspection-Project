<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('organogram.office_type') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="org_name"
            >
              <template v-slot:label>
                {{ $t('orgProfile.org_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.org_id"
                :options="orgProfileList"
                id="org_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="office_type_name"
            >
              <template v-slot:label>
                {{ $t('organogram.office_type_name') }}
              </template>
              <b-form-input
                  id="office_type_name"
                  type="text"
                  v-model="search.office_type_name"
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
        <h4 class="card-title">{{ $t('organogram.office_type') }} {{ $t('globalTrans.list') }}</h4>
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
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { officeTypeList, officeTypeToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import i18n from '@/i18n'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      search: {
        office_type_name: '',
        org_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '40%' } },
        { labels: 'organogram.office_type_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5 }
      ],
      actions: {
        edit: true,
        details: true,
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
          { key: 'office_type_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'office_type_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('organogram.office_type') + ' ' + this.$t('globalTrans.entry') : this.$t('organogram.office_type') + ' ' + this.$t('globalTrans.modify')
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(commonServiceBaseUrl, officeTypeToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, officeTypeList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
        const orgData = {}
            if (typeof orgObj !== 'undefined') {
                orgData.org_name = orgObj.text_en
                orgData.org_name_bn = orgObj.text_bn
            } else {
                orgData.org_name = ''
                orgData.org_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, orgData)
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
