<template>
  <div class="section-wrapper bfti-dashboard-wrapper">
    <breadcumb />
    <div class="form-wrapper">
      <div class="mb-4 bg-white">
        <!-- <h5 class="title">{{ $t('externalUser.external_panel') }}</h5> -->
        <!-- <b-overlay :show="loading" class="px-3"> -->
          <div class="px-4 pb-2">
            <b-row>
              <h4>{{ $t('teaGardenPanel.panelTitle') }}</h4>
            </b-row>
          </div>
        <!-- </b-overlay> -->
      </div>
    </div>
  </div>
</template>
<script>
  import { mapGetters } from 'vuex'
  // import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  export default {
    data () {
      return {
        form: {
        employee_user_id: 0
        },
        loading: false
      }
    },
    mounted () {
    this.form.employee_user_id = this.$store.state.Auth.authUser.user_id
    this.loadData()
  },
    computed: {
      ...mapGetters({
          authUser: 'Auth/authUser'
      })
    },
    methods: {
    edit (item) {
      this.editItemId = item.id
    },
    searchData () {
      this.form = []
      this.loadData()
    },
    mounted () {
    if (this.$store.state.Auth.activeRoleId !== 0) {
      this.form.employee_user_id = this.$store.state.Auth.authUser.user_id
    }
    this.loadData()
  },
    async loadData () {
      this.loading = true
    }
  }
  }
</script>
<style>
  .external-db-sec{
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
  }
  .external-db-sec .info-card{
    padding: 12px;
    color: #fff;
    border-radius: 8px;
    background: #5725cf;
  }
  .external-db-sec .icd-1{
    background: #5725cf;
  }
  .external-db-sec .icd-2{
    background: #27c7a9;
  }
  .external-db-sec .icd-3{
    background: #d34a34;
  }
  .external-db-sec .info-card .info-value{
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .external-db-sec .info-card .info-value .icon i{
    font-size: 30px;
  }
  .bfti-title{
    color: #fff;
    padding: 5px 10px;
    border-radius: 5px;
    margin-bottom: 1rem;
    background: #214162;
  }
  .bfti-title p{
    font-size: 18px;
  }
</style>
