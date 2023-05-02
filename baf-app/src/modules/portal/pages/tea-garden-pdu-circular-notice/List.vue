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
                                      :id="'checkbox-' + field.labels"
                                      v-model="field.show"
                                      :name="'checkbox-' + field.labels"
                                      value=1
                                      unchecked-value=0
                                    >
                                      {{ $t(field.labels)  }}
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
                          <template v-slot:cell(course_fee)="data">
                            <span>{{ $n(data.item.course_fee) }}</span>
                          </template>
                          <template v-slot:cell(course_name)="data">
                            <span v-if="data.item.course">{{ currentLocale === 'en' ? data.item.course.course_name_en : data.item.course.course_name_bn }}</span>
                          </template>
                          <template v-slot:cell(attachment)="data">
                            <span v-if="data.item.attachment"><a target="_blank" :href="isImage(data.item.attachment) ? teaGardenServiceBaseUrl + 'storage' + data.item.attachment : teaGardenServiceBaseUrl + data.item.attachment">{{ $t('globalTrans.download') }}</a></span>
                          </template>
                          <template v-slot:cell(application_deadline)="data">
                            <span>{{ data.item.application_deadline | dateFormat }}</span>
                          </template>
                          <template v-slot:cell(action)="data">
                            <router-link class="moc-action-btn moc-view-btn"
                            :to="{name: 'portal.circular_details', params: { id: data.item.id }}"
                            :title="$t('globalTrans.view')">
                            <i class="ri-eye-line"></i>
                            </router-link>
                            <b-button @click="setServiceUrl(data.item.id)" class="btn btn-sm btn-success" style="border-radius:20px;width: 114px" v-if="data.item.application_deadline >= today && data.item.status === 3"
                              :title="$t('globalTrans.apply')">
                            {{ $t('globalTrans.apply') }}
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
          </b-container>
        </div>
    </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import ModalBaseMasterList from '@/mixins/list'
import { circularApprovedList } from '../../api/routes'
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      today: new Date().toJSON().slice(0, 10),
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      search: {
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '7%' } },
        { labels: 'teaGardenPduService.course_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
        { labels: 'teaGardenPduService.circular_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: 'auto' } },
        { labels: 'teaGardenPduService.course_fee', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'teaGardenPduService.application_deadline', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } },
        { labels: 'teaGardenPduService.attachment', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 9, thStyle: { width: '12%' } }
      ],
      sortDesc: true,
      sortDirection: 'desc',
      editItemId: '',
      service_name: '',
      item: ''
    }
  },
  created () {
    window.scrollTo(0, 0)
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
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'course_name' },
          { key: 'circular_title_bn' },
          { key: 'course_fee' },
          { key: 'application_deadline' },
          { key: 'attachment' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'course_name' },
          { key: 'circular_title_en' },
          { key: 'course_fee' },
          { key: 'application_deadline' },
          { key: 'attachment' },
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
      const result = await RestApi.getData(teaGardenServiceBaseUrl, circularApprovedList, params)
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
    },
    setServiceUrl (circularId) {
      const redirectUrl = this.$route.params.service_url + '?circular_id=' + circularId
      this.$store.dispatch('Portal/setServiceUrl', {
        externalPanelServiceUrl: redirectUrl,
        externalPanelCurrentServiceUrl: redirectUrl
      })
      this.$router.push('/auth/login').catch(() => {})
    },
    isImage (path) {
        return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
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
