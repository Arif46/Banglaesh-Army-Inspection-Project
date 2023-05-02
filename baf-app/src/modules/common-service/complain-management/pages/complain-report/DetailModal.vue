<template>
  <b-row>
   <b-row>
        <b-col lg="12" sm="12">
          <iq-card>
            <template>
                <b-row>
                  <b-col lg="12" sm="12">
                    <b-row>
                      <b-col lg="12" sm="12">
                        <div>
                          <b-table-simple striped bordered small>
                            <b-tr>
                              <b-th style="width:15%">{{ $t('orgProfile.org_name') }}</b-th>
                              <b-td style="width:30%" colspan="3">{{ (this.$i18n.locale=='bn')? complain.org_name_bn : complain.org_name }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('menu.service') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.service_bn : complain.service_en }}</b-td>
                              <b-th>{{ $t('complain_management.complain_title') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.com_title_bn : complain.com_title }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('orgProfile.division') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.division_bn : complain.division_en }}</b-td>
                              <b-th>{{ $t('orgProfile.district') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.district_bn : complain.division_en }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('orgProfile.upazila') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.upazila_bn : complain.upazila_en }}</b-td>
                              <b-th>{{ $t('orgProfile.union') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? complain.union_bn : complain.union_en }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.mobile') }}</b-th>
                              <b-td>{{ complain.mobile_no | mobileNumber }}</b-td>
                              <b-th>{{ $t('globalTrans.email') }}</b-th>
                              <b-td>{{ complain.email }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.description') }}</b-th>
                              <b-td colspan="3">{{ (this.$i18n.locale=='bn')? complain.description_bn : complain.description }}</b-td>
                            </b-tr>
                          </b-table-simple>
                        </div>
                      </b-col>
                    </b-row>
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
      errors: [],
      notice: {
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getWardDetails()
      this.complain = tmp
    }
  },
  computed: {
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('orgProfile.ward_name'), class: 'text-center' },
          { label: this.$t('orgProfile.ward_name_bn'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'ward_name_bn' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'ward_name' }
        ]
      }

      return labels.map((item, index) => {
          return Object.assign(item, keys[index])
      })
    }
  },
  methods: {
    getWardDetails () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
