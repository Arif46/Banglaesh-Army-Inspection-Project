<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizConfig.association_info') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
        <b-col  b-col xs="12" sm="12" md="4" lg="4" xl="4">
          <ValidationProvider name="Council Info" vid="council_info_id" rules="">
              <b-form-group
                label-for="council_info_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('eBizConfig.council_name')}}
              </template>
              <b-form-select
                plain
                v-model="search.council_info_id"
                :options="councilInfo"
                id="council_info_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
        </ValidationProvider>
        </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="association_name"
            >
              <template v-slot:label>
                {{ $t('eBizConfig.association_name') }}
              </template>
              <b-form-input
                  id="association_name"
                  type="text"
                  v-model="search.association_name"
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
        <h4 class="card-title">{{ $t('eBizConfig.association_info') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                  <template v-slot:cell(association_name)="data">
                    {{ $i18n.locale === 'bn' ? data.item.association_name_bn : data.item.association_name_en }}
                  </template>
                  <template v-slot:cell(status)="data">
                     <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="editMethodInParent(data.item,1)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button  v-b-modal.details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                     <b-button :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="editMethodInParent(data.item,2)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { associationInfoList, associationInfoToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
      search: {
        council_info_id: 0,
        association_name: '',
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'eBizConfig.council_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'eBizConfig.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5, thStyle: { width: '12%' } }
      ],
      items: [],
      viewitemId: 0,
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
          { key: 'council_name_bn' },
          { key: 'association_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'council_name' },
          { key: 'association_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('eBizConfig.association_info') + ' ' + this.$t('globalTrans.entry') : this.$t('eBizConfig.association_info') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('eBizConfig.association_info') + ' ' + this.$t('globalTrans.view') : this.$t('eBizConfig.association_info') + ' ' + this.$t('globalTrans.modify')
    },
    councilInfo () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, eBizServiceBaseUrl, associationInfoToggle, item)
      }
    },
    details (item) {
        this.items = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, associationInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const councilInfoObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.find(law => law.value === parseInt(item.council_info_id))
           const councilData = {}
            if (typeof councilInfoObj !== 'undefined') {
                councilData.council_name = councilInfoObj.text_en
                councilData.council_name_bn = councilInfoObj.text_bn
            } else {
              councilData.council_name = ''
              councilData.council_name_bn = ''
            }
          return Object.assign({}, item, councilData, { serial: index })
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
