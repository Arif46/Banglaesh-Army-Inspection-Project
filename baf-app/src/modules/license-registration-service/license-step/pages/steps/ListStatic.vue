<template>
  <b-container fluid>
    <Search @LOAD_DATA="getSearchData" :step="step" :menuId="$route.params.id" />
    <b-row>
      <b-col md="12">
        <iq-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ checkBn ? menuInfoList.grid_title_bn : menuInfoList.grid_title_en }}</h4>
          </template>
          <template v-slot:headerAction>
            <router-link v-if="menuInfoList.is_application" :to="`/license-registration-service/license-step/application-form?step_id=${step.value}&menu_id=${$route.params.id}`" title="Add New" class="btn btn-success" size="sm">{{ $t('globalTrans.add_new') }}</router-link>
          </template>
          <template v-slot:body>
            <b-overlay :show="listLoading">
              <b-row>
                <b-col md="12" class="table-responsive">
                  <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null">
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + pagination.slOffset) }}
                    </template>
                    <template v-slot:cell(org_id)="data">
                      {{ getMainStoreData('orgList', data.item.org_id) }}
                    </template>
                    <template v-slot:cell(service_id)="data">
                      {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', data.item.service_id) }}
                    </template>
                    <template v-slot:cell(status)="data">
                      {{ getStepName(data.item.current_step) }}
                    </template>
                    <template v-slot:cell(action)="data">
                      <span v-if="Object.keys(actions(data.item.service_id)).length">
                        <span v-if="JSON.parse(actions(data.item.service_id).actions).length" >
                          <router-link v-if="data.item.save_status === 1" :to="`${getBtn(1).url}?application_id=${data.item.application_id}&step_id=${step.value}&org_id=${data.item.org_id}&service_id=${data.item.service_id}`" :title="getBtn(1).text" :class="`btn btn-sm `+ getBtn(1).color" size="sm"><i :class="getBtn(1).icon"></i></router-link>
                          <span v-else>
                              <span v-for="(btn, index) in JSON.parse(actions(data.item.service_id).actions)" :key="index">
                                <span v-if="btn === 1 || btn === 3 || btn === 4 || btn === 6 || btn === 7 || btn === 9 || btn === 10 || btn === 11 || btn === 12">
                                  <!-- Next Step -->
                                  <button style='margin-left: 4px' type="button" v-if="btn === 6" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 6)"><i :class="getBtn(btn).icon"></i></button>

                                  <router-link v-if="btn === 4 && data.item.status !== 1 && data.item.status !== 2" :to="`${getBtn(btn).url}?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&status=1`" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"></i></router-link>

                                  <router-link v-if="(btn === 3 && (auth.authUser.user_id === 1 || auth.authUser.is_org_admin === 1) && data.item.forward !== 1) || (btn === 3 && data.item.forward === 1 && auth.authUser.user_id !== 1 && auth.authUser.is_org_admin !== 1)" :to="`${getBtn(btn).url}?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}`" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"></i></router-link>

                                  <router-link v-if="btn === 7 && data.item.status !== 2 && data.item.status !== 1" :to="`${getBtn(btn).url}?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&status=2`" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"></i></router-link>
                                  <!-- License Cancel -->
                                  <template v-if="data.item.status !== 4">
                                    <button style='margin-left: 4px' type="button" v-if="btn === 9" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 9)"><i :class="getBtn(btn).icon"></i></button>
                                  </template>
                                  <!-- License Withdraw -->
                                  <template v-if="data.item.status !== 5">
                                    <button style='margin-left: 4px' type="button" v-if="btn === 10" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 10)"><i :class="getBtn(btn).icon"></i></button>
                                  </template>
                                  <!-- License File Transfer -->
                                  <template v-if="data.item.status !== 6">
                                    <router-link v-if="btn === 11" :to="`${getBtn(btn).url}?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&status=${1}&org_id=${data.item.org_id}`" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"></i></router-link>
                                  </template>
                                  <!-- License Issue -->
                                  <template>
                                    <button style='margin-left: 4px' type="button" v-if="btn === 12 && data.item.expire_date === null" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 12)"><i :class="getBtn(btn).icon"></i></button>
                                  </template>
                                </span>

                                <!-- dynamic buttons -->
                                <span v-else>
                                  <router-link :to="`${getBtn(btn).url}?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&org_id=${data.item.org_id}`" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><i :class="getBtn(btn).icon"> </i></router-link>
                                </span>
                              </span>
                          </span>
                        </span>
                        <span v-if="actions(data.item.service_id).is_custom_action">
                          <router-link v-for="(btn, index) in JSON.parse(actions(data.item.service_id).custom_actions)" :key="'custom'+index" :to="`/license-registration-service/license-step/action-form?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&form_id=${btn.form_id}&org_id=${data.item.org_id}`" class="btn btn-sm btn-success" size="sm">{{ $i18n.locale === 'bn' ? btn.btn_bn : btn.btn_en }}</router-link>
                        </span>
                      </span>
                      <span v-else class="badge badge-warning">Action Not Assign</span>
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
import Search from '../../components/search'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepDataList, changeLogStore, licenseCancel, licenseWithdraw, licenseIssue } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'

