<template>
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template>
              <b-row>
              <b-col lg="12" sm="12">
                <template>
                    <div style="font-size:12px; font-color:white; background-color: #dddddd; padding:6px">
                        <h5 class="card-title text-center" style="margin-bottom: 0;color: #214162;font-size: 1.40rem;"> {{ $t('teaGardenConfig.brokers') }} {{ $t('globalTrans.details') }}</h5>
                    </div>
                </template>
                <table class="table table-borderless">
                  <tr>
                    <th style="width: 18%"> {{$t('teaGardenConfig.broker_name')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ ($i18n.locale === 'bn') ? item.broker_name_bn : item.broker_name_en }}</td>
                    <th style="width: 18%"> {{$t('teaGardenConfig.zone')}}</th>
                    <th style="width: 2%">:</th>
                    <td style="width: 30%">{{ getZonedfList(item.zone_id) }}</td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.area_type')}}</th>
                    <th>:</th>
                    <td>{{ getDivisionName(item.division_id) }}</td>
                    <th> {{$t('teaGardenConfig.division')}}</th>
                    <th>:</th>
                    <td>{{ getDivisionName(item.division_id) }}</td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.district')}}</th>
                    <th>:</th>
                    <td>{{ getDistrictName(item.district_id) }}</td>
                    <th> {{$t('teaGardenConfig.city_corporation')}}</th>
                    <th>:</th>
                    <td>{{ item.city_corporation_id ? getCityCorpName(item.city_corporation_id) : 'N/A' }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.upazila')}}</th>
                    <th>:</th>
                    <td>{{ item.upazila_id ? getUpazilaName(item.upazila_id) : 'N/A' }} </td>
                    <th> {{$t('teaGardenConfig.union')}}</th>
                    <th>:</th>
                    <td>{{ item.union_id ? getUnionName(item.union_id) : 'N/A' }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.municipality_name')}}</th>
                    <th>:</th>
                    <td>{{ item.pauroshoba_id ? getPourosobaName (item.pauroshoba_id) : 'N/A' }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.address')}}</th>
                    <th>:</th>
                    <td colspan="3">{{ ($i18n.locale === 'bn') ? item.address_bn : item.address_en }}</td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.owner_name')}}</th>
                    <th>:</th>
                    <td>{{ ($i18n.locale === 'bn') ? item.owner_name_bn : item.owner_name_en }}</td>
                    <th> {{$t('teaGardenConfig.contact_no')}}</th>
                    <th>:</th>
                    <td>{{ item.contact_no | mobileNumber }}</td>
                  </tr>
                  <!-- <b-tr style="background-color: #fff">
                      <td colspan="4">
                          <b-img style="width:150px" v-if="item.reg_paper" fluid :src="baseUrl + 'download-attachment?file=uploads/broker-photo/'+ item.reg_paper"  class="cover"/>
                      </td>
                  </b-tr> -->
                  <tr>
                    <th> {{$t('teaGardenConfig.email')}}</th>
                    <th>:</th>
                    <td>{{ item.email }}</td>
                    <th>{{ $t('teaGardenConfig.broker') }}  {{ $t('teaGardenConfig.registration_no') }}</th>
                    <th>:</th>
                    <td>{{ item.registration_no }}</td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.establishment_year')}}</th>
                    <th>:</th>
                    <td>{{ $n(item.year, { useGrouping: false}) }}</td>
                    <th>{{ $t('teaGardenConfig.broker') }}  {{ $t('teaGardenConfig.registration') }} {{ $t('teaGardenConfig.paper') }}</th>
                    <th>:</th>
                    <td colspan="4">
                          <b-img style="width:150px" v-if="item.reg_paper" fluid :src="baseUrl + 'storage/' + item.reg_paper"  class="cover"/>
                      </td>
                  </tr>
                  <tr>
                    <th> {{$t('teaGardenConfig.description')}}</th>
                    <th>:</th>
                    <td colspan="3">{{ ($i18n.locale === 'bn') ? item.description_bn : item.description_en }}</td>
                  </tr>
                  <tr>
                    <th>{{ $t('teaGardenConfig.owner') }} {{ $t('globalTrans.photo') }}</th>
                    <th>:</th>
                    <td colspan="4">
                          <b-img style="width:150px" v-if="item.photo" fluid :src="baseUrl + 'storage/' + item.photo"  class="cover"/>
                      </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
            </template>
          </body-card>
        </b-col>
      </b-row>
</template>
<script>
import { teaGardenServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      loading: false,
      errors: [],
      detailsData: [],
      baseUrl: teaGardenServiceBaseUrl,
      detailsItemId: ''
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getWardName (Id) {
            const tmpData = this.$store.state.commonObj.wardList.find(item => item.value === Id)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getUnionName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getUpazilaName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getDivisionName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getPourosobaName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getCityCorpName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getDistrictName (Id) {
            const tmpData = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === Id && item.status === 1)
            if (this.$i18n.locale === 'bn') {
                return tmpData.text_bn
            } else {
                return tmpData.text_en
            }
        },
        getAreaType (Id) {
            const tmpData = this.$store.state.commonObj.wardTypeList.find(item => item.id === parseInt(Id))
            if (this.$i18n.locale === 'bn') {
                return tmpData.name_bn
            } else {
                return tmpData.name
            }
        },
    getZonedfList (typeId) {
        const Type = this.$store.state.TeaGardenService.commonObj.zoneList.find(type => type.value === typeId)
        if (this.$i18n.locale === 'bn') {
            return Type.text_bn
        } else {
            return Type.text_en
        }
        }
  }
}
</script>
