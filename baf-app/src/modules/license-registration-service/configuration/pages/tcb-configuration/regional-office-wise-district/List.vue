<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.region_office_wise') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
         <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Regional Office" vid="regional_office_id">
                <b-form-group
                    label-for="regional_office_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('allocation_management.regional_office')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.regional_office_id"
                    :options="regionalOfficeList"
                    id="regional_office_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Division" vid="division_id">
                <b-form-group
                    label-for="division_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('globalTrans.division')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.division_id"
                    :options="divisionList"
                    id="division_id"
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
          <b-col sm="4" class="mt-4">
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
        <h4 class="card-title">{{ $t('tcbconfiguration.region_office_wise') }} {{ $t('globalTrans.list') }}</h4>
    </template>
    <template v-slot:headerAction>
      <b-button-group>
        <b-button @click="pdfExport" class="mr-2 btn-sm" variant="success"><i class="ri-printer-fill"></i></b-button>
      </b-button-group>
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
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(district)="data">
                    <span  v-for="(districtItem, index) in data.item.district_details" :key="index">
                      <span v-if="index != 0"> </span><span class="badge badge-success">{{ districtName(districtItem.district_id) }}</span>
                    </span >
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button class="mr-2" :title="$t('globalTrans.edit')" v-b-modal.modal-form variant=" action-btn status mr-1" size="sm" @click="edit(data.item)"><i class="ri-pencil-fill"></i></b-button>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { regionWiseDistrictList } from '../../../api/routes'
import modalBaseroute from '@/mixins/list'
import i18n from '@/i18n'
import Pdf from './pdf'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.allocation_management.regional_office, label_bn: i18n.messages.bn.allocation_management.regional_office, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.division, label_bn: i18n.messages.bn.globalTrans.division, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.district, label_bn: i18n.messages.bn.globalTrans.district, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 5, thStyle: { width: '10%' } }
]
export default {
  mixins: [modalBaseroute],
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
        regional_office_id: 0,
        division_id: 0,
        limit: 10
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      districtList: [],
      detailsItemId: '',
      item: ''
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  mounted () {
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    }
  },
  computed: {
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tcbconfiguration.region_office_wise') + ' ' + this.$t('globalTrans.entry') : this.$t('tcbconfiguration.region_office_wise') + ' ' + this.$t('globalTrans.modify')
    },
    regionalOfficeList: function () {
       return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
          { key: 'region_name_bn' },
          { key: 'division_name_bn' },
          { key: 'district' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'region_name' },
          { key: 'division_name' },
          { key: 'district' },
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
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
     detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    edit (item) {
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, regionWiseDistrictList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
            if (typeof divisionObj !== 'undefined') {
              divisionData.division_name = divisionObj.text_en
              divisionData.division_name_bn = divisionObj.text_bn
            } else {
              divisionData.division_name = ''
              divisionData.division_name_bn = ''
            }
        const regionObj = this.$store.state.CommonService.commonObj.officeList.find(regional => regional.value === parseInt(item.regional_office_id))
         const regionalOfficeData = {}
          if (typeof regionObj !== 'undefined') {
            regionalOfficeData.region_name = regionObj.text_en
            regionalOfficeData.region_name_bn = regionObj.text_bn
          } else {
            regionalOfficeData.region_name = ''
            regionalOfficeData.region_name_bn = ''
          }
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const districtData = {}
          if (typeof districtObj !== 'undefined') {
            districtData.district_name = districtObj.text_en
            districtData.district_name_bn = districtObj.text_bn
          } else {
            districtData.district_name = ''
            districtData.district_name_bn = ''
          }
          return Object.assign({}, item, { serial: index }, divisionData, districtData, regionalOfficeData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    districtName (districtId) {
      const districtObj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === districtId)
      if (districtObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return districtObj.text_bn
        } else {
          return districtObj.text_en
        }
      }
    },
    pdfExport () {
      const reportTitle = this.$t('tcbconfiguration.region_office_wise')
      Pdf.exportPdfDetails(reportTitle, this.listData, this, this.districtName)
    }
  }
}
</script>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
