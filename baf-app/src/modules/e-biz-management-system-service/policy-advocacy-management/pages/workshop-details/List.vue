<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('policyAdvocacy.workshop_details') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col lg="4" sm="4">
            <ValidationProvider name="Fiscal Year id" vid="fiscal_year_id" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="fiscal_year_id"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.fiscal_year_id"
                  :options="fiscalYearList"
                  id="org_id"
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
          <b-col sm="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
            <b-button size="sm" type="submit" variant="primary" class="mt-20">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
        </b-form>
      </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('policyAdvocacy.workshop_details_list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <!-- <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" /> -->
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial) }}
                  </template>
                  <template v-slot:cell(council_name)="data">
                    {{ getCouncilName(data.item.council_info_id) }}
                  </template>
                  <template v-slot:cell(association_name)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                  <template v-slot:cell(mobile_no)="data">
                    {{ data.item.mobile | mobileNumber }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status === 0">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-warning" v-if="data.item.status === 1">{{$t('globalTrans.approved')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-b-modal.modal-details variant=" iq-bg-success mr-1" size="sm" @click="details(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { workshopDetailsListt, workshopDetailsToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import { dateFormat, dateFormatBn } from '@/utils/fliter'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        council_info_id: 0,
        association_info_id: 0,
        fiscal_year_id: 0,
        mobile: '',
        limit: 10
      },
      items: [],
      associationInfoList: [],
      start_date: '',
      end_date: '',
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'eBizConfig.council_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'eBizConfig.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'policyAdvocacy.workshop_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'policyAdvocacy.workshop_place_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'policyAdvocacy.workshop_date_from', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'policyAdvocacy.workshop_date_to', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 7, thStyle: { width: '5%' } }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.council_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.associationInfoList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
        }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const fiscalYear = this.fiscalYearList.find(item => item.value === newVal)
        this.start_date = fiscalYear.start_date
        this.end_date = fiscalYear.end_date
      }
    }
  },
  computed: {
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn), end_date: item.end_date, start_date: item.start_date }
        } else {
          return { value: item.value, text: item.text_en, end_date: item.end_date, start_date: item.start_date }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    councilInfoList () {
       return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
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
          { key: 'council_name' },
          { key: 'association_name' },
          { key: 'workshop_name_bn' },
          { key: 'workshop_place_bn' },
          { key: 'start_date_bn' },
          { key: 'end_date_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'council_name' },
          { key: 'association_name' },
          { key: 'workshop_name' },
          { key: 'workshop_place' },
          { key: 'startt_date' },
          { key: 'endd_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('policyAdvocacy.workshop_details') + ' ' + this.$t('globalTrans.entry') : this.$t('policyAdvocacy.workshop_details') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return this.$t('policyAdvocacy.workshop_details_view')
    }
  },
  methods: {
    edit (item) {
        this.editItemId = item.id
      },
      details (item) {
        this.items = item
      },
      remove (item) {
        this.changeStatus(3, eBizServiceBaseUrl, workshopDetailsToggle, item)
      },
      getCouncilName (councilNameId) {
            const cateObj = this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
      },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.search.start_date = this.start_date
      this.search.end_date = this.end_date
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, workshopDetailsListt, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          return Object.assign({}, item, { serial: index + 1, startt_date: dateFormat(item.start_date), endd_date: dateFormat(item.end_date), start_date_bn: dateFormatBn(item.start_date), end_date_bn: dateFormatBn(item.end_date) })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    }
  }
}
</script>
