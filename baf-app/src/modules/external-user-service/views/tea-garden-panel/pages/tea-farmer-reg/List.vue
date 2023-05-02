<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenPanel.tea_farmer_registration') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <!-- fee type  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Application Type" vid="application_type">
              <b-form-group
                label-for="application_type"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.application_type')}}
              </template>
              <b-form-select
                plain
                v-model="search.application_type"
                :options="feeTypes"
                id="application_type"
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
        <h4 class="card-title">{{ $t('teaGardenPanel.tea_farmer_registration') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link to="tea-farmer-application-form" class="btn-add"  v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                            :id="'checkbox-' + field.label_en"
                            v-model="field.show"
                            :name="'checkbox-' + field.label_en"
                            value=1
                            unchecked-value=0
                          >
                            {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
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
                  <template v-slot:cell(total_land_quantity)="data">
                    {{ $n(data.item.total_land_quantity) }}
                  </template>
                  <template v-slot:cell(owner_mobile)="data">
                     <span v-if="data.item.owner_info && data.item.owner_info.owner_mobile">{{ EngBangNum(data.item.owner_info.owner_mobile) }}</span>
                  </template>
                  <template v-slot:cell(application_date)="data">
                    {{ data.item.created_at | dateFormat }}
                  </template>
                  <template v-slot:cell(application_type)="data">
                    <span v-if="data.item.application && data.item.application.application_type">{{ getFeeTypeName(data.item.application.application_type) }}</span>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-warning" v-if="data.item.application.status === 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.application.status === 2">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.application.status === 3">{{$t('component_settings.forward')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.application.status === 4">{{$t('teaGardenPanel.recommendation')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.application.status === 5">{{$t('globalTrans.recommended')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.application.status === 6">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.application.status === 7">{{$t('globalTrans.rejected')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <!-- payment  -->
                    <router-link class="moc-action-btn moc-payment-btn" :to="`payment/${data.item.application.id}?from=tea_garden_panel.tea_farmer_application`" v-if="data.item.application.status === 1 && data.item.application.payment_status == 0 && data.item.application.service.has_payment" :title="$t('teaGardenBtriService.payment_for')">
                      <i class="ri-secure-payment-line"></i>
                    </router-link>
                    <!-- payment receipt  -->
                    <b-button v-b-modal.modal-6 class="moc-action-btn moc-payment-receipt-btn" :title="$t('externalLrcpn.payment_receipt')" @click="paymentInfoShow(data.item.application)" v-if="data.item.application.service.has_payment && data.item.application.status >= 2 && (data.item.application.payment)">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <router-link :to="`tea-farmer-application-renew-form/${data.item.id}`" v-if="data.item.application.warning_date && data.item.application.warning_date <= today" variant="iq-bg-success mr-1" size="sm" class="action-btn delete blinking" :title="$t('globalTrans.renew')"><i class="ri-edit-circle-fill"></i></router-link>
                    <router-link :to="`tea-farmer-application-view/${data.item.id}`" variant="iq-bg-success mr-1" size="sm" class="action-btn status" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></router-link>
                    <router-link v-if="data.item.application && data.item.application.status === 6" :to="`small-farmer-certificate/${data.item.id}`" variant="iq-bg-success mr-1" size="sm" class="action-btn btn-warning" :title="$t('globalTrans.certificate')"><i class="ri-file-line"></i></router-link>
                    <b-button v-if="data.item.application && data.item.application.status === 1 && data.item.application.parent_id" variant="iq-bg-success mr-1" @click="renewData(data.item)" size="sm" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="data.item.application && data.item.application.status === 1 && data.item.application.parent_id === null" variant="iq-bg-success" size="sm" @click="editData(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
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
    <!-- payment receipt modal  -->
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
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>

import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { teaFarmerApplicationListApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/route-based-list'
import i18n from '@/i18n'
import PaymentInfo from '../../../../../tea-garden-service/btb/pages/Payment/PaymentInfo.vue'
const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.teaGardenPanel.garden_name, label_bn: i18n.messages.bn.teaGardenPanel.garden_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
  { label_en: i18n.messages.en.teaGardenPanel.owner_mobile, label_bn: i18n.messages.bn.teaGardenPanel.owner_mobile, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
  { label_en: i18n.messages.en.teaGardenPanel.total_land_quantity, label_bn: i18n.messages.bn.teaGardenPanel.total_land_quantity, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
  { label_en: i18n.messages.en.teaGardenPanel.application_date, label_bn: i18n.messages.bn.teaGardenPanel.application_date, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.teaGardenPanel.application_type, label_bn: i18n.messages.bn.teaGardenPanel.application_type, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: { PaymentInfo },
  data () {
    return {
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      search: {
        application_type: 0,
        user_id: this.$store.state.Auth.authUser.user_id,
        limit: 20
      },
      labelData: [],
      editItemId: 0,
      today: new Date().toISOString().split('T')[0],
      item: {
        id: 0
      }
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
      } else {
        this.unionList = []
        this.pauroshobaList = []
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'garden_name_bn' },
          { key: 'owner_mobile' },
          { key: 'total_land_quantity' },
          { key: 'application_date' },
          { key: 'application_type' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'garden_name_en' },
          { key: 'owner_mobile' },
          { key: 'total_land_quantity' },
          { key: 'application_date' },
          { key: 'application_type' },
          { key: 'status' },
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
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    feeTypes () {
      return this.$store.state.ExternalUserService.teaGarden.commonObj.feeTypesList.filter(item => item.status === 1)
    }
  },
  methods: {
    paymentInfoShow (item) {
      this.item = item
    },
    pdfExport () {
      this.$refs.paymentInfo.pdfExport()
    },
    editData (item) {
      this.$router.push(`/tea-garden-panel/tea-farmer-application-form?id=${item.id}`)
    },
    renewData (item) {
      this.$router.push(`/tea-garden-panel/tea-farmer-application-renew-form/${item.application.parent_id}?id=${item.id}`)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, teaFarmerApplicationListApi, params)
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
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    details (item) {
      this.editItemId = item.id
    },
    getFeeTypeName (id) {
      const feeType = this.$store.state.ExternalUserService.teaGarden.commonObj.feeTypesList.find(item => item.value === id)
          if (feeType && this.$i18n.locale === 'bn') {
              return feeType.text_bn
          } else if (feeType && this.$i18n.locale === 'en') {
              return feeType.text_en
          }
    }
  }
}
</script>
<style>
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
