<template>
    <div>
        <slot v-if="this.$route.params.service_id === '1'">
            <tea-garden-application-view></tea-garden-application-view>
        </slot>
        <slot v-else-if="this.$route.params.service_id === '2'">
            <TreeDisposalNocView></TreeDisposalNocView>
        </slot>
        <slot v-else-if="this.$route.params.service_id === '3'">
            <small-tea-farmer-application-view></small-tea-farmer-application-view>
        </slot>
        <slot v-else-if="this.$route.params.service_id === '4'">
            <tea-factory-details></tea-factory-details>
        </slot>
    </div>
</template>
<script>
import SmallTeaFarmerApplicationView from './SmallTeaFarmer/Details.vue'
import TeaGardenApplicationView from './TeaGarden/Details.vue'
import TreeDisposalNocView from './TreeDisposalNoc/Details.vue'
import TeaFactoryDetails from './TeaFactory/Details.vue'
export default {
  name: 'ApplicationDetails',
  components: {
    SmallTeaFarmerApplicationView, TeaGardenApplicationView, TreeDisposalNocView, TeaFactoryDetails
  },
  data () {
    return {
    }
  },
  computed: {
    appId () {
      return this.$route.params.id
    }
  }
}
</script>
