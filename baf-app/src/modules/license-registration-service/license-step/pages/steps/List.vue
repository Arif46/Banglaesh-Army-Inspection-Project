<template>
  <b-container fluid>
    <ListDynamic v-if="dynamicList" :menuId="$route.params.id"/>
  </b-container>
</template>
<script>
import ListDynamic from './ListDynamic'
export default {
  components: {
    ListDynamic
  },
  data () {
    return {
      labAssign: false,
      dynamicList: false
    }
  },
  created () {
    if (this.menuInfoList.step_type === 'static') {
      this.menuInfoList.static_url = true
      this.dynamicList = false
    } else {
      this.dynamicList = true
    }
  },
  computed: {
    formTitle () {
       return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
    },
    menuInfoList () {
      const menuId = this.$route.params.id
      return this.$store.state.LicenseRegistrationService.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    }
  }
}
</script>
