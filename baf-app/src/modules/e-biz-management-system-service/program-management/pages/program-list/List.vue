<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizProgram.program_list') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="fiscal_year"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fiscal_year"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
         <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Council Name" vid="council_info_id" rules="">
                  <b-form-group
                      label-for="council_info_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eBizProgram.council_name')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.council_info_id"
                      :options="councilInfoList"
                      id="council_info_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
              </ValidationProvider>
           </b-col>
          <b-col md="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
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
        <h4 class="card-title">{{ $t('eBizProgram.program_list') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                 <template v-slot:cell(association)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                 <template v-slot:cell(proposal_id)="data">
                    {{ data.item.program?.proposal?.proposal_id }}
                  </template>
                 <template v-slot:cell(program_id)="data">
                    {{ $n(data.item.proposal_detail_id , {useGrouping: false})}}
                  </template>
                 <template v-slot:cell(program_name)="data">
                    {{ currentLocale == 'en' ? data.item.program.programe_name_en : data.item.program.programe_name_bn }}
                  </template>
                  <template v-slot:cell(program_start_date)="data">
                    {{ data.item.start_date | dateFormat }}
                  </template>
                  <template v-slot:cell(program_end_date)="data">
                    {{ data.item.end_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status === 2" >{{$t('globalTrans.pending')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i>
                    </b-button>
                    <b-button v-if="data.item.status === 2" v-b-modal.edit-form variant="iq-bg-success mr-1" size="sm" @click="editProgram(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button  v-b-modal.send @click="send(data.item)" class="btn btn-sm btn-success"> {{ $t('globalTrans.send') }}
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
   <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
    <Details :items="items" :key="viewitemId"/>
   </b-modal>
     <b-modal id="edit-form" size="lg" :title="editTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <EditForm :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="send" size="lg" :title="sendTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <send-form :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import SendForm from './SendForm.vue'
import EditForm from './Form-edit.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, EditForm, SendForm
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        proposals: [],
      search: {
        fiscal_year_id: 0,
        council_info_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.association', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.proposal_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.program_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
        { labels: 'globalTrans.start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } },
        { labels: 'globalTrans.end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 10, thStyle: { width: '12%' } }
      ],
      items: [],
      viewitemId: 0,
      actions: {
        edit: true,
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
          { key: 'fiscal_year_bn' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'program_id' },
          { key: 'program_name' },
          { key: 'program_start_date' },
          { key: 'program_end_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'program_id' },
          { key: 'program_name' },
          { key: 'program_start_date' },
          { key: 'program_end_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('eBizProgram.program_list') + ' ' + this.$t('globalTrans.view') : this.$t('eBizProgram.program_list') + ' ' + this.$t('globalTrans.modify')
    },
    editTitle () {
      return this.$t('eBizProgram.program_list') + ' ' + this.$t('globalTrans.modify')
    },
    sendTitle () {
      return this.$t('eBizProgram.program_list') + ' ' + this.$t('globalTrans.send')
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
        this.items = item
    },
    editProgram (item) {
        this.items = item
    },
    send (item) {
        this.items = item
    },
     editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
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
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, programList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
          const fiscalYearService = fiscalYearList.find(tmp => tmp.value === item.fiscal_year_id)
          const fisalYearObj = {
          serial: index,
          fiscal_year: fiscalYearService !== 'undefined' ? fiscalYearService.text_en : '',
          fiscal_year_bn: fiscalYearService !== 'undefined' ? fiscalYearService.text_bn : ''
        }
          return Object.assign({}, item, fisalYearObj, { serial: index, select: 0 })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
