<template>
    <div class="uvsportlight clearfix" style="width: 100%; margin-top:-7px">
        <div class="uv-shape">
            <div class="ribbon">
                <div :class="$i18n.locale === 'bn' ? 'ribbon-title ribbon-title-bn' : 'ribbon-title ribbon-title-en'">{{ $t('portal.circular') }}: <span class="click-eye animated pulse">{{ $t('portal.circular_click') }}</span></div>
                <div class="ribbon-content">
                    <marquee
                        style="margin-top:10px"
                        behavior="scroll" direction="left"
                        onmouseover="this.stop();"
                        onmouseout="this.start();">
                        <ul class="navbar-nav bd-navbar-nav flex-row" v-if="notices.length > 0">
                            <li class="nav-item" v-for="(item, index) in notices" :key='index'>
                                {{ $i18n.locale === 'bn' ? item.title_bn : item.title_en }} - {{ item.notice_date | dateFormat }}
                            </li>
                        </ul>
                    </marquee>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Common from '@/mixins/portal/common'

export default {
  mixins: [Common],
  props: ['service'],
  data () {
    return {
        loading: false,
        notices: [],
        search: {}
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    async loadData () {
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/portal/dealer-license/recruitment-notice-list')
        if (result.success) {
            this.notices = result.data.data
        } else {
            this.notices = []
        }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    }
  }
}
</script>
