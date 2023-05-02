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
                        <ul class="navbar-nav bd-navbar-nav flex-row" v-if="circulars.length > 0">
                            <li class="nav-item" v-for="(item, index) in circulars" :key='index'>
                                {{ $i18n.locale === 'bn' ? item.subject_bn : item.subject_en }}
                            </li>
                        </ul>
                    </marquee>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Common from '@/mixins/portal/common'

export default {
  mixins: [Common],
  props: ['service'],
  data () {
    return {
        loading: false,
        circulars: []
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    async loadData () {
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, '/portal/itf-circular-exhibition-marque', null)
        if (result.success) {
            this.circulars = result.data
        } else {
            this.circulars = []
        }
    }
  }
}
</script>
