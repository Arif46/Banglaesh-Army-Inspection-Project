<template>
    <b-overlay :show="loading">
        <main id="laws">
            <div class="laws-body">
                <div class="laws">
                    <ul>
                        <li class="d-flex justify-content-between align-items-center law-item" v-for="(item, index) in data" :key="index">
                            <div class="d-flex align-items-center">
                                <a href="#">{{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}</a>
                            </div>
                            <div class="law-btn">
                                <a title="Download Notice" class="btn law-btn mr-2" target="_blank" :href="rjscServiceBaseUrl + '' + item.attachment">
                                    <i class="ri-download-2-fill"></i>
                                </a>
                            </div>
                        </li>
                        <b-pagination
                            align="center"
                            class="rjsc-pagi"
                            v-model="pagination.currentPage"
                            :per-page="pagination.perPage"
                            :total-rows="pagination.totalRows"
                            @input="searchData">
                        </b-pagination>
                    </ul>
                </div>
            </div>
        </main>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'rjscLaws',
    data () {
        return {
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            data: [],
            search: {
                limit: 10
            },
            pagination: {
                currentPage: 1,
                totalRows: 0,
                perPage: 10,
                slOffset: 1
            }
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        searchData () {
            this.loadData()
        },
        paginationData (data, limit) {
            this.pagination.perPage = limit
            this.pagination.currentPage = data.current_page
            this.pagination.totalRows = data.total
            this.pagination.slOffset = parseInt(this.pagination.perPage) * this.pagination.currentPage - parseInt(this.pagination.perPage) + 1
        },
        async loadData () {
            this.loading = true
            const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/law-list', params)
            if (result.success) {
                this.data = result.data.data
                this.paginationData(result.data, this.search.limit)
            } else {
                this.data = []
                this.paginationData([])
            }
            this.loading = false
        }
    }
}
</script>
<style>
.laws-body .laws {
    display: flex;
    height: auto;
}

.laws-body .laws ul {
    width: 100%;
}

.laws-body .laws ul li.law-item {
    padding: 0.2rem;
    margin-bottom: 1rem;
    border-top: 2px solid;
    background-color: #fff;
    box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}
.laws-body .laws ul li.law-item:nth-child(even){
    border-color: #32AF2D;
}
.laws-body .laws ul li.law-item:nth-child(odd){
    border-color: #056CE5;
}
.laws-body .laws .law-btn{
    transition: all .3s linear;
    display: flex;
}
.laws-body .laws .law-btn a{
    font-weight: 600;
    font-size: 1.1rem;
}
.laws-body .laws ul li.law-item:nth-child(even) .law-btn a{
    color: #32AF2D;
}
.laws-body .laws ul li.law-item:nth-child(odd) .law-btn a{
    color: #056CE5;
}
.laws-body .laws .law-sl{
    color: #fff;
    padding: .2rem;
    width: 35px;
    height: 35px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 35px;
}
.laws-body .laws ul li.law-item:nth-child(even) .law-sl{
    background-color: #32AF2D;
}

.laws-body .laws ul li.law-item:nth-child(odd) .law-sl{
    background-color: #056CE5;
}
.laws-body .laws ul li.law-item:last-child {
    margin-bottom: 0;
}

.laws-body .laws ul li.law-item a {
    display: block;
    font-size: .9rem;
    color: var(--dark);
    padding: .5rem;
}
</style>
