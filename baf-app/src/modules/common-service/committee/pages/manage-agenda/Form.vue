<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('organogram.org')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.org_id"
                  :options="orgList"
                  id="org_id"
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
            <ValidationProvider name="Committee" vid="cmt_committee_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="cmt_committee_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.committee')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.cmt_committee_id"
                  :options="committeeList"
                  id="cmt_committee_id"
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
            <ValidationProvider name="Committee Name (En)" vid="meeting_number" rules="required">
              <b-form-group
              class="row"
                  label-cols-sm="4"
                  label-for="meeting_number"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.meeting_number')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="meeting_number"
                  v-model="form.meeting_number"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Memo Number" vid="memo_number" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="memo_number"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.memo_number')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="memo_number"
                  v-model="form.memo_number"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Memo Issue Date" vid="memo_issue_date" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="memo_issue_date"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.memo_issue_date')}} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker
                  b-form-datepicker
                  id="memo_issue_date"
                  v-model="form.memo_issue_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Agenda Name (En)" vid="agenda_name" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="agenda_name"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.agenda_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="agenda_name"
                  v-model="form.agenda_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Agenda Name (Bn)" vid="agenda_name_bn" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="agenda_name_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.agenda_name_bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  rows="3"
                  id="agenda_name_bn"
                  v-model="form.agenda_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Meeting Date" vid="meeting_date" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="meeting_date"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.meeting_date')}} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker
                  b-form-datepicker
                  id="meeting_date"
                  v-model="form.meeting_date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Attachment" vid="attachment" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.attachment')}} <span class="text-danger">*</span>
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
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { manageAgendaStore, manageAgendaUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        cmt_committee_id: 0
      },
      userList: [],
      attachmentDemo: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCmtAgendaData()
      this.form = tmp
    } else {
      this.getLastSortingOrder()
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
    committeeList () {
      return this.$store.state.CommonService.commonObj.committeeList.filter(committee => committee.org_id === this.form.org_id)
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    }
  },
  methods: {
    getCmtAgendaData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
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
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${manageAgendaUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, manageAgendaStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
