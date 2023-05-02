<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
        <ValidationObserver ref="searchForm" v-slot="{ handleSubmit, reset }">
          <b-form  @submit.prevent="handleSubmit(saveLabAssign)"  @reset.prevent="reset" >
            <b-overlay :show="saveloading">
              <template>
                <div style="font-size:18px; background-color: #005B5B;margin-bottom: 12px">
                  <h5 class="text-white ml-2"> {{ $t('li_step.lab_assign') }} </h5>
                </div>
              </template>
              <hr/>
             <b-row>
               <b-col lg="12" md="12" sm="12">
                 <h4>{{ $t('li_step.sample_number') }} : {{ appDetails.sample_number }}</h4>
               </b-col>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="Lab" vid="lab_id" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="lab_id"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('li_step.lab_name')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="tmpDetails.lab_id"
                        :options="labList"
                        id="lab_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="Officer" vid="officer_id" rules="required|min_value:1">
                      <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="officer_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('budget.officer')}}
                          </template>
                          <b-form-select
                          plain
                          v-model="tmpDetails.officer_id"
                          :options="officerList"
                          id="officer_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                              <b-form-select-option :value="0">{{ officerLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                          </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                          {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="3" sm="3">
                  <ValidationProvider name="InGrident" vid="ingrident_id" rules="required">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="ingrident_id"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('li_step.ingredient_name')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="tmpDetails.ingrident_id"
                        :options="ingridentList"
                        @change="getIngridentAmount(tmpDetails.ingrident_id)"
                        id="ingrident_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                  <b-col lg="3" md="3" sm="12" xs="12">
                    <ValidationProvider name="Amount" vid="amount" rules="required">
                      <b-form-group class="row"
                          label-cols-sm="12"
                          label-for="amount"
                          slot-scope="{ valid, errors }"
                          >
                        <template v-slot:label>
                          {{$t('li_step.amount')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                        type="text"
                        readOnly
                        id="amount"
                        v-model="tmpDetails.amount"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xl="2" lg="12" sm="4" class="mt-4" >
                      <b-button variant=" iq-bg-success" size="sm" @click="add()" style="margin-top: 15px;"><i class="ri-add-line m-0"></i>{{$t('common_config.add_more')}}</b-button>
                  </b-col>
              </b-row>
              <hr>
               <b-row>
                  <b-table-simple  bordered>
                      <thead>
                          <tr class="bg-primary">
                              <th width="100px">{{ $t('globalTrans.sl_no') }}</th>
                              <th>{{ $t('li_step.lab_name') }}</th>
                              <th>{{ $t('li_step.ingredient_name') }}</th>
                              <th>{{ $t('li_step.amount') }}</th>
                              <th>{{ $t('globalTrans.action') }}</th>
                          </tr>
                      </thead>
                      <b-tbody>
                          <b-tr v-for="(item, index) in labAssign.details" :key="index">
                              <b-td>
                                  {{ $n(index + 1) }}
                              </b-td>
                              <b-td>
                                  <ValidationProvider vid="lab_id">
                                      <b-form-group
                                          slot-scope="{ valid, errors }"
                                      >
                                          <b-form-select
                                              disabled
                                              plain
                                              id="lab_id"
                                              v-model="item.lab_id"
                                              :options="labList"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-select>
                                          <div class="invalid-feedback">
                                              {{ errors[0] }}
                                          </div>
                                      </b-form-group>
                                  </ValidationProvider>
                              </b-td>
                              <b-td>
                                  <ValidationProvider vid="ingrident_id">
                                      <b-form-group
                                          slot-scope="{ valid, errors }"
                                      >
                                          <b-form-select
                                              disabled
                                              plain
                                              id="ingrident_id"
                                              v-model="item.ingrident_id"
                                              :options="ingridentList"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-select>
                                          <div class="invalid-feedback">
                                              {{ errors[0] }}
                                          </div>
                                      </b-form-group>
                                  </ValidationProvider>
                              </b-td>
                              <b-td>
                                  <ValidationProvider vid="amount">
                                      <b-form-group
                                          slot-scope="{ valid, errors }"
                                      >
                                          <b-form-input class="form-control"
                                              disabled
                                              v-model="item.amount"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-input>
                                          <div class="invalid-feedback">
                                              {{ errors[0] }}
                                          </div>
                                      </b-form-group>
                                  </ValidationProvider>
                              </b-td>
                              <b-td>
                                  <b-button type="button" @click="remove(index)" class="btn btn- iq-bg-danger btn-sm text-center ml-1"><i class="ri-delete-bin-line m-0"></i></b-button>
                              </b-td>
                          </b-tr>
                      </b-tbody>
                        <b-tr>
                          <th colspan="2" class="text-center">{{ $t('li_step.total_amount') }}</th>
                          <b-td colspan="2"> {{ getTotal(labAssign.details) }} </b-td>
                        </b-tr>
                  </b-table-simple>
                </b-row>
              <b-row>
              </b-row>
            </b-overlay>
              <div class="row">
                  <div class="col-sm-3"></div>
                    <div class="col text-right">
                        <b-button type="submit" @click="labAssign.save_status = 1" variant="warning" class="mr-2">{{ $t('globalTrans.draft') }}</b-button>
                        &nbsp;
                        <b-button type="submit" @click="labAssign.save_status = 2" variant="primary" class="mr-2">{{ $t('globalTrans.save') }}</b-button>
                        &nbsp;
                      <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-1')">{{ $t('globalTrans.cancel') }}</b-button>
                    </div>
                </div>
          </b-form>
        </ValidationObserver>
      </template>
    </iq-card>
  </b-container>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { designationWiseUser, daeLabAssignStore, daeLabAssignUpdate, assignDataApi } from '../../api/routes'
export default {
  props: ['appDetails'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      labAssign: {
        sample_number: '',
        total_amount: '',
        details: [],
        org_id: 0,
        application_id: 0,
        service_id: 0,
        step_id: 0,
        next_step: 0,
        type: 0,
        user_id: '',
        feeInfo: {
          fee_name: 'Lab Fee',
          fee_name_bn: 'ল্যাব ফি',
          vat: 0,
          tax: 0,
          amount_vat: 0,
          amount_tax: 0
        },
        save_status: 1
      },
      tmpDetails: {
        lab_id: 0,
        officer_id: 0,
        designation_id: 0,
        ingrident_id: 0,
        amount: ''
      },
      saveloading: false,
      checkAssign: false,
      total: 0,
      officerList: [],
      officerLoading: false,
      labAssignId: ''
    }
  },
  created () {
    if (this.appDetails) {
      this.labAssign.sample_number = this.appDetails.sample_number
      this.labAssign.next_step = this.getServiceWiseStep(this.appDetails.service_id, this.appDetails.current_step)
      this.labAssign.org_id = this.appDetails.org_id
      this.labAssign.application_id = this.appDetails.application_id
      this.labAssign.service_id = this.appDetails.service_id
      this.labAssign.step_id = this.appDetails.current_step
      this.labAssign.type = this.appDetails.type
      this.labAssign.user_id = this.appDetails.user_id
      this.getVatTax()
    }
    this.labAssignData(this.labAssign.application_id)
  },
  mounted () {
  },
  watch: {
    'labAssign.total_amount': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getVatTaxAmount(newVal)
      }
    },
    'tmpDetails.lab_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.tmpDetails.officer_id = 0
        this.getOfficerList(newVal)
      }
    },
    'tmpDetails.officer_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const officer = this.officerList.find(item => item.value === newVal)
        this.tmpDetails.designation_id = officer.designation_id
      }
    }
  },
  computed: {
    local: function () {
        return this.$i18n.locale
    },
    labList: function () {
       return this.$store.state.licenseRegistration.commonObj.labList.filter(item => item.status === 1)
    },
    ingridentList: function () {
      return this.$store.state.licenseRegistration.commonObj.activeIngredientList.filter(item => item.status === 1)
    }
  },
  methods: {
    async getOfficerList (labId) {
      const lab = this.labList.find(item => item.value === labId)
      const officeId = lab.office_id
      this.officerLoading = true
        const params = {
          org_id: parseInt(this.labAssign.org_id),
          office_id: parseInt(officeId)
        }
        await RestApi.getData(licenseRegistrationServiceBaseUrl, designationWiseUser, params)
        .then(response => {
          if (response.success) {
            const data = response.data
            this.officerList = data.map(item => {
              return Object.assign({ value: item.user_id, designation_id: item.designation_id, text: this.$i18n.locale === 'bn' ? item.name_bn : item.name })
            })
          } else {
            this.officerList = []
          }
          this.officerLoading = false
      })
    },
    labAssignData (applicationID) {
      this.saveloading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, `${assignDataApi}/${applicationID}`).then(response => {
        if (response.success) {
          if (response.data.length > 0) {
            this.checkAssign = true
          }
          this.getRelationData(response.data)
        }
        this.saveloading = false
      })
    },
    getRelationData (data) {
      data.map((item, index) => {
        this.labAssignId = item.id
        this.labAssign.sample_number = item.sample_number
        item.lab_details.map(item2 => {
          const items = {
            lab_id: item2.lab_id,
            officer_id: item2.officer_id,
            designation_id: item2.designation_id,
            ingrident_id: item2.ingrident_id,
            amount: item2.amount
         }
         this.labAssign.details.push(items)
        })
      })
    },
    getVatTax () {
      const vatfind = this.$store.state.licenseRegistration.commonObj.stepFeeList.find(item => item.lab_fee === 1 && item.service_id === this.labAssign.service_id && item.step_id === this.labAssign.next_step)
      this.labAssign.feeInfo.vat = vatfind.vat
      this.labAssign.feeInfo.tax = vatfind.tax
    },
    getVatTaxAmount (amount) {
      this.labAssign.feeInfo.amount_vat = (amount * (this.labAssign.feeInfo.vat ? parseInt(this.labAssign.feeInfo.vat) : 0)) / 100
      this.labAssign.feeInfo.amount_tax = (amount * (this.labAssign.feeInfo.tax ? parseInt(this.labAssign.feeInfo.tax) : 0)) / 100
    },
    add () {
      if (this.tmpDetails.officer_id !== 0) {
        const items = {
          lab_id: parseInt(this.tmpDetails.lab_id),
          officer_id: parseInt(this.tmpDetails.officer_id),
          designation_id: parseInt(this.tmpDetails.designation_id),
          ingrident_id: this.tmpDetails.ingrident_id,
          amount: this.tmpDetails.amount
        }
        this.labAssign.details.push(items)
      }
    },
    remove (index) {
        this.labAssign.details.splice(index, 1)
    },
    async saveLabAssign () {
      let result = null
      this.saveloading = true
      if (this.checkAssign) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${daeLabAssignUpdate}/${this.labAssignId}`, this.labAssign)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, daeLabAssignStore, this.labAssign)
      }
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-1')
        this.$store.dispatch('licenseRegistration/setLaodList', true)
      } else {
        this.$refs.form.setErrors(result.errors)
      }
     this.saveloading = false
    },
    getIngridentAmount (ingridentId) {
      const ingrident = this.$store.state.licenseRegistration.commonObj.activeIngredientList.find(item => item.value === ingridentId)
      this.tmpDetails.amount = typeof ingrident !== 'undefined' ? ingrident.amount : 0
    },
    getTotal (items) {
      let total = 0
      if (items.length > 0) {
        items.forEach(item => {
          total = total + parseInt(item.amount)
        })
      }
      this.labAssign.total_amount = total
      return this.$n(total)
    },
    getServiceWiseStep (serviceId, stepId) {
        const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(stepId))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
    }
  }
}
</script>
<style scoped>
.vue-grid-item .resizing {
    opacity: 0.9;
}
.vue-grid-item .text {
    font-size: 24px;
    text-align: center;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    height: 100%;
    width: 100%;
}
.vue-grid-item .no-drag {
    height: 100%;
    width: 100%;
}
.vue-grid-item .minMax {
    font-size: 12px;
}
.fields {
  padding: 0.375rem 0.75rem;
}
.fields:hover {
  z-index: 1;
  color: #fff;
  background-color: #5a6268;
  border-radius: 0.25rem;
}
.dark_button .btn-secondary {
  color: #000 !important;
}
hr {
    border: none;
    border-top: 3px double #333;
    color: #333;
    overflow: visible;
    text-align: center;
    height: 5px;
}
hr:after {
    background: #fff;
    content: '';
    padding: 0 4px;
    position: relative;
    top: -13px;
}
</style>
