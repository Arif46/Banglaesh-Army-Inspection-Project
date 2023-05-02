<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('moc_portal.about_service_portal') + ' ' + $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-4><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                  <template v-slot:cell(about)="data">
                      <p v-if="$i18n.locale === 'en'" v-html="data.item.description.length > 500 ? (shortString(data.item.description, 500) + '...') : data.item.description"></p>
                      <p v-else v-html="data.item.description_bn.length > 500 ? (shortString(data.item.description_bn, 500) + '...') : data.item.description_bn"></p>
                  </template>
                  <template v-slot:cell(status)="data">
                    {{ data.item.status ? $t('globalTrans.active') : $t('globalTrans.inactive') }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-4 variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button variant=" iq-bg-danger" size="sm" @click="remove(data.item)" class="action-btn delete" :title="$t('globalTrans.delete')"><i class="ri-delete-bin-2-line"></i></b-button>
                  </template>
                </b-table>
              </slot>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-4" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
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
import BreadCumb from '@/components/BreadCumb.vue'
import Form from './Form.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { aboutPortalListApi, aboutPortalToggleStatusApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
  { label_en: i18n.messages.en.globalTrans.description, label_bn: i18n.messages.bn.globalTrans.description, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '40%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 4, thStyle: { width: '20%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, BreadCumb
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
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
          { key: 'about' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'about' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
       return (this.editItemId === 0) ? `${this.$t('moc_portal.about_service_portal')} ${this.$t('globalTrans.entry')}` : `${this.$t('moc_portal.about_service_portal')} ${this.$t('globalTrans.modify')}`
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    shortString (str, n) {
        return (str.length > n) ? str.substr(0, n - 1) + '...' : str
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = null
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, aboutPortalListApi, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.$store.dispatch('setList', listData)
      } else {
        this.$store.dispatch('setList', [])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    remove (item) {
      this.changeStatus(1, commonServiceBaseUrl, aboutPortalToggleStatusApi, item)
    }
  }
}
</script>
