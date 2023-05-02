<template>
    <b-row>
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-row>
                      <b-col lg="12" sm="12">
                        <div>
                          <b-table-simple hover small>
                            <b-tr>
                              <b-th style="width:20%">{{ $t('rjscAdminPortal.question') }}</b-th>
                              <b-td style="width:80%">{{ ($i18n.locale=='bn') ? form.title_bn : form.title_en }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th style="width:20%">{{ $t('globalTrans.details') }}</b-th>
                              <b-td v-if="$i18n.locale=='en'" style="width:80%">
                                <p v-html="form.details_en"></p>
                              </b-td>
                              <b-td v-else style="width:80%">
                                <p v-html="form.details_bn"></p>
                              </b-td>
                            </b-tr>
                          </b-table-simple>
                        </div>
                      </b-col>
                    </b-row>
                  </b-col>
              </b-row>
            </template>
          </body-card>
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
      form: []
      }
    },
    created () {
    if (this.id) {
      const tmp = this.getPortInfo()
      this.form = tmp
    }
    },
    methods: {
    getPortInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
    }
}
</script>
