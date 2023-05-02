<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('research_plan_management.prepare_EOI') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
         <b-row>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Title" vid="title" v-slot="{ errors }">
              <b-form-group
                label-for="title">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }}
                </template>
                <b-form-input
                  id="title"
                  v-model="search.title"
                  :placeholder="$t('globalTrans.title')"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Organization/Ministry/Division (En)" vid="organization_ministry_division" v-slot="{ errors }">
              <b-form-group
                label-for="organization_ministry_division">
                <template v-slot:label>
                  {{ $t('research_plan_management.organization_ministry_division') }}
                </template>
                <b-form-input
                  id="organization_ministry_division"
                  v-model="search.organization_ministry_division"
                  :placeholder="$t('research_plan_management.organization_ministry_division')"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
         <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Start date" vid="from_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="from_date">
                <template v-slot:label>
                  {{ $t('globalTrans.start_date') }}
                </template>
                <date-picker
                  id="from_date"
                  v-model="search.from_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="End date" vid="to_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="to_date">
                <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}
                </template>
                 <date-picker
                  id="to_date"
                  v-model="search.to_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="3" class="mt-3">
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
        <h4 class="card-title">{{ $t('research_plan_management.prepare_EOI') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link  class="btn-add" to="/bfti-research-and-report-service/research-plan-preparation/prepare-eoi/prepare-eoi-form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
      </template>
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
                  <template v-slot:cell(eio_date)="data">
                    {{ data.item.eio_date| dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status == 2">{{$t('globalTrans.finalSave')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('research_plan_management.published')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" variant=" iq-bg-success mr-1" title="Edit" :to="`/bfti-research-and-report-service/research-plan-preparation/prepare-eoi/prepare-eoi-form/${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>
                    <b-button class="action-btn btn-success" v-if="data.item.status == 1" @click="remove(data.item)" title="Submit" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" title="View" :to="`/bfti-research-and-report-service/research-plan-preparation/prepare-eoi/prepare-eoi-detail/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
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
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { prepareEioList, prepareEioTogle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        area_type_id: 0,
        title: '',
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        from_date: '',
        to_date: '',
        organization_ministry_division: '',
        market_directory_id: 0,
        prepare_EOI_collection_date: '',
        divisionList: [],
        districtList: [],
        upazillaList: [],
        marketList: [],
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'research_plan_management.organization_ministry_division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'research_plan_management.eoi_reference_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'research_plan_management.agency', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      marketList: [],
      cityCorporationList: [],
      pauroshobaList: []
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
          { key: 'title_bn' },
          { key: 'organization_ministry_division_bn' },
          { key: 'eoi_reference_no' },
          { key: 'agency_bn' },
          { key: 'eio_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'title' },
          { key: 'organization_ministry_division' },
          { key: 'eoi_reference_no' },
          { key: 'agency' },
          { key: 'eio_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(bftiResReportServiceBaseUrl, prepareEioTogle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, prepareEioList, params)
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
          const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
          const districtData = {}
          if (typeof districtObj !== 'undefined') {
            districtData.district_name = districtObj.text_en
            districtData.district_name_bn = districtObj.text_bn
          } else {
            districtData.district_name = ''
            districtData.district_name_bn = ''
          }
          const upazillaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazilla => upazilla.value === parseInt(item.upazila_id))
          const upazillaData = {}
          if (typeof upazillaObj !== 'undefined') {
            upazillaData.upazila_name = upazillaObj.text_en
            upazillaData.upazila_name_bn = upazillaObj.text_bn
          } else {
            upazillaData.upazila_name = ' '
            upazillaData.upazila_name_bn = ' '
          }
          const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === parseInt(item.market_directory_id))
          const marketData = {}
          if (typeof marketDirectoryObj !== 'undefined') {
            marketData.market_name_en = marketDirectoryObj.text_en
            marketData.market_name_bn = marketDirectoryObj.text_bn
          } else {
            marketData.market_name_en = ' '
            marketData.market_name_bn = ' '
          }
          const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(areaType => areaType.value === parseInt(item.area_type_id))
          const areaTypeData = {}
          if (typeof areaTypeObj !== 'undefined') {
            areaTypeData.area_type_en = areaTypeObj.text_en
            areaTypeData.area_type_bn = areaTypeObj.text_bn
          } else {
            areaTypeData.area_type_en = ''
            areaTypeData.area_type_bn = ''
          }
          const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(cityCorporation => cityCorporation.value === parseInt(item.city_corporation_id))
          const cityCOrporationData = {}
          if (typeof cityCorporationObj !== 'undefined') {
            cityCOrporationData.city_corporation_en = cityCorporationObj.text_en
            cityCOrporationData.city_corporation_bn = cityCorporationObj.text_bn
          } else {
            cityCOrporationData.city_corporation_en = ''
            cityCOrporationData.city_corporation_bn = ''
          }
          const pourosoabaObj = this.$store.state.CommonService.commonObj.municipalityList.find(pouroshova => pouroshova.value === parseInt(item.pauroshoba_id))
          const pouroshobaData = {}
          if (typeof pourosoabaObj !== 'undefined') {
            pouroshobaData.pourosova_name = pourosoabaObj.text_en
            pouroshobaData.pourosova_name_bn = pourosoabaObj.text_bn
          } else {
            pouroshobaData.pourosova_name = ''
            pouroshobaData.pourosova_name_bn = ''
          }
          return Object.assign({}, item, { serial: index + 0 }, divisionData, districtData, upazillaData, marketData, areaTypeData, cityCOrporationData, pouroshobaData)
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
      this.changeStatus(6, bftiResReportServiceBaseUrl, prepareEioTogle, item)
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