export default {
  mixins: [ModalBaseMasterList, common],
  components: {
    Search
  },
  data () {
    return {
      listLoading: false,
      stepChange: {
        application_id: 0,
        step_id: 0,
        service_id: 0,
        org_id: 0
      },
      search: {},
      columns: [],
      allData: {},
      menuInfo: [],
      isAddBtn: false,
      isAppPayment: 0,
      payReceipt: {}
    }
  },
  created () {
    if (this.menuInfoList.data_type === 'ststic') {
      this.setCommonGrid()
      this.checkSingleService()
    }
  },
  computed: {
    auth () {
      return this.$store.state.Auth
    },
    formTitle () {
       return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
    },
    menuId () {
      return this.$route.params.id
    },
    menuInfoList () {
      const menuId = this.$route.params.id
      return this.$store.state.LicenseRegistrationService.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    },
    step () {
      const stepId = this.menuInfoList.step_id
      return this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === parseInt(stepId))
    },
    serviceIds () {
      const ids = []
      this.menuInfoList.details.forEach(item => {
        ids.push(item.service_id)
      })
      return ids
    },
    laodList () {
      return this.$store.state.LicenseRegistrationService.commonObj.laodList
    }
  },
  watch: {
    laodList: function (n, o) {
      if (n !== o) {
        this.loadData()
      }
    },
    menuId: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (this.menuInfoList.data_type === 'static') {
          this.loadData()
          this.setCommonGrid()
          this.checkSingleService()
        }
      }
    }
  },
  methods: {
    setupReceipt (data) {
      this.payReceipt =
      {
        application_id: data.application_id,
        service_id: data.service_id
      }
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
      return step.text
    },
    actions (serviceId) {
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      if (typeof actions === 'undefined') {
        return {}
      } else {
        return actions
      }
    },
    customActions (serviceId) {
      return this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
    },
    getBtn (value) {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
    },
    searchData () {
      this.loadData()
    },
    loadData () {
      const params = Object.assign({}, this.search, {
        page: this.pagination.currentPage,
        per_page: this.pagination.perPage,
        step_id: this.step.value,
        service_ids: this.serviceIds,
        is_forward: this.menuInfoList.is_forward,
        is_common_forward: this.menuInfoList.is_common_forward,
        user_type: this.$store.state.Auth.authUser.user_type,
        is_org_admin: this.$store.state.Auth.authUser.is_org_admin,
        office_id: this.$store.state.Auth.authUser.office_id,
        is_payment: this.isAppPayment
      })
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepDataList, params).then(response => {
        if (response.success) {
          this.$store.dispatch('setList', response.data.data)
          this.paginationData(response.data)
        }
        this.listLoading = false
      })
    },
    getSearchData (res) {
      if (res.type === 2) {
        this.allData = res.data
        this.search = res.searchData
        if (res.data.success) {
          const dynamicGrid = res.data.grid_field.map(item => {
            const tmpData = JSON.parse(item.data)
            return { text: tmpData.label, value: tmpData.field_name }
          })
          if (res.data.grid_field.length) {
            this.setGridData(dynamicGrid)
          }
        } else {
          this.setCommonGrid()
        }
      } else {
        this.search = res.data
      }
      this.loadData()
    },
    setGridData (data) {
      const newArray = data.map(item => {
        return { label: item.text, class: 'text-left', key: item.value }
      })
      this.columns = newArray
      this.setSlAction(1)
    },
    setCommonGrid () {
      this.columns = JSON.parse(this.step.common_grid).map(item => {
        return { label: item.text, class: 'text-left', key: item.value }
      })
      this.setSlAction(2)
    },
    setSlAction (type) {
      this.columns = [
          { label: 'SL', class: 'text-left', key: 'index' },
          { label: 'Application Id', class: 'text-left', key: 'application_id' }
        ].concat(this.columns)
      if (type === 1) {
        this.columns.push({ label: 'Status', class: 'text-left', key: 'status' })
      }
      this.columns.push({ label: 'Action', class: 'text-left', key: 'action' })
    },
    checkSingleService () {
      if (this.menuInfoList.details.length === 1) {
        const serviceId = this.menuInfoList.details[0].service_id
        const isFee = this.paymentCheck(serviceId).application_fee
        if (isFee) {
          this.isAppPayment = 1
        } else {
          this.isAppPayment = 0
        }
        this.isAddBtn = true
      } else {
        this.isAddBtn = false
        this.loadData()
      }
    },
    paymentCheck (serviceId) {
      const steps = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === parseInt(serviceId))
      if (typeof steps === 'undefined') {
        return {}
      } else {
        return steps
      }
    },
    commonStatusChange (data, buttonID) {
      let msztitle = ''
      let Api = ''
      let message = ''
      if (buttonID === 6) {
        if (this.menuInfoList.is_forward === 1) {
          this.stepChange.is_forward = 1
        } else {
          this.stepChange.is_forward = 0
        }
        this.stepChange.step_id = this.getServiceWiseStep(data.service_id)
        this.stepChange.user_id = data.user_id
        msztitle = this.$t('globalTrans.stepChangeMsg')
        Api = changeLogStore
        message = 'Step Changed Successfully'
      }
      if (buttonID === 9) {
        this.stepChange.step_id = data.step_id
        msztitle = this.$t('globalTrans.cancelMsg')
        Api = licenseCancel
        message = 'License Cancel Successfully'
      }
      if (buttonID === 10) {
        this.stepChange.step_id = data.step_id
        msztitle = this.$t('globalTrans.withdrawMsg')
        Api = licenseWithdraw
        message = 'License Withdraw Successfully'
      }
      if (buttonID === 12) {
        this.stepChange.step_id = data.current_step
        this.stepChange.old_application_id = data.old_application_id ? data.old_application_id : 0
        msztitle = this.$t('globalTrans.issueMsg')
        Api = licenseIssue
        message = 'License Issue Successfully'
      }
      window.vm.$swal({
        title: msztitle,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
            this.listLoading = true
            this.stepChange.application_id = data.application_id
            this.stepChange.service_id = data.service_id
            this.stepChange.org_id = data.org_id
            this.stepChange.application_id = data.application_id
            RestApi.getData(licenseRegistrationServiceBaseUrl, Api, this.stepChange).then(res => {
              this.listLoading = false
              if (res.success === true) {
                this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
                this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: message,
                  color: '#D6E09B'
                })
                this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
              } else {
                this.$toast.error({
                  title: 'Error',
                  message: res.message
                })
              }
            })
        }
      })
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.step.value))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
    }
  }
}
</script>
<style scoped>
  .btn i {
      margin-right: 0px !important;
  }
  .btn {
    margin-left: 2px;
  }
</style>
