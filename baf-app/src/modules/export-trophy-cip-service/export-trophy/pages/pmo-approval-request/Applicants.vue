<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophy.pmo_approval_request') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
          <b-row>
          <b-col sm="4">
              <b-form-group
                  label-for="type"
              >
              <template v-slot:label>
                  {{$t('globalTrans.type')}}
              </template>
              <b-form-select
                  plain
                  v-model="search.sector_type"
                  :options="productServiceTypeList"
                  id="type"
              >
                  <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                  label-for="product_service_sector_id"
              >
              <template v-slot:label>
                  {{$t('exportTrophy.product_service_sector')}}
              </template>
              <b-form-select
                  plain
                  v-model="search.product_service_sector_id"
                  :options="productServiceSectorList"
                  id="product_service_sector_id"
              >
                  <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-button class="mt-20" size="sm" variant="primary" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
              </b-button>
          </b-col>
          </b-row>
      </template>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('exportTrophy.pmo_approval_request') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(application_id)="data">
                  {{ $n(data.item.application_id, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(orgAddress)="data">
                  <span>
                    {{ data.item.org_info ? (currentLocale === 'bn' ? data.item.org_info.org_name_bn : data.item.org_info.org_name_en) : '' }} <br/>
                    {{ data.item.org_address ? AddressHelper.getCommonAddress(data.item.org_address) :  ' ' }}
                  </span>
                </template>
                <template v-slot:cell(tin_no)="data">
                  <span v-if="data.item.org_tax_info">
                  {{ data.item.org_tax_info ? $n(data.item.org_tax_info.tin_no, { useGrouping: false }) : '' }}
                  </span>
                </template>
                 <template v-slot:cell(org_tax_info)="data">
                  {{ data.item.org_tax_info ? $n(data.item.org_tax_info.tin_no, { useGrouping: false }) : '' }}
                </template>
                <template v-slot:cell(org_info)="data">
                  {{ data.item.org_info ? $n(data.item.org_info.bin_no, { useGrouping: false }) : '' }}
                </template>
                <template v-slot:cell(position)="data">
                  <span v-if="data.item.evaluation">
                  {{ $n(data.item.evaluation.position, { useGrouping: false }) }}
                  </span>
                </template>
                <template v-slot:cell(trophy)="data">
                  <span v-if="data.item.evaluation">
                    <span>{{ getTrophy(data.item.evaluation.trophy) }}</span>
                  </span>
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="singleData(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                  <b-button v-b-modal.modal-comments variant=" action-btn status mr-1" size="sm" @click="singleData(data.item)" class="action-btn status" :title="$t('globalTrans.comments')"><i class="ri-chat-2-line"></i></b-button>
                </template>
              </b-table>
              <div class="pagination-wrapper mt-3">
                <b-pagination
                  v-model="pagination.currentPage"
                  :per-page="pagination.perPage"
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
    <b-modal id="modal-comments" size="lg" :title="$t('globalTrans.comments')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FowardComments :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-details" size="xl" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from '../Details.vue'
import FowardComments from './FowardComments.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { pmoApprovalReqApplicantstApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import AddressHelper from '@/utils/area-type-address'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, FowardComments
  },
  data () {
    return {
      AddressHelper: AddressHelper,
      editItemId: 0,
      item: {
        status: 0,
        note_title: ''
      },
      search: {
        sector_type: 0,
        product_service_sector_id: 0,
        receiver_id: this.$store.state.Auth.authUser.user_id,
        limit: 20
      },
      productServiceSectorList: []
    }
  },
  created () {
    if (this.$route.query.id) {
      this.loadData()
    }
  },
   watch: {
    'search.sector_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.productServiceSectorList = this.getProductServiceSectorList(newVal)
      }
    }
  },
  computed: {
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('globalTrans.application_id'), class: 'text-center' },
          { label: this.$t('exportTrophy.org_name_address'), class: 'text-left' },
          { label: this.$t('exportTrophy.owner_or_md_name'), class: 'text-left' },
          { label: this.$t('externalUser.tin_no'), class: 'text-center' },
          { label: this.$t('globalTrans.vat') + '/ ' + this.$t('externalUser.bin_no'), class: 'text-center' },
          { label: this.$t('exportTrophy.position'), class: 'text-center' },
          { label: this.$t('exportTrophy.trophy_type'), class: 'text-center' },
          { label: this.$t('globalTrans.action'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'orgAddress' },
          { key: 'owner_info.owner_name_bn' },
          { key: 'tin_no' },
          { key: 'org_tax_info' },
          { key: 'position' },
          { key: 'trophy' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'orgAddress' },
          { key: 'owner_info.owner_name_en' },
          { key: 'org_tax_info' },
          { key: 'org_info' },
          { key: 'position' },
          { key: 'trophy' },
          { key: 'action' }
        ]
      }

      return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
    },
    detailsTitle () {
      return this.$t('externalUser.export_data_application_form') + ' ' + this.$t('globalTrans.details')
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    singleData (item) {
      this.editItemId = item.id
    },
    approveReject (item, status) {
      this.editItemId = item.id
      this.item = {
        status: status,
        note_title: status === 3 ? this.$t('globalTrans.reject') : this.$t('globalTrans.approve')
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { product_service_sector_id: this.$route.query.id })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, pmoApprovalReqApplicantstApi, params)
      if (result.success) {
        this.$store.dispatch('setList', result.data.data)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getProductServiceSectorList (sectorType) {
        return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(exp => exp.type === sectorType && exp.assign_for === 2)
    },
    getTrophy (trophy) {
      if (trophy === 1) {
        return this.$t('exportTrophyConfig.gold')
      } else if (trophy === 2) {
        return this.$t('exportTrophyConfig.silver')
      } else if (trophy === 3) {
        return this.$t('exportTrophyConfig.bronze')
      } else {
        return ''
      }
    }
  }
}
</script>
