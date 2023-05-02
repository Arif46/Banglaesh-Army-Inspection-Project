<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eventManage.guest_invitation') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="searchForm"  v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(searchData)" id="searchForm" @reset.prevent="reset">
            <b-row>
              <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                <ValidationProvider name="Award Type" vid="award_type" rules="required|min_value:1">
                  <b-form-group
                    class="row"
                    style="margin-top:12px"
                    label-cols-sm="4"
                    label-for="award_type"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eventManage.award_type')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-radio-group
                        class="mt-2"
                        v-model="formData.award_type"
                        :options="assignTypeList"
                        value-field="value"
                        text-field="text"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-radio-group>
                    <div class="invalid-feedback d-block">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="4" sm="4" md="4" lg="4" xl="4" v-if="hideYear">
                <ValidationProvider name="Year" vid="year" rules="required|min_value:1">
                  <b-form-group
                    label-for="year"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formData.year"
                    :options="yearList"
                    id="year"
                    :state="errors[0] ? false : (valid ? true : null)"
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
              </b-col>
              <b-col xs="4" sm="4" md="4" lg="4" xl="4" v-if="hideFiscalYear">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="fiscal_year_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formData.fiscal_year_id"
                    :options="fiscalYear"
                    id="fiscal_year_id"
                    :state="errors[0] ? false : (valid ? true : null)"
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
              </b-col>
              <b-col sm="3">
                <b-button type="submit" id="save" variant="primary" class="mt-20 btn-sm">{{ $t('globalTrans.search') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(sendInvite)"  id="form" @reset.prevent="reset">
              <!-- search section end -->
            <b-overlay :show="loading">
              <body-card>
                <template v-slot:headerTitle>
                  <h4 class="card-title text-center">{{ $t('eventManage.guest_list') }} </h4>
                </template>
                <b-row>
                  <div class="col-md-12">
                    <table class="table table-bordered" style="width:100%">
                      <thead class="thead">
                        <tr>
                          <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                          <th class="text-center">{{ $t('exportCipReport.candidate_name_address') }}</th>
                          <th class="text-center">{{ $t('globalTrans.org_name') }}</th>
                          <th class="text-center">{{ $t('eventManage.service_sector') }}</th>
                          <!-- <th class="text-center">
                            <b-form-checkbox
                                style="display: table-cell"
                                class="col-form-label-sm font-weight-bold mb-0"
                                name="checked"
                                v-model="selectAll"
                                @change="checkAll"
                                :value=true
                                :unchecked-value=false
                                >
                                {{ $t('globalTrans.select') }}
                            </b-form-checkbox>
                          </th> -->
                        </tr>
                      </thead>
                      <tr v-for="(applicantData,index) in formData.detailsData" :key="index">
                          <td class="text-center">{{ $n(index+1) }}</td>
                          <td class="text-center">
                              {{ ($i18n.locale==='bn') ? applicantData.name_bn : applicantData.name_en }},{{ AddressHelper.getCommonAddress(applicantData.org_address) }}
                          </td>
                          <td class="text-center">
                              {{ ($i18n.locale==='bn') ? applicantData.org_info.org_name_bn : applicantData.org_info.org_name_en }}
                          </td>
                          <td class="text-center">
                              {{ ($i18n.locale==='bn') ? applicantData.product_service_bn : applicantData.product_service }}
                          </td>
                          <!-- <td class="text-center">
                            <b-form-checkbox
                              name="checked"
                              v-model="applicantData.is_checked"
                              @change="check()"
                              :value=true
                              :unchecked-value=false
                            >
                            </b-form-checkbox>
                          </td> -->
                      </tr>
                        <template v-if="formData.detailsData.length === 0">
                          <tr>
                              <th colspan="5" class="text-center">{{$t('globalTrans.noDataFound')}}</th>
                          </tr>
                        </template>
                    </table>
                  </div>
                </b-row>
                <template v-if="formData.detailsData.length">
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                      <ValidationProvider name="Invitation Card" vid="invitation_card_id" rules="required|min_value:1">
                        <b-form-group
                          label-cols-sm="4"
                          slot-scope="{ valid, errors }"
                          label-for="invitation_card_id"
                        >
                        <template v-slot:label>
                          {{$t('eventManage.invitation_card')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="formData.invitation_card_id"
                          :options="invitationList"
                          id="invitation_card_id"
                          :state="errors[0] ? false : (valid ? true : null)"
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
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <!-- <b-button :disabled='isDisabled' type="submit" id="save" variant="success" class="btn-sm">{{ sendInvitationCard }}</b-button> -->
                      <b-button type="submit" id="save" variant="success" class="btn-sm">{{ sendInvitationCard }}</b-button>
                    </b-col>
                  </b-row>
                </template>
              </body-card>
            </b-overlay>
          </b-form>
        </ValidationObserver>
      </template>
    </card>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { guestInvitationApplicationList, guestInvitationApplicationStore } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import AddressHelper from '@/utils/area-type-address'

export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      AddressHelper: AddressHelper,
      sendInvitationCard: this.$t('eventManage.send_invitation_card'),
      sortBy: '',
      formData: {
        award_type: 1,
        fiscal_year_id: 0,
        year: 0,
        detailsData: [],
        invitation_card_id: 0
      },
      hideYear: true,
      hideFiscalYear: false,
      showdata: false,
      data: [],
      selectAll: false,
      selectedItem: [],
      isDisabled: true,
      invitationList: [],
      tmpInviationList: []
    }
  },
  created () {
  },
  watch: {
    'formData.award_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.formData.detailsData = []
        if (newVal === 1) {
          this.hideYear = true
          this.formData.fiscal_year_id = 0
          this.hideFiscalYear = false
        }
        if (newVal === 2) {
          this.hideFiscalYear = true
          this.formData.year = 0
          this.hideYear = false
        }
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
       this.invitationList = this.getInvitationCardList(this.tmpInviationList)
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    fiscalYear () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    checkAll () {
      if (this.selectAll) {
          this.formData.detailsData.forEach(element => {
            element.is_checked = true
          })
      } else {
          this.formData.detailsData.forEach(element => {
            element.is_checked = false
          })
      }
      const trueItem = this.formData.detailsData.find(item => item.is_checked === true)
        if (trueItem) {
          this.isDisabled = false
        } else {
          this.isDisabled = true
        }
    },
    check () {
      const guestInvitationObj = this.formData.detailsData.filter(item => item.is_checked === true)
        if (guestInvitationObj.length === 0) {
          this.isDisabled = true
        } else if (guestInvitationObj.length > 0) {
          this.isDisabled = false
        }
      const invitationObj = this.formData.detailsData.find(item => item.is_checked === false)
        if (invitationObj === undefined) {
          this.selectAll = true
        } else {
          this.selectAll = false
        }
    },
    async sendInvite () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, guestInvitationApplicationStore, this.formData)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      this.showData = true
      const searchParams = {
        award_type: this.formData.award_type,
        fiscal_year_id: this.formData.fiscal_year_id,
        year: this.formData.year
      }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, guestInvitationApplicationList, searchParams)
      if (result.success) {
        this.tmpInviationList = result.inviatCard
        this.invitationList = this.getInvitationCardList(result.inviatCard)
        this.data = result.data.map(item => {
          const productServiceSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(serviceType => serviceType.value === item.product_service_sector_id)
          const customItem = {
              product_service: productServiceSectorObj !== undefined ? productServiceSectorObj.text_en : '',
              product_service_bn: productServiceSectorObj !== undefined ? productServiceSectorObj.text_bn : ''
          }
          return Object.assign({}, item, { is_checked: true }, customItem)
        })
        this.formData.detailsData = this.data
      } else {
        this.data = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getInvitationCardList (data) {
      return data.map((item) => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getExterUserName (id) {
      const userName = this.userList.find(user => user.value === id)
      if (userName !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return userName.text_bn
        } else {
          return userName.text_en
        }
      }
    }
  }
}
</script>
