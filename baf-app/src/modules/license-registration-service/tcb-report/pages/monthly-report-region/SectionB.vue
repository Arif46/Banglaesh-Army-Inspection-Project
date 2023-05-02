<template>
        <div style="width:100%;overflow-x:auto;">
        <table style="width:100%;" class="table-sm">
          <tr>
            <th colspan="17" class="text-left">{{ $t('tcb_report.month_name_equal') }} {{ getMonthName() }}</th>
            <th colspan="5">{{ $t('tcb_report.table_b') }}</th>
          </tr>
          <tr>
            <th colspan="22" style="text-align: center">{{ $t('tcb_report.warehouse_monthly_text_bill') }}</th>
          </tr>
          <tr>
            <th rowspan="3" style="text-align: left">{{ $t('tcb_report.sl_no') }}</th>
            <th rowspan="3" style="text-align: center">{{ $t('tcb_report.product_name') }}</th>
            <th rowspan="3" style="text-align: center">{{ $t('tcb_report.contact_no_and_brand') }}</th>
            <th colspan="6" style="text-align: center">{{ $t('tcb_report.sale_in_general_allotment') }}</th>
            <th colspan="6" style="text-align: center" >{{ $t('tcb_report.truck_sale_e') }}</th>
            <th colspan="2" rowspan="2" style="text-align: center">{{ $t('tcb_report.online_open_sale') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.total_sales_amount') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.total_price_of_sold_products') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.income_tax') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.money_deposited_in_the_bank') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.comment') }}</th>
          </tr>
          <tr>
            <th colspan="2">{{ $t('tcb_report.0_50_km') }}</th>
            <th colspan="2">{{ $t('tcb_report.50_100_km') }}</th>
            <th colspan="2">{{ $t('tcb_report.100_km') }}</th>
            <th colspan="2">{{ $t('tcb_report.0_50_km') }}</th>
            <th colspan="2">{{ $t('tcb_report.50_100_km') }}</th>
            <th colspan="2">{{ $t('tcb_report.100_km') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
          <tr>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th>{{ $t('tcb_report.taka') }}</th>
            <th>{{ $t('tcb_report.quantity') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
          <tr>
            <th>{{ $n('1') }}</th>
            <th>{{ $n('2') }}</th>
            <th>{{ $n('3') }}</th>
            <th>{{ $n('4') }}</th>
            <th>{{ $n('5') }}</th>
            <th>{{ $n('6') }}</th>
            <th>{{ $n('7') }}</th>
            <th>{{ $n('8') }}</th>
            <th>{{ $n('9') }}</th>
            <th>{{ $n('10') }}</th>
            <th>{{ $n('11') }}</th>
            <th>{{ $n('12') }}</th>
            <th>{{ $n('13') }}</th>
            <th>{{ $n('14') }}</th>
            <th>{{ $n('15') }}</th>
            <th>{{ $n('16') }}</th>
            <th>{{ $n('17') }}</th>
            <th style="text-align: center">{{ $n('18') + "= (" + $n('4') + "+" + $n('6') + "+" + $n('8') + "+" + $n('10') + "+" + $n('12') + "+" + $n('14') + "+" + $n('16') + ")" }}</th>
            <th style="text-align: center">{{ $n('19') + "= (" + $n('5') + "+" + $n('7') + "+" + $n('9') + "+" + $n('11') + "+" + $n('13') + "+" + $n('15') + "+" + $n('17') + ")" }}</th>
            <th>{{ $n('20') }}</th>
            <th>{{ $n('21') }}</th>
            <th>{{ $n('22') }}</th>
          </tr>
          <slot v-for="(item, index) in data.itemList">
            <slot v-for="(innerItem, indx) in item.contractItems">
              <tr v-if="indx == 0" :key="index">
                <td :rowspan="item.contractItems.length+1">{{ $n(index+1) }}</td>
                <td :rowspan="item.contractItems.length">
                  {{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}
                </td>
                <td>
                  {{ $i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name }}
                </td>
                <td>{{ $n(innerItem.store_sale_distance_1 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_1) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_2 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_2) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_3 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_3) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_1 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_1) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_2 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_2) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_3 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_3) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(innerItem.total_sale_quantity) }}</td>
                <td>{{ $n(innerItem.total_sale_price) }}</td>
                <td>{{ $n(innerItem.tax_amount) }}</td>
                <td>{{ $n(innerItem.total_sale_price) }}</td>
                <td></td>
              </tr>
              <tr v-else :key="index + indx + 100">
                <td>
                  {{ $i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name }}
                </td>
                <td>{{ $n(innerItem.store_sale_distance_1 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_1) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_2 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_2) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_3 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.store_sale_distance_3) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_1 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_1) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_2 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_2) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_3 * innerItem.selling_price) }}</td>
                <td>{{ $n(innerItem.truck_sale_distance_3) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(innerItem.total_sale_quantity) }}</td>
                <td>{{ $n(innerItem.total_sale_price) }}</td>
                <td>{{ $n(innerItem.tax_amount) }}</td>
                <td>{{ $n(innerItem.total_sale_price) }}</td>
                <td></td>
              </tr>
            </slot>
              <tr :key="index + indx + 500">
                <td>{{ $t('tcb_report.sub_total') }}</td>
                <td></td>
                <td>{{ $n(item.item_store_sale_price_distance_1) }}</td>
                <td>{{ $n(item.item_store_sale_distance_1) }}</td>
                <td>{{ $n(item.item_store_sale_price_distance_2) }}</td>
                <td>{{ $n(item.item_store_sale_distance_2) }}</td>
                <td>{{ $n(item.item_store_sale_price_distance_3) }}</td>
                <td>{{ $n(item.item_store_sale_distance_3) }}</td>
                <td>{{ $n(item.item_truck_sale_price_distance_1) }}</td>
                <td>{{ $n(item.item_truck_sale_distance_1) }}</td>
                <td>{{ $n(item.item_truck_sale_price_distance_2) }}</td>
                <td>{{ $n(item.item_truck_sale_distance_2) }}</td>
                <td>{{ $n(item.item_truck_sale_price_distance_3) }}</td>
                <td>{{ $n(item.item_truck_sale_distance_3) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(0) }}</td>
                <td>{{ $n(item.item_total_sale_quantity) }}</td>
                <td>{{ $n(item.item_total_sale_price) }}</td>
                <td>{{ $n(item.item_tax_amount) }}</td>
                <td>{{ $n(item.item_total_sale_price) }}</td>
                <td></td>
              </tr>
          </slot>
          <tr>
            <td style="text-align: right;" colspan="18">{{ $t('tcb_report.total_money_deposit_bank') }} {{ data.final_amount ? ($i18n.locale === 'bn' ? convertNumberToBanglaWords(data.final_amount) : convertNumberToEnglishWords(data.final_amount)) : 0 }}</td>
            <td></td>
            <td></td>
            <td>{{ data.final_amount ? $n(data.final_amount) : 0 }}</td>
            <td></td>
          </tr>
          <tr>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border-bottom: 1px solid black;border-right: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-bottom: 1px solid black;"></th>
            <th style="border: 1px solid grey;border-bottom: 1px solid black;"></th>
            <th style="border: 1px solid grey;border-bottom: 1px solid black;"></th>
            <th style="border: 1px solid grey;border-bottom: 1px solid black"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;"></th>
            <th colspan="5">{{ $t('tcb_report.advance_deposit_by_dealer') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
          <tr>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;border-bottom: 1px solid grey;"></th>
            <th colspan="4">{{ $t('tcb_report.total_number_of_days_alloted') }}</th>
            <th></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;"></th>
            <th colspan="5">{{ $t('tcb_report.extra_deposit_by_dealer') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
          <tr>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;border-bottom: 1px solid grey;"></th>
            <th colspan="4">{{ $t('tcb_report.total_truck_sale') }}</th>
            <th></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;"></th>
            <th colspan="5">{{ $t('tcb_report.less_deposit_by_dealer_e') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
          <tr>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;"></th>
            <th style="border: 1px solid grey;border-right: 1px solid black;"></th>
            <th colspan="5">{{ $t('tcb_report.total_money_deposit_bank_e') }}</th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
          </tr>
        </table>
        </div>
</template>
<script>
  export default {
    props: ['search', 'data'],
    data () {
      return {
      }
    },
    created () {
    },
    methods: {
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
