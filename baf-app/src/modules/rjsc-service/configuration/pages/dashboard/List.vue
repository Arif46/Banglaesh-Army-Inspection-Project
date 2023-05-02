<template>
  <div class="section-wrapper">
      <card>
        <template v-slot:searchBody>
          <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" offset="1">
              <p>Welcome to RJSC Dashboard</p>
            </b-col>
          </b-row>
        </template>
      </card>
  </div>
</template>
<script>
// import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
// import { cipDashboardList } from '../../api/routes'

export default {
  data () {
    return {
    }
  }
}
</script>

<style>
  .mc-report-card {
    position: relative;
    margin-bottom: 10px;
    border-radius: var(--border-radius-md);
  }
  .icon-wrapper {
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translate(0, -50%);
    color: rgba(255, 255, 255, .3);
    font-size: 3.6rem;
  }
</style>
