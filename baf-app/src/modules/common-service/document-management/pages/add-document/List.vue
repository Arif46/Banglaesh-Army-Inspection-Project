<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('docuement_management.document') }}</h4>
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
              :options="orgProfileList"
              id="org_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="category_id"
            >
            <template v-slot:label>
              {{$t('docuement_management.category')}}
            </template>
            <b-form-select
              plain
              v-model="search.category_id"
              :options="documentCategoryList"
              id="designaitonList"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="doc_title"
            >
              <template v-slot:label>
                {{ $t('docuement_management.document_title') }}
              </template>
              <b-form-input
                  id="doc_title"
                  type="text"
                  v-model="search.doc_title"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col sm="4">
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
        <h4 class="card-title">{{ $t('docuement_management.document') }}</h4>
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
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(attachment)="data">
                    <div class="text-center">
                      <a :href="commonServiceBaseUrl + 'download-attachment?file=' + data.item.attachment" class="badge badge-primary">
                        <i class="ri-cloud-fill"></i>
                        {{ $t('globalTrans.attachment') }}
                      </a>
                    </div>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button variant=" iq-bg-danger" size="sm" @click="remove(data.item)" class="action-btn delete" :title="$t('globalTrans.delete')"><i class="ri-delete-bin-line"></i></b-button>
                    <b-button variant=" iq-bg-success" size="sm" @click="archive(data.item)" class="action-btn detail" :title="$t('docuement_management.archive')"><i class="ri-archive-fill"></i></b-button>
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
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
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
import { documentList, documentToggle, documentArchive } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.organization, label_bn: i18n.messages.bn.globalTrans.organization, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.docuement_management.category, label_bn: i18n.messages.bn.docuement_management.category, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.docuement_management.document, label_bn: i18n.messages.bn.docuement_management.document, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.docuement_management.attachment, label_bn: i18n.messages.bn.docuement_management.attachment, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 7 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl,
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        org_id: 0,
        category_id: 0,
        doc_title: '',
        status: [1, 2],
        limit: 20
      },
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
          { key: 'attachment' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'document_cat_en' },
          { key: 'doc_title' },
          { key: 'attachment' },
          { key: 'status' },
          { key: 'action' }
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
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).map(item => {
            if (this.$i18n.locale === 'bn') {
                return { value: item.value, text: item.text_bn }
            } else {
                return { value: item.value, text: item.text_en }
            }
        })
    },
    documentCategoryList () {
        return this.$store.state.CommonService.commonObj.documentCategoryList.filter(item => item.status === 1).map(item => {
            if (this.$i18n.locale === 'bn') {
                return { value: item.value, text: item.text_bn }
            } else {
                return { value: item.value, text: item.text_en }
            }
        })
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, documentList, params)
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
    },
    remove (item) {
      this.changeStatus(1, commonServiceBaseUrl, documentToggle, item)
    },
    archive (item) {
      this.$swal({
        title: this.$t('globalTrans.archivedChangeMsg'),
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.ArchivetoggleStatus(item)
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        }
      })
    },
    ArchivetoggleStatus (item) {
      RestApi.deleteData(commonServiceBaseUrl, `${documentArchive}/${item.id}`).then(response => {
        if (response.success) {
          this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
          this.$toast.success({
            title: 'Success',
            message: 'Data Updated Successfully',
            color: '#D6E09B'
          })
        } else {}
      })
    }
  }
}
</script>
