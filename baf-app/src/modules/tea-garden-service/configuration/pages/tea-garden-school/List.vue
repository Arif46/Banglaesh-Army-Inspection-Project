<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.tea_garden_school') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="division"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.division') }}
              </template>
            <b-form-select
                plain
                v-model="search.division_id"
                :options="divisionList"
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
              label-for="district"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.district') }}
              </template>
            <b-form-select
                plain
                v-model="search.district_id"
                :options="districtList"
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
              label-for="garden_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.garden_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.garden_id"
                :options="getGardenlist"
                id="garden_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="School Type" vid="school_type" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_type">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_type') }}
                </template>
                <b-form-select
                      plain
                      v-model="search.school_type"
                      :options="schoolType"
                      id="school_type"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="School Category" vid="school_category" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_category">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_category') }}
                </template>
                <b-form-select
                      plain
                      v-model="search.school_category"
                      :options="schoolCategory"
                      id="school_category"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="School Status" vid="school_status" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="school_status">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.school_status') }}
                </template>
                <b-form-select
                      plain
                      v-model="search.school_status"
                      :options="schoolStatus"
                      id="school_status"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                          <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
              label-for="school_name_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.school_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.school_name_id"
                :options="schoolNameList"
                id="school_name_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title"> {{ $t('teaGardenConfig.tea_garden_school_list') }}</h4>
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
                  <template v-slot:cell(school_category)="data">
                    {{ getSchoolCategoryName(data.item.school_category) }}
                  </template>
                  <template v-slot:cell(school_status)="data">
                    {{ getSchoolStatusName(data.item.school_status) }}
                  </template>
                  <template v-slot:cell(status)="data">
                      <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                      <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.view')" :to="{ name: 'tea_garden_service.configuration.tea-garden-school-view', params: { item: data.item }, query: { id: data.item.id } }">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <b-button class="moc-action-btn moc-edit-btn" v-b-modal.modal-form @click="edit(data.item)" :title="$t('globalTrans.edit')">
                      <i class="ri-pencil-fill"></i>
                    </b-button>
                    <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="editMethodInParent(data.item,2)">
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
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { schoolInformaitonList, schoolInformaitonToggle, getSchoolNameList } from '../../api/routes'
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
        division_id: 0,
        district_id: 0,
        school_category: 0,
        garden_id: 0,
        school_name_id: 0,
        school_type: 0,
        school_status: 0,
        limit: 20
      },
      districtList: [],
      schoolNameList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'teaGardenConfig.school_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.school_category', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.school_status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
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
    this.getSchoolNameSearchList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
      this.getSchoolNameSearchList()
    },
    'search.district_id': function (newVal, oldVal) {
      this.getSchoolNameSearchList()
    },
    'search.garden_id': function (newVal, oldVal) {
      this.getSchoolNameSearchList()
    },
    'search.school_category': function (newVal, oldVal) {
      this.getSchoolNameSearchList()
    },
    'search.school_status': function (newVal, oldVal) {
      this.getSchoolNameSearchList()
    },
    'search.school_type': function (newVal, oldVal) {
      this.getSchoolNameSearchList()
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
          { key: 'school_name_bn' },
          { key: 'school_category' },
          { key: 'school_status' },
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'school_name_en' },
          { key: 'school_category' },
          { key: 'school_status' },
          { key: 'division_name' },
          { key: 'district_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.modify')
    },
    schoolInformaitonList () {
      return this.$store.state.TeaGardenService.commonObj.masterSchoolInformationList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    getAreaTypeList: function () {
        const objectData = this.$store.state.commonObj.areaTypeList
        return objectData.map((obj, key) => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.value, text: obj.text_bn }
            } else {
                return { value: obj.value, text: obj.text_en }
            }
        })
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    getGardenlist: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
    },
    schoolType: function () {
      return this.$store.state.TeaGardenService.commonObj.trustType
    },
    schoolCategory: function () {
      return this.$store.state.TeaGardenService.commonObj.schoolCategory
    },
    schoolStatus: function () {
      return this.$store.state.TeaGardenService.commonObj.schoolStatus
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, teaGardenServiceBaseUrl, schoolInformaitonToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, schoolInformaitonList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        item.school_type = JSON.parse(item.school_type)
        const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const divisionData = {}
        const districtData = {}
            if (typeof divisionObj !== 'undefined') {
                divisionData.division_name = divisionObj.text_en
                divisionData.division_name_bn = divisionObj.text_bn
            } else {
                divisionData.division_name = ''
                divisionData.division_name_bn = ''
            }
            if (typeof districtObj !== 'undefined') {
                districtData.district_name = districtObj.text_en
                districtData.district_name_bn = districtObj.text_bn
            } else {
                districtData.district_name = ''
                districtData.district_name_bn = ''
            }
            return Object.assign({}, item, { serial: index }, divisionData, districtData)
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
    async getSchoolNameSearchList () {
    let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, getSchoolNameList, this.search)
      if (result) {
        this.schoolNameList = result
      }
    },
    getSchoolStatusName (id) {
      const schoolStatus = this.$store.state.TeaGardenService.commonObj.schoolStatus.find(item => item.value === id)
          if (schoolStatus && this.$i18n.locale === 'bn') {
              return schoolStatus.text_bn
          } else if (schoolStatus && this.$i18n.locale === 'en') {
              return schoolStatus.text_en
          }
      },
      getSchoolCategoryName (id) {
      const schoolCategory = this.$store.state.TeaGardenService.commonObj.schoolCategory.find(item => item.value === id)
          if (schoolCategory && this.$i18n.locale === 'bn') {
              return schoolCategory.text_bn
          } else if (schoolCategory && this.$i18n.locale === 'en') {
              return schoolCategory.text_en
          }
      }
  }
}
</script>
