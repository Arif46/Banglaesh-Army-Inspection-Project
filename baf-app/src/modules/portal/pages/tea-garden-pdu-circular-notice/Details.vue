<template>
  <card>
      <body-card style="margin: 0;border: none;">
          <template v-slot:headerTitle>
              <h4 class="card-title">{{ $t('teaGardenBtriService.details') }}</h4>
          </template>
          <template v-slot:body>
              <b-tabs content-class="mt-0" fill class="col-8 offset-2">
                <div v-if="loading">
                    <Loading />
                </div>
                <b-overlay v-else>
                    <div class="text-right">
                        <b-button @click="print" variant="primary" class="btn btn-sm mb-2">
                            <i class="ri-printer-line"></i> {{ $t('globalTrans.print') }}
                        </b-button>
                    </div>
                    <div class="p-3" :class="currentLocale === 'en' ? 'font-en' : 'font-bn'" id="printMe">
                    <div class="mb-4" style="display: flex; flex-wrap: wrap;">
                        <div class="" style="width:50%"><b>{{ $t('teaGardenPduService.circular_name') }}</b> : {{ currentLocale === 'en' ?
                            data.circular_title_en : data.circular_title_bn }}</div>
                        <div class="text-right" style="width:50%"><b>{{ $t('teaGardenPduService.application_deadline') }}</b> : {{
                            data.application_deadline | dateFormat }}</div>
                        </div>
                        <div v-html="currentLocale === 'en' ? data.description_en : data.description_bn" class="editor-content">
                        </div>
                    </div>
                    <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
                </b-overlay>
              </b-tabs>
          </template>
      </body-card>
  </card>
</template>
<script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import Loading from './loading/Details.vue'
  import { circularShow } from '../../api/routes'
  import Vue from 'vue'
  import VueHtmlToPaper from 'vue-html-to-paper'
  Vue.use(VueHtmlToPaper)
  export default {
      name: 'Details',
      components: {
          Loading
      },
      data () {
          return {
              teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
              data: {
                  id: 0,
                  service_id: 0
              },
              pageStyle: {
                  styles: [
                      'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
                      `${teaGardenServiceBaseUrl}/custom.css`
                  ]
              }
          }
      },
      created () {
          this.getAppDetail()
      },
      computed: {
          appId () {
              return this.$route.params.id
          },
          currentLocale () {
              return this.$i18n.locale
          },
          loading () {
              return this.$store.state.commonObj.loading
          }
      },
      methods: {
          print () {
              this.$htmlToPaper('printMe', this.pageStyle)
          },
          back () {
              this.$router.go(-1)
          },
          async getAppDetail () {
              this.$store.dispatch('mutateCommonProperties', { loading: true })
              const result = await RestApi.getData(teaGardenServiceBaseUrl, `${circularShow}/${this.appId}`)
              if (result.success) {
                  this.data = result.data
              }
              this.$store.dispatch('mutateCommonProperties', { loading: false })
          },
          isImage (path) {
              return /\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(path)
          }
      }
  }
</script>
<style>
</style>
