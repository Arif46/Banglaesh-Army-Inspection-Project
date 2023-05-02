<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eventManage.guest_entry') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit()"  id="form" @reset.prevent="reset">
            <b-row>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Award Type" vid="award_type" rules="required">
                  <b-form-group
                    label-for="award_type"
                  >
                  <template v-slot:label>
                    {{$t('exportTrophyConfig.awardType')}}
                  </template>
                  <b-form-select
                    plain
                    v-model="search.award_type"
                    :options="assignTypeList"
                    id="award_type"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.award_type === 1">
                <b-form-group
                  label-for="year"
                >
                <template v-slot:label>
                  {{$t('globalTrans.year')}}
                </template>
                  <b-form-select
                    plain
                    v-model="search.year"
                    :options="yearList"
                    id="year"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.award_type === 2">
                <b-form-group
                  label-for="fiscal_year_id"
                >
                <template v-slot:label>
                  {{$t('globalTrans.fiscal_year')}}
                </template>
                  <b-form-select
                    plain
                    v-model="search.fiscal_year_id"
                    :options="fiscalYearList"
                    id="fiscal_year_id"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="3">
                <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                </b-button>
              </b-col>
            </b-row>
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
                            <th class="text-center">{{$t('globalTrans.sl_no')}}</th>
                            <th class="text-center">{{$t('globalTrans.name')}}</th>
                            <th class="text-center">{{$t('eventManage.service_sector')}}</th>
                            <th>
                                {{$t('globalTrans.action')}}
                            </th>
                          </tr>
                        </thead>
                        <template v-if="applicants.length">
                          <tr v-for="(info,index) in applicants" :key="index">
                              <td class="text-center">{{ $n(index+1) }}</td>
                              <td class="text-center">
                                {{ currentLocale === 'bn' ? info.name_bn : info.name_en }}
                              </td>
                              <td class="text-center">
                                {{ currentLocale === 'bn' ? info.sector_name_bn : info.sector_name_en }}
                              </td>
                              <td class="text-center">
                                <b-button variant="iq-bg-info mr-1" type="submit" size="sm" @click="sendEntry(info.id)" class="action-btn entry" :title="$t('eventManage.guest_entry')"><i class="ri-send-plane-2-fill"></i></b-button>
                              </td>
                          </tr>
                          </template>
                          <template v-else>
                            <tr>
                                <th colspan="5" class="text-center">{{$t('globalTrans.noDataFound')}}</th>
                            </tr>
                          </template>
                      </table>
                    </div>
                  </b-row>
                </body-card>
              </b-overlay>
          </b-form>
        </ValidationObserver>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { guestEntryList, guestEntrySendStatus } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      sendInvitationCard: this.$t('eventManage.send_invitation_card'),
      sortBy: '',
      search: {
        award_type: 0,
        fiscal_year_id: 0,
        year: 0
      },
      applicants: [],
      hideFiscalYear: false,
      hideYear: false,
      showdata: false,
      item: []
    }
  },
  created () {
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
    fiscalYearList () {
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
    async sendEntry (detailsId) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const params = Object.assign({}, { id: detailsId })
      result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, guestEntrySendStatus, params)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$t('eventManage.guest_entry_status'),
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
        award_type: this.search.award_type,
        fiscal_year_id: this.search.fiscal_year_id,
        year: this.search.year
      }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, guestEntryList, searchParams)
      if (result.success) {
        this.applicants = this.getRelationalData(result.data.invitations, result.data.applicants)
      } else {
        this.applicants = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (invitations, userList) {
      return invitations.map(item => {
        const user = userList.find(tmp => tmp.value === item.user_id)
        const sector = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(el => el.value === item.product_service_sector_id)
        const tmpData = {
          name_en: typeof user !== 'undefined' ? user.text_en : '',
          name_bn: typeof user !== 'undefined' ? user.text_bn : '',
          sector_name_en: typeof sector !== 'undefined' ? sector.text_en : '',
          sector_name_bn: typeof sector !== 'undefined' ? sector.text_bn : ''
        }
        return Object.assign({}, item, tmpData)
      })
    }
  }
}
</script>
