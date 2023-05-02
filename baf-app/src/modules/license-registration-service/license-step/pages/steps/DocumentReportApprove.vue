<template>
  <b-container fluid>
    <iq-card class="mt-5">
        <template :id="index">
            <b-overlay :show="unitLoad">
                <table class="table table-bordered table-sm">
                  <tr>
                    <td>
                      <span class="text-center">
                        {{ getOfficeName(pDatas.office_id) }} <br>
                        {{ $t('li_step.district_count') }} - {{ districtCount }} <br>
                        {{ $t('li_step.upazilla_count') }} - {{ upazillaCount }} <br>
                        {{ $t('li_step.dealer_count') }} - {{ totalDealer }}
                      </span>
                    </td>
                    <td>
                      <span>{{ getDistrictName(pDatas.district_id) }}</span><br>
                      <span>{{ $t('li_step.upazilla_count') }} - {{ disUpazillaCount }}</span> <br>
                      <span>{{ $t('li_step.dealer_count') }} - {{ disDealer }}</span>
                    </td>
                    <td>
                      <span>{{ getUpazillaName(pDatas.upazilla_id) }} - {{ upDealer }}</span>
                    </td>
                  </tr>
                </table>
                <div class="row">
                  <div class="col text-right">
                    <router-link :to="{ name: getBtn(4).url, params: { stepChange }}" :title="getBtn(4).text" :class="`btn btn-sm `+ getBtn(4).color" size="sm"><i :class="getBtn(4).icon"></i></router-link>
                    <b-button variant="danger" class="mr-4" @click="$bvModal.hide('modal-9')">{{ $t('globalTrans.cancel') }}</b-button>
                  </div>
                </div>
            </b-overlay>
        </template>
    </iq-card>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { reportData } from '../../api/routes'
export default {
  props: ['pDatas', 'stepID'],
  components: {
  },
  data () {
    return {
      stepChange: {
        step_id: '',
        application_id: [],
        service_id: '',
        org_id: ''
      },
      districtCount: 0,
      upazillaCount: 0,
      disUpazillaCount: 0,
      totalDealer: 0,
      disDealer: 0,
      upDealer: 0,
      unitLoad: false,
      loading: false
    }
  },
  created () {
    if (this.pDatas) {
      this.stepChange.step_id = this.pDatas.current_step
      this.stepChange.application_id[0] = this.pDatas.application_id
      this.stepChange.service_id = this.pDatas.service_id
      this.stepChange.org_id = this.pDatas.org_id
      this.stepChange.status = 1
    }
    this.getReportData()
  },
  methods: {
    getBtn (value) {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
    },
    async getReportData () {
      this.unitLoad = true
      const params = {
        district_id: parseInt(this.pDatas.district_id),
        upazilla_id: parseInt(this.pDatas.upazilla_id),
        office_id: parseInt(this.pDatas.office_id),
        service_id: parseInt(this.pDatas.service_id)
      }
      await RestApi.getData(licenseRegistrationServiceBaseUrl, reportData, params).then(response => {
        if (response.data) {
          this.totalDealer = response.data.totalDealer
          const regionDistricts = response.data.regionData.master_region_districts
          const disUpazillaList = []
          const disDealerList = []
          regionDistricts.forEach(item => {
            const upazilla = this.$store.state.commonObj.upazilaList.filter(upazila => upazila.district_id === item.district_id)
            this.upazillaCount = this.upazillaCount + upazilla.length
          })
          response.data.all.forEach(item => {
            if (item.district_id === this.pDatas.district_id) {
              disDealerList.push(item.district_id)
              if (item.upazilla_id === this.pDatas.upazilla_id) {
                this.upDealer = this.upDealer + 1
              }
              const upazillaFind = disUpazillaList.includes(item.upazilla_id)
              if (!upazillaFind) {
                disUpazillaList.push(item.upazilla_id)
              }
            }
          })
          this.districtCount = regionDistricts.length
          this.disUpazillaCount = disUpazillaList.length
          this.disDealer = disDealerList.length
        }
      })
      this.unitLoad = false
    },
    getOfficeName (officeId) {
      const office = this.$store.state.commonObj.officeList.find(item => item.value === officeId)
      return office.text
    },
    getDistrictName (districtId) {
      const district = this.$store.state.commonObj.districtList.find(item => item.value === districtId)
      return district.text
    },
    getUpazillaName (upazillaId) {
      const upazilla = this.$store.state.commonObj.upazilaList.find(item => item.value === upazillaId)
      return upazilla.text
    }
  }
}
</script>
<style scoped>
</style>
