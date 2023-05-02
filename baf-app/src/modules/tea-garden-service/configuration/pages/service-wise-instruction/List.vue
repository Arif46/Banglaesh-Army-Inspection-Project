<template>
    <div class="inner-section">
      <card>
        <!-- search section start -->
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">{{ $t('teaGardenConfig.instruction_nm') }}</h4>
        </template>
        <template v-slot:searchBody>
          <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
              label-for="service_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.service_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.service_id"
                :options="portalServiceNameList"
                id="service_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
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
          <h4 class="card-title"> {{ $t('teaGardenConfig.instruction_list') }} {{ $t('globalTrans.list') }}</h4>
        </template>
        <template v-slot:headerAction>
          <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
        </template>
        <template v-slot:body>
          <b-overlay :show="loadingState">
            <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :componentId="3" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="teaGardenServiceBaseUrl" />
          </b-overlay>
        </template>
        <!-- table section end -->
      </body-card>
      <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Form :id="editItemId" :key="editItemId"/>
      </b-modal>
      <b-modal id="details" size="lg" :title="$t('teaGardenConfig.instruction_nm') + ' ' + $t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <Details :id="detailItemId" :key="detailItemId"/>
      </b-modal>
    </div>
  </template>
  <script>
  import Form from './Form.vue'
  import Details from './Details'
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { serviceWiseInstructionList, serviceWiseInstructionToggleApi } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  export default {
    mixins: [ModalBaseMasterList],
    components: {
      Form, Details
    },
    data () {
      return {
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        sortBy: '',
        search: {
            service_id: 0,
          limit: 20
        },
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
          { labels: 'teaGardenConfig.service_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '9%' } },
          { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 4, thStyle: { width: '13%' } }
        ],
        actions: {
          edit: true,
          toogle: true,
          details: true,
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
      }
    },
    computed: {
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
            { key: 'status' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'service_en' },
            { key: 'status' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      formTitle () {
        return (this.editItemId === 0) ? this.$t('teaGardenConfig.instruction_nm') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.instruction_list') + ' ' + this.$t('globalTrans.modify')
      },
      currentLocale () {
          return this.$i18n.locale
      },
      portalServiceNameList: function () {
        return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
      }
    },
    methods: {
      editMethodInParent (item, type) {
        if (type === 1) {
          this.edit(item)
        } else if (type === 2) {
          this.changeStatus(3, teaGardenServiceBaseUrl, serviceWiseInstructionToggleApi, item)
        } else if (type === 3) {
        this.details(item)
      }
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, serviceWiseInstructionList, params)
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
          return Object.assign({}, item, { serial: index }, serviceData)
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
