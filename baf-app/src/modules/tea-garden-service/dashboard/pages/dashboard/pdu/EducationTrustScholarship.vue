<template>
    <div class="section-wrapper bfti-dashboard-wrapper">
        <breadcumb />
        <div class="form-wrapper edu-trust-schol-wrapper">
            <b-card title="Education Trust Scholarship">
                <b-card-text style="padding: 2rem 2rem 1rem;">
                    <b-row>
                        <b-col sm="4">
                            <div class="filter-wrapper">
                                <b-form-group label="Scholarship Type:" class="mb-0" v-slot="{ ariaDescribedby }">
                                    <b-form-radio-group v-model="selected" :options="options" value-field="item" text-field="name"
                                        disabled-field="notEnabled" :aria-describedby="ariaDescribedby" name="radio-inline"></b-form-radio-group>
                                </b-form-group>
                            </div>
                        </b-col>
                        <b-col sm="8">
                            <b-row>
                                <b-col sm="6">
                                    <div class="card-item-squ-col">
                                        <div class="card-item-squ">
                                            <div class="card-top schools">
                                                <i class="ri-building-fill"></i>
                                                <p>No of Schools</p>
                                            </div>
                                            <div class="card-bottom">
                                                <h3>350</h3>
                                            </div>
                                        </div>
                                    </div>
                                </b-col>
                                <b-col sm="6">
                                    <div class="card-item-squ-col">
                                        <div class="card-item-squ">
                                            <div class="card-top students">
                                                <i class="ri-user-star-fill"></i>
                                                <p>No of Students</p>
                                            </div>
                                            <div class="card-bottom">
                                                <h3>104395</h3>
                                            </div>
                                        </div>
                                    </div>
                                </b-col>
                            </b-row>
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
            selected: 'A',
            options: [
                { item: 'Primary', name: 'Primary' },
                { item: 'Secondary', name: 'Secondary' }
            ]
        }
    }
}
</script>
