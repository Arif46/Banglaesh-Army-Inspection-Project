<template>
  <b-container fluid>
    <SearchReport @LOAD_DATA="getSearchData" :step="step" :menuId="$route.params.id" />
    <b-row>
      <b-col md="12">
        <iq-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ checkBn ? menuInfoList.grid_title_bn : menuInfoList.grid_title_en }}</h4>
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
                      {{ getStoreData('licenseRegistration', 'serviceNamesList', data.item.service_id) }}
                    </template>
                    <template v-slot:cell(status)="data">
                      {{ getStepName(data.item.current_step) }}
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
import SearchReport from '../../components/searchReport'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepDataList, changeLogStore, licenseCancel, licenseWithdraw, licenseIssue } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'

export default {
  mixins: [ModalBaseMasterList, common],
  components: {
    SearchReport
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
      isAppPayment: false
    }
  },
  created () {
    this.checkSingleService()
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
      return this.$store.state.licenseRegistration.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    },
    serviceIds () {
      const ids = []
      this.menuInfoList.details.forEach(item => {
        ids.push(item.service_id)
      })
      return ids
    },
    laodList () {
      return this.$store.state.licenseRegistration.commonObj.laodList
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
        this.loadData()
        this.checkSingleService()
      }
    }
  },
  methods: {
    getStepName (stId) {
      const step = this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === stId)
      return step.text
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
      const steps = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(item => item.value === parseInt(serviceId))
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
              if (res.success) {
                this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
                this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: message,
                  color: '#D6E09B'
                })
                this.$store.dispatch('licenseRegistration/setLaodList', true)
              } else {
                this.$refs.form.setErrors(res.errors)
                this.$toast.error({
                  title: 'Error',
                  message: 'Operation failed! Please, try again.'
                })
              }
            })
        }
      })
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
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
