<template>
    <div class="home-component-wrapper">
        <div class="component-wrapper" style="margin: 0;padding-top: 30px;">
            <b-overlay :show="loading">
                <b-container fluid>
                    <b-row>
                        <b-col sm="4" class="panel-item" v-for="(panel, index) in panels" :key="index">
                            <b-card class="mc-db-card">
                                <div class="d-flex justify-content-start align-items-center" @click="setPanelMenus(panel.id)">
                                    <img class="mr-3" :src="require(`../../../assets/icons/external-panel/dashboard-icons/${panel.id}.svg`)" width="52" alt="">
                                    <h5>{{ lang === 'bn' ? panel.name_bn : panel.name }}</h5>
                                </div>
                            </b-card>
                        </b-col>
                    </b-row>
                </b-container>
            </b-overlay>
        </div>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
import { EventBus } from '@/EventBusLayout'

export default {
  data () {
    return {
        loading: false,
        tmpServiceUrl: ''
    }
  },
  created () {
      window.scrollTo(0, 0)
    // load external panel list
    if (this.panels.length === 0) {
        this.loadPanels()
    }
  },
  computed: {
    lang: function () {
        return this.$i18n.locale
    },
    ...mapGetters({
        authUser: 'Auth/authUser',
        panels: 'ExternalUserService/externalPanels',
        commonProfile: 'Auth/commonProfile'
    })
  },
  methods: {
    async setUserLastPanel (panelId) {
      const formData = {
        user_id: this.authUser.user_id,
        last_panel: panelId
      }
      const result = await RestApi.postData(authServiceBaseUrl, 'user-management/external-user/set-last-panel', formData)
      if (result.success) {
        return true
      }
    },
    async loadPanels () {
        this.loading = true
        const result = await RestApi.getData(commonServiceBaseUrl, 'external/external-panel/get-all')
        if (result.success) {
          this.$store.dispatch('ExternalUserService/setExternalPanels', result.data.filter(item => item.status === 1))
        } else {
          this.$store.dispatch('ExternalUserService/setExternalPanels', [])
        }
        this.loading = false
    },
    setPanelMenus (panelId) {
        this.loading = true
        if (!this.commonProfile) {
            this.$toast.error({
                title: this.$i18n.locale === 'en' ? 'Permission Denied..!' : 'অনুমতি অস্বীকার করা হয়েছে..!',
                message: this.$i18n.locale === 'en' ? 'Please, Update your profile.' : 'অনুগ্রহপূর্বক, আপনার প্রোফাইল হালনাগাদ করুন।',
                color: 'red'
            })
            this.loading = false
        } else {
            this.setUserLastPanel(panelId)
            EventBus.$emit('LOAD_EXTERNAL_MENUS', panelId)
        }
    }
  }
}
</script>
<style scoped>
    .ext-dash-wrapper {
        padding-top: 30px;
    }
    .ext-dash-wrapper .panel-item .card {
        border: none;
        border-radius: 10px;
        box-shadow: rgba(99, 99, 99, 0.5) 0px 2px 8px 0px;
        cursor: pointer;
        transition: all .5s ease;
    }
    .ext-dash-wrapper .panel-item .card:hover {
        box-shadow: rgb(0 0 0 / 25%) 0px 14px 28px, rgb(0 0 0 / 22%) 0px 10px 10px;
    }
    .ext-dash-wrapper .panel-item .card:hover  .panel-icon {
        transform: rotate(-20deg);
    }
    /* .ext-dash-wrapper .panel-item:nth-child(1) .card {
        background: linear-gradient(180deg, rgba(114,96,237,1) 30%, rgba(53,33,190,1) 100%);
    }
    .ext-dash-wrapper .panel-item:nth-child(2) .card {
        background: linear-gradient(180deg, rgba(87,206,102,1) 30%, rgba(31,143,46,1) 100%);
    }
    .ext-dash-wrapper .panel-item:nth-child(3) .card {
        background: linear-gradient(180deg, rgba(0,158,250,1) 30%, rgba(9,93,142,1) 100%);
    } */
    .ext-dash-wrapper .panel-item:nth-child(even) .card {
        background: linear-gradient(180deg, rgba(114,96,237,1) 30%, rgba(53,33,190,1) 100%);
    }
    .ext-dash-wrapper .panel-item:nth-child(odd) .card {
        background: linear-gradient(180deg, rgba(87,206,102,1) 30%, rgba(31,143,46,1) 100%);
    }
    .ext-dash-wrapper .panel-item .item {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        color: var(--white);
    }
    .ext-dash-wrapper .panel-item .item .panel-icon {
        font-size: 49px;
        transition: all .5s ease;
    }
    .ext-dash-wrapper .panel-item .item .title {
        margin-bottom: 12px;
        font-weight: 300;
    }
</style>
