<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('stakeholder.stakeholder_info') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Organization" vid="organization_category">
                <b-form-group
                    label-for="organization_category"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('stakeholder.org_category')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.organization_category"
                  :options="orgCatType"
                  id="organization_category"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.organization_category === 1">
            <ValidationProvider name="Organization" vid="organization_id">
                <b-form-group
                    label-for="organization_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('organogram.org')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.organization_id"
                  :options="orgList"
                  id="organization_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.organization_category === 2">
            <ValidationProvider name="Organization" vid="organization_type_id">
                <b-form-group
                    label-for="organization_type_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('stakeholder.org_type')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.organization_type_id"
                  :options="organizationTypeList"
                  id="organization_type_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.organization_category === 2">
            <ValidationProvider name="Organization" vid="organization_sub_type_id">
                <b-form-group
                    label-for="organization_sub_type_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('stakeholder.org_sub_type')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.organization_sub_type_id"
                  :options="organizationSubTypeList"
                  id="organization_sub_type_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.organization_category === 2">
            <ValidationProvider name="Organization" vid="organization_id">
                <b-form-group
                    label-for="organization_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('organogram.org')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.organization_id"
                  :options="organizationNameList"
                  id="organization_id"
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
        <h4 class="card-title">{{ $t('stakeholder.stakeholder_info') }} {{ $t('globalTrans.list') }}</h4>
      </template>
        <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
        <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions"/>
        </b-overlay>
      </template>
      <!-- table section end-->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId" />
    </b-modal>
    <b-modal id="details" size="lg" :title="$t('stakeholder.stakeholder_info') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="detailItemId" :key="detailItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { stakeholderList, stakeholderToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details
  },
  data () {
    return {
      showExternalOrg: false,
      showInternalOrg: false,
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      item: '',
      search: {
        organization_category: 0,
        organization_id: 0,
        organization_type_id: 0,
        organization_sub_type_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'stakeholder.org_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'stakeholder.org_sub_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'stakeholder.contact_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: true,
        details: true,
        toogle: true,
        delete: false
      },
      orgCatType: [
        { value: 1, text: 'MOC' },
        { value: 2, text: 'other' }
      ]
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
    orgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList
    },
    organizationTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList
    },
    organizationSubTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.filter(orgSubType => orgSubType.organization_type_id === this.search.organization_type_id)
    },
    organizationNameList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationNameList.filter(externalOrg => externalOrg.organization_sub_type_id === this.search.organization_sub_type_id)
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
          { key: 'org_type_name_bn' },
          { key: 'org_sub_head_name_bn' },
          { key: 'org_name_bn' },
          { key: 'stakeholder_name_bn' },
          { key: 'stakeholder_designation_bn' },
          { key: 'contact_no' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_type_name' },
          { key: 'org_sub_head_name' },
          { key: 'org_name' },
          { key: 'stakeholder_name_en' },
           { key: 'stakeholder_designation' },
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
      return (this.editItemId === 0) ? this.$t('stakeholder.stakeholder_info') + ' ' + this.$t('globalTrans.entry') : this.$t('stakeholder.stakeholder_info') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(6, bftiResReportServiceBaseUrl, stakeholderToggle, item)
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
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, stakeholderList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgTypeObj = this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList.find(orgType => orgType.value === parseInt(item.organization_type_id))
          const orgSubHeadObj = this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.find(orgSubHead => orgSubHead.value === parseInt(item.organization_sub_type_id))
          let orgObj = {}
          if (item.organization_category === 1) {
            orgObj = this.$store.state.CommonService.commonObj.componentOrgList.find(org => org.value === parseInt(item.organization_id))
          }
          if (item.organization_category === 2) {
            orgObj = this.$store.state.BftiResearchAndReportService.commonObj.organizationNameList.find(org => org.value === parseInt(item.organization_id))
          }

          const orgTypeData = {}
          if (typeof orgTypeObj !== 'undefined') {
            orgTypeData.org_type_name = orgTypeObj.text_en
            orgTypeData.org_type_name_bn = orgTypeObj.text_bn
          } else {
            orgTypeData.org_type_name = ''
            orgTypeData.org_type_name_bn = ''
          }

          const orgData = {}
          if (typeof orgObj !== 'undefined') {
            orgData.org_name = orgObj.text_en
            orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }

          const organizationSubHeadData = {}
          if (typeof orgSubHeadObj !== 'undefined') {
            organizationSubHeadData.org_sub_head_name = orgSubHeadObj.text_en
            organizationSubHeadData.org_sub_head_name_bn = orgSubHeadObj.text_bn
          } else {
            organizationSubHeadData.org_sub_head_name = ''
            organizationSubHeadData.org_sub_head_name_bn = ''
          }
          return Object.assign({}, item, { serial: index + 0 }, orgData, orgTypeData, organizationSubHeadData)
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
      this.changeStatus(6, bftiResReportServiceBaseUrl, stakeholderToggle, item)
    },
    orgShow () {
      if (this.form.organization_category === 1) {
        this.showExternalOrg = false
        this.showInternalOrg = true
      }
      if (this.form.organization_category === 2) {
        this.showInternalOrg = false
        this.showExternalOrg = true
      }
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
