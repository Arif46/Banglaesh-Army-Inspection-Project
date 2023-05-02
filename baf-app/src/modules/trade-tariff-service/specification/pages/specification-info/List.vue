<template>
    <div class="inner-section">
      <card>
        <!-- search section start -->
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">Search Specification</h4>
        </template>
        <template v-slot:searchBody>
          <b-row>
             <b-col  xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="demand_no"
              >
                <template v-slot:label>
                  Indent No
                </template>
                <b-form-input
                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                    id="demand_no"
                    type="text"
                    v-model="search.demand_no"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col  xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="item_name"
              >
                <template v-slot:label>
                  Item Name
                </template>
                <b-form-input
                    id="item_name"
                    type="text"
                    v-model="search.item_name"
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
          <h4 class="card-title">Specification List</h4>
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
                    <template v-slot:cell(action)="data">
                      <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                      <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-1" size="sm"  @click="details(data.item)" class="action-btn active" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
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
      <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Details :id="editItemId" :key="editItemId" :item="item" />
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
  import RestApi, { InspectionServiceBaseUrl } from '@/config/api_config'
  import { specificationList } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import i18n from '@/i18n'

  const defaultColumn = [
    { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
    { label_en: 'Indent No', label_bn: i18n.messages.bn.specification.demand_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
    { label_en: 'Item Name', label_bn: i18n.messages.bn.specification.item_name, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
    { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 4, thStyle: { width: '15%' } }
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
          item_name: '',
          demand_no: '',
          limit: 20
        },
        sortDesc: true,
        sortDirection: 'desc',
        labelData: [],
        item: []
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
        const labels = labelData.map((item) => {
          const labelData = {}
          labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
          return Object.assign(item, labelData)
        })
        let keys = []
        if (this.$i18n.locale === 'bn') {
          keys = [
            { key: 'serial' },
            { key: 'demand_no' },
            { key: 'item_name' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'demand_no' },
            { key: 'item_name' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      formTitle () {
        return 'Specification Info Entry'
      },
      detailsTitle () {
        return 'Specification Info Details'
      },
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
      },
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      details (item) {
        this.editItemId = item.id
        this.item = item
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(InspectionServiceBaseUrl, specificationList, params)
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
      // remove (item) {
      //   this.changeStatus(9, tradeTariffServiceBaseUrl, applicationTypeToggle, item)
      // }
    }
  }
  </script>
