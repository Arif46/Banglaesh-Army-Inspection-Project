<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('research_execution.received_payment_entry') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{$t('configuration.document_type')}}
              </template>
              <b-form-select
                plain
                v-model="search.document_type_id"
                :options="docTypeList"
                id="fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="topic"
            >
            <template v-slot:label>
              {{$t('bfti.topic')}}
            </template>
             <b-form-select
                plain
                v-model="search.title_id"
                :options="RFPResearchList"
                id="fiscal_year_id"
              >
              <template v-slot:first>
                <b-form-select-option :value="0">{{ titleLoad ? 'Loading....' : $t('globalTrans.select') }}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Start date" vid="start_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                  {{ $t('globalTrans.start_date') }}
                </template>
                <date-picker
                id="start_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                v-model="search.start_date"
                :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="End date" vid="end_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}
                </template>
                <date-picker
                 id="end_date"
                 class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                 v-model="search.end_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
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
        <h4 class="card-title">{{ $t('research_execution.received_payment_entry') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                    {{ $n(data.index + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(document_type_id)="data">
                    {{ getDocumentTypeName(data.item.document_type_id) }}
                  </template>
                  <template v-slot:cell(client)="data">
                    <slot v-if="data.item.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? data.item.prepare_rfp.client_bn : data.item.prepare_rfp.client }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? data.item.research.client_bn : data.item.research.client }}
                    </slot>
                  </template>
                  <template v-slot:cell(title)="data">
                    <slot v-if="data.item.document_type_id === 1">
                      {{ ($i18n.locale === 'bn') ? data.item.prepare_eoi.title_bn : data.item.prepare_eoi.title }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? data.item.prepare_rfp.rfp_title_bn : data.item.prepare_rfp.rfp_title_en }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? data.item.research.topic_bn: data.item.research.topic }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 4">
                      {{ ($i18n.locale === 'bn') ? data.item.policy.policy_title_bn: data.item.policy.policy_title }}
                    </slot>
                  </template>
                  <template v-slot:cell(rcv_date)="data">
                    {{data.item.rcv_date|dateFormat}}
                  </template>
                  <template v-slot:cell(installment_id)="data">
                    {{ getInstallmentName(data.item.installment_id)}}
                  </template>
                  <template v-slot:cell(rcv_amount)="data">
                    {{ $n(data.item.rcv_amount, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(contact_no)="data">
                    {{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(data.item.contact_no, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="data.item.status === 1" v-b-modal.modal-form variant="iq-bg-success mr-2" size="sm" @click="edit(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                     <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <b-button @click="pdfExport" class="ml-4 btn-success download-pdf-button">
        {{  $t('globalTrans.print') }}
      </b-button>
      <Details  :item="item" ref="details"/>
    </b-modal>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form  :item="item"/>
    </b-modal>
  </div>
</template>
<style scoped>
  table#table-transition-example .flip-list-move {
    transition: transform 1s;
  }
</style>
<script>
  import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
  import { rcvPaymentListApi, contractSignedList } from '../../api/routes'
  import ModalBaseMasterList from '@/mixins/list'
  import i18n from '@/i18n'
  import Form from './Form'
  import Details from './Details'

  const defaultColumn = [
    { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
    { label_en: i18n.messages.en.bfti.doc_type, label_bn: i18n.messages.bn.bfti.doc_type, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
    { label_en: i18n.messages.en.research_execution.title_or_topic, label_bn: i18n.messages.bn.research_execution.title_or_topic, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
    { label_en: i18n.messages.en.research_execution.client, label_bn: i18n.messages.bn.research_execution.client, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '5%' } },
    { label_en: i18n.messages.en.research_execution.ins_no, label_bn: i18n.messages.bn.research_execution.ins_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
    { label_en: i18n.messages.en.research_execution.rcv_amount, label_bn: i18n.messages.bn.research_execution.rcv_amount, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
    { label_en: i18n.messages.en.research_execution.rcv_date, label_bn: i18n.messages.bn.research_execution.rcv_date, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
    { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8, thStyle: { width: '10%' } }
  ]
  export default {
    mixins: [ModalBaseMasterList],
    components: {
       Form, Details
    },
    data () {
      return {
        titleLoad: false,
        sortBy: '',
        search: {
          document_type_id: 0,
          title_id: 0,
          start_date: '',
          end_date: '',
          limit: 10,
          type: this.$store.state.Auth.authUser.user_type,
          user_id: this.$store.state.Auth.authUser.user_id
        },
        item: '',
        sortDesc: true,
        sortDirection: 'desc',
        RFPResearchList: []
      }
    },
    created () {
      this.labelData = this.labelList
      this.loadData()
    },
    watch: {
      'search.document_type_id': function (newVal, oldVal) {
        this.RFPResearchList = this.titleTopicList()
      },
      'search.limit': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.loadData()
        }
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      },
      docTypeList () {
        return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
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
            { key: 'document_type_id' },
            { key: 'title' },
            { key: 'client' },
            { key: 'installment_id' },
            { key: 'rcv_amount' },
            { key: 'rcv_date' },
            { key: 'action' }
          ]
        } else {
          keys = [
            { key: 'serial' },
            { key: 'document_type_id' },
            { key: 'title' },
            { key: 'client' },
            { key: 'installment_id' },
            { key: 'rcv_amount' },
            { key: 'rcv_date' },
            { key: 'action' }
          ]
        }
        return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
      },
      detailsTitle () {
        return this.$t('research_execution.received_payment_entry') + ' ' + this.$t('globalTrans.details')
      },
      formTitle () {
        return this.$t('research_execution.received_payment_entry')
      },
      pageOptions () {
        return this.$store.state.commonObj.pageOptions
      }
    },
    methods: {
      titleTopicList () {
        this.titleLoad = true
        const params = Object.assign({}, { document_type_id: this.search.document_type_id })
        RestApi.getData(bftiResReportServiceBaseUrl, contractSignedList, params).then(response => {
          if (response.success) {
          this.RFPResearchList = response.data.map(item => {
            if (this.$i18n.locale === 'en') {
              if (this.search.document_type_id === 2) {
                return { value: item.research.id, text: item.prepare_rfp.text }
              }
              if (this.search.document_type_id === 3) {
                return { value: item.research.id, text: item.research.text }
              }
            } else {
              if (this.search.document_type_id === 2) {
                return { value: item.research.id, text: item.prepare_rfp.text_bn }
              }
              if (this.search.document_type_id === 3) {
                return { value: item.research.id, text: item.research.text_bn }
              }
            }
          })
          }
          this.titleLoad = false
        })
      },
      edit (item) {
        this.item = item
      },
      resetId () {
        this.item = ''
      },
      searchData () {
        this.loadData()
      },
      async loadData () {
        const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getData(bftiResReportServiceBaseUrl, rcvPaymentListApi, params)
        if (result.success) {
          this.$store.dispatch('setList', result.data.data)
          this.paginationData(result.data, this.search.limit)
        } else {
          this.$store.dispatch('setList', [])
          this.paginationData([])
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      },
      details (item) {
        this.item = item
      },
      getInstallmentName (installmentID) {
        const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
        return data !== undefined ? data.text : ''
      },
      pdfExport () {
        this.$refs.details.pdfExport()
      },
      getDocumentTypeName (documentTypeId) {
        const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
        return data !== undefined ? data.text : ''
      }
    }
  }
</script>
