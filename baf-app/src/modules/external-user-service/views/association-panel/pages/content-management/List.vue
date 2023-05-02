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
              <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="" v-slot="{ errors }">
                <b-form-group
                  label-for="fiscal_year_id"
                >
                <template v-slot:label>
                  {{$t('globalTrans.fiscal_year')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.fiscal_year_id"
                  :options="fiscalYearList"
                  id="fiscal_year_id"
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
            <ValidationProvider name="Program Name" vid="program_name" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="program_name">
                <template v-slot:label>
                  {{ $t('eBizProgram.program_name') }}
                </template>
                <b-form-input
                  id="program_name"
                  v-model="search.program_name"
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
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(fiscal_year)="data">
                    {{ getFiscalYear(data.item.fiscal_year_id) }}
                  </template>
                 <template v-slot:cell(content_documents)="data">
                     <span v-if="data.item.content_attachment !== null"><a target="_blank" class="btn btn-primary mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+data.item.content_attachment" title="Content Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                    <span v-else>N/A</span>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status === 1 ">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-success" v-if="data.item.status === 2">{{$t('globalTrans.submitted')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="data.item.status === 1" v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
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
import { contentManagementList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

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
        fiscal_year_id: 0,
        product_name: '',
        council_info_id: 0,
        association_info_id: 0,
        limit: 10
      },
      items: [],
      profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile,
      associationInfoList: [],
      warehouseList: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'informationTraining.training_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'informationTraining.content_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'informationTraining.content_documents', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
        { labels: 'globalTrans.remarks', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 10, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 12, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 13, thStyle: { width: '5%' } }
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
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
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
          { key: 'fiscal_year' },
          { key: 'training_type_bn' },
          { key: 'program_name_bn' },
          { key: 'content_name_bn' },
          { key: 'content_documents' },
          { key: 'remarks_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'training_type' },
          { key: 'program_name' },
          { key: 'content_name' },
          { key: 'content_documents' },
          { key: 'remarks' },
          { key: 'status' },
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
    fiscalYearList () {
       return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
     }
  },
  methods: {
    edit (item) {
        this.editItemId = item.id
      },
      details (item) {
        this.items = item
      },
      getCouncilName (councilNameId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
      getAssociationName (associationId) {
          const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
      },
      getFiscalYear (yearId) {
          const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
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
      this.search.council_info_id = this.profile.council_info_id
      this.search.association_info_id = this.profile.association_info_id
      this.search.locale = this.currentLocale
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
