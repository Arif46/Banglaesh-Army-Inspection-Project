<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('informationTraining.content_management') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
            <b-col xs="12" sm="12" md="4">
              <ValidationProvider name="Council Name" vid="council_info_id" rules="" v-slot="{ errors }">
                <b-form-group
                  label-for="council_info_id"
                >
                <template v-slot:label>
                  {{$t('eBizConfig.council_name')}}
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
            <b-col xs="12" sm="12" md="4">
              <ValidationProvider name="Association Name" vid="association_info_id" rules="" v-slot="{ errors }">
                <b-form-group label-for="association_info_id">
                  <template v-slot:label>
                    {{$t('eBizConfig.association_name')}}
                  </template>
                  <b-form-select plain v-model="search.association_info_id" :options="associationInfoList" id="association_info_id"
                    :state="errors[0] ? false : (valid ? true : null)">
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
            <b-col xs="12" sm="12" md="4">
              <ValidationProvider name="Training Type" vid="training_type" rules="" v-slot="{ errors }">
                <b-form-group label-for="training_type">
                  <template v-slot:label>
                    {{ $t('informationTraining.training_type') }}
                  </template>
                  <b-form-input id="training_type" v-model="search.training_type"
                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4">
              <ValidationProvider name="Program Name" vid="program_name" rules="" v-slot="{ errors }">
                <b-form-group
                  label-for="program_name">
                  <template v-slot:label>
                    {{ $t('informationTraining.program_name') }}
                  </template>
                  <b-form-input
                    id="program_name"
                    v-model="search.program_name"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
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
        <h4 class="card-title">{{ $t('informationTraining.content_management') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(council_name)="data">
                    {{ getCouncilName(data.item.council_info_id) }}
                  </template>
                  <template v-slot:cell(program_name)="data">
                    {{ currentLocale == 'bn' ? data.item.program_name_bn : data.item.program_name}}
                  </template>
                  <template v-slot:cell(content_name)="data">
                    {{ currentLocale == 'bn' ? data.item.content_name_bn : data.item.content_name}}
                  </template>
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ getName(data.item.fiscal_year_id, 'fiscal_year') }}
                  </template>
                  <template v-slot:cell(association_name)="data">
                    {{ getAssociationName(data.item.association_info_id, {useGrouping: false}) }}
                  </template>
                  <template v-slot:cell(content_attachment)="data">
                    <span v-if="data.item.content_attachment !== null"><a target="_blank" class="btn btn-primary mr-2"
                        :href="eBizServiceBaseUrl+'download-attachment?file='+data.item.content_attachment"
                        title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                    <span v-else>N/A</span>
                  </template>
                  <template v-slot:cell(action)="data">
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
import Details from './Details.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { contentManagementList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
      Details
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        council_info_id: 0,
        program_name: '',
        association_info_id: 0,
        training_type: '',
        limit: 10
      },
      items: [],
      associationInfoList: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'informationTraining.council_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'informationTraining.association_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'informationTraining.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'informationTraining.training_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'informationTraining.content_attachment', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '10%' } },
        { labels: 'informationTraining.remarks', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 10, thStyle: { width: '5%' } }
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
    }
  },
  computed: {
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
          { key: 'program_name_bn' },
          { key: 'fiscal_year_id' },
          { key: 'training_type_bn' },
          { key: 'content_attachment' },
          { key: 'remarks_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'council_name' },
          { key: 'association_name' },
          { key: 'program_name' },
          { key: 'fiscal_year_id' },
          { key: 'training_type' },
          { key: 'content_attachment' },
          { key: 'remarks' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('informationTraining.content_management') + ' ' + this.$t('globalTrans.entry') : this.$t('informationTraining.content_management') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return this.$t('informationTraining.content_management') + ' ' + this.$t('globalTrans.details')
    },
    trainingTypeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Draft' : 'খসড়া' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Processing' : 'প্রক্রিয়াধীন' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Agreement' : 'চুক্তি' }
      ]
      return list
    }
  },
  methods: {
    edit (item) {
        this.editItemId = item.id
      },
    details (item) {
        this.items = item
    },
    getName (id, type) {
      let obj = {}
      if (type === 'fiscal_year') {
        obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      }
      return this.$i18n.locale === 'bn' ? obj?.text_bn : obj?.text_en
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
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, contentManagementList, params)
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
  }
}
</script>
