<template>
    <div>
      <b-card>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.year')}} </b> : {{ $n(detailsData.year, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.name')}} </b> : {{ currentLocale === 'bn' ? detailsData.name_bn : detailsData.name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyConfig.cip_sector')}} </b> : {{ currentLocale === 'bn' ? detailsData.sector_bn : detailsData.sector_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.designation')}} </b> : {{ currentLocale === 'bn' ? detailsData.fbcci_designation_bn : detailsData.fbcci_designation_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
                <b> {{ currentLocale === 'bn' ? $t('cip.referred_association_bn') : $t('cip.referred_association_en') }} </b> : {{ currentLocale === 'bn' ? detailsData.referred_association_bn : detailsData.referred_association_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
            <b> {{ currentLocale === 'bn' ? $t('globalTrans.address_bn') : $t('globalTrans.address_en') }} </b> : {{ currentLocale === 'bn' ? detailsData.address_bn : detailsData.address_en }}
            </b-col>
        </b-row>
      </b-card>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['id', 'userDetails'],
  data () {
    return {
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      valid: null,
      detailsData: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.cipTradeRejectId()
      this.detailsData = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
        cipTradeRejectId () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        }
    }
}
</script>
