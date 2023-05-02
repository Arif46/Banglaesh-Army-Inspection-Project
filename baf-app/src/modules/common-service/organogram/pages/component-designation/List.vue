<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('organogram.component_designation') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="designation_id"
            >
            <template v-slot:label>
              {{$t('menu.component')}}
            </template>
              <b-form-select
                plain
                v-model="search.component_id"
                :options="componentList"
                id="component_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="org_id"
            >
            <template v-slot:label>
              {{$t('organogram.org')}}
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
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
        <h4 class="card-title">{{ $t('organogram.component_designation') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(designation)="data">
                    {{ getDesignationList(data.item.designation_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="editItem(data.item, data.item.serial)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button variant=" iq-bg-danger" size="sm" @click="remove(data.item)" class="action-btn delete" :title="$t('globalTrans.delete')"><i class="ri-delete-bin-line"></i></b-button>
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
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" @hidden="onHidden">
      <Form :item="item"/>
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
import { componentDesignationList, componentDesignationToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.menu.component, label_bn: i18n.messages.bn.menu.component, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.organization, label_bn: i18n.messages.bn.globalTrans.organization, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.organogram.designation, label_bn: i18n.messages.bn.organogram.designation, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 6 }
]
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
      sortBy: '',
      search: {
        org_id: 0,
        component_id: 0,
        limit: 20
      },
      item: [],
      orgList: [],
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
    },
    'search.component_id': function (newVal, oldVal) {
      if (newVal && newVal !== oldVal) {
        this.orgList = this.getOrgListByDesignation(newVal)
      } else {
        this.orgList = []
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
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
          { key: 'component_name_bn' },
          { key: 'org_name_bn' },
          { key: 'designation' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'component_name' },
          { key: 'org_name' },
          { key: 'designation' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.item.status) ? this.$t('organogram.component_designation') + ' ' + this.$t('globalTrans.modify') : this.$t('organogram.component_designation') + ' ' + this.$t('globalTrans.entry')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    onHidden (e) {
      this.item = {
        org_id: 0,
        component_id: 0,
        designation_id: []
      }
    },
    editItem (item) {
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, componentDesignationList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgProfileObj = this.$store.state.CommonService.commonObj.orgProfileList.find(orgProId => orgProId.value === item.org_id)
          const orgProfileData = {
            org_name_bn: orgProfileObj !== undefined ? orgProfileObj.text_bn : '',
            org_name: orgProfileObj !== undefined ? orgProfileObj.text_en : ''
          }
          const componentObj = this.$store.state.CommonService.commonObj.componentList.find(component => component.value === item.component_id)
          const componentData = {
            component_name_bn: componentObj !== undefined ? componentObj.text_bn : '',
            component_name: componentObj !== undefined ? componentObj.text_en : ''
          }
          const designation = []
          item.designation.split(',').filter(item => {
            designation.push(item)
          })
          return Object.assign({}, item, { serial: index }, orgProfileData, componentData, { designation_id: designation })
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
      this.$swal({
        title: this.$t('globalTrans.archivedChangeMsg'),
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.changeStatus(commonServiceBaseUrl, componentDesignationToggle, item)
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        }
      })
    },
    changeStatus (baseUrl, uri, item) {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const data = { org_id: item.org_id, component_id: item.component_id }
        RestApi.putData(baseUrl, `${uri}`, data).then(response => {
          if (response.success) {
            window.vm.$toast.success({
              title: 'Success',
              message: 'Data Updated Successfully',
              color: '#D6E09B'
            })
          } else {
              window.vm.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
            })
          }
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: true })
        })
    },
    getDesignationList (items) {
      if (items != null) {
        if (items.length > 0) {
          const designationList = items.map(ele => {
            const obj = this.$store.state.CommonService.commonObj.designationList.find(des => des.value === parseInt(ele))
            return this.$i18n.locale === 'en' ? obj.text_en : obj.text_bn
          })
          if (designationList === null || designationList === undefined) {
            return ''
          }
          return designationList.join(', ')
        }
      }
    },
    getOrgListByDesignation (componentId) {
      const orgComponentList = this.$store.state.CommonService.commonObj.orgComponentList
      if (orgComponentList !== undefined) {
        return orgComponentList.filter(item => item.component_id === componentId).map(itemObj => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(orgItem => orgItem.value === itemObj.org_id)
          if (this.$i18n.locale === 'bn') {
            return { value: orgObj.value, text: orgObj.text_bn }
          } else {
            return { value: orgObj.value, text: orgObj.text_en }
          }
        })
      }
    }
  }
}
</script>
