<template>
    <div class="bfti-dashboard-wrapper">
        <breadcumb />
        <!-- <b-row>
            <b-col sm="12">
                <h4 class="bg-primary text-white text-center p-1 mt-2">{{ $t('externalUser.dashboard') }}</h4>
            </b-col>
        </b-row> -->
        <!-- <b-row class="mt-20">
           <b-col sm="12">
                <div class="mc-report-card text-center">
                    <span class="p-3 border rounded"> {{ $t('externalUser.welcome')}} {{ currentLocale === 'bn' ? userData.name_bn : userData.name }}</span>
                </div>
                <div class="text-center mt-20" v-if="circularCount > 0">
                    <a href="javascript:" class="btn-add" @click="newCircular"> <i class="ri-arrow-right-line"></i> {{ $t('externalUser.new_circular') }}</a>
                </div>
                <div class="text-center" v-if="inviation.length > 0">
                    <p v-for="(invite, index) in inviation" :key="index">
                    <a href="javascript:" class="btn-add" @click="invitationCard(invite.invitation.award_type)"> <i class="ri-arrow-right-line"></i> {{ invite.invitation.award_type === 1 ? $t('externalUser.cip') : $t('externalUser.et') }} {{ $t('externalUser.invitation_card') }}</a>
                    </p>
                </div>
            </b-col>
        </b-row> -->
        <div class="mb-4">
            <h5 class="title">{{ $t('externalUser.cip') }}</h5>
            <b-overlay :show="cusLoading" class="px-3">
                <b-row>
                    <b-col sm="3">
                        <div class="card-item card-item-alt" style="background: #f0ae4f;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                                <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                                </path>
                            </svg>
                            <div class="doc text-left">
                                <h3 class="count" style="color: #214162;">{{ $n(cipEtDataCount.cip_total_pending, { useGrouping: false }) }}</h3>
                                <p style="color: #214162;">{{ $t('externalUser.app_pending')}}</p>
                            </div>
                            <div class="icon">
                                <i class="ri-sort-asc" style="color: #214162;"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="card-item card-item-alt" style="background: #f2351a;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                                <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                                </path>
                            </svg>
                            <div class="doc text-left">
                                <h3 class="count">{{ $n(cipEtDataCount.cip_total_rejected, { useGrouping: false }) }}</h3>
                                <p>{{ $t('externalUser.app_reject')}}</p>
                            </div>
                            <div class="icon">
                                <i class="ri-file-damage-line"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="card-item card-item-alt" style="background: #02acaf;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                                <path fill="rgb(255 255 255 / 80%)" fill-opacity="1"
                                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                                </path>
                            </svg>
                            <div class="doc text-left">
                                <h3 class="count">{{ $n(cipEtDataCount.cip_total_processing, { useGrouping: false }) }}</h3>
                                <p>{{ $t('externalUser.app_processing')}}</p>
                            </div>
                            <div class="icon">
                                <i class="ri-file-hwp-line"></i>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="card-item card-item-alt" style="background: #9c4fe8;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                                <path fill="rgb(255 255 255 / 60%)" fill-opacity="1"
                                    d="M0,32L48,26.7C96,21,192,11,288,16C384,21,480,43,576,96C672,149,768,235,864,234.7C960,235,1056,149,1152,122.7C1248,96,1344,128,1392,144L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z">
                                </path>
                            </svg>
                            <div class="doc text-left">
                                <h3 class="count">{{ $n(cipEtDataCount.cip_total_awarded, { useGrouping: false }) }}</h3>
                                <p>{{ $t('externalUser.app_awarded')}}</p>
                            </div>
                            <div class="icon">
                                <i class="ri-trophy-line"></i>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-overlay>
        </div>
        <div class="mb-4">
            <h5 class="title">{{ $t('externalUser.et') }}</h5>
            <b-overlay :show="cusLoading" class="px-3">
                <b-row>
                    <b-col sm="3" class="card-item-squ-col">
                        <div class="card-item-squ">
                            <div class="card-top">
                                <i class="ri-sort-asc"></i>
                                <p>{{ $t('externalUser.app_pending')}}</p>
                            </div>
                            <div class="card-bottom">
                                <h3>{{ $n(cipEtDataCount.et_total_pending, { useGrouping: false }) }}</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="card-item-squ-col">
                        <div class="card-item-squ">
                            <div class="card-top">
                                <i class="ri-file-damage-line"></i>
                                <p>{{ $t('externalUser.app_reject')}}</p>
                            </div>
                            <div class="card-bottom">
                                <h3>{{ $n(cipEtDataCount.et_total_rejected, { useGrouping: false }) }}</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="card-item-squ-col">
                        <div class="card-item-squ">
                            <div class="card-top">
                                <i class="ri-file-hwp-line"></i>
                                <p>{{ $t('externalUser.app_processing')}}</p>
                            </div>
                            <div class="card-bottom">
                                <h3>{{ $n(cipEtDataCount.et_total_processing, { useGrouping: false }) }}</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3" class="card-item-squ-col">
                        <div class="card-item-squ">
                            <div class="card-top">
                                <i class="ri-trophy-line"></i>
                                <p>{{ $t('externalUser.app_awarded')}}</p>
                            </div>
                            <div class="card-bottom">
                                <h3>{{ $n(cipEtDataCount.et_total_awarded, { useGrouping: false }) }}</h3>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-overlay>
        </div>
        <!-- <div>
            <b-overlay :show="cusLoading">
                <b-card title="">
                    <b-card-text>
                    <b-row>
                        <b-col sm="12" md="3">
                            <div class="mc-report-card p-3 bg-primary text-light">
                                <p>{{ $t('externalUser.cip')}} {{ $t('externalUser.app_pending')}}</p>
                                <h4>{{ $n(cipEtDataCount.cip_total_pending, { useGrouping: false }) }}</h4>
                                <div class="icon-wrapper">
                                <i class="ri-sort-asc"></i>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="12" md="3">
                            <div class="mc-report-card p-3 bg-danger text-light">
                                <p>{{ $t('externalUser.cip')}} {{ $t('externalUser.app_reject')}}</p>
                                <h4>{{ $n(cipEtDataCount.cip_total_rejected, { useGrouping: false }) }}</h4>
                                <div class="icon-wrapper">
                                <i class="ri-file-damage-line"></i>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="12" md="3">
                            <div class="mc-report-card p-3 bg-warning text-light">
                                <p>{{ $t('externalUser.cip')}} {{ $t('externalUser.app_processing')}}</p>
                                <h4>{{ $n(cipEtDataCount.cip_total_processing, { useGrouping: false }) }}</h4>
                                <div class="icon-wrapper">
                                <i class="ri-file-hwp-line"></i>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="12" md="3">
                            <div class="mc-report-card p-3 bg-success text-light">
                                <p>{{ $t('externalUser.cip')}} {{ $t('externalUser.app_awarded')}}</p>
                                <h4>{{ $n(cipEtDataCount.cip_total_awarded, { useGrouping: false }) }}</h4>
                                <div class="icon-wrapper">
                                <i class="ri-trophy-line"></i>
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                    <b-row class="mt-20">
                        <b-col sm="12" md="3">
                        <div class="mc-report-card p-3 bg-primary text-light">
                            <p>{{ $t('externalUser.et')}} {{ $t('externalUser.app_pending')}}</p>
                            <h4>{{ $n(cipEtDataCount.et_total_pending, { useGrouping: false }) }}</h4>
                            <div class="icon-wrapper">
                            <i class="ri-sort-asc"></i>
                            </div>
                        </div>
                        </b-col>
                        <b-col sm="12" md="3">
                        <div class="mc-report-card p-3 bg-danger text-light">
                            <p>{{ $t('externalUser.et')}} {{ $t('externalUser.app_reject')}}</p>
                            <h4>{{ $n(cipEtDataCount.et_total_rejected, { useGrouping: false }) }}</h4>
                            <div class="icon-wrapper">
                            <i class="ri-file-damage-line"></i>
                            </div>
                        </div>
                        </b-col>
                        <b-col sm="12" md="3">
                        <div class="mc-report-card p-3 bg-warning text-light">
                            <p>{{ $t('externalUser.et')}} {{ $t('externalUser.app_processing')}}</p>
                            <h4>{{ $n(cipEtDataCount.et_total_processing, { useGrouping: false }) }}</h4>
                            <div class="icon-wrapper">
                            <i class="ri-file-hwp-line"></i>
                            </div>
                        </div>
                        </b-col>
                        <b-col sm="12" md="3">
                        <div class="mc-report-card p-3 bg-success text-light">
                            <p>{{ $t('externalUser.et')}} {{ $t('externalUser.app_awarded')}}</p>
                            <h4>{{ $n(cipEtDataCount.et_total_awarded, { useGrouping: false }) }}</h4>
                            <div class="icon-wrapper">
                            <i class="ri-trophy-line"></i>
                            </div>
                        </div>
                        </b-col>
                    </b-row>
                    </b-card-text>
                </b-card>
            </b-overlay>
        </div> -->
    </div>
