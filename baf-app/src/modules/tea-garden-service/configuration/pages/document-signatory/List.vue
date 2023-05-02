<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.document_signatory') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="search.service_id"
                :options="serviceList"
                id="service_id"
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
        <h4 class="card-title"> {{ $t('teaGardenConfig.document_signatory') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
              <b-col sm="12">
                <div class="quick-filter-wrapper">
                  <div class="quick-filter-left">
                    <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
                      <b-dropdown-form>
                        <div
                          class="form-group"
                          v-for="(field, index) in labelData"
                          :key="index"
                          >
                            <b-form-checkbox
                              :id="'checkbox-' + field.labels"
                              v-model="field.show"
                              :name="'checkbox-' + field.labels"
                              value=1
                              unchecked-value=0
                            >
                              {{ $t(field.labels)  }}
                            </b-form-checkbox>
                        </div>
                      </b-dropdown-form>
                    </b-dropdown>
                  </div>
                  <div class="quick-filter-right">
                    <b-form-group
                      :label="$t('menu.perpage')"
                      label-for="per-page-select"
                    >
                      <b-form-select
                        id="per-page-select"
                        v-model="search.limit"
                        :options="pageOptions"
                        size="sm"
                      ></b-form-select>
                    </b-form-group>
                  </div>
                </div>
              </b-col>
          </b-row>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(service_id)="data">
                    {{ getServiceName(data.item.service_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                      <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                      <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="editMethodInParent(data.item, 1)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="editMethodInParent(data.item, 2)">
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
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { documentSignatoryList, documentSignatoryToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      search: {
        service_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
        { labels: 'research_plan_management.employee_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
        { labels: 'teaGardenConfig.show_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: 'auto' } },
        { labels: 'teaGardenConfig.service_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: 'auto' } },
        { labels: 'globalTrans.office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: 'auto' } },
        { labels: 'globalTrans.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: 'auto' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } }
      ],
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
          { key: 'name_bn' },
          { key: 'show_name' },
          { key: 'service_id' },
          { key: 'office_bn' },
          { key: 'designation_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'name_en' },
          { key: 'show_name' },
          { key: 'service_id' },
          { key: 'office_en' },
          { key: 'designation_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.document_signatory') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.document_signatory') + ' ' + this.$t('globalTrans.modify')
    },
    documentSignatoryList () {
      return this.$store.state.TeaGardenService.commonObj.masterDocumentSignatoryList.filter(item => item.status === 1)
    },
    serviceList () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, teaGardenServiceBaseUrl, documentSignatoryToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    getServiceName (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(item => item.value === id)
      if (obj) {
        return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
      }
      return ''
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, documentSignatoryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
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
