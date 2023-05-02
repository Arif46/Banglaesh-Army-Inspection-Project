
<template>
  <b-container fluid>
    <div class="inner-section">
      <card>
        <template v-slot:body>
          <div class="text-dark">
            <b> <i class="fa fa-calendar" aria-hidden="true"></i> {{ note.created_at | dateFormat }} <br></b>
            <hr>
            {{ note.note }}
          </div>
        </template>
      </card>
    </div>
  </b-container>
</template>
<script>
// import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
  props: ['item'],
  components: {
  },
  data () {
    return {
      note: ''
    }
  },
  created () {
    this.note = this.item
  }
}
</script>
