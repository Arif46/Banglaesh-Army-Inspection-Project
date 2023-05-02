<template>
    <div size="A4" class="page">
        <div v-if="loading">
            <Loading />
        </div>
        <!-- <b-overlay :show="loading"> -->
        <template v-else>
            <div class="text-right">
            <b-button @click="pdfExport" variant="primary" class="mb-3" size="sm">
            <i class="ri-printer-fill"></i>
            {{ $t('teaGardenConfig.Print') }}
        </b-button>
        </div>
        <div style="border: 1px double #222; padding: 1rem; height: 100%">
            <TeaGardenReportHead :baseUrl="teaGardenServiceBaseUrl" :uri="'/configuration/report-heading/detail'" :orgId="5" :loadingState="false">
                {{ $t('teaGardenService.tree_disposal_certificate_title') + ' ' + $t('globalTrans.certificate') }}
            </TeaGardenReportHead>
            <table class="report-info">
            <tbody>
                <tr>
                    <td>{{ $t('teaGardenService.application_id') }}</td>
                    <td>&emsp;:&nbsp;</td>
                    <td>{{ application.application.app_id }}</td>
                </tr>
                <tr>
                    <td>{{ $t('teaGardenConfig.garden_name') }}</td>
                    <td>&emsp;:&nbsp;</td>
                    <td>
                        <span v-if="application.garden_info && $i18n.locale ==='en'">{{ application.garden_info.tea_garden_name_en }}</span>
                        <span v-if="application.garden_info && $i18n.locale ==='bn'">{{ application.garden_info.tea_garden_name_bn }}</span>
                    </td>
                </tr>
                <tr>
                    <td>{{ $t('teaGardenService.tea_garden_address') }}</td>
                    <td>&emsp;:&nbsp;</td>
                    <td>
                        {{ getGardenAddress() }}
                    </td>
                </tr>
                <tr>
                    <td>{{ $t('teaGardenConfig.registration_no') }}</td>
                    <td>&emsp;:&nbsp;</td>
                    <td>
                        <span v-if="(application.garden_info && application.garden_info.registration_no_en)">{{ application.garden_info.registration_no_en }}</span>
                    </td>
                </tr>
                <tr>
                    <td>{{ $t('teaGardenService.total_approved_trees') }}</td>
                    <td>&emsp;:&nbsp;</td>
                    <td>{{ $n(totalNumberOfApprovedTrees) }}</td>
                </tr>
            </tbody>
        </table>
        <table class="report-table">
            <thead>
                <tr>
                    <th class="text-center">
                        {{ $t('teaGardenService.section_name') }}
                    </th>
                    <th class="text-center">{{ $t('teaGardenService.mouja') }}</th>
                    <th class="text-center">{{ $t('teaGardenService.khotian') }}</th>
                    <th class="text-center">{{ $t('teaGardenService.dag_no') }}</th>
                    <th style="width:32%;text-align:center">{{ $t('teaGardenService.tree_name') }}</th>
                    <th class="text-center">{{ $t('teaGardenService.approved_tree') }}</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(sectionItem, index) in application.tree_cutting_locations" :key="index">
                    <td class="text-center">{{ getSectionName(sectionItem.section_id) }}</td>
                    <td class="text-center">
                        <span v-if="$i18n.locale === 'en'">{{ sectionItem.mouja_en }}</span>
                        <span v-else>{{ sectionItem.mouja_bn }}</span>
                    </td>
                    <td class="text-center"><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                    <td class="text-center"><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                    <td style="padding: 0;" class="text-center">
                        <table style="width: 100%">
                            <tbody>
                                <tr v-for="(treeItem, treeIndex) in sectionItem.cutting_trees" :key="treeIndex + index + 'tree' + 1">
                                    <td style="border: none;" class="text-center">{{ getTreeName(treeItem.tree_id) }}</td>
                                </tr>
                                <tr><th style="border: none;" class="text-center">{{ $t('teaGardenService.sub_total') }}</th></tr>
                            </tbody>
                        </table>
                    </td>
                    <td style="padding:0;">
                        <table style="width: 100%">
                            <tbody>
                                <tr v-for="(treeItem, treeIndex) in sectionItem.cutting_trees" :key="treeIndex + index + 'treeNumber' + 1">
                                    <td style="border: none;" class="text-center">{{ $n(treeItem.approved_tree) }}</td>
                                </tr>
                                <tr><th style="border: none;" class="text-center">{{ $n(sectionItem.cutting_trees.reduce( ( sum, { approved_tree } ) => sum + Number(approved_tree) , 0)) }}</th></tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="5" class="text-right">{{ $t('teaGardenService.grand_total') }}</th>
                    <th class="text-center">{{ $n(totalNumberOfApprovedTrees) }}</th>
                </tr>
            </tfoot>
        </table>
            <strong style="margin-top:2rem; display: block;">{{ $t('teaGardenPanel.conditions') }}</strong>
            <div class="text-justify" v-html="currentLocale === 'en' ? application.application.service_instruction.instruction_en : application.application.service_instruction.instruction_bn">
            </div>
            <table style="width:100%; margin-top: 5rem;">
                <tbody>
                    <tr>
                        <td style="width:33.33%">
                        </td>
                        <td style="width:30.33%"></td>
                        <td>
                            <div>
                                <img v-if="application.application.document_signatory && signatory_user_info.signature && application.application.document_signatory.show_signature" :src="authServiceBaseUrl + 'storage/' + signatory_user_info.signature" width="100px" alt="">
                                <img v-else-if="approve_user_info.signature" :src="authServiceBaseUrl + 'storage/' + approve_user_info.signature" width="100px" alt="">
                                <p v-if="application.application.document_signatory || application.application.approver_name_en">{{ $t('globalTrans.name') }}:
                                    <span v-if="application.application.document_signatory && application.application.document_signatory.name_en && application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.text_en : signatory_user_info.text_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.text_en : approve_user_info.text_bn }}</span>
                                </p>
                                <p v-if="application.application.document_signatory || application.application.approver_designation_en">{{ $t('globalTrans.designation') }}:
                                    <span v-if="application.application.document_signatory && application.application.document_signatory.designation_en && application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.designation_en : signatory_user_info.designation_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.designation_en : approve_user_info.designation_bn }}</span>
                                </p>
                                <p v-if="application.application.document_signatory && application.application.document_signatory.email">{{ $t('globalTrans.email') }}:
                                    <span v-if="application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ signatory_user_info.email }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ approve_user_info.email }}</span>
                                </p>
                                <p v-if="application.application.document_signatory && application.application.document_signatory.mobile">{{ $t('globalTrans.mobile') }}:
                                    <span v-if="application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(signatory_user_info.mobile) }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(approve_user_info.mobile) }}</span>
                                </p>
                                <p>{{ $t('globalTrans.date') }} <span
                                        style="text-decoration-style: dotted; text-decoration-line: underline;">{{ application.application.approved_date | dateFormat }}</span>
                                </p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="text-left mt-3">
            <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
        </div>
        </template>
        <!-- </b-overlay> -->
    </div>
