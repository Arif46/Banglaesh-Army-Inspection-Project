<template>
    <div class="section-wrapper bfti-dashboard-wrapper">
        <breadcumb />
        <div class="form-wrapper edu-trust-schol-wrapper">
            <b-card title="Regular Garden Inspection">
                <b-card-text style="padding: 2rem 2rem 1rem;">
                    <b-row class="justify-content-center">
                        <b-col sm="4">
                            <div class="card-item-squ-col">
                                <div class="card-item-squ">
                                    <div class="card-top schools">
                                        <i class="ri-road-map-fill"></i>
                                        <p>Total Garden Visited</p>
                                    </div>
                                    <div class="card-bottom">
                                        <h3>350</h3>
                                    </div>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="4">
                            <div class="card-item-squ-col">
                                <div class="card-item-squ">
                                    <div class="card-top pending">
                                        <i class="ri-compass-4-fill"></i>
                                        <p>Garden Visited Pending</p>
                                    </div>
                                    <div class="card-bottom">
                                        <h3>104395</h3>
                                    </div>
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                </b-card-text>
            </b-card>
        </div>
    </div>
</template>
<script>
export default {
    data () {
        return {
            form: {
                email: '',
                name: '',
                course: null,
                year: null
            },
            course: [{ text: 'Select course', value: null }, 'Carrots', 'Beans', 'Tomatoes', 'Corn'],
            year: [{ text: 'Select year', value: null }, '2022', '2021', '2020', '2019', '2018'],
            value: '',
            file1: null,
            valueNumber: 50
        }
    }
}
</script>
