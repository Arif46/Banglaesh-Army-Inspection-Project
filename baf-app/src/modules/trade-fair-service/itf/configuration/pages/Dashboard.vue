<template>
  <div class="section-wrapper">
    <breadcumb />
    <b-overlay :show="loading">
      <div class="form-wrapper bms-db-wrapper">
        <b-row>
          <b-col sm="3">
          </b-col>
          <b-col sm="3">
          </b-col>
          <b-col sm="3">
          </b-col>
          <b-col sm="3">
          </b-col>
        </b-row>
      </div>
    </b-overlay>
  </div>
</template>
<script>

export default {
  data () {
    return {
      dashboardData: {
      },
      loading: false
    }
  },
  computed: {
  },
  created () {
  },
  methods: {
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
  .bar-chart-wrapper {
    padding: 15px 0;
  }
  /* .bar-chart-wrapper svg path {
    fill: #77a0cb;
  } */
</style>
