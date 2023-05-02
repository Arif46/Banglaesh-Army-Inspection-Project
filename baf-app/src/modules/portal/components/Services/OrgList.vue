<template>
    <b-list-group>
        <b-list-group-item :class="(searchData.org_id === org.id) ? `active` : ``" @click="getServiceList(org.id)" v-for="(org, index) in orgList" :key="index" href="javascript:">
            <div class="item">
                <img v-if="org.logo" width="20px" :src="commonServiceBaseUrl + 'storage' + org.logo" alt=""/>
                <img v-else width="20px" src="@/assets/images/logo.png" alt=""/>
                <p>{{ checkBn ? org.abbreviation_bn : org.abbreviation }}</p>
            </div>
            <b-badge class="portal-primary" pill>{{ $n(org.service_count) }}</b-badge>
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
    orgList () {
      return this.$store.state.Portal.orgList.filter(item => item.status === 1)
    },
    searchData () {
      return this.$store.state.Portal.searchData
    }
  },
  methods: {
    async loadData () {
      this.$Progress.start()
      this.$store.dispatch('Portal/mutatePortalLoad', true)
      const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/org-list')
      this.$store.dispatch('Portal/mutatePortalLoad', false)
      if (result.success) {
        this.$Progress.finish()
        this.$store.dispatch('Portal/mutateOrgList', result.data)
      } else {
        this.$Progress.fail()
      }
    },
    getServiceList (id) {
      const search = {
        org_id: id,
        customer_type_id: 0,
        service_category_id: 0
      }
      this.$store.dispatch('Portal/mutateSearch', search)
    }
  }
}
</script>
