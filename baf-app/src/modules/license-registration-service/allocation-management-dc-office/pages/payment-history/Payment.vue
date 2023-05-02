<template>
  <b-container fluid>
    <b-row>
    <b-row class="text-right mb-2">
        <b-col>
          <!--  <b-button variant="primary" @click="pdfExport" class="mr-2">
                <i class="ri-printer-line"></i> {{  $t('globalTrans.export_pdf') }}
            </b-button>-->
        </b-col>
    </b-row>
    <b-col sm="12">
    <b-overlay :show="loading">
        <table style="width:100%" class="text-center">
            <tr>
                <th style="width:20%;text-align: left"><img height="60" width="60" src="@/assets/images/tcb_logo.png"></th>
                <th style="width:50%;">
                    {{$t('allocation_management.tcb')}}
                    <p style="font-size:12px"><!--{{$t('allocation_management.regional_office')}}--> <span style="border-bottom:1px dotted black;">
                      {{ getOfficeName(challanData.regional_office_id) }}
                    </span></p>
                </th>
                <!-- <th style="font-size:12px">
                    {{$t('globalTrans.sl_no')}}-
                    <p style="font-size:12px;margin-top:5px">{{$t('allocation_management.buyer_copy')}}</p>
                </th> -->
            </tr>
            <tr class="text-center" style="margin-top:20px;">
                <td style="width:25%"></td>
                <td  style="width:30%;font-weight:bold;"><span style="border-bottom: 1px solid black;">{{$t('allocation_management.do_sales_header')}}</span> </td>
                <td>{{$t('globalTrans.date')}} : {{ currentDate |dateFormat }}</td>
            </tr>
            <tr>
                <td colspan="3">
                    <table style="width:100%;margin-top:10px" border="1">
                        <tr class="tboder">
                            <td style="width:50%;" class="tboder">{{ $t('allocation_management.name_or_address') }}</td>
                            <td  class="text-left" style="border-right:non
                        ;width:30%;">&nbsp;{{$t('allocation_management.all_letter_no')}} - {{ $n(challanData.delivery_order_no, { useGrouping: false }) }}</td>
                            <td style="width:20%;">{{$t('globalTrans.date')}} : {{ challanData.distribution_date | dateFormat }}</td>
                        </tr>
                        <tr class="tboder">
                            <td class="tboder">
                                <p class="d-block">{{ $t('allocation_dc_office.dc_office_name') }} : {{ getDistrictName(challanData.district_id) }}</p>
                            </td>
                            <td colspan="2" class="tboder text-left">
                                <p> &nbsp;{{$t('globalTrans.fiscal_year')}} : {{ getFiscalYear(challanData.fiscal_year_id) }}</p>
                                <p> &nbsp;{{$t('allocation_dc_office.allonment_count')}} : {{ $n(challanData.allotment_count_id, { useGrouping: false }) }}</p>
                                <p> &nbsp;{{$t('allocation_dc_office.warehouse_name')}} : {{ getWareName(challanData.warehouse_id) }}</p>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width:100%;margin-top:10px" border="1" class="text-center">
            <tr class="tboder">
                <th style="width:5%;" class="tboder">{{$t('globalTrans.sl_no')}}</th>
                <th class="tboder" style="width:20%;">&nbsp;{{$t('allocation_management.item_name')}}</th>
                <th style="width:10%;" class="tboder">{{$t('allocation_management.item_quantity')}}  ({{$t('allocation_dc_office.unit')}})</th>
                <th style="width:10%;" class="tboder">{{$t('allocation_management.unit_rate')}}</th>
                <th style="width:15%;" class="tboder">{{$t('allocation_management.total_price')}} </th>
                <th style="width:10%;" class="tboder">{{$t('allocation_dc_office.commission')}} </th>
                <th style="width:10%;" class="tboder">{{$t('allocation_management.selling_amount')}} </th>
                <th style="width:10%;" class="tboder">{{$t('globalTrans.tax')}} </th>
            </tr>
            <template v-if="detailsArr && detailsArr.length > 0">
                <tr class="tboder" v-for="(detail,index) in detailsArr" :key="detail.id">
                    <td class="tboder" style="padding:15px">{{$n(index+1)}}</td>
                    <td class="tboder">{{ itemCategoryName(detail.item_category_id) }}</td>
                    <td class="tboder">{{ $n(detail.distribution_qty) }}</td>
                    <td class="tboder">{{ $n(detail.rate) }}</td>
                    <td class="tboder">{{ $n(detail.total_pirce) }}</td>
                    <td class="tboder">{{ $n(detail.commission) }}</td>
                    <td class="tboder">{{ $n(detail.selling_amount) }}</td>
                    <td class="tboder">{{ $n(detail.tax) }}</td>
                </tr>
                <tr class="tboder">
                    <td class="tboder text-right" colspan="4">{{$t('globalTrans.total')}} {{$t('globalTrans.taka')}} </td>
                    <td class="tboder">{{ $n(totalPriceSum()) }}</td>
                    <td class="tboder">{{ $n(totalCommissionSum()) }}</td>
                    <td class="tboder">{{ $n(totalSellingAmountSum()) }}</td>
                    <td class="tboder">{{ $n(totalTaxSum()) }}</td>
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
      <div class="card mt-3">
        <div class="card-body">
          <b-row>
            <b-col sm="12">
                <b-overlay :show="loading">
                      <table class="table table-sm table-bordered">
                        <tr>
                          <th style="width: 20%;"> {{ $t('allocation_dc_office.bank_challan') }}</th>
                          <td style="width: 40%;">{{challanData.payment.bank_chalan}}</td>
                          <th style="width: 20%;">{{ $t('allocation_dc_office.payment_date') }}</th>
                          <td style="width: 20%;">{{challanData.payment.payment_date | dateFormat}}</td>
                        </tr>
                        <tr>
                          <th>{{ $t('allocation_dc_office.bank_name') }}</th>
                          <td colspan="3">{{challanData.payment.bank_name}}</td>
                        </tr>
                        <tr>
                          <th>{{ $t('allocation_dc_office.branch_name') }}</th>
                          <td colspan="3">{{challanData.payment.branch_name}}</td>
                        </tr>
                        <tr>
                          <th>{{ $t('globalTrans.attachment') }}</th>
                          <td colspan="3">
                            <a v-if="challanData.payment.attachment" target="_blank" class="btn btn-primary mr-2" :href="licenseRegistrationServiceBaseUrl+'download-attachment?file=storage'+challanData.payment.attachment" title="Attachment">{{$t('globalTrans.download')}}</a>
                          </td>
                        </tr>
                      </table>
                      <b-col class="pt-3">
                        <b-row v-if="is_paid === 0">
                          <b-col class="text-center font-weight-bold">
                            <b-alert show variant="success">{{$i18n.locale == 'bn'? 'টাকা প্রদানের জন্য অপেক্ষা করছি' : 'Waiting for payment'}}</b-alert>
                          </b-col>
                        </b-row>
                        <b-row v-else-if="is_paid === 2">
                          <b-col class="text-center font-weight-bold">
                            <b-alert show variant="success">{{$i18n.locale == 'bn'? 'পেমেন্ট অনুমোদিত হয়েছে' : 'Payment is approved'}}</b-alert>
                          </b-col>
                        </b-row>
                        <b-row v-else>
                          <b-col class="text-center font-weight-bold">
                            <b-alert show variant="warning">{{$i18n.locale == 'bn'? 'পেমেন্ট প্রক্রিয়াধীন আছে' : 'Payment is processing'}}</b-alert>
                          </b-col>
                        </b-row>
                      </b-col>
                </b-overlay>
            </b-col>
          </b-row>
          <b-col class="text-right">
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('challan-view')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </div>
      </div>
    </b-overlay>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { getItemPrice, paymentStore } from '../../api/routes'
