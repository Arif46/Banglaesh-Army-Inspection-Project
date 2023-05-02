<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('notification.circulate_notice') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="6">
            <b-form-group
              label-for="org_id"
            >
            <template v-slot:label>
              {{$t('orgProfile.org_name')}}
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
          <b-col sm="6">
            <b-form-group
              label-for="notification_type_id"
            >
            <template v-slot:label>
              {{$t('notification.notification_type')}}
            </template>
            <b-form-select
              plain
              v-model="search.notification_type_id"
              :options="notificationTypeList"
              id="notification_type_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="6">
            <b-form-group
              label-for="office_id"
            >
            <template v-slot:label>
              {{$t('organogram.office_name')}}
            </template>
            <b-form-select
              plain
              v-model="search.office_id"
              :options="officeList"
              id="office_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="6">
            <b-form-group
              label-for="designation_id"
            >
            <template v-slot:label>
              {{$t('organogram.designation')}}
            </template>
            <b-form-select
              plain
              v-model="search.designation_id"
              :options="assignDesignationList"
              id="designation_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button size="sm" class="mt-20" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('notification.circulate_notice') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
                              <template v-slot:cell(schedule)="data">
                        {{ data.item.notice_date | dateFormat }}
                        <span class="badge badge-light"> {{ dateFormat(data.item.notice_date + ' ' + data.item.notice_time, 'h:m A') }} </span>
                    </template>
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="xl" :title="$t('notification.circulate_notice') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { NotCirculateNoticeList, circulateNoticeToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import i18n from '@/i18n'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details
  },
  data () {
    return {
      search: {
        org_id: 0,
        notification_type_id: 0,
        office_id: 0,
        designation_id: 0,
        limit: 20
      },
      officeList: [],
      assignDesignationList: [],
      notificationTypes: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'orgProfile.org_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'notification.notification_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'notification.notice_titlel', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'notification.office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'notification.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'notification.schedule', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 10 }
      ],
      actions: {
        edit: true,
        details: true,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
   watch: {
    'search.org_id': function (newVal, oldVal) {
      this.officeList = this.getOfficeList(newVal)
    },
    'search.office_id': function (newVal, oldVal) {
      this.assignDesignationList = this.getdesignationList(newVal)
    }
  },
  computed: {
     orgProfileList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
     notificationTypeList () {
      return this.$store.state.CommonService.commonObj.notificationTypeList.filter(item => item.status === 1)
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
          { key: 'org_name_bn' },
          { key: 'not_type_name_bn' },
          { key: 'notice_title_bn' },
          { key: 'office_name_bn' },
          { key: 'designation_bn' },
          { key: 'schedule' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'not_type_name' },
          { key: 'notice_title' },
          { key: 'office_name' },
          { key: 'designation' },
          { key: 'schedule' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('notification.circulate_notice') + ' ' + this.$t('globalTrans.entry') : this.$t('notification.circulate_notice') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
     getOfficeList (officeId) {
    return this.$store.state.CommonService.commonObj.officeList.filter(office => office.org_id === officeId)
    },
    getdesignationList (officeId) {
      return this.$store.state.CommonService.commonObj.assignDesignationList.filter(desgn => desgn.office_id === officeId && desgn.office_id === this.search.office_id && desgn.org_id === this.search.org_id)
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, circulateNoticeToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, NotCirculateNoticeList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(compItem => compItem.value === item.org_id)
        const desigObj = this.$store.state.CommonService.commonObj.assignDesignationList.find(compItem => compItem.value === item.designation_id)
        const officeObj = this.$store.state.CommonService.commonObj.officeList.find(serviceItem => serviceItem.value === item.office_id)
        const notificationTemObj = this.$store.state.CommonService.commonObj.notificationTypeList.find(notTemItem => notTemItem.value === item.notification_type_id)
        const orgData = {
          org_name_bn: orgObj !== undefined ? orgObj.text_bn : '',
          org_name: orgObj !== undefined ? orgObj.text_en : ''
          }
          const designationData = {
            designation_bn: desigObj !== undefined ? desigObj.text_bn : '',
            designation: desigObj !== undefined ? desigObj.text_en : ''
          }
          const officeData = {
            office_name_bn: officeObj !== undefined ? officeObj.text_bn : '',
            office_name: officeObj !== undefined ? officeObj.text_en : ''
          }
          const notiTemplateData = {
            not_type_name_bn: notificationTemObj !== undefined ? notificationTemObj.text_bn : '',
            not_type_name: notificationTemObj !== undefined ? notificationTemObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index + 1 }, orgData, designationData, officeData, notiTemplateData)
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
