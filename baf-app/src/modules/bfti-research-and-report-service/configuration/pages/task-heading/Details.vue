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
                          <b-table-simple striped bordered small hover>
                              <thead class="text-white bg-primary">
                              <tr>
                                  <th class="text-center" width="10%">{{ $t('globalTrans.sl_no') }}</th>
                                  <th scope="col" style="width:70%">{{ $t('configuration.task_heading') }}</th>
                              </tr>
                          </thead>
                                <b-tbody>
                                <b-tr v-for="(item, index) in heading.details" :key="index">
                                  <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                  <b-td>{{ currentLocale == 'bn' ? item.task_heading_bn : item.task_heading_en }}</b-td>
                              </b-tr>
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
      heading: {}
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getDetailsData()
      this.heading = tmp
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
