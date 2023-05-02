<template>
  <div style="width:100%;overflow-x:auto;">
    <p class="text-center mt-2"> {{ $t('tcb_report.total_product_transfer_report') }}</p>
    <table style="width:100%;" class="mt-2">
      <tr>
        <th rowspan="2" style="text-align: left">{{ $t('tcb_report.sl_no') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.regional_office') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.district_name') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.number_of_beneficiary') }}</th>
        <template v-if="items.length > 0">
          <th v-for="(item, index) in items" :key="index" style="text-align: center" colspan="4">{{ getItemCategoryName(item.item_category_id) }}</th>
        </template>
        <th rowspan="2" style="text-align: center">{{ $t('globalTrans.comments') }}</th>
      </tr>
       <template v-for="(item, index) in items">
        <th :key="index">{{ $t('tcb_report.allocated_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.supplier_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.tcb_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.remainder_amount') }}</th>
      </template>
      <!-- <tr>
        <th style="text-align: left">{{ $n('1') }}</th>
        <th style="text-align: center">{{ $n('2') }}</th>
        <th style="text-align: center">{{ $n('3') }}</th>
        <th style="text-align: center">{{ $n('4') }}</th>
        <th style="text-align: center">{{ $n('5') }}</th>
        <th style="text-align: center">{{ $n('6') }}</th>
        <th style="text-align: center">{{ $n('7') }}</th>
        <th style="text-align: center">{{ $n('8') }}</th>
        <th style="text-align: center">{{ $n('9') }}</th>
        <th style="text-align: center">{{ $n('10') }}</th>
        <th style="text-align: center">{{ $n('11') }}</th>
        <th style="text-align: center">{{ $n('12') }}</th>
        <th style="text-align: center">{{ $n('13') }}</th>
        <th style="text-align: center">{{ $n('14') }}</th>
        <th style="text-align: center">{{ $n('15') }}</th>
        <th style="text-align: center">{{ $n('16') }}</th>
      </tr> -->
      <template v-if="districts.length > 0">
          <tr v-for="(district, index) in districts" :key="index">
            <td style="text-align: left">{{ $n(index+1) }}</td>
            <td style="text-align: center" v-if="index == 0" :rowspan="districts.length">{{ getOfficeName(district.regional_office_id) }}</td>
            <td style="text-align: center">{{ getDistrictName(district.district_id) }}</td>
            <td style="text-align: center">{{ $n(district.total_beneficiary) }}</td>
            <template v-if="district.report_items.length > 0">
              <template v-for="(item, itemIn) in district.report_items">
                <td :key="itemIn">{{ $n(item.askQty) }}</td>
                <td :key="itemIn">{{ $n(0) }}</td>
                <td :key="itemIn">{{ $n(item.disQty) }}</td>
                <td :key="itemIn">{{ $n((item.askQty) - (item.disQty) ) }}</td>
              </template>
            </template>
            <template v-else>
                <template v-for="(item, index) in items">
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
              </template>
            </template>
            <td style="text-align: center"></td>
          </tr>
        </template>
    </table>
  </div>
</template>
<script>
  export default {
    props: ['search', 'data'],
    data () {
      return {
        valid: '',
        items: [],
        districts: []
      }
    },
    created () {
      this.districts = this.data
      this.items = this.data[0].items
      this.districts.forEach(district => {
          if (district.report_items.length > 0) {
            const summed = district.report_items.reduce((acc, cur, i) => {
            const item = i > 0 && acc.find(({ catId }) => catId === cur.catId)
            if (item) item.disQty += cur.disQty
            else acc.push({ catId: cur.catId, disQty: cur.disQty, askQty: cur.askQty }) // don't push cur here
            return acc
            }, [])
            district.report_items = summed
          }
      })
    },
    methods: {
      getItemCategoryName (itemId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === itemId)
      return item.text
    },
    getDistrictName (id) {
        const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
        if (obj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return obj.text_bn
            } else {
                return obj.text_en
            }
        }
    },
    getOfficeName (id) {
            const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
            if (typeof data !== 'undefined') {
                return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
            } else {
                return ''
            }
        },
      getMonthName () {
          const month = this.$store.state.commonObj.monthList.find(item => item.value === parseInt(this.search.month))
          if (typeof month !== 'undefined') {
            if (this.$i18n.locale === 'bn') {
              return month.text_bn
            } else {
              return month.text_en
            }
          } else {
            return ''
          }
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
              wordsString += ' হাজার '
            } else if (i === 6 && value !== 0) {
              wordsString += 'শ '
            }
          }

          wordsString = wordsString.split('  ').join(' ')
        }
        return wordsString
      },
      empty (str) {
        return (!str || str.length === 0)
      }
    }
  }
</script>

<style>
@import '../../style.css'
</style>
