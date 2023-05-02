<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"
            enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
          <ValidationProvider name="Business Type" vid="business_type_id" rules="">
            <b-form-group label-for="business_type_id" slot-scope="{ valid, errors }">
              <template v-slot:label>
                {{$t('rjscConfig.business_type')}}
              </template>
              <b-form-select plain v-model="search.business_type_id" :options="businessType" id="business_type_id"
                :state="errors[0] ? false : (valid ? true : null)">
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" class="mt-20" type="submit">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
          </b-form>
        </ValidationObserver>
      </template>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('rjscConfig.common_fee') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('rjscConfig.common_fee') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{
        $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns"
            :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId" />
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { commonFeeList, commonFeeToggleApi } from '../../api/routes'
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
      search: {
        status: 0,
        limit: 10,
        business_type_id: 0
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '7%' } },
        { labels: 'rjscConfig.business_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'rjscConfig.fee', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
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
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'type_bn' },
          { key: 'amount' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'type' },
          { key: 'amount' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('rjscConfig.common_fee') + ' ' + this.$t('globalTrans.entry') : this.$t('rjscConfig.common_fee') + ' ' + this.$t('globalTrans.modify')
    },
    businessType () {
      return this.$store.state.RjscService.commonObj.businessTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(11, rjscServiceBaseUrl, commonFeeToggleApi, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(rjscServiceBaseUrl, commonFeeList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const typeObj = this.businessType.find(type => type.value === parseInt(item.business_type_id))
          const typeData = {}
          if (typeof typeObj !== 'undefined') {
            typeData.type = typeObj.text_en
            typeData.type_bn = typeObj.text_bn
          } else {
            typeData.type = ''
            typeData.type_bn = ''
          }
          return Object.assign({}, item, typeData, { serial: index })
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
