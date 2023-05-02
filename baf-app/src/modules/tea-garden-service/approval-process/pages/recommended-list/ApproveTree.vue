<template>
  <div class="section-wrapper cord-page">
    <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-row>
            <b-col lg="12" sm="12">
                <body-card>
                    <template v-slot:headerTitle>
                        <h4 class="card-title"> {{ $t('teaGardenService.forest_resource_section_area') }}</h4>
                    </template>
                    <template v-slot:body>
                        <b-row>
                            <b-col xl="12" lg="12" sm="12">
                                <b-form @submit.prevent="handleSubmit(register)" @reset.prevent="reset">
                                    <b-row>
                                        <b-col sm="12">
                                            <div class="table-responsive">
                                                <table class="table table-sm table-bordered table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>{{ $t('teaGardenService.section_name') }}</th>
                                                            <th class="text-left">{{ $t('teaGardenService.mouja') }}</th>
                                                            <th>{{ $t('teaGardenService.khotian') }}</th>
                                                            <th>{{ $t('teaGardenService.dag_no') }}</th>
                                                            <th>{{ $t('teaGardenService.tree_name') }}</th>
                                                            <th class="text-right">{{ $t('teaGardenService.number_of_trees') }}</th>
                                                            <th class="text-right">{{ $t('approvalProcess.recommendation') }}</th>
                                                            <th class="text-right">{{ $t('teaGardenService.approved_tree') }}</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody v-if="data.tree_cutting_locations.length > 0">
                                                        <slot v-for="(sectionItem, index) in data.tree_cutting_locations">
                                                            <template v-for="(sectionItem1, sectionIndex) in sectionItem.cutting_trees">
                                                            <tr :key="sectionIndex + 'section'">
                                                                <td v-if="sectionIndex === 0" :rowspan="sectionItem.cutting_trees.length">
                                                                {{ getSectionName(sectionItem.section_id) }}
                                                                </td>
                                                                <td class="text-left" v-if="sectionIndex === 0" :rowspan="sectionItem.cutting_trees.length">{{ currentLocale === 'en' ? sectionItem.mouja_en : sectionItem.mouja_bn }}</td>
                                                                <td v-if="sectionIndex === 0" :rowspan="sectionItem.cutting_trees.length"><span v-if="sectionItem.khotian_no">{{ EngBangNum(sectionItem.khotian_no) }}</span></td>
                                                                <td v-if="sectionIndex === 0" :rowspan="sectionItem.cutting_trees.length"><span v-if="sectionItem.dag_no">{{ EngBangNum(sectionItem.dag_no) }}</span></td>
                                                                <td>
                                                                {{ getTreeName(sectionItem1.tree_id) }}
                                                                </td>
                                                                <td class="text-right">
                                                                    {{ $n(sectionItem1.number_of_tree) }}
                                                                </td>
                                                                <td class="text-right">
                                                                    {{ $n(sectionItem1.requisition_tree) }}
                                                                </td>
                                                                <td>
                                                                <ValidationProvider name="Approved tree" :vid="'approved_tree' + sectionIndex + '_' + index" :rules="{ required: true, max_value :sectionItem1.requisition_tree }">
                                                                    <b-form-group
                                                                    class="mb-0"
                                                                    slot-scope="{ valid, errors }">
                                                                    <b-form-input
                                                                        id="requisition_tree"
                                                                        class="text-right"
                                                                        type="number"
                                                                        :max="sectionItem1.requisition_tree"
                                                                        v-model="sectionItem1.approved_tree"
                                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                                    ></b-form-input>
                                                                    <div class="error invalid-feedback" role="alert">
                                                                        <!-- {{ errors[0] }} -->
                                                                    </div>
                                                                    </b-form-group>
                                                                </ValidationProvider>
                                                                </td>
                                                            </tr>
                                                            </template>
                                                            <tr :key="sectionIndex + 'section' + 1">
                                                                <td colspan="5" class="text-right">
                                                                    <b>{{ $t('teaGardenService.sub_total') }}</b>
                                                                </td>
                                                                <td class="text-right">
                                                                    <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { number_of_tree } ) => sum + Number(number_of_tree) , 0)) }}</b>
                                                                </td>
                                                                <td class="text-right">
                                                                    <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { requisition_tree } ) => sum + Number(requisition_tree) , 0)) }}</b>
                                                                </td>
                                                                <td class="text-right">
                                                                    <b>{{ $n(sectionItem.cutting_trees.reduce( ( sum, { approved_tree } ) => sum + Number(approved_tree) , 0)) }}</b>
                                                                </td>
                                                            </tr>
                                                        </slot>
                                                    <tr>
                                                        <td colspan="5" class="text-right">
                                                            <b>{{ $t('teaGardenService.grand_total') }}</b>
                                                        </td>
                                                        <td class="text-right">
                                                            <b>{{ $n(totalNumberOfTrees) }}</b>
                                                        </td>
                                                        <td class="text-right">
                                                            <b>{{ $n(reqNumberOfTrees) }}</b>
                                                        </td>
                                                        <td class="text-right">
                                                            <b>{{ $n(appNumberOfTrees) }}</b>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </b-col>
                                    </b-row>
                                    <b-row>
                                        <b-col xs="12" sm="12" md="12">
                                            <ValidationProvider name="Attachment" vid="attachment">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-cols-sm="3"
                                                    label-for="attachment">
                                                    <template v-slot:label>
                                                        {{ $t('globalTrans.attachment') }}
                                                    </template>
                                                    <b-form-file
                                                        id="attachment"
                                                        v-model="data.file"
                                                        @change="onChange"
                                                        accept=".pdf"
                                                        :state="errors[0] ? false : (valid ? true : null)"
                                                        placeholder="Choose a file or drop it here..."
                                                        drop-placeholder="Drop file here..."
                                                    ></b-form-file>
                                                    <div class="invalid-feedback">
                                                        {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-col>
                                        <b-col lg="12" sm="12">
                                            <ValidationProvider name="Reason" rules="">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="3"
                                                    label-for="reason"
                                                    slot-scope="{ valid, errors }"
                                                >
                                                <template v-slot:label>
                                                    {{ $t('globalTrans.comments')}}
                                                </template>
                                                    <b-form-textarea
                                                    id="reason"
                                                    v-model="data.remarks"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-textarea>
                                                    <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-col>
                                        <b-col lg="12" sm="12">
                                            <ValidationProvider name="Registration No" vid="registration_no" rules="required">
                                                <b-form-group
                                                    class="row"
                                                    label-cols-sm="3"
                                                    label-for="registration_no"
                                                    slot-scope="{ valid, errors }">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.registration_no') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-input
                                                    id="registration_no"
                                                    v-model="data.registration_no"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                    </div>
                                                </b-form-group>
                                            </ValidationProvider>
                                        </b-col>
                                    </b-row>
                                    <div class="row">
                                        <div class="col-sm-3"></div>
                                        <div class="col text-right">
                                            <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                            &nbsp;
                                            <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-6')">{{ $t('globalTrans.cancel') }}</b-button>
                                        </div>
                                    </div>
                                </b-form>
                            </b-col>
                        </b-row>
                    </template>
                </body-card>
            </b-col>
            </b-row>
        </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { applicantApprove, applicantTreeDesposal } from '../../api/routes'

export default {
    name: 'FormLayout',
    props: ['id'],
    created () {
      if (this.id) {
        const tmp = this.getInfo()
        this.data.base_table_id = tmp.id
        this.data.taggable_id = tmp.taggable_id
        this.data.status = 4
        this.data.attachment = ''
        this.data.user_id = this.$store.state.Auth.authUser.user_id
        this.data.designation_id = this.$store.state.Auth.authUser.office_detail.designation_id
        this.data.office_type_id = this.$store.state.Auth.authUser.office_detail.office_type_id
        this.data.office_id = this.$store.state.Auth.authUser.office_detail.office_id
        this.data.tree_cutting_locations = []
        this.treeDesposalInfo()
        this.data.approver_id = this.data.user_id
        this.data.approver_name_en = this.$store.state.Auth.authUser.name
        this.data.approver_name_bn = this.$store.state.Auth.authUser.name_bn
        this.getDesignationName(this.data.designation_id)
      }
    },
    computed: {
      loading () {
        return this.$store.state.commonObj.loading
      },
      currentLocale () {
          return this.$i18n.locale
      },
      totalNumberOfTrees () {
        var total = 0
        this.data.tree_cutting_locations.forEach(section => {
            section.cutting_trees.forEach(treeSection => {
                total += Number(treeSection.number_of_tree)
            })
        })
        return total
      },
      appNumberOfTrees () {
        var total = 0
        this.data.tree_cutting_locations.forEach(section => {
            section.cutting_trees.forEach(treeSection => {
                total += Number(treeSection.approved_tree)
            })
        })
        return total
      },
      reqNumberOfTrees () {
        var total = 0
        this.data.tree_cutting_locations.forEach(section => {
            section.cutting_trees.forEach(treeSection => {
                total += Number(treeSection.requisition_tree)
            })
        })
        return total
      }
    },
    mounted () {
    },
    data () {
        return {
            saveBtnName: this.id ? this.$t('globalTrans.approve') : this.$t('globalTrans.save'),
            data: {
                file: '',
                remarks: '',
                tree_cutting_locations: []
            },
            gardenSectionDetail: [],
            loader: false
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
        async treeDesposalInfo () {
            const loadingState = { loading: true, listReload: false }
            this.$store.dispatch('mutateCommonProperties', loadingState)
            const result = await RestApi.getData(teaGardenServiceBaseUrl, applicantTreeDesposal + '/' + this.data.taggable_id)
            if (result.success) {
                this.gardenSectionDetail = result.gardenInfo
                this.data.tree_cutting_locations = result.data.tree_cutting_locations
                const loadingState = { loading: false, listReload: false }
                this.$store.dispatch('mutateCommonProperties', loadingState)
            }
        },
        getInfo () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        onChange (event) {
            const input = event.target
            if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
                this.data.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
            } else {
                this.data.attachment = ''
            }
        },
        async register () {
            this.loader = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadinState = { loading: false, listReload: true }
            result = await RestApi.postData(teaGardenServiceBaseUrl, `${applicantApprove}`, this.data)
            this.$store.dispatch('mutateCommonProperties', loadinState)
            if (result.success) {
                this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })
                this.$bvModal.hide('modal-6')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
            this.loader = false
        },
        getDesignationName (designationId) {
            const objectData = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === designationId)
            if (objectData) {
                this.data.approver_designation_en = objectData.text_en
                this.data.approver_designation_bn = objectData.text_bn
            }
        }
    }
}
</script>
