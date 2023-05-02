<template>
  <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
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
                        <b-td class="text-center align-middle">
                          <span>
                              <b-form-checkbox v-model="item.is_invitation_sent"></b-form-checkbox>
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
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-capitalize text-center">
            <h5 style="background-color: #5f90c3;" class="text-white mb-3">{{ $t('globalTrans.other') + ' ' + $t('globalTrans.list') }}</h5>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Organization En" vid="organization_en" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_en"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.organization') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    v-model="formAddMore.organization_en"
                    id="organization_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Organization Bn" vid="organization_bn" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="organization_bn"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.organization') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                    v-model="formAddMore.organization_bn"
                    id="organization_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Designation En" vid="designation_en" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="designation_en"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    v-model="formAddMore.designation_en"
                    id="designation_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Designation Bn" vid="designation_bn" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="designation_bn"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.designation') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                    v-model="formAddMore.designation_bn"
                    id="designation_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Name En" vid="name_en" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="name_en"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    v-model="formAddMore.name_en"
                    id="name_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Name Bn" vid="name_bn" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="name_bn"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.name') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                    v-model="formAddMore.name_bn"
                    id="name_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Email" vid="email" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="email"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.email') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    v-model="formAddMore.email"
                    id="email"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="6" xl="6">
            <ValidationProvider name="Contact No" vid="contact_no" rules="">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="contact_no"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.contact_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    v-model="formAddMore.contact_no"
                    id="contact_no"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
            <div class="text-right mb-2">
              <b-button type="button" variant="success" @click="addItem">{{ $t('globalTrans.add') }}</b-button>
            </div>
          </b-col>
        </b-row>
        <b-row>
          <b-col xl="12" lg="8" sm="8">
            <b-table-simple bordered>
              <thead class="text-white bg-primary">
              <tr>
                <th class="text-center" width="5%">{{ $t('globalTrans.sl_no') }}</th>
                <th scope="col" width="10%">{{ $t('globalTrans.organization') }}</th>
                <th scope="col" width="20%">{{ $t('globalTrans.designation') }}</th>
                <th scope="col" width="30%">{{ $t('globalTrans.name') }}</th>
                <th scope="col" width="20%">{{ $t('globalTrans.email') }}</th>
                <th scope="col" width="20%">{{ $t('globalTrans.contact_no') }}</th>
                <th class="text-center" width="10%">{{ $t('globalTrans.action') }}</th>
              </tr>
              </thead>
              <b-tbody>
                <b-tr v-for="(item, index) in form.invite_others" :key="index">
                  <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                  <b-td>{{ currentLocale === 'en' ? item.organization_en : item.organization_bn }}</b-td>
                  <b-td>{{ currentLocale === 'en' ? item.designation_en : item.designation_bn }}</b-td>
                  <b-td>{{ currentLocale === 'en' ? item.name_en : item.name_bn }}</b-td>
                  <b-td>{{ item.email }}</b-td>
                  <b-td>{{ $n(0) + $n(item.contact_no, { useGrouping: false }) }}</b-td>
                  <b-td class="text-center align-middle">
                    <span class="d-flex text-center">
                        <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                        <b-button type="button" @click="deleteItem(index)" class="m-auto" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                    </span>
                  </b-td>
                </b-tr>
                <b-tr v-if="!form.invite_others.length">
                  <td colspan="7" class="text-center">
                    <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                  </td>
                </b-tr>
              </b-tbody>
            </b-table-simple>
          </b-col>
        </b-row>
        <b-col xs="12" sm="12" md="6">
          <h5>{{ $t('meeting_management.invitation_card') }}</h5>
          <template class="pb-3" v-if="form.id && form.invitation_attachment">
            <a :href="bftiResReportServiceBaseUrl + (isImage(form.invitation_attachment) ? 'storage/' : '') + form.invitation_attachment" target="_blank" class="btn btn-sm btn-success mt-3" download><i class="ri-file-download-fill"></i> {{ $t('bfti.attachment_down')}}</a> <br>
          </template>
        </b-col>
        <b-row class="text-right">
          <b-col>
          <hr>
              <b-button type="submit" variant="warning" class="mr-2 btn-sm">{{ $t('globalTrans.send') }} {{  $t('meeting_management.invitation') }}</b-button>
          </b-col>
        </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { programInfoInviteSendInvitationApi, userListByDesignWise, userNameList } from '../../../api/routes'

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
        organization_en: '',
        organization_bn: '',
        designation_en: '',
        designation_bn: '',
        name_en: '',
        name_bn: '',
        email: '',
        contact_no: ''
      },
      form: {
        id: 0,
        invitation_attachment: '',
        invite_status: 0,
        invite: [],
        invite_others: []
      },
      stakeholderList: [],
      allUserList: [],
      userListResponsible: [],
      heading: [],
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
        this.form = Object.assign({}, this.form, tmp)
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
    designationList () {
      return this.$store.state.CommonService.commonObj.designationList.map(item => {
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
  },
  methods: {
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
    async getNameUser () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
         await RestApi.getData(authServiceBaseUrl, userNameList).then(response => {
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
    editLocation (item, index) {
      this.formAddMore = Object.assign({}, item)
      this.locationIndex = index
      this.lock = true
    },
    deleteItem (index) {
      this.form.invite_others.splice(index, 1)
      if (this.form.invite_others.length === 0) {
        this.nodata = true
      }
      if (this.nodata === true) {
        this.documentTypeList = this.documentType()
      }
    },
    async addItem () {
      if (
          this.formAddMore.organization_en && this.formAddMore.designation_en && this.formAddMore.designation_en &&
          this.formAddMore.email && this.formAddMore.contact_no
      ) {
        if (this.locationIndex !== '') {
          this.form.invite_others[parseInt(this.locationIndex)] = this.formAddMore
        } else {
          const itemExists = this.form.invite_others.find(item => item.organization_en === this.formAddMore.organization_en && item.designation_en === this.formAddMore.designation_en && item.name_en === this.formAddMore.name_en && item.email === this.formAddMore.email && item.contact_no === this.formAddMore.contact_no)
          if (itemExists !== undefined) {
            return this.$toast.error({
              message: 'This item already exists',
              color: '#D6E09B'
            })
          }
          this.form.invite_others.push(JSON.parse(JSON.stringify(this.formAddMore)))
        }
        this.formAddMore = {
          organization_en: '',
          organization_bn: '',
          designation_en: '',
          designation_bn: '',
          name_en: '',
          name_bn: '',
          email: '',
          contact_no: ''
        }
        this.locationIndex = ''
      } else {
        return this.$toast.error({
          message: 'Please select items correctly',
          color: '#D6E09B'
        })
      }
    },
    async submit () {
        let isStakeHolderSelected = false
        this.form.invite.forEach(item => {
          if (item.is_invitation_sent) {
            isStakeHolderSelected = true
          }
        })
        if (!isStakeHolderSelected) {
          return this.$toast.error({
            message: 'Please select at least one stakeholder',
            color: '#D6E09B'
          })
        }
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const loadingState = { loading: false, listReload: false }
        const result = await RestApi.putData(bftiResReportServiceBaseUrl, `${programInfoInviteSendInvitationApi}/${this.id}`, this.form)

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: 'Success',
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })

          this.$bvModal.hide('modal-invitation-form')
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
