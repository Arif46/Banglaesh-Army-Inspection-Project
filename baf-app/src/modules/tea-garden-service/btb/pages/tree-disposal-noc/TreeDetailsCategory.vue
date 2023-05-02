<template>
    <b-row>
      <b-col md="12">
          <ValidationObserver ref="tree_details_category"  v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                 <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                <ValidationProvider name="Tree Class of Forest Resources" vid="tree_class_of_forest_resources" rules="required">
                                    <b-form-group
                                        slot-scope="{ valid, errors }"
                                        label-cols-sm="12"
                                        label-for="tree_class_of_forest_resources"
                                        label-cols-lg="3"
                                        :label="$t('teaGardenService.tree_class_of_forest_resources')" label-size="lg"
                                        label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col>
                                                <b-form-checkbox-group
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    class="custom-control-inline-wrapper" size="lg" v-model="application.tree_class_of_forest_resources" :options="classOfTrees" name="" stacked>
                                               </b-form-checkbox-group>
                                                <div class="invalid-feedback d-block">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </ValidationProvider>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group
                                        label-cols-lg="3"
                                        :label="$t('teaGardenService.description_of_forest_resource')" label-size="lg"
                                        label-class="font-weight-bold pt-0"
                                        class="mb-0">
                                        <b-row>
                                            <b-col sm="12">
                                                <ValidationProvider name="Unit Quantity" vid="unit_quantity" rules="required">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-cols-sm="12"
                                                    label-for="unit_quantity"
                                                    :label="$t('teaGardenService.unit_quantity')">
                                                    <b-form-radio-group
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        class="custom-control-inline-wrapper mb-0" v-model="application.unit_quantity" size="lg" :options="unitQuantity"
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
                                                        label-cols-sm="12"
                                                        label-for="plantation_year"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.plantation_year') }}
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.plantation_year"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Number of Trees" vid="number_of_trees" rules="required|min_value:0">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-cols-sm="12"
                                                        label-for="number_of_trees"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.number_of_trees') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        pattern="[0-9]+"
                                                        v-model="application.number_of_trees"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
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
                                                        label-cols-sm="12"
                                                        label-for="size"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.size') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.size"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
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
                                                        label-cols-sm="12"
                                                        label-for="quantity_approx"
                                                    >
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.quantity_approx') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                        type="number"
                                                        :min="0"
                                                        v-model="application.quantity_approx"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        @keypress="isNumber"
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
                                            <b-col sm="6">
                                                <b-form-group label-for="SectionNo">
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.section_name') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-select
                                                        plain
                                                        v-model="service_section.section_id"
                                                        :options="gardenSectionDetail"
                                                        id="SectionNo"
                                                    >
                                                    <template v-slot:first>
                                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                                    </template>
                                                   </b-form-select>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group label-for="MoujaNameEn">
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.mouja') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input id="MoujaNameEn" v-model="service_section.mouja_en"></b-form-input>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group label-for="MoujaNameBn">
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.mouja') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input id="MoujaNameBn" v-model="service_section.mouja_bn"></b-form-input>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group label-for="KhotianNo">
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.khotian') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input type="text" v-model="service_section.khotian_no" id="KhotianNo"></b-form-input>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="6">
                                                <b-form-group label-for="DagNo">
                                                    <template v-slot:label>
                                                        {{ $t('teaGardenService.dag_no') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input type="text" v-model="service_section.dag_no" id="DagNo"></b-form-input>
                                                    <small style="text-align: right;display: block;">{{ $t('teaGardenService.mile_format') }}</small>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="12">
                                                <b-form-group :label="$t('teaGardenService.plant_species')" label-for="PlantSpecies">
                                                    <table class="table table-sm">
                                                        <b-overlay :show="custom_tree_loading">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="width:40%">
                                                                        <b-form-group label-for="TreeName">
                                                                            <template v-slot:label>
                                                                                {{ $t('teaGardenService.tree_name') }} <span class="text-danger">*</span>
                                                                            </template>
                                                                            <b-form-select
                                                                                plain
                                                                                v-model="tree_section.tree_id"
                                                                                :options="getTreeList"
                                                                                id="tree_id"
                                                                                >
                                                                                <template v-slot:first>
                                                                                <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                                                                <b-form-select-option value='others'>{{$t('teaGardenService.others')}}</b-form-select-option>
                                                                                </template>
                                                                            </b-form-select>
                                                                        </b-form-group>
                                                                    </td>
                                                                    <td>
                                                                        <b-form-group label-for="NumberOfTree">
                                                                            <template v-slot:label>
                                                                                {{ $t('teaGardenService.number_of_trees') }} <span class="text-danger">*</span>
                                                                            </template>
                                                                            <b-form-input type="number" v-model="tree_section.number_of_tree" id="NumberOfTree"></b-form-input>
                                                                        </b-form-group>
                                                                    </td>
                                                                    <td style="width:30%">
                                                                        <button type="button" @click="addMoreTree" class="btn add-more-btn btn-secondary btn-sm" style="margin-top: 20px"><i class="ri-add-line"></i> {{ $t('teaGardenService.add_more_tree') }}</button>
                                                                    </td>
                                                                </tr>
                                                                <!-- custom tree entry -->
                                                                <tr v-if="tree_section.tree_id === 'others'">
                                                                    <td style="width:30%">
                                                                        <b-form-group label-for="tree_name_en">
                                                                            <template v-slot:label>
                                                                                {{ $t('teaGardenService.tree_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                                            </template>
                                                                            <b-form-input type="text" v-model="tree_entry.tree_name_en" id="tree_name_en"></b-form-input>
                                                                        </b-form-group>
                                                                    </td>
                                                                    <td style="width:30%">
                                                                        <b-form-group label-for="tree_name_bn">
                                                                            <template v-slot:label>
                                                                                {{ $t('teaGardenService.tree_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                                            </template>
                                                                            <b-form-input type="text" v-model="tree_entry.tree_name_bn" id="tree_name_bn"></b-form-input>
                                                                        </b-form-group>
                                                                    </td>
                                                                    <td style="width:20%">
                                                                        <button type="button" @click="customTreeSubmit" class="btn add-more-btn btn-secondary btn-sm" style="margin-top: 20px"><i class="ri-add-line"></i> {{ $t('globalTrans.submit') }}</button>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </b-overlay>
                                                    </table>
                                                    <table class="table table-sm table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-center">{{ $t('teaGardenService.tree_name') }}</th>
                                                                <th class="text-center">{{ $t('teaGardenService.number_of_trees') }}</th>
                                                                <th class="text-center">{{ $t('globalTrans.action') }}</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr v-for="(treeItem, treeIndex) in addMoreTrees" :key="treeIndex +'treeList'">
                                                                <td class="text-center">{{ getTreeName(treeItem.tree_id)  }}</td>
                                                                <td class="text-center">{{ $n(treeItem.number_of_tree) }}</td>
                                                                <td class="text-center">
                                                                    <a @click="treeRemove(treeIndex)" href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </b-form-group>
                                            </b-col>
                                            <b-col sm="4" class="offset-8">
                                                <b-button @click="addMorePlantSection" class="add-more-btn" size="sm"><i class="ri-add-line"></i> {{ $t('teaGardenService.add_more_plan_service') }}</b-button>
                                            </b-col>
                                            <b-col sm="12">
                                                <table class="table table-sm table-bordered section-tree-view-table">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                {{ $t('teaGardenService.section_name') }}
                                                            </th>
                                                            <th class="text-left">{{ $t('teaGardenService.mouja') }} {{ $t('globalTrans.en') }}</th>
                                                            <th class="text-left">{{ $t('teaGardenService.mouja') }} {{ $t('globalTrans.bn') }}</th>
                                                            <th>{{ $t('teaGardenService.khotian') }}</th>
                                                            <th>{{ $t('teaGardenService.dag_no') }}</th>
                                                            <th>{{ $t('teaGardenService.tree_name') }}</th>
                                                            <th>{{ $t('teaGardenService.number_of_trees') }}</th>
                                                            <th>{{ $t('globalTrans.action') }}</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <slot v-for="(sectionItem, sectionIndex) in application.tree_cutting_locations">
                                                        <tr :key="sectionIndex + 'section'">
                                                            <td>{{ getSectionName(sectionItem.section_id) }}</td>
                                                            <td class="text-left">{{ sectionItem.mouja_en }}</td>
                                                            <td class="text-left">{{ sectionItem.mouja_bn }}</td>
                                                            <td><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                                                            <td><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                                                            <td class="p-0">
                                                                <table class="table table-sm m-0">
                                                                    <tr v-for="(treeItem, treeIndex1) in sectionItem.cutting_trees" :key="treeIndex1 + sectionIndex + 'section' + 1">
                                                                        <td>{{ getTreeName(treeItem.tree_id) }}</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td class="p-0">
                                                                <table class="table table-sm m-0">
                                                                    <tr v-for="(treeItem, treeIndex2) in sectionItem.cutting_trees" :key="treeIndex2 + sectionIndex + 'section'">
                                                                        <td>{{ $n(treeItem.number_of_tree) }}</td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td @click="plantSectionRemove(sectionIndex)" class="text-center" style="border-bottom-color: transparent">
                                                                <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                            </td>
                                                        </tr>
                                                        <tr :key="sectionIndex + 'section' + 1">
                                                            <td colspan="6" class="text-right">
                                                                <b>{{ $t('teaGardenService.sub_total') }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { number_of_tree } ) => sum + Number(number_of_tree) , 0)) }}</b>
                                                            </td>
                                                        </tr>
                                                        </slot>
                                                        <tr>
                                                            <td colspan="6" class="text-right">
                                                                <b>{{ $t('teaGardenService.grand_total') }}</b>
                                                            </td>
                                                            <td>
                                                                <b>{{ $n(totalNumberOfTrees) }}</b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="8" class="text-right pe-5">
                                                                <b>({{ $i18n.locale === 'bn' ? convertNumberToBanglaWords(Number(totalNumberOfTrees)) :  convertNumberToEnglishWords(Number(totalNumberOfTrees)) }})</b>
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
                    </b-row>
                </b-overlay>
              </b-form>
          </ValidationObserver>
      </b-col>
  </b-row>
  </template>
  <script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { treeDisposalAppStoreApi, customTreeEntryApi } from '../../api/routes'
  import { mapGetters } from 'vuex'
  import { helpers } from '@/utils/helper-functions'
  export default {
      props: ['app_id', 'garden_id_set', 'applicationData', 'isShow', 'baseUrl'],
      name: 'TeeDetailsCategory',
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
              application: {
                app_id: 0,
                garden_id: 1,
                tree_class_of_forest_resources: [],
                unit_quantity: null,
                plantation_year: '',
                number_of_trees: null,
                size: null,
                quantity_approx: null,
                tree_cutting_locations: []
              },
              valid: null,
              loading: false,
              service_section: {
                 section_id: 0,
                 dag_no: null,
                 khotian_no: null,
                 mouja_en: null,
                 mouja_bn: null,
                 cutting_trees: []
              },
              tree_section: {
               tree_id: 0,
               number_of_tree: null
              },
              tree_entry: {
                tree_name_en: '',
                tree_name_bn: ''
              },
              addMoreTrees: [],
              addMoreServices: [],
              section_loaded: true,
              errors: [],
              custom_tree_loading: false
            }
      },
      created () {
        this.application = this.applicationData
      },
      computed: {
          ...mapGetters({
              authUser: 'Auth/authUser'
          }),
          currentLocale () {
              return this.$i18n.locale
          },
          gardenSectionDetail: function () {
            return this.$store.state.TeaGardenService.commonObj.masterSectionList.filter(item => (item.garden_id === this.garden_id_set))
          },
          classOfTrees () {
            return this.$store.state.TeaGardenService.commonObj.forestResource
          },
          unitQuantity () {
            return this.$store.state.TeaGardenService.commonObj.unitQuantity
          },
          getTreeList () {
            return this.$store.state.TeaGardenService.commonObj.masterTreeList.filter(item => (item.status === 1))
         },
          totalNumberOfTrees () {
            var total = 0
            this.application.tree_cutting_locations.forEach(section => {
                section.cutting_trees.forEach(treeSection => {
                    total += Number(treeSection.number_of_tree)
                })
            })
            return total
          }
      },
      methods: {
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
        async submit () {
            var check = await this.$refs.tree_details_category.validate()
            if (this.application.tree_cutting_locations.length === 0) {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                })
                return false
            }
            if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                this.application.garden_id = this.garden_id_set
                const result = await RestApi.postData(teaGardenServiceBaseUrl, treeDisposalAppStoreApi, this.application)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.loading = false
                if (result.success) {
                    this.$toast.success({
                        title: 'Success',
                        message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                        color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$refs.tree_details_category.setErrors(result.errors)
                    this.$toast.error({
                        title: this.$t('globalTrans.error'),
                        message: this.$t('globalTrans.form_error_msg'),
                        color: '#ee5253'
                    })
                }
            }
        },
        addMoreTree () {
            if (this.tree_section.tree_id === 0 || this.tree_section.tree_id === 'others' || this.tree_section.number_of_tree === null) {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
               })
               return false
            }
           this.addMoreTrees.push(this.tree_section)
           this.tree_section = {
               tree_id: 0,
               number_of_tree: null
           }
        },
        treeRemove (index) {
           this.addMoreTrees.splice(index, 1)
        },
        addMorePlantSection () {
            if (this.service_section.section_id === 0 || this.service_section.mouja_bn === null || this.service_section.mouja_en === null || this.service_section.khotian_no === null || this.service_section.dag_no === null) {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
               })
               return false
            }
            this.service_section.cutting_trees = this.addMoreTrees
            this.service_section.id = 0
            this.application.tree_cutting_locations.push(this.service_section)
            this.tree_section = {
            tree_id: 0,
            number_of_tree: null
           }
           this.service_section = {
            section_id: 0,
            dag_no: null,
            khotian_no: null,
            mouja_en: null,
            mouja_bn: null,
            cutting_trees: []
           }
           this.addMoreTrees = []
        },
        plantSectionRemove (index) {
           this.application.tree_cutting_locations.splice(index, 1)
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
            const sectionName = this.gardenSectionDetail.find(item => item.value === id)
            if (sectionName && this.$i18n.locale === 'bn') {
                return sectionName.text_bn
            } else if (sectionName && this.$i18n.locale === 'en') {
                return sectionName.text_en
            }
        },
        async customTreeSubmit () {
            if (this.tree_entry.tree_name_bn === '' || this.tree_entry.tree_name_en === '') {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                })
                return false
            }
            this.custom_tree_loading = true
            const result = await RestApi.postData(teaGardenServiceBaseUrl, customTreeEntryApi, this.tree_entry)
            this.custom_tree_loading = false
            if (result.success) {
                this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
                this.tree_section.tree_id = result.model.id
                this.tree_entry = {
                    tree_name_en: '',
                    tree_name_bn: ''
                }
                this.$toast.success({
                    title: 'Success',
                    message: this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })
                return false
            } else {
                this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('globalTrans.form_error_msg'),
                color: '#ee5253'
                })
            }
        },
        isNumber (evt) {
            // if (evt === 'undefined' || evt === null) {
            //     evt = window.event
            // }
            // var charCode = (evt.which) ? evt.which : evt.keyCode
            // if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
            //     evt.preventDefault()
            // }
            helpers.isNumber(evt)
        }
      },
      watch: {
        currentLocale: function () {}
      }
  }
  </script>
