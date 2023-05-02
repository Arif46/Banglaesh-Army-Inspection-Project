<template>
  <b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit()" @reset.prevent="reset">
                <table style="width:100%" class="text-center">
                    <tr>
                        <th style="width:20%;text-align: left"><img height="60" width="60" src="@/assets/images/tcb_logo.png"></th>
                        <th style="width:50%;">
                            {{$t('allocation_management.tcb')}}
                            <p style="font-size:12px">{{$t('allocation_management.regional_office')}} <span style="border-bottom:1px dotted black;">{{ getOfficeName(items.office_id)}}</span></p>
                        </th>
                        <th style="font-size:12px">
                        {{$t('globalTrans.sl_no')}}-
                        <p style="font-size:12px;margin-top:5px">{{$t('allocation_management.buyer_copy')}}</p>
                        </th>
                    </tr>
                    <tr class="text-center" style="margin-top:20px;">
                        <td style="width:25%"></td>
                        <td  style="width:30%;font-weight:bold;"><span style="border-bottom: 1px solid black;">{{$t('allocation_management.do_sales_header')}}</span> </td>
                        <td>{{$t('globalTrans.date')}} : ...............</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table style="width:100%;margin-top:10px" border="1">
                                <tr class="tboder">
                                    <td style="width:50%;" class="tboder">{{$t('allocation_management.name_or_address')}}</td>
                                    <td  class="text-left" style="border-right:non
                                ;width:30%;">&nbsp;{{$t('allocation_management.all_letter_no')}} - {{items.allocation_letter_id}}</td>
                                    <td style="width:20%;">{{$t('globalTrans.date')}} : {{ items.pay_date }}</td>
                                </tr>
                                <tr class="tboder">
                                    <td class="tboder">
                                        <p class="d-block">{{ $i18n.locale === 'bn' ? items.applicant_name_bn : items.applicant_name }}</p>
                                        <p class="d-block">{{ $i18n.locale === 'bn' ? items.company_name_bn : items.company_name }}</p>
                                        <p class="d-block">{{ $i18n.locale === 'bn' ? items.village_bn : items.village }}</p>
                                    </td>
                                    <td colspan="2" class="tboder text-left">
                                       <p> &nbsp;{{$t('allocation_management.bank_pay')}} {{ items.transaction_no }}</p>
                                       <p> &nbsp;{{$t('allocation_management.mr_no')}} {{ items.challan_no }}</p>
                                       <p> &nbsp;{{$t('allocation_management.bank_name')}} {{ items.bank_name }} {{ ' , ' }} {{ items.branch_name }}</p>
                                       <p> &nbsp;{{$t('allocation_management.warehouse')}} {{$t('globalTrans.name')}}:</p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table style="width:100%;margin-top:10px" border="1" class="text-center">
                    <tr class="tboder">
                        <td style="width:5%;" class="tboder">{{$t('globalTrans.sl_no')}}</td>
                        <td  class="tboder" style="width:20%;">&nbsp;{{$t('allocation_management.item_name')}}</td>
                        <td style="width:15%;" class="tboder">{{$t('allocation_management.item_quantity')}}</td>
                        <td style="width:15%;" class="tboder">{{$t('allocation_management.unit_rate')}}</td>
                        <td style="width:22%;" class="tboder">{{$t('allocation_management.total_price')}} </td>
                        <td style="width:23%;" class="tboder">{{$t('allocation_management.selling_amount')}} </td>
                    </tr>
                    <tr class="tboder" v-for="(detail,index) in items.details" :key="detail.id">
                        <td class="tboder" style="padding:15px">{{$n(index+1)}}</td>
                        <td class="tboder">{{itemName(detail.item_id)}}</td>
                        <td class="tboder">{{$n(detail.quantity)}}</td>
                        <td class="tboder">{{$n(detail.unit_price)}}</td>
                        <td class="tboder">{{$n(detail.total_price) }}</td>
                        <td class="tboder">{{$n(detail.selling_amount)}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder text-right" style="padding-right:7px;" colspan="4"> {{$t('allocation_management.tax_diduction')}} </td>
                        <td class="tboder">{{$n(totalTax)}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder text-left" colspan="3">&nbsp;{{$t('allocation_management.taka_in_word')}} : {{$i18n.locale === 'bn' ? convertNumberToBanglaWords(allTotal) : convertNumberToEnglishWords(allTotal)}}</td>
                        <td class="tboder"> {{$t('globalTrans.total')}} = </td>
                        <td class="tboder">{{$n(allTotal)}}</td>
                    </tr>
                </table>
                <div>
                    <p style="text-align: right;font-weight: bold;font-size:12px;margin-top:3px;">{{$t('allocation_management.accept_message')}}</p>
                </div>
                <table style="width:100%;margin-top:30px" class="text-center">
                    <tr>
                        <td style="width:25%;border-top:1px solid black;"><span>{{$t('allocation_management.2nd_signature')}}</span></td>
                        <td style="width:1px;"></td>
                        <td style="width:25%;border-top:1px solid black;">{{$t('allocation_management.head_signature')}}</td>
                        <td style="width:1px;"></td>
                        <td style="width:25%;border-top:1px solid black;margin-top:10px;">{{$t('allocation_management.buyer_signature')}}</td>
                    </tr>
                </table>
                <div>
                    <table style="width:100%;margin-top:30px" class="text-center">
                        <tr>
                            <td style="width:33%;text-align: left"><span style="border-bottom:1px solid black;font-weight: bold;">{{$t('allocation_management.terms_of_supply')}}</span></td>
                            <td style="width:33%;"></td>
                            <td style="width:33%"></td>
                        </tr>
                    </table>
                    <p style="font-size:12px;">
                    {{$t('allocation_management.rules_one')}}
                    <br>
                    {{$t('allocation_management.rules_two')}}
                    <br>
                    {{$t('allocation_management.rules_three')}}
                    <br>
                    {{$t('allocation_management.rules_four')}}
                    <br>
                    {{$t('allocation_management.rules_five')}}
                    <br>
                    {{$t('allocation_management.rules_six')}}
                    </p>
                </div>
                <table style="width:100%;margin-top:30px" class="text-center">
                    <tr>
                        <td style="width:33%"></td>
                        <td style="width:33%;"><span style="border-bottom:1px solid black;font-weight: bold;">{{$t('allocation_management.delivery_details')}}</span> </td>
                        <td style="width:33%"></td>
                    </tr>
                </table>
                <table style="width:100%;margin-top:10px;margin-bottom:10px;" border="1" class="text-center">
                    <tr class="tboder">
                        <td style="width:16.66%;" class="tboder">{{$t('allocation_management.warehouse')}} {{$t('globalTrans.name')}}</td>
                        <td  class="tboder" style="width:16.66%;">{{$t('allocation_management.supply_date')}}</td>
                        <td style="width:16.66%;" class="tboder">{{$t('allocation_management.item_name')}}</td>
                        <td style="width:16.66%;" class="tboder">{{$t('globalTrans.quantity')}}</td>
                        <td style="width:16.66%;" class="tboder">{{$t('allocation_management.buy_sig')}}</td>
                        <td style="width:16.66%;" class="tboder">{{$t('allocation_management.warehouse_sig')}}</td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                    <tr class="tboder">
                        <td class="tboder" style="padding:15px"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                        <td class="tboder"></td>
                    </tr>
                </table>
            </b-form>
    </b-overlay>
  </ValidationObserver>
      <b-row class="text-right">
          <b-col>
              <b-button v-if="items.verify_status === 0" type="submit" variant="success" @click="verifyAllocation(items.id)" class="mr-2 btn-sm">{{ $t('globalTrans.verify') }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paidAllocationVerify } from '../../api/routes'
export default {
    props: ['items'],
    components: {
    },
    created () {
      this.paidAllocationDetails = this.items.details
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
            paidAllocationDetails: [],
            formData: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    computed: {
         loading: function () {
            return this.$store.state.commonObj.loading
        },
        currentLocale () {
            return this.$i18n.locale
        },
        totalTax () {
            return this.items.details.reduce((sum = 0, item) => sum + item.tax_amount, 0)
        },
        allTotal () {
            return this.items.details.reduce((sum = 0, item) => sum + item.tax_amount + item.selling_amount, 0)
        }
    },
    methods: {
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
        itemName (itemId) {
            const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
            if (itemObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return itemObj.text_bn
                } else {
                    return itemObj.text_en
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
        sellerTypeList (itemId) {
            const sellerTypeList = this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList.find(item => item.value === itemId)
            if (sellerTypeList !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return sellerTypeList.text_bn
                } else {
                    return sellerTypeList.text_en
                }
            }
        },
        verifyAllocation (id) {
            window.vm.$swal({
                title: window.vm.$t('allocation_management.verify_allocation'),
                showCancelButton: true,
                confirmButtonText: window.vm.$t('globalTrans.yes'),
                cancelButtonText: window.vm.$t('globalTrans.no'),
                focusConfirm: false
            }).then((result) => {
                if (result.isConfirmed) {
                this.verifyStatus(id)
                }
            })
        },
        verifyStatus (id) {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            const loadingState = { loading: false, listReload: false }
            RestApi.deleteData(licenseRegistrationServiceBaseUrl, `${paidAllocationVerify}/${id}`).then(response => {
                if (response.success) {
                    window.vm.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: 'Allocation Verified.',
                    color: '#D6E09B'
                    })
                    this.$bvModal.hide('details')
                    loadingState.listReload = true
                    this.$store.dispatch('mutateCommonProperties', loadingState)
                } else {
                    window.vm.$toast.error({
                        title: 'Error',
                        message: 'Operation failed! Please, try again.'
                    })
                    this.$store.dispatch('mutateCommonProperties', { listReload: true })
                }
            })
        }
    }
}
</script>
<style scoped>
    .tboder{
        border: 1px solid black;
    }
</style>
