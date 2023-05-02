<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.cip_trade') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col lg="3" md="3" sm="3">
              <b-form-group
                label-for="year"
              >
              <template v-slot:label>
                {{$t('globalTrans.year')}}
              </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="yearList"
                id="year"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col lg="3" md="3" sm="3">
            <b-form-group
              label-for="cip_sector_id"
            >
            <template v-slot:label>
              {{ $t('exportTrophyConfig.cip_sector') }}
            </template>
            <v-select name="cip_sector_id"
              v-model="search.cip_sector_id"
              label="text"
              :reduce="item => item.value"
              :options= cipSectorList
              :placeholder="$t('globalTrans.select')"
            />
            </b-form-group>
          </b-col>
          <b-col lg="3" md="3" sm="3">
            <b-form-group
              label-for="name_en"
            >
              <template v-slot:label>
                {{ $t('globalTrans.name') }}
              </template>
              <b-form-input
                  id="name_en"
                  type="text"
                  v-model="search.name_en"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col lg="3" md="3" sm="3">
            <b-button size="sm" class="mt-20" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('cip.cip_trade') }} {{ $t('globalTrans.search') }}</h4>
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
              <slot>
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant="iq-bg-success mr-1" size="sm" @click="detaislData(data.item)" class="action-btn status" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status === 1" v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="data.item.status === 1" variant=" action-btn delete mr-1" size="sm" @click="deleteStatus(data.item)" class="action-btn reject" :title="$t('globalTrans.delete')"><i class="ri-close-fill"></i></b-button>
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
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="detailsItemId"  :item="item"/>
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
import Details from './Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipTradeListApi, cipTradeDelete } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import Store from '@/store'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1 },
  { label_en: i18n.messages.en.globalTrans.year, label_bn: i18n.messages.bn.globalTrans.year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2 },
  { label_en: i18n.messages.en.globalTrans.name, label_bn: i18n.messages.bn.globalTrans.name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
  { label_en: i18n.messages.en.exportTrophyConfig.cip_sector, label_bn: i18n.messages.bn.exportTrophyConfig.cip_sector, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4 },
  { label_en: i18n.messages.en.globalTrans.designation, label_bn: i18n.messages.bn.globalTrans.designation, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 6 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        year: 0,
        cip_sector_id: '',
        name_en: '',
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      actions: {
        edit: true,
        details: false,
        reject: true
      },
      item: '',
      detailsItemId: ''
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
    yearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    },
    cipSectorList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.filter(item => item.cip_category === 2)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
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
          { key: 'year_bn' },
          { key: 'name_bn' },
          { key: 'sector_bn' },
          { key: 'fbcci_designation_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'year_en' },
          { key: 'name_en' },
          { key: 'sector_en' },
          { key: 'fbcci_designation_en' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('cip.cip_trade') + ' ' + this.$t('globalTrans.entry') : this.$t('cip.cip_trade') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    detaislData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, cipTradeListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const cipSectorObj = this.cipSectorList.find(tmp => tmp.value === item.cip_sector_id)

          const cipSectorData = {
            sector_bn: cipSectorObj !== undefined ? cipSectorObj.text_bn : '',
            sector_en: cipSectorObj !== undefined ? cipSectorObj.text_en : ''
          }

          const yearData = {
            year_bn: this.$n(item.year, { useGrouping: false }),
            year_en: item.year
          }

          return Object.assign({}, item, { serial: index }, cipSectorData, yearData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    changeStatus (componentId, baseUrl, uri, item, destination = null, dropdownName = null) {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: true })
      RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
        if (response.success) {
          /** The following line commented as list is reloaded */
          // Store.dispatch('toggleStatus', item)
          if (destination !== null && dropdownName !== null) {
            Store.dispatch('toggleDropdownItemStatus', { itemId: item.id, destination: destination, dropdownName: dropdownName })
          }
          // call dropdown
          this.getComponentById(componentId)
          window.vm.$toast.success({
            title: 'Success',
            message: 'Data Delete Successfully',
            color: '#D6E09B'
          })
        } else {
            window.vm.$toast.error({
              title: 'Error',
              message: 'Operation failed! Please, try again.'
          })
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      })
    },
    deleteStatus (item) {
      window.vm.$swal({
        title: window.vm.$t('cip.delete_status'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.changeStatus(9, exportTrophyCIPServiceBaseUrl, cipTradeDelete, item)
        }
      })
    },
    getComponentById (componentId) {
      if (componentId === 9) {
        Store.dispatch('ExportTrophyCipService/mutateCommonObj', { hasDropdownLoaded: false })
      }
    }
  }
}
</script>
