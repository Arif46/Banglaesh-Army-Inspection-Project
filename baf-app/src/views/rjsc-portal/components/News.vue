<template>
    <div class="news-wrapper">
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex">
                    <i class="ri-newspaper-fill"></i>
                    <h6 class="mb-0 ml-2">News</h6>
                </div>
            </template>
            <b-list-group flush>
                <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
            </b-list-group>
        </b-card>
    </div>
</template>
<script>
export default {
    name: 'News'
}
</script>
<style>

.news-wrapper .card .card-header {
    color: var(--white);
    background: var(--rjsc-title-bg);
}
.news-wrapper .list-group-item-action:hover,
.list-group-item-action:focus {
    color: var(--rjsc-brand);
    border-left-width: 5px !important;
    border-left: 3px solid var(--rjsc-brand);
    }
</style>
