<template>
  <div class="inner-section">
    <card>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('cip.bb_verified') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction v-if="applications.length > 0">
        <b-overlay :show="loading">
          <a href="javascript:" class="btn-add mr-2" @click="pdfExport"> {{ $t('globalTrans.download') }}</a>
        </b-overlay>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <th style="width:8%">{{ $t('globalTrans.sl_no') }}</th>
                                <th style="width:8%">{{ $t('cip.sector_wise_no') }}</th>
                                <th style="width:25%">{{ $t('cip.name_father_mother_address') }}</th>
                                <th style="width:25%">{{ $t('cip.org_name_address_phone_fax') }}</th>
                                <th style="width:34%">{{ $t('cip.bb_comment') }}</th>
                                <th style="width:34%">{{ $t('globalTrans.action') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-for="(tmp, indx) in applications">
                                <tr :key="indx">
                                    <td colspan="6">
                                        <p class="text-left">{{ $t('exportTrophyConfig.product_or_service_sector_name') }}: {{ currentLocale === 'bn' ? tmp.sector_name_bn : tmp.sector_name_en }}</p>
                                    </td>
                                </tr>
                                <tr v-for="(item, index) in tmp.details" :key="index+indx+1">
                                  <td class="text-center">{{ $n((tmp.sector_sl + 1), { useGrouping: false }) }}</td>
                                  <td class="text-center">{{ $n((index + 1), { useGrouping: false }) }}</td>
                                  <td>
                                      {{ currentLocale === 'bn' ? item.name_bn : item.name_en }} <br/>
                                      {{ currentLocale === 'bn' ? item.owner_info.designation_bn : item.owner_info.designation_en }} <br/>
                                      {{ $t('cip.father') }}- {{ currentLocale === 'bn' ? item.owner_info.father_husband_name_bn : item.owner_info.father_husband_name_en }} <br/>
                                      {{ $t('cip.mother') }}- {{ currentLocale === 'bn' ? item.owner_info.mother_name_bn : item.owner_info.mother_name_en }} <br/>
                                      {{ AddressHelper.getPresentAddress(item.address) }}
                                  </td>
                                  <td>
                                      {{ item.org_info ? (currentLocale === 'bn' ? item.org_info.org_name_bn : item.org_info.org_name_en) : '' }} <br>
                                      {{ AddressHelper.getCommonAddress(item.org_address) }} <br>
                                      {{ item.office_contact_info.telephone_no ? $n(item.office_contact_info.telephone_no, { useGrouping: false }) : '' }}, {{ item.office_contact_info.fax_no ? $n(item.office_contact_info.fax_no, { useGrouping: false }) : '' }}
                                  </td>
                                  <td>
                                      <template v-if="item.profile_verification && item.profile_verification.bb_comment">
                                          {{ item.profile_verification.bb_comment }}
                                      </template>
                                      <template v-else>
                                          <ValidationProvider name="BB Comment" :vid="`bb_comment${index+indx+1}`" rules="required|max:250">
                                              <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  :label-for="`bb_comment${index+indx+1}`"
                                              >
                                                  <b-form-textarea
                                                      v-model="item.bb_comment"
                                                      :id="`bb_comment${index+indx+1}`"
                                                      :placeholder="$t('cip.enter_your_comment')"
                                                      rows="4"
                                                      max-rows="6"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  >
                                                  </b-form-textarea>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                              </b-form-group>
                                          </ValidationProvider>
                                      </template>
                                  </td>
                                  <td>
                                    <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="singleData(item.id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                                    <b-button v-b-modal.enquiry-form-one variant="action-btn status mr-1" size="sm" @click="enquiry(item)" class="action-btn status" :title="$t('cip.enquiry_form_one')"><i class="ri-file-2-line"></i></b-button>
                                    <b-button v-b-modal.enquiry-form-two variant="action-btn status mr-1" size="sm" @click="enquiry(item)" class="action-btn status" :title="$t('cip.enquiry_form_two')"><i class="ri-file-3-line"></i></b-button>
                                  </td>
                                </tr>
                            </template>
                            <template v-if="applications.length === 0">
                              <tr class="text-center">
                                <td colspan="6">{{ $t('globalTrans.no_data_found') }}</td>
                              </tr>
                            </template>
                        </tbody>
                    </table>
                    <b-row class="text-right" v-if="applications.length > 0 && actionBtnShow">
                        <b-col>
                            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.submit') }}</b-button>
                            <b-button variant="danger" class="btn-sm">{{ $t('globalTrans.cancel') }}</b-button>
                        </b-col>
                    </b-row>
                </b-form>
            </ValidationObserver>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="enquiry-form-one" size="lg" :title="$t('cip.enquiry_form_one')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <EnquiryFormOne :item="item" :key="editItemId"/>
    </b-modal>
    <b-modal id="enquiry-form-two" size="lg" :title="$t('cip.enquiry_form_two')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <EnquiryFormTwo :item="item" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import Details from '../Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { bbApplicationList, bbVerify } from '../../api/routes'
import EnquiryFormOne from '../enquiry-form-one.vue'
import EnquiryFormTwo from '../enquiry-form-two.vue'
import ModalBaseMasterList from '@/mixins/list'
import AddressHelper from '@/utils/area-type-address'
import ExportPdf from './applicants'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, EnquiryFormOne, EnquiryFormTwo
  },
  data () {
    return {
      item: [],
      actionBtnShow: false,
      applications: [],
      AddressHelper: AddressHelper
    }
  },
  created () {
    this.loadData()
  },
  computed: {
     ...mapGetters({
      authUser: 'Auth/authUser'
    }),
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    singleData (itemId) {
      this.editItemId = itemId
    },
    enquiry (item) {
      this.item = item
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, bbApplicationList)
      if (result.success) {
        this.applications = this.getRelationalData(result.data)
        const existVerfication = result.data[0].details[0].profile_verification
        if (existVerfication && existVerfication.bb_comment) {
          this.actionBtnShow = false
        } else {
          this.actionBtnShow = true
        }
      } else {
        this.applications = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
        const sectorList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList

        const list = data.map((tmp, indx) => {
            const sector = sectorList.find(el => el.value === tmp.sector_id)

            const sectorObj = {
                sector_sl: indx,
                sector_name_en: typeof sector !== 'undefined' ? sector.text_en : '',
                sector_name_bn: typeof sector !== 'undefined' ? sector.text_bn : ''
            }

            const details = tmp.details.map((item, index) => {
                const orgData = {
                    detail_serial: index,
                    org_name_en: item.org_info !== null ? item.org_info.org_name_en : '',
                    org_name_bn: item.org_info !== null ? item.org_info.org_name_bn : '',
                    bb_comment: ''
                }
                Object.assign({}, item, orgData)
            })
            return Object.assign({}, tmp, sectorObj, details)
        })

        return list
    },
    async submit () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const formData = this.generateFormData(this.applications)
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, bbVerify, formData)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    generateFormData (data) {
        let applicants = []
        const circularId = data[0].details[0].circular_id
        data.map(tmp => {
            return tmp.details.map((item, index) => {
                const detailObj = {
                    app_id: item.id,
                    bb_user_id: this.authUser.user_id,
                    bb_comment: item.bb_comment
                }
                applicants = [...applicants, detailObj]
            })
        })
        return Object.assign({ circular_id: circularId }, applicants)
    },
    pdfExport () {
      const reportTitle = this.$t('exportTrophy.et_app_list')
      ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
    }
  }
}
</script>
