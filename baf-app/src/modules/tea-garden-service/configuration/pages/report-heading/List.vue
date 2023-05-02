<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.report_heading') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
              <b-form-group
                label-for="org_id"
              >
              <template v-slot:label>
                {{$t('globalTrans.organization')}}
              </template>
              <b-form-select
                plain
                v-model="search.org_id"
                :options="orgList"
                id="org_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="address"
            >
              <template v-slot:label>
                {{ $t('globalTrans.address') }}
              </template>
              <b-form-input
                  id="address"
                  type="text"
                  v-model="search.address"
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
        <h4 class="card-title">{{ $t('teaGardenConfig.report_heading') }} {{ $t('globalTrans.list') }}</h4>
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
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(left_logo)="data">
                    <div class="text-center">
                      <img :src="teaGardenServiceBaseUrl+'storage' + data.item.left_logo" width="50"/>
                    </div>
                  </template>
                  <template v-slot:cell(right_logo)="data">
                    <div class="text-center">
                      <img :src="teaGardenServiceBaseUrl+'storage' + data.item.right_logo" width="50"/>
                    </div>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button class="moc-action-btn moc-edit-btn" v-b-modal.modal-form @click="edit(data.item)" :title="$t('globalTrans.edit')">
                      <i class="ri-pencil-fill"></i>
                    </b-button>
                    <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" @click="remove(data.item)" :title="$t('globalTrans.delete')">
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { reportHeadingListApi, reportHeadingToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.organization, label_bn: i18n.messages.bn.globalTrans.organization, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.organogram.office_type, label_bn: i18n.messages.bn.organogram.office_type, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.globalTrans.office, label_bn: i18n.messages.bn.globalTrans.office, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.globalTrans.address, label_bn: i18n.messages.bn.globalTrans.address, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.left_logo, label_bn: i18n.messages.bn.globalTrans.left_logo, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.right_logo, label_bn: i18n.messages.bn.globalTrans.right_logo, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 9 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        org_id: 0,
        address: '',
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      moduleList: []
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
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'org_name_bn' },
          { key: 'office_type_name_bn' },
          { key: 'office_name_bn' },
          { key: 'address_bn' },
          { key: 'left_logo' },
          { key: 'right_logo' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'office_type_name' },
          { key: 'office_name' },
          { key: 'address' },
          { key: 'left_logo' },
          { key: 'right_logo' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.report_heading') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.report_heading') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, reportHeadingListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObj = this.$store.state.CommonService.commonObj.componentOrgList.find(org => org.value === parseInt(item.org_id))
        const officeTypeObj = this.$store.state.CommonService.commonObj.officeTypeList.find(org => org.value === parseInt(item.office_type_id))
        const office = this.$store.state.CommonService.commonObj.officeList.find(org => org.value === parseInt(item.office_id))
        const orgData = {}
          if (typeof orgObj !== 'undefined') {
              orgData.org_name = orgObj.text_en
              orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }
          if (typeof officeTypeObj !== 'undefined') {
              orgData.office_type_name = officeTypeObj.text_en
              orgData.office_type_name_bn = officeTypeObj.text_bn
          } else {
            orgData.office_type_name = ''
            orgData.office_type_name_bn = ''
          }
          if (typeof office !== 'undefined') {
              orgData.office_name = office.text_en
              orgData.office_name_bn = office.text_bn
          } else {
            orgData.office_name = ''
            orgData.office_name_bn = ''
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
    },
    remove (item) {
      this.changeStatus(9, teaGardenServiceBaseUrl, reportHeadingToggleApi, item)
    }
  }
}
</script>
