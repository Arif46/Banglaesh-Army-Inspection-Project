<template>
    <div>
      <b-card>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.circular') }} </b> : {{ currentLocale === 'bn' ? detailsData.circular.title_bn : detailsData.circular.title_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('exportTrophyConfig.cip_sector')}} </b> : {{ currentLocale === 'bn' ? detailsData.sector_bn : detailsData.sector_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.year')}} </b> : {{ $n(detailsData.year, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.name')}} </b> : {{ currentLocale === 'bn' ? detailsData.name_bn : detailsData.name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.father_name') }}</b> : {{ currentLocale === 'bn' ? detailsData.father_name_bn : detailsData.father_name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.designation')}} </b> : {{ currentLocale === 'bn' ? detailsData.fbcci_designation_bn : detailsData.fbcci_designation_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.mobile') }}</b> : {{ EngBangNum(detailsData.mobile.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.phone_no') }}</b> : {{ EngBangNum(detailsData.phone.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.email') }}</b> : {{ detailsData.email }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.web') }}</b> : {{ detailsData.website }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.fax') }}</b> : {{ EngBangNum(detailsData.fax.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('externalUser.bin_no') }}</b> : {{ EngBangNum(detailsData.bin_no.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('externalUser.tin_no') }}</b> : {{ EngBangNum(detailsData.tin_no.toString()) }}
            </b-col>
            <b-col sm="6" class="mt-2">
                <b> {{ currentLocale === 'bn' ? $t('cip.referred_association_bn') : $t('cip.referred_association_en') }} </b> : {{ currentLocale === 'bn' ? detailsData.referred_association_bn : detailsData.referred_association_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.address') }} </b> : {{ currentLocale === 'bn' ? detailsData.address_bn : detailsData.address_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.org_address') }} </b> : {{ currentLocale === 'bn' ? detailsData.org_address_bn : detailsData.org_address_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.bb_comment') }} </b> : {{ detailsData.bb_comment }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.nbr_comment') }} </b> : {{ detailsData.nbr_comment }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.moha_sb_comment') }} </b> : {{ detailsData.moha_sb_comment }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('cip.moha_nsi_comment') }} </b> : {{ detailsData.moha_nsi_comment }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b>{{$t('globalTrans.attachment')}}</b>
              <span v-if="detailsData.attachment">
                <a target="_blank" :href="exportTrophyCIPServiceBaseUrl + 'download-attachment?file=' + detailsData.attachment" title="attachment" class="mr-3"> &nbsp; &nbsp;<i class="ri-download-cloud-fill"></i></a>
              </span>
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
  props: ['id'],
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
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    cipTradeRejectId () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
