<template>
    <div style="background-color: var(--white);">
        <b-container>
            <div class="page-title">
                <slot></slot>
                <h5>{{ title }}</h5>
            </div>
        </b-container>
    </div>
</template>
<script>
    export default {
        name: 'BreadCumb',
        props: ['title']
    }
</script>
