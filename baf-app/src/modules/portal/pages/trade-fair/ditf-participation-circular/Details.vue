<template>
    <div>
      <b-card>
        <b-row>
          <b-overlay :show="loading">
            <list-report-head :base-url="baseUrl" uri="/itf-report-head/report-head/detail" :org-id="2">
              <template v-slot:projectNameSlot>
                {{ }}
              </template>
              {{ $t('portal.participation_circular_dhaka_international_trade_fair') }}
            </list-report-head>
            <b-row>
              <b-col sm="6"> <div class="mt-2"> <strong>{{$t('externalTradeFair.circular_memo_no')}} : </strong>{{ detailsData.circular_memo_no }} </div></b-col>
              <b-col sm="6">
                <div class="text-right mt-2"><strong>{{ $t('globalTrans.date')}} : </strong>{{ dateData(detailsData.updated_at) }}</div>
              </b-col>
            </b-row>
            <table class="table table-borderless mt-3">
              <tr>
                <th style="width: 22%;" class="p-0"> {{$t('externalTradeFair.subject')}}</th>
                <th style="width: 2%;" class="p-0">:</th>
                <td style="width: 76%;" class="p-0">{{ $i18n.locale === 'en' ? detailsData.title_en : detailsData.title_bn }}</td>
              </tr>
              <tr>
                <th style="width: 22%;" class="p-0">{{ $t('exportTrophyCircular.deadline') }}</th>
                <th style="width: 2%;" class="p-0">:</th>
                <td style="width: 76%;" class="p-0">{{ detailsData.deadline|dateFormat }}</td>
              </tr>
            </table>
            <b-table-simple bordered hover small v-if="detailsData?.circular_type === 1">
              <b-tbody>
                <tr>
                  <b-th colspan="5" class="text-center">{{ $t('portal.ditf_p_4') }}</b-th>
                </tr>
                <tr>
                  <b-th class="text-center" style="width:6%">{{ $t('globalTrans.sl_no') }}</b-th>
                  <b-th class="text-center" style="width:35%">{{ $t('portal.ditf_p_1') }}</b-th>
                  <b-th class="text-center" style="width:15%">{{ $t('portal.size') }}</b-th>
                  <b-th class="text-center" style="width:22%">{{ $t('portal.ditf_p_2') }}</b-th>
                  <b-th class="text-center" style="width:22%">{{ $t('portal.ditf_p_3') }}</b-th>
                </tr>
                <tr v-for="(detail, index) in detailsData.details?.filter(el => parseInt(el.stall_type) === 1)" :key="index">
                  <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.cat_name_en : detail.cat_name_bn }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.size_en : detail.size_bn }}</b-td>
                  <b-td class="text-center">{{ $t('portal.tk') + ' ' + $n(detail.processing_fee)+ '/-' }}</b-td>
                  <b-td class="text-center">{{ $t('portal.tk') + ' ' + $n(detail.floor_price)+ '/-' }}</b-td>
                </tr>
              </b-tbody>
            </b-table-simple>
            <b-table-simple bordered hover small v-if="detailsData?.circular_type === 1">
              <b-tbody>
                <tr>
                  <b-th colspan="5" class="text-center">{{ $t('portal.ditf_p_5') }}</b-th>
                </tr>
                <tr>
                  <b-th class="text-center" style="width:6%">{{ $t('globalTrans.sl_no') }}</b-th>
                  <b-th class="text-center" style="width:35%">{{ $t('portal.ditf_p_1') }}</b-th>
                  <b-th class="text-center" style="width:15%">{{ $t('portal.size') }}</b-th>
                  <b-th class="text-center" style="width:22%">{{ $t('portal.ditf_p_22') }}</b-th>
                  <b-th class="text-center" style="width:22%">{{ $t('portal.ditf_p_33') }}</b-th>
                </tr>
                <tr v-for="(detail, index1) in detailsData.details?.filter(el => parseInt(el.stall_type) === 2)" :key="index1">
                  <b-td class="text-center">{{ $n(index1 + 1) }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.cat_name_en : detail.cat_name_bn }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.size_en : detail.size_bn }}</b-td>
                  <b-td class="text-center">{{ $t('portal.usd') + ' ' + $n(detail.processing_fee) }}</b-td>
                  <b-td class="text-center">{{ $t('portal.usd') + ' ' + $n(detail.floor_price) }}</b-td>
                </tr>
              </b-tbody>
            </b-table-simple>
            <b-table-simple bordered hover small v-if="detailsData?.circular_type === 2">
              <b-tbody>
                <tr>
                  <b-th colspan="4" class="text-center">{{ $t('portal.ditf_p_6') }}</b-th>
                </tr>
                <tr>
                  <b-th class="text-center" style="width:8%">{{ $t('globalTrans.sl_no') }}</b-th>
                  <b-th class="text-center" style="width:40%">{{ $t('portal.ditf_p_7') }}</b-th>
                  <b-th class="text-center" style="width:26%">{{ $t('portal.ditf_p_8') }}</b-th>
                  <b-th class="text-center" style="width:26%">{{ $t('portal.ditf_p_9') }}</b-th>
                </tr>
                <tr v-for="(detail, index1) in detailsData.details?.filter(el => parseInt(el.stall_type) === 1)" :key="index1">
                  <b-td class="text-center">{{ $n(index1 + 1) }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.cat_name_en : detail.cat_name_bn }}</b-td>
                  <b-td class="text-center">{{ $n(detail.processing_fee)+ '/-' + ' (' + ($i18n.locale === 'en' ? convertNumberToEnglishWords(parseFloat(detail.processing_fee)) : convertNumberToBanglaWords(parseFloat(detail.processing_fee))) + ')' }}</b-td>
                  <b-td class="text-center">{{ $n(detail.floor_price)+ '/-' + ' (' + ($i18n.locale === 'en' ? convertNumberToEnglishWords(parseFloat(detail.floor_price)) : convertNumberToBanglaWords(parseFloat(detail.floor_price))) + ')' }}</b-td>
                </tr>
              </b-tbody>
            </b-table-simple>
            <b-table-simple bordered hover small v-if="detailsData.docs_details">
              <b-tbody>
                <tr>
                  <b-th colspan="3" class="text-center">{{ $t('ditfTradeFairManages.attachment_info') }}</b-th>
                </tr>
                <tr>
                  <b-th class="text-center" style="width:20%">{{ $t('globalTrans.sl_no') }}</b-th>
                  <b-th class="text-center" style="width:50%">{{ $t('globalTrans.document_name') }}</b-th>
                  <b-th class="text-center" style="width:30%">{{ $t('globalTrans.attachment') }}</b-th>
                </tr>
                <tr v-for="(detail, index11) in detailsData.docs_details" :key="index11">
                  <b-td class="text-center">{{ $n(index11 + 1) }}</b-td>
                  <b-td class="text-center">{{ $i18n.locale === 'en' ? detail.doc_name_en : detail.doc_name_bn }}</b-td>
                  <b-td class="text-center">
                    <a v-if="detail.attachment" :href="baseUrl + 'download-attachment?file=app/public/' + detail.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                    <!-- <a target="_blank" v-if="detail.attachment" :href="baseUrl + 'storage/' + detail.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a> -->
                  </b-td>
                </tr>
              </b-tbody>
            </b-table-simple>
            <table class="table table-borderless">
              <tr>
                <th style="width: 22%" class="pl-0">{{ $t('globalTrans.description') }}</th>
                <th style="width: 2%" class="pl-0">:</th>
                <td style="width: 76%" class="pl-0">{{ $i18n.locale === 'en' ? detailsData.description_en : detailsData.description_bn }}</td>
              </tr>
            </table>
          </b-overlay>
        </b-row>
      </b-card>
      <b-row class="text-right">
        <b-col>
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-details')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
      <!-- <pre>{{detailsData}}</pre> -->
    </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import moment from 'moment'
