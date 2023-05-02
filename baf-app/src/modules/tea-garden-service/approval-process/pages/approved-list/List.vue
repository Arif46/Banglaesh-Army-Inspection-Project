<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('globalTrans.approved') }} {{ $t('globalTrans.list') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="search.service_id"
                :options="masterServiceList"
                id="service_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
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
        <h4 class="card-title"> {{ $t('globalTrans.approved') }} {{ $t('globalTrans.list') }}</h4>
      </template>
       <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(issue_date)="data">
                    <slot v-if="data.item.issue_date">
                      {{ data.item.issue_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(applicant_name)="data">
                    {{ $i18n.locale === 'en' ? data.item.taggable.applicant_name_en : data.item.taggable.applicant_name_bn }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.status === 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 2">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 3">{{$t('component_settings.forward')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 4">{{$t('teaGardenPanel.recommendation')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status === 5">{{$t('globalTrans.recommended')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status === 6">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status === 7">{{$t('globalTrans.rejected')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="moc-action-btn moc-view-btn" :title="$t('globalTrans.details')" :to="`/tea-garden-service/approval-process/applicant-list/detail/${data.item.service_id}/${data.item.taggable_id}`">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-forward-btn" v-if="data.item.status === 6 && data.item.service_id === 1" :to="`/tea-garden-service/btb/tea-garden-application-certificate/${data.item.taggable_id}`" :title="$t('globalTrans.certificate')">
                      <i class="ri-file-paper-2-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-forward-btn" v-else-if="data.item.status === 6 && data.item.service_id === 2" :to="`/tea-garden-service/btb/tree-disposal-certificate/${data.item.taggable_id}`" :title="$t('globalTrans.certificate')">
                      <i class="ri-file-paper-2-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-forward-btn" v-else-if="data.item.status === 6 && data.item.service_id === 3" :to="`/tea-garden-service/btb/small-farmer-certificate/${data.item.taggable_id}`" :title="$t('globalTrans.certificate')">
                      <i class="ri-file-paper-2-line"></i>
                    </router-link>
                    <router-link class="moc-action-btn moc-forward-btn" v-else-if="data.item.status === 6 && data.item.service_id === 4" :to="`/tea-garden-service/btb/tea-factory-certificate/${data.item.taggable_id}`" :title="$t('globalTrans.certificate')">
                      <i class="ri-file-paper-2-line"></i>
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
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { approveOrRejectList, applicantToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
 components: {
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      search: {
        service_id: 0,
        employee_user_id: 0,
        status: 6,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'globalTrans.applicant_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'teaGardenService.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'teaGardenConfig.registration_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'teaGardenPanel.application_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
        delete: false
      },
      recommendedItemId: ''
    }
  },
  created () {
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    statusList () {
      return [
        { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
        { value: 4, text: this.$i18n.locale === 'en' ? 'Recommendation' : 'সুপারিশ', text_en: 'Recommendation', text_bn: 'সুপারিশ' },
        { value: 5, text: this.$i18n.locale === 'en' ? 'Recommended' : 'সুপারিশকৃত', text_en: 'Recommended', text_bn: 'সুপারিশকৃত' },
        { value: 6, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
        { value: 7, text: this.$i18n.locale === 'en' ? 'Rejected' : 'প্রত্যাখ্যাত', text_en: 'Rejected', text_bn: 'প্রত্যাখ্যাত' }
      ]
    },
    masterServiceList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => JSON.parse(item.service_type).includes(1))
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
          { key: 'service_bn' },
          { key: 'applicant_name' },
          { key: 'app_id' },
          { key: 'registration_no' },
          { key: 'issue_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'service_en' },
          { key: 'applicant_name' },
          { key: 'app_id' },
          { key: 'registration_no' },
          { key: 'issue_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('approvalProcess.applicant_list') + ' ' + this.$t('globalTrans.entry') : this.$t('approvalProcess.applicant_list') + ' ' + this.$t('globalTrans.modify')
    },
    applicantList () {
      return this.$store.state.TeaGardenService.commonObj.masterapplicantList.filter(item => item.status === 1)
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        employee_user_id: this.$store.state.Auth.authUser.user_id
      })
    }
    this.loadData()
  },
  methods: {
    remove (item) {
      this.changeStatus(5, teaGardenServiceBaseUrl, applicantToggle, item)
    },
    recommended (item) {
      this.recommendedItemId = item.id
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, teaGardenServiceBaseUrl, applicantToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, approveOrRejectList, params)
      if (result.success) {
      const listData = result.data.data.map((item, index) => {
        const serviceObj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(law => law.value === parseInt(item.service_id))
        const serviceData = {}
          if (typeof serviceObj !== 'undefined') {
            serviceData.service_en = serviceObj.text_en
            serviceData.service_bn = serviceObj.text_bn
          } else {
            serviceData.service_en = ''
            serviceData.service_bn = ''
          }
        return Object.assign({}, item, { serial: index + 0 }, serviceData)
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
