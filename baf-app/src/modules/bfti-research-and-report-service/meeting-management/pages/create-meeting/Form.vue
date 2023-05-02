<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col md="12 text-center">
            <span class="badge badge-primary card-title" style="width: 100%"><h5>{{ $t('meetingManagement.meeting_information') }}</h5></span>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Memo No." vid="memo_no" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="memo_no">
                <template v-slot:label>
                  {{ $t('meetingManagement.memo_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="memo_no"
                  v-model="form.memo_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Meeting Title (En)" vid="meeting_title_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="meeting_title_en">
                <template v-slot:label>
                  {{ $t('meetingManagement.title_en') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="meeting_title_en"
                  v-model="form.meeting_title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Meeting Title (Bn)" vid="meeting_title_bn">
              <b-form-group
                label-for="meeting_title_bn">
                <template v-slot:label>
                  {{ $t('meetingManagement.title_bn') }}
                </template>
                <b-form-input
                  id="meeting_title_bn"
                  v-model="form.meeting_title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Agenda (En)" vid="agenda_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="agenda_en">
                <template v-slot:label>
                  {{ $t('meetingManagement.agenda_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    rows="3"
                    id="address"
                    v-model="form.agenda_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Agenda (Bn)" vid="agenda_bn">
              <b-form-group
                label-for="agenda_bn">
                <template v-slot:label>
                  {{ $t('meetingManagement.agenda_bn') }}
                </template>
                <b-form-textarea
                    rows="3"
                    id="agenda_bn"
                    v-model="form.agenda_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Details (En)" vid="details_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="details_en">
                <template v-slot:label>
                  {{ $t('meetingManagement.details_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    rows="3"
                    id="details_en"
                    v-model="form.details_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Details (Bn)" vid="details_bn">
              <b-form-group
                label-for="details_bn">
                <template v-slot:label>
                  {{ $t('meetingManagement.details_bn') }}
                </template>
                <b-form-textarea
                    rows="3"
                    id="details_bn"
                    v-model="form.details_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col  xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Venue (En)" vid="venue_en" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="venue_en">
                <template v-slot:label>
                  {{ $t('meetingManagement.venue_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="venue_en"
                  v-model="form.venue_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col  xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Venue (Bn)" vid="venue_bn">
              <b-form-group
                label-for="venue_bn">
                <template v-slot:label>
                  {{ $t('meetingManagement.venue_bn') }}
                </template>
                <b-form-input
                  id="venue_bn"
                  v-model="form.venue_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Meeting Date" vid="meeting_date" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="meeting_date">
                <template v-slot:label>
                  {{ $t('meetingManagement.meeting_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="meeting_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  v-model="form.meeting_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Start Time" vid="start_time" v-slot="{ errors }" rules="required">
              <b-form-group
                label-for="start_time">
                <template v-slot:label>
                  {{ $t('meetingManagement.meeting_start_time') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="start_time"
                  type="time"
                  v-model="form.start_time"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="End Time" vid="end_time">
              <b-form-group
                label-for="end_time">
                <template v-slot:label>
                  {{ $t('meetingManagement.meeting_end_time') }}
                </template>
                <b-form-input
                  id="end_time"
                  type="time"
                  v-model="form.end_time"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment">
              <b-form-group
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('globalTrans.attachment') }}
                </template>
                 <b-form-file
                    id="attachment"
                    v-model="form.attachment"
                    @change="onChange"
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
        </b-row>
        <b-col md="12 text-center">
          <span class="badge badge-primary card-title" style="width: 100%;"><h5>{{ $t('globalTrans.details') }}</h5></span>
        </b-col>
        <b-col sm="9" lg="9" class="text-right">
          <button type="button" class="btn btn-primary btn-sm mr-1 rounded-pill" @click="addHeadItem()" title="Add More"> {{ $t('meetingManagement.label_add') }} </button>
        </b-col>
        <b-row style="">
          <b-col md="12">
            <b-overlay>
              <b-row v-for="(headItem,index) in form.heads" :key="index">
                <b-col sm="8" lg="8">
                  <ValidationProvider name="head_title_en" :vid="`group.heads${[index]}`">
                        <b-form-group
                            label-class="mr-3"
                            :label-for="`headItem.head_title_en${index}`"
                        >
                          <template v-slot:label>
                          {{ $t('meetingManagement.label') }} <span class="text-danger">*</span>
                      </template>
                        <b-form-input
                          v-model="headItem.head_title_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                  </ValidationProvider>
                </b-col>
                  <b-col lg="12" v-for="(item, index2) in headItem.details" :key="index2">
                    <b-row>
                      <b-col lg="4" sm="4">
                          <ValidationProvider name="item" vid="item" rules="required">
                            <b-form-group
                              class="row"
                              label-cols-sm="12"
                              label-for="item"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                  {{ $t('meetingManagement.item') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-textarea
                                id="item"
                                v-model="item.item"
                                :state="errors[0] ? false : (valid ? true : null)">
                              </b-form-textarea>
                            </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="4" sm="4">
                          <ValidationProvider name="decision" vid="decision" rules="required">
                              <b-form-group
                                class="row"
                                label-cols-sm="12"
                                label-for="decision"
                                slot-scope="{ valid, errors }">
                                <template v-slot:label>
                                    {{ $t('meetingManagement.decision') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-textarea
                                  id="decision"
                                  v-model="item.decision"
                                  :state="errors[0] ? false : (valid ? true : null)" >
                                </b-form-textarea>
                                <div class="invalid-feedback">
                                  {{ errors[0] }}
                                </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="4" sm="4" rules="required">
                          <ValidationProvider name="update" vid="update" >
                              <b-form-group
                                class="row"
                                label-cols-sm="12"
                                label-for="update">
                                <template v-slot:label>
                                  {{ $t('meetingManagement.update') }}
                                </template>
                                <b-form-textarea
                                  id="update"
                                  v-model="item.update">
                                </b-form-textarea>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="4" sm="4">
                          <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                              <b-form-group
                                class="row"
                                label-cols-sm="12 p-0 m-0"
                                label-for="designation_id"
                                slot-scope="{ valid, errors }">
                                <template v-slot:label>
                                  {{ $t('globalTrans.designation') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                  @change="getUserList(item.designation_id, item)"
                                  id="designation_id"
                                  :options="item.designationList"
                                  v-model="item.designation_id"
                                  :state="errors[0] ? false : (valid ? true : null)">
                                  <template v-slot:first>
                                    <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                                  </template>
                                </b-form-select>
                                  <div class="invalid-feedback">
                                      {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="4" sm="4">
                          <ValidationProvider name="Employee" vid="user_id" rules="required|min_value:1" >
                              <b-form-group
                                  class="row"
                                  label-cols-sm="12"
                                  label-for="user_id"
                                  slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{ $t('stakeholder.employee_name') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                  plain
                                  id="user_id"
                                  v-model="item.employee_user_id"
                                  :options="item.employeeList"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="2" sm="2">
                          <div style="margin-top: 42px !important">
                              <b-badge title="Add more" class="badge badge-success badge-btn ml-1 mr-1" @click="detailAddMore(index)"><i class="ri-add-line m-0"></i></b-badge>
                              <b-badge title="remove" class="badge badge-danger badge-btn" @click="reduceDetailItem(index, index2)"><i class="ri-delete-bin-line m-0"></i></b-badge>
                          </div>
                      </b-col>
                      </b-row>
                  </b-col>
              </b-row>
            </b-overlay>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <b-button type="button" variant="success" class="mr-2 btn-sm" @click="draftSave()" v-if="draftSHow">{{ $t('globalTrans.draft') }}</b-button>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ getButtonName() }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
            <!-- <pre>{{form.heads}}</pre> -->
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { createMeetingStoreApi, createMeetingUpdateApi, userListByDesignWise, createMeetingDraftStoreApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      draftSHow: true,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        edit_id: '',
        heads: [
          {
            head_title_en: '',
              details: [
                {
                  designationList: this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === 10),
                  employeeList: [],
                  designation_id: 0,
                  employee_user_id: 0
                }
              ]
          }
        ]
      },
      allUserList: []
    }
  },
  created () {
    this.getAllUserList()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (e) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    },
    async draftSave () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, createMeetingDraftStoreApi, this.form)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
         this.$bvModal.hide('modal-form')
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${createMeetingUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, createMeetingStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
         this.$bvModal.hide('modal-form')
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getMeetingData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getUserList (designationId, item, type = null) {
      const userList = this.allUserList.filter(item => item.designation_id === designationId)
      if (userList.length > 0) {
        const userLists = []
        userList.map(e => {
          const user = {
              value: e.id, text: this.$i18n.locale === 'en' ? e.name : e.name_bn
          }
          userLists.push(user)
        })
        if (type) {
          return userLists
        } else {
          item.employeeList = userLists
        }
      } else {
        if (type) {
          return []
        } else {
          item.employeeList = []
        }
      }
    },
    detailAddMore (index) {
      this.form.heads[index].details.push({
          id: '',
          designationList: this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === 10),
          employeeList: [],
          user_id: '',
          employee_id: '',
          designation_id: ''
      })
    },
    reduceDetailItem (index, index2) {
        this.form.heads[index].details.splice(index2, 1)
    },
    addHeadItem () {
      const headList = {
        head_title_en: '',
        details: [
          {
            designationList: this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === 10),
            employeeList: [],
            designation_id: 0,
            employee_user_id: 0
          }
        ]
      }
      this.form.heads.push(headList)
    },
    getAllUserList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allUserList = response.data
          this.getEditData()
        }
      })
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
    },
    getEditData () {
      if (this.id) {
        const tmp = this.getMeetingData()
        const tmpData = tmp.heads.map((item1) => {
          item1.details = item1.details.map((item2) => {
            const userList = this.getUserList(item2.designation_id, item2, 'edit')
            const detailData = {
              designationList: this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === 10),
              employeeList: userList
            }
            return Object.assign({}, item2, detailData)
          })
          return Object.assign({}, item1)
        })
        const newTmp = tmp
        newTmp.heads = tmpData
        this.form = newTmp
        if (this.form.is_draft === 2) {
          this.draftSHow = false
        } else {
          this.draftSHow = true
        }
      }
    },
    getButtonName () {
      if (this.form.is_draft === 1) {
        return this.$t('globalTrans.save')
      } else if (this.id) {
        return this.$t('globalTrans.update')
      } else {
        return this.$t('globalTrans.save')
      }
    }
  }
}
</script>