import Pdf from './pdf'
export default {
    props: ['item'],
    components: {
    },
    data () {
        return {
          formData: {
            delivery_entry_id: '',
            amount: 0,
            bank_chalan: '',
            payment_date: null,
            bank_name: '',
            branch_name: '',
            attachment: ''
          },
            loading: true,
            is_paid: false,
            challanItems: [],
            allotmentItems: [],
            detailsArr: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
        }
    },
    created () {
        this.challanData = this.item
        this.formData.delivery_entry_id = this.item.id
        this.is_paid = this.item.is_paid
        this.challanItems = JSON.parse(JSON.stringify(this.item.details))
        this.getItemCategoryTotal(this.challanItems)
        this.itemPrice()
        this.currentDate = new Date().toJSON()
    },
    mounted () {
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        },
        allTotal () {
            return this.items.details.reduce((sum = 0, item) => sum + item.tax_amount + item.selling_amount, 0)
        },
        isResionalOffice () {
          return this.$store.state.Auth.authUser.office_detail.office_type_id === 23
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
        async itemPrice () {
            this.loading = true
            const params = {
                fiscal_year_id: this.challanData.fiscal_year_id,
                allotment_count_id: this.challanData.allotment_count_id,
                delivery_order_date: this.challanData.distribution_date
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
            const pay = this.detailsArr.reduce((sum = 0, item) => sum + item.tax + item.selling_amount, 0)
           this.formData.amount = pay
          return pay
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
            res += this.convertNumber(Kt) + ' Crore '
        }
        if (Gn) {
            res += this.convertNumber(Gn) + ' Lac'
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
      ontTransferAttachmentChange (e) {
        var file = e.target.files[0]
        var reader = new FileReader()
        // eslint-disable-next-line no-return-assign
        reader.onloadend = () => this.formData.attachment = reader.result
        reader.readAsDataURL(file)
      },
      saveData () {
        this.$swal({
          title: this.$t('globalTrans.final_save_msg'),
          showCancelButton: true,
          confirmButtonText: this.$t('globalTrans.yes'),
          cancelButtonText: this.$t('globalTrans.no'),
          focusConfirm: false
        }).then((resultSwal) => {
          if (resultSwal.isConfirmed) {
            this.saveUpdate()
          }
        })
      },
      async saveUpdate () {
        const isValid = await this.$refs.mainForm.validate()
        if (isValid) {
          this.loading = true
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          const loadingState = { loading: false, listReload: false }
          let result = null
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentStore, this.formData)
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            this.loading = false
            this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.$bvModal.hide('pay-view')
          } else {
            this.loading = false
            this.$refs.mainForm.setErrors(result.errors)
          }
        }
      },
        pdfExport () {
           Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.items, this.detailsArr, this.challanData, this, this.currentDate)
        }
    }
}
</script>
<style scoped>
    .tboder{
        border: 1px solid black;
    }
</style>
