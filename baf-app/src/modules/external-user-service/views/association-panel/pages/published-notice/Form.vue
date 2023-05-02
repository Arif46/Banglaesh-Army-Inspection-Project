<template>
 <div class="inner-section">
        <b-container fluid>
          <b-row>
            <b-overlay :show="loading">
              <b-col sm="12" class="mt-3">
                <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                      <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset"  autocomplete="off" enctype="multipart/form-data">
                          <b-row>
                        <slot>
                       <b-col xs="12" sm="12" md="6">
                          <ValidationProvider name="Council Name" vid="council_info_id" rules="">
                                <b-form-group
                                    label-for="council_info_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.council_info_id"
                                    :options="councilInfoList"
                                    disabled
                                    id="council_info_id"
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
                       <b-col xs="12" sm="12" md="6">
                          <ValidationProvider name="Association Name" vid="association_info_id" rules="">
                                <b-form-group
                                    label-for="association_info_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProposal.association_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.association_info_id"
                                    :options="associationInfoList"
                                    disabled
                                    id="association_info_id"
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
                         <b-col xs="12" sm="12" md="12">
                          <ValidationProvider name="Proposal Type" vid="proposal_type_ids" rules="required" v-slot="{ errors }">
                              <b-form-group
                              class="row"
                              label-cols-sm="3"
                              label-for="proposal_type_ids"
                              >
                              <template v-slot:label>
                              {{ $t('associationPnl.proposal_type') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-checkbox-group
                                  v-model="formData.proposal_type_ids"
                                  :options="proposalTypeList"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-checkbox-group>
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

                        <!-- =============End Main========= -->
                  <template>
                        <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                            <h5 class="text-white text-left">
                                {{ $t('eBizProposal.budget') }} {{ $t('globalTrans.details') }}
                            </h5>
                        </div>
                  </template>
                    <hr>
                    <!-- =================Add More Start===================== -->
                  <div>
                    <ValidationObserver ref="programProposalForm" v-slot="{ handleSubmit, reset }">
                      <!-- <b-overlay :show="loading"> -->
                        <b-form @submit.prevent="handleSubmit(programProposalAddItem)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
                          <b-row>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Program Name (En)" vid="programe_name_en" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="programe_name_en">
                                    <template v-slot:label>
                                      {{ $t('associationPanel.program_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="programe_name_en"
                                      v-model="programData.programe_name_en"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Program Name (Bn)" vid="programe_name_bn" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="programe_name_bn">
                                    <template v-slot:label>
                                      {{ $t('associationPanel.program_name') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="programe_name_bn"
                                      v-model="programData.programe_name_bn"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                          </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Duration (Day)" vid="duration" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="duration">
                                  <template v-slot:label>
                                    {{ $t('associationPanel.duration') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="duration"
                                    v-model="programData.duration"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="amount">
                                  <template v-slot:label>
                                    {{ $t('eBizProposal.amount') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="amount"
                                    v-model="programData.amount"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Attachment" vid="attachment" rules="required">
                                <b-form-group
                                  label-for="attachment"
                                  slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{ $t('globalTrans.attachment') }}<span class="text-danger">*</span>
                                  </template>
                                <b-form-file id="attachment"
                                v-model="programData.file"
                                v-on:change="onFileChange"
                                accept=".doc,.docx,.pdf"
                                class="mt-2" plain
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                          </b-row>
                          <b-row class="text-right">
                            <b-col>
                                <b-button type="submit" variant="success" class="mr-2 btn-sm">
                                    <span v-if="loading">
                                        <b-spinner small label="Loading..."></b-spinner>
                                    </span>
                                    <span v-else>
                                        <i class="fas fa-plus-circle m-0"></i>
                                    </span>
                                    {{arrProgramList && arrProgramList.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
                                </b-button>
                            </b-col>
                          </b-row>
                        </b-form>
                      <!-- </b-overlay> -->
                    </ValidationObserver>
                  </div>
                  <br/>
                    <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                      <div class="table-wrapper table-responsive">
                      <table class="table table-striped table-hover table-bordered">
                              <thead>
                                  <tr class="bg-primary">
                                      <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" class="text-center">
                                        <div>{{ $t('associationPanel.program_name') }}</div>
                                      </th>
                                      <th scope="col" class="text-center">
                                        <div>{{ $t('associationPanel.duration') }} </div>
                                      </th>
                                      <th scope="col" class="text-center">
                                        <div>{{ $t('eBizProposal.amount') }}</div>
                                      </th>
                                      <th scope="col" class="text-center">
                                        <div>{{ $t('globalTrans.attachment') }}</div>
                                      </th>
                                      <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="arrProgramList && arrProgramList.length > 0">
                                      <tr v-for="(item, index) in arrProgramList" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }}</td>
                                          <td class="text-center">{{ currentLocale == 'en' ? item.programe_name_en : item.programe_name_bn }}</td>
                                           <td style="width: 40%" class="text-center" >
                                              <ValidationProvider name="Duration" :vid="`duration${index}`" rules="required" v-slot="{ errors }">
                                                <b-form-group
                                                  :label-for="`duration${index}`">
                                                  <b-form-input
                                                    id="duration"
                                                    v-model.number="item.duration"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                          </td>
                                          <td style="width: 40%" class="text-center" >
                                              <ValidationProvider name="Amount" :vid="`amount${index}`" rules="required" v-slot="{ errors }">
                                                <b-form-group
                                                  :label-for="`amount${index}`">
                                                  <b-form-input
                                                    id="amount"
                                                    v-model.number="item.amount"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                          </td>
                                          <td class="text-center">
                                            <span><a target="_blank" class="btn btn-primary btn-sm btn-outline mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+item.attachment" :title="$t('globalTrans.download')"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                           </td>
                                          <td class="text-center">
                                              <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="programProposalRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                          </td>
                                      </tr>
                                  </template>
                                  <template v-else>
                                      <tr>
                                          <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                      </tr>
                                  </template>
                              </tbody>
                          </table>
                      </div>
                      <!-- &&&&&&&&&&&&&&Manual Info Details End&&&&&&&&&&&&&&& -->
                  <!-- =================Add More End===================== -->
                  <br>
                  <!-- attachemnt  -->
              <b-row class="text-right mb-3">
                  <b-col>
                      <b-button type="submit" variant="warning" @click="saveData(1)" class="mr-2 btn-sm">{{ draftBtnName }}</b-button>
                      <b-button type="submit" variant="success" @click="saveData(2)" class="mr-2 btn-sm">{{ finalSave }}</b-button>
                      <b-button variant="danger" class="btn-sm"  @click="$bvModal.hide('apply')">{{ $t('globalTrans.cancel') }}</b-button>
                  </b-col>
              </b-row>
              </b-col>
        </b-overlay>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { applyProposalSave, applyProposalUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'items', 'associationInfo'],
  components: { },
  data () {
    return {
      valid: null,
      draftBtnName: this.$t('globalTrans.draft'),
      finalSave: this.$t('globalTrans.finalSave'),
      errors: [],
      formData: {
        fiscal_year_id: this.items.fiscal_year_id,
        circular_notice_id: this.id,
        council_info_id: this.associationInfo.council_info_id,
        association_info_id: this.associationInfo.association_info_id,
        status: 1,
        proposal_type_ids: [],
        programListArr: []
      },
      programData: {
        programe_name_en: '',
        programe_name_bn: '',
        duration: 0,
        amount: 0,
        file: [],
        attachment: ''
      },
      exitBudgetShow: false,
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      arrProgramList: []
      // itemList: []
    }
  },
  created () {
    if (this.items?.proposal?.id) {
      const tmp = this.getEditEntry()
      this.formData = tmp.proposal
      this.formData.circular_notice_id = this.items.id
      this.formData.proposal_type_ids = JSON.parse(this.items.proposal?.proposal_type_ids)
      this.formData.programListArr = tmp.proposal?.details
      this.arrProgramList = tmp.proposal?.details
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
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
    },
    proposalTypeList () {
      return this.$store.state.ExternalUserService.eBizPanel.commonObj.proposalTypeList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  watch: {
  },
  methods: {
    onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.programData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.programData.attachment = ''
        }
    },
    // ================Edu Info Start=================
        async programProposalAddItem () {
               var obj = {
                    programe_name_en: this.programData.programe_name_en,
                    programe_name_bn: this.programData.programe_name_bn,
                    duration: this.programData.duration,
                    amount: parseFloat(this.programData.amount),
                    file: this.programData.file,
                    attachment: this.programData.attachment
                }
                  // this.loading = true
                      if (this.programData.key === undefined) {
                          this.formData.programListArr.push(obj)
                      } else {
                          this.formData.programListArr[this.programData.key].programe_name_en = this.programData.programe_name_en
                          this.formData.programListArr[this.programData.key].council_name_bn = this.programData.programe_name_bn
                          this.formData.programListArr[this.programData.key].duration = this.programData.duration
                          this.formData.programListArr[this.programData.key].amount = this.programData.amount
                          this.formData.programListArr[this.programData.file].file = this.programData.file
                          this.formData.programListArr[this.programData.file].attachment = this.programData.attachment
                      }
                      this.programData = {
                            programe_name_en: '',
                            programe_name_bn: '',
                            duration: 0,
                            amount: 0,
                            file: [],
                            attachment: ''
                      }
                      this.arrProgramList = this.formData.programListArr
                      this.$refs.programProposalForm.reset()
                      // this.loading = false
        },
        programProposalRemove (key) {
          this.formData.programListArr.splice(key, 1)
        },
        // ================Edu Info End===================
    async saveData (status) {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.programListArr.length > 0) {
      this.formData.status = status
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.items.proposal?.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${applyProposalUpdate}/${this.items.proposal?.id}`, this.formData)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, applyProposalSave, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.items.proposal?.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('apply')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getEditEntry () {
      const tmpData = this.$store.state.list.find(item => item.proposal?.id === parseInt(this.items?.proposal?.id))
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
