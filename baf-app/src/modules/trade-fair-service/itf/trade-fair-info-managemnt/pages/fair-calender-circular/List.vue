<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairInfoManagement.fair_calender_circular') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{ $t('globalTrans.fiscal_year') }}
              </template>
              <b-form-select
                plain
                id="fiscal_year_id"
                :options="fiscalYearList"
                v-model="search.fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title">{{ $t('tradeFairInfoManagement.fair_calender_circular') }}  {{ $t('globalTrans.list') }}</h4>
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
                            :id="'checkbox-' + field.label_en"
                            v-model="field.show"
                            :name="'checkbox-' + field.label_en"
                            value=1
                            unchecked-value=0
                          >
                            {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
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
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-secondary" v-else-if="data.item.status == 2">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 4">{{$t('globalTrans.return')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 5">{{$t('globalTrans.publish')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm" @click="edit(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status === 1 || data.item.status === 4" v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="data.item.status === 1 || data.item.status === 4" :title="$t('globalTrans.forward')" v-b-modal.modal-5 variant="iq-bg-info" class="action-btn btn-info" size="sm" @click="edit(data.item)"><i class="ri-share-forward-line"></i></b-button>
                    <b-button variant=" iq-bg-info" v-if="data.item.status === 3" size="sm" @click="publishStatus(data.item)" class="btn moc-action-btn moc-publish-btn btn-secondary" :title="$t('globalTrans.publish')"><i class="ri-compass-discover-line"></i></b-button>
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
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.forward')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Forward :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-form-details" size="lg" :title="$t('tradeFairInfoManagement.fair_calender_circular') + ' ' + $t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('tradeFairInfoManagement.fair_calender_circular') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="editItemId" :key="editItemId" ref="details"/>
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
import Forward from './Forward.vue'
import Details from '../approve-fair-calender-circular/Details'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairCalenderCircularList, fairCalenderCircularPublish } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import Store from '@/store'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.fiscal_year, label_bn: i18n.messages.bn.globalTrans.fiscal_year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.circular_memo_no, label_bn: i18n.messages.bn.tradeFairInfoManagement.circular_memo_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.subject, label_bn: i18n.messages.bn.tradeFairInfoManagement.subject, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 6, thStyle: { width: '15%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Forward, Details
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: []
    }
  },
  created () {
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
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
          { key: 'fiscal_year_bn' },
          { key: 'circular_memo_number' },
          { key: 'subject_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_number' },
          { key: 'subject_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tradeFairInfoManagement.fair_calender_circular') + ' ' + this.$t('globalTrans.entry') : this.$t('tradeFairInfoManagement.fair_calender_circular') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairCalenderCircularList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const customItem = {
            fiscal_year_en: fiscalYearData?.text_en,
            fiscal_year_bn: fiscalYearData?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    changeStatus (baseUrl, uri, item, destination = null, dropdownName = null) {
        Store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
            if (response.success) {
                this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
                if (destination !== null && dropdownName !== null) {
                    Store.dispatch('toggleDropdownItemStatus', { itemId: item.id, destination: destination, dropdownName: dropdownName })
                }
                window.vm.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.$t('globalTrans.update_msg'),
                    color: '#D6E09B'
                })
            } else {
                window.vm.$toast.error({
                    title: 'Error',
                    message: 'Operation failed! Please, try again.'
                })
            }
            Store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
        })
    },
    publishStatus (item) {
      window.vm.$swal({
        title: window.vm.$t('priceMonitoring.publish_status'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.changeStatus(internationalTradeFairServiceBaseUrl, fairCalenderCircularPublish, item)
        }
      })
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
