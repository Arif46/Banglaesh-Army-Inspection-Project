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
                <ValidationProvider name="Word" vid="word" rules="" v-slot="{ errors }">
                  <b-form-group label-for="word">
                    <template v-slot:label>
                      {{ $t('rjscConfig.business_type') }}
                    </template>
                    <b-form-input id="word" v-model="search.word"
                      :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
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
        <h4 class="card-title">{{ $t('rjscConfig.business_type') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('rjscConfig.business_type') }} {{ $t('globalTrans.list') }}</h4>
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
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only
      ok-variant="danger">
      <Form :id="editItemId" :key="editItemId" />
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { businessTypeList, businessTypeToggleApi } from '../../api/routes'
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
        word: '',
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'rjscConfig.business_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
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
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'type_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('rjscConfig.business_type') + ' ' + this.$t('globalTrans.entry') : this.$t('rjscConfig.business_type') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(11, rjscServiceBaseUrl, businessTypeToggleApi, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(rjscServiceBaseUrl, businessTypeList, params)
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
    }
  }
}
</script>
