<template>
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenBtriService.payment_for') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-overlay :show="loading"></b-overlay>
      </template>
      </card>
  </template>
  <script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { PaymentCancel } from '../../../api/routes'
  import teaGardenService from '@/mixins/tea-garden-service'
  export default {
    mixins: [teaGardenService],
    name: 'Form',
    props: ['item'],
      components: {},
    data () {
      return {
        valid: null,
        saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        circularLoading: false,
        data: {},
        isGardenAdmin: false,
        loading: false
      }
    },
    created () {
      if (this.$route.query.transId) {
        this.loading = true
        const tmp = this.getData(this.$route.query.transId)
        this.data = tmp
      }
    },
    computed: {
      currentLocale () {
          return this.$i18n.locale
      }
    },
    methods: {
      async getData (transId) {
          let result = null
          result = await RestApi.getData(teaGardenServiceBaseUrl, PaymentCancel, { transId: transId })
          if (result.success) {
              this.$toast.success({
                title: 'Success',
                message: this.$t('teaGardenBtriService.payment_cencel')
              })
            }
          //  route name get
          const data = result
          var routeName = ''
          if (this.$store.state.Auth.authUser.user_type === 2) {
            if (data.service_id === 1) {
              routeName = 'tea_garden_panel.tea_garden_application'
            } else if (data.service_id === 3) {
              routeName = 'tea_garden_panel.tea_farmer_application'
            } else if (data.service_id === 4) {
              routeName = 'tea_garden_panel.tea_factory_application'
            }
          } else {
            if (data.service_id === 1) {
              routeName = 'tea_garden_service.btb.tea_garden_application'
            } else if (data.service_id === 2) {
              routeName = 'tea_garden_service.btb.tree_disposal_registration'
            } else if (data.service_id === 3) {
              routeName = 'tea_garden_service.btb.received_application'
            } else if (data.service_id === 4) {
              routeName = 'tea_garden_service.btb.tea_factory_application'
            }
          }
          this.$router.push({ name: routeName })
          this.data = result.data
          this.loading = false
      }
    },
    watch: {
      currentLocale: function () { }
    }
  }
  </script>
  <style scoped>
    .p_heading{
      font-weight: bold;
    }
  </style>
