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
            <ValidationProvider name="Agenda" vid="cmt_agenda_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="cmt_agenda_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.select_agenda')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.cmt_agenda_id"
                  :options="agendaList"
                  id="cmt_agenda_id"
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
            <ValidationProvider name="Decision Name (En)" vid="decision" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="decision"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.decision')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  rows="3"
                  id="decision"
                  v-model="form.decision"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Decision Name (Bn)" vid="decision_bn" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="decision_bn"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.decision_bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  rows="3"
                  id="decision_bn"
                  v-model="form.decision_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Attendance Attachment" vid="attendance_attachment" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="attendance_attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.attendance_attachment')}} <span class="text-danger">*</span>
                </template>
                 <b-form-file
                    id="attendance_attachment"
                    v-model="form.attendance_attachment"
                    @change="attendenceOnChange"
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
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Document Attachment" vid="document_attachment" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="document_attachment"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('committee.document_attachment')}} <span class="text-danger">*</span>
                </template>
                 <b-form-file
                    id="document_attachment"
                    v-model="form.document_attachment"
                    @change="documentOnChange"
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
import { meetingMinuteStore, meetingMinuteUpdate } from '../../api/routes'
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
        cmt_committee_id: 0,
        cmt_agenda_id: 0
      },
      userList: [],
      attachmentDemo: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCmtGenCirculatedData()
      this.form = tmp
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
    agendaList () {
      return this.$store.state.CommonService.commonObj.agendaList.filter(agenda => agenda.cmt_committee_id === this.form.cmt_committee_id)
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
    getCmtGenCirculatedData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    attendenceOnChange (e) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attendance_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attendance_attachment = ''
      }
    },
    documentOnChange (e) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.document_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.document_attachment = ''
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${meetingMinuteUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, meetingMinuteStore, this.form)
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
