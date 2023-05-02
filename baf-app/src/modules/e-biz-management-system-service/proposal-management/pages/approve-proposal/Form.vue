<template>
 <div class="inner-section">
      <b-container fluid>
        <b-overlay :show="loading">
          <b-row>
            <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                    <b-col sm="12" class="mt-3">
                      <!-- Proposal Details -->
                        <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center">
                                          <div>{{ $t('associationPanel.program_name') }}</div>
                                        </th>
                                        <th scope="col" class="text-center">
                                          <div>{{ $t('associationPanel.duration') }}</div>
                                        </th>
                                        <th scope="col" class="text-center">
                                          <div>{{ $t('eBizProposal.amount') }}</div>
                                        </th>
                                        <th scope="col" class="text-center">
                                          <div>{{ $t('eBizProposal.approve_amount') }}</div>
                                        </th>
                                        <th scope="col" class="text-center">
                                          <div>{{ $t('globalTrans.attachment') }}</div>
                                        </th>
                                        <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="items.details && items.details.length > 0">
                                        <tr v-for="(item, index) in items.details" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td style="width: 30%" class="text-center">{{ currentLocale == 'en' ? item.programe_name_en : item.programe_name_bn }}</td>
                                            <td style="width: 15%" class="text-center" >{{ $n(item.duration)}}</td>
                                            <td style="width: 20%" class="text-center" > {{ $n(item.amount) }} </td>
                                            <td style="width: 40%" class="text-center" >
                                                <ValidationProvider name="Approve Amount" :vid="`approve_amount${index}`" :rules="`required|min_value:1|max_value: ${item.amount}`" v-slot="{ errors }">
                                                  <b-form-group
                                                    :label-for="`approve_amount${index}`">
                                                    <b-form-input
                                                      id="approve_amount"
                                                      v-model.number="item.approve_amount"
                                                      @keyup="calculateApproveAmount()"
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
                                                <b-button v-if="item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="programProposalRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
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
                  </b-col>
                        <!-- Proposal Details -->
                <div class="row">
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                        <ValidationProvider name="Total Demanded Budget Amount" vid="total_demanded_budget_amount" rules="required" v-slot="{ errors }">
                          <b-form-group
                            label-for="total_demanded_budget_amount">
                            <template v-slot:label>
                              {{ $t('eBizProposal.demanded_budget_amount') }}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="total_demanded_budget_amount"
                              v-model.number="formData.total_demanded_budget_amount"
                              oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              disabled
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Total Approve Budget" vid="total_approve_budget" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="total_approve_budget">
                          <template v-slot:label>
                            {{ $t('eBizProposal.approve_budget') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="total_approve_budget"
                            v-model="formData.total_approve_budget"
                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
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
                    <ValidationProvider name="Attachment" vid="attachment" rules="">
                      <b-form-group
                        label-for="attachment"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{ $t('globalTrans.attachment') }}
                        </template>
                      <b-form-file id="attachment"
                      v-model="formData.file"
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
                </div>
                </b-form>
            </ValidationObserver>
          </b-row>
          <b-row class="text-right mb-3">
            <b-col>
                <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm"  @click="cancelModal()">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-overlay>
     </b-container>
  </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { proposalApprove } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'items'],
  components: { },
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.approve'),
      errors: [],
      formData: {
        circular_notice_id: this.id,
        total_demanded_budget_amount: '',
        total_approve_budget: '',
        file: [],
        attachment: ''
      },
      eBizServiceBaseUrl: eBizServiceBaseUrl
    }
  },
  created () {
    if (this.items?.id) {
      this.formData.details = this.items.details
    }
    if (this.items.details.length > 0) {
      this.formData.total_demanded_budget_amount = this.items.details.reduce((total, item) => total + parseFloat(item.amount), 0)
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.formData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.formData.attachment = ''
        }
    },
      calculateApproveAmount () {
        const approveBudget = this.items.details.reduce((total, item) => total + parseFloat(item.approve_amount), 0)
        this.formData.total_approve_budget = parseFloat(approveBudget)
      },
        programProposalRemove (key) {
            this.items.details.splice(key, 1)
            this.calculateApproveAmount()
        },
        // ================Edu Info End===================
      cancelModal () {
          this.items.details.map(item => {
              item.approve_amount = ''
          })
         this.$bvModal.hide('edit-form')
      },
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.items.details.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.items?.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${proposalApprove}/${this.items.id}`, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.items?.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('edit-form')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    }
  }
}
</script>
