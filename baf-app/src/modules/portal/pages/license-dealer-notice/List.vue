<template>
    <div class="service-details-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ Object.keys($route.params).length > 0 ? checkServiceName() : $t('portal.circular') + ' ' + $t('globalTrans.list') }}</h2>
            <img src="../../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
          <b-container>
            <ol class="breadcrumb custom-bread">
              <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
              <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{ $t('portal.all_service') }}</router-link></li>
              <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.service_details') }}</span></li>
            </ol>
          </b-container>
        </div>
        <div class="service-description">
          <b-container>
            <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.list') }}</h4>
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
                          <template v-slot:cell(notice_date)="data">
                            <span>{{ data.item.notice_date | dateFormat }}</span>
                          </template>
                          <template v-slot:cell(start_date)="data">
                            <span>{{ data.item.start_date | dateFormat }}</span>
                          </template>
                          <template v-slot:cell(end_date)="data">
                            <span>{{ data.item.end_date | dateFormat }}</span>
                          </template>
                          <template v-slot:cell(memorial_no)="data">
                            <span>{{ EngBangNum(data.item.memorial_no) }}</span>
                          </template>
                          <template v-slot:cell(action)="data">
                            <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-1" size="sm" class="btn btn-primary apply_btn" @click="details(data.item)" :title="$t('globalTrans.view')">{{ $t('globalTrans.view') }}</b-button><br/>
                            <span v-if="(data.item.start_date <= currentDate) && (data.item.end_date >= currentDate)">
                              <b-button class="btn btn-success apply_btn" variant="iq-bg-success mr-1 my-1" size="sm" @click="setServiceUrl(data.item)" :title="$t('license_management.application')">{{ $t('license_management.application') }}</b-button>
                            </span>
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
          </b-container>
        </div>
      <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Details :id="editItemId" :key="editItemId" :item="item" />
      </b-modal>
    </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.license_management.title, label_bn: i18n.messages.bn.license_management.title, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '14%' } },
  { label_en: i18n.messages.en.license_management.memorial_no, label_bn: i18n.messages.bn.license_management.memorial_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.license_management.notice_date, label_bn: i18n.messages.bn.license_management.notice_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.license_management.start_date, label_bn: i18n.messages.bn.license_management.start_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.license_management.end_date, label_bn: i18n.messages.bn.license_management.end_date, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 7, thStyle: { width: '15%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      currentDate: new Date().toJSON().slice(0, 10),
      sortBy: '',
      search: {
        fiscal_year_id: 0,
        year: 0,
        memo_no: '',
        title_en: '',
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      editItemId: '',
      service_name: '',
      item: ''
    }
  },
  components: {
    Details
  },
  created () {
    window.scrollTo(0, 0)
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
    currentLocale () {
      return this.$i18n.locale
    },
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
          { key: 'title_bn' },
          { key: 'memorial_no' },
          { key: 'notice_date' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'title_en' },
          { key: 'memorial_no' },
          { key: 'notice_date' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    detailsTitle () {
      return this.$t('portal.recruitment_notice') + ' ' + this.$t('globalTrans.details')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    }
  },
  methods: {
    checkServiceName () {
      return this.currentLocale === 'bn' ? this.$route.params.name_bn : this.$route.params.name
    },
    details (item) {
      this.editItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async loadData () {
      const params = Object.assign({}, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
       this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/portal/dealer-license/recruitment-notice-list', params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index }, { start_date: item.start_date }, { end_date: item.end_date })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
       this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    setServiceUrl (item) {
      this.$store.dispatch('Portal/setServiceUrl', {
        externalPanelServiceUrl: '/dealer-panel/applications',
        externalPanelCurrentServiceUrl: '/dealer-panel/applications'
      })
      this.$router.push('/auth/login').catch(() => {})
    }
  }
}
</script>
<style scoped>
  .apply_btn{
    font-size: 13px;
    padding: 3px 5px;
  }
</style>
