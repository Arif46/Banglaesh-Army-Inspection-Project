<template>
    <b-row>
      <b-col md="12">
          <ValidationObserver ref="previous_permission_story"  v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                  <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.tea_board_memorial_label')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <b-form-group :label="$t('teaGardenService.memorial_number')" label-for="MemorialNo">
                                                    <b-form-input disabled type="text" v-model="previousPermissionData.application.registration_no" id="MemorialNo"></b-form-input>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group :label="$t('globalTrans.date')" label-for="Date">
                                                    <date-picker
                                                        disabled
                                                        id="approved_date"
                                                        v-model="previousPermissionData.application.issue_date"
                                                        class="form-control"
                                                        :placeholder="$t('globalTrans.select_date')"
                                                    >
                                                    </date-picker>
                                                </b-form-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group
                                        label-cols-lg="3"
                                        label-for="tree_class_of_forest_resources"
                                        :label="$t('teaGardenService.tree_class_of_forest_resources')"
                                        label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col>
                                                <b-form-checkbox-group disabled
                                                    class="custom-control-inline-wrapper" size="lg" v-model="previousPermissionData.tree_class_of_forest_resources" :options="classOfTrees" name="" stacked>
                                               </b-form-checkbox-group>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group
                                        label-cols-lg="3"
                                        :label="$t('teaGardenService.description_of_forest_resource')"
                                        label-size="lg"
                                        label-class="font-weight-bold pt-0"
                                        class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Unit Quantity" vid="unit_quantity" rules="required">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="unit_quantity"
                                                    :label="$t('teaGardenService.unit_quantity')">
                                                    <b-form-radio-group
                                                        disabled
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        class="custom-control-inline-wrapper mb-0" v-model="previousPermissionData.unit_quantity" size="lg" :options="unitQuantity"
                                                        name="radio-options">
                                                    </b-form-radio-group>
                                                    <div class="invalid-feedback d-block">
                                                    {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                               </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Plantation Year" vid="plantation_year" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="plantation_year"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.plantation_year') }}
                                                    </template>
                                                    <b-form-input
                                                        disabled
                                                        type="number"
                                                        :min="0"
                                                        v-model="previousPermissionData.plantation_year"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Number of Trees" vid="number_of_trees" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="number_of_trees"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_trees') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        disabled
                                                        type="number"
                                                        :min="0"
                                                        v-model="previousPermissionData.number_of_trees"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Average Diameter / Size" vid="size" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="size"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.size') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        disabled
                                                        type="number"
                                                        :min="0"
                                                        v-model="previousPermissionData.size"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Quantity (Approx)" vid="quantity_approx" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="quantity_approx"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.quantity_approx') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        disabled
                                                        type="number"
                                                        :min="0"
                                                        v-model="previousPermissionData.quantity_approx"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenService.forest_resource_section_area')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <table class="table table-sm table-bordered section-tree-view-table">
                                                    <thead>
                                                         <tr>
                                                            <th>
                                                                {{ $t('teaGardenService.section_name') }}
                                                            </th>
                                                            <th class="text-left">{{ $t('teaGardenService.mouja') }}</th>
                                                            <th>{{ $t('teaGardenService.khotian') }}</th>
                                                            <th>{{ $t('teaGardenService.dag_no') }}</th>
                                                            <th>{{ $t('teaGardenService.tree_name') }}</th>
                                                            <th>{{ $t('teaGardenService.number_of_trees') }}</th>
                                                            <th>{{ $t('teaGardenService.approved_tree') }}</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <slot v-for="(sectionItem, prevSectionIndex) in previousPermissionData.tree_cutting_locations">
                                                        <tr :key="prevSectionIndex + 'prev'">
                                                            <td>{{ getSectionName(sectionItem.section_id) }}</td>
                                                            <td class="text-left">
                                                                <span v-if="$i18n.locale === 'en'">{{ sectionItem.mouja_en }}</span>
                                                                <span v-else>{{ sectionItem.mouja_bn }}</span>
                                                            </td>
                                                            <td><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                                                            <td><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                                                            <td class="p-0">
                                                                <table class="table table-sm m-0">
                                                                    <tr v-for="(treeItem, prevTreeIndex1) in sectionItem.cutting_trees" :key="prevTreeIndex1 + prevSectionIndex + 'prev' + 1">
                                                                        <td>{{ getTreeName(treeItem.tree_id) }}</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td class="p-0">
                                                                <table class="table table-sm m-0">
                                                                    <tr v-for="(treeItem, prevTreeIndex2) in sectionItem.cutting_trees" :key="prevTreeIndex2 + prevSectionIndex + 'prev'">
                                                                        <td>{{ $n(treeItem.number_of_tree) }}</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td class="p-0">
                                                                <table class="table table-sm m-0">
                                                                    <tr v-for="(treeItem, prevTreeIndex3) in sectionItem.cutting_trees" :key="prevTreeIndex3 + prevSectionIndex + 'prevA'">
                                                                        <td>{{ $n(treeItem.approved_tree) }}</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr :key="prevSectionIndex + 'prev' + 1">
                                                            <td colspan="5" class="text-right">
                                                                <b>{{ $t('teaGardenService.sub_total') }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { number_of_tree } ) => sum + Number(number_of_tree) , 0)) }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { approved_tree } ) => sum + Number(approved_tree) , 0)) }}</b>
                                                            </td>
                                                        </tr>
                                                        </slot>
                                                        <tr>
                                                            <td colspan="5" class="text-right">
                                                                <b>{{ $t('teaGardenService.grand_total') }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(totalNumberOfTrees) }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(totalNumberOfApprovedTrees) }}</b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6" class="text-right pe-5">
                                                                <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfTrees)) }}</b>
                                                            </td>
                                                            <td class="text-right pe-5">
                                                                <b>{{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfApprovedTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfApprovedTrees)) }}</b>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group
                                        label-cols-sm="12"
                                        label-for="purpose_of_tree_felling"
                                        label-cols-lg="3"
                                        :label="$t('teaGardenService.purpose_of_tree_felling')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                    <b-row>
                                        <b-col>
                                            <b-form-checkbox-group disabled
                                                class="custom-control-inline-wrapper" size="lg" v-model="previousPermissionData.cutting_purpose.purpose_of_tree_felling" :options="purposeTreeFelling" name="" stacked>
                                            </b-form-checkbox-group>
                                        </b-col>
                                    </b-row>
                                </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                    </b-row>
                  </b-overlay>
              </b-form>
          </ValidationObserver>
      </b-col>
  </b-row>
  </template>
  <script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { treeDisposalPreviousPermissionDetailsApi } from '../../api/routes'
  import { mapGetters } from 'vuex'
  export default {
      props: ['app_id', 'garden_id_set', 'isShow', 'baseUrl'],
      name: 'PreviousPermissionStory',
      data () {
        return {
              ItemShow: false,
              teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
              fieldObj: {
                  xl: 6,
                  lg: 6,
                  md: 6,
                  sm: 12,
                  labelCols: 5,
                  noAddress: false
              },
              previousPermissionData: {
                tree_class_of_forest_resources: [],
                unit_quantity: null,
                plantation_year: null,
                number_of_trees: null,
                size: null,
                quantity_approx: null,
                tree_cutting_locations: [],
                development_planing: {
                    id: 0,
                    tree_cutting_id: 0,
                    fiscal_year_id: 0,
                    expansion_planting: null,
                    re_plantation: null,
                    rubber: null,
                    afforestation: null,
                    other_plants: null
                },
                cutting_purpose: {
                    id: 0,
                    tree_cutting_id: 1,
                    purpose_of_tree_felling: [],
                    total_cutable_trees: null,
                    number_of_re_plantable_tree: null,
                    number_of_very_old_trees: null,
                    number_of_rubber_tree: null,
                    number_of_disease_tree: null,
                    number_of_other_trees: null
                },
                application: {
                    registration_no: '',
                    issue_date: ''
                }
              },
              valid: null,
              loading: false
        }
      },
      created () {
          this.getPreviousPermissionData(this.garden_id_set)
      },
      computed: {
          ...mapGetters({
              authUser: 'Auth/authUser'
          }),
          currentLocale () {
              return this.$i18n.locale
          },
          classOfTrees () {
            return this.$store.state.TeaGardenService.commonObj.forestResource
          },
          purposeTreeFelling () {
            return this.$store.state.TeaGardenService.commonObj.purposeTreeFelling
          },
          unitQuantity () {
            return this.$store.state.TeaGardenService.commonObj.unitQuantity
          },
          getTreeList () {
            return this.$store.state.TeaGardenService.commonObj.masterTreeList
          },
          gardenId () {
            return this.garden_id_set
          },
          gardenSectionDetail: function () {
            return this.$store.state.TeaGardenService.commonObj.masterSectionList.filter(item => (item.garden_id === this.gardenId))
          },
          totalNumberOfTrees () {
            var total = 0
            this.previousPermissionData.tree_cutting_locations.forEach(section => {
                section.cutting_trees.forEach(treeSection => {
                    total += Number(treeSection.number_of_tree)
                })
            })
            return total
          },
          totalNumberOfApprovedTrees () {
            var total = 0
            this.previousPermissionData.tree_cutting_locations.forEach(section => {
                section.cutting_trees.forEach(treeSection => {
                    total += Number(treeSection.approved_tree)
                })
            })
            return total
          }
      },
      methods: {
        async getPreviousPermissionData (gardenId) {
            const paramsData = {
                garden_id: gardenId,
                id: this.app_id
            }
            const result = await RestApi.getData(teaGardenServiceBaseUrl, treeDisposalPreviousPermissionDetailsApi, paramsData)
            if (result.success) {
                const data = result.data
                if (data) {
                    this.previousPermissionData = data
                }
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
        async submit () {},
        getTreeName (id) {
            const treeName = this.$store.state.TeaGardenService.commonObj.masterTreeList.find(item => item.value === id)
            if (treeName && this.$i18n.locale === 'bn') {
                return treeName.text_bn
            } else if (treeName && this.$i18n.locale === 'en') {
                return treeName.text_en
            }
        },
        getSectionName (id) {
            const sectionName = this.gardenSectionDetail.find(item => item.value === id)
            if (sectionName && this.$i18n.locale === 'bn') {
                return sectionName.text_bn
            } else if (sectionName && this.$i18n.locale === 'en') {
                return sectionName.text_en
            }
        }
      }
  }
  </script>
