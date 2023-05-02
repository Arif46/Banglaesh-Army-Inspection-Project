<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_a') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
      <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay>
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
                <b-row>
                  <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <b-form-group label-for="office_type_id">
                      <template v-slot:label>
                        {{ $t('tcbconfiguration.office_type') }}
                      </template>
                      <b-form-select
                        plain
                        id="office_type_id"
                        :options="officeTypeList"
                        v-model="search.office_type_id"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                    </b-form-group>
                  </b-col> -->
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Card No." vid="card_no" v-slot="{ errors }">
                                <b-form-group
                                    label-for="card_no">
                                    <template v-slot:label>
                                      {{ $t('tcbconfiguration.card_no') }}
                                    </template>
                                    <b-form-input
                                    id="card_no"
                                    v-model="search.card_no"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <ValidationProvider name="NID" vid="nid" rules="min:10|max:17" v-slot="{ errors }">
                            <b-form-group
                                style="margin-left:12px;"
                                label-for="nid">
                                <template v-slot:label>
                                  {{ $t('tcbconfiguration.nid') }}
                                </template>
                                <b-form-input
                                id="nid"
                                v-model="search.nid"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                          <ValidationProvider name="Mobile" vid="mobile" rules="min:11|max:15" v-slot="{ errors }">
                            <b-form-group
                              label-for="mobile">
                              <template v-slot:label>
                                {{ $t('tcbconfiguration.mobile') }}
                              </template>
                              <b-form-input
                                id="mobile"
                                v-model="search.mobile"
                                :state="errors[0] ? false : (valid ? true : null)"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                      </b-col>
                </b-row>
                <b-row>
                    <!-- -----------------Add More Start------------------- -->
                    <!-- -----------------Add More End--------------------- -->
                </b-row>
                <b-row class="text-right mb-3">
                    <b-col>
                    </b-col>
                    <b-col>
                    </b-col>
                    <b-col>
                      <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                        <b-button type="submit" size="sm" variant="primary" class="mt-20" @click="searchData">
                          <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                        </b-button>
                      </b-col>
                    </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
      </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_s') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add mr-1" @click="resetId" v-b-modal.modal-form><i class="ri-file-excel-2-line mb-1"></i> {{ $t('tcbconfiguration.excel_import') }}</a>
        <router-link  class="btn-add" to="beneficiary-information-entry-form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(contract_date)="data">
                    {{ data.item.contract_date | dateFormat }}
                  </template>
                  <template v-slot:cell(mobile)="data">
                    {{ data.item.mobile | mobileNumber}}
                  </template>
                  <template v-slot:cell(card_no)="data">
                    {{ $n(data.item.card_no, { useGrouping: false })}}
                  </template>
                  <template v-slot:cell(nid)="data">
                    {{ $n(data.item.nid, { useGrouping: false })}}
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" :title="$t('globalTrans.edit')" :to="{ path: 'beneficiary-information-entry-form?id=' + data.item.id, query: { item: data.item }}"  size="sm">
                      <i class="ri-pencil-fill"></i>
                    </router-link>
                    <b-button :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="remove(data.item)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
                    </b-button>
                    <b-button class="mr-2" :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status mr-1" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-form" size="lg" :title="excelFormTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ExecelForm :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :item="item" :key="detailsItemId"/>
    </b-modal>
  </div>
</template>
<script>
import ExecelForm from './Execel-from.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { beneficiartInformationEntryList, beneficiaryInformationEntryToggle } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Details from './Details.vue'
import { helpers } from '@/utils/helper-functions'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ExecelForm, Details
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      detailsItemId: '',
      item: '',
      sortDirection: 'desc',
      search: {
        card_no: '',
        nid: '',
        mobile: '',
        limit: 10
      },
      officeTypeList: [],
      officeList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'tcbconfiguration.beneficiary_name_un', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tcbconfiguration.card_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tcbconfiguration.list_nid', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'tcbconfiguration.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5, thStyle: { width: '40%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.card_no': function (newVal, oldVal) {
    if (this.search.card_no.length > 15) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পনের অঙ্কের বেশি নয়।' : 'please enter a value not greater than fifteen digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.search.card_no = this.search.card_no.slice(0, 15)
    })
    }
  },
  'search.nid': function (newVal, oldVal) {
    if (this.search.nid.length > 17) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা সতের অঙ্কের বেশি নয়।' : 'please enter a value not greater than seventeen digits.',
          color: '#FF0000'
        })
    this.$nextTick(() => {
      this.search.nid = this.search.nid.slice(0, 17)
    })
    }
  },
  'search.mobile': function (newVal, oldVal) {
    if (this.search.mobile.length > 15) {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$i18n.locale === 'bn' ? 'অনুগ্রহ করে একটি মান লিখুন যা পনের অঙ্কের বেশি নয়।' : 'please enter a value not greater than fifteen digits.',
          color: '#FF0000'
        })
      this.$nextTick(() => {
        this.search.mobile = this.search.mobile.slice(0, 15)
      })
    }
  },
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
          { key: 'beneficiary_name_bn' },
          { key: 'card_no' },
          { key: 'nid' },
          { key: 'mobile' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'beneficiary_name' },
          { key: 'card_no' },
          { key: 'nid' },
          { key: 'mobile' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    excelFormTitle () {
      return this.$t('tcbconfiguration.beneficiary_excel_form')
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tcbconfiguration.supplier_contract_number') + ' ' + this.$t('globalTrans.entry') : this.$t('tcbconfiguration.supplier_contract_number') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
        async saveUpdate () {
      },
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    editMethodInParent (conNum, type) {
      if (type === 1) {
        this.edit(conNum)
      } else if (type === 2) {
        this.changeStatus(7, licenseRegistrationServiceBaseUrl, beneficiaryInformationEntryToggle, conNum)
      }
    },
    searchData () {
      this.loadData()
    },
    remove (item) {
        this.changeStatus(8, licenseRegistrationServiceBaseUrl, beneficiaryInformationEntryToggle, item)
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.search.limit })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, beneficiartInformationEntryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
          listData.map(element => {
          element.DateBn = this.$options.filters.dateFormatBn(element.dob)
          element.DateEn = this.$options.filters.dateFormatEn(element.dob)
          element.ageBn = helpers.convertEnglishToBanglaNumber(element.age)
          element.genderEn = this.$store.state.commonObj.genderList.find(ele => ele.value === element.gender)?.text_en
          element.genderBn = this.$store.state.commonObj.genderList.find(ele => ele.value === element.gender)?.text_bn
          element.mobileBn = helpers.convertEnglishToBanglaNumber(element.mobile)
          element.cardBn = helpers.convertEnglishToBanglaNumber(element.card_no)
          element.nidBn = helpers.convertEnglishToBanglaNumber(element.nid)
          element.member_in_familyBn = helpers.convertEnglishToBanglaNumber(element.member_in_family)
          element.family_net_monthly_incomeBn = helpers.convertEnglishToBanglaNumber(element.family_net_monthly_income)
          element.family_net_monthly_expenseBn = helpers.convertEnglishToBanglaNumber(element.family_net_monthly_expense)
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
<style>
.card-title {
  font-size: 1rem!important;
}
</style>
