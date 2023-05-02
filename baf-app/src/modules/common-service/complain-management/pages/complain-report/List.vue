<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('complain_management.complain_report') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
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
              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="service_id"
            >
            <template v-slot:label>
              {{$t('menu.service')}}
            </template>
            <b-form-select
            plain
            v-model="search.service_id"
            :options="serviceList"
            id="service_id"
            >
              <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="division_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.division')}}
              </template>
              <b-form-select
              plain
              v-model="search.division_id"
              :options="divisionList"
              id="division_id"
              >
              <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="district_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.district')}}
              </template>
              <b-form-select
              plain
              v-model="search.district_id"
              :options="districtList"
              id="district_id"
              >
              <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="upazila_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.upazila')}}
              </template>
              <b-form-select
              plain
              v-model="search.upazila_id"
              :options="upazilaList"
              id="upazila_id"
              >
              <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="union_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.union')}}
              </template>
              <b-form-select
                plain
                v-model="search.union_id"
                :options="unionList"
                id="union_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
              label-for="status"
              >
              <template v-slot:label>
              {{$t('globalTrans.status')}}
              </template>
              <b-form-select
              plain
              v-model="search.status"
              :options="statusList"
              id="status"
              >
              <template v-slot:first>
              <b-form-select-option :value="'selected'" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
              label-for="from_date">
              <template v-slot:label>
                {{ $t('globalTrans.from_date') }}
              </template>
              <b-form-datepicker b-form-datepicker
              id="from_date"
              v-model="search.from_date"
              >
              </b-form-datepicker>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
              label-for="to_date">
              <template v-slot:label>
                {{ $t('globalTrans.to_date') }}
              </template>
              <b-form-datepicker b-form-datepicker
              id="to_date"
              v-model="search.to_date"
              >
              </b-form-datepicker>
              </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button size="sm" variant="primary" @click="searchData" class="mt-3">
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
        <h4 class="card-title">{{ $t('complain_management.complain_report') }} {{ $t('globalTrans.list') }}</h4>
      </template>
        <!-- <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template> -->
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
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
                  <template v-slot:cell(action)="data">
                    <b-button class="mr-1" title="View Complain" v-b-modal.modal-view variant="action-btn status mr-1" size="sm" @click="edit(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <!-- <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button> -->
                    <b-button class="action-btn btn-success" @click="remove(data.item)" title="Approve Btn" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
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
      <!-- table section end-->
    </body-card>
    <!-- <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal> -->
     <b-modal id="modal-view" size="xl" :title="$t('complain_management.complain_info_detail')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <DetailModal :id="editItemId"/>
     </b-modal>
  </div>
</template>
<script>
import DetailModal from './DetailModal'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { complainSubmitList, complainSubmitToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
      DetailModal
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        org_id: 0,
        module_id: 0,
        service_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        status: 'selected',
        from_date: '',
        to_date: '',
        limit: 10
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'menu.service', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'complain_management.complain_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 6, thStyle: { width: '10%' } }
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
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList()
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList()
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList()
      }
    }
  },
  computed: {
    statusList: function () {
    const listObject = this.$store.state.commonObj.statusList
    const tmpList = listObject.map((obj, index) => {
        if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
        } else {
            return { value: obj.value, text: obj.text_en }
        }
    })
    return tmpList
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList
    },
    serviceList () {
      return this.$store.state.CommonService.commonObj.serviceList.filter(item => item.status === 1)
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
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
          { key: 'service_bn' },
          { key: 'com_title_bn' },
          { key: 'status_name_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'service_en' },
          { key: 'com_title' },
          { key: 'status_name' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
   formTitle () {
      return (this.editItemId === 0) ? this.$t('complain_management.complain') + ' ' + this.$t('globalTrans.entry') : this.$t('complain_management.complain') + ' ' + this.$t('globalTrans.modify')
  }
  },
  methods: {
    getDistrictList () {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.division_id === this.search.division_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUpazilaList () {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.district_id === this.search.district_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUnionList () {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.division_id === this.search.division_id && item.district_id === this.search.district_id && item.upazila_id === this.search.upazila_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, complainSubmitToggle, item)
      }
    },
    // searchData () {
    //   this.loadData()
    // },
    searchData () {
          if (this.search.org_id !== 0) {
              this.loadData()
          }
      },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, complainSubmitList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
          const cmtObj = this.$store.state.CommonService.commonObj.serviceList.find(cmt => cmt.value === parseInt(item.service_id))
          const diviObj = this.$store.state.CommonService.commonObj.divisionList.find(cmt => cmt.value === parseInt(item.division_id))
          const districtObj = this.$store.state.CommonService.commonObj.districtList.find(cmt => cmt.value === parseInt(item.district_id))
          const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(cmt => cmt.value === parseInt(item.upazila_id))
          const unionObj = this.$store.state.CommonService.commonObj.unionList.find(cmt => cmt.value === parseInt(item.union_id))
          const objectData = this.$store.state.commonObj.statusList.find(cmt => cmt.value === parseInt(item.status))

          const orgData = {}
          if (typeof orgObj !== 'undefined') {
            orgData.org_name = orgObj.text_en
            orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }
          const diviData = {}
          if (typeof diviObj !== 'undefined') {
            diviData.division_en = diviObj.text_en
            diviData.division_bn = diviObj.text_bn
          } else {
            diviData.division_en = ''
            diviData.division_bn = ''
          }

          const districData = {}
          if (typeof districtObj !== 'undefined') {
            districData.district_en = districtObj.text_en
            districData.district_bn = districtObj.text_bn
          } else {
            districData.district_en = ''
            districData.district_bn = ''
          }

          const upazilaData = {}
          if (typeof upazilaObj !== 'undefined') {
            upazilaData.upazila_en = upazilaObj.text_en
            upazilaData.upazila_bn = upazilaObj.text_bn
          } else {
            upazilaData.upazila_en = ''
            upazilaData.upazila_bn = ''
          }

          const unionObjData = {}
          if (typeof unionObj !== 'undefined') {
            unionObjData.unionObj_en = unionObj.text_en
            unionObjData.unionObj_bn = unionObj.text_bn
          } else {
            unionObjData.unionObj_en = ''
            unionObjData.unionObj_bn = ''
          }

          const serviceData = {}
          if (typeof cmtObj !== 'undefined') {
            serviceData.service_en = cmtObj.text_en
            serviceData.service_bn = cmtObj.text_bn
          } else {
            serviceData.service_en = ''
            serviceData.service_bn = ''
          }
          const statusData = {}
          if (typeof objectData !== 'undefined') {
            statusData.status_name = objectData.text_en
            statusData.status_name_bn = objectData.text_bn
          } else {
            statusData.status_name = ''
            statusData.status_name_bn = ''
          }
          return Object.assign({}, item, { serial: index + 0 }, orgData, serviceData, statusData, diviData, districData, upazilaData, unionObjData)
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
      this.changeStatus(1, commonServiceBaseUrl, complainSubmitToggle, item)
    }
  }
}
</script>

<style>
.btn-success {
  background-color: var(--success) !important;
  border-color: var(--success);
}
</style>
