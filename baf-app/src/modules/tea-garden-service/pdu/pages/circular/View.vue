<template>
  <card>
      <body-card style="margin: 0;border: none;">
          <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('teaGardenBtriService.details') }}</h4>
          </template>
          <template v-slot:body>
              <b-tabs content-class="mt-0" fill>
                  <!--  Tab of Application Start  -->
                  <b-tab :title="$t('license_management.application')" active>
                      <div v-if="loading">
                          <Loading />
                      </div>
                      <b-overlay v-else>
                          <div class="text-right">
                              <b-button @click="print" variant="primary" class="btn btn-sm mb-2">
                                  <i class="ri-printer-line"></i> {{ $t('globalTrans.print') }}
                              </b-button>
                          </div>
                          <div class="stepper-wrapper mt-3">
                              <div :class="item.value <= data.status ? `stepper-item completed` : `stepper-item`"
                                   v-for="(item, index) in stepList" :key="index">
                                  <div class="step-counter">
                                      <i v-if="item.value <= data.status" class="ri-check-fill"></i>
                                      <span v-else>{{ $n(index+1) }}</span>
                                  </div>
                                  <div class="step-name">{{ item.text }}</div>
                              </div>
                          </div>
                          <div class="p-3" :class="currentLocale === 'en' ? 'font-en' : 'font-bn'" id="printMe">
                            <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                                <div class="" style="width:50%"><b>{{ $t('teaGardenPduService.circular_name') }}</b> : {{ currentLocale === 'en' ?
                                  data.circular_title_en : data.circular_title_bn }}</div>
                                <div class="text-right" style="width:50%"><b>{{ $t('teaGardenPduService.application_deadline') }}</b> : {{
                                  data.application_deadline | dateFormat }}</div>
                              </div>
                              <div v-html="currentLocale === 'en' ? data.description_en : data.description_bn" class="editor-content">
                              </div>
                          </div>
                          <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
                      </b-overlay>
                  </b-tab>
                  <!--  Tab of Application End  -->
                  <!--  Tab of Forward Start  -->
                  <b-tab :title="$t('license_management.forward_history')" v-if="data.forwards.length">
                      <div v-if="forwarLoad || loading" class="col-md-12">
                          <forward-loading></forward-loading>
                      </div>
                      <div v-else class="row">
                          <div class="col-md-10 offset-md-1">
                              <div v-for="(forward, index) in data.forwards" :key="index">
                                  <b-card>
                                      <b-card-title>
                                          <h5 style="font-size:17px">{{ getCardTitle(forward.status) }}</h5>
                                      </b-card-title>
                                      <b-card-sub-title style="font-size:14px">
                                          <b-row>
                                              <b-col md="5">
                                                  <span class="badge badge-success">{{ $t('license_management.sender') }}</span> : {{
                                                  getUserName(forward.sender_id) }} <i class=" ml-3 ri-arrow-right-line"></i>
                                              </b-col>
                                              <b-col>
                                                  <p><span class="badge badge-primary">{{ $t('license_management.receiver') }}</span> : {{
                                                      getUserName(forward.receiver_id) }}</p>
                                                  <p><strong>{{ $t('globalTrans.designation') }} : </strong>
                                                      {{ getDesignationName(forward.designation_id) }}</p>
                                                  <p><strong>{{ $t('globalTrans.office') }} : </strong>
                                                      {{ getOfficeName(forward.office_id) }}</p>
                                              </b-col>
                                          </b-row>
                                      </b-card-sub-title>
                                      <b-card-text class="mt-3">
                                          <b>{{ $t('globalTrans.note') }}</b> : <span>{{ $i18n.locale === 'bn' ? forward.remarks : forward.remarks }}</span>
                                      </b-card-text>
                                  </b-card>
                              </div>
                          </div>
                      </div>
                  </b-tab>
                  <!--  Tab of Forward End  -->
              </b-tabs>
          </template>
      </body-card>
  </card>
