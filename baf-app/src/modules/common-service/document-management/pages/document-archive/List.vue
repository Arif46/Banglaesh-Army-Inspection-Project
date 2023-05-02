<template>
  <div class="inner-section">
    <card></card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('docuement_management.document') }} {{ $t('docuement_management.archive')}} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(attachment)="data">
                    <div class="text-center">
                      <a :href="commonServiceBaseUrl + 'download-attachment?file=' + data.item.attachment" class="badge badge-primary">
                        <i class="ri-cloud-fill"></i>
                        {{ $t('globalTrans.attachment') }}
                      </a>
                    </div>
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
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { documentArchiveList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import Card from '../../../../../components/Card.vue'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.organization, label_bn: i18n.messages.bn.globalTrans.organization, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.docuement_management.category, label_bn: i18n.messages.bn.docuement_management.category, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.docuement_management.document, label_bn: i18n.messages.bn.docuement_management.document, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.docuement_management.attachment, label_bn: i18n.messages.bn.docuement_management.attachment, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '40%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Card
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl,
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        status: 3,
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: []
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
          { key: 'document_cat_bn' },
          { key: 'doc_title_bn' },
          { key: 'attachment' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'document_cat_en' },
          { key: 'doc_title' },
          { key: 'attachment' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('docuement_management.document') + ' ' + this.$t('globalTrans.entry') : this.$t('docuement_management.document') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, documentArchiveList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
        const documentCategoryObj = this.$store.state.CommonService.commonObj.documentCategoryList.find(documentCategoryItem => documentCategoryItem.value === parseInt(item.category_id))
        const orgData = {}
        const documentCategoryData = {}
          if (typeof orgObj !== 'undefined') {
            orgData.org_name = orgObj.text_en
            orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }
          if (typeof documentCategoryObj !== 'undefined') {
            documentCategoryData.document_cat_en = documentCategoryObj.text_en
            documentCategoryData.document_cat_bn = documentCategoryObj.text_bn
          } else {
            documentCategoryData.document_cat_en = ''
            documentCategoryData.document_cat_bn = ''
          }
          return Object.assign({}, item, { serial: index }, orgData, documentCategoryData)
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
