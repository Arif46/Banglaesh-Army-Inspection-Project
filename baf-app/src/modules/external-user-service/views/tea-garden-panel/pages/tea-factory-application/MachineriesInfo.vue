<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="machineriesInfo"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="4" :label="$t('teaGardenPanel.machineries_info_label_add')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Machine Name (En)" vid="machine_name_en">
                                                    <b-form-group label-for="machine_name_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.machine_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input v-model="addMoreMachineriesData.machine_name_en"></b-form-input>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Machine Name (Bn)" vid="machine_name_bn">
                                                    <b-form-group label-for="machine_name_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.machine_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input v-model="addMoreMachineriesData.machine_name_bn"></b-form-input>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Capacity Per Hour" vid="capacity_per_hour">
                                                    <b-form-group label-for="capacity_per_hour">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.capacity_kg_per_hour') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number" v-model="addMoreMachineriesData.capacity_per_hour"></b-form-input>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Capacity Per Year" vid="capacity_per_year">
                                                    <b-form-group label-for="capacity_per_year">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.capacity_kg_per_year') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input type="number" v-model="addMoreMachineriesData.capacity_per_year"></b-form-input>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="12">
                                                <ValidationProvider name="Remarks" vid="remarks">
                                                    <b-form-group label-for="remarks">
                                                        <template v-slot:label>
                                                            {{ $t('globalTrans.remarks') }}
                                                        </template>
                                                        <b-form-textarea
                                                            v-model="addMoreMachineriesData.remarks"
                                                            rows="1"
                                                            max-rows="2"
                                                            >
                                                        </b-form-textarea>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="12">
                                                <b-button @click="addMoreItem" class="add-more-btn" size="sm"><i class="ri-add-line"></i> {{ $t('teaGardenPanel.add_more_machineries') }}</b-button>
                                            </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="12" :label="$t('teaGardenPanel.machineries_info_label')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-col sm="12">
                                                <table class="table table-sm table-bordered section-tree-view-table">
                                                    <thead>
                                                        <tr>
                                                            <th>{{ $t('teaGardenPanel.machine_name') }} {{ $t('globalTrans.en') }}</th>
                                                            <th>{{ $t('teaGardenPanel.machine_name') }} {{ $t('globalTrans.bn') }}</th>
                                                            <th>{{ $t('teaGardenPanel.capacity_kg_per_hour') }}</th>
                                                            <th>{{ $t('teaGardenPanel.capacity_kg_per_year') }}</th>
                                                            <th>{{ $t('globalTrans.action') }}</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <slot v-for="(item, index) in application.machineries_info">
                                                         <tr :key="index">
                                                            <td>{{ item.machine_name_en }}</td>
                                                            <td>{{ item.machine_name_bn }}</td>
                                                            <td>
                                                                <ValidationProvider name="Capacity Per Hour" :vid="'capacity_kg_per_hour' + '_' + index" :rules="{ required: true,min_value: 1}">
                                                                    <b-form-group
                                                                    class="mb-0"
                                                                    slot-scope="{ valid, errors }">
                                                                    <b-form-input
                                                                        :id="`capacity_kg_per_hour-${index}`"
                                                                        class="text-right"
                                                                        type="number"
                                                                        min="1"
                                                                        v-model="item.capacity_per_hour"
                                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                                    ></b-form-input>
                                                                    <div class="error invalid-feedback" role="alert">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    </b-form-group>
                                                                </ValidationProvider>
                                                            </td>
                                                            <td>
                                                                <ValidationProvider name="Capacity Per Year" :vid="'capacity_per_year' + '_' + index" :rules="{ required: true, min_value: 1 }">
                                                                    <b-form-group
                                                                    class="mb-0"
                                                                    slot-scope="{ valid, errors }">
                                                                    <b-form-input
                                                                        :id="`capacity_per_year-${index}`"
                                                                        class="text-right"
                                                                        type="number"
                                                                        min="1"
                                                                        v-model="item.capacity_per_year"
                                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                                    ></b-form-input>
                                                                    <div class="error invalid-feedback" role="alert">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                    </b-form-group>
                                                                </ValidationProvider>
                                                            </td>
                                                            <td @click="addMoreItemRemove(index)" class="text-center">
                                                                <a href="javascript:" class="text-danger" title="Delete"><i class="ri-delete-bin-6-line"></i></a>
                                                            </td>
                                                         </tr>
                                                        </slot>
                                                    </tbody>
                                                    <tfoot v-if="Object.keys(application.machineries_info).length === 0">
                                                        <tr>
                                                            <td colspan="5" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                                                         </tr>
                                                    </tfoot>
                                                </table>
                                        </b-col>
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
import { factoryInfoMachineriesInfoStoreApi } from '../../api/routes'
export default {
    props: ['app_id', 'machineriesInfoData', 'isRenew'],
    data () {
      return {
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        application: {
            app_id: 0,
            machineries_info: []
        },
        valid: null,
        loading: false,
        editIndex: '',
        addMoreMachineriesData: {
            machine_name_en: null,
            machine_name_bn: null,
            capacity_per_hour: null,
            capacity_per_year: null,
            remarks: null
        }
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      },
      divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        getAreaTypeList: function () {
            const objectData = this.$store.state.commonObj.areaTypeList
            return objectData.map((obj, key) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.value, text: obj.text_bn }
                } else {
                    return { value: obj.value, text: obj.text_en }
                }
            })
        }
    },
    methods: {
        async submit () {
               // checking machineries data can't empty
                if (Object.keys(this.application.machineries_info).length === 0) {
                    this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('teaGardenPanel.add_machineries_data'),
                    color: '#ee5253'
                })
                 return false
                }
                // validation checking
                var check = await this.$refs.machineriesInfo.validate()
                if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                const result = await RestApi.postData(teaGardenServiceBaseUrl, factoryInfoMachineriesInfoStoreApi, this.application)
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
                    this.$refs.machineriesInfo.setErrors(result.errors)
                    this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                    })
                }
                }
        },
        addMoreItemRemove (index) {
            this.application.machineries_info.splice(index, 1)
        },
        addMoreItem () {
            if (this.addMoreMachineriesData.machine_name_en === null || this.addMoreMachineriesData.machine_name_bn === null || this.addMoreMachineriesData.capacity_per_hour === null || this.addMoreMachineriesData.capacity_per_year === null) {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
               })
               return false
            }
            this.application.machineries_info.push(this.addMoreMachineriesData)
            this.addMoreMachineriesData = {
                machine_name_en: null,
                machine_name_bn: null,
                capacity_per_hour: null,
                capacity_per_year: null,
                remarks: null
            }
        }
    },
    created () {
        this.application.machineries_info = this.machineriesInfoData
        this.application.app_id = this.app_id
    }
}
</script>
