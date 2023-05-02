<template>
  <b-container fluid>
    <Search @LOAD_DATA="getSearchData" :step="step" :menuId="menuId" :key="componentKey" />
    <b-row>
      <b-col md="12">
        <body-card>
          <template v-slot:headerTitle>
            <b-button size="sm" class="mr-2 btn_application" @click="loadData">{{ $t('li_step.app_recieved_list') }}</b-button>
            <b-button size="sm" class="btn_add_new" @click="getSendList">{{ $t('li_step.app_send_list') }}</b-button>
          </template>
          <template v-slot:body>
            <b-overlay :show="listLoading">
              <b-row>
                <b-col md="8" class="mb-2">
                  <b-button size="sm" @click="selectAllRows">{{ $t('globalTrans.checkAll') }}</b-button>
                </b-col>
                <b-col md="4" style="text-align: right">
                  <span v-if="JSON.parse(actions(menuInfoList.details[0].service_id).actions).length" >
                    <span v-for="(btn, index) in JSON.parse(actions(menuInfoList.details[0].service_id).actions)" :key="index">
                      <!-- License Forward = 3, Approve = 4, Verify = 6, Reject = 7,Cancel = 9, Document Issue = 12-->
                      <span v-if="btn === 3 || btn === 4 || btn === 6 || btn === 7 || btn === 9 || btn === 12">
                        <!-- License Forward -->
                        <router-link v-if="btn === 3 && !sendList" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetMultiApplicantStep(1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                        <!-- License Approve -->
                        <router-link v-if="btn === 4 && !sendList" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetMultiApplicantStep(1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                        <!-- License Reject -->
                        <router-link v-if="btn === 7 && !sendList" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetMultiApplicantStep(2)"><i :class="getBtn(btn).icon"></i></span></router-link>
                        <!-- License Verify -->
                        <button style='margin-left: 4px' type="button" v-if="btn === 6 && !sendList" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(applicationIds, 6)"><i :class="getBtn(btn).icon"></i></button>
                        <!-- License Cancel -->
                        <button style='margin-left: 4px' type="button" v-if="btn === 9 && !sendList" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(applicationIds, 9)"><i :class="getBtn(btn).icon"></i></button>
                        <!-- License Issue -->
                        <button style='margin-left: 4px' type="button" v-if="btn === 12 && !sendList" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(applicationIds, 12)"><i :class="getBtn(btn).icon"></i></button>
                      </span>
                      <!-- dynamic buttons -->
                    </span>
                    <span v-if="sendList">
                      <button style='margin-left: 4px' type="button" :title="$t('li_step.return_application')" class="btn btn-sm btn-info" size="sm" @click="commonStatusChange(applicationIds, 19)"><i class="fa fa-undo"></i></button>
                    </span>
                  </span>
                </b-col>
                <b-col md="12" class="table-responsive" v-if="!sendList">
                  <b-table :select-mode="selectMode" ref="selectableTable" selectable @row-selected="onRowSelected" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :tbody-tr-class="rowClass">
                    <template v-slot:cell(selected)="{ rowSelected }">
                      <template v-if="rowSelected">
                        <span class="ml-4" aria-hidden="true">&check;</span>
                      </template>
                      <template v-else>
                        <span class="ml-4" aria-hidden="true">&#x25a2;</span>
                      </template>
                    </template>
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + 1) }}
                    </template>
                    <template v-slot:cell(org_id)="data">
                      {{ getMainStoreData('orgList', data.item.org_id) }}
                    </template>
                    <template v-slot:cell(service_id)="data">
                      {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', data.item.service_id) }}
                    </template>
                    <template v-slot:cell(application_id)="data">
                      {{ $n(data.item.application_id, { useGrouping: false }) }}
                    </template>
                    <template v-slot:cell(note)="data">
                      <span class="sub_string" :title="$i18n.locale === 'bn' ? data.item.app_forwards[0].note_bn : data.item.app_forwards[0].note_en" v-if="data.item.app_forwards.length > 0">{{ $i18n.locale === 'bn' ? data.item.app_forwards[0].note_bn : data.item.app_forwards[0].note_en }}</span>
                    </template>
                    <template v-slot:cell(type)="data">
                      <span class="badge pay-status badge-success w-100 text-white font-weight-bold" v-if="data.item.type === 2">
                        {{ $t('globalTrans.renew') }}
                      </span>
                      <span class="badge pay-status badge-primary w-100 text-white font-weight-bold" v-if="data.item.type === 1">
                        {{ $t('globalTrans.new') }}
                      </span>
                    </template>
                    <template v-slot:cell(status)="data">
                      {{ getStepName(data.item.current_step) + ' ' + ServiceLastStepCheck(data.item.service_id, data.item.current_step, data.item.status, data.item.generate_id, data.item.doc_verified) }}
                    </template>
                    <template v-slot:cell(action)="data">
                      <span v-if="Object.keys(actions(data.item.service_id)).length">
                        <span v-if="JSON.parse(actions(data.item.service_id).actions).length">
                          <router-link v-if="data.item.save_status === 1" :to="`${getBtn(1).url}?application_id=${data.item.application_id}&step_id=${step.value}&org_id=${data.item.org_id}&service_id=${data.item.service_id}`" :title="getBtn(1).text" :class="`btn btn-sm `+ getBtn(1).color" size="sm"><i :class="getBtn(1).icon"></i></router-link>
                          <span v-else>
                              <span v-for="(btn, index) in JSON.parse(actions(data.item.service_id).actions)" :key="index">
                                <span v-if="btn === 1 || btn === 3 || btn === 4 || btn === 5 || btn === 6 || btn === 7 || btn === 9 || btn === 10 || btn === 11 || btn === 12 || btn === 13 || btn === 14 || btn === 15 || btn === 16 || btn === 17 || btn === 18 || btn === 20 || btn === 21 || btn === 22">
                                  <!-- Verify Button -->
                                  <button style='margin-left: 4px' type="button" v-if="btn === 6  && data.item.doc_verified !== 1 && data.item.status !== 2 && data.item.status !== 8" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 6)"><i :class="getBtn(btn).icon"></i></button>
                                  <!-- License Forward -->
                                  <span v-if="checkSendAvailable(data.item, data.item.service_id) && btn === 3">
                                    <router-link v-if="btn === 3 && data.item.status !== 8" :to="{ name: 'forward', params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                                  </span>
                                  <!-- License Approve -->
                                  <template v-if="checkSummaryReport === 0">
                                    <router-link v-if="btn === 4 && data.item.status !== 1 && data.item.status !== 2" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                                  </template>
                                  <template v-if="checkSummaryReport === 1">
                                    <b-button v-if="btn === 4 && data.item.status !== 1 && data.item.status !== 2" class="btn btn-primary m-1" :title="getBtn(btn).text" v-b-modal.modal-9 size="sm"  @click="previewData(data.item, step.value)"><i :class="getBtn(btn).icon" ></i></b-button>
                                  </template>
                                  <!-- License Reject -->
                                  <router-link v-if="btn === 7 && data.item.status !== 2 && data.item.status !== 1" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 2)"><i :class="getBtn(btn).icon"></i></span></router-link>
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
                                    <router-link v-if="btn === 11" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                                  </template>
                                  <!-- License Issue -->
                                    <button style='margin-left: 4px' type="button" v-if="(btn === 12 && data.item.status === 1 && data.item.expire_date === null) || (btn === 12 && data.item.type === 2 && data.item.status === 1)" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 12)"><i :class="getBtn(btn).icon"></i></button>
                                  <!-- Receieve Sample -->
                                  <template>
                                    <button style='margin-left: 4px' type="button" v-if="btn === 18 && !data.item.sample_number" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 18)"><i :class="getBtn(btn).icon"></i></button>
                                  </template>
                                  <!-- License View -->
                                  <template v-if="data.item.generate_id !== null">
                                    <router-link v-if="btn === 5" :to="{ name: getBtn(btn).url, params: { stepChange }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link>
                                  </template>
                                  <!-- Preview -->
                                  <template v-if="btn === 13">
                                    <b-button class="btn btn-primary m-1" title="Preview" v-b-modal.modal-5 size="sm"  @click="previewData(data.item, step.value)"><i :class="getBtn(btn).icon" ></i></b-button>
                                  </template>

                                  <!-- Approve and Issue -->
                                  <template v-if="btn === 14 && data.item.status !== 1 && data.item.status !== 2">
                                    <b-button class="mr-1" title="Approve & Issue" v-b-modal.modal-7 variant=" iq-bg-success" size="sm"  @click="previewData(data.item, step.value)"><i class="ri-mail-check-fill m-0 "></i></b-button>
                                  </template>

                                  <!-- Publish -->
                                  <template>
                                    <button style='margin-left: 4px' type="button" v-if="btn === 16" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm" @click="commonStatusChange(data.item, 16)"><i :class="getBtn(btn).icon"></i></button>
                                  </template>

                                  <!-- Publish with Doc-->
                                  <template v-if="btn === 15">
                                    <b-button class="mr-1" :title="getBtn(btn).text" v-b-modal.modal-6 variant=" iq-bg-success" size="sm"  @click="previewData(data.item, step.value)" v-if="data.item.attachment === null"><i :class="getBtn(btn).icon"></i></b-button>
                                  </template>

                                  <!-- Document Download -->
                                  <a target = '_blank' :href="licenseRegistrationServiceBaseUrl + 'uploads/lrcpn/' + data.item.attachment" download v-if="data.item.attachment !== null && btn === 17"><i :class="getBtn(btn).icon"></i></a>
                                  <!-- Preview -->
                                  <template v-if="btn === 20">
                                    <b-button class="m-1" :title="getBtn(btn).text" v-b-modal.modal-8 variant=" iq-bg-secondary" size="sm"  @click="previewData(data.item, step.value)"><i :class="getBtn(btn).icon" ></i></b-button>
                                  </template>
                                  <!-- Send To Nothi -->
                                  <template v-if="btn === 21 && data.item.status !== 8 && $store.state.Auth.authUser.ssoLogin">
                                    <b-button :title="getBtn(btn).text" style="font-size: 12px !important; margin-top:10px" variant="btn btn-xs btn-success" size="sm" @click="nothiData(data.item)" ><i class="fa fa-forward"></i></b-button>
                                  </template>

                                  <!-- archive -->
                                  <template v-if="btn === 22">
                                    <b-button class="m-1" :title="getBtn(btn).text" variant=" iq-bg-primary" size="sm"  @click="commonStatusChange(data.item, 22)"><i :class="getBtn(btn).icon" ></i></b-button>
                                  </template>
                                </span>
                                <!-- dynamic buttons Custom Form-->
                                <span v-else>
                                  <span @click="SetStep(data.item, 1)"><router-link :to="{ name: getBtn(btn).url, params: { stepChange, nothiview }}" :title="getBtn(btn).text" :class="`btn btn-sm `+ getBtn(btn).color" size="sm"><span @click="SetStep(data.item, 1)"><i :class="getBtn(btn).icon"></i></span></router-link></span>
                                </span>
                              </span>
                          </span>
                        </span>
                        <span v-if="actions(data.item.service_id).is_custom_action">
                          <span v-for="(btn, index) in JSON.parse(actions(data.item.service_id).custom_actions)" :key="'custom'+index">
                            <router-link v-if="data.item.is_action_submitted === 1 && data.item.status !== 7" :to="`/license-registration-service/license-step/action-form?application_id=${data.item.application_id}&step_id=${step.value}&service_id=${data.item.service_id}&form_id=${btn.form_id}&org_id=${data.item.org_id}`" class="btn btn-sm btn-success" size="sm">{{ $i18n.locale === 'bn' ? btn.btn_bn : btn.btn_en }}</router-link>
                          </span>
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
                <b-col md="12" class="table-responsive" v-if="sendList">
                  <b-table :select-mode="selectMode" ref="selectableTable" selectable @row-selected="onRowSelected" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="sendColumns" aria-hidden="loading | listReload ? 'true' : null">
                    <template v-slot:cell(selected)="{ rowSelected }">
                      <template v-if="rowSelected">
                        <span class="ml-4" aria-hidden="true">&check;</span>
                      </template>
                      <template v-else>
                        <span class="ml-4" aria-hidden="true">&#x25a2;</span>
                      </template>
                    </template>
                    <template v-slot:cell(index)="data">
                      {{ $n(data.index + pagination.slOffset) }}
                    </template>
                    <template v-slot:cell(service_id)="data">
                      {{ getStoreData('LicenseRegistrationService', 'serviceNamesList', data.item.service_id) }}
                    </template>
                    <template v-slot:cell(application_id)="data">
                      {{ $n(data.item.application_id, { useGrouping: false }) }}
                    </template>
                    <template v-slot:cell(action)="data">
                      <!-- Return Application -->
                      <button style='margin-left: 4px' type="button" :title="$t('li_step.return_application')" class="btn btn-sm btn-info" size="sm" @click="commonStatusChange(data.item, 19)"><i class="fa fa-undo"></i></button>
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
        </body-card>
      </b-col>
    </b-row>
    <b-modal id="modal-5" size="xl" :title="$t('globalTrans.preview')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DocumentPreview :pDatas="pData" :stepID="stepID" :key="dtlsItemId"></DocumentPreview>
    </b-modal>
    <b-modal id="modal-6" size="lg" :title="$t('globalTrans.publish')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Publish :pDatas="pData.application_id" :stepID="stepID" :key="dtlsItemId"></Publish>
    </b-modal>
    <b-modal id="modal-7" size="xl" :title="$t('component_settings.approve_issue')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ApproveIssue :pDatas="pData" :stepID="stepID" :key="dtlsItemId"></ApproveIssue>
    </b-modal>
    <b-modal id="modal-8" size="xl" :title="$t('li_step.lab_report')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <LabReport :pDatas="pData" :stepID="stepID" :key="dtlsItemId"></LabReport>
    </b-modal>
    <b-modal id="modal-9" size="xl" :title="$t('globalTrans.preview')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DocumentReportApprove :pDatas="pData" :stepID="stepID" :key="dtlsItemId"></DocumentReportApprove>
    </b-modal>
    <b-modal id="modal-10" size="xl" :title="$t('globalTrans.preview')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <EditableData :pDatas="pData" :stepID="stepID" :key="dtlsItemId"></EditableData>
    </b-modal>
    <div style ="visibility: hidden;" id="myP" v-if="isShowModel" >
      <DetailsMain :stepChange="stepChange" :nothiSend="nothiSend" :key="nothiKey"></DetailsMain>
    </div>
  </b-container>
