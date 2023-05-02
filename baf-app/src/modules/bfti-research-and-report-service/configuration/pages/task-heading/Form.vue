<template>
  <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(addItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Document Type" vid="document_type_id" rules="required|min_value:1">
              <b-form-group
                label-for="document_type_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('configuration.document_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="heading_details.document_type_id"
                :options="documentTypeList"
                id="document_type_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option disabled :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Task Heading (En)" vid="task_heading_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="task_heading_en">
                <template v-slot:label>
                  {{ $t('configuration.task_heading') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="task_heading_en"
                  v-model="heading_details.task_heading_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12">
            <ValidationProvider name="Task Heading (Bn)" vid="task_heading_bn">
              <b-form-group
                label-for="task_heading_bn">
                <template v-slot:label>
                  {{ $t('configuration.task_heading') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="task_heading_bn"
                  v-model="heading_details.task_heading_bn"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
         <b-col xs="12" sm="12" md="12">
          <ValidationProvider name="Please select one" vid="is_sub_task" rules="required|min_value:1" v-slot="{ errors }">
          <b-form-group
              label-cols-sm="4"
              label-for="is_sub_task"
            >
            <template v-slot:label>
            {{$t('configuration.sub_task')}} <span class="text-danger">*</span>
            </template>
              <b-form-radio-group
                v-model="heading_details.is_sub_task"
                :options="getsubTaskList"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-radio-group>
             <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
          </b-form-group>
           </ValidationProvider>
       </b-col>
        <b-col>
            <div class="text-right mb-2">
                <b-button v-if="locationIndex !== ''" variant="danger" class="mr-1" @click="cancelLocation()">{{ $t('globalTrans.cancel') }}</b-button>
                <b-button type="submit" variant="success">{{ locationIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
            </div>
        </b-col>
        </b-row>
         <hr>
        <b-row>
            <b-col xl="12" lg="8" sm="8">
                <b-table-simple bordered>
                <thead class="text-white bg-primary">
                    <tr>
                        <th class="text-center" width="10%">{{ $t('globalTrans.sl_no') }}</th>
                        <th scope="col" width="50%">{{ $t('configuration.task_heading') }}</th>
                        <th scope="col" width="20%">{{ $t('configuration.sub_task') }}</th>
                        <th class="text-center" width="10%">{{ $t('globalTrans.action') }}</th>
                    </tr>
                </thead>
                <b-tbody>
                    <b-tr v-for="(item, index) in heading" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td>{{ currentLocale == 'bn' ? item.task_heading_bn : item.task_heading_en }}</b-td>
                        <b-td>{{ getSubTaskList(item.is_sub_task) }}</b-td>
                        <b-td class="text-center">
                            <span class="d-flex text-center">
                                <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                                <b-button v-if="!item.id" type="button" @click="deleteItem(index)" class="m-auto" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                            </span>
                        </b-td>
                    </b-tr>
                    <!-- <b-tr v-if="nodata">
                        <td colspan="7" class="text-center">
                            <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                        </td>
                    </b-tr> -->
                </b-tbody>
                </b-table-simple>
            </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="button" @click="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { taskHeadingStoreApi, taskHeadingUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      heading: [],
      nodata: true,
      locationIndex: '',
      documentTypeList: [],
      subTaskList: [{ text_en: 'Yes', text_bn: 'হ্যাঁ', value: 1 }, { text_en: 'No', text_bn: 'না', value: 2 }],
      heading_details: {
        document_type_id: 0,
        task_heading_en: '',
        is_sub_task: 0,
        task_heading_bn: ''
      }
    }
  },
    created () {
        if (this.heading.length === 0) {
          this.nodata = true
        } else {
          this.nodata = false
        }
      if (this.id) {
        const tmp = this.getLawEntry()
        tmp.details.forEach((value, key) => {
          this.heading.push(JSON.parse(JSON.stringify(value)))
        })
        const d = tmp.details[0].document_type_id
        this.heading_details.document_type_id = d
        this.documentTypeList = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.value === d && item.status === 1)
      } else {
        this.documentTypeList = this.documentType()
      }
    },
  computed: {
    currentLocale () {
            return this.$i18n.locale
        },
    getsubTaskList () {
      return this.subTaskList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
      getSubTaskList (taskId) {
            const task = this.subTaskList.find(type => type.value === taskId)
            if (this.$i18n.locale === 'bn') {
                return task.text_bn
            } else {
                return task.text_en
            }
        },
        cancelLocation () {
            this.heading_details = {}
            this.locationIndex = ''
            this.$refs.form1.reset()
        },
        editLocation (item, index) {
            this.heading_details = Object.assign({}, item)
            this.locationIndex = index
        },
        documentType () {
            return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
        },
        deleteItem (index) {
            this.heading.splice(index, 1)
            if (this.heading.length === 0) {
                this.nodata = true
            }
            if (this.nodata === true) {
                this.documentTypeList = this.documentType()
            }
        },
         async addItem () {
                         const d = this.heading_details.document_type_id
            let result = []
            if (this.locationIndex !== '') {
                const editList = [...this.heading]
                editList.splice(parseInt(this.locationIndex), 1)
                result = [...editList]
            } else {
                result = this.heading
            }

            const nameEn = this.heading_details.org_name
            const newData = result.find(item => item.org_name === nameEn)
            if (typeof newData === 'undefined') {
                if (this.locationIndex !== '') {
                    this.heading[parseInt(this.locationIndex)] = this.heading_details
                } else {
                    this.heading.push(JSON.parse(JSON.stringify(this.heading_details)))
                }

                this.heading_details = {}
                this.locationIndex = ''
            } else {
                 if (this.locationIndex !== '') {
                    this.heading[parseInt(this.locationIndex)] = this.heading_details
                } else {
                    this.heading.push(JSON.parse(JSON.stringify(this.heading_details)))
                }

                this.heading_details = {}
                this.locationIndex = ''
            }
            this.$nextTick(() => {
                this.$refs.form1.reset()
            })
            this.nodata = false
            if (this.nodata === false) {
              this.documentTypeList = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.value === d)
              this.heading_details.document_type_id = d
            } else {
                this.documentTypeList = this.documentType()
            }
        },
          async submit () {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            const loadingState = { loading: false, listReload: false }
            if (this.id) {
              result = await RestApi.putData(bftiResReportServiceBaseUrl, `${taskHeadingUpdateApi}/${this.id}`, this.heading)
            } else {
              result = await RestApi.postData(bftiResReportServiceBaseUrl, taskHeadingStoreApi, this.heading)
            }

            loadingState.listReload = true
            this.$store.dispatch('mutateCommonProperties', loadingState)

            if (result.success) {
              this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
              this.$toast.success({
                title: 'Success',
                message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
              })

              this.$bvModal.hide('modal-form')
            } else {
              this.$toast.error({
                  message: result.message,
                  color: '#D6E09B'
              })
              this.$refs.heading.setErrors(result.errors)
            }
          },
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
