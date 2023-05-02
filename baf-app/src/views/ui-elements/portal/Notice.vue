<template>
    <div class="portal notice-wrapper">
        <b-card text-variant="dark" header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">Notice List</h6>
                    </div>
                    <a href="javascript:" class="pr-3 portal-text">See More <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <div class="notice-list">
                <b-list-group class="notice-title">
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">The first prizes received by BADC</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>

                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                    <b-list-group-item href="#" class="flex-column align-items-start">
                        <div>
                            <h5 class="mb-1">List Group item heading</h5>
                        </div>

                        <p class="mb-1">
                            Donec id elit non mi porta gravida at eget metus.
                        </p>
                    </b-list-group-item>
                </b-list-group>
            </div>
        </b-card>
    </div>
</template>
<script>
export default {
    name: 'Notice'
}
</script>
<style>
.notice-list::-webkit-scrollbar{
    width: 3px;
}
.notice-wrapper .card .card-body{
    padding: 5px;
}
.notice-list{
    height: 350px;
    overflow-y: auto;
    margin-bottom: 8px;
}
.notice-list .list-group-item{
    border: none;
    border-bottom: 1px solid #bbb;
}
.notice-list .list-group-item p {
    font-size: 0.8rem;
}
.notice-list .list-group-item:hover{
    color: #fff;
    background-color: var(--portal-secondary);
}
.notice-list .list-group-item:hover h5{
    color: #fff;
}
.portal .notice-title h5{
    color: var(--portal-brand);
    font-size: 15px;
    white-space: nowrap;
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: .5s all;
    }
</style>
