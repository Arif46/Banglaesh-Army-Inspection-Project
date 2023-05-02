<template>
    <div class="portal">
        <b-card>
            <template #header>
                <div class="d-flex card-title-wrapper">
                    <h6 class="mb-0 ml-2">Importent Links</h6>
                </div>
            </template>
            <div class="organization-links">
                <b-tabs justified>
                    <b-tab title="Org. Links" active>
                        <b-list-group>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Ministry of Commerce</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Bangladesh Trade and Tariff Commission</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Export Promotion Bureau</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Trading Corporation of Bangladesh</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Directorate Of National Consumer Rights Protection</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Registrar of Joint Stock Companies and Firms</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Bangladesh Tea Board</p>
                            </b-list-group-item>
                        </b-list-group>
                    </b-tab>
                    <b-tab title="Useful Link">
                        <b-list-group>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Export Promotion Bureau</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Trading Corporation of Bangladesh</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Directorate Of National Consumer Rights Protection</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Registrar of Joint Stock Companies and Firms</p>
                            </b-list-group-item>
                            <b-list-group-item href="#" class="d-flex justify-content-start align-items-center">
                                <img src="../../../assets/images/logo.png" width="20" class="mr-2" alt="">
                                <p>Bangladesh Tea Board</p>
                            </b-list-group-item>
                        </b-list-group>
                    </b-tab>
                </b-tabs>
            </div>
        </b-card>
    </div>
</template>
<script>
export default {
    name: 'OrganizationLinks'
}
</script>
<style>
.organization-links::-webkit-scrollbar{
    width: 3px;
}
.organization-links{
    height: 400px;
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
