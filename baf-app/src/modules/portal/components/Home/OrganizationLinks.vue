<template>
    <div class="portal">
        <b-card class="imp-link-card">
            <template #header>
                <div class="d-flex card-title-wrapper">
                    <h6 class="mb-0 ml-2">{{ $t('portal.important_links') }}</h6>
                </div>
            </template>
            <div class="organization-links">
                <b-tabs justified>
                    <b-tab :title="$t('portal.org_link')" active>
                        <OrgLoader v-if="loading"></OrgLoader>
                        <b-list-group v-else>
                            <b-list-group-item v-for="(org, index) in orgList" :key="index" class="justify-content-start">
                                <a :href="`http://` + org.website_url" class="d-flex align-items-center text-dark" target="_blank">
                                    <img v-if="org.logo" :src="commonServiceBaseUrl + 'storage' + org.logo" width="20" height="20" class="mr-2" alt="Org. Logo">
                                    <img v-else src="../../../../assets/images/logo.png" width="20" height="20" class="mr-2" alt="Org. Logo">
                                    <p>{{ $i18n.locale === 'bn' ? org.org_name_bn : org.org_name }}</p>
                                </a>
                            </b-list-group-item>
                        </b-list-group>
                    </b-tab>
                    <b-tab :title="$t('portal.useful_link')">
                        <b-list-group>
                            <b-list-group-item target="_blank" href="https://jds-scholarship.org/" class="d-flex justify-content-start align-items-center">
                                <!-- <img src="../../../../assets/images/logo.png" width="20" class="mr-2" alt=""> -->
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'জে.ডি.এস প্রোগ্রাম': 'JDS Program' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="http://www.bangladeshcustoms.gov.bd/" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'বাংলাদেশ কাস্টমস': 'Bangladesh Customs' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="https://mopa.gov.bd/" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'জনপ্রশাসন মন্ত্রণালয়': 'Ministry of Public Administration' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="http://www.pmo.gov.bd/" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'প্রধানমন্ত্রীর কার্যালয়': 'Prime Minister\'s Office' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="http://www.mincom.gov.bd/National%20Web%20Portal" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'রাষ্ট্রপতির কার্যালয়': 'President\'s Office (Bangabhaban)' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="http://www.bangladesh.gov.bd/" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'জাতীয় তথ্য বাতায়ন': 'National Web Portal' }}</p>
                            </b-list-group-item>
                            <b-list-group-item target="_blank" href="http://www.cabinet.gov.bd/" class="d-flex justify-content-start align-items-center">
                                <i class="ri-checkbox-multiple-fill"></i>
                                <p class="pl-1">{{ ($i18n.locale === 'bn') ? 'মন্ত্রিপরিষদ বিভাগ': 'Cabinet Division' }}</p>
                            </b-list-group-item>
                        </b-list-group>
                    </b-tab>
                </b-tabs>
            </div>
        </b-card>
    </div>
</template>
<script>
import { commonServiceBaseUrl } from '@/config/api_config'
import OrgLoader from './loading/org_loader'
export default {
    name: 'OrganizationLinks',
    components: { OrgLoader },
    data () {
        return {
            loading: true,
            commonServiceBaseUrl: commonServiceBaseUrl,
            orgList: []
        }
    },
    computed: {
        orgListAll () {
            return this.$store.state.Portal.serviceData.orgList
        }
    },
    watch: {
        orgListAll: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.setOrgList(newVal)
            }
        }
    },
    methods: {
        setOrgList (orgList) {
            if (orgList !== undefined && orgList.length > 0) {
                this.orgList = orgList.filter(item => item.status === 1)
                this.loading = false
                return
            }
            this.orgList = []
            this.loading = false
        }
    }
}
</script>
<style>
.imp-link-card .card-body{
    padding: 0!important;
}
.organization-links::-webkit-scrollbar{
    width: 3px;
}
.organization-links{
    height: 280px;
    overflow-y: auto;
    margin-bottom: 8px;
}
.organization-links .tabs{
    overflow-x: hidden;
    border: none;
}
.organization-links .nav-tabs{
    background-color: var(--portal-secondary);
}
.organization-links .tabs .tab-content{
    padding: 10px 0 0 0;
}
.organization-links .nav-link{
    border-radius: 0;
}
.organization-links .tabs .tab-content .list-group .list-group-item{
    border: none;
    border-bottom: 1px solid #bbb;
    transition: 0.5s all;
}
.organization-links .tabs .tab-content .list-group .list-group-item:hover{
    color: var(--portal-secondary);
}
</style>