export default {
  name: 'Details',
  props: ['id', 'item'],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      loading: false,
      detailsData: {},
      deadline: '',
      fYear: '',
      lYear: ''
    }
  },
  created () {
    this.loadData()
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    dateData (fdate) {
      const date = moment(fdate).format('MM/DD/YYYY')
      // const date = moment(fdate).format('Do MMMM, YYYY')
      return date
    },
    getCircular () {
      this.loading = true
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      this.loading = false
      return JSON.parse(JSON.stringify(tmpData))
    },
    async loadData () {
      this.loading = true
      const params = {
        id: this.id,
        year: this.item.year,
        circular_type: this.item.circular_type
      }
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, '/portal/ditf-participation-circular/details', params)
      this.loading = false
      if (result.success) {
        this.detailsData = result.data
      } else {
        this.detailsData = ''
      }
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
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
            wordsString += ' হাজার'
          } else if (i === 6 && value !== 0) {
            wordsString += ' শ '
          }
        }

        wordsString = wordsString.split('  ').join(' ')
      }
      return wordsString
    },
    async pdfExport () {
      this.loading = true
      const params = Object.assign({ local: this.$i18n.locale, org_id: 2, id: this.id })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, '/portal/itf-calendar-circular-details', params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.loading = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
<style>
  /*Creation of vertical text in cell*/
  .vertical_Text {
    writing-mode: vertical-rl;
  }
</style>
