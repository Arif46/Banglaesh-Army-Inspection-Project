<template>
  <b-container fluid>
       <b-row>
            <template>
                <div class="row">
                    <div class="col-sm" style="position: absolute;top: 235px;left: 53px;">
                        <span>{{ $i18n.locale === 'en' ? cityCorp.text_en : cityCorp.text_bn }}</span>
                    </div>
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm" style="position: absolute;top: 260px;left: 44px;text-align: center;width: 197px;">
                        <b style="font-size: 18px;"><span>{{ $i18n.locale === 'en' ? item.pre_address_en : item.pre_address_bn }}</span></b>
                    </div>
                    <div class="col-sm" style="text-align: center;margin-left: -31px;">
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm">
                        <img v-if="item.photo !== ''" class="img w-50" style="height: 130px;position: absolute;margin-top: 41px;margin-left: 43px;" :src="baseUrl + 'download-attachment?file=storage/' + item.photo" alt="Profile Image">
                        <img v-if="item.photo === '' || item.photo === null" class="img w-50" style="height: 130px;position: absolute;margin-top: 41px;margin-left: 43px;" src="@/assets/images/nophoto.png" alt="Profile Image">
                    </div>
                    <div class="col-sm" style="text-align: center;margin-left: -31px;">
                        <img src="@/assets/images/logo.png" class="img-fluid" alt="" style="width: 30px;">
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                    <b style="color: #a75555;">{{ $t('tcbconfiguration.digital_family_description') }}</b>
                    </div>
                    <div class="col-sm">
                        <b-button-group style="transform: translate(173px, -20px);">
                            <b-button @click="pdfExport" class="mr-2 btn-sm" variant="success"><i class="ri-printer-fill"></i></b-button>
                        </b-button-group>
                    </div>
                </div>
                <div class="row" style="margin-top:20px;">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                        {{ $t('tcbconfiguration.beneficiary_name_un') }}
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                    <b style="font-size: 18px;">{{ $i18n.locale === 'en' ? item.beneficiary_name : item.beneficiary_name_bn }}</b>
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row" style="margin-top:20px;">
                    <div class="col-sm" style="text-align: center; position: static;">
                    </div>
                    <div class="col-sm">
                        {{ $t('tcbconfiguration.nid_un_one') }}
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm" style="text-align: center;">
                    </div>
                    <div class="col-sm">
                        <b style="font-size: 18px;">{{ item.nid }}</b>
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row" style="margin-top:20px;">
                    <div class="col-sm" style="transform: translateY(34px);text-align: center;">
                    </div>
                    <div class="col-sm">
                        {{ $t('tcbconfiguration.card_no_un') }}
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm" style="transform: translateY(34px);text-align: center;">
                    </div>
                    <div class="col-sm">
                        <b style="font-size: 18px;">{{ item.card_no }}</b>
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row" style="margin-top:20px;">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                        {{ $t('globalTrans.occupation') }}
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                        <b style="font-size: 18px;">{{ $i18n.locale === 'en' ? occupation.text_en : occupation.text_bn }}</b>
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row" style="margin-top:20px;">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                        {{ $t('tcbconfiguration.mobile') }}
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm">
                    </div>
                    <div class="col-sm">
                        <b style="font-size: 18px;">{{item.mobile}}</b>
                    </div>
                    <div class="col-sm">
                    </div>
                </div>
            </template>
    </b-row>
  </b-container>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Pdf from './pdf'
export default {
    props: ['item'],
    components: {
    },
    data () {
        return {
        cityCorp: '',
        ward: '',
        occupation: '',
        baseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    created () {
        var occupationone = [
                {
                    value: 1,
                    text_en: 'Housewife',
                    text_bn: 'গৃহিণী',
                    text: 'Housewife'
                },
                {
                    value: 2,
                    text_en: 'employee',
                    text_bn: 'চাকুরিজীবী',
                    text: 'employee'
                },
                {
                    value: 3,
                    text_en: 'day laborer',
                    text_bn: 'দিনমজুর',
                    text: 'day laborer'
                },
                {
                    value: 4,
                    text_en: 'Farmer',
                    text_bn: 'কৃষক',
                    text: 'Farmer'
                }
            ]
      this.occupation = occupationone.find(ele => ele.value === this.item.occupation)
      if (this.occupation === undefined) {
        this.occupation = {
            value: 0,
            text: '',
            text_en: '',
            text_bn: '',
            division_id: '',
            district_id: '',
            city_corporation_code: '',
            status: ''
        }
      }
      this.cityCorp = this.$store.state.CommonService.commonObj.cityCorporationList.filter(itemm => itemm.value === this.item.pre_city_corporation_id)
      if (this.cityCorp.length === 0) {
        this.cityCorp = {
            value: 0,
            text: '',
            text_en: '',
            text_bn: '',
            division_id: '',
            district_id: '',
            city_corporation_code: '',
            status: ''
        }
      } else {
      this.cityCorp = this.cityCorp[0]
      }
      this.ward = this.$store.state.CommonService.commonObj.wardList.filter(itemm => itemm.value === this.item.pre_ward_id)
      if (this.ward.length === 0) {
        this.ward = {
            value: 0,
            text: '',
            text_en: '',
            text_bn: '',
            division_id: '',
            district_id: '',
            city_corporation_code: '',
            status: ''
        }
      } else {
      this.ward = this.$store.state.CommonService.commonObj.wardList.filter(itemm => itemm.value === this.item.pre_ward_id)
      this.ward = this.ward[0]
      }
    },
    computed: {
    },
    methods: {
    pdfExport () {
      const reportTitle = this.$t('tcbconfiguration.region_office_wise')
      Pdf.exportPdfDetails(reportTitle, this.listData, this, this.item, this.cityCorp, this.ward, this.occupation)
    }
    }
}

</script>
