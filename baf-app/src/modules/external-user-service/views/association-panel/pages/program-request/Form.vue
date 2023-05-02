<template>
  <div class="inner-section">
     <!-- <bread-cumb /> -->
        <body-card>
           <b-container fluid>
              <b-row>
                <b-overlay :show="loading">
                 <b-col sm="12" class="mt-3">
                   <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                         <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                             <b-row>
                           <slot>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                               <ValidationProvider name="Council" vid="council_info_id" rules="required|min_value:1">
                                   <b-form-group
                                     label-for="council_info_id"
                                     slot-scope="{ valid, errors }"
                                   >
                                   <template v-slot:label>
                                     {{$t('associationPnl.council')}} <span class="text-danger">*</span>
                                   </template>
                                   <b-form-select
                                     plain
                                     v-model="formData.council_info_id"
                                     :options="councilInfoList"
                                     id="council_info_id"
                                     disabled
                                     :state="errors[0] ? false : (valid ? true : null)"
                                   >
                                     <template v-slot:first>
                                       <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                     </template>
                                   </b-form-select>
                                   <div class="invalid-feedback">
                                     {{ errors[0] }}
                                   </div>
                                   </b-form-group>
                               </ValidationProvider>
                           </b-col>
                           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                               <ValidationProvider name="Association" vid="association_info_id" rules="required|min_value:1">
                                   <b-form-group
                                     label-for="association_info_id"
                                     slot-scope="{ valid, errors }"
                                   >
                                   <template v-slot:label>
                                     {{$t('associationPnl.association')}} <span class="text-danger">*</span>
                                   </template>
                                   <b-form-select
                                     plain
                                     v-model="formData.association_info_id"
                                     :options="associationInfoList"
                                     id="association_info_id"
                                     disabled
                                     :state="errors[0] ? false : (valid ? true : null)"
                                   >
                                     <template v-slot:first>
                                       <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                     </template>
                                   </b-form-select>
                                   <div class="invalid-feedback">
                                     {{ errors[0] }}
                                   </div>
                                   </b-form-group>
                               </ValidationProvider>
                           </b-col>
                             <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                               <ValidationProvider name="Program Name" vid="program_id" rules="required|min_value:1">
                                   <b-form-group
                                     label-for="program_id"
                                     slot-scope="{ valid, errors }"
                                   >
                                   <template v-slot:label>
                                     {{$t('associationPnl.program_name')}} <span class="text-danger">*</span>
                                   </template>
                                   <b-form-select
                                     plain
                                     v-model="formData.program_id"
                                     :options="programList"
                                     id="program_id"
                                     :state="errors[0] ? false : (valid ? true : null)"
                                   >
                                     <template v-slot:first>
                                       <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                     </template>
                                   </b-form-select>
                                   <div class="invalid-feedback">
                                     {{ errors[0] }}
                                   </div>
                                   </b-form-group>
                               </ValidationProvider>
                           </b-col>
                           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Proposal No" vid="proposal_id" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="proposal_id">
                                  <template v-slot:label>
                                    {{ $t('associationPnl.proposal_no') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="proposal_id"
                                    v-model="formData.proposal_id"
                                    disabled
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                           </b-col>
                           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Program Duration" vid="program_duration" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="program_duration">
                                    <template v-slot:label>
                                      {{ $t('associationPnl.program_duration') }} <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                      id="program_duration"
                                      v-model="formData.program_duration"
                                      class="form-control"
                                      :placeholder="$t('globalTrans.select_date')"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :class="errors[0] ? 'is-invalid' : ''"
                                    >
                                    </date-picker>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="6">
                              <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
                                <b-form-group
                                  label-for="description_en">
                                  <template v-slot:label>
                                    {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                                  </template>
                                  <b-form-textarea
                                      id="description_en"
                                      rows="3"
                                      v-model="formData.description_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-textarea>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="6">
                              <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
                                <b-form-group
                                  label-for="description_bn">
                                  <template v-slot:label>
                                    {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                                  </template>
                                  <b-form-textarea
                                      id="description_bn"
                                      rows="3"
                                      v-model="formData.description_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-textarea>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           </slot>
                        </b-row>
                      </b-form>
                   </ValidationObserver>
                      <!-- attachemnt  -->
                 <b-row class="text-right mb-3">
                     <b-col>
                         <b-button type="submit" variant="success" @click="saveData(1)" class="mr-2 btn-sm">{{$t('globalTrans.draft')}}</b-button>
                         <!-- <b-button type="submit" variant="success" @click="saveData(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button> -->
                         <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                     </b-col>
                 </b-row>
                 </b-col>
              </b-overlay>
            </b-row>
          </b-container>
      </body-card>
   </div>
 </template>
 <script>
 import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
 import { programStore, programGetProgram } from '../../api/routes'
//  import BreadCumb from '../../../../../../components/BreadCumb.vue'
import flatpickr from 'flatpickr'
 export default {
   name: 'Form',
   props: ['id'],
   components: { },
   data () {
     return {
       valid: null,
       saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
       errors: [],
       formData: {
        user_id: this.$store.state.Auth.authUser.user_id,
        program_id: 0,
        program_name: '',
        proposal_id: '',
        council_info_id: 0,
        association_info_id: 0,
        program_duration: '',
        start_date: '',
        end_date: '',
        description_en: '',
        description_bn: '',
        status: 1
       },
       allProgramList: [],
       programList: [],
       loading: false
     }
   },
   created () {
    this.getProgram()
    if (this.id) {
       const tmp = this.getEditEntry()
       this.formData = tmp
      //  this.formData.budgetEntryDataArr = tmp.details
      //  this.arrBudgetEntryData = tmp.details
     }
   },
   computed: {
    //  loading: function () {
    //    return this.$store.state.commonObj.loading
    //  },
     currentLocale () {
       return this.$i18n.locale
     },
      councilInfoList () {
          return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).map(item => {
            if (this.$i18n.locale === 'bn') {
              return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
            } else {
              return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
            }
          })
        },
        associationInfoList () {
          return this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1).map(item => {
            if (this.$i18n.locale === 'bn') {
              return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
            } else {
              return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
            }
          })
        }
   },
   mounted () {
        flatpickr('#program_duration', {
          mode: 'range',
          minDate: 'today'
        })
    },
   watch: {
     'formData.program_id': function (newVal, oldVal) {
       if (newVal !== oldVal) {
        this.loading = true
         const programObj = this.allProgramList.find(item => item.value === newVal)
         if (typeof programObj !== 'undefined') {
          this.formData.proposal_id = programObj.proposal_id
          } else {
            this.formData.proposal_id = ''
          }
          this.loading = false
       }
     },
     'formData.program_duration': function (newVal, oldVal) {
      const dateArray = newVal.split('to')
      if (dateArray.length > 1) {
        this.formData.start_date = dateArray[0]
        this.formData.end_date = dateArray[1]
      } else {
        this.formData.start_date = dateArray[0]
        this.formData.end_date = dateArray[0]
      }
     }
   },
   methods: {
     async saveData (status) {
       const isValid = await this.$refs.mainForm.validate()
       if (isValid) {
        this.loading = true
        this.formData.status = status
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
         result = await RestApi.postData(eBizServiceBaseUrl, programStore, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)
       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })
         this.$bvModal.hide('modal-form')
       } else {
         this.$refs.mainForm.setErrors(result.errors)
       }
     }
     },
     getEditEntry () {
       const itemId = this.id
       const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
       return JSON.parse(JSON.stringify(tmpData))
     },
     async getProgram () {
      this.loading = true
      let result = null
      const params = Object.assign({}, { user_id: this.$store.state.Auth.authUser.user_id })
      result = await RestApi.postData(eBizServiceBaseUrl, programGetProgram, params)
      // var tagArr = []
      if (result.success) {
          if (result.data.length > 0) {
            this.allProgramList = result.data
            this.programList = result.data.map(item => {
              return { value: item.value, text: this.currentLocale === 'en' ? item.text_en : item.text_bn }
            })
            // ----------------Start 1----
            this.formData.association_info_id = result.assoprofile.association_info_id
            this.formData.council_info_id = result.assoprofile.council_info_id
          } else {
            // this.tagList = this.allTagList
          }
          this.loading = false
      } else {
          this.loading = false
      }
    },
    getProgramList () {
      return this.programList.map(item => {
        return { value: item.value, text: this.currentLocale === 'en' ? item.text_en : item.text_bn }
      })
    }
   }
 }
 </script>
