<template>
  <b-container fluid>
    <b-row>
    <b-row class="text-right mb-2">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                    <i class="ri-printer-line"></i> {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
        </b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit()" @reset.prevent="reset">
                 <table style="width:100%">
                    <tr style="margin-top:20px;">
                        <td colspan="2" class="text-center" style="font-size:20px; font-width:bold"> {{$t('allocation_dc_office.delivery')}} {{$t('allocation_dc_office.challan')}}</td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td style="width:50%">{{$t('globalTrans.fiscal_year')}}: {{getFiscalYear(items.fiscal_year_id)}}</td>
                        <td class="text-right" style="width:50%;">{{ $t('allocation_management.allotment_count')}}: {{ $n(items.allotment_count? items.allotment_count : items.allotment_count_id) }}</td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td style="width:50%">{{$t('allocation_dc_office.delivery_date')}}: {{items.allotment_date | dateFormat}}</td>
                        <td class="text-right" style="width:50%;">{{$t('allocation_dc_office.delivery_order_no')}}: {{items.delivery_order_no}}</td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td class="text-center" colspan="2"> {{$t('allocation_dc_office.dc_office_name')}} : {{ getDistrictName(items.district_id) }} {{$t('allocation_dc_office.dc_office')}}</td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td style="width:50%">{{ $t('allocation_management.regional_office')}}: {{ getOfficeName(items.regional_office_id) }}</td>
                        <td class="text-right" style="width:50%;">{{$t('allocation_dc_office.warehouse_name')}}: {{ getWareName(items.warehouse_id) }}</td>
                    </tr>
                </table>
                <table style="width:100%;margin-top:10px" border="1" class="text-center">
                    <tr class="tboder">
                        <th style="width:5%;" class="tboder">{{$t('globalTrans.sl_no')}}</th>
                        <th class="tboder" style="width:20%;">&nbsp;{{$t('allocation_management.item_name')}}</th>
                        <th style="width:10%;" class="tboder">{{$t('allocation_management.item_quantity')}} ({{$t('allocation_dc_office.unit')}})</th>
                        <th style="width:10%;" class="tboder">{{$t('allocation_management.unit_rate')}}</th>
                        <th style="width:15%;" class="tboder">{{$t('allocation_management.total_price')}} </th>
                        <th style="width:10%;" class="tboder">{{$t('allocation_dc_office.commission')}} </th>
                        <th style="width:10%;" class="tboder">{{$t('allocation_management.selling_amount')}} </th>
                        <th style="width:10%;" class="tboder">{{$t('globalTrans.tax')}} </th>
                    </tr>
                    <template v-if="detailsArr && detailsArr.length > 0">
                    <tr class="tboder" v-for="(detail,index) in detailsArr" :key="detail.id">
                        <td class="tboder" style="padding:15px">{{$n(index+1)}}</td>
                        <td class="tboder">{{itemCategoryName(detail.item_category_id)}}</td>
                        <td class="tboder">{{$n(detail.distribution_qty)}}</td>
                        <td class="tboder">{{$n(detail.rate)}}</td>
                        <td class="tboder">{{$n(detail.total_pirce) }}</td>
                        <td class="tboder">{{$n(detail.commission) }}</td>
                        <td class="tboder">{{$n(detail.selling_amount)}}</td>
                        <td class="tboder">{{$n(detail.tax)}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder text-right" colspan="4">{{$t('globalTrans.total')}} {{$t('globalTrans.taka')}} </td>
                        <td class="tboder">{{$n(totalPriceSum())}}</td>
                        <td class="tboder">{{$n(totalCommissionSum())}}</td>
                        <td class="tboder">{{$n(totalSellingAmountSum())}}</td>
                        <td class="tboder">{{$n(totalTaxSum())}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder text-right" colspan="6">{{$t('allocation_dc_office.total_payable_amount')}} </td>
                        <td class="tboder" colspan="2">{{$n(totalPayableAmount())}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder text-left" colspan="8">&nbsp;{{$t('allocation_management.taka_in_word')}} : {{$i18n.locale === 'bn' ? convertNumberToBanglaWords(totalPayableAmount()) : convertNumberToEnglishWords(totalPayableAmount())}}</td>
                    </tr>
                    </template>
                </table>
                <table style="width:100%;margin-top:70px" class="text-center">
                    <tr>
                        <td style="width:50%;">{{$t('allocation_dc_office.signature_of_storekeeper')}}</td>
                      <td style="width:50%;">{{$t('allocation_dc_office.signature_of_dc_office')}}</td>
                    </tr>
                </table>
            </b-form>
    </b-overlay>
  </ValidationObserver>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { getItemPrice } from '../../api/routes'
import Pdf from './pdf'
export default {
    props: ['items', 'challan_id'],
    components: {
    },
    data () {
        return {
            loading: true,
            formData: [],
            challanItems: [],
            allotmentItems: [],
            detailsArr: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    created () {
        const deliveryEntry = this.items.delivery_items.find(item => item.challan_id === this.challan_id)
        this.challanItems = JSON.parse(JSON.stringify(deliveryEntry.details))
        this.getItemCategoryTotal(this.challanItems)
        this.itemPrice()
    },
    mounted () {
        // core.index()
    },
    computed: {
        //  loading: function () {
        //     return this.$store.state.commonObj.loading
        // },
        currentLocale () {
            return this.$i18n.locale
        },
        allTotal () {
            return this.items.details.reduce((sum = 0, item) => sum + item.tax_amount + item.selling_amount, 0)
        }
    },
    methods: {
       getItemCategoryTotal (data) {
            this.detailsArr = []
            const arr = []
            data.forEach(item => {
                const obj = arr.find(item2 => item2.item_category_id === item.item_category_id)
                if (typeof obj !== 'undefined') {
                    obj.distribution_qty += parseFloat(item.distribution_qty)
                    obj.rate += parseFloat(item.rate)
                    obj.total_pirce += parseFloat(item.total_pirce)
                    obj.commission += parseFloat(item.commission)
                    obj.selling_amount += parseFloat(item.selling_amount)
                    obj.tax += parseFloat(item.tax)
                } else {
                    arr.push(item)
                }
            })
            this.detailsArr = arr
        },
        totalPriceSum () {
            return this.detailsArr.reduce((sum = 0, item) => sum + item.total_pirce, 0)
        },
        totalCommissionSum () {
            return this.detailsArr.reduce((sum = 0, item) => sum + item.commission, 0)
        },
        totalSellingAmountSum () {
            return this.detailsArr.reduce((sum = 0, item) => sum + item.selling_amount, 0)
        },
        totalTaxSum () {
            return this.detailsArr.reduce((sum = 0, item) => sum + item.tax, 0)
        },
        totalPayableAmount () {
            return this.detailsArr.reduce((sum = 0, item) => sum + item.tax + item.selling_amount, 0)
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
                    wordsString += ' হাজার '
                } else if (i === 6 && value !== 0) {
                    wordsString += 'শ '
                }
                }

                wordsString = wordsString.split('  ').join(' ')
            }
            return wordsString
            },
        categoryName (catId) {
            const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        getWareName (wareId) {
        const wareObj = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === wareId)
        if (wareObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return wareObj.text_bn
            } else {
                return wareObj.text_en
            }
        }
        },
        itemCategoryName (itemId) {
            const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === itemId)
            if (itemObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return itemObj.text_bn
                } else {
                    return itemObj.text_en
                }
            }
        },
        getDistrictName (id) {
            if (id) {
                const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
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

        async itemPrice () {
            this.loading = true
            const params = {
                fiscal_year_id: this.items.fiscal_year_id,
                allotment_count_id: this.items.allotment_count_id,
                delivery_order_date: this.items.allotment_date
            }
            this.loadHistory = true
            const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getItemPrice, params)
            this.loadHistory = false
            if (result.success) {
                const taxCommission = result.tax_and_commission
                this.allotmentItems = result.data.details
                this.allotmentItems.forEach((element, index) => {
                    this.detailsArr.map(singleItem => {
                        singleItem.rate = element.selling_amount
                        singleItem.total_pirce = parseFloat(element.selling_amount) * parseFloat(singleItem.distribution_qty)
                        singleItem.commission = parseFloat(taxCommission.commission_value) * parseFloat(singleItem.distribution_qty)
                        singleItem.selling_amount = (parseFloat(element.selling_amount) * parseFloat(singleItem.distribution_qty)) - (parseFloat(taxCommission.commission_value) * parseFloat(singleItem.distribution_qty))
                        singleItem.tax = (parseFloat(taxCommission.commission_value) * parseFloat(singleItem.distribution_qty)) * (parseFloat(taxCommission.tax_value) / 100)
                   })
                })
                this.loading = false
            } else {
                this.allotmentItems = []
            }
        },
        getFiscalYear (yearId) {
            const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        pdfExport () {
           Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.items, this.detailsArr, this)
        }
    }
}
</script>
<style scoped>
    .tboder{
        border: 1px solid black;
    }
</style>
