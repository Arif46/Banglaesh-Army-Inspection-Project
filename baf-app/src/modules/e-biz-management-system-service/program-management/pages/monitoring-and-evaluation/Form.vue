
<template>
<b-container fluid>
    <b-row>
      <b-overlay :show="loading">
      <b-col sm="12">
          <!-- =================Add More Start===================== -->
          <ValidationObserver ref="evaluationForm" v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(evaluationAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Proposal No" vid="proposal_no" v-slot="{ errors }" rules="required">
                    <b-form-group
                      label-for="proposal_no"
                    >
                      <template v-slot:label>
                        {{ $t('eBizProgram.proposal_no') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="proposal_no"
                          type="text"
                          v-model="evaluationData.proposal_no"
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
                    <ValidationProvider name="Program No" vid="program_no" v-slot="{ errors }" rules="required">
                    <b-form-group
                      label-for="program_no"
                    >
                      <template v-slot:label>
                        {{ $t('eBizProgram.program_no') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="program_no"
                          type="text"
                          v-model="evaluationData.program_no"
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
                    <ValidationProvider name="Program Name" vid="program_name" v-slot="{ errors }" rules="required">
                    <b-form-group
                      label-for="program_name"
                    >
                      <template v-slot:label>
                        {{ $t('eBizProgram.program_name') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                          id="program_name"
                          type="text"
                          v-model="evaluationData.program_name"
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
                      <ValidationProvider name="Evaluation Attachment" vid="attachment" rules="required">
                        <b-form-group
                          label-for="attachment"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                            {{$t('eBizProgram.evaluation')}} {{ $t('globalTrans.attachment') }}<span class="text-danger">*</span>
                          </template>
                        <b-form-file id="attachment"
                        v-model="evaluationData.file"
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
                      <b-button :disabled="loading" type="submit" variant="success" class="mr-2 btn-sm">
                          <span v-if="loading">
                              <b-spinner small label="Loading..."></b-spinner>
                          </span>
                          <span v-else>
                              <i class="fas fa-plus-circle m-0"></i>
                          </span>
                          {{arrEvaluationItemData && arrEvaluationItemData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
                      </b-button>
                  </b-col>
                </b-row>
              </b-form>
            <!-- </b-overlay> -->
          </ValidationObserver>
          <br/>
            <!-- Investigator Add Start -->
            <ValidationObserver ref="addMoreForm" v-slot="{ handleSubmit, reset }">
            <!-- <b-overlay :show="loading"> -->
              <b-form @submit.prevent="handleSubmit(addMoreFormData)" @reset.prevent="reset">
                <div class="table-wrapper table-responsive">
                  <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr class="bg-primary">
                                <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('eBizProgram.proposal_no') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('eBizProgram.program_no') }}</div></th>
                                <th scope="col" style="width: 15%;" class="text-center"><div>{{ $t('eBizProgram.program_name') }}</div></th>
                                <th scope="col" style="width: 15%;" class="text-center"><div>{{ $t('globalTrans.attachment') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.action') }}</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="arrEvaluationItemData && arrEvaluationItemData.length > 0">
                                <tr v-for="(item, index) in arrEvaluationItemData" :key="index">
                                    <td  class="text-center">{{ index+1 }}</td>
                                    <td  class="text-center">{{ item.proposal_no }}</td>
                                    <td  class="text-center">{{ item.program_no }}</td>
                                    <td  class="text-center">{{ item.program_name }}</td>
                                    <td class="text-center">
                                          <span><a target="_blank" class="btn btn-primary btn-sm btn-outline mr-2" :href="eBizServiceBaseUrl+'download-attachment?file='+item.attachment" :title="$t('globalTrans.download')"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                    </td>
                                    <td class="text-center">
                                        <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="evaluationItemRemove(index)" class="action-btn delete"><i class="ri-delete-bin-2-line"></i></b-button>
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
              </b-form>
            <!-- </b-overlay> -->
          </ValidationObserver>
            <!-- Investigator Add End -->
          <br>
          <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
            <!-- <b-overlay :show="loading"> -->
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
              <b-row>
                  <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Evaluation Comment" vid="evaluation_comment" v-slot="{ errors }" rules="required">
                          <b-form-group
                              label-for="evaluation_comment">
                              <template v-slot:label>
                               {{ $t('eBizProgram.evaluation') }}  {{ $t('eBizProgram.comment') }} <span class="text-danger">*</span>
                              </template>
                            <b-form-textarea
                                  id="evaluation_comment"
                                  rows="3"
                                  v-model="formData.evaluation_comment"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-textarea>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                </b-row>
              </b-form>
            <!-- </b-overlay> -->
        </ValidationObserver>
      <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('evaluation-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
  </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { evaluationSave } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.submit'),
      errors: [],
      officerLoading: false,
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      formData: {
        evaluation_comment: '',
        fiscal_year_id: this.items.fiscal_year_id,
        association_info_id: this.items.association_info_id,
        council_info_id: this.items.council_info_id,
        program_id: this.items.program_id,
        proposal_id: this.items.program?.proposal_id,
        proposal_detail_id: this.items.program?.id,
        evaluationDataArr: []
      },
      evaluationData: {
        proposal_no: this.items.program?.proposal?.proposal_id,
        program_no: this.items.proposal_detail_id,
        program_name: '',
        attachment: '',
        file: []
      },
      arrEvaluationItemData: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
    }
    if (this.items) {
      this.evaluationData.program_name = this.currentLocale === 'bn' ? this.items.program?.programe_name_bn : this.items.program?.programe_name_en
      this.formData.program_id = this.items.id
      this.formData.fiscal_year_id = this.items.fiscal_year_id
      this.formData.association_info_id = this.items.association_info_id
      this.formData.council_info_id = this.items.council_info_id
    }
  },
  computed: {
    auth () {
      return this.$store.state.Auth
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.componentOrgList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
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
            this.evaluationData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.evaluationData.attachment = ''
        }
    },
    // ================Edu Info Start=================
        async evaluationAddItem () {
               var obj = {
                  proposal_no: this.evaluationData.proposal_no,
                  program_no: this.evaluationData.program_no,
                  program_name: this.evaluationData.program_name,
                  attachment: this.evaluationData.attachment
                }
                this.formData.evaluationDataArr.push(obj)
                this.evaluationData = {
                    proposal_no: this.items.program?.proposal?.proposal_id,
                    program_no: this.items.proposal_detail_id,
                    program_name: this.currentLocale === 'bn' ? this.items.program?.programe_name_bn : this.items.program?.programe_name_en,
                    attachment: '',
                    file: []
                }
                this.arrEvaluationItemData = this.formData.evaluationDataArr
                this.$refs.evaluationForm.reset()
                this.loading = false
        },
        evaluationItemRemove (key) {
            this.formData.evaluationDataArr.splice(key, 1)
        },
        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      const isDetailsValid = await this.$refs.addMoreForm.validate()
      this.formData.evaluationDataArr = this.arrEvaluationItemData
      if (isValid && isDetailsValid && this.formData.evaluationDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(eBizServiceBaseUrl, evaluationSave, this.formData)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('evaluation-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
