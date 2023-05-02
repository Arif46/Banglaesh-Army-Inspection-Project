<template>
    <div>
        <b-row>
            <b-col md="10" offset-md="1">
                <b-skeleton animation="wave" width="30%"></b-skeleton>
                <b-skeleton animation="wave" width="60%"></b-skeleton>
                <b-skeleton animation="wave" width="40%"></b-skeleton>
                <b-skeleton animation="wave" width="50%"></b-skeleton>
                <b-skeleton animation="wave" width="70%"></b-skeleton>
                <b-skeleton animation="wave" width="100%"></b-skeleton>
                <b-skeleton animation="wave" width="100%"></b-skeleton>
                <b-skeleton animation="wave" width="16%"></b-skeleton>
                <b-skeleton-table
                :rows="5"
                :columns="4"
                :table-props="{ bordered: true, striped: true }"
                ></b-skeleton-table>
                <b-skeleton animation="wave" height="30px"></b-skeleton>
                <b-skeleton-table
                :rows="3"
                :columns="4"
                :table-props="{ bordered: true, striped: true }"
                ></b-skeleton-table>
                <b-skeleton animation="wave" height="30px"></b-skeleton>
                <b-skeleton-table
                :rows="3"
                :columns="4"
                :table-props="{ bordered: true, striped: true }"
                ></b-skeleton-table>
                <b-skeleton animation="wave" height="30px"></b-skeleton>
                <b-skeleton-table
                :rows="3"
                :columns="4"
                :table-props="{ bordered: true, striped: true }"
                ></b-skeleton-table>
            </b-col>
        </b-row>
    </div>
</template>
