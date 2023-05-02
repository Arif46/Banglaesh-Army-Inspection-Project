<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairConfig.committee_info') }} {{ $route.query.id? $t('globalTrans.modify') : $t('globalTrans.entry') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link to="committee-info-list" :class="'btn btn-primary text-light'">{{ $t('tradeFairConfig.committee_info_list') }}</router-link>
      </template>
      <template v-slot:searchBody>
        <b-overlay :show="loadingState">
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-overlay :show="loader">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Committee Type" vid="committee_type_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-for="committee_type_id">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.committee_type') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="committee_type_id"
                            :options="committeeTypeList"
                            v-model="data.committee_type_id"
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
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Committee Name" vid="committee_name_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                          label-for="committee_name_id">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.committee_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="committee_name_id"
                            :options="committeeNameList"
                            v-model="data.committee_name_id"
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
                  </b-row>
                  <b-row class="p-2">
                    <b-col style="background-color: var(--gray-ddd);" lg="4" class="offset-lg-4 p-2">
                      <template>
                        <h5 style="" class="text-center">{{ $t('tradeFairConfig.committee_member_info') }}</h5>
                      </template>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Name (En)" vid="name_en" v-slot="{ errors }">
                        <b-form-group
                          label-for="category_name_en">
                          <template v-slot:label>
                            {{ $t('globalTrans.name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="name_en"
                            v-model="detailsFormData.name_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ nameEnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Name (Bn)" vid="name_bn" v-slot="{ errors }">
                        <b-form-group
                          label-for="name_bn">
                          <template v-slot:label>
                            {{ $t('globalTrans.name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="name_bn"
                            v-model="detailsFormData.name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ nameBnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Designation (En)" vid="designation_en" v-slot="{ errors }">
                        <b-form-group
                          label-for="designation_en">
                          <template v-slot:label>
                            {{ $t('globalTrans.designation') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="designation_en"
                            v-model="detailsFormData.designation_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ designationEnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Designation (Bn)" vid="designation_bn" v-slot="{ errors }">
                        <b-form-group
                          label-for="designation_bn">
                          <template v-slot:label>
                            {{ $t('globalTrans.designation') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="designation_bn"
                            v-model="detailsFormData.designation_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ designationBnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Committee Roll" vid="committee_roll_id" v-slot="{ errors }">
                        <b-form-group
                          label-for="committee_roll_id">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.committee_roll') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="committee_roll_id"
                            :options="committeeRollList"
                            v-model="detailsFormData.committee_roll_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                          >
                            <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <p class="text-danger" style="font-size: 10px"> {{ rollBnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6"></b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Organization (En)" vid="org_name_en" v-slot="{ errors }">
                        <b-form-group
                          label-for="org_name_en">
                          <template v-slot:label>
                            {{ $t('globalTrans.org_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="org_name_en"
                            v-model="detailsFormData.org_name_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ orgEnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Organization (Bn)" vid="org_name_bn" v-slot="{ errors }">
                        <b-form-group
                          label-for="org_name_bn">
                          <template v-slot:label>
                            {{ $t('globalTrans.org_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="org_name_bn"
                            v-model="detailsFormData.org_name_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ orgBnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Contrict No" vid="contact_no" v-slot="{ errors }">
                        <b-form-group
                          label-for="contact_no">
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.contact_no') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="contact_no"
                            type="number"
                            v-model="detailsFormData.contact_no"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ contractError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
                        <b-form-group
                          label-for="email">
                          <template v-slot:label>
                            {{ $t('globalTrans.email') }}
                          </template>
                          <b-form-input
                            id="email"
                            v-model="detailsFormData.email"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Address En" vid="address_en" v-slot="{ errors }">
                        <b-form-group
                          label-for="address_en">
                          <template v-slot:label>
                            {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="address_en"
                            v-model="detailsFormData.address_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ addressEnError }} </p>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Address Bn" vid="address_bn" v-slot="{ errors }">
                        <b-form-group
                          label-for="address_bn">
                          <template v-slot:label>
                            {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="address_bn"
                            v-model="detailsFormData.address_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <p class="text-danger" style="font-size: 10px"> {{ addressBnError }} </p>
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
                  <b-table-simple bordered>
                    <thead>
                      <tr class="bg-primary">
                        <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                        <th style="width:10%">{{ $t('globalTrans.name') }}</th>
                        <th style="width:10%">{{ $t('globalTrans.designation') }}</th>
                        <th style="width:10%">{{ $t('tradeFairConfig.committee_roll') }}</th>
                        <th style="width:10%">{{ $t('globalTrans.org_name') }}</th>
                        <th style="width:10%">{{ $t('tradeFairConfig.contract_no') }}</th>
                        <th style="width:13%">{{ $t('globalTrans.email') }}</th>
                        <th style="width:10%">{{ $t('globalTrans.address') }}</th>
                        <th style="width:10%">{{ $t('globalTrans.action') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                        <b-tr v-for="(item, index) in data.details" :key="index">
                            <b-td>
                                {{ $n(index + 1) }}
                            </b-td>
                            <b-td>
                              {{ currentLocale == 'bn' ? item.name_bn : item.name_en }}
                            </b-td>
                            <b-td>
                              {{ currentLocale == 'bn' ? item.designation_bn : item.designation_en }}
                            </b-td>
                            <b-td>
                                {{ getRoll(item.committee_roll_id) }}
                            </b-td>
                            <b-td>
                              {{ currentLocale == 'bn' ? item.org_name_bn : item.org_name_en }}
                            </b-td>
                            <b-td>
                              {{ item.contact_no }}
                            </b-td>
                            <b-td>
                              {{ item.email }}
                            </b-td>
                            <b-td>
                              {{ currentLocale == 'bn' ? item.address_bn : item.address_en }}
                            </b-td>
                            <b-td>
                              <span class="d-flex text-center">
                                <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                                <b-button type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button>
                                <!-- <b-button v-if="!item.id" type="button" @click="deleteItem(index)" class="btn btn- iq-bg-danger btn-sm ml-1" variant="danger"><i class="ri-delete-bin-line m-0"></i></b-button> -->
                              </span>
                            </b-td>
                        </b-tr>
                    </b-tbody>
                  </b-table-simple>
                  <b-row class="mt-5">
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Committee Formation Date" vid="committee_formation_date" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="date"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.committee_formation_date') }}  <span class="text-danger">*</span>
                          </template>
                          <date-picker
                            id="committee_formation_date"
                            class="form-control"
                            v-model="data.committee_formation_date"
                            :class="errors[0] ? 'is-invalid' : ''"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :placeholder="$t('globalTrans.select')"
                          >
                          </date-picker>
                          <div class="invalid-feedback d-block">
                              {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Committee Tenure Date" vid="committee_tenure_date" rules="required" v-slot="{ errors }">
                        <b-form-group
                          label-for="date"
                        >
                          <template v-slot:label>
                            {{ $t('tradeFairConfig.committee_tenure_date') }}  <span class="text-danger">*</span>
                          </template>
                          <date-picker
                            id="committee_tenure_date"
                            class="form-control"
                            v-model="data.committee_tenure_date"
                            :class="errors[0] ? 'is-invalid' : ''"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :placeholder="$t('globalTrans.select')"
                          >
                          </date-picker>
                          <div class="invalid-feedback d-block">
                              {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <b-row class="text-right">
                    <b-col>
                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                        <router-link to="committee-info-list" :class="'btn btn-danger text-light btn-sm'">{{ $t('globalTrans.cancel') }}</router-link>
                    </b-col>
                  </b-row>
                </b-form>
              </b-overlay>
            </b-overlay>
          </ValidationObserver>
        </b-overlay>
      </template>
      <!-- <pre>{{data.details}}</pre> -->
    </card>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { committeeInfoStore, committeeInfoUpdate, committeeInfoShow } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      loader: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      nameEnError: '',
      nameBnError: '',
      contractError: '',
      designationEnError: '',
      rollBnError: '',
      loadingState: false,
      designationBnError: '',
      orgEnError: '',
      orgBnError: '',
      addressEnError: '',
      addressBnError: '',
      data: {
        committee_type_id: 0,
        committee_name_id: 0,
        committee_formation_date: '',
        committee_tenure_date: '',
        details: []
      },
      detailsFormData: {
        name_en: '',
        name_bn: '',
        designation_en: '',
        designation_bn: '',
        committee_roll_id: 0,
        org_name_en: '',
        org_name_bn: '',
        contact_no: '',
        email: '',
        address_en: '',
        address_bn: ''
      },
      locationIndex: '',
      committeeNameList: []
    }
  },
  created () {
    if (this.$route.query.id) {
      this.getCommitteeInfo()
      // this.data = tmp
    }
  },
  mounted () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    committeeTypeList () {
      return this.$store.state.TradeFairService.commonObj.committeeTypeList
    },
    committeeRollList () {
      return this.$store.state.TradeFairService.commonObj.committeeRollList.filter(item => item.status === 1)
    }
  },
  watch: {
    'data.committee_type_id': function (newVal) {
      if (newVal) {
        this.committeeNameList = this.getCommitteeName(newVal)
      } else {
        this.committeeNameList = []
      }
    }
  },
  methods: {
    getRoll (id) {
      const dataRoll = this.$store.state.TradeFairService.commonObj.committeeRollList.find(item => item.value === id && item.status === 1)
      if (this.currentLocale === 'bn') {
        return dataRoll !== undefined ? dataRoll.text_bn : ''
      } else {
        return dataRoll !== undefined ? dataRoll.text_en : ''
      }
    },
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
      if (this.detailsFormData.name_en && this.detailsFormData.name_bn && this.detailsFormData.designation_en && this.detailsFormData.designation_bn && this.detailsFormData.committee_roll_id && this.detailsFormData.org_name_en && this.detailsFormData.org_name_bn && this.detailsFormData.contact_no && this.detailsFormData.address_en && this.detailsFormData.address_bn) {
        this.nameEnError = ''
        this.nameBnError = ''
        this.designationEnError = ''
        this.rollBnError = ''
        this.designationBnError = ''
        this.orgEnError = ''
        this.orgBnError = ''
        this.contractError = ''
        this.addressEnError = ''
        this.addressBnError = ''
        if (this.locationIndex !== '') {
          this.data.details[parseInt(this.locationIndex)] = this.detailsFormData
        } else {
          this.data.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
        }

        this.detailsFormData = {}
        this.locationIndex = ''
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      } else {
        this.nameEnError = this.detailsFormData.name_en > 0 ? '' : 'Name En is not valid.'
        this.nameBnError = this.detailsFormData.name_bn > 0 ? '' : 'Name Bn is not valid.'
        this.designationEnError = this.detailsFormData.designation_en > 0 ? '' : 'Designation En is not valid.'
        this.designationBnError = this.detailsFormData.designation_bn > 0 ? '' : 'Designation Bn is not valid.'
        this.rollBnError = this.detailsFormData.committee_roll_id > 0 ? '' : 'Committee Roll is not valid.'
        this.orgEnError = this.detailsFormData.org_name_en > 0 ? '' : 'Organization Name En is not valid.'
        this.orgBnError = this.detailsFormData.org_name_bn > 0 ? '' : 'Organization Name Bn is not valid.'
        this.contractError = this.detailsFormData.contact_no > 999999999 ? '' : 'Contract No is not valid.'
        this.addressEnError = this.detailsFormData.address_en > 0 ? '' : 'Address En is not valid.'
        this.addressBnError = this.detailsFormData.address_bn > 0 ? '' : 'Address Bn is not valid.'
      }
    },
    deleteItem (index) {
      this.data.details.splice(index, 1)
    },
    async saveUpdate () {
      if (!this.data.details.length) {
        return this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('tradeFairConfig.added_msg'),
          color: 'red'
        })
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(internationalTradeFairServiceBaseUrl, `${committeeInfoUpdate}/${this.$route.query.id}`, this.data)
      } else {
        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, committeeInfoStore, this.data)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$router.push('/trade-fair-service/itf/configuration/committee-info-list')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getCommitteeName (id) {
      return this.$store.state.TradeFairService.commonObj.committeeNameList.filter(item => item.status === 1 && item.committee_type_id === id)
    },
    async getCommitteeInfo () {
      this.loader = true
      const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, committeeInfoShow + '/' + this.$route.query.id)
      const tmpData = resultData.data
      const detailsData = tmpData.details.map(item => {
        return {
          name_en: item.name_en, name_bn: item.name_bn, designation_en: item.designation_en, designation_bn: item.designation_bn, committee_roll_id: item.committee_roll_id, org_name_en: item.org_name_en, org_name_bn: item.org_name_bn, contact_no: item.contact_no, email: item.email, address_en: item.address_en, address_bn: item.address_bn
        }
      })
      this.data.details = detailsData
      this.data = tmpData
      this.loader = false
    }
  }
}
</script>
