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
                              <b-th style="width:20%">{{ $t('orgProfile.org_name') }}</b-th>
                              <b-td style="width:30%">{{ (this.$i18n.locale=='bn')? notice.org_name_bn : notice.org_name }}</b-td>
                              <b-th>{{ $t('notification.notification_type') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? notice.not_type_name_bn : notice.not_type_name }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('notification.notice_titlel') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? notice.notice_title_bn : notice.notice_title }}</b-td>
                              <b-th>{{ $t('notification.notice_for') }}</b-th>
                              <b-td>{{ notice.notice_for }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('notification.notice_descriptionl') }}</b-th>
                              <b-td colspan="3">{{ (this.$i18n.locale=='bn')? notice.description_bn : notice.description }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('organogram.designation') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? notice.designation_bn : notice.designation }}</b-td>
                              <b-th>{{ $t('organogram.office_name') }}</b-th>
                              <b-td>{{ (this.$i18n.locale=='bn')? notice.office_name_bn : notice.office_name }}</b-td>
                            </b-tr>
                            <b-tr>
                              <b-th>{{ $t('globalTrans.date') }}</b-th>
                              <b-td>{{ notice.notice_date | dateFormat }}</b-td>
                              <b-th>{{ $t('globalTrans.time') }}</b-th>
                              <b-td>{{ notice.notice_time }}</b-td>
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
      this.notice = tmp
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
