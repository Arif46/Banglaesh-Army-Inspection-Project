<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('globalTrans.payment') }}</h4>
      </template>
      <template v-slot:body>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
          <b-form  @submit.prevent="handleSubmit(searchData)" >
            <b-row>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Organization" vid="org_id">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="org_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('org_pro.organization') }}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.org_id"
                      :options="organizationList"
                      id="org_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Service" vid="service_id">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="service_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('service_name.service_name') }}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.service_id"
                      :options="serviceNamesList"
                      id="service_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Application" vid="application_id" >
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="application_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.application_id') }}
                    </template>
                    <b-form-input
                      plain
                      v-model="search.application_id"
                      id="application_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <!-- <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Application" vid="from_date" >
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="from_date"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.from_date') }}
                    </template>
                    <b-form-input
                      plain
                      v-model="search.from_date"
                      id="from_date"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Application" vid="to_date" >
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="to_date"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.to_date') }}
                    </template>
                    <b-form-input
                      plain
                      v-model="search.to_date"
                      id="to_date"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col> -->
              <b-col class="col-sm-2">
                <b-button type="submit" variant="primary">{{ $t('globalTrans.search')}}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
    </iq-card>
    <b-row>
      <b-col md="12">
        <iq-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('globalTrans.payment') }} {{ $t('globalTrans.list') }}</h4>
          </template>
          <template v-slot:body>
            <b-overlay :show="loadingState">
              <b-row>
                <b-col md="12" class="table-responsive">
                  <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + 1) }}
                    </template>
                    <template v-slot:cell(payment_type)="data">
                      <span class="badge badge-success" v-if="data.item.status == 1">{{ 'Type Payment' }}</span>
                      <span class="badge badge-success" v-if="data.item.status == 2">{{ 'Step Payment' }}</span>
                      <span class="badge badge-success" v-if="data.item.status == 3">{{ 'Renew Payment' }}</span>
                      <span class="badge badge-success" v-if="data.item.status == 4">{{ 'Lost Payment' }}</span>
                    </template>
                  </b-table>
                  <b-pagination
                    v-model="pagination.currentPage"
                    :per-page="pagination.perPage"
                    :total-rows="pagination.totalRows"
                    @input="searchData"
                    />
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </iq-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paymentList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import flatpickr from 'flatpickr'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      search: {
        org_id: 0,
        service_id: 0,
        application_id: ''
      },
      editItem: '',
      editItemId: '',
      serviceNamesList: []
    }
  },
  computed: {
    organizationList: function () {
      return this.$store.state.commonObj.organizationProfileList.filter(item => item.status === 0)
    },
    dynamicFormList: function () {
      return this.$store.state.licenseRegistration.commonObj.dynamicFormList
    },
    stepList: function () {
      return this.$store.state.licenseRegistration.commonObj.stepNamesList.filter(item => item.status === 1)
    },
    formTitle () {
       return (this.editItemId === 0) ? this.$t('li_step.transfer_list') : this.$t('li_step.transfer_list') + ' ' + this.$t('globalTrans.modify')
    },
    columns () {
      const labels = [
        { label: this.$t('globalTrans.sl_no'), class: 'text-left' },
        { label: this.$t('globalTrans.application_id'), class: 'text-left' },
        { label: this.$t('globalTrans.organization'), class: 'text-left' },
        { label: this.$t('service_name.service_name'), class: 'text-left' },
        { label: this.$t('globalTrans.payment_type'), class: 'text-left' },
        { label: this.$t('globalTrans.transaction_no'), class: 'text-left' },
        { label: this.$t('globalTrans.amount'), class: 'text-left' },
        { label: this.$t('globalTrans.pay_status'), class: 'text-left' }
      ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'org_name_bn' },
          { key: 'service_name_bn' },
          { key: 'payment_type' },
          { key: 'transaction_no' },
          { key: 'amount' },
          { key: 'pay_status' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'org_name_en' },
          { key: 'service_name_en' },
          { key: 'payment_type' },
          { key: 'transaction_no' },
          { key: 'amount' },
          { key: 'pay_status' }
        ]
      }

      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    }
  },
  watch: {
    loadingState: function (newVal) {
      if (newVal) {
        this.loadData()
      }
    },
    'search.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    }
  },
  mounted () {
    flatpickr('#to_date', {})
    flatpickr('#from_date', {})
  },
  created () {
    this.loadData()
  },
  methods: {
    searchData () {
      this.loadData()
    },
    edit (item) {
      this.editItem = item
      const service = Object.keys(item)
      const serviceId = parseInt(service[0])
      this.editItemId = serviceId
    },
    loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      RestApi.getData(licenseRegistrationServiceBaseUrl, paymentList, params).then(response => {
        if (response.success) {
          this.$store.dispatch('setList', this.relationData(response.data.data))
          this.paginationData(response.data)
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      })
    },
    relationData (data) {
      const listData = data.map(item => {
        const serviceList = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(serviceItem => serviceItem.value === parseInt(item.service_id))
        const orgList = this.organizationList.find(orgItem => orgItem.value === parseInt(item.org_id))
        const serviceObj = {
          service_name_en: serviceList !== undefined ? serviceList.text_en : '',
          service_name_bn: serviceList !== undefined ? serviceList.text_bn : ''
        }
        const orgObj = {
          org_name_en: orgList !== undefined ? orgList.text_en : '',
          org_name_bn: orgList !== undefined ? orgList.text_bn : ''
        }
        return Object.assign({}, item, serviceObj, orgObj)
      })
      return listData
    },
    getServiceName (serviceId) {
      const ServiceName = this.serviceList.find(item => item.value === serviceId)
      return this.$i18n.locale === 'en' ? ServiceName !== undefined ? ServiceName.text_en : '' : ServiceName !== undefined ? ServiceName.text_bn : ''
    },
    getServiceList (orgId) {
      const serviceList = this.$store.state.licenseRegistration.commonObj.serviceNamesList.filter(item => item.org_id === orgId)
      return serviceList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  }
}
</script>
