<template>
  <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
      <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('meeting_management.invite_notice') }}</h5>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="org_id" rules="" >
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_category')}} <span class="text-danger">*</span>
                </template>
                <b-form-radio-group
                  v-if="lock && heading[0]"
                  disabled
                  id="organization_category"
                  v-model="formAddMore.organization_category"
                  :options="orgTypeList"
                  @change="orgShow()"
                  name="organization_category"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <b-form-radio-group
                  v-else
                  id="organization_category"
                  v-model="formAddMore.organization_category"
                  @change="orgShow()"
                  :options="orgTypeList"
                  name="organization_category"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showInternalOrg">
            <!-- Org List -->
            <ValidationProvider name="Organization" vid="organization_id" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.organization_id"
                  :options="orgList"
                  id="organization_id"
                  @change="stakeholdr()"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization Type" vid="organization_type_id" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.organization_type_id"
                  :options="organizationTypeList"
                  id="organization_type_id"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization Sub Type" vid="organization_sub_type_id" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_sub_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('stakeholder.org_sub_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.organization_sub_type_id"
                  :options="organizationSubTypeList"
                  id="organization_sub_type_id"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="showExternalOrg">
            <ValidationProvider name="Organization" vid="organization_id" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.organization_id"
                  :options="organizationNameList"
                  id="organization_id"
                  @change="stakeholdr()"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="formAddMore.organization_category < 3">
            <ValidationProvider name="Document Type" vid="stake_holder_id" rules="">
              <b-form-group
                label-for="stake_holder_id"
                label-cols-sm="4"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('meeting_management.stake_holder')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="formAddMore.stake_holder_id"
                :options="stakeholderList"
                id="stake_holder_id"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="formAddMore.organization_category > 2">
            <!-- <pre>{{$store.state.CommonService.commonObj.designationList}}</pre> -->
            <!-- <pre>{{$store.state.CommonService.commonObj.componentDesignationList}}</pre> -->
            <!-- Desig List -->
            <ValidationProvider name="Organization" vid="designation" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="designation"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('meeting_management.stakeHolderDesignation')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.designation"
                  :options="designationList"
                  id="designation"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="formAddMore.organization_category === 3">
            <ValidationProvider name="Stake Holder" vid="stake_holder" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="stake_holder"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{$t('meeting_management.stake_holder')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAddMore.stake_holder_id"
                  :options="userList"
                  id="stake_holder_id"
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
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('meeting_management.responsible_person') }}</h5>
          </b-col>
          <slot v-if="formAddMore.organization_category > 2">
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Designation" vid="designation" rules="">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="designation"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('meeting_management.designation_responsible')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formAddMore.designation_responsible"
                    :options="designationListResponsible"
                    id="designation"
                    @input="getResUserList()"
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
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Employee Name" vid="employee_name" rules="">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="employee_name"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('meeting_management.responsible_person')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formAddMore.responsible_person"
                    :options="userListResponsible"
                    id="employee_name"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ responsiblePersonLoading ? $t('globalTrans.loading') : $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
            </b-col>
          </slot>
          <slot v-else>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Designation" vid="designation" rules="">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="designation"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('meeting_management.designation_responsible')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formAddMore.designation_responsible"
                    :options="designationListResponsible"
                    id="designation"
                    :state="errors[0] ? false : (valid ? true : null)"
                    disabled
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
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Employee Name" vid="employee_name" rules="">
                  <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="employee_name"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{$t('meeting_management.responsible_person')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="formAddMore.responsible_person"
                    :options="userListResponsible"
                    id="employee_name"
                    :state="errors[0] ? false : (valid ? true : null)"
                    disabled
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ responsiblePersonLoading ? $t('globalTrans.loading') : $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
            </b-col>
          </slot>
      </b-row>
      <b-row class="text-right">
        <b-col>
            <div class="text-right mb-2">
                <b-button type="button" variant="success" @click="addItem">{{ locationIndex !== '' ? $t('globalTrans.add') : $t('globalTrans.add')}}</b-button>
            </div>
        </b-col>
      </b-row>
      <b-row >
      <b-col xl="12" lg="8" sm="8">
      </b-col>
      </b-row>
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('meeting_management.sil') }}</h5>
          </b-col>
            <b-col xl="12" lg="8" sm="8">
                <b-table-simple bordered>
                <thead class="text-white bg-primary">
                    <tr>
                        <th class="text-center" width="5%">{{ $t('globalTrans.sl_no') }}</th>
                        <th scope="col" width="10%">{{ $t('stakeholder.org_category') }}</th>
                        <th scope="col" width="20%">{{ $t('organogram.org') }}</th>
                        <th scope="col" width="30%">{{ $t('meeting_management.stake_holder') }}</th>
                        <th scope="col" width="20%">{{ $t('meeting_management.designation_responsible') }}</th>
                        <th scope="col" width="20%">{{ $t('meeting_management.responsible_person') }}</th>
                        <th class="text-center" width="10%">{{ $t('globalTrans.action') }}</th>
                    </tr>
                </thead>
                <b-tbody>
                    <b-tr v-for="(item, index) in form.invite" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td>{{ getOrgCategory(item.organization_category) }}</b-td>
                        <b-td>{{ getOrg(item.organization_id) }}</b-td>
                        <b-td>{{ getStakeHolder(item.stake_holder_id, item.organization_category) }}</b-td>
                        <b-td>{{ getDesignationListResponsible(item.designation_responsible) }}</b-td>
                        <b-td>{{ getName(item.responsible_person) }}</b-td>
                        <b-td class="text-center">
                          <span class="d-flex text-center">
                              <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                              <b-button type="button" @click="deleteItem(index)" class="m-auto" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                          </span>
                      </b-td>
                    </b-tr>
                    <b-tr v-if="!form.invite.length">
                        <td colspan="7" class="text-center">
                            <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                        </td>
                    </b-tr>
                </b-tbody>
                </b-table-simple>
            </b-col>
        </b-row>
        <b-col xs="12" sm="12" md="6">
          <ValidationProvider name="Attachment" vid="attachment" :rules="form.invitation_attachment ? '' : 'required'" v-slot="{ errors }">
            <b-form-group
                label-for="attachment">
                <template v-slot:label>
                    {{ $t('meeting_management.invitation_card') }} <span class="text-danger">*</span>
                </template>
                <b-form-file
                    id="attachment"
                    v-model="form.invitation_attachment"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.attachment_placeholder')"
                    :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"
                ></b-form-file>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
                <template class="pb-3" v-if="form.id && form.invitation_attachment">
                  <a :href="bftiResReportServiceBaseUrl + (isImage(form.invitation_attachment) ? 'storage/' : '') + form.invitation_attachment" target="_blank" class="btn btn-sm btn-success mt-3" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
                </template>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" @click="form.invite_status = 1" variant="warning" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
              <b-button type="submit" @click="form.invite_status = 2" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-invite')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
