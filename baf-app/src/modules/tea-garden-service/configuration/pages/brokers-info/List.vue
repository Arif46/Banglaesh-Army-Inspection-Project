<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenConfig.brokers') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
         <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
              label-for="zone_id"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.zone') }}
              </template>
            <b-form-select
                plain
                v-model="search.zone_id"
                :options="getZoneList"
                id="zone_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="broker_name"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.broker_name') }}
              </template>
              <b-form-input
                  id="broker_name"
                  type="text"
                  v-model="search.broker_name"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="type_name"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.owner_name') }}
              </template>
              <b-form-input
                  id="owner_name"
                  type="text"
                  v-model="search.owner_name"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="registration_no"
            >
              <template v-slot:label>
                {{ $t('teaGardenConfig.broker') }}  {{ $t('teaGardenConfig.registration_no') }}
              </template>
              <b-form-input
                  id="registration_no"
                  type="text"
                  v-model="search.registration_no"
              ></b-form-input>
            </b-form-group>
          </b-col>
            <b-col sm="4" class="mt-4">
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
        <h4 class="card-title">{{ $t('teaGardenConfig.brokers') }} {{ $t('globalTrans.list') }}</h4>
      </template>
        <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                   <template v-slot:cell(contact_no)="data">
                    {{ data.item.contact_no | mobileNumber }}
                  </template>
                  <template v-slot:cell(zone_id)="data">
                    {{ getZonedfList(data.item.zone_id) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 2">{{$t('globalTrans.inactive')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button class="moc-action-btn moc-view-btn" v-b-modal.modal-form-details @click="details(data.item)" :title="$t('globalTrans.view')">
                      <i class="ri-eye-line"></i>
                    </b-button>
                    <b-button class="moc-action-btn moc-edit-btn" v-b-modal.modal-form @click="edit(data.item)" :title="$t('globalTrans.edit')">
                      <i class="ri-pencil-fill"></i>
                    </b-button>
                    <b-button class="moc-action-btn" :variant="data.item.status === 2 ? ' moc-secondary-btn' : ' moc-assign-btn'" @click="remove(data.item)" title="Active" v-b-modal.details>
                      <i :class="data.item.status === 2 ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
      <!-- table section end-->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form-details" size="xl" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details  :item="item" :key="editItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
  import Form from './Form.vue'
  import Details from './Details'
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { brokersInfoListApi, brokersInfoToggleApi } from '../../api/routes'
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
        sortDesc: true,
        sortDirection: 'desc',
        search: {
          broker_name: '',
          owner_name: '',
          registration_no: '',
          zone_id: 0,
          limit: 10
        },
        item: '',
        editItemId: 0,
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
          { labels: 'teaGardenConfig.zone', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: 'auto' } },
          { labels: 'teaGardenConfig.registration_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
          { labels: 'teaGardenConfig.broker_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
          { labels: 'teaGardenConfig.owner_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
          { labels: 'teaGardenConfig.contact_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '9%' } },
          { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '12%' } }
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
      'search.limit': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.loadData()
        }
      }
    },
    computed: {
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
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
            { key: 'zone_id' },
            { key: 'registration_no' },
            { key: 'broker_name_bn' },
            { key: 'owner_name_bn' },
            { key: 'contact_no' },
            { key: 'status' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'zone_id' },
            { key: 'registration_no' },
            { key: 'broker_name_en' },
            { key: 'owner_name_en' },
            { key: 'contact_no' },
            { key: 'status' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      formTitle () {
        return (this.editItemId === 0) ? this.$t('teaGardenConfig.broker') + ' ' + this.$t('globalTrans.entry') : this.$t('teaGardenConfig.broker') + ' ' + this.$t('globalTrans.modify')
      },
      detailsTitle () {
          return this.$t('teaGardenConfig.brokers') + ' ' + this.$t('globalTrans.details')
        },
        currentLocale () {
            return this.$i18n.locale
        },
      getZoneList: function () {
        const objectData = this.$store.state.TeaGardenService.commonObj.zoneList
        return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
        })
      },
      portalServiceNameList: function () {
        return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => item.status === 1)
      }
    },
    methods: {
      searchData () {
        this.loadData()
      },
      edit (item) {
          this.editItemId = item.id
      },
      // async loadData () {
      //   const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      //   this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      //   const result = await RestApi.getData(teaGardenServiceBaseUrl, brokersInfoListApi, params)
      //   if (result.success) {
      //     const listData = result.data.data.map((item, index) => {
      //       const serviceObj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(law => law.value === parseInt(item.service_id))
      //       const serviceData = {}
      //         if (typeof serviceObj !== 'undefined') {
      //           serviceData.service_en = serviceObj.text_en
      //           serviceData.service_bn = serviceObj.text_bn
      //         } else {
      //           serviceData.service_en = ''
      //           serviceData.service_bn = ''
      //         }
      //       return Object.assign({}, item, { serial: index + 0 }, serviceData)
      //     })
      //     this.$store.dispatch('setList', listData)
      //     this.paginationData(result.data, this.search.limit)
      //   } else {
      //     this.$store.dispatch('setList', [])
      //     this.paginationData([])
      //   }
      //   this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      // },
      getZonedfList (typeId) {
        const Type = this.$store.state.TeaGardenService.commonObj.zoneList.find(type => type.value === typeId)
        if (this.$i18n.locale === 'bn') {
            return Type.text_bn
        } else {
            return Type.text_en
        }
        },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, brokersInfoListApi, params)
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
      remove (item) {
        this.changeStatus(3, teaGardenServiceBaseUrl, brokersInfoToggleApi, item)
      },
      details (item) {
          this.item = item
          this.editItemId = item.id
      }
    }
  }
  </script>
<style>
  .btn-success {
    background-color: var(--success) !important;
    border-color: var(--success);
  }
  </style>
