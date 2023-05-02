<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenBtriService.pending_application') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <!-- service list  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="service_name"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.service_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.service_id"
                :options="serviceList"
                id="service_name"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <!-- fiscal year list  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{ $t('globalTrans.fiscal_year') }}
              </template>
            <b-form-select
                plain
                v-model="search.fiscal_year_id"
                :options="fiscalYearList"
                id="fiscal_year_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <!-- start date  -->
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Start date" vid="from_date" rules="required">
              <b-form-group slot-scope="{ valid, errors }" label-for="from_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_from') }}
                </template>
                <date-picker
                  id="from_date"
                  v-model="search.from_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- end date  -->
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="End date" vid="to_date" rules="required">
              <b-form-group slot-scope="{ valid, errors }" label-for="to_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_to') }}
                </template>
                <date-picker
                  id="to_date"
                  v-model="search.to_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- status list  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="status"
            >
              <template v-slot:label>
                {{ $t('globalTrans.status') }}
              </template>
            <b-form-select
                plain
                v-model="search.status"
                :options="statusList"
                id="year"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
           <!-- application number  -->
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="applicant_list"
            >
              <template v-slot:label>
                {{ $t('teaGardenService.application_id') }}
              </template>
              <b-form-input
                  id="app_id"
                  type="text"
                  v-model="search.app_id"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col sm="4">
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
        <h4 class="card-title"> {{ $t('teaGardenBtriService.pending_application') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link href="javascript:" to="test-service-form" class="btn-add"><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                  <template #head(select)="">
                    {{ $t('teaGardenBtriService.assign') }} <br>
                    <b-form-checkbox v-if="!isGardenAdminCheckGardenId()" v-model="check_all"  class="d-inline-block ml-1">
                    </b-form-checkbox>
                  </template>
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.application_date | dateFormat }}
                  </template>
                  <template v-slot:cell(total_samples)="data">
                    {{ $n(data.item.total_samples) }}
                  </template>
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ getName(data.item.fiscal_year_id, 'fiscal_year') }}
                  </template>
                  <template v-slot:cell(garden_id)="data">
                    {{ getName(data.item.garden_id, 'garden') }}
                  </template>
                  <template v-slot:cell(service_id)="data">
                    {{ $i18n.locale === 'bn' ? data.item.service.service_name_bn : data.item.service.service_name_en }}
                  </template>
                  <template v-slot:cell(status)="data">
                      <span :class="'badge badge-'+ getStatusInfo(data.item, 2)">{{ getStatusInfo(data.item) }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.view')" :to="{ name: 'tea_garden_service.btri.test_services_view', params: { id: data.item.id }}">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-edit-btn" :title="$t('globalTrans.edit')" :to="`test-service-form/${data.item.id}`" v-if="data.item.status === 1">
                      <i class="ri-pencil-fill"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-payment-btn" :to="`payment/${data.item.id}`" v-if="data.item.payment_status === 0 && data.item.test_category === 1 && data.item.service_id !== 12 && data.item.service_id !== 13 && data.item.service_id !== 14" :title="$t('teaGardenBtriService.payment_for')">
                      <i class="ri-secure-payment-line"></i>
                    </router-link>
                    <b-button v-b-modal.modal-6 class="moc-action-btn moc-payment-receipt-btn" :title="$t('externalLrcpn.payment_receipt')" @click="returnApplication(data.item)" v-if="(data.item.status >= 2) && (data.item.payment)">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <b-button class="moc-action-btn moc-assign-btn" :title="$t('teaGardenBtriService.assign')" @click="assign(data.item)" v-if="!isGardenAdminCheckGardenId() && data.item.status === 2">
                      <i class="ri-newspaper-line"></i>
                    </b-button>
                    <b-button v-b-modal.modal-4 class="moc-action-btn moc-return-btn" :title="$t('globalTrans.return')" @click="returnApplication(data.item)" v-if="!isGardenAdminCheckGardenId() && (data.item.status > 1 && data.item.status < 5)">
                      <i class="ri-reply-all-fill"></i>
                    </b-button>
                    <router-link class="moc-action-btn moc-resubmit-btn blinking" :title="$t('globalTrans.resubmit')" :to="`test-service-form/${data.item.id}`" v-if="isGardenAdminCheckGardenId() > 0 && data.item.status === 5">
                      <i class="ri-save-fill"></i>
                    </router-link>
                    <a class="moc-action-btn moc-download-btn" :title="$t('globalTrans.download')" :href="teaGardenServiceBaseUrl + 'download-storage-attachment?file=app/public' + data.item.report.attachment.replace('storage', '')" v-if="data.item.report" download>
                      <i class="ri-download-cloud-line"></i>
                    </a>
                  </template>
                  <template #cell(select)="data">
                    <b-form-checkbox v-if="!isGardenAdminCheckGardenId() && data.item.status === 2" v-model="assign_ids" :value="data.item.id" class="d-inline-block ml-1">
                    </b-form-checkbox>
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
               <div class="text-right">
                <b-button v-if="!isGardenAdminCheckGardenId() && hasPendingStatus" type="button" pill variant="primary" @click="multipleAssign">{{ $t('teaGardenBtriService.assign') }}</b-button>
               </div>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-4" size="lg" :title="$t('globalTrans.return')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Return :id="item.id" :item="item"/>
    </b-modal>
    <b-modal id="modal-6" size="lg" :title="$t('externalLrcpn.payment_receipt')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <template #modal-title class="flex-grow-1">
        {{ $t('externalLrcpn.payment_receipt') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <PaymentInfo :id="item.id" :item="item" ref="paymentInfo"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { applicationList, applicationAssign, multipleAssign } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import teaGardenService from '@/mixins/tea-garden-service'
import Return from './Return'
import PaymentInfo from './PaymentInfo'

export default {
  mixins: [ModalBaseMasterList, teaGardenService],
  components: { Return, PaymentInfo },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      errors: [],
      search: {
        year: 0,
        service_id: 0,
        fiscal_year_id: 0,
        status: 0,
        limit: 20
      },
      // labelData: [
      //   { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
      //   { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
      //   { labels: 'teaGardenService.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
      //   { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
      //   { labels: 'teaGardenConfig.garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
      //   { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
      //   { labels: 'teaGardenBtriService.no_of_sample', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
      //   { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '14%' } },
      //   { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } },
      //   { labels: 'globalTrans.select', class: 'text-left', show: '1', order: 9, thStyle: { width: '5%' } }
      // ],
      statusList: [],
      actions: {
        edit: true,
        toogle: true,
        delete: false
      },
      item: {
        id: 0
      },
      assign_ids: [],
      check_all: false,
      hasPendingStatus: false
    }
  },
  created () {
    this.loadData()
    this.getStatusList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    currentLocale: function () {
      this.getStatusList()
    },
    check_all: function (newValue) {
      const arr = []
      if (newValue) {
        this.listData.forEach(item => {
          if (item.status === 2) {
            arr.push(item.id)
          }
        })
      }
      this.assign_ids = arr
    }
  },
  computed: {
    currentLocale () {
        return this.$i18n.locale
    },
    labelData () {
      const labelData = [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'teaGardenService.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'teaGardenConfig.garden_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'teaGardenBtriService.no_of_sample', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '14%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } }
      ]
      if (!this.isGardenAdminCheckGardenId()) {
        labelData.push(
          { labels: 'globalTrans.select', class: 'text-left', show: '1', order: 9, thStyle: { width: '5%' } }
        )
      }
      return labelData
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
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'status' },
          { key: 'action' }
          // { key: 'select' }
        ]
        if (!this.isGardenAdminCheckGardenId()) {
          keys.push({ key: 'select' })
        }
      } else {
        keys = [
          { key: 'serial' },
          { key: 'app_id' },
          { key: 'application_date' },
          { key: 'fiscal_year_id' },
          { key: 'garden_id' },
          { key: 'service_id' },
          { key: 'total_samples' },
          { key: 'status' },
          { key: 'action' }
          // { key: 'select' }
        ]
        if (!this.isGardenAdminCheckGardenId()) {
          keys.push({ key: 'select' })
        }
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.tea_garden_school') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    serviceList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => JSON.parse(item.service_type).includes(2))
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  methods: {
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, teaGardenServiceBaseUrl, applicationAssign, item)
      }
    },
    assign (item) {
      window.vm.$swal({
        title: window.vm.$t('teaGardenBtriService.assign_confirm_msg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
          RestApi.deleteData(teaGardenServiceBaseUrl, `${applicationAssign}/${item.id}`).then(response => {
            if (response.success) {
              window.vm.$toast.success({
                title: window.vm.$t('globalTrans.success'),
                message: window.vm.$t('globalTrans.update_msg'),
                color: '#D6E09B'
              })
            } else {
              window.vm.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
              })
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
          })
        }
      })
    },
    returnApplication (item) {
      this.item = item
    },
    getStatusInfo (item, type = 1) {
      let statusText = this.$t('globalTrans.draft')
      let statusClass = 'warning'
      if (item.status === 2) {
        statusText = this.$t('globalTrans.pending')
        statusClass = 'light'
      } else if (item.status === 3) {
        statusText = this.$t('teaGardenBtriService.assigned')
        statusClass = 'secondary'
      } else if (item.status === 4) {
        statusText = this.$t('globalTrans.forward')
        statusClass = 'dark'
      } else if (item.status === 5) {
        statusText = this.$t('globalTrans.returned')
        statusClass = 'danger'
      } else if (item.status === 6) {
        statusText = this.$t('teaGardenBtriService.sample_verified')
        statusClass = 'primary'
      } else if (item.status === 7) {
        statusText = this.$t('teaGardenBtriService.report_prepared')
        statusClass = 'info'
      } else if (item.status === 8) {
        statusText = this.$t('globalTrans.published')
        statusClass = 'success'
      }
      return type === 2 ? statusClass : statusText
    },
    getStatusList () {
      this.statusList = [
        { value: 1, text: this.$t('globalTrans.draft') },
        { value: 2, text: this.$t('globalTrans.pending') },
        { value: 3, text: this.$t('teaGardenBtriService.assigned') },
        { value: 4, text: this.$t('globalTrans.forward') },
        { value: 5, text: this.$t('globalTrans.returned') },
        { value: 6, text: this.$t('teaGardenBtriService.sample_verified') },
        { value: 7, text: this.$t('teaGardenBtriService.report_prepared') },
        { value: 8, text: this.$t('globalTrans.published') }
      ]
    },
    getName (id, type) {
      let obj = {}
      if (type === 'fiscal_year') {
        obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === parseInt(id))
      } else if (type === 'garden') {
        obj = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === parseInt(id))
      }
      return this.$i18n.locale === 'bn' ? obj?.text_bn : obj?.text_en
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.hasPendingStatus = false
      this.check_all = false
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, applicationList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
            return Object.assign({}, item, { serial: index })
        })
        listData.forEach(item => {
          if (item.status === 2) {
            this.hasPendingStatus = true
          }
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async multipleAssign () {
      if (!this.assign_ids.length) {
        return this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: 'Please check at least one checkbox',
          color: '#ee5253'
        })
      }
      window.vm.$swal({
        title: window.vm.$t('teaGardenBtriService.assign_confirm_msg'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
          RestApi.putData(teaGardenServiceBaseUrl, multipleAssign, { assign_ids: this.assign_ids }).then(response => {
            if (response.success) {
              window.vm.$toast.success({
                title: window.vm.$t('globalTrans.success'),
                message: window.vm.$t('globalTrans.update_msg'),
                color: '#D6E09B'
              })
            } else {
              window.vm.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
              })
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
          })
        }
      })
    },
    pdfExport () {
      this.$refs.paymentInfo.pdfExport()
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
 .blinking {
    animation: 1s blink ease infinite;
  }
  @keyframes blink {
    from,
    to {
      opacity: 0;
    }
    50% {
      opacity: 1;
    }
  }
</style>