<!--        <b-row class="text-right">-->
<!--          <b-col>-->
<!--          <hr>-->
<!--              <b-button type="button" @click="invitation" variant="warning" class="mr-2 btn-sm">{{ $t('globalTrans.send') }} {{  $t('meeting_management.invitation') }}</b-button>-->
<!--          </b-col>-->
<!--        </b-row>-->
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { programInfoInviteUpdateApi, userListByDesignWise, userNameList } from '../../../api/routes'

export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      baseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      showExternalOrg: false,
      showInternalOrg: false,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      userName: [],
      locationIndex: '',
      formAddMore: {
        organization_id: 0,
        organization_category: 0,
        organization_type_id: 0,
        organization_sub_type_id: 0,
        designation: 0,
        responsible_person: '',
        stake_holder_id: 0
      },
      form: {
        id: 0,
        invitation_attachment: '',
        invite_status: 0,
        invite: []
      },
      stakeholderList: [],
      allUserList: [],
      userListResponsible: [],
      heading: [],
      designationList: [],
      userList: [],
      lock: false,
      orgTypeList: [
        { value: 1, text: 'Moc Stakeholder', text_en: 'Moc Stakeholder', text_bn: 'Moc স্টেকহোল্ডার' },
        { value: 2, text: 'Other', text_en: 'Other', text_bn: 'Other' },
        { value: 3, text: 'Moc', text_en: 'Moc', text_bn: 'Moc' }
      ],
      responsiblePersonLoading: false,
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl
    }
  },
  created () {
      this.getNameUser()
      this.getAllUserList()
      this.documentTypeList = this.documentType()
      this.programTypeList = this.programType()
      this.orgShow()
      if (this.id) {
        const tmp = this.getProgramInfoInviteData()
        this.form = tmp
        this.form.invite = tmp.invite
      }
  },
  computed: {
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    designationListResponsible () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    organizationTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationTypeList
    },
    organizationSubTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationSubTypeList.filter(orgSubType => orgSubType.organization_type_id === this.formAddMore.organization_type_id)
    },
    organizationNameList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.organizationNameList.filter(externalOrg => externalOrg.organization_sub_type_id === this.formAddMore.organization_sub_type_id)
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'formAddMore.organization_category': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.formAddMore.organization_id = 0
        this.formAddMore.organization_type_id = 0
        this.formAddMore.organization_sub_type_id = 0
        if (newVal === 1 || newVal === 2) {
          this.formAddMore.responsible_person = 0
          this.formAddMore.designation_responsible = 0
        }
        this.orgShow(newVal)
      }
    },
    'formAddMore.organization_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.designationList = this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === newVal)
        this.stakeholdr()
      }
    },
    'formAddMore.designation': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    },
    'formAddMore.stake_holder_id': function (newVal, oldVal) {
      if (newVal) {
         if (this.formAddMore.organization_category === 1 || this.formAddMore.organization_category === 2) {
          const stateHolder = this.stakeholderList.find(item => item.value === parseInt(newVal))
          this.formAddMore.designation_responsible = parseInt(stateHolder?.designation)
          this.formAddMore.responsible_person = parseInt(stateHolder?.employee_name)
          this.getUserListResponsible(this.formAddMore.designation_responsible)
         }
      } else {
        this.userList = []
      }
    },
    'formAddMore.designation_responsible': function (newVal, oldVal) {
      // if (newVal) {
      //   this.userListResponsible = this.getUserListResponsible(newVal)
      // } else {
      //   this.userListResponsible = []
      // }
    }
  },
  methods: {
    getResUserList () {
      if (this.formAddMore.designation_responsible) {
        this.userListResponsible = this.getUserListResponsible(this.formAddMore.designation_responsible)
      } else {
        this.userListResponsible = []
      }
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.invitation_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.invitation_attachment = ''
      }
    },
    getNameUser () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
         RestApi.getData(authServiceBaseUrl, userNameList).then(response => {
          if (response.success) {
            this.userName = response.data
          } else {
             this.userName = ['ddr']
          }
      })
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getOrgCategory (id) {
        const task = this.orgTypeList.find(type => type.value === id)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text_bn
          } else {
              return task.text_en
          }
        } else {
          return ''
        }
    },
    getOrg (id) {
        const task = this.$store.state.CommonService.commonObj.orgProfileList.find(type => type.value === id)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text_bn
          } else {
              return task.text_en
          }
        } else {
          return ''
        }
    },
    getStakeHolder (id, orgCategory) {
      if (orgCategory < 3) {
        const task = this.$store.state.BftiResearchAndReportService.commonObj.stakeholderList.find(type => type.value === id && type.organization_category === orgCategory)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text_bn
          } else {
              return task.text_en
          }
        } else {
          return ''
        }
      } else {
        const task = this.allUserList.find(type => type.value === id)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text
          } else {
              return task.text
          }
        } else {
          return ''
        }
      }
    },
    getDesignationListResponsible (id) {
        const task = this.$store.state.CommonService.commonObj.designationList.find(type => type.value === id)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text_bn
          } else {
              return task.text_en
          }
        } else {
          return ''
        }
    },
    getName (id) {
      const task = this.userName.find(type => type.value === id)
        if (task) {
          if (this.$i18n.locale === 'bn') {
              return task.text_bn
          } else {
              return task.text_en
          }
        } else {
          return ''
        }
    },
    editLocation (item, index) {
        this.formAddMore = Object.assign({}, item)
        this.locationIndex = index
        this.lock = true
    },
    deleteItem (index) {
        this.form.invite.splice(index, 1)
        if (this.form.invite.length === 0) {
            this.nodata = true
        }
        if (this.nodata === true) {
            this.documentTypeList = this.documentType()
        }
    },
    async addItem () {
      if (this.formAddMore.organization_id && this.formAddMore.stake_holder_id) {
        let result = []
        if (this.locationIndex !== '') {
          const editList = [...this.form.invite]
          editList.splice(parseInt(this.locationIndex), 1)
          result = [...editList]
        } else {
          result = this.form.invite
        }

        const nameEn = this.formAddMore.org_name
        const newData = result.find(item => item.org_name === nameEn)
        if (typeof newData === 'undefined') {
          if (this.locationIndex !== '') {
            this.form.invite[parseInt(this.locationIndex)] = this.formAddMore
          } else {
            const inviteItem = result.find(item => item.organization_id === parseInt(this.formAddMore.organization_id) && item.stake_holder_id === parseInt(this.formAddMore.stake_holder_id))
            if (inviteItem !== undefined) {
              return this.$toast.error({
                message: 'This item already exists',
                color: '#D6E09B'
              })
            }
            this.form.invite.push(JSON.parse(JSON.stringify(this.formAddMore)))
          }
          this.formAddMore = {
            organization_id: 0,
            organization_category: 0,
            organization_type_id: 0,
            organization_sub_type_id: 0,
            designation: 0,
            responsible_person: '',
            stake_holder_id: 0
          }
          this.locationIndex = ''
        } else {
          if (this.locationIndex !== '') {
            this.form.invite[parseInt(this.locationIndex)] = this.formAddMore
          } else {
            const inviteItem = result.find(item => item.organization_id === parseInt(this.formAddMore.organization_id) && item.stake_holder_id === parseInt(this.formAddMore.stake_holder_id))
            if (inviteItem !== undefined) {
              return this.$toast.error({
                message: 'This item already exists',
                color: '#D6E09B'
              })
            }
            this.form.invite.push(JSON.parse(JSON.stringify(this.formAddMore)))
          }
          this.formAddMore = {
            organization_id: 0,
            organization_category: 0,
            organization_type_id: 0,
            organization_sub_type_id: 0,
            designation: 0,
            responsible_person: '',
            stake_holder_id: 0
          }
          this.locationIndex = ''
        }
        this.$nextTick(() => {
          this.$refs.form1.reset()
          this.lock = false
        })
      } else {
        return this.$toast.error({
          message: 'Please select items correctly',
          color: '#D6E09B'
        })
      }
    },
    orgShow () {
      this.stakeholdr()
      if (this.formAddMore.organization_category === 1) {
        this.showExternalOrg = false
        this.showInternalOrg = true
      }
      if (this.formAddMore.organization_category === 3) {
        this.showExternalOrg = false
        this.showInternalOrg = true
      }
      if (this.formAddMore.organization_category === 2) {
        this.showInternalOrg = false
        this.showExternalOrg = true
      }
    },
    documentType () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    programType () {
      return this.$store.state.BftiResearchAndReportService.commonObj.programTypeList.filter(item => item.status === 1)
    },
    async submit () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const loadingState = { loading: false, listReload: false }
        const result = await RestApi.putData(bftiResReportServiceBaseUrl, `${programInfoInviteUpdateApi}/${this.id}`, this.form)

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: 'Success',
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })

          this.$bvModal.hide('modal-invite')
        } else {
          this.$toast.error({
              message: result.message,
              color: '#D6E09B'
          })
          this.$refs.heading.setErrors(result.errors)
        }
    },
    stakeholdr () {
      const oi = parseInt(this.formAddMore.organization_id)
      const oc = parseInt(this.formAddMore.organization_category)
      if (oc === 1) {
        this.stakeholderList = this.$store.state.BftiResearchAndReportService.commonObj.stakeholderList.filter(item => item.organization_id === oi && item.organization_category === oc)
      } else if (oc === 2) {
        this.stakeholderList = this.$store.state.BftiResearchAndReportService.commonObj.stakeholderList.filter(item => item.organization_id === oi && item.organization_category === oc)
      } else if (oc === 3) {
        this.getUserList(0)
      } else {
        this.stakeholderList = []
      }
    },
    getUserList (designationId) {
      if (designationId) {
        this.userLoading = true
        const params = Object.assign({}, { designation_id: designationId })
        RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
          if (response.success) {
            this.userList = response.data.map((obj, index) => {
              if (this.$i18n.locale === 'bn') {
                return { value: obj.id, text: obj.name_bn }
              } else {
                return { value: obj.id, text: obj.name }
              }
            })
            this.userLoading = false
          }
        })
      }
    },
    getAllUserList () {
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, {}).then(response => {
        if (response.success) {
          this.allUserList = response.data.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
        }
      })
    },
    getUserListResponsible (designationId) {
      this.responsiblePersonLoading = true
      const params = Object.assign({}, { designation_id: designationId })
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
        if (response.success) {
          this.userListResponsible = response.data.map((obj, index) => {
            if (this.$i18n.locale === 'bn') {
              return { value: obj.id, text: obj.name_bn }
            } else {
              return { value: obj.id, text: obj.name }
            }
          })
          this.responsiblePersonLoading = false
        }
      })
    },
    getProgramInfoInviteData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    isImage (path) {
      return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
    }
  }
}
</script>
