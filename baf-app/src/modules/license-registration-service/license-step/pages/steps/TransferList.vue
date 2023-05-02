<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('li_step.transfer_list') }}</h4>
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
                        <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
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
                      :options="serviceList"
                      id="service_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
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
              <b-col lg="6" sm="6" md="6">
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
              </b-col>
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
            <h4 class="card-title">{{ $t('li_step.transfer_list') }}</h4>
          </template>
          <template v-slot:headerAction>
            <router-link :to="`transfer`">
              <b-button class="mr-2" title="Add New" variant="primary" size="sm">{{ $t('globalTrans.add_new') }}</b-button>
            </router-link>
          </template>
          <template v-slot:body>
            <b-overlay :show="loadingState">
              <b-row>
                <b-col md="12" class="table-responsive">
                  <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + 1) }}
                    </template>
                    <template v-slot:cell(old_application_id)>
                      <router-link :to="{ name: 'app_detail', params: { stepChange }}" title="View Form" class="iq-bg-info mr-1 mb-1" size="sm"><i class="ri-eye-fill m-0"></i></router-link>
                    </template>
                    <template v-slot:cell(action)>
                      <router-link :to="{ name: 'app_detail', params: { stepChange }}" title="View Form" class="iq-bg-info mr-1 mb-1" size="sm"><i class="ri-eye-fill m-0"></i></router-link>
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
    <!-- <b-modal id="modal-4" size="xl" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <p> <Transfer :id="editItemId" :key="editItemId"/> </p>
    </b-modal> -->
  </b-container>
</template>
<script>
// import Transfer from './Transfer'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { licenseTransferList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import flatpickr from 'flatpickr'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ValidationObserver,
    ValidationProvider
    // Transfer
  },
  data () {
    return {
      search: {
        org_id: 0,
        service_id: 0,
        application_id: ''
      },
      stepChange: {
        application_id: 0,
        step_id: 0,
        service_id: 0,
        org_id: 0,
        status: 1
      },
      editItem: '',
      editItemId: ''
    }
  },
  computed: {
    organizationList: function () {
      return this.$store.state.commonObj.organizationProfileList.filter(item => item.status === 0)
    },
    dynamicFormList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList
    },
    serviceList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1)
    },
    stepList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.filter(item => item.status === 1)
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
        { label: 'Old Application', class: 'text-center' },
        { label: this.$t('globalTrans.action'), class: 'text-center' }
      ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'org_name_bn' },
          { key: 'service_name_bn' },
          { key: 'old_application_id' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'application_id' },
          { key: 'org_name_en' },
          { key: 'service_name_en' },
          { key: 'old_application_id' },
          { key: 'action' }
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
      RestApi.getData(licenseRegistrationServiceBaseUrl, licenseTransferList, params).then(response => {
        if (response.success) {
          this.$store.dispatch('setList', this.relationData(response.data.data))
          this.paginationData(response.data)
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      })
    },
    relationData (data) {
      const listData = data.map(item => {
        this.stepChange.application_id = item.application_id
        this.stepChange.org_id = item.org_id
        this.stepChange.service_id = item.service_id
        // this.stepChange.application_id = item.application_id
        const serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(serviceItem => serviceItem.value === parseInt(item.service_id))
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
    }
  }
}
</script>
