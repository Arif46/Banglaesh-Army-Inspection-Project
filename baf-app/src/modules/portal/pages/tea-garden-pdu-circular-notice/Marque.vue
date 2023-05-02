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
                        <ul class="navbar-nav bd-navbar-nav flex-row" v-if="circular_notice.length > 0">
                            <li class="nav-item" v-for="(item, index) in circular_notice" :key='index'>
                                {{ $i18n.locale === 'bn' ? item.circular_title_bn : item.circular_title_en }} - {{ item.application_deadline | dateFormat }}
                            </li>
                        </ul>
                    </marquee>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import Common from '@/mixins/portal/common'
import { circularApprovedList } from '../../api/routes'
export default {
  mixins: [Common],
  props: ['service'],
  data () {
    return {
        loading: false,
        circular_notice: [],
        search: {}
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    async loadData () {
        const result = await RestApi.getData(teaGardenServiceBaseUrl, circularApprovedList)
        if (result.success) {
            this.circular_notice = result.data.data
        } else {
            this.circular_notice = []
        }
    }
  }
}
</script>