</template>
<script>
    import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
    import { getExternaldashboardApi } from '../api/routes'
    import { mapGetters } from 'vuex'
    export default {
        data () {
            return {
                baseUrl: exportTrophyCIPServiceBaseUrl,
                circularCount: 0,
                inviation: [],
                userData: {},
                search: {},
                cipEtDataCount: [],
                cusLoading: false
            }
        },
        created () {
            this.userData = this.$store.state.Auth.authUser
            this.search.user_id = this.$store.state.Auth.authUser.user_id
            this.getExternalPanelDashboard()
        },
        computed: {
            currentLocale () {
                return this.$i18n.locale
            },
            ...mapGetters({
                authUser: 'Auth/authUser'
            })
        },
        methods: {
            async newCircular () {
                this.cusLoading = true
                this.$router.push('/export-trophy-cip-panel/circular')
                this.cusLoading = false
            },
            invitationCard (value) {
                this.cusLoading = true
                if (value === 1) {
                    this.$router.push('/export-trophy-cip-panel/cip-award-invitation')
                } else {
                    this.$router.push('/export-trophy-cip-panel/export-trophy-award-invitation')
                }
                this.cusLoading = false
            },
            async getExternalPanelDashboard () {
                this.cusLoading = true
                const params = Object.assign({}, this.search)
                const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, getExternaldashboardApi, params)
                if (result.success) {
                    this.cipEtDataCount = result.data
                    this.circularCount = result.circular
                    this.inviation = result.inviation
                    this.cusLoading = false
                }
            }
        }
    }
</script>
<style scoped>
.bfti-dashboard-wrapper .card-item-squ-col .card-item-squ .card-top {
    padding: 0 10px 5px;
}
.bfti-dashboard-wrapper .card-item-squ-col .card-item-squ .card-top p {
    margin: -4px 0 0;
    font-size: inherit;
}
.bfti-dashboard-wrapper .card-item-squ-col .card-item-squ .card-bottom {
    padding: 10px 5px 0;
}
.bfti-dashboard-wrapper .card-item .icon i,
.bfti-dashboard-wrapper .card-item-squ-col .card-item-squ .card-top i {
    font-size: 2rem;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(1) .card-item-squ .card-top {
    color: #214162;
    background: #f0ae4f;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(1) .card-item-squ .card-top::before {
    border-top-color: #f0ae4f;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(2) .card-item-squ .card-top {
    background: #f2351a;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(2) .card-item-squ .card-top::before {
    border-top-color: #f2351a;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(3) .card-item-squ .card-top {
    color: #fff;
    background: #02acaf;
}
.bfti-dashboard-wrapper .card-item-squ-col:nth-child(3) .card-item-squ .card-top::before {
    border-top-color: #02acaf;
}
</style>
