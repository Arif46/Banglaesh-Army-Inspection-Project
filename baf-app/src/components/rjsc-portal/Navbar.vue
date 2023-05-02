<template>
    <div class="rjsc-title-bg">
        <div class="menu-rjsc rjsc-title-bg">
            <b-container class="menu-desktop">
                <b-navbar type="dark">
                    <span class="sidebar-button" @click="mobileSidebar"><i class="ri-menu-2-line"></i></span>
                    <b-collapse is-nav>
                        <b-navbar-nav v-if="loading">
                            <b-skeleton animation="wave" height="30px" width="700px"></b-skeleton>
                        </b-navbar-nav>
                        <b-navbar-nav v-else>
                            <b-nav-item :to="{ path: '/rjsc-portal/home' }"> {{ locale === 'bn' ? 'হোম' : 'Home' }} </b-nav-item>
                            <span v-for="(item, index) in menus" :key="index">
                                <b-nav-item :to="!item.url ? '/rjsc-portal/common-page/'+ item.id : item.url ">
                                    {{ locale === 'bn' ? item.name_bn : item.name_en }}
                                    <div class="dropdown" v-if="item.childs">
                                        <span v-for="(item1, index1) in item.childs" :key="index1">
                                            <b-nav-item :to="!item1.url ? '/rjsc-portal/common-page/'+ item1.id : item1.url ">
                                                <p>{{ locale === 'bn' ? item1.name_bn : item1.name_en }} <i class="ri-arrow-right-s-fill" v-if="item1.childs.length > 0"></i></p>
                                                <div class="sub-dropdown" v-if="item1.childs">
                                                    <span v-for="(item2, index2) in item1.childs" :key="index2">
                                                        <b-nav-item :to="!item2.url ? '/rjsc-portal/common-page/'+ item2.id : item2.url ">{{ locale === 'bn' ? item2.name_bn : item2.name_en }}</b-nav-item>
                                                    </span>
                                                </div>
                                            </b-nav-item>
                                        </span>
                                    </div>
                                </b-nav-item>
                            </span>
                        </b-navbar-nav>
                    </b-collapse>
                </b-navbar>
            </b-container>
            <!-- mobile sidebar stat -->
            <div class="sidebar" :class="{ active: isActive }">
                <div class="menu">
                    <div class="login">
                        <button class="btn btn-sm btn-light"><i class="ri-login-circle-line"></i> {{ $t('rjsc_portal.login_btn')}}</button>
                    </div>
                    <ul class="mobile-menu">
                        <li>
                            <label for="item_1">Home<i class="ri-arrow-drop-right-line"></i></label>
                            <input type="checkbox" id="item_1">
                        </li>
                        <li>
                            <label for="item_2">Business Process<i class="ri-arrow-drop-right-line"></i></label>
                            <input type="checkbox" id="item_2">
                            <ul class="dd-menu">
                                <li>
                                    <label for="dditem_1">List of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                    <input type="checkbox" id="item_dd_1">
                                </li>
                                <li>
                                    <label for="item_dd_2">No of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                    <input type="checkbox" id="item_dd_2">
                                    <ul class="dd-menu sub-dd">
                                        <li>
                                            <label for="item_sub_dd_1">List of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                            <input type="checkbox" id="item_sub_dd_1">
                                        </li>
                                        <li>
                                            <label for="item_sub_dd_2">No of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                            <input type="checkbox" id="item_sub_dd_2">
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label for="item_3">Entity Statistics<i class="ri-arrow-drop-right-line"></i></label>
                            <input type="checkbox" id="item_3">
                            <ul class="dd-menu">
                                <li>
                                    <label for="dditem_1">List of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                    <input type="checkbox" id="item_dd_1">
                                </li>
                                <li>
                                    <label for="dditem_2">No of Entity<i class="ri-arrow-drop-right-line"></i></label>
                                    <input type="checkbox" id="item_dd_2">
                                </li>
                            </ul>
                        </li>
                        <li>
                            <label for="item_4">Fee<i class="ri-arrow-drop-right-line"></i></label>
                            <input type="checkbox" id="item_4">
                        </li>
                    </ul>
                    <!-- <b-navbar-nav>
                        <b-nav-item
                            @click="clickToGo(item.url, item.page_type, item.id, 1)"
                            v-for="(item, index) in menus"
                            :key="index" :class="activeClass1 ? 'active' : ''">
                            {{ item.name_en }}
                            <div class="dropdown" v-if="item.childs">
                                <b-nav-item @click="clickToGo(item1.url, item.page_type, item1.id, 2)" v-for="(item1, index1) in item.childs" :key="index1" :class="activeClass2 ? 'active' : ''">
                                    <p>{{ item1.name_en }} <i class="ri-arrow-right-s-fill" v-if="item1.childs"></i></p>
                                    <div class="sub-dropdown" v-if="item1.childs">
                                        <b-nav-item @click="clickToGo(item2.url, item.page_type, item2.id, 3)" v-for="(item2, index2) in item1.childs" :key="index2" :class="activeClass3 ? 'active' : ''" >{{ item2.name_en }}</b-nav-item>
                                    </div>
                                </b-nav-item>
                            </div>
                        </b-nav-item> -->

                        <!-- <b-nav-item to="/rjsc-portal/home">Home</b-nav-item>
                        <b-nav-item href="#" @click="dropdownShow = !dropdownShow" :class="{ active: dropdownShow}">
                            Introductions
                            <div class="dropdown">
                                <b-nav-item to="/rjsc-portal/about">About</b-nav-item>
                                <b-nav-item to="/rjsc-portal/faq">FAQ</b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item href="#">
                            Business Process & Documents
                            <div class="dropdown">
                                <b-nav-item to="/rjsc-portal/name-clearance">Name Clearance</b-nav-item>
                                <b-nav-item to="/rjsc-portal/registration">Registration</b-nav-item>
                                <b-nav-item to="/rjsc-portal/returns">Returns Filing</b-nav-item>
                                <b-nav-item to="/rjsc-portal/winding-up">Winding Up</b-nav-item>
                                <b-nav-item to="/rjsc-portal/certified-copy">Certified Copy Issuance</b-nav-item>
                                <b-nav-item to="/rjsc-portal/struck-off">Struck Off</b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item href="#">
                            Entity Statistics
                            <div class="dropdown">
                                <b-nav-item to="/rjsc-portal/entity-list">List of Entities</b-nav-item>
                                <b-nav-item href="#">
                                    <span class="d-flex">
                                        <p>No of Entities</p> <i class="ri-arrow-right-s-fill"></i>
                                    </span>
                                    <div class="sub-dropdown">
                                        <b-nav-item to="/rjsc-portal/entity-type">Entity Type</b-nav-item>
                                        <b-nav-item to="/rjsc-portal/sector">Sector</b-nav-item>
                                        <b-nav-item to="/rjsc-portal/sub-sector">Sub-Sector</b-nav-item>
                                        <b-nav-item to="/rjsc-portal/district">District</b-nav-item>
                                    </div>
                                </b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item to="/rjsc-portal/contact-us">Contact</b-nav-item> -->
                    <!-- </b-navbar-nav> -->
                </div>
                <div class="overlay" @click="mobileSidebar" :class="{ active: isActive }"></div>
            </div>
            <!-- mobile sidebar end-->
        </div>
    </div>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'MainNav',
    data () {
        return {
            loading: false,
            isActive: false,
            active: false,
            dropdownShow: false,
            menus: []
        }
    },
    created () {
        this.getMenuList()
    },
    computed: {
        locale: function () {
            return this.$i18n.locale
        }
    },
    methods: {
        mobileSidebar () {
            this.isActive = !this.isActive
        },
        async getMenuList () {
            this.loading = true
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/menus')
            this.loading = false
            if (result.success) {
                this.menus = result.data
            } else {
                this.menus = []
            }
        }
    }
}
</script>
<style>

</style>
