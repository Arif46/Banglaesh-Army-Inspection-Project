<template>
    <div class="inner-section">
      <card>
        <!-- search section start -->
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">{{ $t('teaGardenPduService.circular') }} {{ $t('globalTrans.search') }}</h4>
        </template>
        <template v-slot:searchBody>
          <b-row>
            <!-- course_name -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Course Name" vid="course_id" rules="required|min_value:1">
                <b-form-group
                    label-for="course_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('teaGardenPduService.course_name')}}
                    </template>
                    <b-form-select
                    plain
                    v-model="search.course_id"
                    :options="courseList"
                    id="service_id"
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
            <!-- circular name -->
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="circular_title"
              >
                <template v-slot:label>
                  {{ $t('teaGardenPduService.circular_name') }}
                </template>
                <b-form-input
                    id="circular_title"
                    type="text"
                    v-model="search.circular_title"
                ></b-form-input>
              </b-form-group>
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
          <h4 class="card-title">{{ $t('teaGardenPduService.circular') }} {{ $t('globalTrans.list') }}</h4>
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
                      <span>{{ getCourseName(data.item.course_id) }}</span>
                    </template>
                    <template v-slot:cell(attachment)="data">
                      <span v-if="data.item.attachment"><a target="_blank" :href="isImage(data.item.attachment) ? teaGardenServiceBaseUrl + 'storage' + data.item.attachment : teaGardenServiceBaseUrl + data.item.attachment">{{ $t('globalTrans.download') }}</a></span>
                    </template>
                    <template v-slot:cell(application_deadline)="data">
                      <span>{{ data.item.application_deadline | dateFormat }}</span>
                    </template>
                    <template v-slot:cell(action)="data">
                      <router-link class="moc-action-btn moc-view-btn"
                       :to="{name: 'tea_garden_panel.circular_details', params: { id: data.item.id }}"
                       :title="$t('globalTrans.view')">
                       <i class="ri-eye-line"></i>
                      </router-link>
                      <router-link class="btn btn-sm btn-success" style="border-radius:20px;width: 114px" v-if="data.item.application_deadline >= today && data.item.status === 3"
                        :to="{name: 'tea_garden_panel.course_application_form', query: { circular_id: data.item.id }}"
                        :title="$t('globalTrans.apply')">
                       {{ $t('globalTrans.apply') }}
                      </router-link>
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
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { circularApprovedList } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/route-based-list'
  const today = new Date().toISOString().substr(0, 10)
  export default {
    mixins: [ModalBaseMasterList],
    components: {},
    data () {
      return {
        sortBy: '',
        sortDirection: 'desc',
        sortDesc: true,
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        search: {
          circular_title: '',
          course_id: 0,
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
        editItemId: 0,
        today: today,
        item: {
          id: 0
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
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
      },
      courseList: function () {
        return this.$store.state.ExternalUserService.teaGarden.commonObj.pduCourseList.filter(item => item.status === 1)
      }
    },
    methods: {
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, circularApprovedList, params)
        if (result.success) {
          const listData = result.data.data.map((item, index) => {
              return Object.assign({ serial: index }, item)
          })
          this.$store.dispatch('setList', listData)
          this.paginationData(result.data, this.search.limit)
        } else {
          this.$store.dispatch('setList', [])
          this.paginationData([])
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      },
      getCourseName (id) {
        const obj = this.$store.state.ExternalUserService.teaGarden.commonObj.pduCourseList.find(item => item.value === id)
        if (obj) {
          return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
        }
        return '-'
      },
      isImage (path) {
          return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
      }
    }
  }
  </script>
