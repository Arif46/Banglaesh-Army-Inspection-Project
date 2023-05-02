<template>
    <b-list-group>
        <b-list-group-item :class="(searchData.customer_type_id === customer.id) ? `active` : ``" @click="getServiceList(customer.id)" v-for="(customer, index) in customerTypeList" :key="index" href="javascript:">
            <div class="item">
                <img width="20px" :src="commonServiceBaseUrl + 'storage' + customer.image" alt=""/>
                <p>{{ checkBn ? customer.name_bn : customer.name }}</p>
            </div>
            <b-badge class="portal-primary" pill>{{ $n(customer.service_count) }}</b-badge>
        </b-list-group-item>
    </b-list-group>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
  created () {
    this.loadData()
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl
    }
  },
  computed: {
    checkBn () {
        return (this.$i18n.locale === 'bn') ? 1 : 0
    },
    customerTypeList () {
      return this.$store.state.Portal.customerTypeList.filter(item => item.status === 1)
    },
    searchData () {
      return this.$store.state.Portal.searchData
    }
  },
  methods: {
    async loadData () {
      this.$Progress.start()
      this.$store.dispatch('Portal/mutatePortalLoad', true)
      const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/customer-type-list')
      this.$store.dispatch('Portal/mutatePortalLoad', false)
      if (result.success) {
        this.$Progress.finish()
        this.$store.dispatch('Portal/mutateCustomerTypeList', result.data)
      } else {
        this.$Progress.fail()
      }
    },
    getServiceList (id) {
      const search = {
        org_id: 0,
        customer_type_id: id,
        service_category_id: 0
      }
      this.$store.dispatch('Portal/mutateSearch', search)
    }
  }
}
</script>