</template>
<script>
import Search from '../../components/search'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepDataList, stepSendDataList, changeLogStore, licenseCancel, licenseWithdraw, licenseArchive, licenseIssue, servicePublish, returnForward } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import common from '@/mixins/common'
import DocumentPreview from './DocumentPreview'
import DetailsMain from './DetailsMain'
import DocumentReportApprove from './DocumentReportApprove'
import ApproveIssue from './ApproveIssue'
import Publish from './Publish'
import LabReport from './LabReport'

export default {
  mixins: [ModalBaseMasterList, common],
  props: ['menuId'],
  components: {
    Search,
    DocumentPreview,
    Publish,
    ApproveIssue,
    LabReport,
    DocumentReportApprove,
    DetailsMain
  },
  data () {
    return {
      nothiview: 0,
      nothiKey: 1,
      listLoading: false,
      componentKey: 0,
      stepChange: {
        application_id: [],
        step_id: 0,
        service_id: 0,
        org_id: 0,
        status: 1
      },
      search: {},
      columns: [],
      allData: {},
      menuInfo: [],
      isAddBtn: false,
      isAppPayment: 0,
      payReceipt: {},
      pData: '',
      dtlsItemId: '',
      stepID: '',
      gridLangData: '',
      commonGrid: false,
      selected: [],
      selectMode: 'multi',
      applicationIds: [],
      allselect: false,
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      listGetData: '',
      gridData: false,
      sendList: false,
      nothiSend: 0,
      sendColumns: [
        { label: this.$t('globalTrans.select'), class: 'text-left', key: 'selected' },
        { label: this.$t('globalTrans.sl_no'), class: 'text-left', key: 'index' },
        { label: this.$t('infoServiceManagement.service_name'), class: 'text-left', key: 'service_id' },
        { label: this.$t('globalTrans.application_id'), class: 'text-left', key: 'application_id' },
        { label: this.$t('globalTrans.action'), class: 'text-left', key: 'action' }
      ],
      checkSummaryReport: '',
      isShowModel: false
    }
  },
  created () {
      this.setCommonGrid()
      this.checkSingleService()
  },
  computed: {
    auth () {
      return this.$store.state.Auth
    },
    formTitle () {
       return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
    },
    menuInfoList () {
      const menuId = this.menuId
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
    },
    local: function () {
        return this.$i18n.locale
    }
  },
  watch: {
    laodList: function (n, o) {
      if (n !== o) {
        this.loadData()
      }
    },
    local: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.getLanguateWisedata()
          this.componentKey = this.componentKey + 1
      }
    },
    menuId: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
        this.setCommonGrid()
        this.checkSingleService()
      }
    }
  },
  methods: {
    checkSendAvailable (item, serviceId) {
      const actions = JSON.parse(this.actions(serviceId).actions)
      if (actions.includes(3) && actions.includes(6) && item.doc_verified === 1) {
        return true
      } else if (actions.includes(3) && actions.includes(4) && item.status === 1 && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(12) && item.generate_id !== null && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(14) && item.generate_id !== null && item.status !== 7) {
        return true
      } else if (actions.includes(3) && actions.includes(2) && actions.length < 3 && item.status !== 7) {
        return true
      } else {
        return false
      }
    },
    rowClass (item, type) {
      if (!item || type !== 'row') return
      if (item.status === 7) return 'table-danger'
    },
    getSendList () {
      this.sendList = true
      const params = {
        step_id: this.step.value,
        sender_id: this.$store.state.Auth.authUser.user_id,
        service_id: this.menuInfoList.details[0].service_id
      }
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepSendDataList, params).then(response => {
        if (response.success) {
          this.$store.dispatch('setList', response.data.data)
          this.paginationData(response.data)
        }
        this.listLoading = false
      })
    },
    onRowSelected (items) {
      this.selected = items
      this.applicationIds = []
      items.forEach(item => {
        const applicationId = item.application_id
        this.applicationIds.push(applicationId)
      })
    },
    selectAllRows () {
      if (this.allselect) {
        this.$refs.selectableTable.clearSelected()
        this.applicationIds = []
        this.allselect = false
      } else {
        this.$refs.selectableTable.selectAllRows()
        this.allselect = true
      }
    },
    SetStep (item, status) {
      this.stepChange.application_id[0] = item.application_id
      this.stepChange.step_id = this.step.value
      this.stepChange.service_id = item.service_id
      this.stepChange.org_id = item.org_id
      this.stepChange.status = status
    },
    nothiData (item) {
      this.stepChange.application_id[0] = item.application_id
      this.stepChange.step_id = this.step.value
      this.stepChange.service_id = item.service_id
      this.stepChange.org_id = item.org_id
      this.stepChange.status = 8
      let msztitle = ''
      msztitle = this.$t('globalTrans.tranferToNothi')
      window.vm.$swal({
        title: msztitle,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.nothiKey = this.nothiKey + 1
          this.isShowModel = true
          this.nothiSend = 1
        }
      })
    },
    SetMultiApplicantStep (status) {
      this.stepChange.application_id = this.applicationIds
      this.stepChange.step_id = this.step.value
      this.stepChange.service_id = this.selected[0].service_id
      this.stepChange.org_id = this.selected[0].org_id
      this.stepChange.status = status
    },
    previewData (item, stepId) {
      this.pData = item
      this.stepID = stepId
      this.dtlsItemId = item.id
    },
    getLanguateWisedata () {
      if (this.commonGrid === true) {
        this.setCommonGrid()
      } else {
        this.setGridData(this.gridLangData)
      }
    },
    setupReceipt (data) {
      this.payReceipt =
      {
        application_id: data.application_id,
        service_id: data.service_id
      }
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
      return step !== undefined ? step.text : ''
    },
    actions (serviceId) {
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      if (typeof actions === 'undefined') {
        return {}
      } else {
        return actions
      }
    },
    CheckForward (serviceId, buttonId) {
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      if (typeof actions === 'undefined') {
        return 'false'
      } else {
        return 'true'
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
      this.sendList = false
      const params = Object.assign({}, this.search, {
        page: this.pagination.currentPage,
        per_page: this.pagination.perPage,
        step_id: this.step.value,
        service_ids: this.serviceIds,
        is_forward: this.menuInfoList.is_forward,
        user_type: this.$store.state.Auth.authUser.user_type,
        is_org_admin: this.$store.state.Auth.authUser.is_org_admin,
        office_id: this.$store.state.Auth.authUser.office_id,
        is_payment: this.isAppPayment
      })
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepDataList, params).then(response => {
        if (response.success) {
          this.listGetData = response.data.data
          if (this.gridData === true) {
            this.gridLangData.forEach(item => {
              if (item.fieldType === 'number') {
                this.listGetData.forEach(listitem => {
                  const value = this.$n(listitem[item.fieldName], { useGrouping: false })
                  listitem[item.fieldName] = value
                })
              } else if (item.fieldType === 'dropdown') {
                if (item.drpComponent === '1') {
                  this.listGetData.forEach(listitem => {
                    const drpvalue = this.getCommonStoreData(item.drpName, listitem[item.fieldName])
                    listitem[item.fieldName] = drpvalue
                  })
                }
              }
            })
          }
          this.$store.dispatch('setList', response.data.data)
          this.paginationData(response.data)
        }
        this.checkSummaryReport = this.summaryReportShow()
        this.listLoading = false
      })
    },
    getSearchData (res) {
      if (res.type === 2) {
        this.allData = res.data
        this.search = res.searchData
        if (res.data.success) {
          if (res.data.grid_field.length) {
            const dynamicGrid = res.data.grid_field.map(item => {
              const tmpData = JSON.parse(item.data)
              if (tmpData.field_type === 'dropdown') {
                const componentId = tmpData.dropdownData.component_id
                const dropdownName = tmpData.dropdownData.dropdown_name
                return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '', fieldType: tmpData.field_type, fieldName: tmpData.field_name, drpComponent: componentId, drpName: dropdownName }
              } else {
                return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '', fieldType: tmpData.field_type, fieldName: tmpData.field_name }
              }
            })
            this.gridLangData = dynamicGrid
            this.gridData = true
            this.commonGrid = false
            this.setGridData(dynamicGrid)
          } else {
            this.commonGrid = true
            this.gridData = false
          }
        } else {
          this.commonGrid = true
          this.gridData = false
          this.setCommonGrid()
        }
      } else {
        this.commonGrid = true
        this.search = res.data
        this.gridData = false
      }
      this.loadData()
    },
    setGridData (data) {
      const newArray = data.map(item => {
        if ((this.local === 'en' && item.langType === 'en') || (this.local === 'en' && item.langType === '')) {
          return { label: item.text_en, class: 'text-left', key: item.value }
        } else if (this.local === 'bn' && item.langType === 'en' && item.fieldType === 'number') {
          return { label: item.text_bn, class: 'text-left', key: item.value }
        } else if ((this.local === 'bn' && item.langType === 'bn') || (this.local === 'bn' && item.langType === '') || (this.local === 'bn' && item.langType === 'en' && item.field_type === 'number')) {
          return { label: item.text_bn, class: 'text-left', key: item.value }
        }
      })
      this.columns = newArray
      this.setSlAction(1)
    },
    setCommonGrid () {
      this.columns = JSON.parse(this.step.common_grid).map(item => {
        if (this.local === 'en') {
          return { label: item.text_en, class: 'text-left', key: item.value }
        } else {
          return { label: item.text_bn, class: 'text-left', key: item.value }
        }
      })
      this.setSlAction(2)
    },
    setSlAction (type) {
      this.columns = [
          { label: this.$t('globalTrans.select'), class: 'text-left', key: 'selected' },
          { label: this.$t('globalTrans.sl_no'), class: 'text-left', key: 'index' },
          { label: this.$t('globalTrans.application_id'), class: 'text-left', key: 'application_id' }
        ].concat(this.columns)
        const checkSample = this.checkSampleAvailable()
        if (checkSample) {
          this.columns.push({ label: this.$t('li_step.sample_number'), class: 'text-left', key: 'sample_number' })
        }
      this.columns.push({ label: this.$t('budget.note'), class: 'text-left', key: 'note' })
      this.columns.push({ label: this.$t('externalLrcpn.type'), class: 'text-left', key: 'type' })
      if (type === 1) {
        this.columns.push({ label: this.$t('globalTrans.status'), class: 'text-left', key: 'status' })
      }
      this.columns.push({ label: this.$t('globalTrans.action'), class: 'text-left', key: 'action' })
    },
    checkSingleService () {
      if (this.menuInfoList.details.length === 1) {
        const serviceId = this.menuInfoList.details[0].service_id
        const isFee = this.paymentCheck(serviceId)
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
    checkLabPayment (serviceId, currentStep) {
      const tmp = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => item.step_id === currentStep && item.service_id === serviceId && item.lab_fee === 1)
      return typeof tmp === 'undefined' ? 0 : 1
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
        if (data.length === undefined) {
          this.stepChange.step_id = data.current_step
          this.stepChange.application_id[0] = data.application_id
          this.stepChange.service_id = data.service_id
          this.stepChange.org_id = data.org_id
        } else {
          this.stepChange.step_id = this.step.value
          this.stepChange.application_id = data
          this.stepChange.service_id = this.selected[0].service_id
          this.stepChange.org_id = this.selected[0].org_id
        }
        msztitle = this.$t('globalTrans.verifyMsg')
        Api = changeLogStore
        message = 'Document Verified Successfully'
      }
      if (buttonID === 9) {
        if (data.length === undefined) {
          this.stepChange.step_id = data.current_step
          this.stepChange.application_id[0] = data.application_id
          this.stepChange.service_id = data.service_id
          this.stepChange.org_id = data.org_id
        } else {
          this.stepChange.step_id = this.step.value
          this.stepChange.application_id = data
          this.stepChange.service_id = this.selected[0].service_id
          this.stepChange.org_id = this.selected[0].org_id
          msztitle = this.$t('globalTrans.cancelMsg')
          Api = licenseCancel
          message = 'License Cancel Successfully'
        }
      }
      if (buttonID === 10) {
        this.stepChange.step_id = data.step_id
        this.stepChange.application_id = data.application_id
        this.stepChange.service_id = data.service_id
        this.stepChange.org_id = data.org_id
        msztitle = this.$t('globalTrans.withdrawMsg')
        Api = licenseWithdraw
        message = 'License Withdraw Successfully'
      }
      if (buttonID === 12) {
        if (data.length === undefined) {
          this.stepChange.step_id = data.current_step
          this.stepChange.application_id[0] = data.application_id
          this.stepChange.service_id = data.service_id
          this.stepChange.org_id = data.org_id
        } else {
          this.stepChange.step_id = this.step.value
          this.stepChange.application_id = data
          this.stepChange.old_application_id = []
          this.stepChange.service_id = this.selected[0].service_id
          this.stepChange.org_id = this.selected[0].org_id
        }
        msztitle = this.$t('globalTrans.issueMsg')
        Api = licenseIssue
        message = 'License Issue Successfully'
      }
      if (buttonID === 16) {
        this.stepChange.step_id = data.current_step
        this.stepChange.old_application_id = data.old_application_id ? data.old_application_id : 0
        this.stepChange.application_id = data.application_id
        this.stepChange.service_id = data.service_id
        this.stepChange.org_id = data.org_id
        msztitle = this.$t('globalTrans.publishMsq')
        Api = servicePublish
        message = 'License Published Successfully'
      }
      if (buttonID === 18) {
        this.stepChange.step_id = data.current_step
        this.stepChange.application_id = data.application_id
        this.stepChange.service_id = data.service_id
        this.stepChange.org_id = data.org_id
        msztitle = this.$t('li_step.messageSample')
        Api = '/step/sample-number-store'
        message = 'Sample number assign  successfully.'
      }
      if (buttonID === 19) {
        if (data.length === undefined) {
          this.stepChange.application_id[0] = data.application_id
          this.stepChange.org_id = data.org_id
          this.stepChange.step_id = data.step_id
          this.stepChange.service_id = data.service_id
        } else {
          this.stepChange.step_id = this.step.value
          this.stepChange.application_id = data
          this.stepChange.old_application_id = []
          this.stepChange.service_id = this.selected[0].service_id
          this.stepChange.org_id = this.selected[0].org_id
        }
        msztitle = this.$t('li_step.return_application')
        Api = returnForward
        message = 'Application Returned Successfully'
      }
      if (buttonID === 22) {
        if (data.length === undefined) {
          this.stepChange.application_id[0] = data.application_id
          this.stepChange.org_id = data.org_id
          this.stepChange.step_id = data.step_id
          this.stepChange.service_id = data.service_id
        } else {
          this.stepChange.step_id = this.step.value
          this.stepChange.application_id = data
          this.stepChange.old_application_id = []
          this.stepChange.service_id = this.selected[0].service_id
          this.stepChange.org_id = this.selected[0].org_id
        }
        msztitle = this.$t('li_step.archive_message')
        Api = licenseArchive
        message = 'Application Archived Successfully'
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
          RestApi.getData(licenseRegistrationServiceBaseUrl, Api, this.stepChange).then(res => {
            this.listLoading = false
            if (res.success === true) {
              this.$store.dispatch('LicenseRegistrationService/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
              this.$toast.success({
                title: 'Success',
                message: message,
                color: '#D6E09B'
              })
              if (this.sendList === true) {
                this.getSendList()
              } else {
                this.$store.dispatch('LicenseRegistrationService/setLaodList', true)
              }
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
    paymentCheck (serviceId) {
      const steps = this.$store.state.LicenseRegistrationService.commonObj.stepFeeList.find(item => item.service_id === serviceId && item.step_id === this.step.value && item.fee_id !== 0)
      const stepFee = typeof steps !== 'undefined' ? steps : { fee_id: '' }
      const otherPay = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      const otherFee = typeof otherPay !== 'undefined' ? otherPay : { checkbox_payment: false, field_payment: false }
      if (stepFee.fee_id || (otherFee.checkbox_payment !== null) || (otherFee.field_payment !== null) || this.checkLabPayment(serviceId, this.step.value)) {
        return true
      } else {
        return false
      }
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.step.value))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
    },
    ServiceLastStepCheck (serviceId, stepId, status, generateId, docVerify) {
      // const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
      // const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(stepId))
      // const order = tmpIndVStepList.order
      // const orderCheck = tmpStepList.find(item => item.order === order + 1)
      const actions = JSON.parse(this.actions(serviceId).actions)
      if (status === 0 && !docVerify) {
        return this.$t('globalTrans.processing')
      } else if (status === 2) {
        return this.$t('globalTrans.rejected')
      } else if (status === 7) {
        return this.$t('externalLrcpn.application_resubmit')
      } else if (status === 8) {
        return this.$t('externalLrcpn.transfered_to_nothi')
      } else if (actions.includes(4)) {
        if (status === 1) {
          return this.$t('globalTrans.completed')
        } else {
          return this.$t('globalTrans.processing')
        }
      } else if (actions.includes(6)) {
        if (docVerify === 1) {
          return this.$t('globalTrans.completed')
        } else {
          return this.$t('globalTrans.processing')
        }
      } else if (actions.includes(12)) {
        if (generateId) {
          return this.$t('globalTrans.completed')
        } else {
          return this.$t('globalTrans.processing')
        }
      } else if (actions.includes(14)) {
        if (generateId && status === 1) {
          return this.$t('globalTrans.completed')
        } else {
          return this.$t('globalTrans.processing')
        }
      } else {
        return this.$t('globalTrans.completed')
      }
    },
    checkSampleAvailable () {
      let buttonFind = false
      const serviceId = this.menuInfoList.details[0].service_id
      const actions = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      if (typeof actions !== 'undefined') {
        const actionButtons = JSON.parse(actions.actions)
        actionButtons.forEach(item => {
          if (item === 18) {
            buttonFind = true
          }
        })
      }
      return buttonFind
    },
    summaryReportShow () {
      const serviceId = this.menuInfoList.details[0].service_id
      const stepData = this.$store.state.LicenseRegistrationService.commonObj.seviceStepWiseButtonList.find(item => item.step_id === this.step.value && item.service_id === serviceId)
      return parseInt(stepData.is_summary_report_show)
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
  .btn_application {
    background: #228B22 !important;
    border-color: #1d7c1d !important;
  }
  .sub_string{
    width: 90px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    overflow: hidden;
  }
</style>