</template>
<script>
  import RestApi, { authServiceBaseUrl, teaGardenServiceBaseUrl } from '@/config/api_config'
  import ForwardLoading from './loading/ForwardLoading.vue'
  import Loading from './loading/Details.vue'
  import { circularShow } from '../../api/routes'
  import Vue from 'vue'
  import VueHtmlToPaper from 'vue-html-to-paper'
  Vue.use(VueHtmlToPaper)
  export default {
      name: 'Details',
      components: {
          Loading,
          ForwardLoading
      },
      data () {
          return {
              forwarLoad: false,
              teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
              data: {
                  id: 0,
                  service_id: 0,
                  details: [],
                  forwards: []
              },
              users: [],
              pageStyle: {
                  styles: [
                      'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
                      `${teaGardenServiceBaseUrl}/custom.css`
                  ]
              }
          }
      },
      created () {
          this.getAppDetail()
      },
      computed: {
          appId () {
              return this.$route.params.id
          },
          stepList () {
              const arr1 = [
                  { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
                  { value: 2, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
                  { value: 3, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' },
                  { value: 4, text: this.$i18n.locale === 'en' ? 'Closed' : 'সমাপ্তি', text_en: 'Closed', text_bn: 'সমাপ্তি' }
              ]
              const tcbStepList = arr1
              return tcbStepList
          },
          currentLocale () {
              return this.$i18n.locale
          },
          loading () {
              return this.$store.state.commonObj.loading
          },
          forwardStatusList () {
              const list = [
                  { value: 1, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ', text_en: 'Pending', text_bn: 'অপেক্ষমাণ' },
                  { value: 2, text: this.$i18n.locale === 'en' ? 'Forwarded' : 'ফরোয়ার্ড', text_en: 'Forwarded', text_bn: 'ফরোয়ার্ড' },
                  { value: 3, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত', text_en: 'Approved', text_bn: 'অনুমোদিত' }
              ]
              return list
          }
      },
      methods: {
          print () {
              this.$htmlToPaper('printMe', this.pageStyle)
          },
          getCardTitle (status) {
              const tgServiceStep = this.forwardStatusList.find(item => item.value === parseInt(status))
              if (typeof tgServiceStep !== 'undefined') {
                  return this.$i18n.locale === 'bn' ? tgServiceStep.text_bn : tgServiceStep.text_en
              } else {
                  return ''
              }
          },
          back () {
              this.$router.go(-1)
          },
          async getAppDetail () {
              this.$store.dispatch('mutateCommonProperties', { loading: true })
              const result = await RestApi.getData(teaGardenServiceBaseUrl, `${circularShow}/${this.appId}`)
              if (result.success) {
                  this.data = result.data
                  if (this.data.forwards && this.data.forwards.length) {
                      await this.getForwardedUsers(this.data.forwards)
                  }
              }
              this.$store.dispatch('mutateCommonProperties', { loading: false })
          },
          getOfficeName (id) {
              const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
              if (typeof data !== 'undefined') {
                  return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
              } else {
                  return ''
              }
          },
          getUserName (userId) {
              const user = this.users.find(user => parseInt(user.value) === parseInt(userId))
              return typeof user !== 'undefined' ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
          },
          async getForwardedUsers (forwards) {
              this.forwarLoad = true
              var userIds = []
              forwards.map((item, key) => {
                  userIds.push(item.sender_id)
                  userIds.push(item.receiver_id)
              })
              const params = Object.assign({}, { user_ids: userIds })
              await RestApi.getData(authServiceBaseUrl, '/user-detail-by-user-ids', params).then(response => {
                  if (response.length) {
                      this.users = response
                  } else {
                      this.users = []
                  }
                  this.forwarLoad = false
              })
          },
          isImage (path) {
              return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
          },
          getDesignationName (id) {
              const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
              return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
          }
      }
  }
</script>
<style>
.editor-content {
      white-space: pre !important;
  }
</style>
<style scoped>
  .tag {
      font-weight: 600;
      border-left: 4px solid #1c4261;
      padding-left: 6px;
  }
  .download-btn {
      color: green;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 2px 4px;
  }
  .yes-btn {
      color: green;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 1px 3px;
  }
  .no-btn {
      color: red;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 1px 3px;
      margin-right: 33px !important;
  }
  .tag {
      font-weight: 600;
      border-left: 4px solid #1c4261;
      padding-left: 6px;
  }
  .download-btn {
      color: green;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 2px 4px;
  }
  .yes-btn {
      color: green;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 1px 3px;
  }
  .no-btn {
      color: red;
      border: 1px solid gray;
      margin-left: 5px;
      font-size: 18px;
      padding: 1px 3px;
      margin-right: 33px !important;
  }

  .stepper-wrapper {
      margin-top: auto;
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
  }
  .stepper-item {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      flex: 1;
  }

  @media (max-width: 768px) {
      font-size: 12px;
  }
  .stepper-item::before {
      position: absolute;
      content: "";
      border-bottom: 2px solid #ccc;
      width: 100%;
      top: 20px;
      left: -50%;
      z-index: 2;
  }

  .stepper-item::after {
      position: absolute;
      content: "";
      border-bottom: 2px solid #ccc;
      width: 100%;
      top: 20px;
      left: 50%;
      z-index: 2;
  }

  .stepper-item .step-counter {
      position: relative;
      z-index: 5;
      display: flex;
      justify-content: center;
      align-items: center;
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background: #ccc;
      margin-bottom: 6px;
      color: white;
  }

  .stepper-item.active {
      font-weight: bold;
  }

  .stepper-item.completed .step-counter {
      background-color: #4bb543;
      color:white;
  }

  .stepper-item.completed::after {
      position: absolute;
      content: "";
      border-bottom: 2px solid #4bb543;
      width: 100%;
      top: 20px;
      left: 50%;
      z-index: 3;
  }

  .stepper-item:first-child::before {
      content: none;
  }
  .stepper-item:last-child::after {
      content: none;
  }
  .step-name {
      color: black;
      font-weight: bold;
      font-size: 11px;
  }
  .tagTwo {
      position: relative;
      display: inline-block;
      border-radius: 6px;
      clip-path: polygon(20px 0px, 100% 0px, 100% 100%, 0% 100%, 0% 20px);
      background: hsl(250deg, 100%, 40%);
      padding: 5px 25px;
      font-weight: 600;
      font-size: 12px;
      color: #FFF;
      transition: clip-path 500ms;
  }
  .tagTwo:after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 20px;
      height: 20px;
      background: hsl(252deg, 100%, 60%);
      box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1);
      border-radius: 0 0 6px 0;
      transition: transform 500ms;
  }
</style>
