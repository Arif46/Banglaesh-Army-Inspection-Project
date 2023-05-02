<template>
  <b-row>
   <b-row>
        <b-col lg="12" sm="12">
          <iq-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-overlay :show="loading">
                      <b-row>
                        <b-col lg="12" sm="12">
                          <div>
                             <b-table-simple striped bordered small hover>
                                <tbody>
                                    <b-tr>
                                        <b-td width="2%">{{ $t('configuration.document_type') }}</b-td>
                                        <b-td width="6%" colspan="3">{{ currentLocale == 'bn' ? heading.document_type_bn : heading.document_type_en }}</b-td>
                                    </b-tr>
                                </tbody>
                            </b-table-simple>
                           <b-table-simple bordered hover small v-for="(item, index) in heading.task_sub_heading_details" :key="index">
                              <b-tbody>
                                  <tr>
                                      <b-th colspan="2" class="text-left" style="background: #e3e3e3">{{ $n(index + 1) + '. ' + getTaskHeading(item.task_heading_id) }}</b-th>
                                  </tr>
                                  <!-- <tr>
                                      <b-th colspan="2" class="text-center">{{ $t('configuration.task_sub_heading') }}</b-th>
                                  </tr> -->
                                  <tr v-for="(detail, inx) in item.details" :key="inx">
                                      <b-td class="text-center" style="width: 10%">{{ '(' + $n(inx + 1) + ')' }}</b-td>
                                      <b-td class="text-left" style="width: 85%">{{ $i18n.locale === 'en' ? detail.task_sub_heading_en : detail.task_sub_heading_bn }}</b-td>
                                  </tr>
                              </b-tbody>
                          </b-table-simple>
                          </div>
                        </b-col>
                      </b-row>
                    </b-overlay>
                  </b-col>
              </b-row>
            </template>
          </iq-card>
        </b-col>
      </b-row>
  </b-row>
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
      heading: []
    }
  },
    computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDetailsData()
      this.heading = tmp
      const newArray = []
      const headingDetails = tmp.task_sub_heading_details
      if (headingDetails.length > 0) {
        headingDetails.map(item => {
          const filterData = tmp.task_sub_heading_details.filter(el => el.task_heading_id === item.task_heading_id)
          const myObj = {
            task_heading_id: item.task_heading_id,
            details: filterData
        }
          const checkExits = newArray.find(itm => itm.task_heading_id === myObj.task_heading_id)
          if (typeof checkExits === 'undefined') {
            newArray.push(myObj)
          }
        })
        this.heading.task_sub_heading_details = []
        this.heading.task_sub_heading_details = newArray
      }
    }
  },
  methods: {
      getTaskHeading (id) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.taskHeadingList.find(orgCat => orgCat.value === id)
      return data !== 'undefined' ? data.text : ''
    },
    getDetailsData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
