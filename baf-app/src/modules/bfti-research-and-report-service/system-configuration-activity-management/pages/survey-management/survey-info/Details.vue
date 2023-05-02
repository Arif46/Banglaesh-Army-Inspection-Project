<template>
  <div class="section-wrapper">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:550;"> {{ $t('survey_management.survey_information') }}</h5>
            </template>
            <template v-slot:body>
                <b-row>
                  <b-col lg="12" sm="12">
                   <table class="table table-borderless">
                     <tr>
                       <th style="width: 20%">  {{$t('survey_management.research_topic')}}</th>
                       <th style="width: 2%">:</th>
                       <td style="width: 78%"> {{currentLocale === 'bn'? item.topic_bn : item.topic}}</td>
                     </tr>
                     <tr>
                       <th style="width: 20%">  {{$t('survey_management.title')}}</th>
                       <th style="width: 2%">:</th>
                       <td style="width: 78%"> {{ ($i18n.locale === 'bn') ? item.title_bn : item.title }}</td>
                     </tr>
                     <tr>
                       <th style="width: 20%">  {{ $t('meeting_management.details')}}</th>
                       <th style="width: 2%">:</th>
                       <td style="width: 78%"> {{ ($i18n.locale === 'bn') ? item.detail_bn : item.detail }}</td>
                     </tr>
                     <tr>
                       <th style="width: 20%">  {{ $t('survey_management.start_date')}}</th>
                       <th style="width: 2%">:</th>
                       <td style="width: 78%"> {{item.start_date|dateFormat}}</td>
                     </tr>
                     <tr>
                       <th style="width: 20%">  {{ $t('survey_management.end_date')}}</th>
                       <th style="width: 2%">:</th>
                       <td style="width: 78%"> {{item.end_date|dateFormat}}</td>
                     </tr>
                    </table>
                  </b-col>
              </b-row>
            </template>
          </body-card>
        </b-col>
      </b-row>
  </div>
</template>
<script>
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      valid: null,
      loading: false,
      errors: [],
      detailsData: [],
      detailsItemId: '',
      item: {}
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDetailsData()
      this.item = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getDetailsData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
