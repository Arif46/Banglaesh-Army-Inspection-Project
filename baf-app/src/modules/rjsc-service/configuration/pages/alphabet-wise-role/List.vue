<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('rjscConfig.alphabet_wise_role_search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
          <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
              <b-form-group
                  label-for="office_type_id"
                  slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{$t('organogram.office_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                  plain
                  v-model="search.office_type_id"
                  :options="officeTypeList"
                  id="office_type_id"
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
        <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-2">
          <ValidationProvider name="Office name" vid="office_id" rules="required|min_value:1">
              <b-form-group
                  label-for="office_id"
                  slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{$t('organogram.office_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                  plain
                  v-model="search.office_id"
                  :options="officeList"
                  id="office_id"
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
        <h4 class="card-title">{{ $t('rjscConfig.alphabet_wise_role_assign') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial +1) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(office_id)="data">
                    {{ getOfficeName(data.item.office_id) }}
                  </template>
                  <template v-slot:cell(alphabets)="data">
                    {{ getAlphabetName(data.item.alphabets) }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="editMethodInParent(data.item,2)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
                    </b-button>
                  </template>
                </b-table>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { alphabetWiseRoleList, alphabetWiseRoleToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      rjscServiceBaseUrl: rjscServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        office_type_id: 0,
        office_id: 0,
        limit: 20
      },
      item: '',
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1 },
        { labels: 'rjscConfig.alphabet', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'globalTrans.office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 4 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      officeList: []
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
    },
    'search.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.getOfficeList(newVal)
      } else {
        this.officeList = []
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
          { key: 'alphabets' },
          { key: 'office_id' },
          { key: 'name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'alphabets' },
          { key: 'office_id' },
          { key: 'name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('rjscConfig.alphabet_wise_role_assign') + ' ' + this.$t('globalTrans.entry') : this.$t('rjscConfig.alphabet_wise_role_assign') + ' ' + this.$t('globalTrans.modify')
    },
    officeTypeList (id) {
      return this.$store.state.RjscService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === this.$rjscOrgId)
    }
  },
  methods: {
    getOfficeList (officeTypeId) {
      return this.$store.state.RjscService.commonObj.officeList.filter(office => office.office_type_id === officeTypeId)
    },
    editMethodInParent (item, type) {
      this.edit(item)
      if (type === 1) {
      } else if (type === 2) {
        this.changeStatus(6, rjscServiceBaseUrl, alphabetWiseRoleToggleApi, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(rjscServiceBaseUrl, alphabetWiseRoleList, params)
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
    getOfficeName (id) {
      const data = this.$store.state.RjscService.commonObj.officeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
      }
    },
    getAlphabetName (alphabets) {
      const alphabetList = JSON.parse(alphabets)
      const alphabetObj = alphabetList.map(obj => {
        const data = this.$store.state.commonObj.alphabetList.find(item => item.value === obj)
        if (typeof data !== 'undefined') {
            return data.text
        } else {
            return ''
        }
      })
      const removeQuotation = JSON.stringify(alphabetObj).replace(/"|'/g, ' ') // "" remove
      const finalAlphabets = removeQuotation.replace(/\[|\]/g, '') // bracket remove
      return finalAlphabets
    }
  }
}
</script>
