<template>
  <div class="section-wrapper bfti-dashboard-wrapper">
    <breadcumb />
    <!-- <b-card class="mt-3" :title="$t('dashboard.welcome_bfti_dashboard')">
    </b-card> -->
    <div class="form-wrapper">
      <div class="mb-4" v-if="$store.state.Auth.activeRoleId === 1 || $store.state.Auth.authUser.org_admin === 2">
        <h5 class="title">{{ $t('externalUser.research_and_other_request') }} {{ $t('globalTrans.info') }}</h5>
        <b-overlay :show="loading" class="px-3">
          <b-form inline class="mt-3 mb-4">
            <label class="mr-sm-2" for="inline-form-custom-select-pref">{{ $t('configuration.document_type') }}</label>
            <b-form-select id="input-3" v-model="form.document_type_id" :options="docTypeList" required></b-form-select>
          </b-form>
          <b-row>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#77a0cb" fill-opacity="1"
                    d="M0,224L48,186.7C96,149,192,75,288,80C384,85,480,171,576,202.7C672,235,768,213,864,218.7C960,224,1056,256,1152,234.7C1248,213,1344,139,1392,101.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-file-copy-2-fill" style="color: #77a0cb"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #77a0cb"> {{ $n(DocApproved + DocPending + DocRejected) }}</h3>
                  <p>{{$t('dashboard.document') }} {{ $t('globalTrans.request') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#40af6c" fill-opacity="1"
                    d="M0,160L48,144C96,128,192,96,288,117.3C384,139,480,213,576,202.7C672,192,768,96,864,74.7C960,53,1056,107,1152,144C1248,181,1344,203,1392,213.3L1440,224L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-shield-check-fill" style="color: #40af6c"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #40af6c"> {{ $n(DocApproved) }} </h3>
                  <p>{{ $t('globalTrans.approved') }} {{$t('dashboard.document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#F2351A" fill-opacity="1"
                    d="M0,256L48,229.3C96,203,192,149,288,149.3C384,149,480,203,576,197.3C672,192,768,128,864,133.3C960,139,1056,213,1152,224C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-close-circle-fill" style="color: #F2351A"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #F2351A"> {{ $n(DocRejected) }} </h3>
                  <p>{{ $t('globalTrans.rejected') }} {{$t('dashboard.document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#F2B03E" fill-opacity="1"
                    d="M0,0L48,48C96,96,192,192,288,208C384,224,480,160,576,112C672,64,768,32,864,58.7C960,85,1056,171,1152,202.7C1248,235,1344,213,1392,202.7L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <!-- <i class="ri-time-fill"></i> -->
                  <i class="ri-history-line" style="color: #F2B03E"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #F2B03E"> {{ $n(DocPending) }} </h3>
                  <p>{{ $t('globalTrans.pending') }} {{$t('dashboard.document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#02acaf" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-refresh-fill" style="color: #02acaf"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #02acaf"> {{ $n(researchDocOngoing) }} </h3>
                  <p>{{ $t('globalTrans.ongoing') }} {{$t('dashboard.document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#9C4FE8" fill-opacity="1"
                    d="M0,288L48,245.3C96,203,192,117,288,106.7C384,96,480,160,576,176C672,192,768,160,864,128C960,96,1056,64,1152,90.7C1248,117,1344,203,1392,245.3L1440,288L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-shield-star-fill" style="color: #9C4FE8"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #9C4FE8"> {{ $n(researchDocDone) }} </h3>
                  <p>{{ $t('globalTrans.done') }} {{$t('dashboard.document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#3BAFDA" fill-opacity="1"
                    d="M0,224L48,186.7C96,149,192,75,288,80C384,85,480,171,576,202.7C672,235,768,213,864,218.7C960,224,1056,256,1152,234.7C1248,213,1344,139,1392,101.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon">
                  <i class="ri-award-fill" style="color: #3BAFDA"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #3BAFDA">{{ $n(award) }}</h3>
                  <p>{{$t('dashboard.awarded_document') }}</p>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="#556e89" fill-opacity="1"
                    d="M0,160L48,144C96,128,192,96,288,117.3C384,139,480,213,576,202.7C672,192,768,96,864,74.7C960,53,1056,107,1152,144C1248,181,1344,203,1392,213.3L1440,224L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="icon non-awarded">
                  <i class="ri-award-line" style="color: #556e89"></i>
                </div>
                <div class="doc">
                  <h3 class="count" style="color: #556e89">{{ $n(nonAward) }}</h3>
                  <p>{{$t('dashboard.no_awarded_document') }}</p>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-overlay>
      </div>
      <div class="mb-4">
        <h5 class="title">{{ $t('dashboard.employee_research_info') }}</h5>
        <b-overlay :show="loading2" class="px-3">
          <b-form inline class="mt-3 mb-4">
            <label class="mr-sm-2" for="inline-form-custom-select-pref">{{ $t('configuration.document_type') }}</label>
            <b-form-select id="input-3" v-model="form2.document_type_id" :options="docTypeList" required></b-form-select>
          </b-form>
          <b-row>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-pen-nib-fill"></i>
                  <p> {{$t('task_activity_monitoring.task') }} {{ $t('task_activity_monitoring.assignd') }} </p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(taskTotOngoing + taskTotPending + taskTotDone) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-airplay-fill"></i>
                  <p> {{$t('task_activity_monitoring.task') }} {{ $t('task_activity_monitoring.start') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(taskTotOngoing) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-history-line"></i>
                  <p> {{$t('task_activity_monitoring.task') }} {{ $t('globalTrans.pending') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(taskTotPending) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-shield-star-fill"></i>
                  <p> {{$t('task_activity_monitoring.task') }} {{ $t('globalTrans.done') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(taskTotDone) }} </h3>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-overlay>
      </div>
      <div class="mb-4">
        <h5 class="title">{{ $t('dashboard.documents_workload_info_task_coordinators') }}</h5>
        <b-overlay :show="loading" class="px-3">
          <b-form inline class="mt-3 mb-4">
            <label class="mr-sm-2" for="inline-form-custom-select-pref">{{ $t('configuration.document_type') }}</label>
            <b-form-select id="input-3" v-model="form.document_type_id" :options="docTypeList" required></b-form-select>
          </b-form>
          <b-row>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item card-item-alt" style="background: #00b5b8;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h3 class="count">{{ $n(documentAssigned) }}</h3>
                  <p>{{ $t('dashboard.document_assigned') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-pen-nib-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item card-item-alt" style="background: #00c182;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h3 class="count"> {{ $n(start) }} </h3>
                  <p>{{ $t('dashboard.document_start') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-airplay-fill"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item card-item-alt" style="background: #f0ae4f;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 80%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h3 class="count" style="color: #15273b;"> {{ $n(pending) }} </h3>
                  <p style="color: #15273b;">{{ $t('dashboard.document_pending') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-history-line" style="color: #15273b;"></i>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3">
              <div class="card-item card-item-alt" style="background: #9c4fe8;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                  <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                  </path>
                </svg>
                <div class="doc text-left">
                  <h3 class="count"> {{ $n(done) }} </h3>
                  <p>{{ $t('dashboard.document_done') }}</p>
                </div>
                <div class="icon">
                  <i class="ri-shield-star-fill"></i>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-overlay>
      </div>
      <div class="mb-3" v-if="$store.state.Auth.activeRoleId === 1 || $store.state.Auth.authUser.org_admin === 2">
        <h5 class="title">{{ $t('policy_advocacy.policy_advocacy') }}</h5>
        <b-overlay :show="loading" class="px-3">
          <b-row>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-draft-line"></i>
                  <p>{{$t('policy_advocacy.policy_request') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(policyTotApproved + policyTotRejected + policyTotPending) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-checkbox-circle-fill"></i>
                  <p> {{ $t('globalTrans.approved') }} {{$t('policy_advocacy.policy') }} </p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(policyTotApproved) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top rejected">
                  <i class="ri-close-circle-fill"></i>
                  <p>{{ $t('globalTrans.rejected') }} {{$t('policy_advocacy.policy') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(policyTotRejected) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top pending">
                  <i class="ri-history-line"></i>
                  <p>{{ $t('globalTrans.pending') }} {{$t('policy_advocacy.policy') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(policyTotPending) }} </h3>
                </div>
              </div>
            </b-col>
            <b-col sm="6" md="6" lg="3" class="card-item-squ-col">
              <div class="card-item-squ">
                <div class="card-top">
                  <i class="ri-checkbox-fill"></i>
                  <p>{{$t('policy_advocacy.policy') }} {{ $t('globalTrans.review') }}</p>
                </div>
                <div class="card-bottom">
                  <h3> {{ $n(policyTotreview) }} </h3>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-overlay>
      </div>
    </div>
    <div class="meeting-notice-section">
      <b-row>
        <b-col>
          <h5 class="title">{{ $t('meetingManagement.meeting') }} {{ $t('meetingManagement.notice') }}</h5>
          <b-overlay :show="loading2" class="px-3">
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                  <tr>
                    <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                    <th scope="col">{{ $t('meetingManagement.meeting') }} {{ $t('meetingManagement.notice') }}</th>
                    <th scope="col">{{$t('globalTrans.date')}}</th>
                    <th scope="col">{{ $t('globalTrans.action') }}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(item, index) in data.research_done.meeting" :key="index">
                    <td class="text-center" style="width: 10%">{{$n(index + 1) }}</td>
                    <td class="text-left" style="width: 85%">{{ currentLocale == 'bn' ? item.meeting_title_bn :
                    item.meeting_title_en }}</td>
                    <td class="text-left" style="width: 85%">{{ item.meeting_date | dateFormat }}</td>
                    <td class="text-left" style="width: 85%">
                      <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm"
                        @click="details(item)" class="action-btn status" :title="$t('globalTrans.view')"><i
                          class="ri-eye-fill"></i></b-button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </b-overlay>
        </b-col>
      </b-row>
    </div>
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')"
      ok-only ok-variant="danger">
      <Details :item="item" />
    </b-modal>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { taskActivityApi, documentInformationApi, meetingDetailApi } from '../../api/routes'
import Details from '../../../meeting-management/pages/receive-meeting-notice/Details'

export default {
  components: {
    Details
  },
  data () {
    return {
      // search: {
      //   document_type_id: 0
      // },
      loading: false,
      loading2: false,
      form: {
        document_type_id: 2,
        employee_user_id: 0
      },
      form2: {
        document_type_id: 2,
        employee_user_id: 0
      },
      data: {
        research_done: 0,
        research_pending: 0,
        research_ongoing: 0,
        policyStatusCount: 0,
        rfpStatusCount: 0,
        researchStatusCount: 0,
        statusCount: 0,
        eoiStatusCount: 0,
        statusCountp: 0,
        policy_review_done: 0,
        employee_user_id: 0,
        review_pending: 0
      },
      item: '',
      editItemId: 0,
      value: '',
      file1: null,
      valueNumber: 50,
      zero: 0,
      taskTotPending: 0,
      taskTotDone: 0,
      taskTotOngoing: 0,
      policyTotApproved: 0,
      policyTotPending: 0,
      policyTotreview: 0,
      researchDocDone: 0,
      researchDocPending: 0,
      researchDocOngoing: 0,
      policyTotRejected: 0,
      DocRejected: 0,
      DocPending: 0,
      DocApproved: 0,
      award: 0,
      documentAssigned: 0,
      start: 0,
      pending: 0,
      done: 0
    }
  },
  created () {
    // this.loadData()
  },
  watch: {
    'form.document_type_id': function (newValue) {
      this.loadData()
    },
    'form2.document_type_id': function (newValue) {
      this.loadData2()
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1 && this.$store.state.Auth.authUser.org_admin === 1) {
      this.form.employee_user_id = this.$store.state.Auth.authUser.user_id
      this.form2.employee_user_id = this.$store.state.Auth.authUser.user_id
    }
    this.loadData()
    this.loadData2()
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    detailsTitle () {
      return this.$t('meetingManagement.meeting') + ' ' + this.$t('globalTrans.details')
    }
  },
  methods: {
    getZero () {
      this.zero = 0
      return true
    },
    edit (item) {
      this.editItemId = item.id
    },
    // getDocTypeList (typeId) {
    //     const documentTypeList = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    //     if (typeId) {
    //         return documentTypeList.filter(item => item.document_type_id === typeId)
    //     }
    //     return documentTypeList
    // },
    searchData () {
      this.form = []
      // this.form2 = []
      this.loadData()
    },
    async loadData () {
      this.loading = true
      const params = Object.assign({}, this.search, this.form)

      const result = await RestApi.getData(bftiResReportServiceBaseUrl, documentInformationApi, params)
      if (result.success) {
        this.award = result.data.award
        this.nonAward = result.data.nonAward
        this.documentAssigned = result.data.documentAssigned
        this.start = result.data.start
        this.pending = result.data.pending
        this.done = result.data.done
        let policyTotApproved = 0
        let policyTotPending = 0
        let policyTotreview = 0
        let policyTotRejected = 0
        let researchDocDone = 0
        let researchDocPending = 0
        let researchDocOngoing = 0
        let DocRejected = 0
        let DocApproved = 0
        let DocPending = 0
        result.data.policy.forEach(element => {
          if (element.status === 2) {
            policyTotApproved += parseInt(element.policyStatusCount)
          }
          if (element.status === 1) {
            policyTotPending += parseInt(element.policyStatusCount)
          }
          if (element.status === 3) {
            policyTotRejected += parseInt(element.policyStatusCount)
          }
        })
        result.data.policy_review_done.forEach(element => {
          if (element.document_approve_status === 3) {
            policyTotreview += parseInt(element.policy_review_done)
          }
        })
        //   if (result.data.rfp) {
        //   result.data.rfp.forEach(element => {
        //     if (element.status === 1) {
        //         DocPending += parseInt(element.rfpStatusCount)
        //       }
        //     if (element.status === 4) {
        //       DocApproved += parseInt(element.rfpStatusCount)
        //     }
        //   })
        // }
        if (result.data.research) {
          result.data.research.forEach(element => {
            if (element.status === 3) {
              DocRejected += parseInt(element.researchStatusCount)
            }
            if (element.status === 2) {
              DocApproved += parseInt(element.researchStatusCount)
            }
            if (element.status === 1) {
              DocPending += parseInt(element.researchStatusCount)
            }
          })
        }
        //   if (result.data.eoi) {
        //    result.data.eoi.forEach(element => {
        //     // if (element.status === 1) {
        //     //     DocPending += parseInt(element.eoiStatusCount)
        //     //   }
        //     if (element.status === 4) {
        //       DocApproved += parseInt(element.eoiStatusCount)
        //     }
        //   })
        // }
        result.data.document_ongoing.forEach(element => {
          if (element.coordinator_assign === 2) {
            researchDocOngoing += parseInt(element.research_ongoing)
          }
        })
        result.data.document_done.forEach(element => {
          if (element.document_approve_status === 3) {
            researchDocDone += parseInt(element.research_done)
          }
        })
        result.data.document_pending.forEach(element => {
          if (element.document_approve_status === 1) {
            researchDocPending += parseInt(element.research_pending)
          }
        })
        this.policyTotApproved = policyTotApproved
        this.policyTotreview = policyTotreview
        this.policyTotPending = policyTotPending
        this.policyTotRejected = policyTotRejected
        this.DocRejected = DocRejected
        this.DocApproved = DocApproved
        this.DocPending = DocPending
        this.researchDocDone = researchDocDone
        this.researchDocPending = researchDocPending
        this.researchDocOngoing = researchDocOngoing

        this.data.policyStatusCount = result.data
        this.data.research_ongoing = result.data
        this.data.policyStatusCount = result.data
        this.data.researchStatusCount = result.data
        this.data.policy_review_done = result.data
        this.data.review_pending = result.data
        this.data.research_done = result.data
        this.data.rfpStatusCount = result.data
        this.data.research_pending = result.data
        this.data.eoiStatusCount = result.data
        this.loading = false
      } else {
        this.loading = false
      }
    },
    async loadData2 () {
      this.loading2 = true
      const params = Object.assign({}, this.search, this.form2)

      let result = await RestApi.getData(bftiResReportServiceBaseUrl, taskActivityApi, params)
      if (result.success) {
        let taskTotPending = 0
        let taskTotDone = 0
        let taskTotOngoing = 0
        result.data.task_activity.forEach(element => {
          if (element.status === 1) {
            taskTotPending += parseInt(element.statusCount)
          }
          if (element.status === 2) {
            taskTotOngoing += parseInt(element.statusCount)
          }
          if (element.status === 3) {
            taskTotDone += parseInt(element.statusCount)
          }
        })
        this.taskTotPending = taskTotPending
        this.taskTotOngoing = taskTotOngoing
        this.taskTotDone = taskTotDone

        this.data.statusCount = result.data
        this.loading2 = false
        // this.form.push(result.data)
      }
      result = await RestApi.getData(bftiResReportServiceBaseUrl, meetingDetailApi, params)
      if (result.success) {
        this.data.item = result.data
        // this.form.push(result.data)
        this.loading2 = false
      } else {
        this.loading2 = false
      }
    },
    details (item) {
      this.item = item
    }
  }
}
</script>
<style>
.bfti-title {
  color: #fff;
  padding: 5px 10px;
  border-radius: 5px;
  margin-bottom: 1rem;
  background: #214162;
}

.bfti-title p {
  font-size: 16px;
}

.research-info-section .info-card {
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  padding: 10px;
  word-wrap: break-word;
  background-clip: border-box;
  border: 1px solid;
  border-radius: 0.25rem;
}

.research-info-section .icd-1 {
  background-color: #9cffe3;
  border-color: #19d7a1;
}

.research-info-section .icd-2 {
  background-color: #9fc6ff;
  border-color: #2b7af1;
}

.research-info-section .icd-3 {
  background-color: #fdc3c9;
  border-color: #ff4356;
}

.research-info-section .icd-4 {
  background-color: #ffea98;
  border-color: #eccb48;
}

.research-info-section .icd-5 {
  background-color: #a4a4ff;
  border-color: #3636eb;
}

.research-info-section .icd-6 {
  background-color: #85e3ff;
  border-color: #19a8d3;
}

.research-info-section .info-card .info-value {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.research-info-section .info-card .info-value p {
  font-size: 18px;
}

.research-info-section .info-card .info-value .icon {
  width: 40px;
  height: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  color: #fff;
}

.research-info-section .icd-1 .icon {
  background-color: #19d7a1;
}

.research-info-section .icd-2 .icon {
  background-color: #2a77eb;
}

.research-info-section .icd-3 .icon {
  background-color: #e74051;
}

.research-info-section .icd-4 .icon {
  background-color: #dfbd37;
}

.research-info-section .icd-5 .icon {
  background-color: #2a2aeb;
}

.research-info-section .icd-6 .icon {
  background-color: #02a9dc;
}

.research-info-section .info-card .info-value .icon i {
  font-size: xx-large;
  line-height: initial;
}

/* *** emploeyy-info-section *** */
.emploeyy-info-section .info-card {
  color: #fff;
  padding: 8px;
  border-radius: 5px;
}

.emploeyy-info-section .info-card.icd-1 {
  background: #6495ed;
}

.emploeyy-info-section .info-card.icd-2 {
  background: #8351e7;
}

.emploeyy-info-section .info-card.icd-3 {
  background: #ed6464;
}

.emploeyy-info-section .info-card.icd-4 {
  background: #2bb555;
}

.emploeyy-info-section .info-card .info-wrapper .info-name {
  display: flex;
  align-items: center;
}

.emploeyy-info-section .info-card .info-wrapper .info-name p {
  margin-left: 10px;
}

/* old style */
/* .mc-report-card {
    position: relative;
    margin-bottom: 10px;
    border-radius: var(--border-radius-md);
  }
  .icon-wrapper {
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translate(0, -50%);
    color: rgba(255, 255, 255, .3);
    font-size: 3.6rem;
  } */
</style>
