<template>
  <b-row>
    <b-col lg="12" sm="12">
      <iq-card>
            <b-overlay :show="loading">
              <b-row>
                <b-col>
                  <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                    <template v-slot:projectNameSlot>
                      {{ }}
                    </template>
                    {{ $t('priceMonitoring.fine_receipt') + ' ' + $t('globalTrans.details') }}
                  </list-report-head>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" sm="12">
                  <div>
                    <b-table-simple hover small caption-top responsive striped borderless>
                      <b-tr>
                        <b-td width="40%">{{ $t('globalTrans.district') }}</b-td>
                        <b-td>: {{ currentLocale === 'en' ? detailsData.district_name_en : detailsData.district_name_bn }}</b-td>
                      </b-tr>
                      <b-tr v-if="detailsData.area_type_id === 1">
                        <b-td>{{ $t('globalTrans.city_corporation') }}</b-td>
                        <b-td>: {{ currentLocale === 'en' ? detailsData.city_corporation_name_en : detailsData.city_corporation_name_bn }}</b-td>
                      </b-tr>
                      <template v-else>
                        <b-tr>
                          <b-td>{{ $t('globalTrans.upazila') }}</b-td>
                          <b-td>: {{ currentLocale === 'en' ? detailsData.upazila_name_en : detailsData.upazila_name_bn }}</b-td>
                        </b-tr>
                        <b-tr v-if="detailsData.area_type_id === 2">
                          <b-td>{{ $t('globalTrans.pouroshova') }}</b-td>
                          <b-td>: {{ currentLocale === 'en' ? detailsData.pauroshoba_name_en : detailsData.pauroshoba_name_bn }}</b-td>
                        </b-tr>
                      </template>
                      <b-tr>
                        <b-td>{{ $t('priceMonitoring.case_number') }}</b-td>
                        <b-td>: {{ detailsData.case_number }}</b-td>
                      </b-tr>
                      <b-tr>
                        <b-td>{{ $t('priceMonitoring.accused_person_name_address') }}</b-td>
                        <b-td v-if="currentLocale === 'en'">
                          <div class="d-flex m-0 p-0">
                            <span>:</span>&nbsp;
                            <span>
                              {{ detailsData.accused_person_name_en }}<br>
                              {{ detailsData.accused_person_address_en }}
                            </span>
                          </div>
                        </b-td>
                        <b-td v-else>
                          <div class="d-flex m-0 p-0">
                            <span>:</span>&nbsp;
                            <span>
                              {{ detailsData.accused_person_name_bn }}<br>
                              {{ detailsData.accused_person_address_bn }}
                            </span>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-td>{{ $t('priceMonitoring.mobile_no') }}</b-td>
                        <b-td>: {{ detailsData.mobile_no | mobileNumber }}</b-td>
                      </b-tr>
                      <b-tr>
                        <b-td>{{ $t('priceMonitoring.date_of_conviction') }}</b-td>
                        <b-td>: {{ detailsData.date_of_conviction | dateFormat }}</b-td>
                      </b-tr>
                      <b-tr v-if="detailsData.fine_details && detailsData.fine_details.sections">
                        <b-td>{{ $t('priceMonitoring.convicted_of_that_crime') }}</b-td>
                        <b-td>
                          <div class="d-flex m-0 p-0">
                            <span>:</span>&nbsp;
                            <span>
                              <template v-if="currentLocale === 'en'">
                                {{ $t('priceMonitoring.fine_description_of_sections') + ' ' + detailsData.fine_details.law_name_en }}
                              </template>
                              <template v-else>
                                {{ detailsData.fine_details.law_name_bn + ' ' + $t('priceMonitoring.fine_description_of_sections') }}
                              </template>
                              <br>
                              <span v-for="(item, index) in detailsData.fine_details.sections" :key="index">
                                {{ $n(index + 1) + ') ' + $n(item.section_number) + ' ' + $t('priceMonitoring.amount_in_taka') + ' ' + $n(item.fine_amount) }} <br>
                              </span>
                            </span>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr v-if="detailsData.fine_details && detailsData.fine_details.sections">
                        <b-td>{{ $t('priceMonitoring.amount_of_total_fine') }}</b-td>
                        <b-td>
                          <div class="d-flex m-0 p-0">
                            <span>:</span>&nbsp;
                            <span>
                            {{ $t('priceMonitoring.taka_in_numbers') + ' ' + $n(getTotalFineAmount(detailsData.fine_details.sections)) }}
                            <br>
                            ({{ $t('priceMonitoring.in_words') + ' ' + (currentLocale === 'en' ? convertNumberToEnglishWords(getTotalFineAmount(detailsData.fine_details.sections)) : convertNumberToBanglaWords(getTotalFineAmount(detailsData.fine_details.sections)) + $t('priceMonitoring.taka')) + ') ' +  $t('priceMonitoring.only') }}
                            </span>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-td><br><br><br><br><br>{{ $t('globalTrans.date') }}:.....................................</b-td>
                        <b-td class="text-center">
                          <br><br><br>
                          {{ $t('globalTrans.signature') }} <br><br>
                          .......................................... <br><br>
                          {{ $t('priceMonitoring.seal_of_fine_collecting_disposal_officer') }}
                          <br><br><br><br>
                        </b-td>
                      </b-tr>
<!--                      <b-tr>-->
<!--                        <b-td>-->
<!--                          <br>-->
<!--                          {{ $t('priceMonitoring.challan_no') }}..........................-->
<!--                        </b-td>-->
<!--                        <b-td>-->
<!--                          <br>-->
<!--                          {{ $t('globalTrans.date') }}..........................-->
<!--                        </b-td>-->
<!--                      </b-tr>-->
<!--                      <b-tr>-->
<!--                        <b-td>-->
<!--                          {{ $t('priceMonitoring.name_of_bank_branch') }} <br><br>-->
<!--                          ......................................................-->
<!--                        </b-td>-->
<!--                        <b-td>-->
<!--                          {{ $t('priceMonitoring.in_government_treasury') }} <br>-->
<!--                          {{ $t('priceMonitoring.taka') }} ........................... <br>-->
<!--                          ({{ $t('priceMonitoring.in_words') }}................................................................) <br>-->
<!--                          {{ $t('priceMonitoring.submitted') }}-->
<!--                        </b-td>-->
<!--                      </b-tr>-->
                    </b-table-simple>
                  </div>
                </b-col>
              </b-row>
            </b-overlay>
      </iq-card>
    </b-col>
  </b-row>
</template>
<script>
import { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { helpers } from '@/utils/helper-functions'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'

  export default {
  name: 'Details',
  mixins: [bazarMonitoringServiceMixin],
  props: ['id'],
  data () {
    return {
      detailsData: {},
      officer: {},
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl
    }
  },
  components: {
    ListReportHead
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  created () {
    if (this.id) {
      let tmp = this.getFormData()
      const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === tmp.district_id)
      const upazila = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === tmp.upazila_id)
      const pauroshoba = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === tmp.pauroshoba_id)
      const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === tmp.city_corporation_id)
      const customItem = {
        district_name_en: district?.text_en,
        district_name_bn: district?.text_bn,
        upazila_name_en: upazila?.text_en,
        upazila_name_bn: upazila?.text_bn,
        pauroshoba_name_en: pauroshoba?.text_en,
        pauroshoba_name_bn: pauroshoba?.text_bn,
        city_corporation_name_en: cityCorporation?.text_en,
        city_corporation_name_bn: cityCorporation?.text_bn
      }
      const law = this.$store.state.BazarMonitoringService.commonObj.lawEntryList.find(obj => obj.value === parseInt(tmp.fine_details?.law_id))
      const customItemLaw = {
        law_name_en: law?.text_en,
        law_name_bn: law?.text_bn
      }
      tmp.fine_details = Object.assign({}, tmp.fine_details, customItemLaw)
      if (tmp.fine_details && tmp.fine_details.sections) {
        tmp.fine_details.sections = tmp.fine_details?.sections.map(item => {
          const section = this.$store.state.BazarMonitoringService.commonObj.sectionList.find(obj => obj.value === parseInt(item.section_id))
          const customItem = {
            section_name_en: section?.text_en,
            section_name_bn: section?.text_bn
          }
          return Object.assign({}, item, customItem)
        })
      }
      tmp = Object.assign({}, tmp, customItem)
      this.detailsData = tmp
    }
  },
  methods: {
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getCaseNumber () {
      if (this.currentLocale === 'en') {
        return this.detailsData.case_number
      } else {
        const caseNumberArr = this.detailsData.case_number.split('Commerce-')
        if (caseNumberArr[1] !== undefined) {
          const caseNumberPart = caseNumberArr[1].split('/')
          const year = helpers.convertEnglishToBanglaNumber(parseInt(caseNumberPart[0]))
          let caseNumberMain
          if (caseNumberPart[1] !== undefined) {
            caseNumberMain = helpers.convertEnglishToBanglaNumber(parseInt(caseNumberPart[1].replace('0000', '')))
          }
          let caseNumberBn = ''
          if (year !== undefined && caseNumberMain !== undefined) {
            caseNumberBn = 'বাণিজ্য-' + year + '/' + this.$n(0) + this.$n(0) + this.$n(0) + this.$n(0) + caseNumberMain
          }
          return caseNumberBn
        }
      }
    },
    getTotalFineAmount (sections) {
      let total = 0
      if (sections && sections.length) {
        sections.forEach(item => {
          total += item.fine_amount
        })
      }
      return total
    },
    empty (str) {
      return (!str || str.length === 0)
    },
    convertNumberToEnglishWords (number) {
      if ((number < 0) || (number > 999999999)) {
        alert('Number is out of range')
        return
      }
      const numberArray = number.toString().split('.')
      const numberWithoutFloatingPart = numberArray[0] ? parseInt(numberArray[0]) : 0
      const numberWithFloatingPart = numberArray[1]
      let stringBeforeFloatingPart = ''
      if (numberWithoutFloatingPart) {
        stringBeforeFloatingPart = this.convertNumber(numberWithoutFloatingPart)
      }
      let numberWords = stringBeforeFloatingPart
      if (numberWithFloatingPart) {
        if (stringBeforeFloatingPart) {
          numberWords += stringBeforeFloatingPart + ' Point ' + this.convertNumber(parseInt(numberWithFloatingPart))
        } else {
          numberWords += 'Point ' + this.convertNumber(parseInt(numberWithFloatingPart))
        }
      }
      return numberWords
    },
    convertNumber (number) {
      const Kt = Math.floor(number / 10000000) /* Koti */
      number -= Kt * 10000000
      const Gn = Math.floor(number / 100000) /* lakh  */
      number -= Gn * 100000
      const kn = Math.floor(number / 1000) /* Thousands (kilo) */
      number -= kn * 1000
      const Hn = Math.floor(number / 100) /* Hundreds (hecto) */
      number -= Hn * 100
      const Dn = Math.floor(number / 10) /* Tens (deca) */
      const n = number % 10 /* Ones */

      let res = ''

      if (Kt) {
        res += this.convertNumber(Kt) + ' Koti '
      }
      if (Gn) {
        res += this.convertNumber(Gn) + ' Lakh'
      }

      if (kn) {
        res += (this.empty(res) ? '' : ' ') +
          this.convertNumber(kn) + ' Thousand'
      }

      if (Hn) {
        res += (this.empty(res) ? '' : ' ') +
          this.convertNumber(Hn) + ' Hundred'
      }

      const ones = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
        'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve', 'Thirteen',
        'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eightteen',
        'Nineteen']
      const tens = ['', '', 'Twenty', 'Thirty', 'Fourty', 'Fifty', 'Sixty',
        'Seventy', 'Eigthy', 'Ninety']

      if (Dn || n) {
        if (!this.empty(res)) {
          res += ' and '
        }

        if (Dn < 2) {
          res += ones[Dn * 10 + n]
        } else {
          res += tens[Dn]

          if (n) {
            res += '-' + ones[n]
          }
        }
      }

      if (this.empty(res)) {
        res = 'zero'
      }

      return res
    },
    convertNumberToBanglaWords (amount) {
      const Words = ['', 'এক', 'দুই', 'তিন', 'চার', 'পাঁচ', 'ছয়', 'সাত', 'আট', 'নয়', 'দশ',
        'এগার', 'বার', 'তের', 'চৌদ্দ', 'পনের', 'ষোল', 'সতের', 'আঠার', 'ঊনিশ', 'বিশ',
        'একুশ', 'বাইশ', 'তেইশ', 'চব্বিশ', 'পঁচিশ', 'ছাব্বিশ', 'সাতাশ', 'আঠাশ', 'ঊনত্রিশ', 'ত্রিশ',
        'একত্রিশ', 'বত্রিশ', 'তেত্রিশ', 'চৌত্রিশ', 'পঁয়ত্রিশ', 'ছত্রিশ', 'সাঁইত্রিশ', 'আটত্রিশ', 'ঊনচল্লিশ', 'চল্লিশ',
        'একচল্লিশ', 'বিয়াল্লিশ', 'তেতাল্লিশ', 'চুয়াল্লিশ', 'পঁয়তাল্লিশ', 'ছেচল্লিশ', 'সাতচল্লিশ', 'আটচল্লিশ', 'ঊনপঞ্চাশ', 'পঞ্চাশ',
        'একান্ন', 'বায়ান্ন', 'তিপ্পান্ন', 'চুয়ান্ন', 'পঞ্চান্ন', 'ছাপ্পান্ন', 'সাতান্ন', 'আটান্ন', 'ঊনষাট', 'ষাট',
        'একষট্টি', 'বাষট্টি', 'তেষট্টি', 'চৌষট্টি', 'পঁয়ষট্টি', 'ছেষট্টি', 'সাতষট্টি', 'আটষট্টি', 'ঊনসত্তর', 'সত্তর',
        'একাতর', 'বাহাত্তর', 'তিয়াত্তর', 'চুয়াত্তর', 'পঁচাত্তর', 'ছিয়াত্তর', 'সাতাত্তর', 'আটাত্তর', 'ঊনআশি', 'আশি',
        'একাশি', 'বিরাশি', 'তিরাশি', 'চুরাশি', 'পঁচাশি', 'ছিয়াশি', 'সাতাশি', 'আটাশি', 'ঊননব্বই', 'নব্বই',
        'একানব্বই', 'বিরানব্বই', 'তিরানব্বই', 'চুরানব্বই', 'পঁচানব্বই', 'ছিয়ানব্বই', 'সাতানব্বই', 'আটানব্বই', 'নিরানব্বই']

      amount = amount.toString()
      const atemp = amount.split('.')
      let beforeWord = ''
      let afterWord = ''
      const beforeNumber = atemp[0]
      if (beforeNumber !== '0') {
        beforeWord = this.toWord(beforeNumber, Words)
      }
      if (atemp.length === 2) {
        const afterNumber = atemp[1]
        afterWord = this.toWord(afterNumber, Words)
        if (beforeWord !== '') {
          beforeWord += ' দশমিক ' + afterWord
        } else {
          beforeWord += 'দশমিক ' + afterWord
        }
      }
      return beforeWord
    },
    toWordOld (number, words) {
      var nLength = number.length
      var wordsString = ''

      if (nLength <= 9) {
        const nArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        const receivedNArray = []
        for (let i = 0; i < nLength; i++) {
          receivedNArray[i] = number.substr(i, 1)
        }
        for (let i = 9 - nLength, j = 0; i < 9; i++, j++) {
          nArray[i] = receivedNArray[j]
        }
        for (let i = 0, j = 1; i < 9; i++, j++) {
          if (i === 0 || i === 2 || i === 4 || i === 7) {
            if (nArray[i] === 1) {
              nArray[j] = 10 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 2) {
              nArray[j] = 20 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 3) {
              nArray[j] = 30 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 4) {
              nArray[j] = 40 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 5) {
              nArray[j] = 50 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 6) {
              nArray[j] = 60 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 7) {
              nArray[j] = 70 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 8) {
              nArray[j] = 80 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 9) {
              nArray[j] = 90 + parseInt(nArray[j])
              nArray[i] = 0
            }
          }
        }

        var value = ''
        for (let i = 0; i < 9; i++) {
          value = parseInt(nArray[i])
          if (value !== 0) {
            wordsString += words[value] + ''
          }
          if ((i === 1 && value !== 0) || (i === 0 && value !== 0 && nArray[i + 1] === 0)) {
            wordsString += ' কোটি '
          }
          if ((i === 3 && value !== 0) || (i === 2 && value !== 0 && nArray[i + 1] === 0)) {
            wordsString += ' লাখ '
          }
          if ((i === 5 && value !== 0) || (i === 4 && value !== 0 && nArray[i + 1] === 0)) {
            wordsString += ' হাজার '
          } else if (i === 6 && value !== 0) {
            wordsString += 'শ '
          }
        }

        wordsString = wordsString.split('  ').join(' ')
      }
      return wordsString
    },
    toWord (number, words) {
      var nLength = number.length
      var wordsString = ''

      if (nLength <= 9) {
        const nArray = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        const receivedNArray = []
        for (let i = 0; i < nLength; i++) {
          receivedNArray[i] = parseInt(number.substr(i, 1))
        }
        for (let i = 9 - nLength, j = 0; i < 9; i++, j++) {
          nArray[i] = receivedNArray[j]
        }
        for (let i = 0, j = 1; i < 9; i++, j++) {
          if (i === 0 || i === 2 || i === 4 || i === 7) {
            if (nArray[i] === 1) {
              nArray[j] = 10 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 2) {
              nArray[j] = 20 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 3) {
              nArray[j] = 30 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 4) {
              nArray[j] = 40 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 5) {
              nArray[j] = 50 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 6) {
              nArray[j] = 60 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 7) {
              nArray[j] = 70 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 8) {
              nArray[j] = 80 + parseInt(nArray[j])
              nArray[i] = 0
            } else if (nArray[i] === 9) {
              nArray[j] = 90 + parseInt(nArray[j])
              nArray[i] = 0
            }
          }
        }

        let value = ''
        for (let i = 0; i < 9; i++) {
          value = parseInt(nArray[i])
          if (value !== 0) {
            wordsString += words[value] + ''
          }
          if ((i === 1 && value !== 0) || (i === 0 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
            wordsString += ' কোটি '
          }
          if ((i === 3 && value !== 0) || (i === 2 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
            wordsString += ' লাখ '
          }
          if ((i === 5 && value !== 0) || (i === 4 && value !== 0 && parseInt(nArray[i + 1]) === 0)) {
            wordsString += ' হাজার '
          } else if (i === 6 && value !== 0) {
            wordsString += 'শ '
          }
        }

        wordsString = wordsString.split('  ').join(' ')
      }
      return wordsString
    },
    pdfExport () {
      const reportTitle = this.$t('priceMonitoring.fine_receipt') + ' ' + this.$t('globalTrans.details')
      ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this)
    }
  }
}
</script>
