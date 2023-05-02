<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title" style="font-weight:550;"> {{ $t('bfti.research_and_other_request') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 30%"> {{$t('bfti.doc_type')}}</th>
                    <td style="width: 70%">{{currentLocale === 'bn'? item.doc_type.document_type_bn : item.doc_type.document_type_en}}</td>
                  </tr>
                  <tr>
                    <th> {{$t('bfti.topic')}}</th>
                  <td>{{ ($i18n.locale === 'bn') ? item.topic_bn : item.topic }}</td>
                  </tr> <tr>
                  <th> {{$t('bfti.description')}}</th>
                  <td>{{ ($i18n.locale === 'bn') ? item.description_bn : item.description }}</td>
                </tr>
                  <tr>
                    <th> {{ $t('bfti.budget')}}</th>
                    <td>{{$n(item.budget)}}</td>
                  </tr>
                  <tr>
                    <th> {{ $t('bfti.budget_source')}}</th>
                  <td>{{ ($i18n.locale === 'bn') ? item.budget_source_bn : item.budget_source }}</td>
                  </tr>
                  <tr>
                    <th> {{ $t('bfti.duration')}}</th>
                    <td>{{item.duration}}</td>
                  </tr>
                  <tr>
                    <th> {{ $t('bfti.attachment')}}</th>
                    <td>
                      <a target="_blank" v-if="item.attachment" :href="bftiResReportServiceBaseUrl + item.attachment">{{ $t('bfti.attachment_down')}}</a>
                    </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
        <body-card>
          <template v-slot:body>
            <b-row>
                 <b-col md="12 text-left">
                    <span class="btn btn-primary"><h5>{{ $t('policy_advocacy.policy_information') }}</h5></span>
                  </b-col>
                  <b-col lg="12" sm="12">
                   <b-table-simple hover small caption-top responsive striped bordered>
                     <b-tr>
                      <b-th style="width:20%">{{ $t('meetingManagement.memo_no') }}</b-th>
                      <b-td style="width:30%">{{ item.memo_no }}</b-td>
                      <b-th style="width:20%">{{ $t('bfti.submission_date') }}</b-th>
                      <b-td style="width:30%">{{ item.submission_date | dateFormat }}</b-td>
                    </b-tr>
                     <tr>
                       <th> {{$t('policy_advocacy.policy_title')}}</th>
                       <td>{{currentLocale === 'bn'? item.policy_title_bn : item.policy_title}}</td>
                       <th> {{ $t('bfti.attachment')}}</th>
                       <td>
                         <a v-if="item.attachment" class="btn btn-success btn-sm rounded-pill mr-1" target="_blank" :href="baseUrl + 'download-attachment?file=' + item.attachment" title="attachment"><i class="ri-download-cloud-fill"></i></a>
                         <a target="_blank" v-if="item.attachment" :href="baseUrl + item.attachment">{{ $t('bfti.attachment_down')}}</a>
                       </td>
                     </tr>
                      <tr>
                       <th> {{$t('policy_advocacy.description_instruction')}}</th>
                       <td colspan="3">{{currentLocale === 'bn'? item.description_bn : item.description}}</td>
                     </tr>
                   </b-table-simple>
                  </b-col>
                    <b-col md="12 text-left">
                     <span class="btn btn-primary"><h5>{{ $t('policy_advocacy.focal_point_information') }}</h5></span>
                  </b-col>
                  <b-col lg="12" sm="12">
                    <b-table-simple hover small caption-top responsive striped bordered>
                      <tr>
                       <th style="width: 20%"> {{$t('globalTrans.name')}}</th>
                       <td style="width: 30%">{{currentLocale === 'bn'? item.name_bn : item.name}}</td>
                       <th style="width: 20%"> {{$t('globalTrans.designation')}}</th>
                       <td style="width: 30%">{{currentLocale === 'bn'? item.designation_bn : item.designation}}</td>
                      </tr>
                      <tr>
                        <th> {{ $t('bfti.organization')}}</th>
                        <td>{{currentLocale === 'bn'? item.organization_bn : item.organization}}</td>
                        <th> {{ $t('bfti.contact_number')}}</th>
                        <td>{{item.contact_no | mobileNumber}}</td>
                      </tr>
                      <tr>
                        <th> {{ $t('bfti.email')}}</th>
                        <td colspan="3">{{item.email}}</td>
                      </tr>
                     </b-table-simple>
                  </b-col>
            </b-row>
          </template>
        </body-card>
        <!-- <b-row class="text-right mt-2">
          <b-col>
              <b-button variant="success" class="btn-sm" @click="Approval(item, 2)">{{ $t('globalTrans.approved') }}</b-button>
              <b-button variant="danger" class="btn-sm ml-1" @click="Approval(item, 3)">{{ $t('globalTrans.rejected') }}</b-button>
              <b-button variant="danger" class="btn-sm ml-1" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row> -->
         <div class="row">
            <div class="col-sm-3"></div>
            <div class="col text-right">
              <b-button v-if="item.status !== 2 && item.status !== 3" :title="$t('globalTrans.approved')" v-b-modal.modal-2 @click="addRemarks(item.id, status=2)" class="mr-1" variant="success mr-1" size="sm"><i class="m-0"></i> {{ $t('globalTrans.approved') }}</b-button>
              <b-button v-if="item.status !== 3" :title="$t('globalTrans.reject')" v-b-modal.modal-2 @click="addRemarks(item.id, status=3)" class="mr-1" variant="danger mr-1" size="sm"><i class="ri-delete-back-2-line m-0"></i> {{ $t('globalTrans.reject') }}</b-button>
              <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.close') }}</b-button>
            </div>
        </div>
        <b-modal id="modal-2" size="lg" :title="$t('globalTrans.remarks')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <b-container fluid>
        <b-row>
            <b-col lg="12" sm="12">
                <iq-card>
                    <ValidationObserver ref="form3" v-slot="{ handleSubmit, reset }">
                        <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                            <b-row class="pt-3 px-2">
                                <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                                    <ValidationProvider name="Remarks" vid="remarks" rules="required">
                                        <b-form-group
                                            class="row"
                                            label-cols-sm="2"
                                            label-for="remarks"
                                            slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                            {{$t('globalTrans.remarks')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-textarea
                                            id="remarks"
                                            v-model="remarksData.remarks"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-textarea>
                                            <div class="invalid-feedback">
                                            {{ errors[0] }}
                                            </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                            </b-row>
                            <div class="row pb-3 px-2">
                                <div class="col-sm-3"></div>
                                <div class="col text-right">
                                    <b-button type="submit" variant="primary" class="mr-2">{{ $t('globalTrans.submit') }}</b-button>
                                    &nbsp;
                                    <b-button variant="danger" @click="$bvModal.hide('modal-2')">{{ $t('globalTrans.cancel') }}</b-button>
                                </div>
                            </div>
                        </b-form>
                    </ValidationObserver>
                </iq-card>
          </b-col>
        </b-row>
      </b-container>
    </b-modal>
      </b-col>
    </b-row>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { bftiPolicyRequestApproveRejectApi } from '../../../api/routes'
import toggleMixedStatus from '@/utils/toggle-mixed-status'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      baseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      loading: false,
      errors: [],
      remarksData: {
          id: '',
          remarks: '',
          status: 0
      },
      detailsData: [],
      detailsItemId: ''
    }
  },
   created () {
        if (this.id) {
            const tmp = this.getData()
            this.item = tmp
        }
    },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
   components: {
        ValidationProvider, ValidationObserver
    },
  methods: {
    saveData () {
            let message = ''
            if (this.remarksData.status === 2) {
                message = this.$t('globalTrans.approveMsg')
            } else if (this.remarksData.status === 3) {
                message = this.$t('globalTrans.rejectMsg')
            }
            toggleMixedStatus(bftiResReportServiceBaseUrl, bftiPolicyRequestApproveRejectApi, this.remarksData, message, ['modal-2', 'modal-form-details'])
        },
        addRemarks (id, status) {
            this.remarksData.id = id
            this.remarksData.status = status
        },
    getData () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
    },
    Approval (item, type) {
      let msg = ''
      if (type === 2) {
        msg = window.vm.$t('globalTrans.approveMsg')
      } else {
        msg = window.vm.$t('globalTrans.rejectMsg')
      }
      window.vm.$swal({
        title: msg,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.acceptReject(item.id, type)
        }
      })
    },
    acceptReject (id, type) {
      const params = {
        id: id,
        status: type
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      RestApi.getData(bftiResReportServiceBaseUrl, bftiPolicyRequestApproveRejectApi, params)
      .then(response => {
        if (response.success) {
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
          window.vm.$toast.success({
            title: 'Success',
            message: 'Data Updated Successfully',
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-form-details')
          this.loadData()
        } else {
          window.vm.$toast.error({
            title: 'Error',
            message: 'Operation failed! Please, try again.'
          })
        }
      })
    }
  }
}
</script>
