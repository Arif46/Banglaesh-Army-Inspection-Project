<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('notification.notification_setting') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="3">
            <b-form-group
              label-for="component_id"
            >
            <template v-slot:label>
              {{$t('menu.component')}}
            </template>
            <b-form-select
              plain
              v-model="search.component_id"
              :options="componentList"
              id="component_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="module_id"
            >
            <template v-slot:label>
              {{$t('menu.module')}}
            </template>
            <b-form-select
              plain
              v-model="search.module_id"
              :options="moduleList"
              id="module_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="service_id"
            >
            <template v-slot:label>
              {{$t('menu.service')}}
            </template>
            <b-form-select
              plain
              v-model="search.service_id"
              :options="serviceList"
              id="service_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="menu_id"
            >
            <template v-slot:label>
              {{$t('menu.menu')}}
            </template>
            <b-form-select
              plain
              v-model="search.menu_id"
              :options="menuList"
              id="menu_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="template_id"
            >
            <template v-slot:label>
              {{$t('notification.template')}}
            </template>
            <b-form-select
              plain
              v-model="search.template_id"
              :options="templateList"
              id="template_id"
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
        <h4 class="card-title">{{ $t('notification.notification_setting') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
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
import Form from './Form.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { notificationSetupList, notificationSetupToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import i18n from '@/i18n'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      search: {
        component_id: 0,
        module_id: 0,
        service_id: 0,
        menu_id: 0,
        template_id: 0,
        limit: 20
      },
      moduleList: [],
      serviceList: [],
      menuList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'menu.component', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'menu.module', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'menu.service', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'menu.menu', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'notification.template', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
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
    },
    'search.component_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.moduleList = this.getModuleList(newVal)
      }
    },
    'search.module_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.getServiceList()
      }
    },
    'search.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.menuList = this.getMenuList()
      }
    }
  },
  computed: {
    componentList () {
      return this.$store.state.CommonService.commonObj.componentList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    templateList: function () {
      return this.$store.state.CommonService.commonObj.notificationTemplateList
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
          { key: 'component_bn' },
          { key: 'module_bn' },
          { key: 'service_bn' },
          { key: 'menu_bn' },
          { key: 'template_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'component_en' },
          { key: 'module_en' },
          { key: 'service_en' },
          { key: 'menu_en' },
          { key: 'template_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('notification.notification_setting') + ' ' + this.$t('globalTrans.entry') : this.$t('notification.notification_setting') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    getModuleList (componentId) {
      return this.$store.state.CommonService.commonObj.moduleList.filter(item => item.component_id === componentId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getServiceList () {
      return this.$store.state.CommonService.commonObj.serviceList.filter(item => item.component_id === this.search.component_id && item.module_id === this.search.module_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getMenuList () {
      return this.$store.state.CommonService.commonObj.menuList.filter(item => item.component_id === this.search.component_id && item.module_id === this.search.module_id && item.service_id === this.search.service_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, notificationSetupToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, notificationSetupList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
         const componentObj = this.$store.state.CommonService.commonObj.componentList.find(compItem => compItem.value === item.component_id)
          const moduleObj = this.$store.state.CommonService.commonObj.moduleList.find(compItem => compItem.value === item.module_id)
          const serviceObj = this.$store.state.CommonService.commonObj.serviceList.find(serviceItem => serviceItem.value === item.service_id)
          const menuObj = this.$store.state.CommonService.commonObj.menuList.find(menuItem => menuItem.value === item.menu_id)
          const notificationTemObj = this.$store.state.CommonService.commonObj.notificationTemplateList.find(notTemItem => notTemItem.value === item.template_id)
          const componentData = {
            component_bn: componentObj !== undefined ? componentObj.text_bn : '',
            component_en: componentObj !== undefined ? componentObj.text_en : ''
          }
          const moduleData = {
            module_bn: moduleObj !== undefined ? moduleObj.text_bn : '',
            module_en: moduleObj !== undefined ? moduleObj.text_en : ''
          }
          const serviceData = {
            service_bn: serviceObj !== undefined ? serviceObj.text_bn : '',
            service_en: serviceObj !== undefined ? serviceObj.text_en : ''
          }
          const menuData = {
            menu_bn: menuObj !== undefined ? menuObj.text_bn : '',
            menu_en: menuObj !== undefined ? menuObj.text_en : ''
          }
          const notiTemplateData = {
            template_bn: notificationTemObj !== undefined ? notificationTemObj.text_bn : '',
            template_en: notificationTemObj !== undefined ? notificationTemObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index + 1 }, componentData, moduleData, serviceData, menuData, notiTemplateData)
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
