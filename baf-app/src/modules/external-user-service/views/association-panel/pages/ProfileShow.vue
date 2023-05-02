<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('sideBar.profile') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loading">
        <b-row>
            <div v-if="profile.status == 1" class="box-message col-md-12 mt-1 mb-2 text-danger">
                <div class="message-body message-body-center">
                  <p class="pb-2 pt-2 h5"><i class="ri-alert-fill mr-2"></i>
                    <span>{{ $t('externalPanel.profile_approval_msg') }}</span>
                  </p>
                </div>
            </div>
            <b-col md="9">
                <table class="table table-sm table-borderless">
                  <tr>
                        <th width="15%">{{$t('eBizProposal.council_name')}}</th>
                        <td width="35%">: {{ getCouncilName(profile.council_info_id) }}</td>
                        <th width="15%">{{$t('eBizProposal.association_name')}}</th>
                        <td width="35%">: {{ getAssociationName(profile.association_info_id) }}</td>
                    </tr>
                    <tr>
                        <th width="15%">{{$t('associationPnl.establish_date')}}</th>
                        <td width="35%">: {{ profile.establish_date | dateFormat }}</td>
                        <th width="15%"></th>
                        <td width="35%"></td>
                    </tr>
                    <tr>
                        <th>{{$t('eBizConfig.contact_person_name')}}</th>
                        <td>: {{ currentLocale === 'bn' ? profile.contact_person_name_bn : profile.contact_person_name_en }}</td>
                        <th>{{$t('globalTrans.email')}}</th>
                        <td>: {{ profile.email }}</td>
                    </tr>

                    <tr>
                        <th>{{$t('globalTrans.mobile')}}</th>
                        <td>: {{currentLocale == 'bn'? profile.mobile.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d]) : profile.mobile}}</td>
                        <th>{{ $t('globalTrans.nid') }}</th>
                        <td>: {{ $n(profile.nid, { useGrouping: false }) }}</td>
                    </tr>
                    <tr>
                        <th>{{$t('globalTrans.description')}}</th>
                        <td class="2">: {{ currentLocale === 'bn' ? profile.description_bn : profile.description_en }}</td>
                    </tr>
                    <tr>
                        <th>{{$t('globalTrans.gender')}}</th>
                        <td>: {{ profile.gender ? getGenderName(profile.gender) : '' }}</td>
                    </tr>
                </table>
                <b-row>
                    <b-col lg="12" sm="12">
                        <p class="text-black" style="border-bottom: 1px solid #ddd; font-weight: bold">
                            {{ $t('globalTrans.present_address') + ' :' }}
                        </p>
                    </b-col>
                    <b-col lg="12" sm="12">
                        <table class="table table-sm table-borderless">
                          <tr>
                              <th width="15%">{{$t('globalTrans.division')}}</th>
                              <td width="35%">: {{ getDivisionName(profile.division_id) }}</td>
                              <th width="15%">{{$t('globalTrans.district')}}</th>
                              <td width="35%">: {{ AddressHelper.getDistrictName(profile.district_id) }}</td>
                          </tr>
                          <tr>
                              <th>{{$t('globalTrans.upazila')}}</th>
                              <td>: {{ profile.upazila_id ? AddressHelper.getUpazilaName(profile.upazila_id) : 'N/A' }}</td>
                              <th>{{$t('globalTrans.city_corporation')}}</th>
                              <td>: {{ profile.city_corporation_id ? AddressHelper.getCityCorporationName(profile.city_corporation_id) : 'N/A' }}</td>
                          </tr>
                          <tr>
                              <th>{{$t('globalTrans.pouroshova')}}</th>
                              <td>: {{ profile.pauroshoba_id ? AddressHelper.getPauroshobaName(profile.pauroshoba_id) : 'N/A' }}</td>
                              <th>{{$t('globalTrans.union')}}</th>
                              <td>: {{ profile.union_id ? AddressHelper.getUnionName(profile.union_id) : 'N/A' }}</td>
                          </tr>
                        </table>
                    </b-col>
                    <b-col lg="12" sm="12">
                        <table class="table table-sm table-borderless">
                          <tr>
                              <th width="15%">{{$t('globalTrans.status')}}</th>
                              <td v-if="profile.status === 1" width="85%">: {{ $t('globalTrans.pending') }}</td>
                              <td v-else width="85%">: {{ $t('globalTrans.approved') }}</td>
                          </tr>
                        </table>
                    </b-col>
                </b-row>
            </b-col>
        </b-row>
        </b-overlay>
      </template>
    </body-card>
  </div>
</template>
<script>
// import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
import RestApi, { authServiceBaseUrl, eBizServiceBaseUrl } from '@/config/api_config'
import { associationProfileShow } from '../api/routes'
import BreadCumb from '@/components/BreadCumb.vue'
import AddressHelper from '@/utils/area-type-address'
// import { EventBus } from '@/EventBusLayout'
import { mapGetters } from 'vuex'
export default {
  components: { BreadCumb },
  name: 'ProfileShow',
  data () {
    return {
        loading: false,
        loader: false,
        baseUrl: authServiceBaseUrl,
        AddressHelper: AddressHelper,
        isLoaded: false,
        profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile
    }
  },
  created () {
    if (!this.$store.state.ExternalUserService.eBizPanel.associationProfile) {
      this.$router.push('/association-panel/association-profile-update')
    }
    // load profile data
    if (Object.values(this.authUser).length > 0) {
        // this.loadData(this.authUser.user_id)
    }
  },
  computed: {
    // loading: function () {
    //   return this.$store.state.commonObj.loading
    // },
    currentLocale () {
      return this.$i18n.locale
    },
    ...mapGetters({
      authUser: 'Auth/authUser'
    })
  },
  watch: {
  },
  methods: {
    getCouncilName (Id) {
      const Obj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.find(item => item.value === parseInt(Id))
        if (Obj) {
          return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
        } else {
          return ''
        }
    },
    getAssociationName (Id) {
      const Obj = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.find(item => item.value === parseInt(Id))
        if (Obj) {
          return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
        } else {
          return ''
        }
    },
    getDivisionName (Id) {
      const Obj = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === parseInt(Id))
      if (Obj) {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ''
      }
    },
    getGenderName (val) {
      const Obj = this.$store.state.commonObj.genderList.find(el => el.value === val)
      return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
    },
    async loadData (userId) {
        this.loading = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(eBizServiceBaseUrl, `${associationProfileShow}/${userId}`)
        if (!result.success) {
            /** redirect to profie update page */
            this.$router.push('/association-panel/association-profile-update')
        } else {
            this.profile = result.data
        }
        this.loading = false
    }
  }
}
</script>
<style scope='css'>
  .blink_me {
    animation: blinker 1.3s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      /* background-color: green; */
    }
  }
</style>
