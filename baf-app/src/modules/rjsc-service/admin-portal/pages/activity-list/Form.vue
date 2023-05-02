<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <ValidationProvider name="Activity Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
          <b-form-group
            label-for="name_en">
            <template v-slot:label>
              {{ $t('rjscAdminPortal.activity_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="name_en"
              v-model="form.name_en"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Activity Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
          <b-form-group
            label-for="name_bn">
            <template v-slot:label>
              {{ $t('rjscAdminPortal.activity_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
            </template>
            <b-form-input
              id="name_bn"
              v-model="form.name_bn"
              :state="errors[0] ? false : (valid ? true : null)"
            ></b-form-input>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
          </b-form-group>
        </ValidationProvider>
        <ValidationProvider name="Logo" v-slot="{ errors }">
          <b-form-group
            class="row"
            label-cols-sm="12"
            label-for="logo"
          >
          <template v-slot:label>
            {{ $t('rjscAdminPortal.logo') }}
          </template>
          <b-input-group>
            <b-form-file
              validate="size:10"
              id="logo"
              v-model="form.logo"
              @change="onChange"
              accept="image/*"
              :state="errors[0] ? false : (valid ? true : null)"
              placeholder="Choose a file or drop it here"
              drop-placeholder="Drop file here..."
            ></b-form-file>
          </b-input-group>
          <div v-if="form.logo">
            <img :src="rjscServiceBaseUrl + 'storage/' + form.logo" style="width: 40px; height: 40px; border-radius: 50% !important;" class="center">
          </div>
          <div class="d-block invalid-feedback">
            {{ fileValidationMsz }}
          </div>
          <p>
            {{ $t('rjscAdminPortal.logo_status') }}
          </p>
          </b-form-group>
        </ValidationProvider>
        <b-table-simple bordered>
          <h5 style="background: #e3e3e3; padding: 10px;">{{ $t('rjscAdminPortal.activity_list') }}</h5>
        </b-table-simple>
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (En)" vid="title_en" v-slot="{ errors }">
              <b-form-group
                label-for="title_en">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_en"
                  v-model="detailsFormData.title_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <p class="text-danger" style="font-size: 10px"> {{ titleEnError + ' ' + alreadyAddedMsg }} </p>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" v-slot="{ errors }">
              <b-form-group
                label-for="title_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="title_bn"
                  v-model="detailsFormData.title_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <p class="text-danger" style="font-size: 10px"> {{ titleBnError }} </p>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="URL" vid="url" v-slot="{ errors }">
              <b-form-group
                label-for="url">
                <template v-slot:label>
                  {{ $t('globalTrans.url') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="url"
                  v-model="detailsFormData.url"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <p class="text-danger" style="font-size: 10px"> {{ urlError }} </p>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <div class="row">
          <div class="col-sm-3"></div>
          <div class="col text-right">
            <b-button v-if="locationIndex !== ''" variant="danger" class="btn btn-danger text-light btn-sm mr-1" @click="cancelLocation()">{{ $t('globalTrans.cancel') }}</b-button>
            <b-button @click="addItem()" variant="success" class="mr-2 btn-sm">{{ locationIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button>
          </div>
        </div>
        <br/>
        <b-table-simple bordered v-if="form.lists.length">
          <thead>
            <tr class="bg-primary">
              <th style="width:20%">{{ $t('globalTrans.sl_no') }}</th>
              <th style="width:60%">{{ $t('globalTrans.title') }}</th>
              <th style="width:60%">{{ $t('globalTrans.url') }}</th>
              <th style="width:20%">{{ $t('globalTrans.action') }}</th>
            </tr>
          </thead>
          <b-tbody>
              <b-tr v-for="(item, index) in form.lists" :key="index">
                  <b-td>
                      {{ $n(index + 1) }}
                  </b-td>
                  <b-td>
                    {{ currentLocale == 'bn' ? item.title_bn : item.title_en }}
                  </b-td>
                  <b-td>
                    {{ item.url }}
                  </b-td>
                  <b-td>
                    <span class="d-flex text-center">
                      <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                      <b-button type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button>
                    </span>
                  </b-td>
              </b-tr>
          </b-tbody>
        </b-table-simple>
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
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import { activityStore, activityUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      rjscServiceBaseUrl: rjscServiceBaseUrl,
      alreadyAddedMsg: '',
      fileValidationMsz: '',
      titleEnError: '',
      titleBnError: '',
      urlError: '',
      locationIndex: '',
      form: {
        name_en: '',
        name_bn: '',
        logo: [],
        // logo: [],
        lists: []
      },
      detailsFormData: {
        title_en: '',
        title_bn: '',
        url: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMenu()
      this.form = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    cancelLocation () {
      this.detailsFormData = {}
      this.locationIndex = ''
      this.$refs.form1.reset()
    },
    editLocation (item, index) {
      this.detailsFormData = Object.assign({}, item)
      this.locationIndex = index
    },
    async addItem () {
      if (this.detailsFormData.title_en && this.detailsFormData.title_bn && this.detailsFormData.url) {
        this.titleEnError = ''
        this.titleBnError = ''
        this.urlError = ''
        this.alreadyAddedMsg = ''
        const objExist = this.form.lists.find(detail => detail.title_en === this.detailsFormData.title_en)
        if (typeof objExist === 'undefined') {
          if (this.locationIndex !== '') {
            this.form.lists[parseInt(this.locationIndex)] = this.detailsFormData
          } else {
            this.form.lists.push(JSON.parse(JSON.stringify(this.detailsFormData)))
          }

          this.detailsFormData = {}
          this.locationIndex = ''
          this.$nextTick(() => {
            this.$refs.form.reset()
          })
        } else {
          this.alreadyAddedMsg = 'Title Already Added!!!'
        }
      } else {
        this.alreadyAddedMsg = ''
        this.titleEnError = this.detailsFormData.title_en > 0 ? '' : 'Title (En) is not valid.'
        this.titleBnError = this.detailsFormData.title_bn > 0 ? '' : 'Title (Bn) is not valid.'
        this.urlError = this.detailsFormData.url > 0 ? '' : 'URL is not valid.'
      }
    },
    deleteItem (index) {
      this.form.lists.splice(index, 1)
    },
    onChange (e) {
      this.fileValidationMsz = ''
      const input = event.target
      const file = input.files[0]
      if (file.size > 1024 * 2048) {
        e.preventDefault()
        this.fileValidationMsz = 'Maximum file size must be 2MB'
      }
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.logo = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.logo = ''
      }
    },
    async saveUpdate () {
      if (!this.form.lists.length) {
        return this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('rjscAdminPortal.added_msg'),
          color: 'red'
        })
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(rjscServiceBaseUrl, `${activityUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(rjscServiceBaseUrl, activityStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('RjscService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$toast.error({
          title: 'Error',
          message: result.errors.logo[0],
          color: '#FF0000'
        })
        this.$refs.form.setErrors(result.errors)
      }
    },
    getMenu () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
