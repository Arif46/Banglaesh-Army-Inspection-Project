
<template>
<b-container fluid>
    <b-row>
      <b-overlay :show="loading">
      <b-col sm="12">
          <!-- =================Add More Start===================== -->
          <ValidationObserver ref="InvestigatorForm" v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(investigatorAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
                <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                            <b-form-group
                                label-for="org_id"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="invesData.org_id"
                                :options="orgList"
                                id="org_id"
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
                      <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                            <b-form-group
                                label-for="designation_id"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                {{$t('globalTrans.designation')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="invesData.designation_id"
                                :options="designationList"
                                id="designation_id"
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
                      <ValidationProvider name="Employee" vid="employee_id" rules="required|min_value:1">
                            <b-form-group
                                label-for="employee_id"
                                slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                {{$t('eBizProgram.employee')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                plain
                                v-model="invesData.employee_id"
                                :options="employeeList"
                                id="employee_id"
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
                          {{arrInvestigatorItemData && arrInvestigatorItemData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
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
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.organization') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.designation') }}</div></th>
                                <th scope="col" style="width: 15%;" class="text-center"><div>{{ $t('eBizProgram.employee') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.action') }}</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="arrInvestigatorItemData && arrInvestigatorItemData.length > 0">
                                <tr v-for="(item, index) in arrInvestigatorItemData" :key="index">
                                    <td  class="text-center">{{ index+1 }}</td>
                                    <td  class="text-center">{{ getOrgnizationName(item.org_id) }}</td>
                                    <td  class="text-center">{{ currentLocale == 'en' ? item.designation_name : item.designation_name_bn}}</td>
                                    <td  class="text-center">{{ currentLocale == 'en' ? item.employee_name : item.employee_name_bn }}</td>
                                    <td class="text-center">
                                        <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="investigatorItemRemove(index)" class="action-btn delete"><i class="ri-delete-bin-2-line"></i></b-button>
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
                      <ValidationProvider name="Remark" vid="remarks" v-slot="{ errors }" rules="required">
                          <b-form-group
                              label-for="remarks">
                              <template v-slot:label>
                                {{ $t('globalTrans.remark') }} <span class="text-danger">*</span>
                              </template>
                            <b-form-textarea
                                  id="remarks"
                                  rows="3"
                                  v-model="formData.remarks"
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
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('investigator-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
  </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { investigatorSave, investigatorUpdate, designationWiseUser } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('eBizProgram.assign'),
      errors: [],
      officerLoading: false,
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      formData: {
        remarks: '',
        InvestigatorDataArr: []
      },
      invesData: {
        org_id: 0,
        designation_id: 0,
        designation_name: '',
        designation_name_bn: '',
        employee_id: 0,
        employee_name: '',
        employee_name_bn: ''
      },
      arrInvestigatorItemData: [],
      itemList: [],
      designationList: [],
      employeeList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
    }
    if (this.items) {
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
      return this.$store.state.CommonService.commonObj.orgProfileList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      }).filter(item => item.value === 8)
    }
  },
  watch: {
    'invesData.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.designationList = this.getDesignationList(newVal)
      }
    },
    'invesData.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.employeeList = this.getEmployeeList(newVal, this.invesData.org_id)
      }
    }
  },
  methods: {
    getDesignationList (orgId) {
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.status === 1 && item.org_id === parseInt(orgId)).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn, text_en: obj.text_en, text_bn: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en, text_en: obj.text_en, text_bn: obj.text_bn }
        }
      })
    },
    // ================Edu Info Start=================
        async investigatorAddItem () {
               const desigObj = this.designationList.find(item => item.value === this.invesData.designation_id)
               const empObj = this.employeeList.find(item => item.value === this.invesData.employee_id)
               var obj = {
                    org_id: this.invesData.org_id,
                    designation_id: this.invesData.designation_id,
                    designation_name: desigObj !== undefined ? desigObj.text_en : '',
                    designation_name_bn: desigObj !== undefined ? desigObj.text_bn : '',
                    employee_id: this.invesData.employee_id,
                    employee_name: empObj !== undefined ? empObj.text_en : '',
                    employee_name_bn: empObj !== undefined ? empObj.text_bn : ''
                }
                      if (this.invesData.key === undefined) {
                        const extItem = this.formData.InvestigatorDataArr.find(eItm => eItm.employee_id === this.invesData.employee_id)
                        if (extItem === undefined) {
                          this.formData.InvestigatorDataArr.push(obj)
                        } else {
                          // extItem.quantity += parseFloat(this.invesData.quantity)
                        }
                      } else {
                          this.formData.InvestigatorDataArr[this.invesData.key].org_id = this.invesData.org_id
                          this.formData.InvestigatorDataArr[this.invesData.key].designation_id = this.invesData.designation_id
                          this.formData.InvestigatorDataArr[this.invesData.key].designation_name = this.invesData.designation_name
                          this.formData.InvestigatorDataArr[this.invesData.key].designation_name_bn = this.invesData.designation_name_bn
                          this.formData.InvestigatorDataArr[this.invesData.key].employee_id = this.invesData.employee_id
                          this.formData.InvestigatorDataArr[this.invesData.key].employee_name = this.invesData.employee_name
                          this.formData.InvestigatorDataArr[this.invesData.key].employee_name_bn = this.invesData.employee_name_bn
                      }
                      this.invesData = {
                          org_id: 0,
                          designation_id: 0,
                          designation_name: '',
                          designation_name_bn: '',
                          employee_id: 0,
                          employee_name: '',
                          employee_name_bn: ''
                      }
                      this.arrInvestigatorItemData = this.formData.InvestigatorDataArr
                      this.$refs.InvestigatorForm.reset()
                      this.loading = false
        },
        investigatorItemRemove (key) {
            this.formData.InvestigatorDataArr.splice(key, 1)
        },
        stockItemEdit (key) {
          this.invesData = this.formData.InvestigatorDataArr[key]
          this.invesData.editMode = true
          this.invesData.key = key
        },
        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      const isDetailsValid = await this.$refs.addMoreForm.validate()
      this.formData.InvestigatorDataArr = this.arrInvestigatorItemData
      if (isValid && isDetailsValid && this.formData.InvestigatorDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${investigatorUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, investigatorSave, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('investigator-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
    },
    getOrgnizationName (orgId) {
        const cateObj = this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).find(item => item.value === orgId)
        if (cateObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return cateObj.text_bn
            } else {
                return cateObj.text_en
            }
        }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async getEmployeeList (designationId, officeId) {
      this.officerLoading = true
        const params = {
          org_id: parseInt(officeId),
          designation_id: parseInt(designationId)
        }
        await RestApi.getData(eBizServiceBaseUrl, designationWiseUser, params)
        .then(response => {
          if (response.success) {
            const data = response.data
            this.employeeList = data.map(item => {
              return Object.assign({ value: item.user_id, text: this.$i18n.locale === 'bn' ? item.name_bn : item.name, text_bn: item.name_bn, text_en: item.name })
            })
          } else {
            this.employeeList = []
          }
          this.officerLoading = false
      })
    }
  }
}
</script>
