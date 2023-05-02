<template>
  <div class="inner-section">
    <card>
      <b-row>
        <b-col sm="8">
          <div class="py-2 px-2">
            <span><strong>{{ $t('externalUser.export_product_sector') }}</strong> : {{ productName($route.query.id) }}</span>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="py-2 px-2">
              <span><i class="ri-check-line"></i> {{ $t('exportTrophy.total_number_of_application') + ': ' + $n(totalApplication, { useGrouping: false }) }}</span>
          </div>
        </b-col>
      </b-row>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('exportTrophy.profile_scrutiny_evaluation') }}</h4>
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
                  <b-button v-if="data.item.status === 8" v-b-modal.modal-approve-reject variant=" action-btn status mr-1" size="sm" @click="approveReject(data.item, 9)" class="action-btn active" :title="$t('cip.primary_scrutiny')"><i class="ri-check-line"></i></b-button>
                  <b-button v-b-modal.modal-approve-reject variant=" action-btn delete mr-1" size="sm" @click="approveReject(data.item, 3)" class="action-btn edit" :title="$t('globalTrans.reject')"><i class="ri-close-fill"></i></b-button>
                  <b-button v-b-modal.modal-form size="sm" variant="action-btn edit mr-1" @click="singleData(data.item)" class="action-btn edit" :title="$t('exportTrophy.evaluation_details')"><i class="ri-open-source-line"></i></b-button>
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
    <b-modal id="modal-approve-reject" size="md" :title="item.note_title" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApproveReject :id="editItemId" :item="item" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-details" size="xl" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Evaluation :id="editItemId" :sector_name="productName($route.query.id)" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import ApproveReject from '../ApproveReject.vue'
import Details from '../Details.vue'
import Evaluation from './EvaluationModal.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { mocScrutinyApplicantsApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import AddressHelper from '@/utils/area-type-address'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Evaluation, ApproveReject
  },
  data () {
    return {
      AddressHelper: AddressHelper,
      totalApplication: 0,
      editItemId: 0,
      item: {
        status: 0,
        note_title: ''
      },
      search: {
        limit: 20
      }
    }
  },
  created () {
    if (this.$route.query.id) {
      this.loadData()
    }
  },
  computed: {
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
          { key: 'org_tax_info' },
          { key: 'org_info' },
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
    formTitle () {
      return this.$t('exportTrophy.evaluation') + ' ' + this.$t('globalTrans.details')
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
        note_title: status === 3 ? this.$t('globalTrans.reject') : this.$t('cip.primary_scrutiny')
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { product_service_sector_id: this.$route.query.id })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, mocScrutinyApplicantsApi, params)
      if (result.success) {
        this.$store.dispatch('setList', result.data.data)
        this.paginationData(result.data, this.search.limit)
        this.totalApplication = result.total_application
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
        this.totalApplication = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    productName (Id) {
      const Obj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(item => item.value === parseInt(Id))
      if (typeof Obj !== 'undefined') {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ''
      }
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
