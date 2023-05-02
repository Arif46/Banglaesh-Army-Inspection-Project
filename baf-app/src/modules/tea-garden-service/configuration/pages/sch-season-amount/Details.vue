<template>
    <div class="section-wrapper">
        <breadcumb />
        <b-overlay :show="loadingState">
        <div class="form-wrapper tea-garden-school-wrapper">
            <div class="header-title-wrapper">
                <h6 class="mb-0">{{ $t('teaGardenConfig.scholarship_season_amount') }}</h6>
                <router-link :to="{ name: 'tea_garden_service.configuration.sch-season-amount' }" class="mr-2 btn btn-light btn-sm"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</router-link>
            </div>
            <b-row>
                <b-col sm="12">
                    <b-card class="tea-school-card">
                        <b-card-text style="padding: 0 1.2rem;">
                            <b-row>
                                <b-col sm="12" md="6" lg="6">
                                    <table class="table table-bordered mt-2">
                                        <tbody>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.year') }}</th>
                                                <td>
                                                    <span v-if="formData.year">
                                                        {{ EngBangNum(formData.year.toString())  }}
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.trust_type') }}</th>
                                                <td>{{ getTrustTypeName(formData.trust_type) }}</td>
                                            </tr>
                                            <tr>
                                                <th scope="col">{{ $t('teaGardenConfig.remarks') }}</th>
                                                <td>
                                                    <span v-if="$i18n.locale === 'bn'">
                                                    {{ formData.remarks_bn }}
                                                    </span>
                                                    <span v-else>
                                                    {{ formData.remarks_en }}
                                                    </span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </b-col>
                               <b-col sm="12" md="6" lg="6">
                                <table class="table table-bordered mt-2">
                                    <thead>
                                        <tr>
                                            <th>{{ $t('teaGardenConfig.class') }}</th>
                                            <th v-if="formData.trust_type === 1">{{ $t('teaGardenConfig.amount') }}</th>
                                            <th v-if="formData.trust_type === 2">{{ $t('teaGardenConfig.amount_gpa5') }}</th>
                                            <th v-if="formData.trust_type === 2">{{ $t('teaGardenConfig.amount_below_gpa5') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(item, index) in formData.details" :key="index">
                                            <td scope="col" class="text-center">{{ getClassName(item.class_id) }}</td>
                                            <td class="text-center">
                                                <span v-if="item.amount">
                                                    {{ $n(item.amount)  }}
                                                </span>
                                            </td>
                                            <td class="text-center" v-if="formData.trust_type === 2">
                                                <span v-if="item.below_gpa5_amount">
                                                    {{ $n(item.below_gpa5_amount)  }}
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                </b-col>
                            </b-row>
                        </b-card-text>
                    </b-card>
                </b-col>
            </b-row>
        </div>
        </b-overlay>
    </div>
</template>
<script>
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    import { schSeasonAmountView } from '../../api/routes'
    export default {
      name: 'Details',
      data () {
        return {
            formData: {
                id: '',
                year: 0,
                trust_type: 0,
                remarks_en: '',
                remarks_bn: '',
                details: [
                {
                    id: '',
                    sch_session_main_id: 0,
                    class_id: '',
                    amount: '',
                    below_gpa5_amount: ''
                }
                ]
          },
          loadingState: false
        }
      },
      created () {
        if (this.$route.query.id) {
          this.loadingState = true
          this.getData(this.$route.query.id)
        }
      },
      computed: {
         currentLocale () {
           return this.$i18n.locale
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
        async getData (id) {
        let result = null
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${schSeasonAmountView}/${id}`)
        this.formData = result.data
        this.loadingState = false
        },
        getTrustTypeName (id) {
          const trustType = this.$store.state.TeaGardenService.commonObj.trustType.find(item => item.value === id)
          if (trustType && this.$i18n.locale === 'bn') {
              return trustType.text_bn
          } else if (trustType && this.$i18n.locale === 'en') {
              return trustType.text_en
          }
        },
        getClassName (id) {
            const trustTypeInfo = this.$store.state.TeaGardenService.commonObj.masterTrustTypeList.find(item => item.value === id)
            if (trustTypeInfo && this.$i18n.locale === 'bn') {
                return trustTypeInfo.text_bn
            } else if (trustTypeInfo && this.$i18n.locale === 'en') {
                return trustTypeInfo.text_en
            }
        }
      }
    }
    </script>
