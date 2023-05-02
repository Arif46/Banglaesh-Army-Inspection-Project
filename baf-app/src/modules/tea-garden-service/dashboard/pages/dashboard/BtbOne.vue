<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper fertilizer-distribution">
            <b-card class="total-gardens">
                <b-card-text>
                    <b-row no-gutters>
                        <b-col sm="6">
                            <div class="total-garden-card">
                                <i class="ri-seedling-fill"></i>
                                <div class="content">
                                    <p>{{ $t('teaGardenDashboard.total_gandens') }}</p>
                                    <h3>{{ $n(masterTeaGardenGenInfoList.length) }}</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="6">
                            <img src="../../../../../assets/images/tea_gardens.jpg" class="img-fluid" alt="">
                        </b-col>
                    </b-row>
                </b-card-text>
            </b-card>
            <b-card title="Fartilizer Distribution">
                <b-card-text class="mb-3">
                    <b-row>
                        <b-col sm="4">
                            <div class="info-card submitted">
                                <div class="icon">
                                    <i class="ri-folder-received-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Total Indent Submitted</p>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="4">
                            <div class="info-card approved">
                                <div class="icon">
                                    <i class="ri-checkbox-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Approved Indent</p>
                                    <h3>107</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="4">
                            <div class="info-card pending">
                                <div class="icon">
                                    <i class="ri-time-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Pending Indent</p>
                                    <h3>07</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="4">
                            <div class="info-card requested-far">
                                <div class="icon">
                                    <i class="ri-share-circle-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Requested Fartilizer Qty</p>
                                    <h3>1672 M.Ton</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="4">
                            <div class="info-card approved-far">
                                <div class="icon">
                                    <i class="ri-shield-check-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Approved Fartilizer Qty</p>
                                    <h3>800 M. Ton</h3>
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                </b-card-text>
            </b-card>
            <b-card>
                <b-card-text>
                    <img src="../../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
                </b-card-text>
            </b-card>
        </div>
    </div>
</template>
<script>
export default {
    data () {
        return {
            //
        }
    },
    computed: {
        masterTeaGardenGenInfoList () {
            return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
        }
    }
}
</script>

<style>
/* all style of this page is --> tea-garden-service/configuration/css/tgdb.css */
</style>
