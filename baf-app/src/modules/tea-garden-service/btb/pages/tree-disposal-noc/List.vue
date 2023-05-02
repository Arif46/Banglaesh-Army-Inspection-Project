<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenService.tree_disposal_service') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <!-- application id  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Application ID" vid="application_id">
              <b-form-group
                label-for="application_id"
              >
              <template v-slot:label>
                {{$t('teaGardenService.application_id')}}
              </template>
              <b-form-input
                  id="registration_no"
                  v-model="search.application_id"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!--garden area wise search  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Area Type" vid="area_type_id">
              <b-form-group
                label-for="area_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.area_type')}}
              </template>
              <b-form-select
                plain
                v-model="search.area_type_id"
                :options="areaTypeList"
                id="area_type_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="Division" vid="division_id">
              <b-form-group
                label-for="division_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.division')}}
              </template>
              <b-form-select
                plain
                v-model="search.division_id"
                :options="divisionList"
                id="division_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="District" vid="district_id">
              <b-form-group
                label-for="district_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.district')}}
              </template>
              <b-form-select
                plain
                v-model="search.district_id"
                :options="districtList"
                id="district_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1">
            <ValidationProvider name="City Corporation" vid="city_corporation_id">
              <b-form-group
                label-for="city_corporation_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.city_corporation')}}
              </template>
              <b-form-select
                plain
                v-model="search.city_corporation_id"
                :options="corporationList"
                id="city_corporation_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2 || search.area_type_id === 3">
            <ValidationProvider name="Upazila" vid="upazila_id">
              <b-form-group
                label-for="upazila_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.upazila')}}
              </template>
              <b-form-select
                plain
                v-model="search.upazila_id"
                :options="upazilaList"
                id="upazila_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2">
            <ValidationProvider name="Pauroshoba" vid="pauroshoba_id">
              <b-form-group
                label-for="pauroshoba_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.pouroshova')}}
              </template>
              <b-form-select
                plain
                v-model="search.pauroshoba_id"
                :options="pauroshobaList"
                id="pauroshoba_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 3">
            <ValidationProvider name="Union" vid="union_id">
              <b-form-group
                label-for="union_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.union')}}
              </template>
              <b-form-select
                plain
                v-model="search.union_id"
                :options="unionList"
                id="union_id"
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
          <!-- garden list  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Garden Name" vid="garden_idgarden_id">
              <b-form-group
                label-for="garden_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.garden_name')}}
              </template>
              <b-form-select
                plain
                v-model="search.garden_id"
                :options="teaGardenNameList"
                id="tea_garden_gen_info_id"
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
            <ValidationProvider name="Status" vid="status">
              <b-form-group
                label-for="status"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.status')}}
              </template>
              <b-form-select
                plain
                v-model="search.status"
                :options="statusList"
                id="status"
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
          <!-- registration no  -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Registration No" vid="registration_no">
              <b-form-group
                label-for="registration_no"
              >
              <template v-slot:label>
                {{$t('teaGardenConfig.registration_no')}}
              </template>
              <b-form-input
                  id="registration_no"
                  v-model="search.registration_no"
                ></b-form-input>
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
        <h4 class="card-title">{{ $t('teaGardenService.tree_disposal_service') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link to="tree-disposal-registration-form" class="btn-add"  v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(garden_name)="data">
                    <span v-if="data.item.garden_info && data.item.garden_info.tea_garden_name_en && $i18n.locale === 'en'">{{ data.item.garden_info.tea_garden_name_en }}</span>
                    <span v-if="data.item.garden_info && data.item.garden_info.tea_garden_name_bn && $i18n.locale === 'bn'">{{ data.item.garden_info.tea_garden_name_bn }}</span>
                  </template>
                  <template v-slot:cell(app_id)="data">
                    <span v-if="data.item.application && data.item.application.app_id">{{EngBangNum(data.item.application.app_id ) }}</span>
                  </template>
                  <template v-slot:cell(garden_address)="data">
                    <span v-if="data.item.garden_info">
                      <span v-if="$i18n.locale === 'bn'">{{ data.item.garden_info.garden_address_bn }}</span>
                      <span v-else>{{ data.item.garden_info.garden_address_en }}</span>
                    </span>
                  </template>
                  <template v-slot:cell(garden_registration_no)="data">
                      <span v-if="data.item.garden_info && data.item.garden_info.registration_no_en">{{ data.item.garden_info.registration_no_en }}</span>
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
                    <!-- payment routes -->
                   <router-link class="moc-action-btn moc-payment-btn" :to="`payment/${data.item.application.id}?from=tea_garden_service.btb.tree_disposal_registration`" v-if="data.item.application.status === 1 && data.item.application.payment_status == 0 && data.item.application.service.has_payment" :title="$t('teaGardenBtriService.payment_for')">
                      <i class="ri-secure-payment-line"></i>
                    </router-link>
                    <!-- payment receipt  -->
                    <b-button v-b-modal.modal-6 class="moc-action-btn moc-payment-receipt-btn" :title="$t('externalLrcpn.payment_receipt')" @click="paymentInfoShow(data.item.application)" v-if="data.item.application.service.has_payment && data.item.application.status >= 2 && (data.item.application.payment)">
                      <i class="ri-file-shield-2-line"></i>
                    </b-button>
                    <router-link class="moc-action-btn moc-view-btn" :to="`tree-disposal-registration-view/${data.item.id}`" :title="$t('globalTrans.view')">
                      <i class="ri-eye-line"></i>
                    </router-link>
                    <b-button class="moc-action-btn moc-edit-btn" v-if="data.item.application && data.item.application.status === 1" @click="editData(data.item)" :title="$t('globalTrans.edit')">
                      <i class="ri-pencil-fill"></i>
                    </b-button>
                    <router-link class="moc-action-btn moc-forward-btn" v-if="data.item.application && data.item.application.status === 6" :to="`tree-disposal-certificate/${data.item.id}`" :title="$t('globalTrans.certificate')">
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
    <b-modal id="modal-detail" size="xl" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
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
import Details from '../../ApplicationDetails/TreeDisposalNoc/Details.vue'
import { treeDisposalAppListApi, getTeaGardenNameList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import PaymentInfo from '../Payment/PaymentInfo.vue'
const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.teaGardenService.application_id, label_bn: i18n.messages.bn.teaGardenService.application_id, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
  { label_en: i18n.messages.en.globalTrans.applicant_name, label_bn: i18n.messages.bn.globalTrans.applicant_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
  { label_en: i18n.messages.en.teaGardenConfig.garden_name, label_bn: i18n.messages.bn.teaGardenConfig.garden_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
  { label_en: i18n.messages.en.teaGardenConfig.garden_address, label_bn: i18n.messages.bn.teaGardenConfig.garden_address, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
  { label_en: i18n.messages.en.teaGardenConfig.registration_no, label_bn: i18n.messages.bn.teaGardenConfig.registration_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8 }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    PaymentInfo
  },
  data () {
    return {
      sortBy: '',
      sortDirection: 'desc',
      sortDesc: true,
      search: {
        garden_id: 0,
        registration_no: '',
        application_id: '',
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        status: 0,
        limit: 20
      },
      labelData: [],
      editItemId: 0,
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      pauroshobaList: [],
      teaGardenNameList: [],
      item: {
        id: 0
      }
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
    this.getGardenNameList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.area_type_id': function (newVal, oldVal) {
      this.getGardenNameList()
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.getGardenNameList()
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
        this.getGardenNameList()
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
        this.getGardenNameList()
      } else {
        this.unionList = []
        this.pauroshobaList = []
      }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getGardenNameList()
      }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getGardenNameList()
      }
    },
    currentLocale: function () {
      this.getGardenNameList()
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
          { key: 'app_id' },
          { key: 'applicant_name_bn' },
          { key: 'garden_name' },
          { key: 'garden_address' },
          { key: 'garden_registration_no' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'app_id' },
          { key: 'applicant_name_en' },
          { key: 'garden_name' },
          { key: 'garden_address' },
          { key: 'garden_registration_no' },
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
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    getGardenList () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
    },
    statusList () {
      return [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'খসড়া' : 'Draft' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'অপেক্ষমাণ' : 'Pending' },
        { value: 3, text: this.$i18n.locale === 'bn' ? 'ফরওয়ার্ড' : 'Forwarded' },
        { value: 4, text: this.$i18n.locale === 'bn' ? 'সুপারিশ' : 'Recommendation' },
        { value: 5, text: this.$i18n.locale === 'bn' ? 'সুপারিশকৃত' : 'Recommended' },
        { value: 6, text: this.$i18n.locale === 'bn' ? 'অনুমোদিত' : 'Approved' },
        { value: 7, text: this.$i18n.locale === 'bn' ? 'প্রত্যাখ্যাত' : 'Reject' }
      ]
    }
  },
  methods: {
    pdfExport () {
      this.$refs.paymentInfo.pdfExport()
    },
    paymentInfoShow (item) {
      this.item = item
    },
    editData (item) {
      this.$router.push(`tree-disposal-registration-form?id=${item.id}`)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalAppListApi, params)
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
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    async getGardenNameList () {
    let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, getTeaGardenNameList, this.search)
      if (result) {
        this.teaGardenNameList = result.map(item => {
          const text = {
            text: this.currentLocale === 'en' ? item.text_en : item.text_bn
          }
          return Object.assign(item, text)
      })
      }
    }
  }
}
</script>
