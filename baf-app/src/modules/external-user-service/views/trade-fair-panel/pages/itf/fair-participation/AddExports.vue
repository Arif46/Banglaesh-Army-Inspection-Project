<template>
    <ValidationObserver ref="form2"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(addItem)" @reset.prevent="reset">
            <b-overlay :show="unitLoad">
                <!-- <b-row class="mb-3">
                    <div class="bg-dark w-50 m-auto rounded-pill">
                        <h6 class="text-white text-center py-1"> {{ $t('externalTradeFair.export_performance_last') }}</h6>
                    </div>
                </b-row> -->
                <b-row>
                    <b-col sm="3">
                        <ValidationProvider name="Year" vid="year" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group label-for="year">
                                <template v-slot:label>
                                    {{$t('globalTrans.year')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                    plain
                                    v-model="detail_obj.year"
                                    :options="yearList"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                </b-form-select>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col sm="3">
                        <ValidationProvider name="Export Value" vid="usd_dollar" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group label-for="usd_dollar">
                                <template v-slot:label>
                                    {{ $t('externalTradeFair.usd_dollar') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="detail_obj.usd_dollar"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col sm="3">
                        <ValidationProvider :name="$t('tradeFairConfig.measurement_unit', 'en')" vid="measurement_id" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group label-for="measurement_id">
                                <template v-slot:label>
                                    {{ $t('tradeFairConfig.measurement_unit') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                    plain
                                    v-model="detail_obj.measurement_id"
                                    :options="getMeasurementUnitList"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                </b-form-select>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col>
                        <div style="margin-top: 21px;">
                            <b-button type="submit" variant="primary" class="btn-sm mr-1" :title="editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')">
                                <i class="ri-add-line" style="vertical-align: bottom;"></i>
                                <!-- {{ editIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}} -->
                            </b-button>
                            <b-button type="button" v-if="editIndex !== ''" variant="danger" class="btn-sm" :title="$t('globalTrans.cancel')" @click="cancelItem()">
                                <i class="ri-close-line" style="vertical-align: bottom;"></i>
                                <!-- {{ $t('globalTrans.cancel') }} -->
                            </b-button>
                        </div>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col xl="12" lg="12" sm="12">
                        <b-table-simple bordered class="mt-2">
                            <thead class="text-white bg-primary">
                                <tr>
                                    <th class="text-center" width="100px">{{ $t('globalTrans.sl_no') }}</th>
                                    <th scope="col">{{ $t('globalTrans.year') }}</th>
                                    <th scope="col">{{ $t('externalTradeFair.usd_dollar') }}</th>
                                    <th scope="col">{{ $t('tradeFairConfig.measurement_unit') }}</th>
                                    <th width="15%" class="text-center">{{ $t('globalTrans.action') }}</th>
                                </tr>
                            </thead>
                            <b-tbody>
                                <b-tr v-for="(item, index) in dataArray" :key="index">
                                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                    <b-td>{{ $n(item.year, { useGrouping: false }) }}</b-td>
                                    <b-td>{{ $n(item.usd_dollar, { minimumFractionDigits: 2 }) }}</b-td>
                                    <b-td>{{ getMeasurementUnitName(item.measurement_id) }}</b-td>
                                    <b-td class="text-center">
                                        <b-button @click="editItem(item, index)" title="Edit" class="btn btn-success btn-sm mr-1"><i class="ri-pencil-fill m-0"></i></b-button>
                                        <b-button type="button" @click="deleteItem(index)" title="Delete" class="btn btn-danger" size="sm"><i class="ri-delete-bin-2-line"></i></b-button>
                                    </b-td>
                                </b-tr>
                                <b-tr v-if="dataArray.length <= 0">
                                    <td colspan="5" class="text-center">
                                        <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                                    </td>
                                </b-tr>
                            </b-tbody>
                        </b-table-simple>
                    </b-col>
                </b-row>
            </b-overlay>
        </b-form>
    </ValidationObserver>
</template>

<script>
export default {
    props: ['dataArray', 'unitList'],
    data () {
      return {
        valid: null,
        unitLoad: false,
        editIndex: '',
        detail_obj: {
            year: 0,
            usd_dollar: '',
            measurement_id: 0
        }
      }
    },
    created () {
        //
    },
    computed: {
        getMeasurementUnitList () {
            const list = []
            this.unitList.map(el => {
                const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === parseInt(el))
                if (typeof Obj !== 'undefined') {
                    list.push({ value: Obj.value, text: this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn })
                }
            })
            return list
        },
        yearList () {
            return this.$store.state.commonObj.yearList.map(el => {
                return Object.assign({ value: el, text: this.$i18n.locale === 'en' ? el : this.$n(el, { useGrouping: false }) })
            })
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        cancelItem () {
            this.detail_obj = {}
            this.editIndex = ''
            this.$refs.form2.reset()
        },
        editItem (item, index) {
            this.detail_obj = Object.assign({}, item)
            this.editIndex = index
        },
        deleteItem (index) {
            this.dataArray.splice(index, 1)
        },
        async addItem () {
            // last 3 years validations
            if (this.dataArray.length >= 3) {
                return this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: 'Add at least one stall category item!',
                    color: 'red'
                })
            }

            let result = []
            if (this.editIndex !== '') {
                const editList = [...this.dataArray]
                editList.splice(parseInt(this.editIndex), 1)
                result = [...editList]
            } else {
                result = this.dataArray
            }
            const year = this.detail_obj.year
            const newData = result.find(item => parseInt(item.year) === parseInt(year))
            if (typeof newData === 'undefined') {
                    if (this.editIndex !== '') {
                        this.dataArray[parseInt(this.editIndex)] = this.detail_obj
                    } else {
                        this.dataArray.push(JSON.parse(JSON.stringify(this.detail_obj)))
                    }
                    this.detail_obj = {
                        year: 0,
                        usd_dollar: '',
                        measurement_id: 0
                    }
                    this.editIndex = ''
            } else {
                this.$toast.error({
                    title: '!',
                    message: 'Item already added',
                    color: '#ee5253'
                })
            }
            this.$nextTick(() => {
                this.$refs.form2.reset()
            })
        },
        getMeasurementUnitName (Id) {
            const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === parseInt(Id))
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
            }
            return ''
        }
    }
}
</script>
