<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.application_list') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="year"
            >
            <template v-slot:label>
              {{$t('globalTrans.year')}}
            </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="yearList"
                id="year"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('cip.final_list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loading">
          <b-row>
              <b-col xl="6" lg="6" md="6" sm="6">
                  <ValidationProvider>
                      <b-form-group
                          class="row"
                          label-for="app_type"
                          slot-scope="{ valid, errors }"
                          >
                          <b-form-radio-group
                              v-model="search.app_type"
                              :options="appTypeList"
                              value-field="item"
                              text-field="name"
                              :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-radio-group>
                          <div class="invalid-feedback d-block">
                          {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
              </b-col>
          </b-row>
        </b-overlay>
         <component :is='comp' :ref="comp" :searchItem="search"/>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import CipApplicants from './CipApplicants.vue'
import CipTrades from './CipTrades.vue'

export default {
  components: {
    CipApplicants,
    CipTrades
  },
  data () {
    return {
      loading: false,
      comp: 'CipApplicants',
      search: {
        year: 0,
        app_type: 1
      },
      appTypes: [
        { item: 1, text_en: 'Cip Applications', text_bn: 'সিআইপি অ্যাপ্লিকেশন' },
        { item: 2, text_en: 'Cip Trades', text_bn: 'সিআইপি ট্রেডস' }
      ]
    }
  },
  computed: {
    appTypeList: function () {
      return this.appTypes.map(item => {
        return Object.assign({}, item, { name: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    }
  },
  watch: {
    'search.app_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (parseInt(newVal) === 1) {
          this.comp = 'CipApplicants'
        } else {
          this.comp = 'CipTrades'
        }
      }
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
    searchData () {
      if (this.search.app_type === 1) {
        this.$refs.CipApplicants.applicantSearch(this.search)
      } else {
        this.$refs.CipTrades.tradesSearch(this.search)
      }
    }
  }
}
</script>
