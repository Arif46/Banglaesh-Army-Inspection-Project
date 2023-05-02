<template>
    <b-list-group>
        <b-list-group-item :class="(searchData.service_category_id === category.id) ? `active` : ``" @click="getServiceList(category.id)" v-for="(category, index) in categoryList" :key="index" href="javascript:">
            <div class="item">
                <img width="20px" :src="commonServiceBaseUrl + 'storage' + category.logo" alt=""/>
                <p>{{ checkBn ? category.name_bn : category.name }}</p>
            </div>
            <b-badge class="portal-primary" pill>{{ $n(category.service_count) }}</b-badge>
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
    categoryList () {
      return this.$store.state.Portal.categoryList.filter(item => item.status === 1)
    },
    searchData () {
      return this.$store.state.Portal.searchData
    }
  },
  methods: {
    async loadData () {
      this.$Progress.start()
      this.$store.dispatch('Portal/mutatePortalLoad', true)
      const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/category-list')
      this.$store.dispatch('Portal/mutatePortalLoad', false)
      if (result.success) {
        this.$Progress.finish()
        this.$store.dispatch('Portal/mutateCategoryList', result.data)
      } else {
        this.$Progress.fail()
      }
    },
    getServiceList (id) {
      const search = {
        org_id: 0,
        customer_type_id: 0,
        service_category_id: id
      }
      this.$store.dispatch('Portal/mutateSearch', search)
    }
  }
}
</script>
