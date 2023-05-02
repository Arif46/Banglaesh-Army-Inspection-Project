<template>
  <div class="inner-section">
    <card>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('exportTrophy.primary_sorting') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(application_id) = "data">
                  {{ $n(data.item.application_id, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(export_value) = "data">
                  {{ $n(data.item.export_value, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(mobile) = "data">
                  {{ data.item.mobile | mobileNumber }}
                </template>
                <template v-slot:cell(name_address)="data">
                  {{ currentLocale === 'bn' ? data.item.name_bn : data.item.name_en }} <br/>
                  {{ data.item.address ? AddressHelper.getPresentAddress(data.item.address) : '' }}
                </template>
                <template v-slot:cell(org_address)="data">
                  {{ data.item.org_info ? (currentLocale === 'bn' ? data.item.org_info.org_name_bn : data.item.org_info.org_name_en) : '' }} <br/>
                  {{ data.item.org_address ? AddressHelper.getCommonAddress(data.item.org_address) : '' }}
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="singleData(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                  <slot v-if="data.item.status === 2">
                    <b-button v-b-modal.modal-approve-reject variant=" action-btn status mr-1" size="sm" @click="approveReject(data.item, 4)" class="action-btn active" :title="$t('cip.primary_select')"><i class="ri-check-line"></i></b-button>
                    <b-button v-b-modal.modal-approve-reject variant=" action-btn delete mr-1" size="sm" @click="approveReject(data.item, 3)" class="action-btn edit" :title="$t('globalTrans.reject')"><i class="ri-close-fill"></i></b-button>
                  </slot>
                </template>
              </b-table>
              <b-pagination
                class="mt-20"
                v-model="pagination.currentPage"
                :per-page="pagination.perPage"
                :total-rows="pagination.totalRows"
                @input="searchData"
              />
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-approve-reject" size="md" :title="noteTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApproveReject :id="editItemId" :status="status" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import ApproveReject from '../ApproveReject.vue'
import Details from '../Detials.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { primarySortingApplicantsApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import AddressHelper from '@/utils/area-type-address'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ApproveReject,
    Details
  },
  data () {
    return {
      AddressHelper: AddressHelper,
      labelData: [],
      productServiceSectorList: [],
      status: 0,
      noteTitle: '',
      search: {
        limit: 20
      }
    }
  },
  created () {
    this.loadData()
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
          { label: this.$t('exportTrophy.applicant_name_address'), class: 'text-center' },
          { label: this.$t('exportTrophy.org_name_address'), class: 'text-center' },
          { label: this.$t('globalTrans.mobile'), class: 'text-center' },
          { label: this.$t('globalTrans.email'), class: 'text-center' },
          { label: this.$t('exportTrophy.export_income_proposed_income'), class: 'text-center' },
          { label: this.$t('globalTrans.action'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'name_address' },
          { key: 'org_address' },
          { key: 'mobile' },
          { key: 'email' },
          { key: 'export_value' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'name_address' },
          { key: 'org_address' },
          { key: 'mobile' },
          { key: 'email' },
          { key: 'export_value' },
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
      this.status = status
      this.noteTitle = status === 3 ? this.$t('globalTrans.reject') : this.$t('cip.primary_select')
    },
    async loadData () {
      const params = Object.assign({}, this.search, { product_service_sector_id: this.$route.query.id })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, primarySortingApplicantsApi, params)
      if (result.success) {
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      return data.map((item, index) => {
        const orgData = {
          serial: index,
          org_name_en: item.org_info !== null ? item.org_info.org_name_en : '',
          org_name_bn: item.org_info !== null ? item.org_info.org_name_bn : ''
        }

        return Object.assign({}, item, orgData)
      })
    }
  }
}
</script>
