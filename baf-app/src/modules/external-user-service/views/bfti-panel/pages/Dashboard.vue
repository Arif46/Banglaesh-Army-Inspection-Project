<template>
  <!-- <div>
      <b-row>
          <b-col>
              <h4 text="text-center p-1 mt-2">{{ $t('bfti.welcome_bfti_panel_dashboard') }}</h4>
          </b-col>
      </b-row>
  </div> -->
  <div class="section-wrapper bfti-dashboard-wrapper">
    <breadcumb />
    <div class="form-wrapper">
      <div class="mb-4 bg-white">
        <h5 class="title">{{ $t('externalUser.external_panel') }}</h5>
        <!-- <b-overlay :show="loading" class="px-3"> -->
          <div class="px-4 pb-2">
            <b-form inline class="mt-3 mb-4">
              <label class="mr-sm-2" for="inline-form-custom-select-pref">{{ $t('configuration.document_type') }}</label>
              <b-form-select id="input-3" v-model="form.document_type_id" :options="docTypeList" required></b-form-select>
            </b-form>
            <b-row>
              <b-col sm="3">
                <div class="card-item card-item-alt" style="background: #9c4fe8;padding: 20px 10px;">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                    <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                      d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                    </path>
                  </svg>
                  <div class="doc text-left">
                    <h2 class="count"> {{ $n(DocApproved + DocPending + DocRejected) }}</h2>
                    <p>{{$t('dashboard.document') }} {{ $t('globalTrans.request') }}</p>
                  </div>
                  <div class="icon">
                    <i class="ri-file-copy-2-fill"></i>
                  </div>
                </div>
              </b-col>
              <b-col sm="3">
                <div class="card-item card-item-alt" style="background: #00c182;padding: 20px 10px;">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                    <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                      d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                    </path>
                  </svg>
                  <div class="doc text-left">
                    <h2 class="count"> {{ $n(DocApproved) }} </h2>
                    <p>{{ $t('globalTrans.approved') }} {{$t('dashboard.document') }}</p>
                  </div>
                  <div class="icon">
                    <i class="ri-shield-check-fill"></i>
                  </div>
                </div>
              </b-col>
              <b-col sm="3">
                <div class="card-item card-item-alt" style="background: #F2351A;padding: 20px 10px;">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                    <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                      d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                    </path>
                  </svg>
                  <div class="doc text-left">
                    <h2 class="count"> {{ $n(DocRejected) }} </h2>
                    <p> {{ $t('globalTrans.rejected') }} {{$t('dashboard.document') }} </p>
                  </div>
                  <div class="icon">
                    <i class="ri-close-circle-fill"></i>
                  </div>
                </div>
              </b-col>
            </b-row>
          </div>
        <!-- </b-overlay> -->
      </div>
    </div>
  </div>
</template>
<script>
  import { mapGetters } from 'vuex'
  import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { documentUploadInformation } from '../api/routes'
  export default {
    data () {
      return {
        form: {
        document_type_id: 3,
        employee_user_id: 0
        },
        loading: false,
        DocRejected: 0,
        DocApproved: 0,
        DocPending: 0,
        value: '',
        file1: null,
        valueNumber: 50
      }
    },
    mounted () {
    this.form.employee_user_id = this.$store.state.Auth.authUser.user_id
    this.loadData()
  },
  watch: {
    'form.document_type_id': function (newValue) {
        this.loadData()
    }
  },
    computed: {
      ...mapGetters({
          authUser: 'Auth/authUser'
      }),
      docTypeList () {
        return this.$store.state.ExternalUserService.bftiPanel.commonObj.documentTypeList.filter(item => item.status === 1)
      }
    },
    methods: {
    edit (item) {
      this.editItemId = item.id
    },
    searchData () {
      this.form = []
      this.loadData()
    },
    mounted () {
    if (this.$store.state.Auth.activeRoleId !== 0) {
      this.form.employee_user_id = this.$store.state.Auth.authUser.user_id
    }
    this.loadData()
  },
    async loadData () {
      this.loading = true
      const params = Object.assign({}, this.search, this.form)

      const result = await RestApi.getData(bftiResReportServiceBaseUrl, documentUploadInformation, params)
      if (result.success) {
        let DocRejected = 0
        let DocApproved = 0
        let DocPending = 0
        if (result.data) {
            result.data.forEach(element => {
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
          this.DocRejected = DocRejected
          this.DocApproved = DocApproved
          this.DocPending = DocPending

          this.data.researchStatusCount = result.data
          this.data.research_ongoing = result.data
          this.data.policyStatusCount = result.data
          this.data.policy_review_done = result.data
          this.data.review_pending = result.data
          this.data.rfpStatusCount = result.data
          this.data.research_pending = result.data
          this.data.eoiStatusCount = result.data
          this.loading = false
      }
      this.loading = false
    }
  }
  }
</script>
<style>
  .external-db-sec{
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
  }
  .external-db-sec .info-card{
    padding: 12px;
    color: #fff;
    border-radius: 8px;
    background: #5725cf;
  }
  .external-db-sec .icd-1{
    background: #5725cf;
  }
  .external-db-sec .icd-2{
    background: #27c7a9;
  }
  .external-db-sec .icd-3{
    background: #d34a34;
  }
  .external-db-sec .info-card .info-value{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .external-db-sec .info-card .info-value .icon i{
    font-size: 30px;
  }
  .bfti-title{
    color: #fff;
    padding: 5px 10px;
    border-radius: 5px;
    margin-bottom: 1rem;
    background: #214162;
  }
  .bfti-title p{
    font-size: 18px;
  }
</style>