</template>
<script>
import TeaGardenReportHead from '@/components/custom/TeaGardenReportHead'
import RestApi, { teaGardenServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { treeDisposalAppDetailsApi, gardenSectionDetailsApi, TreeDisposalViewPdf, AuthUserInfo } from '../../api/routes'
import Loading from './../loading/Details.vue'
export default {
  name: 'Details',
  components: {
    Loading,
    TeaGardenReportHead
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      authServiceBaseUrl: authServiceBaseUrl,
      application: {
        reviews: [],
        application: {
          forwards: [],
          recommendations: []
        }
      },
      gardenSectionDetail: [],
      approve_user_info: {},
      signatory_user_info: {}
    }
  },
  created () {
     this.getAppDetail()
  },
  computed: {
    appId () {
      return this.$route.params.id
    },
    currentLocale () {
        return this.$i18n.locale
    },
    totalNumberOfTrees () {
      var total = 0
      this.application.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.number_of_tree)
          })
      })
      return total
    },
    totalNumberOfApprovedTrees () {
      var total = 0
      this.application.tree_cutting_locations.forEach(section => {
          section.cutting_trees.forEach(treeSection => {
              total += Number(treeSection.approved_tree)
          })
      })
      return total
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async getGardenSections (gardenId) {
        const result = await RestApi.getData(teaGardenServiceBaseUrl, gardenSectionDetailsApi, { garden_id: gardenId })
        if (result.success) {
            this.gardenSectionDetail = result.data
            this.loading = false
        } else {
            this.gardenSectionDetail = []
        }
    },
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalAppDetailsApi, { app_id: this.$route.params.id })
        if (result.success) {
          this.getGardenSections(result.data.garden_id)
          this.application = result.data
           // document signatory load
           if (this.application.application.document_signatory && this.application.application.document_signatory.user_id) {
                this.getSignatoryUserInfo(this.application.application.document_signatory.user_id)
            }
            if (this.application.application.approver_id) {
                this.getApproveUserInfo(this.application.application.approver_id)
            }
          this.$store.dispatch('mutateCommonProperties', { loading: false })
        } else {
            this.$store.dispatch('mutateCommonProperties', { loading: false })
        }
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    // convert to word start
    empty (str) {
        return (!str || str.length === 0)
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
    // convert to word end
    getOrgName (id) {
        const org = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === id)
        if (org && this.$i18n.locale === 'bn') {
            return org.text_bn
        } else if (org && this.$i18n.locale === 'en') {
            return org.text_en
        }
    },
    async pdfExport () {
        const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 5, app_id: this.appId, show_certificate: 1 })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, TreeDisposalViewPdf, params)
        var blob = new Blob([result], {
            type: 'application/pdf'
        })
        var url = window.URL.createObjectURL(blob)
        window.open(url).print()
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDivisionName  (id) {
    const division = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
        if (division && this.$i18n.locale === 'bn') {
            return division.text_bn
        } else if (division && this.$i18n.locale === 'en') {
            return division.text_en
        }
    },
    getDistrictName (id) {
    const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
        if (district && this.$i18n.locale === 'bn') {
            return district.text_bn
        } else if (district && this.$i18n.locale === 'en') {
            return district.text_en
        }
    },
    getCityCorporationName (id) {
    const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
        if (cityCorporation && this.$i18n.locale === 'bn') {
            return cityCorporation.text_bn
        } else if (cityCorporation && this.$i18n.locale === 'en') {
            return cityCorporation.text_en
        }
    },
    getUpzillaName (id) {
    const upzilla = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
        if (upzilla && this.$i18n.locale === 'bn') {
            return upzilla.text_bn
        } else if (upzilla && this.$i18n.locale === 'en') {
            return upzilla.text_en
        }
    },
    getPauroshobaName (id) {
    const municipality = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
        if (municipality && this.$i18n.locale === 'bn') {
            return municipality.text_bn
        } else if (municipality && this.$i18n.locale === 'en') {
            return municipality.text_en
        }
    },
    getUnionName (id) {
    const union = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
        if (union && this.$i18n.locale === 'bn') {
            return union.text_bn
        } else if (union && this.$i18n.locale === 'en') {
            return union.text_en
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
    getFiscalYearName (id) {
      const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getUserName (userId) {
      const user = this.users.find(user => parseInt(user.value) === parseInt(userId))
      return typeof user !== 'undefined' ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
    },
    getUnitName (id) {
      const unit = this.$store.state.TeaGardenService.commonObj.unitQuantity.find(item => item.value === id)
        if (unit && this.$i18n.locale === 'bn') {
            return unit.text_bn
        } else if (unit && this.$i18n.locale === 'en') {
            return unit.text_en
        }
    },
    getTreeFellingPurposeName (id) {
      const purpose = this.$store.state.TeaGardenService.commonObj.purposeTreeFelling.find(item => item.value === id)
        if (purpose && this.$i18n.locale === 'bn') {
            return purpose.text_bn
        } else if (purpose && this.$i18n.locale === 'en') {
            return purpose.text_en
        }
    },
    getForestResourceName (id) {
      const purpose = this.$store.state.TeaGardenService.commonObj.forestResource.find(item => item.value === id)
        if (purpose && this.$i18n.locale === 'bn') {
            return purpose.text_bn
        } else if (purpose && this.$i18n.locale === 'en') {
            return purpose.text_en
        }
    },
    getTreeName (id) {
        const treeName = this.$store.state.TeaGardenService.commonObj.masterTreeList.find(item => item.value === id)
        if (treeName && this.$i18n.locale === 'bn') {
            return treeName.text_bn
        } else if (treeName && this.$i18n.locale === 'en') {
            return treeName.text_en
        }
    },
    getSectionName (id) {
        const treeName = this.gardenSectionDetail.find(item => item.value === id)
        if (treeName && this.$i18n.locale === 'bn') {
            return treeName.text_bn
        } else if (treeName && this.$i18n.locale === 'en') {
            return treeName.text_en
        }
    },
    getGardenAddress () {
       var address = ''
       address = address + this.getDistrictName(this.application.garden_info.district_id) + ','
       address = address + this.getDivisionName(this.application.garden_info.division_id) + ','
       if (this.application.garden_info.upazila_id) {
        address = address + this.getUpzillaName(this.application.garden_info.upazila_id) + ','
       }
       if (this.application.garden_info.city_corporation_id) {
        address = address + this.getCityCorporationName(this.application.garden_info.city_corporation_id) + ','
       }
       if (this.application.garden_info.pauroshoba_id) {
        address = address + this.getPauroshobaName(this.application.garden_info.pauroshoba_id) + ','
       }
       if (this.$i18n.locale === 'en') {
        address = address + this.application.garden_info.garden_address_en
       } else {
        address = address + this.application.garden_info.garden_address_bn
       }
       return address
    },
    getTreeClassResource (data) {
      var treeClassResoruce = []
      if (Array.isArray(data)) {
          data.forEach(arrItem => {
          const item = this.$store.state.TeaGardenService.commonObj.forestResource.find(item => item.value === arrItem)
          if (item && this.$i18n.locale === 'bn') {
            treeClassResoruce.push(item.text_bn)
          } else if (item && this.$i18n.locale === 'en') {
            treeClassResoruce.push(item.text_en)
          }
          })
      }
      return treeClassResoruce.toString()
    },
    async getSignatoryUserInfo (id) {
        const result = await RestApi.getData(authServiceBaseUrl, AuthUserInfo + id)
        if (result.success) {
          this.signatory_user_info = result.data
          if (this.signatory_user_info) {
             this.getDesignationNameSignatory(this.signatory_user_info.designation_id)
             this.getOfficeNameSignatory(this.signatory_user_info.office_id)
          }
        }
    },
    async getApproveUserInfo (id) {
        const result = await RestApi.getData(authServiceBaseUrl, AuthUserInfo + id)
        if (result.success) {
          this.approve_user_info = result.data
          if (this.approve_user_info) {
             this.getDesignationNameApprove(this.approve_user_info.designation_id)
             this.getOfficeNameApprove(this.approve_user_info.office_id)
          }
        }
    },
    getDesignationNameSignatory (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      if (obj) {
        this.signatory_user_info.designation_en = obj.text_en
        this.signatory_user_info.designation_bn = obj.text_bn
      }
      return true
    },
    getOfficeNameSignatory (id) {
      const obj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(id))
      if (obj) {
        this.signatory_user_info.office_en = obj.text_en
        this.signatory_user_info.office_bn = obj.text_bn
      }
      return true
    },
    getDesignationNameApprove (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      if (obj) {
        this.approve_user_info.designation_en = obj.text_en
        this.approve_user_info.designation_bn = obj.text_bn
      }
      return true
    },
    getOfficeNameApprove (id) {
      const obj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(id))
      if (obj) {
        this.approve_user_info.office_en = obj.text_en
        this.approve_user_info.office_bn = obj.text_bn
      }
      return true
    }
  }
}
</script>
<style scoped>
.page {
    background: white;
    padding: .5in;
    margin: 0 auto;
    margin-bottom: 0.5cm;
}

.page[size="A4"] {
    width: 21cm;
    min-height: 29.7cm;
    height: auto;
}

.report-table {
    margin-top: 1rem;
    width: 100%;
}

.report-table td,
.report-table th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 4px;
}

@media print {

    body,
    .page {
        margin: 0;
        box-shadow: 0;
    }
}
</style>
