<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.contract_signing_basic_info') }}</h4>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr v-if="form.document_type_id">
                  <b-th>{{ $t('configuration.document_type') }}</b-th>
                  <b-td colspan="3">{{ getDocumentTypeName(form.document_type_id) }}</b-td>
                </b-tr>
                 <b-tr>
                  <b-th>{{ $t('globalTrans.title') }}</b-th>
                  <b-td colspan="3">
                     <slot v-if="form.document_type_id === 1">
                      {{ ($i18n.locale === 'bn') ? form.prepare_eoi.title_bn : form.prepare_eoi.title }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? form.prepare_rfp.rfp_title_bn : form.prepare_rfp.rfp_title_en }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? form.research.topic_bn: form.research.topic }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 4">
                      {{ ($i18n.locale === 'bn') ? form.policy.policy_title_bn: form.policy.policy_title }}
                    </slot>
                    <!-- {{ ($i18n.locale === 'bn') ? form.topic_bn : form.topic }} -->
                  </b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-td colspan="3">{{ ($i18n.locale === 'bn') ? form.organization_ministry_division_bn : form.organization_ministry_division }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th style="padding-top: 35px">{{ $t('researchRequestManagement.contract_sign') + ' ' + $t('globalTrans.date')}} <span class="text-danger">*</span></b-th>
                  <b-td>
                    <ValidationProvider name="Contract Date" vid="contract_date" rules="required">
                    <b-form-group
                      label-for="contract_date"
                      slot-scope="{ valid, errors }"
                    >
                    <date-picker
                      id="contract_date"
                      v-model="form.contract_date"
                      modelValue=null
                      class="form-control"
                      :class="errors[0] ? 'is-invalid' : ''"
                      :placeholder="$t('globalTrans.select_date')"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </date-picker>
                    <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card v-if="budgetInfoCheck">
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.budget_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Amount" vid="contract_amount" rules="required">
                    <b-form-group
                      label-for="contract_amount"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('researchRequestManagement.contract_amount')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      id="contract_amount"
                      v-model="contract_amount"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="validated == 1"
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remaining Amount" vid="remaining_amount">
                    <b-form-group
                      label-for="remaining_amount"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('research_execution.remaining_amount')}}
                    </template>
                    <b-form-input
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      id="remaining_amount"
                      v-model="form.remaining_amount"
                      :state="errors[0] ? false : (valid ? true : null)"
                      disabled
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row>
                <b-col xs="12" sm="12" md="3">
                  <ValidationProvider name="Installment" vid="installment_id">
                    <b-form-group
                      label-for="installment_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('researchRequestManagement.installment')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="budget_details.installment_id"
                      :options="budgetInstallmentList"
                      id="installment_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option disabled :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="3">
                  <ValidationProvider name="Payment For" vid="payment_for" v-slot="{ errors }">
                    <b-form-group
                      label-for="payment_for">
                      <template v-slot:label>
                        {{ $t('researchRequestManagement.payment_for') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        type="text"
                        id="payment_for"
                        v-model="budget_details.payment_for"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="3">
                  <ValidationProvider name="Installment Amount" vid="installment_amount" v-slot="{ errors }">
                    <b-form-group
                      label-for="installment_amount">
                      <template v-slot:label>
                        {{ $t('researchRequestManagement.installment_amount') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        @input="installmentCalculation(budget_details.installment_amount)"
                        id="installment_amount"
                        v-model="budget_details.installment_amount"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                       <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="1">
                  <div class="w-100 h-100 d-grid">
                    <b-button v-if="locationIndex !== ''" variant="danger" class="btn-sm" @click="cancelBudgetLocation()">{{ $t('globalTrans.cancel') }}</b-button>
                    <b-button variant="success" class="m-auto btn-sm" @click="addItem()">{{ locationIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
                  </div>
                </b-col>
              </b-row>
              <hr>
              <b-row>
                <b-col xl="12" lg="8" sm="8">
                  <b-table-simple bordered>
                    <thead class="text-white bg-primary">
                      <tr>
                        <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.installment') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.payment_for') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.installment_amount') }}</th>
                        <th class="text-center">{{ $t('globalTrans.action') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                      <b-tr v-for="(item, index) in budget" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td> {{ getInstallmentName(item.installment_id) }} </b-td>
                        <b-td> {{ item.payment_for }} </b-td>
                        <b-td> {{ $n(item.installment_amount, { useGrouping: false }) }} </b-td>
                        <b-td class="text-center">
                          <span class="d-flex text-center">
                            <b-button @click="editBudgetLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                            <b-button type="button" @click="deleteItem(index)" class="m-auto btn-sm" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                          </span>
                        </b-td>
                      </b-tr>
                      <!-- <b-tr v-if="nodata">
                          <td colspan="7" class="text-center">
                              <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                          </td>
                      </b-tr> -->
                    </b-tbody>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card v-if="budgetInfoCheckEdit">
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.budget_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Amount" vid="contract_amount">
                    <b-form-group
                      label-for="contract_amount"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('researchRequestManagement.contract_amount')}}
                    </template>
                    <b-form-input
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      id="contract_amount"
                      v-model="contract_amount"
                      :state="errors[0] ? false : (valid ? true : null)"
                      disabled
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remaining Amount" vid="remaining_amount">
                    <b-form-group
                      label-for="remaining_amount"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('research_execution.remaining_amount')}}
                    </template>
                    <b-form-input
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      id="remaining_amount"
                      v-model="form.remaining_amount"
                      :state="errors[0] ? false : (valid ? true : null)"
                      readonly
                      ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row>
                <b-col xl="12" lg="8" sm="8">
                  <b-table-simple bordered>
                    <thead class="text-white bg-primary">
                      <tr>
                        <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.installment') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.payment_for') }}</th>
                        <th scope="col">{{ $t('researchRequestManagement.installment_amount') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                      <b-tr v-for="(item, index) in budget" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td> {{ getInstallmentName(item.installment_id) }} </b-td>
                        <b-td> {{ item.payment_for }} </b-td>
                        <b-td> {{ $n(item.installment_amount, { useGrouping: false }) }} </b-td>
                      </b-tr>
                    </b-tbody>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.document_information') }}</h4>
            </template>
            <template v-slot:body v-if="attachmentShow">
              <hr>
                <div class="row" v-for="(value, index) in attachment" :key="index">
                  <div class="col-md-1 text-center">
                    <p class="text-dark font-weight-bold"> {{index + 1}}. </p>
                  </div>
                  <div class="col-md-4">
                    <ValidationProvider name="Title (En)" :vid="`name_`+index">
                      <b-form-group
                        :label-for="`name_`+index"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{$t('meeting_management.document_title')}}
                      </template>
                      <b-form-input
                        :id="`name_`+index"
                        v-model="value.document_name"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                      </b-form-group>
                    </ValidationProvider>
                  </div>
                  <b-col xs="12" sm="12" md="5" v-if="value.attachment === undefined ">
                    <ValidationProvider name="Attachment" :vid="attachment+index" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment">
                        <template v-slot:label>
                          {{ $t('meeting_management.curriculum_vitae') }}
                        </template>
                        <b-form-file
                          accept="application/pdf,application/doc,application/docx,application/csv"
                          v-model="attachmentFile"
                          @change="onChange($event, index)"
                          :state="errors[0] ? false : (valid ? true : null)"
                          placeholder="Choose a file or drop it here..."
                          drop-placeholder="Drop file here..."
                        ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="5" v-else>
                    <ValidationProvider name="Attachment" :vid="attachment+index" v-slot="{ errors }">
                      <b-form-group
                        label-for="attachment">
                        <template v-slot:label>
                          {{ $t('meeting_management.curriculum_vitae') }}
                        </template>
                        <b-form-file
                          accept="application/pdf,application/doc,application/docx,application/csv"
                          v-model="attachmentFile"
                          @change="onChange($event, index)"
                          :state="errors[0] ? false : (valid ? true : null)"
                          placeholder="Choose a file or drop it here..."
                          drop-placeholder="Drop file here..."
                        ></b-form-file>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                    <!-- <a target="_blank" v-if="attachmentDownload" :href="bftiResReportServiceBaseUrl + value.attachment">{{ $t('bfti.attachment_down')}}</a> -->
                    <b-button variant="success" v-if="value.attachment && value.id" class="btn-sm" target="_blank" :href="bftiResReportServiceBaseUrl + value.attachment">{{ $t('bfti.attachment_down') }}</b-button>
                  </b-col>
                  <div class="col-md-2">
                    <div class="w-100 h-100 d-grid">
                      <b-button v-if="index === 0" type="button" class="m-auto btn-sm" @click="addAttachment" variant="primary"><i class="ri-add-line p-0 m-0"></i></b-button>
                      <b-button v-if="index !== 0" type="button" class="m-auto btn-sm" @click="removeAttachment(index)" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                    </div>
                  </div>
                </div>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
              <b-button v-if="!finalSave" type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.update') }}</b-button>
              <b-button v-if="finalSave" type="submit" variant="success" class="mr-2 btn-sm" @click="form.status = 2">{{ $t('configuration.final_save') }}</b-button>
              <b-button v-if="finalSave" type="submit" variant="success" class="mr-2 btn-sm" @click="form.status = 3">{{ $t('configuration.save_draft') }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { contractSigningUpdate, contractSignEditApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      finalSave: true,
      budgetInfoCheck: true,
      budgetInfoCheckEdit: false,
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      attachmentDownload: false,
      attachmentShow: true,
      budget: [],
      locationIndex: '',
      valid: null,
      saveBtnName: this.$t('configuration.final_save'),
      errors: [],
      form: {
        document_type_id: 0,
        contract_date: '',
        remaining_amount: 0,
        status: 0
      },
      budget_details: {
        installment_id: 0,
        payment_for: '',
        installment_amount: ''
      },
      contract_amount: 0,
      budget_amount: 0,
      attachmentFile: [],
      attachment: [
        {
          document_name: '',
          attachment: ''
        }
      ],
      validated: 0
    }
  },
  created () {
    if (this.id) {
      const tmp = this.editInformation()
      this.form = tmp
    }
  },
  computed: {
    budgetInstallmentList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.filter(item => item.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    editInformation () {
      const loadingState = { loading: true, listReload: false }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { id: this.id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignEditApi, params).then(response => {
        if (response.success) {
          if (response.data.budgets.length > 0) {
            this.form = response.data
            this.budget = response.data.budgets
            this.contract_amount = response.data.contract_amount
            if (response.data.documents.length > 0) { // documents check
              this.attachment = response.data.documents
              this.attachmentDownload = true
            }
            if (response.data.status === 2) {
              this.finalSave = false
              this.budgetInfoCheck = false
              this.budgetInfoCheckEdit = true
            }
          } else {
            const form = this.getInfo()
            form.remaining_amount = 0
            this.form = form
            this.attachmentDownload = false
          }
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    installmentList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.filter(item => item.status === 1)
    },
    async saveUpdate () {
      this.$refs.form.reset()
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const params = Object.assign({}, { form: this.form, budget: this.budget, attachment: this.attachment, contractAmount: this.contract_amount })
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${contractSigningUpdate}/${this.id}`, params)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    deleteItem (index) {
      this.budget.splice(index, 1)
      if (this.budget.length === 0) {
        this.nodata = true
      }
      if (this.nodata === true) {
        this.budgetInstallmentList = this.installmentList()
      }
    },
    async addItem () {
      if (this.budget_details.installment_id && this.budget_details.installment_id && this.budget_details.installment_id) {
        this.validated = 1
        const d = this.budget_details.installment_id
        let result = []
        if (this.locationIndex !== '') {
            const editList = [...this.budget]
            editList.splice(parseInt(this.locationIndex), 1)
            result = [...editList]
        } else {
            result = this.budget
        }

        const nameEn = this.budget_details.org_name
        const newData = result.find(item => item.org_name === nameEn)
        if (typeof newData === 'undefined') {
            if (this.locationIndex !== '') {
                this.budget[parseInt(this.locationIndex)] = this.budget_details
            } else {
                this.budget.push(JSON.parse(JSON.stringify(this.budget_details)))
            }

            this.budget_details = {}
            this.locationIndex = ''
        } else {
              if (this.locationIndex !== '') {
                this.budget[parseInt(this.locationIndex)] = this.budget_details
            } else {
                this.budget.push(JSON.parse(JSON.stringify(this.budget_details)))
            }

            this.budget_details = {}
            this.locationIndex = ''
        }
        this.nodata = false
        if (this.nodata === false) {
          this.budgetInstallmentList = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.filter(item => item.value === d)
          this.budget_details.installment_id = d
        } else {
            this.budgetInstallmentList = this.installmentList()
        }
        this.budget_details = {
          installment_id: 0,
          payment_for: '',
          installment_amount: ''
        }
        this.$refs.form.reset()
        let budget = 0
        this.budget.map(item => {
          budget += parseInt(item.installment_amount)
        })
        this.budget_amount = budget
        this.form.remaining_amount = this.contract_amount - this.budget_amount
      }
    },
    cancelBudgetLocation () {
      this.budget_details = {}
      this.locationIndex = ''
      this.$refs.form.reset()
    },
    editBudgetLocation (item, index) {
      this.budget_details = Object.assign({}, item)
      this.locationIndex = index
    },
    onChange (event, index) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.attachment[index].attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
         this.attachment[index].attachment = null
      }
    },
    addAttachment () {
      const tmpAtt = {
        document_name: ''
      }
      this.attachment.push(tmpAtt)
    },
    removeAttachment (index) {
      this.attachment.splice(index, 1)
    },
    installmentCalculation (amount) {
      const totContractAmount = parseInt(this.contract_amount)
      if (this.budget) {
        let budgetInstallmentAmount = 0

        this.budget.map((item, index) => {
          if (this.locationIndex !== index) {
            budgetInstallmentAmount += parseInt(item.installment_amount)
          }
        })

        const individualInstallmentAmount = parseInt(this.budget_details.installment_amount)
        const totIndvInstallmentAmount = budgetInstallmentAmount + individualInstallmentAmount

        if (totIndvInstallmentAmount > totContractAmount) {
          this.budget_details.installment_amount = 0
        }
        if (totIndvInstallmentAmount < totContractAmount) {
          this.budget_details.installment_amount = amount
        }
      }
    },
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
    }
  }
}
</script>
