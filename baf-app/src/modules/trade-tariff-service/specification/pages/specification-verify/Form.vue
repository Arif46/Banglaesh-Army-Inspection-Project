<template>
    <div class="inner-section">
      <card>
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">Offer Vetting</h4>
        </template>
        <b-container fluid>
          <b-row>
              <b-overlay :show="loading">
                <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
                  <b-form @submit.prevent="handleSubmit(demandWiseData)" @reset.prevent="reset" autocomplete="off">
                    <b-row>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                        <ValidationProvider name="Indent No" vid="demand_no" v-slot="{ errors }" rules="required">
                          <b-form-group
                            label-for="alert_percentage">
                            <template v-slot:label>
                            Indent No <span class="text-center">*</span>
                            </template>
                            <b-form-input
                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                            id="demand_no"
                            v-model="searchDemand.demand_no"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                        <b-button size="sm" type="submit" :disabled="is_disable" variant="primary" class="mt-20">
                          <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                        </b-button>
                      </b-col>
                    </b-row>
                  </b-form>
                </ValidationObserver>
                <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                  <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                    <template v-if="showData">
                      <b-overlay :show="loader">
                        <b-row>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Supplier Name" vid="supplier_name" rules="required" v-slot="{ errors }">
                              <b-form-group
                                label-for="supplier_name">
                                <template v-slot:label>
                                Supplier Name <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                  id="supplier_name"
                                  v-model="formData.supplier_name"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Date" vid="offer_date" rules="required" v-slot="{ errors }">
                              <b-form-group
                                label-for="offer_date"
                              >
                                <template v-slot:label>
                                  Offer Date <span class="text-danger">*</span>
                                </template>
                                <date-picker
                                  id="offer_date"
                                  class="form-control"
                                  v-model="formData.offer_date"
                                  :placeholder="$t('globalTrans.select')"
                                >
                                </date-picker>
                                <div class="invalid-feedback d-block">
                                    {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                        <b-row>
                          <template>
                            <div class="table-wrapper table-responsive">
                                <table class="table table-striped table-bordered">
                                  <b-thead>
                                    <tr>
                                        <b-th class="text-center" width="7%">SL NO</b-th>
                                        <b-th class="text-center" width="15%">Description</b-th>
                                        <b-th class="text-center" width="15%">Specification Specified</b-th>
                                        <b-th class="text-center" width="20%">Received Specification</b-th>
                                        <b-th class="text-center" width="20%">Verify Action</b-th>
                                        <b-th class="text-center" width="20%">Reason</b-th>
                                    </tr>
                                  </b-thead>
                                  <b-tbody>
                                    <template v-if="formData.specification_details">
                                      <template v-for="(item, index) in formData.specification_details">
                                        <b-tr :key="'parent' + index">
                                          <b-td class="text-center">{{ index+1 }}</b-td>
                                          <b-td class="text-left">{{ item.s_description }}</b-td>
                                          <b-td class="text-left">{{ item.s_specified }}</b-td>
                                          <b-td>
                                            <ValidationProvider name="Received Specification" vid="received_specification" v-slot="{ errors }" rules="required" v-if="!item.childs.length">
                                              <b-form-group
                                                label-for="received_specification"
                                                >
                                                <b-form-input
                                                id="received_specification"
                                                v-model="item.received_specification"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                          <b-td>
                                            <ValidationProvider name="verify Status" vid="verify_status" rules="required|min_value:1" v-slot="{ errors }" v-if="!item.childs.length">
                                              <b-form-group
                                                label-for="verify_status">
                                                <b-form-select
                                                  plain
                                                  id="verify_status"
                                                  :options="verifyStatusList"
                                                  v-model="item.verify_status"
                                                  :state="errors[0] ? false : (valid ? true : null)"
                                                  @change="getTotalInfo(index)"
                                                >
                                                  <template v-slot:first>
                                                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                                    <!-- <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option> -->
                                                  </template>
                                                </b-form-select>
                                                <div class="invalid-feedback">
                                                  {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                          <b-td>
                                            <ValidationProvider name="Reason" vid="reason" v-slot="{ errors }" v-if="!item.childs.length">
                                              <b-form-group
                                                label-for="reason">
                                                <b-form-textarea
                                                  id="reason"
                                                  v-model="item.reason"
                                                  :state="errors[0] ? false : (valid ? true : null)"
                                                  :disabled="item.verify_status !== 3"
                                                ></b-form-textarea>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                        </b-tr>
                                        <b-tr v-for="(childItem, childIndex) in item.childs" :key="'childs' + childIndex">
                                          <b-td v-if="childIndex === 0" class="text-center" :rowspan="item.childs.length"></b-td>
                                          <b-td class="text-left">{{ (childIndex + 10).toString(36) }}) {{ childItem.s_description }}</b-td>
                                          <b-td class="text-left">{{ childItem.s_specified }}</b-td>
                                          <b-td>
                                            <ValidationProvider name="Received Specification" :vid="`received_specification${childIndex}`" v-slot="{ errors }" rules="required">
                                              <b-form-group
                                                :label-for="`received_specification${childIndex}`"
                                                >
                                                <b-form-input
                                                id="received_specification"
                                                v-model="childItem.received_specification"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                          <b-td>
                                            <ValidationProvider name="verify Status" :vid="`verify_status${childIndex}`" rules="required|min_value:1" v-slot="{ errors }">
                                              <b-form-group
                                                :label-for="`verify_status${childIndex}`">
                                                <b-form-select
                                                  plain
                                                  id="verify_status"
                                                  :options="verifyStatusList"
                                                  v-model="childItem.verify_status"
                                                  :state="errors[0] ? false : (valid ? true : null)"
                                                  @change="getTotalInfo(index, childIndex)"
                                                >
                                                  <template v-slot:first>
                                                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                                  </template>
                                                </b-form-select>
                                                <div class="invalid-feedback">
                                                  {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                          <b-td>
                                            <ValidationProvider name="Reason" vid="reason" v-slot="{ errors }">
                                              <b-form-group
                                                label-for="alert_percentage">
                                                <b-form-textarea
                                                  id="reason"
                                                  v-model="childItem.reason"
                                                  :state="errors[0] ? false : (valid ? true : null)"
                                                  :disabled="childItem.verify_status !== 3"
                                                ></b-form-textarea>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </b-td>
                                        </b-tr>
                                        <b-tr v-if="item.has_blank_row" :key="'p-black-row-' + index">
                                            <b-td colspan="6" class="text-center">{{ item.blank_row_text }}</b-td>
                                        </b-tr>
                                      </template>
                                    </template>
                                    <template v-else>
                                      <b-tr>
                                        <b-td class="text-center text-danger" colspan="6">Data Not Found</b-td>
                                      </b-tr>
                                    </template>
                                  </b-tbody>
                                </table>
                            </div>
                          </template>
                        </b-row>
                        <b-row>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Total Fully Comply" vid="total_fully_comply" v-slot="{ errors }">
                              <b-form-group
                                label-for="alert_percentage">
                                <template v-slot:label>
                                  Total Fully Comply
                                </template>
                                <b-form-input
                                style="background-color:#c8ebc8;"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                id="total_fully_comply"
                                v-model="formData.total_fully_comply"
                                :state="errors[0] ? false : (valid ? true : null)"
                                readonly
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Total Partially Comply" vid="total_partially_comply" v-slot="{ errors }">
                              <b-form-group
                                label-for="alert_percentage">
                                <template v-slot:label>
                                Total Partially Comply
                                </template>
                                <b-form-input
                                style="background-color:#9f9f51;"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                id="total_partially_comply"
                                v-model="formData.total_partially_comply"
                                :state="errors[0] ? false : (valid ? true : null)"
                                readonly
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                            <ValidationProvider name="Total Reject" vid="total_reject" v-slot="{ errors }">
                              <b-form-group
                                label-for="alert_percentage">
                                <template v-slot:label>
                                Total Reject
                                </template>
                                <b-form-input
                                style="background-color:#d58686;"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                id="total_reject"
                                v-model="formData.total_reject"
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
                          <b-col xl="4" lg="4" md="4" sm="12">
                            <ValidationProvider name="Result" vid="result_id">
                              <b-form-group
                                class="row"
                                label-for="result_id"
                                slot-scope="{ valid, errors }">
                                <template v-slot:label>
                                  Result <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                  plain
                                  v-model="formData.result_id"
                                  :options="resultList"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                >
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                                </b-form-select>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="attachement" vid="attachement">
                                <b-form-group
                                  label-for="attachement"
                                  slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                 Attachment <span style="font-size:9px" class="text-danger"> Maximum Size (5MB) & Accepted Format (pdf, docx)</span>
                                </template>
                                <b-input-group>
                                  <b-form-file
                                    validate="size:10"
                                    id="photo"
                                    v-model="formData.attachement"
                                    @change="onChange"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    placeholder="Choose a file or drop it here"
                                    drop-placeholder="Drop file here..."
                                  ></b-form-file>
                                  <b-input-group-append v-if="formData.attachement">
                                    <a target="_blank" :href="InspectionServiceBaseUrl+formData.attachement" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                                  </b-input-group-append>
                                </b-input-group>
                                <div class="d-block invalid-feedback">
                                  {{ errors[0] }}
                                  {{ fileValidationMsz }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                        <b-row class="text-right mb-3">
                            <b-col>
                              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                              <router-link class="btn-sm btn btn-danger" to="specification-verify">{{ $t('globalTrans.cancel') }}</router-link>
                            </b-col>
                        </b-row>
                      </b-overlay>
                    </template>
                  </b-form>
                </ValidationObserver>
              </b-overlay>
          </b-row>
        </b-container>
      </card>
    </div>
</template>
<script>
import RestApi, { InspectionServiceBaseUrl } from '@/config/api_config'
import { specificationDemandWiseSearch, specificationVerifyStore, specificationVerifyShow, specificationVerifyUpdate } from '../../api/routes'

export default {
  components: {
  },
  name: 'Form',
  props: ['id'],
  data () {
    return {
      InspectionServiceBaseUrl: InspectionServiceBaseUrl,
      valid: null,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      loading: false,
      is_disable: false,
      value: '',
      searchDemand: {
        demand_no: ''
      },
      formData: {
        id: '',
        supplier_name: '',
        total_fully_comply: '',
        total_partially_comply: '',
        total_reject: '',
        attachement: '',
        result_id: 0,
        specification_details: []
      },
      showData: false,
      loader: false,
      reasonStatus: false,
      fileValidationMsz: '',
      resultList: [
          { value: 1, text: 'Accept' },
          { value: 2, text: 'Reject' }
      ]
    }
  },
  created () {
    if (this.$route.query.id) {
      this.getOfferVettingList()
      this.showData = true
      this.is_disable = true
    }
  },
  computed: {
    verifyStatusList: function () {
      const list = [
        { value: 1, text: 'Fully Comply' },
        { value: 2, text: 'Partially Comply' },
        { value: 3, text: 'Reject', color: 'green' }
      ]
      return list
    }
  },
  watch: {
  },
  methods: {
    async demandWiseData () {
      this.showData = true
      this.loader = true
      const params = Object.assign({}, this.searchDemand)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(InspectionServiceBaseUrl, specificationDemandWiseSearch, params)
      if (result.success) {
        this.formData = result.data
        this.formData.specification_details = this.formData.specification_details.map(item => {
          item.childs = item.childs.map(childItem => {
            childItem.received_specification = childItem.s_specified
            return childItem
          })
          item.received_specification = item.s_specified
          return item
        })
      } else {
        this.formData = []
      }
      this.loader = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    onChange (e) {
      this.fileValidationMsz = ''
      const input = event.target
      const file = input.files[0]
      if (file.size > 1024 * 5120) {
        e.preventDefault()
        this.fileValidationMsz = 'Maximum file size must be 5 MB'
      }
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.formData.attachement = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.formData.attachement = ''
      }
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(InspectionServiceBaseUrl, `${specificationVerifyUpdate}/${this.$route.query.id}`, this.formData)
      } else {
        result = await RestApi.postData(InspectionServiceBaseUrl, specificationVerifyStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push({ path: '/trade-tariff-service/specification/specification-verify' })
        // this.$bvModal.hide('modal-form')
        // this.$refs.form.reset()
      } else {
        this.$refs.form.setErrors(result.errors)
      }
      this.loading = false
    },
    getTotalInfo (index, childIndex = null) {
      if (childIndex !== null && this.formData.specification_details[index].childs[childIndex].verify_status !== 3) {
        this.formData.specification_details[index].childs[childIndex].reason = ''
      } else {
        if (this.formData.specification_details[index].verify_status !== 3) {
          this.formData.specification_details[index].reason = ''
        }
      }
      this.formData.total_fully_comply = 0
      this.formData.total_partially_comply = 0
      this.formData.total_reject = 0
      let totalFullyComply = 0
      let totalPartiallyComply = 0
      let totalReject = 0
      this.formData.specification_details.forEach(item => {
        if (item.verify_status === 1) {
          totalFullyComply++
        } else if (item.verify_status === 2) {
          totalPartiallyComply++
        } else if (item.verify_status === 3) {
          totalReject++
        }
        if (item.childs.length) {
          item.childs.forEach(childItem => {
            if (childItem.verify_status === 1) {
              totalFullyComply++
            } else if (childItem.verify_status === 2) {
              totalPartiallyComply++
            } else if (childItem.verify_status === 3) {
              totalReject++
            }
          })
        }
      })
      this.formData = Object.assign({}, this.formData, {
        total_fully_comply: totalFullyComply,
        total_partially_comply: totalPartiallyComply,
        total_reject: totalReject
      })
    },
    async getOfferVettingList() {
      this.loading = true
      const result = await RestApi.getData(InspectionServiceBaseUrl, `${specificationVerifyShow}/${this.$route.query.id}`)
      if (result.success) {
        this.searchDemand.demand_no = result.data.demand_no
        this.formData = result.data
        this.formData.specification_details = this.formData.specification_details.map(item => {
          item.childs = item.childs.map(childItem => {
            childItem.s_specified = childItem?.specification_item?.s_specified
            childItem.s_description = childItem?.specification_item?.s_description
            return childItem
          })
          item.s_specified = item?.specification_item?.s_specified
          item.s_description = item?.specification_item?.s_description
          return item
        })  
      }
      this.loading = false
    }
  }
}
</script>
